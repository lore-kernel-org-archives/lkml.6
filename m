Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeCNPsA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:48:00 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:33817 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752402AbeCNPr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:47:57 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Subject: [PATCH 29/47] mmc: remove bfin_sdh driver
Date: Wed, 14 Mar 2018 16:35:42 +0100
Message-Id: <20180314153603.3127932-30-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:vFnj92gW4/FJcjni9h5oW7AcoeMEADifckltmjMYGnpZE94tA5R
 ylRaVZlqCe+EnWumXId1OtGa4/oXmv8aL6AuGnNLkpIdTLNKd5rb/xtrGjum3/So0xssWqT
 CpWPiuanAPjl6A2QTvGFuQBHzUbokipj3+xjYBA2dhDFM9WXeyBJD6YehAQmCpf5ps2uAZi
 +avc3DNv3K5p+qC1E+Czg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ARCQpUx0jZQ=:EtFmlx93Iz+cww5M6b3N7K
 r/NWQ+JP+lRq/ipqPrJhjBQn4x9A3SggThejl+hyuQfZSva6uD31d7vKsKOY1n7TS/xL9H1DG
 wZTQ7ekiWB6ruVq4FTG4ATtj+lOwgZhlXZnxifR5K0dqbcirm/ctTqrTRNn7gdkb0dtdfOhMJ
 H9DSuijCqB/ItgBJz73QeKxYZIpliBSkuor5Xw4A9bMPeK6W12xJwQwcImqpPE3eHj4qFzt76
 IQcCUGBKM7N1ZPnwpiwj36XFuLEaYxtxWSfX9JfYHBH2le7aqtSyb9bpS7jtRTxSbblY2CjaR
 85DPKZRATKwEuTO9avC2O11+HVGOzxE1cEmX1cCaFBx4AbxMBTGGkp9IuS7dNlq9YJ2WbZnrX
 G0YTn1ecH9PwZkklkCRJggcknJ+g1rO9Ds2XLwNZnLqVVsSH8WYLgh6rPUdlnvuSY0dZzW9sC
 LxYCbn0q8bpyTY7fvqVCiFnv/NlLEsX3iacH//vntwv6G9IluqadV3OQezkxLIXDZJOiyR18k
 YPjaujZ0VMAIC8Xf3nnA0150fd1tRK3bL16dqrGTr/G1pIIrJW6DCHV44eOsRXYYAaNmjdYuJ
 91M+OQzw+n5iuHAYPTMWnNyd2AUfGPSUq9D12Rju6nXJvo8yXEua1Wsr44G0Mu4AA0tKI7X4B
 dYsf/E2BgWkzMopjM5g3s9ImPOtopFtWcD7ngH0o85EvdCqZwIjTYFsZTi/yfoDRMzQH6cNQg
 Gwbc/ycVes+oRMTukNz/Vpw5XxkEQzXoROjmXw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blackfin architecture is getting removed, so this one
is obsolete now as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/Kconfig    |  19 --
 drivers/mmc/host/Makefile   |   1 -
 drivers/mmc/host/bfin_sdh.c | 679 --------------------------------------------
 3 files changed, 699 deletions(-)
 delete mode 100644 drivers/mmc/host/bfin_sdh.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 620c2d90a646..b4fd5d48dd35 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -646,25 +646,6 @@ config MMC_VIA_SDMMC
 
 	  If unsure, say N.
 
-config SDH_BFIN
-	tristate "Blackfin Secure Digital Host support"
-	depends on (BF54x && !BF544) || (BF51x && !BF512)
-	help
-	  If you say yes here you will get support for the Blackfin on-chip
-	  Secure Digital Host interface.  This includes support for MMC and
-	  SD cards.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called bfin_sdh.
-
-	  If unsure, say N.
-
-config SDH_BFIN_MISSING_CMD_PULLUP_WORKAROUND
-	bool "Blackfin EZkit Missing SDH_CMD Pull Up Resistor Workaround"
-	depends on SDH_BFIN
-	help
-	  If you say yes here SD-Cards may work on the EZkit.
-
 config MMC_CAVIUM_OCTEON
 	tristate "Cavium OCTEON SD/MMC Card Interface support"
 	depends on CAVIUM_OCTEON_SOC
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 84cd1388abc3..f563cc0b7f93 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -43,7 +43,6 @@ obj-$(CONFIG_MMC_SDHI_SYS_DMAC)		+= renesas_sdhi_sys_dmac.o
 obj-$(CONFIG_MMC_SDHI_INTERNAL_DMAC)	+= renesas_sdhi_internal_dmac.o
 obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
-obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
 octeon-mmc-objs := cavium.o cavium-octeon.o
 obj-$(CONFIG_MMC_CAVIUM_OCTEON) += octeon-mmc.o
 thunderx-mmc-objs := cavium.o cavium-thunderx.o
diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
deleted file mode 100644
index 526231e38583..000000000000
-- 
2.9.0
