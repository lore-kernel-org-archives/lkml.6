Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeCNPuE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:50:04 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:60699 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbeCNPuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:50:00 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 32/47] mtd: maps: remove bfin-async-flash driver
Date: Wed, 14 Mar 2018 16:35:45 +0100
Message-Id: <20180314153603.3127932-33-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:nx6DFakSc7GudSOfd5C+berzrSxpjqbNR8y7CK1ejwku3oDO2tU
 +5XWveazy19J1auiBE5/eUMBVXvs9mnrkbBeLH76qdwVQIQlwNyVDcIMqThZv5XnUMhQapI
 yax5QYh5IYqnLAFOCSBj0iK+JMzMQSCUKzI+wHviwq6HGtRuMUZIucmVBir5PdINmjYM+Gb
 ON3Iq0NF47vgcXGVuEQHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Kq6Xe20dBVE=:Nif9pH0rY6mxS+ryLlApjN
 WSVwVeP1ZcHXm4E5uOjhD30CBouT6mgM8+6pBaksc9afdDaQO6IbLDpewtrU3rA18PpUoNYm9
 kck/KwsvSmfvOeF56LDRvvOsBJFailJGWEKruJC2vjT34/ItUegfj2vp4ZdGAFu96UVonOtnD
 /zBQs7E2JGsbHi757AhGJh0rIF8KUX3k7bPwSLaHOe2Lu/OEtnmrg+Iz5oWykuz+PYY7PFmTJ
 pPPlMouEF4mG04tBgUxbv/09yhI+tW54lCYT1l74kTBGKPgIS6PyqWuFjuofOci3iDt4+dVLd
 ZJ3YQZzZp4g13T71MF1sUbp9lGRCWRec7+PXlVRXiqpHfHt0i/T/U4TRO0/lAVOFNWL2WmFaf
 pgrXodhvTwXLJdWx5/SuZAPyR8pUyypxUZcs7qCkzhfAI1oAX11OearlUOa+MClAgjcI0M3t/
 YHLiON6qyZLjY/BgO3Tp8dTrf82wbX81w2ADOBPhsSqMBEaoqv9UNJmRAZtD7b5ZkDb2sOAra
 o/Ux864GatJWVGTCJo59Cr+sGWjV+XloFf8CbaUJSUtl2gGkzGGyBZKobiWjRYhCgPpcCBi4G
 HAWR2BCMGesbI5K1aY3/v98q0raFKc8NeMCC9f03QJeabLdfXJkg6KzwoFh6zggxLqlXV5VIx
 1o8tJeCMdN3xCkSE6LYLpbzRp01sOuk0An+p18eFS1ZxVeXkLTKNZe3KdMmFo0HWCR/SngKB6
 esgqQGdmxSo0TKc4EZjwrDClH8EVOYe0opyniQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blackfin architecture is getting removed, so this driver
has become obsolete.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/maps/Kconfig            |  10 --
 drivers/mtd/maps/Makefile           |   1 -
 drivers/mtd/maps/bfin-async-flash.c | 196 ------------------------------------
 3 files changed, 207 deletions(-)
 delete mode 100644 drivers/mtd/maps/bfin-async-flash.c

diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 542fdf8e81fa..bdc1283f30fb 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -334,16 +334,6 @@ config MTD_PCMCIA_ANONYMOUS
 
 	  If unsure, say N.
 
-config MTD_BFIN_ASYNC
-	tristate "Blackfin BF533-STAMP Flash Chip Support"
-	depends on BFIN533_STAMP && MTD_CFI && MTD_COMPLEX_MAPPINGS
-	default y
-	help
-	  Map driver which allows for simultaneous utilization of
-	  ethernet and CFI parallel flash.
-
-	  If compiled as a module, it will be called bfin-async-flash.
-
 config MTD_GPIO_ADDR
 	tristate "GPIO-assisted Flash Chip Support"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index b849aaf85c34..51acf1fec19b 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -42,7 +42,6 @@ obj-$(CONFIG_MTD_SCB2_FLASH)	+= scb2_flash.o
 obj-$(CONFIG_MTD_IXP4XX)	+= ixp4xx.o
 obj-$(CONFIG_MTD_PLATRAM)	+= plat-ram.o
 obj-$(CONFIG_MTD_INTEL_VR_NOR)	+= intel_vr_nor.o
-obj-$(CONFIG_MTD_BFIN_ASYNC)	+= bfin-async-flash.o
 obj-$(CONFIG_MTD_RBTX4939)	+= rbtx4939-flash.o
 obj-$(CONFIG_MTD_VMU)		+= vmu-flash.o
 obj-$(CONFIG_MTD_GPIO_ADDR)	+= gpio-addr-flash.o
diff --git a/drivers/mtd/maps/bfin-async-flash.c b/drivers/mtd/maps/bfin-async-flash.c
deleted file mode 100644
index 41730feeace8..000000000000
-- 
2.9.0
