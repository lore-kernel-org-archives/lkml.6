Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A448CC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B49A271A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="j6SLFUgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B49A271A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935340AbeF1J7P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:59:15 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46806 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935134AbeF1J6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:58:06 -0400
Received: by mail-wr0-f194.google.com with SMTP id t6-v6so4838795wrq.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ahqoiiTcjlh/wyXMEWUU//ONxQ8k9wdMzGQvnnctcxI=;
        b=j6SLFUgVHHRJpbH5ihivwb9rD7uFTMGfc/GXU/rCRMTSx+hbT1h0h5wbR1d8+xHeuw
         mdXxeKs6gKyZDpTIhyfCBwq4JDemRfYZpdA6675JNtOUpv1lip93AzM7rsnS499FBjVC
         dBiQQwJr0VI6NIEdX+Hf6NCpIMc/pVdGg5JjCAwD+lwL7wBfYNAQCFaOWwyZQQCixT2S
         gkV2FXc5YQarEap1Myi8SZe7TsmgC0jnGPSQZUCunJuKChSI21a1Eb8sf9zNWE+5YX4u
         4QkyOgziMHI0GjwQtghP8Kg3AHqvdKOEXGMUYeqP6aEVJ/1tqjBdg357n+hnpf2WDyGE
         DXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ahqoiiTcjlh/wyXMEWUU//ONxQ8k9wdMzGQvnnctcxI=;
        b=qwx/7uSOjaLiUMgKUhQyE83EhQ+I/dhux1RFZpqbYZudShcjpFRUrHerMz/eQXI2MP
         K6ianzxXrRPopDPmyPG5F0K+JT3/T1KzAnMorC47IZF541LRV5ewYVzdfTSjf6wpTxkF
         sGSoQIQl8Z44cyu3IA2/f04g34Uj0Z+jResyqTqQkn7s6joGt18UjjQQO9hm++YgD1or
         TH6maPAdCN+aRkR3SmI118W6+j3ijSRosd+gA3Dra0MHFiv+jdf9z4vsOLjv7adbC0KI
         KhXwYmVDRPk1Oy0FsYpq5FE6/amDt15jRZvI8MEmGXa02B13p19o5ljpCxmEJppum28E
         b1sg==
X-Gm-Message-State: APt69E0MYJ/OgFADQcjg/nvIWvX35bXkQcUQMz/VxjwOYtEQIqGqh8/C
        HDITv+GH3B/MS+RQiscnC08uaA==
X-Google-Smtp-Source: AAOMgpcWJUWXA2ioMHNnXFqbr5swL4piByWtP7qaLCZh5nue9hHHmteO7qX2npx2mTVxDG3IFSmKuQ==
X-Received: by 2002:adf:e207:: with SMTP id j7-v6mr8125988wri.205.1530179885537;
        Thu, 28 Jun 2018 02:58:05 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id s8-v6sm1550352wrm.84.2018.06.28.02.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 02:58:04 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 09/13] ARM: davinci: dm644x-evm: use aemif platform driver
Date:   Thu, 28 Jun 2018 11:57:44 +0200
Message-Id: <20180628095748.4462-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628095748.4462-1-brgl@bgdev.pl>
References: <20180628095748.4462-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support board files in the aemif driver. Register a platform
device instead of using the handcrafted API in dm644x-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c | 55 ++++++++++++++++++------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 738e443ab15f..e4a8f9225d16 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -42,6 +42,7 @@
 #include <linux/platform_data/mmc-davinci.h>
 #include <linux/platform_data/usb-davinci.h>
 #include <linux/platform_data/mtd-davinci-aemif.h>
+#include <linux/platform_data/ti-aemif.h>
 
 #include "davinci.h"
 
@@ -174,14 +175,47 @@ static struct resource davinci_evm_nandflash_resource[] = {
 	},
 };
 
-static struct platform_device davinci_evm_nandflash_device = {
-	.name		= "davinci_nand",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &davinci_evm_nandflash_data,
+static struct resource davinci_evm_aemif_resource[] = {
+	{
+		.start		= DM644X_ASYNC_EMIF_CONTROL_BASE,
+		.end		= DM644X_ASYNC_EMIF_CONTROL_BASE + SZ_4K - 1,
+		.flags		= IORESOURCE_MEM,
 	},
-	.num_resources	= ARRAY_SIZE(davinci_evm_nandflash_resource),
-	.resource	= davinci_evm_nandflash_resource,
+};
+
+static struct aemif_abus_data davinci_evm_aemif_abus_data[] = {
+	{
+		.cs		= 1,
+	},
+};
+
+static struct platform_device davinci_evm_nandflash_devices[] = {
+	{
+		.name		= "davinci_nand",
+		.id		= 0,
+		.dev		= {
+			.platform_data	= &davinci_evm_nandflash_data,
+		},
+		.num_resources	= ARRAY_SIZE(davinci_evm_nandflash_resource),
+		.resource	= davinci_evm_nandflash_resource,
+	},
+};
+
+static struct aemif_platform_data davinci_evm_aemif_pdata = {
+	.abus_data = davinci_evm_aemif_abus_data,
+	.num_abus_data = ARRAY_SIZE(davinci_evm_aemif_abus_data),
+	.sub_devices = davinci_evm_nandflash_devices,
+	.num_sub_devices = ARRAY_SIZE(davinci_evm_nandflash_devices),
+};
+
+static struct platform_device davinci_evm_aemif_device = {
+	.name			= "ti-aemif",
+	.id			= -1,
+	.dev = {
+		.platform_data	= &davinci_evm_aemif_pdata,
+	},
+	.resource		= davinci_evm_aemif_resource,
+	.num_resources		= ARRAY_SIZE(davinci_evm_aemif_resource),
 };
 
 static u64 davinci_fb_dma_mask = DMA_BIT_MASK(32);
@@ -795,12 +829,7 @@ static __init void davinci_evm_init(void)
 
 		/* only one device will be jumpered and detected */
 		if (HAS_NAND) {
-			platform_device_register(&davinci_evm_nandflash_device);
-
-			if (davinci_aemif_setup(&davinci_evm_nandflash_device))
-				pr_warn("%s: Cannot configure AEMIF\n",
-					__func__);
-
+			platform_device_register(&davinci_evm_aemif_device);
 #ifdef CONFIG_I2C
 			evm_leds[7].default_trigger = "nand-disk";
 #endif
-- 
2.17.1

