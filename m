Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB89C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90EE2719F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ifGrXA2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90EE2719F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965099AbeF1J6J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:58:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37105 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935231AbeF1J6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:58:05 -0400
Received: by mail-wm0-f68.google.com with SMTP id n17-v6so7835808wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aAipzPKBO632NJ0duDUioMPfNkzJ+t1E0zp4HTn+o8Y=;
        b=ifGrXA2VbYFKNEGe9Zni0sDlRRi/MDSdUNmrYuAS0ArB9oUXHBLBDDy87o+UgcpBRt
         f8QLJZ0ii9lDvmA+KCUPNs1i6gMevRqOYHiVPZsEy9EQV6I8lBTBaC2Vh+KhAwFCFgkQ
         +FxcYPmn6dAdUsw9ERFQCp0IuzWyafMWxfjq0yR6iQ3Fhi4bFoQI5PFC7I33QKQ2qxhx
         MkIRClIiFeHiInkpv0Qqq2M3m5ETfVUWjoZvOppGxnweO57/PWwlY+PLCVapLT9rfS5A
         q723sgLYkTFzdCUtDpC+Lg1blg22kVwAHYEGo8e0OSihCWhcna1UrFuxYnrY/2uaHqRB
         K/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aAipzPKBO632NJ0duDUioMPfNkzJ+t1E0zp4HTn+o8Y=;
        b=sMMZrjXhyQG4WyS9qTa+pxKqDOeSC0ftNToIk++EyLY6ZqUQotXnRkitqtIbMx0ymz
         jFRnRTAc2lmnaSWkXYhdVy82TMx9kmVMOkOCB9qV4ukOhAYwXnHNIXUQlG4np5bS1xUj
         bGzFVa1r9nDwumiIKVfILZfN28e0rWxbetZHbiarq5v6dyYxDY0c5alw8ubdZWu24siX
         ba+59tz7eS5PoaZ2vrYadwPYWiH9GkZlhaP94eb57wFfGUJBtri16aWU29YPCejH6PnN
         hWukfkCEG4MULEnSknnPoQ8hpsEm+o+cuEoreDZrwX8z6vddlUMgE0GCOA6WkIkqdCx8
         8nhQ==
X-Gm-Message-State: APt69E2Jl8Dha1ggrMPnxLp56k5qhkzgS0CW66cvtBcrrvc/3aubXcC4
        Si6bT+cmaPCSav6IEas5yJyRZA==
X-Google-Smtp-Source: AAOMgpd3F0uvz3Zog5+llb/J48dSD4OPG/weQBBXg88w1Nkbizd7eK+PM1X5RkZgi118BXQNHDckPg==
X-Received: by 2002:a1c:a88a:: with SMTP id r132-v6mr6089606wme.31.1530179884469;
        Thu, 28 Jun 2018 02:58:04 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id s8-v6sm1550352wrm.84.2018.06.28.02.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 02:58:03 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 08/13] ARM: davinci: dm365-evm: use the ti-aemif soc driver
Date:   Thu, 28 Jun 2018 11:57:43 +0200
Message-Id: <20180628095748.4462-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628095748.4462-1-brgl@bgdev.pl>
References: <20180628095748.4462-1-brgl@bgdev.pl>
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

