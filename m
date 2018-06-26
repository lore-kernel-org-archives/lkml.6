Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B176FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DB6267A3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="k/awcZDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67DB6267A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934389AbeFZJ0g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:26:36 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33116 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933822AbeFZJZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:25:50 -0400
Received: by mail-wr0-f194.google.com with SMTP id k16-v6so16486045wro.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ys0pHhAz6lKrrz6odTeZF3ZKvLxJEqE7KZ9Ja4OaoXo=;
        b=k/awcZDPx7qmhpJdmpg40fzYE91rkJvR6CLCgPl6wVQ4H2aSGhoKKq6KPOmvbmPxd9
         R7CnfeIo17vpC7+RYKgf++f459or/kdkHkQTycnwdYQSD54ZA65xikfa8DLP58iAjabA
         oDMwP4y54FuvBBwcus+fDstNc0s+MVCxDjZL/gaevYTB16zlkkwmklJ7GJCCP5P2a8jA
         Z/sEd6OrQrZGb+LvWZrgafO/E2s31KNv8MnXRXWIAXDp4aEiukvFcqcHDroJnoMYewAn
         sb0gjD0jC7KpeykF/OuBK1eygEZkLq0R1rEsiJSLLebqLOidQjkKgBPTS2Gfb3Lm9yWP
         7rRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ys0pHhAz6lKrrz6odTeZF3ZKvLxJEqE7KZ9Ja4OaoXo=;
        b=MP4k0EwVSIeLwq8Y6156mkxhRtsM7lCDdLTBTkt3geIxDSEyXqVaZ412XE510G6GDH
         eXI9npKO6dli7OxAf6pOSJBj52MdByoW2rA7llk+TE0hrP6UwD02tuHe1lx8WjGcV47z
         /vwgbJxOOGaSsr/VOesCIOnj1S7jwwbsHSK/UaG3t79o7ptb5r5XTTpjgVpHdJjdWfku
         jj/ExZl2IvXRstlfLzgSPiNkDqxNPJMY6i2xDsQA5Il1qb6v1DV6m5XPmpJ5GMjXU30d
         YgA3UC3TMWxn9d+wKNuHHbVvSMOmwoC6aDMBGqsYEQTDfrfxlnyvmyEl2NgJzhGpCZqF
         Faog==
X-Gm-Message-State: APt69E2p6QgbC2Qi+ufV0exEy5K74NHdds400/gZ6WsjK9juicfsgtZO
        eE4JJC6QRo5eOzQerhSvJ5u5XQ==
X-Google-Smtp-Source: AAOMgpc69GQ/nXBv6JWZy/LYP8/VT31yMJP4vezQnwONHNqYJgc+qQf8wtc2UDAdTg3cPjztRNQOeQ==
X-Received: by 2002:adf:ec02:: with SMTP id x2-v6mr697986wrn.245.1530005149601;
        Tue, 26 Jun 2018 02:25:49 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id a8-v6sm1528791wrn.50.2018.06.26.02.25.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 02:25:49 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 07/13] ARM: davinci: da850-evm: use aemif platform driver in legacy mode
Date:   Tue, 26 Jun 2018 11:25:31 +0200
Message-Id: <20180626092537.6737-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626092537.6737-1-brgl@bgdev.pl>
References: <20180626092537.6737-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support board files in the aemif driver. Register a platform
device instead of using the handcrafted API in da850-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 93 ++++++++++++++-----------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 442c16773f09..ace66f368f8d 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -33,6 +33,7 @@
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/mtd-davinci-aemif.h>
+#include <linux/platform_data/ti-aemif.h>
 #include <linux/platform_data/spi-davinci.h>
 #include <linux/platform_data/uio_pruss.h>
 #include <linux/regulator/machine.h>
@@ -185,16 +186,6 @@ static struct resource da850_evm_norflash_resource[] = {
 	},
 };
 
-static struct platform_device da850_evm_norflash_device = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev		= {
-		.platform_data  = &da850_evm_norflash_data,
-	},
-	.num_resources	= 1,
-	.resource	= da850_evm_norflash_resource,
-};
-
 /* DA850/OMAP-L138 EVM includes a 512 MByte large-page NAND flash
  * (128K blocks). It may be used instead of the (default) SPI flash
  * to boot, using TI's tools to install the secondary boot loader
@@ -266,37 +257,58 @@ static struct resource da850_evm_nandflash_resource[] = {
 	},
 };
 
-static struct platform_device da850_evm_nandflash_device = {
-	.name		= "davinci_nand",
-	.id		= 1,
-	.dev		= {
-		.platform_data	= &da850_evm_nandflash_data,
-	},
-	.num_resources	= ARRAY_SIZE(da850_evm_nandflash_resource),
-	.resource	= da850_evm_nandflash_resource,
+static struct resource da850_evm_aemif_resource[] = {
+	{
+		.start	= DA8XX_AEMIF_CTL_BASE,
+		.end	= DA8XX_AEMIF_CTL_BASE + SZ_32K,
+		.flags	= IORESOURCE_MEM,
+	}
 };
 
-static struct platform_device *da850_evm_devices[] = {
-	&da850_evm_nandflash_device,
-	&da850_evm_norflash_device,
+static struct aemif_abus_data da850_evm_aemif_abus_data[] = {
+	{
+		.cs	= 3,
+	}
 };
 
-#define DA8XX_AEMIF_CE2CFG_OFFSET	0x10
-#define DA8XX_AEMIF_ASIZE_16BIT		0x1
-
-static void __init da850_evm_init_nor(void)
-{
-	void __iomem *aemif_addr;
-
-	aemif_addr = ioremap(DA8XX_AEMIF_CTL_BASE, SZ_32K);
+static struct platform_device da850_evm_aemif_devices[] = {
+	{
+		.name		= "davinci_nand",
+		.id		= 1,
+		.dev		= {
+			.platform_data	= &da850_evm_nandflash_data,
+		},
+		.num_resources	= ARRAY_SIZE(da850_evm_nandflash_resource),
+		.resource	= da850_evm_nandflash_resource,
+	},
+	{
+		.name		= "physmap-flash",
+		.id		= 0,
+		.dev		= {
+			.platform_data  = &da850_evm_norflash_data,
+		},
+		.num_resources	= 1,
+		.resource	= da850_evm_norflash_resource,
+	}
+};
 
-	/* Configure data bus width of CS2 to 16 bit */
-	writel(readl(aemif_addr + DA8XX_AEMIF_CE2CFG_OFFSET) |
-		DA8XX_AEMIF_ASIZE_16BIT,
-		aemif_addr + DA8XX_AEMIF_CE2CFG_OFFSET);
+static struct aemif_platform_data da850_evm_aemif_pdata = {
+	.cs_offset = 2,
+	.abus_data = da850_evm_aemif_abus_data,
+	.num_abus_data = ARRAY_SIZE(da850_evm_aemif_abus_data),
+	.sub_devices = da850_evm_aemif_devices,
+	.num_sub_devices = ARRAY_SIZE(da850_evm_aemif_devices),
+};
 
-	iounmap(aemif_addr);
-}
+static struct platform_device da850_evm_aemif_device = {
+	.name		= "ti-aemif",
+	.id		= -1,
+	.dev = {
+		.platform_data	= &da850_evm_aemif_pdata,
+	},
+	.resource	= da850_evm_aemif_resource,
+	.num_resources	= ARRAY_SIZE(da850_evm_aemif_resource),
+};
 
 static const short da850_evm_nand_pins[] = {
 	DA850_EMA_D_0, DA850_EMA_D_1, DA850_EMA_D_2, DA850_EMA_D_3,
@@ -339,13 +351,10 @@ static inline void da850_evm_setup_nor_nand(void)
 			pr_warn("%s: NOR mux setup failed: %d\n",
 				__func__, ret);
 
-		da850_evm_init_nor();
-
-		platform_add_devices(da850_evm_devices,
-					ARRAY_SIZE(da850_evm_devices));
-
-		if (davinci_aemif_setup(&da850_evm_nandflash_device))
-			pr_warn("%s: Cannot configure AEMIF.\n", __func__);
+		ret = platform_device_register(&da850_evm_aemif_device);
+		if (ret)
+			pr_warn("%s: registering aemif failed: %d\n",
+				__func__, ret);
 	}
 }
 
-- 
2.17.1

