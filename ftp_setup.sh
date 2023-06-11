#!/bin/bash

# 安装FTP服务
sudo apt-get update
sudo apt-get install vsftpd

# 修改配置文件
sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.orig
sudo sed -i 's/#write_enable=YES/write_enable=YES/' /etc/vsftpd.conf
sudo sed -i 's/#local_umask=022/local_umask=022/' /etc/vsftpd.conf
sudo sed -i 's/#chroot_local_user=YES/chroot_local_user=YES/' /etc/vsftpd.conf
sudo sed -i 's/#allow_writeable_chroot=YES/allow_writeable_chroot=YES/' /etc/vsftpd.conf
sudo sed -i '$a\user_sub_token=$USER' /etc/vsftpd.conf
sudo sed -i '$a\local_root=/home/$USER/ftp' /etc/vsftpd.conf
sudo ufw allow 20/tcp
sudo ufw allow 21/tcp
sudo ufw allow 990/tcp
sudo ufw allow 40000:50000/tcp
sudo systemctl enable vsftpd
sudo systemctl restart vsftpd

# 创建FTP用户
echo "请输入新用户的用户名："
read username
sudo useradd -m -s /bin/bash $username
echo "请输入新用户的密码："
sudo passwd $username
sudo chown root:root /home/$username
sudo chmod go-w /home/$username
sudo mkdir /home/$username/ftp
sudo chown $username:$username /home/$username/ftp

