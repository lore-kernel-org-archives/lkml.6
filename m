Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425953AbeCBJsm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:48:42 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:55277 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424764AbeCBJsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:48:14 -0500
From: Baruch Siach <baruch@tkos.co.il>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Baruch Siach <baruch@tkos.co.il>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] gpio: raspberrypi-exp: explain Kconfig dependency
Date: Fri,  2 Mar 2018 11:47:01 +0200
Message-Id: <3c3b8755d186b1f762081ee18efb718886814e51.1519984021.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7ed915059c3001 (gpio: raspberrypi-ext: fix firmware dependency)
fixed the Kconfig dependency to ensure that gpio-raspberrypi-exp is not
built-in when the firmware is a module. But the Kconfig syntax for doing
so is cryptic. Add a comment to make it a little easier.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/gpio/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 52a8b0a6f4e1..1bb25c1ff2d8 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -126,6 +126,8 @@ config GPIO_RASPBERRYPI_EXP
 	tristate "Raspberry Pi 3 GPIO Expander"
 	default RASPBERRYPI_FIRMWARE
 	depends on OF_GPIO
+	# Make sure not 'y' when RASPBERRYPI_FIRMWARE is 'm'. This can only
+	# happen when COMPILE_TEST=y, hence the added !RASPBERRYPI_FIRMWARE.
 	depends on (ARCH_BCM2835 && RASPBERRYPI_FIRMWARE) || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
 	help
 	  Turn on GPIO support for the expander on Raspberry Pi 3 boards, using
-- 
2.16.1
