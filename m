Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966723AbeEYPjO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:39:14 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:60239 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965666AbeEYPjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:39:13 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
        ShuFan Lee <shufan_lee@richtek.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: typec: rt1711h: fix tcpci dependency
Date: Fri, 25 May 2018 17:38:25 +0200
Message-Id: <20180525153841.3314617-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:JyBxk+i1NTWhhYTMwJeXtWJaJb+2lC3VUjl6qu207JrB5lK/vYs
 SU6XpL9gRE8B/Sd1Yt3AWxdBVfGMWCqOGmb6jngyRl5TTV1Ac2180M5/cU3vIC833WNFZKw
 JHN6ujP465B9JtLPn5CkVAqb2MaiXogfS+WBn8rlMk0AwKGAzJ6H+gJsTGutQxkjDfBYvxg
 H8EiYQINxeic9OyYsjADQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0pJQhiWXEtg=:TWkPv5u5J1+xjfJeUnpUtm
 G8//N09rsIsl43XodNJuLf4pfnDjC4nEMC5yfdhqM7FxBW6/bBSeC5nNscWapxFUjtSJYwBDj
 5SCem51NWhuUOb0GTBSB3lhfCGGSp6N7JG/NmyaX+PY+x9uI7IU4Fgjgowu5maI6+aatxMY+U
 Q2IkRQj6Kbz+x+zNr0pP1uamGLX63MW1CAUQDK4A6Pr56dTTkDO3dYuIubrBs98SXtfENyIOL
 kvUqzOobDcTt8QQRleABUX1BiIMLWfnaQHo2ex7Fi/BmlKsfOXyllTc5rzSVvpJX/vJd2rsnO
 O+giYUjMDXWzYlBuXjHYqTivircWa6HL+scGBsF+eNTdVYxm9gLCaMPyslsDa/7qw7/0S77XZ
 IFiI3EcI7SX286N6UMIht19ZuRjkZF4BFWPKU5iNr1SNvS7exae7ujQHGb3flYNFL9S1zDFV7
 DpeOY2i3npzcR13Hv5aJ/eXuMpHJsz1i8aHE9zbiJVrWR2ILaPf+tT5OyDLupOy/9be5nwAl8
 ys32ihEoiMu6TvYRiBbWwm0PUcZjAY4UUkJ6gQxW1WwBz7MJhw0mWVgzjlmml15D0ME3oauAW
 mwgrpngf291aGI2vqjIpX7UssAtgSUCzY3PzcUq6q4TIKo9AevVz+eaadf3uzHZK6whry/gtv
 ZaTrzog6RMrbE1TOYhKXXMwPNtjSYmpwn9uXjzriRgVSCu81CqChh39BwZrBgrYg7JeA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using 'select' instead of the normal 'depends on' causes
a build issue with CONFIG_I2C=m:

WARNING: unmet direct dependencies detected for TYPEC_TCPCI
  Depends on [m]: STAGING [=y] && TYPEC_TCPM [=y] && I2C [=m]
  Selected by [y]:
  - TYPEC_RT1711H [=y] && STAGING [=y] && TYPEC_TCPM [=y]

Fixes: ce08eaeb6388 ("staging: typec: rt1711h typec chip driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/typec/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/typec/Kconfig b/drivers/staging/typec/Kconfig
index 3aa981fbc8f5..51474d798f99 100644
--- a/drivers/staging/typec/Kconfig
+++ b/drivers/staging/typec/Kconfig
@@ -11,7 +11,7 @@ config TYPEC_TCPCI
 
 config TYPEC_RT1711H
 	tristate "Richtek RT1711H Type-C chip driver"
-	select TYPEC_TCPCI
+	depends on TYPEC_TCPCI
 	help
 	  Richtek RT1711H Type-C chip driver that works with
 	  Type-C Port Controller Manager to provide USB PD and USB
-- 
2.9.0
