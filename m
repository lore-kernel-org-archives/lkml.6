Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85A9C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6535320869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGWVK1YR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6535320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbeKET4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:56:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44989 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbeKET4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:56:22 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so7499397lji.11;
        Mon, 05 Nov 2018 02:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v5SrLqwaefxhcu13dG/N9X5a04K90k89Ih63e3RyAys=;
        b=TGWVK1YRmXP/aebB6wXKwVf0Hjug9Y++cvVhwPNSUqkM5EDwURH53ejCLsgB5bCrBP
         mH/X1fxQNqUsUztNWVrEoU53vSfMHSRNrkOJ7Ls2G4kRx3s0N4mVhDZE8qyOC9ZoIge3
         tU5dcCJGV3a7shpPF9LRabHOq+pl5kGYaVbgF75dUJJkjm1S+Ntu1MBG11MAUNkkb5qG
         mWmmHCn6N8qaegqk7DXP78BSBXwIXJCCh0LO0YProJg3VGQEUwVJnsSO48ftQoChe1N1
         mDa2jqHjY032YLnNvKKuJR3ElgTPxKEKC616J18dRZ3fnHNbCKX3Zp2TpBTysBJ823M3
         BzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v5SrLqwaefxhcu13dG/N9X5a04K90k89Ih63e3RyAys=;
        b=fi0uGa9dWkusdqUVkbqJNDQoz1+jrnQ2fr593r3Qr4irKl7pi7WvBLYi1FyF3U/xRy
         LDxQLJiJlWMfidHsSil1a5oZCG/f22LX3K9Ulbt+2gLj+kZeMg2CCEw1Pb37cPeNiItt
         6u8eXL9dVBBXEguXAZHYm9FDX2ut31VP1NY4P8ju+ouwfyRYI6EMUYsc1+NRZHbixK2K
         PRW3RABHxZw4GDfmhNUFJ0jmBeiEtJIVmmMjoiJ0vIi9bycG1RTkg3NIroko1VTqXsin
         W21GEjWvhBvOhgRMKCf6QU7YVdYXznXIwyiVu+qCiZI4yEfTVJfdFDcsiNNx9qdnpwuN
         +cVA==
X-Gm-Message-State: AGRZ1gI6qs8ux15nf4tgdaPIBMLgmNF3iy29+VM9Qc18oQWgqQ1SF6MD
        59H/u+Wm5ncfosJTVxOD8w==
X-Google-Smtp-Source: AJdET5eGxRiM0DxyBfEpFi98zsql3a3uCLwL1yTi8X8guYMX6Ale70TxJBKmyIvm3q2Fh8fn57x8lw==
X-Received: by 2002:a2e:6594:: with SMTP id e20-v6mr15002634ljf.123.1541414237787;
        Mon, 05 Nov 2018 02:37:17 -0800 (PST)
Received: from localhost.localdomain (89-64-7-227.dynamic.chello.pl. [89.64.7.227])
        by smtp.gmail.com with ESMTPSA id h140-v6sm5413605lfg.4.2018.11.05.02.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 02:37:16 -0800 (PST)
From:   Piotr Bugalski <bugalski.piotr@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <bugalski.piotr@gmail.com>
Subject: [PATCH v3 5/6] spi: Add QuadSPI driver for Atmel SAMA5D2
Date:   Mon,  5 Nov 2018 11:36:24 +0100
Message-Id: <20181105103625.9644-6-bugalski.piotr@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181105103625.9644-1-bugalski.piotr@gmail.com>
References: <20181105103625.9644-1-bugalski.piotr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel contains QSPI driver strongly tied to MTD and nor-flash memory.
New spi-mem interface allows usage also other memory types, especially
much larger NAND with SPI interface. This driver works as SPI controller
and is not related to MTD, however can work with NAND-flash or other
peripherals using spi-mem interface.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Piotr Bugalski <bugalski.piotr@gmail.com>
---
 drivers/mtd/spi-nor/Kconfig                  | 9 ---------
 drivers/mtd/spi-nor/Makefile                 | 1 -
 drivers/spi/Kconfig                          | 9 +++++++++
 drivers/spi/Makefile                         | 1 +
 drivers/{mtd/spi-nor => spi}/atmel-quadspi.c | 0
 5 files changed, 10 insertions(+), 10 deletions(-)
 rename drivers/{mtd/spi-nor => spi}/atmel-quadspi.c (100%)

diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
index 6cc9c929ff57..44fe8018733c 100644
--- a/drivers/mtd/spi-nor/Kconfig
+++ b/drivers/mtd/spi-nor/Kconfig
@@ -39,15 +39,6 @@ config SPI_ASPEED_SMC
 	  and support for the SPI flash memory controller (SPI) for
 	  the host firmware. The implementation only supports SPI NOR.
 
-config SPI_ATMEL_QUADSPI
-	tristate "Atmel Quad SPI Controller"
-	depends on ARCH_AT91 || (ARM && COMPILE_TEST)
-	depends on OF && HAS_IOMEM
-	help
-	  This enables support for the Quad SPI controller in master mode.
-	  This driver does not support generic SPI. The implementation only
-	  supports SPI NOR.
-
 config SPI_CADENCE_QUADSPI
 	tristate "Cadence Quad SPI controller"
 	depends on OF && (ARM || ARM64 || COMPILE_TEST)
diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index f4c61d282abd..a552efd22958 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
 obj-$(CONFIG_SPI_ASPEED_SMC)	+= aspeed-smc.o
-obj-$(CONFIG_SPI_ATMEL_QUADSPI)	+= atmel-quadspi.o
 obj-$(CONFIG_SPI_CADENCE_QUADSPI)	+= cadence-quadspi.o
 obj-$(CONFIG_SPI_FSL_QUADSPI)	+= fsl-quadspi.o
 obj-$(CONFIG_SPI_HISI_SFC)	+= hisi-sfc.o
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 7d3a5c94727e..ca68ac63c6c3 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -91,6 +91,15 @@ config SPI_AT91_USART
 	  This selects a driver for the AT91 USART Controller as SPI Master,
 	  present on AT91 and SAMA5 SoC series.
 
+config SPI_ATMEL_QUADSPI
+	tristate "Atmel Quad SPI Controller"
+	depends on ARCH_AT91 || (ARM && COMPILE_TEST)
+	depends on OF && HAS_IOMEM
+	help
+	  This enables support for the Quad SPI controller in master mode.
+	  This driver does not support generic SPI. The implementation only
+	  supports spi-mem interface.
+
 config SPI_AU1550
 	tristate "Au1550/Au1200/Au1300 SPI Controller"
 	depends on MIPS_ALCHEMY
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 3575205c5c27..258917db3f56 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
 obj-$(CONFIG_SPI_ALTERA)		+= spi-altera.o
 obj-$(CONFIG_SPI_ARMADA_3700)		+= spi-armada-3700.o
 obj-$(CONFIG_SPI_ATMEL)			+= spi-atmel.o
+obj-$(CONFIG_SPI_ATMEL_QUADSPI)		+= atmel-quadspi.o
 obj-$(CONFIG_SPI_AT91_USART)		+= spi-at91-usart.o
 obj-$(CONFIG_SPI_ATH79)			+= spi-ath79.o
 obj-$(CONFIG_SPI_AU1550)		+= spi-au1550.o
diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
similarity index 100%
rename from drivers/mtd/spi-nor/atmel-quadspi.c
rename to drivers/spi/atmel-quadspi.c
-- 
2.11.0

