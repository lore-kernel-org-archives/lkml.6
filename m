Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5C3C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F33270F6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="dg74wn+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F33270F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935300AbeF1J6y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:58:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37115 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935264AbeF1J6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:58:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id n17-v6so7836030wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MJvgkDiHW4gPWvPNjt08VsbgJnWIDweim6LTyj60Vb4=;
        b=dg74wn+NYJwlK0qg6jZc6uAt8PlAUshd0nWRa82aP4wfk/Erb6D7ABaPlGmO/+U44U
         QCBoZQOZSxfvIVQCyOIQZcivCFsqFDW3s3gpM+7Xux6hLBO09z8NdeEse+D3OFoWT3FZ
         Sxz+Fm1x1cdnJ5wL82x7zFLwXszDkrW9HW2a+lU3GAHPy4/+Wye6LM/JNGYTQUSIysXQ
         5dTqMjcTYqJblgfDFhHo7qxXLb5MgznHX6EixTIyNMpa81z50FcIOuSQRIjdSDIVX3z2
         KITHLNor6QJjMNNw7iea4uFvsfr4GcKjeVI9eJ90GXTEXNwgaAkmbmLi+Xg37w63OimF
         uhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MJvgkDiHW4gPWvPNjt08VsbgJnWIDweim6LTyj60Vb4=;
        b=fprLrBGfkJ8KVPidbLw3FTGd5+ep6lNPGV/c0yTpgdt7JYx6TTt5kts9MD9NPFSdXf
         KE70relyJ6O7F1Rxy/VHlfn3tm5Rd0YfimhlCly2/9E7HB3sVHDUNqx5YAwBwvnRZv+c
         TWLfeUAVb4bV08NB0ChShEUnTlSyEgjguB/2Fa79+M8T0X20wFhk2pyaE0mkjgeUV9bG
         OuLFQNHzWXWiOi3+x6OzhFtr+2kFHDOWA/wEXp8MbbcAikOOaOe7L4ywddj9fuk/oNC3
         ri+RfSTqBTnUkGTyAxvHSjvh1ptfVS+nW1TMXcGcHVZ7Sv+B9ZKTnzXg0BhEmElGSmSJ
         ZIuA==
X-Gm-Message-State: APt69E2I4kb+Ef1EnuxueLXiUqbz5I71z00SrkxSIcHEDM0tNX/w+ChC
        s/w+Ys0P2k5QZP4v9b2isZXumw==
X-Google-Smtp-Source: AAOMgpdrhUx/3sDXLQ4A/KxVsu6QSWli8bxrV50V2+Kqn4AaEaCYTiOhhc6G/8XnRWD3Sb5EB064jA==
X-Received: by 2002:a1c:8893:: with SMTP id k141-v6mr7697396wmd.133.1530179887651;
        Thu, 28 Jun 2018 02:58:07 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id s8-v6sm1550352wrm.84.2018.06.28.02.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 02:58:07 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 11/13] ARM: davinci: dm646x-evm: use aemif platform driver
Date:   Thu, 28 Jun 2018 11:57:46 +0200
Message-Id: <20180628095748.4462-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628095748.4462-1-brgl@bgdev.pl>
References: <20180628095748.4462-1-brgl@bgdev.pl>
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
index 867ab2fa6cfd..3e5ee09ee717 100644
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
+	.id		= -1,
+	.dev = {
+		.platform_data	= &davinci_aemif_pdata,
 	},
+	.resource	= davinci_aemif_resources,
+	.num_resources	= ARRAY_SIZE(davinci_aemif_resources),
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

