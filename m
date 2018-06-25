Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CD9C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A6925CB5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="M3kqkFCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A6925CB5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752751AbeFYPaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:30:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37359 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752248AbeFYP34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:29:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id r125-v6so10493451wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WiqV9M76Gh7uIiyGVv/zVGJ/wBPqBjAK4YHV4jg0FP4=;
        b=M3kqkFCSe6bRY/PbE20zNLP/1xem3I5D+YfzQShygp9W1urnnmrH7V+VudIzwNHvaN
         8TZRNM6BesGBKYECkmGq8ctjeIQspnDFmalHE6sk7oUu4gS6wjVB5XaH+nRmBI6OCdKZ
         NL9QjtmHXsUHjGaVo2iOB5tcamErzT4Xb70aAGJG0VwBxouzYdCDuuzybvsqFSff8cWT
         ezMRqFL2jdRKkq1Ey0e5rd5xGIwWx8ACBhfrIR6smx+CYIeVJFxarxufRdVlBfryglnC
         Qqwq6bZGt8JN9d8AWn7rLxci4rDpACjvgjldFHPNnosquaY1HYfppuVdPCINAjsQ760k
         xR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WiqV9M76Gh7uIiyGVv/zVGJ/wBPqBjAK4YHV4jg0FP4=;
        b=rtlm2iYkUFfc3RruxMgEAXvtouWJTKxUcWDkbPo5r17GofpN0bGRQifNuwbMImn52U
         +WoXSKtnGA0UTkZO1MoTXTE0NgT8n2fqOhmTM/X5myp/kMyt6qIszSqv8k3HOzHKKrUb
         u/hPWD7ZXW7NbGNKL1KjfSqmvHEYtGPmLhQw5BnhBKgLFL3PJjvG3UEEgFL5wj3u20KW
         6vXRbRiptmxtqeZdbN1cK0WPRPHDMIL0VXB1PYRUjHAVAreJ1Rw8y7B7ALIbzxKG1DdM
         f70dYH8wlhTIlut5CJD+DwDKAZ0EZa1M5xwlcLJxVY1zLfa3ZK90HT/IdR5taFq3J7nS
         RwUw==
X-Gm-Message-State: APt69E0Xunb44+bynDomIMDED7FItvqTFODJ0toz2kS//DTDcpRO0mdo
        ikql9y0TUMh5tZFzhFOTjPsMnw==
X-Google-Smtp-Source: ADUXVKL3qVB6a1Dqug/OpVB2233TbYImjl/hMRcczbiqDb171Xs3pXfnddcUT+1UosE8qg48Ya1BKw==
X-Received: by 2002:a1c:b80a:: with SMTP id i10-v6mr1442182wmf.123.1529940595526;
        Mon, 25 Jun 2018 08:29:55 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id l15-v6sm18829174wrs.95.2018.06.25.08.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:29:54 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 5/9] ARM: davinci: dm644x-evm: use aemif platform driver
Date:   Mon, 25 Jun 2018 17:29:16 +0200
Message-Id: <20180625152920.11549-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625152920.11549-1-brgl@bgdev.pl>
References: <20180625152920.11549-1-brgl@bgdev.pl>
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
index 738e443ab15f..e3556708c71b 100644
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
+	.dev = {
+		.platform_data = &davinci_evm_aemif_pdata,
+	},
+	.resource = davinci_evm_aemif_resource,
+	.num_resources = ARRAY_SIZE(davinci_evm_aemif_resource),
+	.id = -1,
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

