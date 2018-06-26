Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA17C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD47E267AB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="PQzAQTbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD47E267AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934552AbeFZJ03 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:26:29 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45061 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932629AbeFZJZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:25:55 -0400
Received: by mail-wr0-f194.google.com with SMTP id u7-v6so1194881wrn.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MJvgkDiHW4gPWvPNjt08VsbgJnWIDweim6LTyj60Vb4=;
        b=PQzAQTbw8eievQfXi/WPD9sXn9pGn5pxikfMpK7fZDleENggpZn5dCHW+eMiUq1/gz
         WYrz8I5wFdk7rFOGMQjWW2ZPdVc9d4sPnu2/iRwwFHBqucQtDew8l0HqcQdbxxJT4DbC
         Rz7HIxUF1FfeDovTeGbeobeoGZ/3dGbCigeSVpaTRzCbaANnovrTOWDUqDXQC6qdXrqq
         F+G9Ssg1c8ghhA/7+dg7+TcPSJG0L2Px7r1fXe/dZhKJ7rvhOqlnUHMNX8Rlx9e6lRXS
         4hQOkc/nSzCu9Ude2Rv5DkDun77MZmgzMwLepAJLfm3/PcKcJFGbOpxjPjW8mYRb7UYf
         9acA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MJvgkDiHW4gPWvPNjt08VsbgJnWIDweim6LTyj60Vb4=;
        b=DoWhRmbEKWMtysV7+MUgil4P2Ln4Abf95u32mzFGb+Mbb5UZZOfq1OE70t7YAy54dH
         ESqD7wyLigcJ8L70k4m5G+/DK7fZaXx2y4+pbRsbFtVNSY89YcJipK1EXt7AHdy8yd97
         89+GjiEt0ez/Y7zMOJZPiYCsvgIzaRuOLPUJVE2D4uFfn7tU071ZKVXI9BIWiGROnSKH
         StR4tg3wMG8vdRRnAU+00d0IzZFdWtRJ6d8Id9JRlJoX5pKsAGgPPtfPBoe9fBby94n2
         dv7jsSqDoV9nm8+153xfsOvKasgo6usy7YS/YjoxPc1np/8imlYRbIAuXKR1DT3Jry80
         wzlw==
X-Gm-Message-State: APt69E1ES34j+tnHqg/2PQ0eMIVS2b66zVnETh0VYOAYfo6n8ebC5Fpn
        Me1JSVgcNUjgCp2/LsEpElL4gQ==
X-Google-Smtp-Source: AAOMgpcy2FFPUjJHrSLcY95Xy9+Y3cE5VJC4fuw7zaQ2pdr2+WZDSnPfX6b6BfYj1rUefXU4yzkfLg==
X-Received: by 2002:adf:890a:: with SMTP id s10-v6mr774544wrs.122.1530005153943;
        Tue, 26 Jun 2018 02:25:53 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id a8-v6sm1528791wrn.50.2018.06.26.02.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 02:25:53 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 11/13] ARM: davinci: dm646x-evm: use aemif platform driver
Date:   Tue, 26 Jun 2018 11:25:35 +0200
Message-Id: <20180626092537.6737-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626092537.6737-1-brgl@bgdev.pl>
References: <20180626092537.6737-1-brgl@bgdev.pl>
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

