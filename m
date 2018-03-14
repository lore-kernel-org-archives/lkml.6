Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752502AbeCNPra (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:47:30 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:47581 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbeCNPr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:47:28 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 28/47] input: misc: remove blackfin rotary driver
Date: Wed, 14 Mar 2018 16:35:41 +0100
Message-Id: <20180314153603.3127932-29-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:Bh7GBfnfTMy/uZL15e71XraGUVtYO9LquZsrfKI//AKjCcfSyc3
 cmhIUih0M3zNl19kgn2gfqLZxYccqEkLeax4t0C1MoPk3KB7aKQ3AToJHoFPpE6fjhLJK+d
 ZGlpiC+s8XBG4r+DLL3KPeHQBQHL57VWM1yPFSiPWduHzypKrDoJ7L4KXxUc0R9QcjCWr6F
 Jn0nhYc1U2FUpVcFOMhnQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VdRpxfhU4gs=:1t8RYYrw2E0gwN1S8ZoSNW
 cZaZdC56Uw+1ikv3sP9l+s0maFSKyAxuqPS5kr0p2cD33tzkylMaY9jOjxnGYQfnnextICXXz
 6im2++ULcsllyiVEmhgU2LYqZ/7p5dlKGkROufnqnK8beDXAU9t1w0Q9btTp4AKvqQERmIcNX
 tiDnCUYjz704B476aAwMMQQ2XBQh/lxvjbG6HrEbrIOy5PEn9TezmzmYhaE2IYYgeN4QmcPek
 Vro2hXkzjsUCQW7pWSjay/EuplfBSuzOPW3nxytjRIb9n8VOx1ezhrYxehi6lqFX/PvsRVwlP
 CMMKp37mo/P1penEo/VVNmP2IAkI1g5m03dX5G83JCtSxM5pt9hLcEmsA9KkezppYg9VueROs
 uhqLVnQSMea1Hh1S8sR2e3ALSnIgkiA54iCp4kNdYnI1iOeh9e3AQIMwzk7f3aIWbmKUsdo4I
 i86wrnwQPq5dAla9KRRgBiskLWIHWvE+z7/IL1hh+JBRocuGz1T4ofAWL5eoV4VhqAjZu25O+
 EtxCwM5zgmikdmGW68Vo/xfCuOxevJ1og2AIQ2C9qPBHmtHcF7Neu2M/WGwT1D7o3auRilman
 tSdiMX8IEluypF0DlY+35YlKBultTQEOoH4Jay86LK2ELu5/RZwUwomzbu+Imzd0PImL9eEah
 w1gSBAq4QiubsM/XMguCf4SrmrRXwWwURCObBh40Cd3WHrbQE8ZhS4xdQTo874kSK2LtDAEcZ
 dTcqQVPYJPkqU1fasuMQhzz8s7vjgOR8kJwLkw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blackfin architecture is getting removed, so this
one is obsolete as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/misc/Kconfig                |   9 -
 drivers/input/misc/Makefile               |   1 -
 drivers/input/misc/bfin_rotary.c          | 294 ------------------------------
 include/linux/platform_data/bfin_rotary.h | 117 ------------
 4 files changed, 421 deletions(-)
 delete mode 100644 drivers/input/misc/bfin_rotary.c
 delete mode 100644 include/linux/platform_data/bfin_rotary.h

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 6a3c753b093b..572b15fa18c2 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -655,15 +655,6 @@ config INPUT_DM355EVM
 	  To compile this driver as a module, choose M here: the
 	  module will be called dm355evm_keys.
 
-config INPUT_BFIN_ROTARY
-	tristate "Blackfin Rotary support"
-	depends on BF54x || BF52x
-	help
-	  Say Y here if you want to use the Blackfin Rotary.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called bfin-rotary.
-
 config INPUT_WM831X_ON
 	tristate "WM831X ON pin"
 	depends on MFD_WM831X
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 8cc58f362bb8..72cde28649e2 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_INPUT_ARIZONA_HAPTICS)	+= arizona-haptics.o
 obj-$(CONFIG_INPUT_ATI_REMOTE2)		+= ati_remote2.o
 obj-$(CONFIG_INPUT_ATLAS_BTNS)		+= atlas_btns.o
 obj-$(CONFIG_INPUT_ATMEL_CAPTOUCH)	+= atmel_captouch.o
-obj-$(CONFIG_INPUT_BFIN_ROTARY)		+= bfin_rotary.o
 obj-$(CONFIG_INPUT_BMA150)		+= bma150.o
 obj-$(CONFIG_INPUT_CM109)		+= cm109.o
 obj-$(CONFIG_INPUT_CMA3000)		+= cma3000_d0x.o
diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
deleted file mode 100644
index 799ce3d2820e..000000000000
diff --git a/include/linux/platform_data/bfin_rotary.h b/include/linux/platform_data/bfin_rotary.h
deleted file mode 100644
index 98829370fee2..000000000000
-- 
2.9.0
