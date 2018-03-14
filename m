Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbeCNPuN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:50:13 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:40347 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbeCNPuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:50:10 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org
Subject: [PATCH 34/47] spi: remove blackfin related host drivers
Date: Wed, 14 Mar 2018 16:35:47 +0100
Message-Id: <20180314153603.3127932-35-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:m3xKmraVFuisT+aVbY3R0+WhiHVu8JPtN1BM+DphmXtw9yTyq11
 Q3fmmROhFYUpBxMAhJWaRMygorG2FpivNJJNM0SwkV8I/4d12KsJf5IEZH5EKMz9HPa/zZJ
 rCw92d9qBchYT+eY45x7HCdyaEWp4HeYZLL1DBC61Se2v12EwE3GvUwQrwMzI+9NNkVMtXB
 i4Gl241o78etXNxMCMrMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mPmNk/kLUKg=:J3SASw50Y2QR1jMLaBQy4t
 KOjPnnymH3Wob0x3x3EuM9+aAdhx9Cqy3ZxFjgVfq4aPikijf0kzP1TOI9c1Sxg6EIiHJ2y2O
 WAVLXHpOcQdCCYYokb84EoF4AJNbx/EucuWAI4FdQ8YlV9jjx5sOjk3oNDLSZK4b0Q7af6Srd
 ohRZ2D9wsjRUNeG/Pi+AgTlT/4i5RIji5bI5JCIS70XeEh3lIETB5eEFXK6FyFRu7c7qfgLyA
 GdeW4jcfDEcKuqHLF3m3Wzkst8eu7Hzq/YhNXm9obVxZEc3WS2np7qIVdZs7NeHBf9NeCBd50
 6o1AZGper2guMvlpk88B0UiCiHkQZ0sXO9rjC7UcRFRhfO2gSMcMUoJ5bf0rFgVIWIrD9bpS1
 FmqH85x5C25Rr/vhVi7WZA3GTuqS/UdPw7gCNvQyKe4Qjaa5jXJbqqAJKYJbNHrCivaQRenw9
 zJDor/RxJOqDF/p/TGLnJZ8a4CRCt6jz5qgZ0tvF3pYlns8LXX1t/IGzY32OZ1cn6m0/ccbD1
 bTzd7GcatZCtYQMYSis5tXmuoIPX8zRNCSfBV/Ul7LhAtP8ZPipCAL2wou1bACMdyv/d/hAh6
 cJB+9K6Ae7p5epxIzu84/PMCwRX0ADIkbXAK5yzMI+Qk6luFTT9u2Zy06Mw1i+eupUz0k2wsX
 v8WYYTji/CYQSWxBAjS4t0c738nSuRyTHDoMj0s+PQ1s8lOuOJGHRqhUOkka9egYviUiudyr9
 BoY2Ul6Wk5xPsbjaG94orRyMYIRCch2A0LkqLg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blackfin architecture is getting removed, so these
won't be needed any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/Kconfig          |   19 -
 drivers/spi/Makefile         |    3 -
 drivers/spi/spi-adi-v3.c     |  984 ----------------------------
 drivers/spi/spi-bfin-sport.c |  919 --------------------------
 drivers/spi/spi-bfin5xx.c    | 1462 ------------------------------------------
 5 files changed, 3387 deletions(-)
 delete mode 100644 drivers/spi/spi-adi-v3.c
 delete mode 100644 drivers/spi/spi-bfin-sport.c
 delete mode 100644 drivers/spi/spi-bfin5xx.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 6fb0347a24f2..9b0d9ae740d1 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -115,25 +115,6 @@ config SPI_BCM2835AUX
 	  "universal SPI master", and the regular SPI controller.
 	  This driver is for the universal/auxiliary SPI controller.
 
-config SPI_BFIN5XX
-	tristate "SPI controller driver for ADI Blackfin5xx"
-	depends on BLACKFIN && !BF60x
-	help
-	  This is the SPI controller master driver for Blackfin 5xx processor.
-
-config SPI_ADI_V3
-	tristate "SPI controller v3 for ADI"
-	depends on BF60x
-	help
-	  This is the SPI controller v3 master driver
-	  found on Blackfin 60x processor.
-
-config SPI_BFIN_SPORT
-	tristate "SPI bus via Blackfin SPORT"
-	depends on BLACKFIN
-	help
-	  Enable support for a SPI bus via the Blackfin SPORT peripheral.
-
 config SPI_BCM53XX
 	tristate "Broadcom BCM53xx SPI controller"
 	depends on ARCH_BCM_5301X
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 34c5f2832ddf..b935f10eb961 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -24,9 +24,6 @@ obj-$(CONFIG_SPI_BCM53XX)		+= spi-bcm53xx.o
 obj-$(CONFIG_SPI_BCM63XX)		+= spi-bcm63xx.o
 obj-$(CONFIG_SPI_BCM63XX_HSSPI)		+= spi-bcm63xx-hsspi.o
 obj-$(CONFIG_SPI_BCM_QSPI)		+= spi-iproc-qspi.o spi-brcmstb-qspi.o spi-bcm-qspi.o
-obj-$(CONFIG_SPI_BFIN5XX)		+= spi-bfin5xx.o
-obj-$(CONFIG_SPI_ADI_V3)                += spi-adi-v3.o
-obj-$(CONFIG_SPI_BFIN_SPORT)		+= spi-bfin-sport.o
 obj-$(CONFIG_SPI_BITBANG)		+= spi-bitbang.o
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi-butterfly.o
 obj-$(CONFIG_SPI_CADENCE)		+= spi-cadence.o
diff --git a/drivers/spi/spi-adi-v3.c b/drivers/spi/spi-adi-v3.c
deleted file mode 100644
index a16b25dcd1e6..000000000000
diff --git a/drivers/spi/spi-bfin-sport.c b/drivers/spi/spi-bfin-sport.c
deleted file mode 100644
index 01d0ba9c5942..000000000000
diff --git a/drivers/spi/spi-bfin5xx.c b/drivers/spi/spi-bfin5xx.c
deleted file mode 100644
index 249c7a3677c9..000000000000
-- 
2.9.0
