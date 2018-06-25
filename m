Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2A1C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0671A25CBC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="woSPazWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0671A25CBC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbeFYPaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:30:00 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56184 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbeFYP35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:29:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so12497wmv.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=miS79Zl1c9cscJKWDTR+dBLAkOpFyzsZThlhunhRyuQ=;
        b=woSPazWjAaA2j51R2pj/If+vzahYAgqI0pJvNIZFNxwhbpe0rA/pp20OHKmDdXvUTC
         WkQxR5XazBRG28xsHMsxF3/AdFpdVhcN/jZjbLI6DsxAZS9tOcyYvy2dhrvapshaMo9B
         mqy2wA0O/wuQMPEKa9QJXh/eJp9x0aHrSld0HTG+aSPPtgiPMVOpo00H4RlTqut6IfwF
         yxfnLaGjU3wEv3mqe5z/gIeyHXykgaJeFwjUSDrDsiDPzAZhoWhGu+AM1DJ36PQdknTM
         zHZN3vBLU3POrwK9iqwG54a12iCjomfGidv/zsceZSIQkUBeMs1w/LpJjZLOr7eXcekr
         ui4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=miS79Zl1c9cscJKWDTR+dBLAkOpFyzsZThlhunhRyuQ=;
        b=YoHXZm4TbNCStszJZ/sOlDG3zuOexWB7s4gn4f/6Uk1TAhlNMTmv+jBSMC6aSJBXz4
         gSdK6u+X1SKed79YpKwOar9Ki/ZyD/fk93JysP0VpXdMJ93jRfui/gJ+ZwEmSKRUGLtM
         GpGN/VHzIUjpFgsbiAf+otbT/OI+w1fWSpGrLFaNiFVjbMRQuMUYk/V23K88i7h2aVK5
         8y1GFS4zE5F6HK15bDRa9oI2k5wm3RFyRMU6Soqkc1MJHrSVSpRCMLf8TfilIP5z02sl
         EGttyZ1HSQ7sagA1RV8TcZzdELTBFG58d6a+YkbJwXzmt28DSYJSXLg+wBgIigtOX7Cj
         /jEg==
X-Gm-Message-State: APt69E2M1rbBWxZ9Xv/UWLoaLXTgZftaeha2Q146ofi6QfAlHufMi1SR
        cCqnRq6TgTtYpMYz6iOVZwYOgA==
X-Google-Smtp-Source: AAOMgpf5nTVPEaKtxjsylB4jQMEj5m0fHN5r+s1f0/f6FzeZxSoM3vd0+5BDLzJidvSAdF9tsfdw1w==
X-Received: by 2002:a1c:5b0d:: with SMTP id p13-v6mr1407560wmb.53.1529940596579;
        Mon, 25 Jun 2018 08:29:56 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id l15-v6sm18829174wrs.95.2018.06.25.08.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:29:56 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 6/9] ARM: davinci: da830-evm: use aemif platform driver
Date:   Mon, 25 Jun 2018 17:29:17 +0200
Message-Id: <20180625152920.11549-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625152920.11549-1-brgl@bgdev.pl>
References: <20180625152920.11549-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support board files in the aemif driver. Register a platform
device instead of using the handcrafted API in da830-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c | 56 +++++++++++++++++++------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index b2470141dba3..666db3cee08a 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -28,6 +28,7 @@
 #include <linux/platform_data/mtd-davinci-aemif.h>
 #include <linux/platform_data/spi-davinci.h>
 #include <linux/platform_data/usb-davinci.h>
+#include <linux/platform_data/ti-aemif.h>
 #include <linux/regulator/machine.h>
 
 #include <asm/mach-types.h>
@@ -333,14 +334,48 @@ static struct resource da830_evm_nand_resources[] = {
 	},
 };
 
-static struct platform_device da830_evm_nand_device = {
-	.name		= "davinci_nand",
-	.id		= 1,
-	.dev		= {
-		.platform_data	= &da830_evm_nand_pdata,
+static struct platform_device da830_evm_aemif_devices[] = {
+	{
+		.name		= "davinci_nand",
+		.id		= 1,
+		.dev		= {
+			.platform_data	= &da830_evm_nand_pdata,
+		},
+		.num_resources	= ARRAY_SIZE(da830_evm_nand_resources),
+		.resource	= da830_evm_nand_resources,
+	},
+};
+
+static struct resource da830_evm_aemif_resource[] = {
+	{
+		.start	= DA8XX_AEMIF_CTL_BASE,
+		.end	= DA8XX_AEMIF_CTL_BASE + SZ_32K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct aemif_abus_data da830_evm_aemif_abus_data[] = {
+	{
+		.cs	= 3,
 	},
-	.num_resources	= ARRAY_SIZE(da830_evm_nand_resources),
-	.resource	= da830_evm_nand_resources,
+};
+
+static struct aemif_platform_data da830_evm_aemif_pdata = {
+	.abus_data		= da830_evm_aemif_abus_data,
+	.num_abus_data		= ARRAY_SIZE(da830_evm_aemif_abus_data),
+	.sub_devices		= da830_evm_aemif_devices,
+	.num_sub_devices	= ARRAY_SIZE(da830_evm_aemif_devices),
+	.cs_offset		= 2,
+};
+
+static struct platform_device da830_evm_aemif_device = {
+	.name		= "ti-aemif",
+	.dev = {
+		.platform_data = &da830_evm_aemif_pdata,
+	},
+	.resource	= da830_evm_aemif_resource,
+	.num_resources	= ARRAY_SIZE(da830_evm_aemif_resource),
+	.id		= -1,
 };
 
 /*
@@ -371,12 +406,9 @@ static inline void da830_evm_init_nand(int mux_mode)
 	if (ret)
 		pr_warn("%s: emif25 mux setup failed: %d\n", __func__, ret);
 
-	ret = platform_device_register(&da830_evm_nand_device);
+	ret = platform_device_register(&da830_evm_aemif_device);
 	if (ret)
-		pr_warn("%s: NAND device not registered\n", __func__);
-
-	if (davinci_aemif_setup(&da830_evm_nand_device))
-		pr_warn("%s: Cannot configure AEMIF\n", __func__);
+		pr_warn("%s: AEMIF device not registered\n", __func__);
 
 	gpio_direction_output(mux_mode, 1);
 }
-- 
2.17.1

