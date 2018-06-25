Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A76C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F401525CB5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yy90DSrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F401525CB5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753170AbeFYPaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:30:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52000 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752305AbeFYP36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:29:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id w137-v6so4449914wmw.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4HAy4CFX12smc0TnD2wG3IULi/54eoKnvvMUZ/d29ys=;
        b=yy90DSrTj2fc+se71/phGT+Bi0iqLgeH+47AgNXRMDFRo5nlsZlI6V8D2BglJlPof0
         ZmR6LNIyizmB3QB5s88o1EFfLY76gtgqr1TXU0r3PTmAtsdRnH0Mie39TjiSB5AWuLUk
         gEdza/vO0zlxoOt2baADuQMKbxtnBhwRG8iM2YwnrqsRQwpDSXmBfqmnRgU3HfTgtq5G
         twfziKYa6rPaoVJ3BUwW4wnvyICn+9ag8d4nSuYzLZ600o7eYomLzidHnSNw89yAAOtq
         /jJjrObJUlmw+unZ8LtfhDA2ue3A6hfz0rFMXEW/izzPlU8rwxnfUhIX8vOj5znMvRqu
         0Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4HAy4CFX12smc0TnD2wG3IULi/54eoKnvvMUZ/d29ys=;
        b=J58/KNNTlIPYUmfpIzt/Mg9fzbni+/4jBpOV9k+9DmfCHdl9d7yKkGxqQqs3eWxG5B
         C17FyKcxvcn3mrwI2dGKeChDIRdEolI+zrcZfLvYBpzDesx5w4DxFF5cNGmpdRUJ6wX0
         Y9oGMMweEfDLZPyay70HysFQild7YxqrD8dVTwTJh8zlv0FmnOyxN+wmFZhVmoY7FSxH
         LJbKKGnaccqXaG/ofe0Ha1KsERlh8jUcT78WDxzgTIqM+RS5z3Js+fH52VwDVnV8Ojgd
         WZ/IE7ZZcl2AIqNyjtwi6rx6Lx9A7O4lX5MV45VGyR4PNw32XXn5nxrfv8YlRfTrhB9D
         82WA==
X-Gm-Message-State: APt69E3+EnYEcuLDY6+o8JUU7B+OX81IV3h2eLjqdG24wGOkauJtdJzx
        TyRyIaIVVmfVAHS8HJt8V19GUnwu3Pw=
X-Google-Smtp-Source: AAOMgpedQ5dk47B4slfXXD4+Fsl+JjrfVb01jcZ7D6Sl4FLyy1cEs/SEZaGjSqff3xkNf8V5h6AdIA==
X-Received: by 2002:a1c:ea4a:: with SMTP id i71-v6mr1302968wmh.158.1529940597620;
        Mon, 25 Jun 2018 08:29:57 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id l15-v6sm18829174wrs.95.2018.06.25.08.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:29:57 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 7/9] ARM: davinci: dm646x-evm: use aemif platform driver
Date:   Mon, 25 Jun 2018 17:29:18 +0200
Message-Id: <20180625152920.11549-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625152920.11549-1-brgl@bgdev.pl>
References: <20180625152920.11549-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support board files in the aemif driver. Register a platform
device instead of using the handcrafted API in dm646x-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-dm646x-evm.c | 52 +++++++++++++++++++-----
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 867ab2fa6cfd..99297e0612ba 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -24,6 +24,7 @@
 #include <linux/i2c.h>
 #include <linux/platform_data/at24.h>
 #include <linux/platform_data/pcf857x.h>
+#include <linux/platform_data/ti-aemif.h>
 
 #include <media/i2c/tvp514x.h>
 #include <media/i2c/adv7343.h>
@@ -106,16 +107,47 @@ static struct resource davinci_nand_resources[] = {
 	},
 };
 
-static struct platform_device davinci_nand_device = {
-	.name			= "davinci_nand",
-	.id			= 0,
+static struct platform_device davinci_aemif_devices[] = {
+	{
+		.name		= "davinci_nand",
+		.id		= 0,
+		.num_resources	= ARRAY_SIZE(davinci_nand_resources),
+		.resource	= davinci_nand_resources,
+		.dev		= {
+			.platform_data	= &davinci_nand_data,
+		},
+	},
+};
+
+static struct resource davinci_aemif_resources[] = {
+	{
+		.start	= DM646X_ASYNC_EMIF_CONTROL_BASE,
+		.end	= DM646X_ASYNC_EMIF_CONTROL_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
 
-	.num_resources		= ARRAY_SIZE(davinci_nand_resources),
-	.resource		= davinci_nand_resources,
+static struct aemif_abus_data davinci_aemif_abus_data[] = {
+	{
+		.cs	= 1,
+	},
+};
 
-	.dev			= {
-		.platform_data	= &davinci_nand_data,
+static struct aemif_platform_data davinci_aemif_pdata = {
+	.abus_data		= davinci_aemif_abus_data,
+	.num_abus_data		= ARRAY_SIZE(davinci_aemif_abus_data),
+	.sub_devices		= davinci_aemif_devices,
+	.num_sub_devices	= ARRAY_SIZE(davinci_aemif_devices),
+};
+
+static struct platform_device davinci_aemif_device = {
+	.name		= "ti-aemif",
+	.dev = {
+		.platform_data	= &davinci_aemif_pdata,
 	},
+	.resource	= davinci_aemif_resources,
+	.num_resources	= ARRAY_SIZE(davinci_aemif_resources),
+	.id		= -1,
 };
 
 #define HAS_ATA		(IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710) || \
@@ -793,10 +825,8 @@ static __init void evm_init(void)
 	if (machine_is_davinci_dm6467tevm())
 		davinci_nand_data.timing = &dm6467tevm_nandflash_timing;
 
-	platform_device_register(&davinci_nand_device);
-
-	if (davinci_aemif_setup(&davinci_nand_device))
-		pr_warn("%s: Cannot configure AEMIF.\n", __func__);
+	if (platform_device_register(&davinci_aemif_device))
+		pr_warn("%s: Cannot register AEMIF device.\n", __func__);
 
 	dm646x_init_edma(dm646x_edma_rsv);
 
-- 
2.17.1

