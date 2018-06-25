Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681F9C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DFA25CCA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="epDyws1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DFA25CCA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755692AbeFYPbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:31:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51989 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752141AbeFYP3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:29:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id w137-v6so4449645wmw.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8JuZK+HNNEd4fVhB8qrJxhtkuaTgbS2c20MkI2hOwNA=;
        b=epDyws1vkbBHKO4Ahy8jR88/8BhccLHoM027KKwIsypuwNvx6DioSXIX5KyZLdv2Kt
         aX5slmlAihUY2i8AioGXPpY38VzEaLjEodYIHZ0LRGowt5hUiQLyZNo3Fcs7GuA/tV2h
         daBUCCnzkiglNR1Cf19FpHiP2lh/xCwZ3sy5qMRxvbUfHq8LzmW0vC7s9OVFsGqf/Qcn
         Gz+FuETPMc2+0Ld4TvuA6ZukxuqEYzULe3D/0+z6Rb5XAffvMKvmdgGjqkl1FSQNZUnk
         golbmdMuHlVpq4oepxR3e6OyyeRRqc9Spob+U+mPpu3+XsJ4X29FLLPgnSOFS+LvQpBU
         EJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8JuZK+HNNEd4fVhB8qrJxhtkuaTgbS2c20MkI2hOwNA=;
        b=F6Gayo7sREj6gntQlKBOksTLzgO4kzfr+BIRH7EBYjG7TnDvG3gaVeENnF9eLE9IOU
         zxKN1n7v+GWYXjFCdW4x47XnQxUwHfrH/eEcp9vdWlZiz+p/7afVlgdnfbEfhp0EtC2I
         /MgWb58fZcZUgRBoBNT+mqkXBH7hcE4ixV3nlk8vi5BM1oz+B7W35O3NdY3e55ht5Z0c
         sIfuthZjyc4Cg2nvDsPviQkryxyGUwKh65oL4hrwwemYGUiVsvVLaQWMppVCOFVHCR21
         y9JLjg04GtekN6hPGpV9atKuNCt4YudcpgZUVXoZZCVRE6olGFXot4IlwODYaEA1IqLV
         J4jw==
X-Gm-Message-State: APt69E2K3/9CxDx9T3TwVzK8ASuvScpPxj515tDogOaxc+kQd2j/RnHB
        oAw8ZhkT5erFh1RwNfOaaVdLHA==
X-Google-Smtp-Source: ADUXVKJImLw3I/v2BoKISwXfCGzUNK4cxMDLg1o8dYXYy0mwei8ovqldhVBf9cTOVD01USiKNqxaLw==
X-Received: by 2002:a1c:14cc:: with SMTP id 195-v6mr1338712wmu.48.1529940593375;
        Mon, 25 Jun 2018 08:29:53 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id l15-v6sm18829174wrs.95.2018.06.25.08.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:29:52 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/9] ARM: davinci: da850-evm: use aemif platform driver in legacy mode
Date:   Mon, 25 Jun 2018 17:29:14 +0200
Message-Id: <20180625152920.11549-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625152920.11549-1-brgl@bgdev.pl>
References: <20180625152920.11549-1-brgl@bgdev.pl>
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
index 442c16773f09..0ae7c47ed2b0 100644
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
+	.dev = {
+		.platform_data	= &da850_evm_aemif_pdata,
+	},
+	.resource	= da850_evm_aemif_resource,
+	.num_resources	= ARRAY_SIZE(da850_evm_aemif_resource),
+	.id		= -1,
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

