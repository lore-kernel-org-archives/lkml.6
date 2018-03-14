Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752252AbeCNPj6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:39:58 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:37731 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeCNPjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:39:55 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Subject: [PATCH 09/47] rtc: remove bfin driver
Date: Wed, 14 Mar 2018 16:35:22 +0100
Message-Id: <20180314153603.3127932-10-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:sZsDBIqqFUiefJ4HO/ViZsbPhx33gg6sHdHynLh5BnGkR+Y2kKK
 VjK7X6/8QVXXKbnQINzr8HHVOZMflSyRGlaZllit8LL1vMCToMp40yVMDEUBxsuBkodwism
 jvwLTWpe5aBM+k2OlgtXLekdW0SUx0VPeAbd25PiRvAX3vGjvMhNJPVdbGqIsvvy9ldiFYK
 cFUWXejHLfMccf4baSg/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vZtNGPbcJYU=:OWcoJ8lDVQh71mLTSDlRuo
 fg3Ed4wXnO9jnQMYlK+gm7q/znAd5ceCNiGG0T/jpVqHOVlSwWAM0XHtAI8iRVJR4sP3VL04b
 xs9RSlZGsoQ7Zt4/1sK4DeqkgVbbLsl4R5iArDY5xnrzzCn+AQFOxjKo6veD4APiXmacLTgKZ
 C4dcdcG2QlKgvhQX1SIUbr4Z4FTpD1q68Kz5Auo6g91lEdQBRrnD19cXQ244S2bMgtfAzBpTn
 0h/OKIc+P0UQjxDIgkWWCCYElIKno0mMKBJmNoF5J/pn4PoWlX/0LHsIIuRoIte8/nd0U/2hY
 XWPVuRWriI4+7K7TYpUbu40rHvgfJuKqEq1gdSXfjBf654/fcgiTbJ1JhY3FJs/2bkmpS44x8
 2aaN2Rp69qvnTwXHZfS3BxkaMOUcskQR3I9qmx4CyqjG8EEC+tY3wIjJRh3XQkys3SpjWN7GB
 Z+A6lOCyco5vweirovP6PHCYAu9CI+4RtGXFX1qlI+IWt4Q+GauMg9dLE6Dw6oxGwSqWpSyN1
 QWXIF5nDm2GFxKO+HHpMxoJVmNxmx2zcfgRynwwLI/ivyTuLsooENFsP2syqUJMoDZ0foajNc
 G5m0V6467WOn5X/YReTtleYl0gHJqzASYIlv+LqST5Et+xbKHG/kU1mHcTxTN6kjBwrKGderZ
 bKslernxuxN7yTnnPFGll4QM5pVtMvTbyrIfWeGkMzRxb6yvacihr6+sziuj4UIkyNywYOsVB
 5LStevjswEEFvHd5fSW3Lo0BXN5ElnYXax88yg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blackfin architecture is getting removed, so this one is
now obsolete.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/Kconfig    |  10 --
 drivers/rtc/Makefile   |   1 -
 drivers/rtc/rtc-bfin.c | 448 -------------------------------------------------
 3 files changed, 459 deletions(-)
 delete mode 100644 drivers/rtc/rtc-bfin.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 0e1413a5ba3a..0ab8946f69b7 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1445,16 +1445,6 @@ config RTC_DRV_AU1XXX
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-au1xxx.
 
-config RTC_DRV_BFIN
-	tristate "Blackfin On-Chip RTC"
-	depends on BLACKFIN && !BF561
-	help
-	  If you say yes here you will get support for the
-	  Blackfin On-Chip Real Time Clock.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called rtc-bfin.
-
 config RTC_DRV_RS5C313
 	tristate "Ricoh RS5C313"
 	depends on SH_LANDISK
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index f7a4b09557a0..5ff2fc0c361a 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -36,7 +36,6 @@ obj-$(CONFIG_RTC_DRV_ASM9260)	+= rtc-asm9260.o
 obj-$(CONFIG_RTC_DRV_AT91RM9200)+= rtc-at91rm9200.o
 obj-$(CONFIG_RTC_DRV_AT91SAM9)	+= rtc-at91sam9.o
 obj-$(CONFIG_RTC_DRV_AU1XXX)	+= rtc-au1xxx.o
-obj-$(CONFIG_RTC_DRV_BFIN)	+= rtc-bfin.o
 obj-$(CONFIG_RTC_DRV_BRCMSTB)	+= rtc-brcmstb-waketimer.o
 obj-$(CONFIG_RTC_DRV_BQ32K)	+= rtc-bq32k.o
 obj-$(CONFIG_RTC_DRV_BQ4802)	+= rtc-bq4802.o
diff --git a/drivers/rtc/rtc-bfin.c b/drivers/rtc/rtc-bfin.c
deleted file mode 100644
index 15344b7c07c5..000000000000
-- 
2.9.0
