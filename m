Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D931CC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5712620E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2AF8d0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5712620E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965224AbeF0NQd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:16:33 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40871 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964873AbeF0NQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:16:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id m15-v6so3064597edr.7;
        Wed, 27 Jun 2018 06:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gm3L6Se0BvBWf1yhSNGI9gTjy2+Us7pnXrQRpckv6lY=;
        b=p2AF8d0ZlTXL6VM7rJC8QhpFweuPHtZBqDLPDzdKCz99TT4wWkyXd1GWyHeM7OTCM7
         LHeEqk1nuoYO35WU49dEtaYnAuZeJFPvCKxy0lJMEMUskNV1H8Zq4Uy2XMmKy4C1wIuS
         nr9vuhP33GggoVvlH4QsnaIWBOXOyG8bLNLB60m277RoncZc+laWvYcKyrd3VA7aeGUv
         o1uikP3X9fzTBc3+Lgxs8mhXRTaA6/mAGu4kk4ItP3/tmsRCmoxC052QjYGNiOYf8HKf
         J97KWGZPtFv0Qs8R52a/pLgDqJPH+oSGb37hCxyqZmNzSQGjHD1ZFyuDZIp2mx6HQ8x4
         bgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gm3L6Se0BvBWf1yhSNGI9gTjy2+Us7pnXrQRpckv6lY=;
        b=NmQ7lxaU9POCRnS32oSupLHkUn6rHITN67PAV48qjW5jaUqKS3EcpzssGJHi+jh/7p
         lXQ7FgLrZr8zCNE5L8UamwrxBCLk9KvfpgXZ9+bX9+zqNVjR6l17vTnpqHPG/YbkoJ+X
         0+4pL2veSV5N0qwlcbMMTnab6n9vE/fo+OVe6dnx6WWxbnqGU22Q8SDoy/4Z8p0yizq3
         RUk9DwIjyRISmBT5jnhG9Nqe+LPOu+NDq8ohBdET6mnUgEjJRwivq0uy2Nz5aioielOh
         yA/XClJHaA4R6DNbvCb5FsI1s7cjjoFeaLYjg7+S07BuLyhlhGKpx4bTcFgs2teYjwsg
         p8Ag==
X-Gm-Message-State: APt69E2T+z9wGPhCN7CHkbdp3Z/I9A9Fv1jgCMN/QY94gB0B7VCOcWBe
        F+CgtF3ZRSXzs5FjWf2rEQ==
X-Google-Smtp-Source: AAOMgpfB7ansLVyawqkzRv0tRa7KMU/F10Chk2wGCK3NqkNNC7lIL54YS1gzG+v60IIH5nrwRo0oQA==
X-Received: by 2002:aa7:c803:: with SMTP id a3-v6mr1468704edt.124.1530105385548;
        Wed, 27 Jun 2018 06:16:25 -0700 (PDT)
Received: from carbonite.sagemdenmark.dk ([130.228.251.5])
        by smtp.gmail.com with ESMTPSA id i34-v6sm1953000edc.29.2018.06.27.06.16.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:16:24 -0700 (PDT)
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
        Piotr Bugalski <bugalski.piotr@gmail.com>,
        Piotr Bugalski <pbu@cryptera.com>
Subject: [RFC PATCH v2 5/6] spi: Add QuadSPI driver for Atmel SAMA5D2
Date:   Wed, 27 Jun 2018 15:16:08 +0200
Message-Id: <20180627131609.13681-6-bugalski.piotr@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180627131609.13681-1-bugalski.piotr@gmail.com>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
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
Signed-off-by: Piotr Bugalski <pbu@cryptera.com>
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
index ad5d68e1dab7..88f9c007d825 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -83,6 +83,15 @@ config SPI_ATMEL
 	  This selects a driver for the Atmel SPI Controller, present on
 	  many AT91 ARM chips.
 
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
index cb1f4378b87c..1a08e5bfcee9 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
 obj-$(CONFIG_SPI_ALTERA)		+= spi-altera.o
 obj-$(CONFIG_SPI_ARMADA_3700)		+= spi-armada-3700.o
 obj-$(CONFIG_SPI_ATMEL)			+= spi-atmel.o
+obj-$(CONFIG_SPI_ATMEL_QUADSPI)		+= atmel-quadspi.o
 obj-$(CONFIG_SPI_ATH79)			+= spi-ath79.o
 obj-$(CONFIG_SPI_AU1550)		+= spi-au1550.o
 obj-$(CONFIG_SPI_AXI_SPI_ENGINE)	+= spi-axi-spi-engine.o
diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
similarity index 100%
rename from drivers/mtd/spi-nor/atmel-quadspi.c
rename to drivers/spi/atmel-quadspi.c
-- 
2.11.0

