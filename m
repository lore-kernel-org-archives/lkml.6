Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779F3C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA45520779
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiCyO28N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA45520779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeI2Hga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 03:36:30 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34835 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeI2Hga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 03:36:30 -0400
Received: by mail-yw1-f66.google.com with SMTP id y76-v6so3415248ywd.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 18:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=m5SixqPrDfkx1SbmhW98nkdLNVMVeQ9qW5LOANaYpQ8=;
        b=CiCyO28NNdEqpD1FyYhIJD5ArYVg3UpQtA8XJX+0EXNwA/e1UE6Ek5qz9MPgRCFY67
         0xWDc9fNdRhbBMkbhAuKccKu+ZY1Jwi7uSBnnYLIMc/26XJZI9IW6U8zqiwCt+b29j/X
         fLNOo25SnByyHbeTUQKSLwUhAr3yZAigpkqhhXDjy51ASy7t72gazKFrQoOAeBmrF5Sa
         DWFyKa1P+vK0nknPOgGbpHUsR7YTKvB55ZVZfqOF1sM5fgtfxWbnkdazmot+G/osFYct
         FNStwoqnnhb/DOXRtWwm7ZofpSsNFb2KqU8B2JCRTqZssPmh219k2WRl8Mn3nvZX39Zb
         JZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=m5SixqPrDfkx1SbmhW98nkdLNVMVeQ9qW5LOANaYpQ8=;
        b=SKYrfTmgJp2StxjSbjj4aqHgneGTbu4mtCmv4W5Mp7EodypBltI6hKKu8JY8A5p5p/
         zkwrs5vRUr/nU23bjfj/a82XiS2wbNvRlxjfb/slmzxQhAYf7L58wtOcQQzBEDtIot5D
         4GUjpM4fydB1Kq5x9vodKKBLJLLr6w0VgBnX2slo9sHeJDVEETs/PhJ7yclXTSiVFIRu
         4AoLobAVgeV8LjcIaRU32L1tVTNiTjuzgpcFRFQwc3zgF6Efzy89qBD93Z54UXgR6Wx3
         TSHtQYJM2hTKk6G4dHBMpi73FrTgSp4PgQagPuIMXyKQwjyMNisbX6Z0RLhdz9zLF5Yb
         V+OQ==
X-Gm-Message-State: ABuFfohXkJBkza8ghkgaYH8iH3aE628huprOAhqKG2hTB8ECpmBI/PBi
        L1XLbn0CuHG5QPldsUtGTyl+6F5ZS5B0JU405lG+Sn4=
X-Google-Smtp-Source: ACcGV60kO61UEdp0y9bIofCjdK79+/KbStlGHPx7FW6n7657YJi6FlJKGH6EMpry/IzbKB69g44zIv50eG8DsuXlDSY=
X-Received: by 2002:a0d:ed47:: with SMTP id w68-v6mr603459ywe.479.1538183407929;
 Fri, 28 Sep 2018 18:10:07 -0700 (PDT)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Date:   Sat, 29 Sep 2018 09:06:35 +0800
Message-ID: <CANnei0EOqnPufT_NighvuRHh-Ztx0kePnSeRE49+9Rq_1fjMwQ@mail.gmail.com>
Subject: Step-by-Step Tutorial: How to Setup Your Own e-Commerce Online Store
 using WooCommerce 3.4.5, Wordpress 4.9.8, and CentOS 1805 (LAMP) in Amazon
 AWS Cloud
To:     linux-kernel@vger.kernel.org
Cc:     Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Step-by-Step Tutorial: How to Setup Your Own e-Commerce Online Store
using WooCommerce 3.4.5, Wordpress 4.9.8, and CentOS 1805 (LAMP) in
Amazon AWS Cloud

Author: Mr. Turritopsis Dohrnii Teo En Ming
Country: Singapore
Date: 28th September 2018 Friday

Document Version: 1809.01

Abbreviations
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

LAMP: Linux + Apache Web Server + MySQL/MariaDB + PHP

WAMP: Windows + Apache Web Server + MySQL/MariaDB + PHP

SECTION 1 CREATING YOUR CENTOS 7.5 (1805) LINUX INSTANCE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

001. Login to Amazon Web Services.

002. Click Services > Compute > EC2.

003. Click Network & Security > Key Pairs

004. Click Create Key Pair.

005. Enter your key pair name. Then click Create.

006. Be sure to download your private key in the form of a .PEM file.
You will need to convert it to a .PPK file later.

007. Click Instances > Instances.

008. Click Launch Instance.

009. Click AWS Marketplace.

010. Search for CentOS.

011. Select CentOS 7 (x86_64) - with Updates HVM Amazon Machine Image (AMI)=
.

012. Click Continue.

013. Select General Purpose, t2.micro, 1 vCPU, 1 GB RAM (FREE TIER ELIGIBLE=
).

014. Click Next: Configure Instance Details.

015. Select Network: <Your VPC network>

016. Select Subnet: <Your subnet>

017. Click Protect against accidental termination.

018. Click Next: Add Storage.

019. Click Next: Add Tags. Click Add tag.

020. Enter Key =3D Name and Value =3D Online Store.

021. Click Next: Configure Security Group

022. Click Select an existing security group.

023. Select VS_SG (Virtual Server Security Group).

024. Click Review and Launch. Click Launch.

025. Select a key pair. Click Launch Instances.

026. Click View Instances.

027. Click Network & Security > Elastic IPs.

028. Select an unused IPv4 address.

029. Click Actions > Associate address.

030. Select the Online Store instance.

031. Click Allow Elastic IP to be reassociated if already attached.

032. Click Associate. Click Close.

033. Login to CentOS 7.5 Linux using Putty.

SECTION 2 INSTALLING WORDPRESS 4.9.8
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

034. sudo yum install php php-mysql php-devel php-gd php-pecl-memcache
php-pspell php-snmp php-xmlrpc php-xml

Guide: How To Install MySQL / MariaDB on CentOS 7

Link: https://www.liquidweb.com/kb/how-to-install-mysql-mariadb-on-centos-7=
/

035. sudo yum -y install mariadb-server mariadb

036. sudo yum install wget

Guide: Installing WordPress: Detailed Instructions

Link: https://codex.wordpress.org/Installing_WordPress#Detailed_Instruction=
s

037. wget https://wordpress.org/latest.tar.gz

038. tar xfvz latest.tar.gz

039. sudo passwd root

040. su -

041. systemctl start mariadb

042. systemctl enable mariadb

043. mysql

044. MariaDB [(none)]> CREATE DATABASE wordpress;

045. MariaDB [(none)]> GRANT ALL PRIVILEGES ON wordpress.* TO
"wordpress"@"localhost" IDENTIFIED BY "password";

046. MariaDB [(none)]> FLUSH PRIVILEGES;

047. MariaDB [(none)]> EXIT

048. cd /home/centos/wordpress

AFAIK Wordpress 4.9.8 cannot be installed in a subdirectory. If you
encounter a HTTP error code 500 doing so, be sure to check the Apache
Web Server error logs, that is, tail -f /var/log/httpd/error_log.

049. cp -R * /var/www/html

050. systemctl start httpd

051. systemctl enable httpd

052. sudo yum install nano

053. nano /etc/httpd/conf/httpd.conf

054. Append the following line

AddType application/x-httpd-php .php

055. systemctl restart httpd

Wordpress 4.9.8's PHP code won't execute on php-5.4.16, which is
installed by default on CentOS 7.5. It will return a HTTP error code
of 500. Install PHP-7.2.10 instead.

Guide: How to Install PHP 7 in CentOS 7

Link: https://www.tecmint.com/install-php-7-in-centos-7/

056. yum install
https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

057. yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm

058. yum install yum-utils

You will need minimum PHP 7.2.

059. yum-config-manager --enable remi-php72

060. yum install php php-mcrypt php-cli php-gd php-curl php-mysql
php-ldap php-zip php-fileinfo

061. php -v

PHP 7.2.10 is now installed.

062. systemctl stop httpd && systemctl start httpd

063. Go to http://<IP_address_of_eCommerce_Online_Store>

064. Click Let's go!

065. Fill in the following MySQL/MariaDB database connection information.

Database Name: wordpress

Username: wordpress

Password: password

Database Host: localhost

Table Prefix: wp_

066. Click Submit.

067. cd /var/www/html

068. nano wp-config.php

069. Copy and paste the contents of wp-config.php shown on the
Wordpress installation screen on your browser.

070. Click Run the installation.

071. Fill in the following information.

Site Title: Teo En Ming Corporation Online Store

Username: admin

Password: password

Your email: user@example.com

Uncheck Discourage search engines from indexing this site

072. Click Install wordpress.

073. Click Login.

SECTION 3 INSTALLING WOOCOMMERCE 3.4.5
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Follow the WooCommerce installation guide here:

https://docs.woocommerce.com/document/installing-uninstalling-woocommerce/

074. Login to your new wordpress site.

075. Click Plugins > Add new.

076. Search for WooCommerce.

077. Click Install Now on WooCommerce by Automattic.

Installing FTP Server in CentOS 7.5.

Guide: How to Install and Configure vsftpd on CentOS 7

Link: https://www.liquidweb.com/kb/how-to-install-and-configure-vsftpd-on-c=
entos-7/

078. sudo yum -y install vsftpd

079. sudo nano /etc/vsftpd/vsftpd.conf

anonymous_enable=3DNO
local_enable=3DYES
write_enable=3DYES
chroot_local_user=3DYES

080. sudo systemctl restart vsftpd

081. sudo systemctl enable vsftpd

082. sudo passwd centos

Change National Security Agency (NSA)=E2=80=99s SELinux mode.

083. sudo nano /etc/selinux/config

SELINUX=3Dpermissive

084. reboot

085. su -

086. echo 'allow_writeable_chroot=3DYES' >> /etc/vsftpd/vsftpd.conf

087. systemctl restart vsftpd

088. Go back to WooCommerce installation page on your browser.

089. Fill in the Connection Information.

Hostname: <IP address of e-Commerce Online Store>

FTP Username: ftpuser

FTP Password: password

Connection type: FTP

090. Click Proceed.

Installation failed: Unable to locate WordPress content directory (wp-conte=
nt).

To resolve this issue, see
https://wordpress.stackexchange.com/questions/206022/unable-to-locate-wordp=
ress-content-directory-wp-content

091. cd /var/www/html








092. nano wp-config.php

Append the following lines

if(is_admin()) {
   add_filter('filesystem_method', create_function('$a', 'return "direct";'=
 ));
   define( 'FS_CHMOD_DIR', 0751 );
}

093. Go back to WooCommerce installation page.

094. Fill in the Connection Information.

Hostname: <IP address of e-Commerce Online Store>

FTP Username: ftpuser

FTP Password: password

Connection type: FTP

095. Click Proceed.

WooCommerce will be installed.

096. Click Activate.

097. Click Run the Setup Wizard.

098. WooCommerce Store setup page:

Where is your store based? Singapore

Address: Singapore

City: Singapore

Postcode/ZIP: 123456

What currency do you accept payments in? Singapore dollar ($ / SGD)
What type of products do you plan to sell? I plan to sell both
physical and digital products

Check I will also be selling products or services in person.

Check Help WooCommerce improve with usage tracking.

099. Click Let's go!

100. WooCommerce Payment page:

Stripe: Enabled

Click Create a new Stripe account for me

Paypal: Enabled

Click Accept payments without linking a PayPal account

Expand Offline Payments.

Check Payments: Enabled

Bank transfer (BACS) payments: Enabled

Cash on delivery: Enabled

101. Click Continue.

102. WooCommerce Shipping page:

Shipping Zone

Singapore: Flat Rate

Cost: $5

Locations not covered by your other zones: Flat Rate

Cost: $5

Weight unit: kg

Dimension unit: cm

103. Click Continue.

104. Recommended for All WooCommerce Stores page:

Storefront Theme: Enabled

MailChimp: Enabled

105. Click Continue.

106. Click Continue with Jetpack.

107. Create an account to set up Jetpack

Your email address: user@example.com

Choose a username: jetpackuser

Choose a password: password

108. WooCommerce Ready! page:

109. Click Create a Product

SECTION 4 INSTALLING MOD_SSL TO SERVE SECURE WEB PAGES
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

110. sudo yum -y install mod_ssl

110. sudo systemctl restart httpd

SSL is now available.

111. Go to https://<IP_address_of_eCommerce_Online_Store>/wp-admin and logi=
n.

112. On the Dashboard, click Let's go!

113. Click Publish.

114. Setup is complete.

SECTION 5 CREATING DNS HOST RECORD
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

SECTION 5.1 CPANEL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

115. Login to your cpanel.

116. Click DNS Functions > Edit DNS Zone.

117. Choose a zone to edit. Click Edit.

118. On the Add New Entries Below this Line section, fill in the
following information:

store.example.com.

Select A record

IPv4 address: <IP address of e-Commerce Online Store>

119. Click Save.

120. Repeat Steps 116 to 119 for other DNS Zones.

121. Click DNS Functions > Synchronize DNS Records

122. Select Synchronize all zones to all servers

123. Click Synchronize.

Error: DNS Records failed to synchronize! I will need to investigate
further why the cPanel virtual server failed to synchronize DNS
records with the 2 name servers.

SECTION 5.2 WINDOWS SERVER 2019 ACTIVE DIRECTORY DNS SERVER
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

115. Login to your Windows Server 2019 Domain Controller.

116. Under Server Manager, click Tools > DNS.

117. Click Forward Lookup Zones > EXAMPLE.COM

118. Right click, select New Host (A or AAAA)...

Name (uses parent domain name if blank):

store

Fully qualified domain name (FQDN):

EXAMPLE.COM

IP address: <IP address of e-Commerce Online Store>

119. Click Add Host. Click Done.

120. Right Click, select Reload. Click Yes.

SECTION 6 WORDPRESS Address Settings
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

6.1 Go to https://store.example.com/wp-admin and login.

6.2 Click Settings > General Settings.

WordPress Address (URL): https://store.example.com

Site Address (URL): https://store.example.com

6.3 Click Save Changes




SECTION 7 Purchase and Install SSL Certificate
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

7.1 Please remember to purchase and install SSL certificate in your
Apache web server! There are free 90-day SSL certificates available.

All done!

I have just completed setting up my Teo En Ming Corporation Online
Store. Have you done yours?

If all of these sound too technical and complicated for you, I may be
able to help you in setting up your very own e-Commerce Online Store!

=3D=3D=3DBEGIN SIGNATURE=3D=3D=3D

Turritopsis Dohrnii Teo En Ming's Academic Qualifications as at 30 Oct 2017

[1] https://tdtemcerts.wordpress.com/

[2] http://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

=3D=3D=3DEND SIGNATURE=3D=3D=3D
