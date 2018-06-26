Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23CDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6700267A3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="XWnKCzAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6700267A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964786AbeFZJ0e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:26:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52551 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934389AbeFZJZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:25:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id p126-v6so1053061wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aAipzPKBO632NJ0duDUioMPfNkzJ+t1E0zp4HTn+o8Y=;
        b=XWnKCzAlHQrtDGa8f6Jf9MbUczaMRZ8F1q9LPiHjhUXj/Yf2F4o0kiQASvzBh9ayl5
         DIbfarLqLplZD66kO2JjeQ+j6/SeNPv/zKsu8iGQEdyl88eUT76l0ec3KMbHp5NWM8NZ
         MiUPM7WO6VX5CxehIWMJtwY7+C2P4VIuhpbhC379/ybVnGdPUBgVCelCtEn8xgBOgYFY
         OoyAQBNzIRDM5xXzTife5WumtA7Bj6wW5bqwj2G5S8XcKhVulIVj0Fgcc/mw3UMOIjF/
         5tHxTZVv4Ou2RIwA2v0VWpDoXiTxVdyuyg8DyOiaH8cdSAK2Z1+ErSsNIuyyTdO77Wvs
         LDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aAipzPKBO632NJ0duDUioMPfNkzJ+t1E0zp4HTn+o8Y=;
        b=eErgQUS5WEr7dyC71jxxB/PchQBLUQ/9FMdGJ5LWdoMnD9gdjuEKDWRBNVRca2Ubgj
         gbptU44uJ8f2Lv/6wcIqDuxBLMT0HNRFg+U8dclsmdvFGQ6cx+IxdwFkvpUqzF9mlR3p
         S1zOGeNj1UpiteD+yRaHPiUxOY80Ybkz41QSq5YueVCTI7LzSUZHvDzDXevn+wMMyrti
         yTTBaYkX2AGB9IJ1QjeN8juxSaPuS5FqX0egR8Rv2i4xXsj9VCevEJXCq7mqhhiak4E5
         EkIfG5EvGwRvCYjd+DOFHqkSMRNKyNGbYNG0YfG8XlBaHlnU45kgZTKYIu8FxvQ9ZD6c
         wkBw==
X-Gm-Message-State: APt69E2Qki/Vr/hspfcphOlPZjH3z9396nJD0qCRA0PsAYVCv5xxsH/i
        GxixJv+VU21PtTRl6UuG97ICVHXcf+U=
X-Google-Smtp-Source: AAOMgpfMqBXCpsGq8UfqnCo7BKqMlWyhJjZMFq/3B54ysZGp2ThyQZwWsOp3VMolIVXoZVGQCgIoFQ==
X-Received: by 2002:a1c:bc3:: with SMTP id 186-v6mr1011439wml.39.1530005150656;
        Tue, 26 Jun 2018 02:25:50 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id a8-v6sm1528791wrn.50.2018.06.26.02.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 02:25:50 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 08/13] ARM: davinci: dm365-evm: use the ti-aemif soc driver
Date:   Tue, 26 Jun 2018 11:25:32 +0200
Message-Id: <20180626092537.6737-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626092537.6737-1-brgl@bgdev.pl>
References: <20180626092537.6737-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support board files in the aemif driver. Register a platform
device instead of using the handcrafted API in dm365-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c | 59 +++++++++++++++++++------
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 307e88d99dd3..8143756ff38b 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -28,6 +28,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
 #include <linux/v4l2-dv-timings.h>
+#include <linux/platform_data/ti-aemif.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -159,14 +160,47 @@ static struct resource davinci_nand_resources[] = {
 	},
 };
 
-static struct platform_device davinci_nand_device = {
-	.name			= "davinci_nand",
-	.id			= 0,
-	.num_resources		= ARRAY_SIZE(davinci_nand_resources),
-	.resource		= davinci_nand_resources,
-	.dev			= {
-		.platform_data	= &davinci_nand_data,
+static struct platform_device davinci_aemif_devices[] = {
+	{
+		.name		= "davinci_nand",
+		.id		= 0,
+		.num_resources	= ARRAY_SIZE(davinci_nand_resources),
+		.resource	= davinci_nand_resources,
+		.dev		= {
+			.platform_data	= &davinci_nand_data,
+		},
+	}
+};
+
+static struct resource davinci_aemif_resources[] = {
+	{
+		.start		= DM365_ASYNC_EMIF_CONTROL_BASE,
+		.end		= DM365_ASYNC_EMIF_CONTROL_BASE + SZ_4K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct aemif_abus_data da850_evm_aemif_abus_data[] = {
+	{
+		.cs		= 1,
+	},
+};
+
+static struct aemif_platform_data davinci_aemif_pdata = {
+	.abus_data		= da850_evm_aemif_abus_data,
+	.num_abus_data		= ARRAY_SIZE(da850_evm_aemif_abus_data),
+	.sub_devices		= davinci_aemif_devices,
+	.num_sub_devices	= ARRAY_SIZE(davinci_aemif_devices),
+};
+
+static struct platform_device davinci_aemif_device = {
+	.name			= "ti-aemif",
+	.id			= -1,
+	.dev = {
+		.platform_data	= &davinci_aemif_pdata,
 	},
+	.resource		= davinci_aemif_resources,
+	.num_resources		= ARRAY_SIZE(davinci_aemif_resources),
 };
 
 static struct at24_platform_data eeprom_info = {
@@ -537,10 +571,6 @@ static void __init evm_init_i2c(void)
 	i2c_register_board_info(1, i2c_info, ARRAY_SIZE(i2c_info));
 }
 
-static struct platform_device *dm365_evm_nand_devices[] __initdata = {
-	&davinci_nand_device,
-};
-
 static inline int have_leds(void)
 {
 #ifdef CONFIG_LEDS_CLASS
@@ -628,6 +658,7 @@ static void __init evm_init_cpld(void)
 	u8 mux, resets;
 	const char *label;
 	struct clk *aemif_clk;
+	int rc;
 
 	/* Make sure we can configure the CPLD through CS1.  Then
 	 * leave it on for later access to MMC and LED registers.
@@ -660,8 +691,10 @@ static void __init evm_init_cpld(void)
 		/* external keypad mux */
 		mux |= BIT(7);
 
-		platform_add_devices(dm365_evm_nand_devices,
-				ARRAY_SIZE(dm365_evm_nand_devices));
+		rc = platform_device_register(&davinci_aemif_device);
+		if (rc)
+			pr_warn("%s(): error registering the aemif device: %d\n",
+				__func__, rc);
 	} else {
 		/* no OneNAND support yet */
 	}
-- 
2.17.1

