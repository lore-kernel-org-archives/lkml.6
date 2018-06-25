Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63281C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BB725CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oMn7VjZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BB725CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934905AbeFYPbW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:31:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34870 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752211AbeFYP3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:29:55 -0400
Received: by mail-wm0-f68.google.com with SMTP id z137-v6so4794703wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ms5Z6SLZQlg5xNASHReMwsM7T1SdKNsJ9oPGqZasbmk=;
        b=oMn7VjZ3gZtu3aRfQTLmdTiJO7t95bnlY+D0sOIxiATZTIHa7u4IqP09C9kr52PDnD
         POGpDebZLFolim6ybyxSsWCVDLCV1OXPaWZ7VJpGmge2i5kPcQ+NNjlJ020CjSWb7vDk
         //9FcUHy9omuwX8+aDruZn31xgUOWVj6eEn5OiiNsLP/Wp+cZIgs7IjSRySvlAPcEqsR
         cOEI0F/bDvTGlQKcGwEP/7/MmHwPsxYck/OoIv7rUenfNsWmuXtUPc52tOsR3s8T4a2b
         lShPLHNoRs4gDd0DNdqx2sCPEE33WM6UrweG3RB1uy5zd+8hMgLeqnYZBOlQGcN5T5P9
         nOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ms5Z6SLZQlg5xNASHReMwsM7T1SdKNsJ9oPGqZasbmk=;
        b=RugYb3fymXErqGTBeWJY7oMjjJvk9oZePR5Ww4iRehEItZ3xqbVN/ZfI7ndDUc8TsC
         wR0MF9BC2qhnNs3CgnRLb9UCzTDVx/Nb5Y1GkTyGflil3ggJPi2DzrfJABxL4dHcUkDc
         OLt9vhLYF4B/3ZKptfH4o/KTKg2xMThtLvYgPPlP+xjxFdDH5L7I4qw3KegMZGWTQQPa
         2YnhzrahBQGgnRXujJV1ucPBs3vvpnOY/GmDxUrK0DGLXa4ff9DFh+ClusvSA/rxQcb2
         MSqq2gI84cWXye7fsblHd//40uy7vRLA33eG7r5YNk8SWbaCdpGAmaSzs+tkYdsTXL5A
         +L+g==
X-Gm-Message-State: APt69E08fxN//CwzZj0E/6coYOHh3ay6EZs9mmILyOEHZrZRm0Su0MEv
        ydD1zvW0C8tHgLBplLIrl+M73Q==
X-Google-Smtp-Source: AAOMgpcQi5GtDVfkmtdszuyBxCevwt8rrVXI6cLYO53oRIiYgimPW4UnATdgCwnctsI2h6mbBrpt/A==
X-Received: by 2002:a1c:8b52:: with SMTP id n79-v6mr1391436wmd.148.1529940594421;
        Mon, 25 Jun 2018 08:29:54 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id l15-v6sm18829174wrs.95.2018.06.25.08.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:29:53 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4/9] ARM: davinci: dm365-evm: use the ti-aemif soc driver
Date:   Mon, 25 Jun 2018 17:29:15 +0200
Message-Id: <20180625152920.11549-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625152920.11549-1-brgl@bgdev.pl>
References: <20180625152920.11549-1-brgl@bgdev.pl>
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
index 307e88d99dd3..12b8d7b8c6b8 100644
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
+	.dev = {
+		.platform_data	= &davinci_aemif_pdata,
 	},
+	.resource		= davinci_aemif_resources,
+	.num_resources		= ARRAY_SIZE(davinci_aemif_resources),
+	.id			= -1,
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

