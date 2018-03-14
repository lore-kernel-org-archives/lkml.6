Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeCNPlX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:41:23 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:36433 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbeCNPlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:41:18 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 14/47] pcmcia: remove blackfin driver
Date: Wed, 14 Mar 2018 16:35:27 +0100
Message-Id: <20180314153603.3127932-15-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:kiOXzsVB0Q5UajRvBcPl2POyrEx+twR1Bnhl2zqNyCfc4VOtHF/
 Ms++48/eXDG7dYA0o4rtk/54XyJDzKB/1p9bofK4m2bijYEZqH3pjrs5kjyC/VbRZgVHyDo
 pNKe2xwNKePTeps61ZdIhbKGZKYEiL9ly5u+uMW6p8C/qr97X/BpzT7Syy9RmkuPnb/hr6Q
 QHlhNMjPhkrIXEkU+78Ww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a52uj5VdzqA=:DgFIgzTW14n2JyaJ0OOV11
 7tQ4mcupALUd0f3MDNMQaICPDgmdYgFJirtKcvNeW9NiCjy/0aXycP8MlgHfvIc7AmXvAg7Ga
 0WIVWKMhkHheaY3q2F5oxISKlz12a3Gu+yOWUqDtYrSFN5op0V9aDigty6LaRMAcQ2aarniXI
 vENR4s/iO6Xe0GF5ou1FOW6BUKnMH/Mh/wDB24JlBywsA/vEPgLaUWe1i7vbtsPVl8Wn3py5Q
 LEaBOWMcx97d5E8lQTjGyPhrrsB5bWtJ65BwhHhgZwcev+ikTBwdSVpJmYgPaFP9MADgV03m1
 F85LOTXHwm7PrJWt5coI6EiJ2PeaLr5B3CM25L8XIee9hzQgliaZb0Pk0gqR3E4dk2kpxPEox
 CDHrMNXiL4jE7cfgYUt0uc4W1/dcSBVo87cQG36KyhUxc3GwnBNKkdfnZveye341q1Ux1V6VS
 KtIYjWYYxyjkvBu5OUg/8gRstHyTkQFeWjGiBPG47Rtnmlm6TsW/F58gUGdoJAPeggZ1e6God
 v9KcIAQT9lgJEGt71zK5qV+AC8nWPl6B0S9Tla9Qu63qpcJ/AwDHOcGpHDmxytyFsRpyYDDnp
 6QpQHhZLdtYo2FiwSDYsXnFMC1fwtlkXaFYWqeqUzkKbvvlnuXBTnEtKGGKNHVTvLpCskqaqK
 FcYRyV1ys5aBIKWhlsBpMYDzbtWuOA9nZCzHOS4NKzAcqcatXe5Yj6P9doXYVhhIOHAUjtktD
 w+/ojnJbV5wMlIj5IvlBvkbc/zJtvMPkF0Xh3Q==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blackfin architecture is getting removed, so this one is no
longer needed either.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pcmcia/Kconfig          |   7 -
 drivers/pcmcia/Makefile         |   1 -
 drivers/pcmcia/bfin_cf_pcmcia.c | 316 ----------------------------------------
 3 files changed, 324 deletions(-)
 delete mode 100644 drivers/pcmcia/bfin_cf_pcmcia.c

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 49540d13dea4..cbbe4a285b48 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -247,13 +247,6 @@ config OMAP_CF
 	  Say Y here to support the CompactFlash controller on OMAP.
 	  Note that this doesn't support "True IDE" mode.
 
-config BFIN_CFPCMCIA
-	tristate "Blackfin CompactFlash PCMCIA Driver"
-	depends on PCMCIA && BLACKFIN
-	help
-	  Say Y here to support the CompactFlash PCMCIA driver for Blackfin.
-
-
 config AT91_CF
 	tristate "AT91 CompactFlash Controller"
 	depends on PCI
diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index ca361266d055..f1f89ddb1bfd 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -32,7 +32,6 @@ obj-$(CONFIG_PCMCIA_BCM63XX)			+= bcm63xx_pcmcia.o
 obj-$(CONFIG_PCMCIA_VRC4171)			+= vrc4171_card.o
 obj-$(CONFIG_PCMCIA_VRC4173)			+= vrc4173_cardu.o
 obj-$(CONFIG_OMAP_CF)				+= omap_cf.o
-obj-$(CONFIG_BFIN_CFPCMCIA)			+= bfin_cf_pcmcia.o
 obj-$(CONFIG_AT91_CF)				+= at91_cf.o
 obj-$(CONFIG_ELECTRA_CF)			+= electra_cf.o
 obj-$(CONFIG_PCMCIA_ALCHEMY_DEVBOARD)		+= db1xxx_ss.o
diff --git a/drivers/pcmcia/bfin_cf_pcmcia.c b/drivers/pcmcia/bfin_cf_pcmcia.c
deleted file mode 100644
index 00a296d431ba..000000000000
-- 
2.9.0
