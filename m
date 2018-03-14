Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeCNPu1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:50:27 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:40047 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbeCNPuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:50:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org
Subject: [PATCH 35/47] i2c: remove bfin-twi driver
Date: Wed, 14 Mar 2018 16:35:48 +0100
Message-Id: <20180314153603.3127932-36-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:lcBmtt5hXFLAhXiblCWJeSeLeiAXsaMa7v7U6FdWuwTlnVbZB8k
 EbDObOuKdq/ezxZuhZmhlb+wKFiJCb9k0dEXjEX7XuCzWvhP7/VTyJrsY33c0ev0TgYbJ6p
 OJc9PT+pjxh71cuqGNaXibcMVqyTsnjziudP4mHT4upmcSitaNIfOEP0jLEKZMqaGOpHqmJ
 iwtQI8CW+5gQAlHTxc2KA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T6Tn5BFgK10=:XUFq/ceFcA+PyjofqYkSCt
 d8W8RIekQfQlFvljl3ort9yEzIYsRIw9eMpGxVv0Wc3dGnIW/LDv1Nv5h3Q90Ou2OjF9w1ASH
 Ntj/Cv8WxlwuBGgPuOlA1mQ6Mkyw2AxcC3WSc78tq8teSjB6u24DFPlYrHvIzdqQNKkRc5iDw
 +D94YqdMduTtFWamO8Ml3C5a7Q0AeSIab9yUjHMxbXJoH3xgggIoReb6XoGcbAB7QvrI0s1YO
 PBNMQK4SE5AB9KyDAMlTW+rOfNmcNBKsWLxwurDP3HSSn3hzyRSxaS9mqpLed5QXhmLTkpnKb
 OhYiei//EF4ps+6/fnZWTSc8fvh23QzqrAFLFwM+KD3jarWjLDKyPDvNLFahTIekCDtfJ2xnr
 HGsCe5fBQ/KbaSQTHA30s7GB9dbb/kMKgRrtlrCJRJUd/PgFcqHyKSF/Y8O3qevnHo/pweisO
 9S4jUPFCGr9/ruyBc9eFeNMy1ebdBLmgCSakJHJhRAWxBoSrQwUwIrpDUlIBDJ9/QEBiwpHNl
 NINOzPEK3ykepuNqxdC6+/huVEIWZ7yiJZP5UW1RmJ282dCwjmGR/VHzCqOq9PanMhRBR0QSA
 xm060w7lSwo0+X02Wp03iFabq03K7DQOijfjs2yKT3Fb5YMkT3KOEh68Vg/qJbrKZZ+RpgByx
 +eerd8cf3hCl94yaQ4rn7X48Du9+Qh3AtBk0OOg7vfVsA2yw0mN2JSBd6+copbY0MVY3THZFz
 k4Gy/62jY0nIFms5UVnwSkNOA5Zp66zDOgVS+g==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blackfin architecture is getting removed, so the
twi driver can also be removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/i2c/busses/Kconfig        |  18 -
 drivers/i2c/busses/Makefile       |   1 -
 drivers/i2c/busses/i2c-bfin-twi.c | 737 --------------------------------------
 3 files changed, 756 deletions(-)
 delete mode 100644 drivers/i2c/busses/i2c-bfin-twi.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 68ceac7617ff..4c0895165727 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -445,24 +445,6 @@ config I2C_BRCMSTB
 
 	  If you do not need I2C interface, say N.
 
-config I2C_BLACKFIN_TWI
-	tristate "Blackfin TWI I2C support"
-	depends on BLACKFIN
-	depends on !BF561 && !BF531 && !BF532 && !BF533
-	help
-	  This is the I2C bus driver for Blackfin on-chip TWI interface.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-bfin-twi.
-
-config I2C_BLACKFIN_TWI_CLK_KHZ
-	int "Blackfin TWI I2C clock (kHz)"
-	depends on I2C_BLACKFIN_TWI
-	range 21 400
-	default 50
-	help
-	  The unit of the TWI clock is kHz.
-
 config I2C_CADENCE
 	tristate "Cadence I2C Controller"
 	depends on ARCH_ZYNQ || ARM64 || XTENSA
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 2ce8576540a2..9e475a54e36e 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -38,7 +38,6 @@ obj-$(CONFIG_I2C_AU1550)	+= i2c-au1550.o
 obj-$(CONFIG_I2C_AXXIA)		+= i2c-axxia.o
 obj-$(CONFIG_I2C_BCM2835)	+= i2c-bcm2835.o
 obj-$(CONFIG_I2C_BCM_IPROC)	+= i2c-bcm-iproc.o
-obj-$(CONFIG_I2C_BLACKFIN_TWI)	+= i2c-bfin-twi.o
 obj-$(CONFIG_I2C_CADENCE)	+= i2c-cadence.o
 obj-$(CONFIG_I2C_CBUS_GPIO)	+= i2c-cbus-gpio.o
 obj-$(CONFIG_I2C_CPM)		+= i2c-cpm.o
diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
deleted file mode 100644
index ff3343186a82..000000000000
-- 
2.9.0
