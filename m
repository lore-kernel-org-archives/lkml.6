Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B47C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D67D267AC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Mg/GUTML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D67D267AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934495AbeFZJ00 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:26:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56248 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934041AbeFZJZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:25:56 -0400
Received: by mail-wm0-f68.google.com with SMTP id v16-v6so1045137wmv.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xn0TQaIyLWB0HDP/8rvd9dfNDRKBIZ2xXAWWSdTqIuQ=;
        b=Mg/GUTML7xgHHaFwRyjTiq+9FxusLfdhUJSUavvhg/SiD0DoAAxZL4w1SN3RVfsS49
         y79kb4zGgQvgF0mfHpI51mVDkxJ4Em9HN96M5OfWw1l086YyW/tdyGbRQepFb4BRKtqp
         YOXgp7m1YriQUKhyMUn1baIh/9vjfJ7S6Wbrp/90faebhRFR9nt3n0HZkOzlD1TuRXdC
         6491Pf5PhEj0h/GJJ6iV2RmWc1WbtfT1Kqtw8UeT8gdaOYRTfT/LWB0DlAFPSz1UJyrY
         6wrSVfAMiQZLa0ezzKGnD5O06yELhcRq3mDqbjnEp/xC6mTS3vJYX184hqyVeGfqkvoZ
         372w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xn0TQaIyLWB0HDP/8rvd9dfNDRKBIZ2xXAWWSdTqIuQ=;
        b=jfCfgTCYV8OtUqEgtMUWmo7Df7UN2hGbTcLqm04Qa7qgMlBx3M2rhKanmhzTgqVgCH
         yuNn3Q8PUWVi6TLAXGLklLpSZS5ss07qTs+IalhbbiBVg5PGatXMSfGsKYp71540C89d
         bbw+t/fslL2YcfDMXeLXjQ4zYN8dryq4XHFul+VLxPy726oCGlXo0y2WfVNGHH/npidB
         43i2iwnmKxKLrx9fuR1NcBL5Entd+BIDHuxjVrRQOG4PKA8E0pJDBkIb1J++pCmJmQdC
         jJyprnyLaHZiAnFrlnmvVK8scNvmwSyRH/K2K3V5+jAPZ0tbixgrDvD1Q0gvtB/rAoTt
         kJRg==
X-Gm-Message-State: APt69E2UDJItF/sZzBesiWlUl8/jiqfy0fJnitiGrf0tT6fmd+5rAN/c
        x/MurrC/FMMd7yJ1kGPXrHhO7w==
X-Google-Smtp-Source: AAOMgpeG4WHS4olZin+XJTfje4iWXAQnfalfDxbpc/LbzpMjKpwMeYjeN3OZGNJPpxBnrzkq8dyxeg==
X-Received: by 2002:a1c:d9d0:: with SMTP id q199-v6mr1000719wmg.78.1530005155070;
        Tue, 26 Jun 2018 02:25:55 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id a8-v6sm1528791wrn.50.2018.06.26.02.25.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 02:25:54 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 12/13] ARM: davinci: mityomapl138: use aemif platform driver
Date:   Tue, 26 Jun 2018 11:25:36 +0200
Message-Id: <20180626092537.6737-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626092537.6737-1-brgl@bgdev.pl>
References: <20180626092537.6737-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support board files in the aemif driver. Register a platform
device instead of using the handcrafted API in mityomapl138.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c | 55 ++++++++++++++++------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 2cce0d7d2f2a..2933e0c87cfa 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -30,6 +30,7 @@
 #include <mach/da8xx.h>
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/mtd-davinci-aemif.h>
+#include <linux/platform_data/ti-aemif.h>
 #include <mach/mux.h>
 #include <linux/platform_data/spi-davinci.h>
 
@@ -422,27 +423,53 @@ static struct resource mityomapl138_nandflash_resource[] = {
 	},
 };
 
-static struct platform_device mityomapl138_nandflash_device = {
-	.name		= "davinci_nand",
-	.id		= 1,
-	.dev		= {
-		.platform_data	= &mityomapl138_nandflash_data,
+static struct platform_device mityomapl138_aemif_devices[] = {
+	{
+		.name		= "davinci_nand",
+		.id		= 1,
+		.dev		= {
+			.platform_data	= &mityomapl138_nandflash_data,
+		},
+		.num_resources	= ARRAY_SIZE(mityomapl138_nandflash_resource),
+		.resource	= mityomapl138_nandflash_resource,
 	},
-	.num_resources	= ARRAY_SIZE(mityomapl138_nandflash_resource),
-	.resource	= mityomapl138_nandflash_resource,
 };
 
-static struct platform_device *mityomapl138_devices[] __initdata = {
-	&mityomapl138_nandflash_device,
+static struct resource mityomapl138_aemif_resources[] = {
+	{
+		.start	= DA8XX_AEMIF_CTL_BASE,
+		.end	= DA8XX_AEMIF_CTL_BASE + SZ_32K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct aemif_abus_data mityomapl138_aemif_abus_data[] = {
+	{
+		.cs	= 1,
+	},
+};
+
+static struct aemif_platform_data mityomapl138_aemif_pdata = {
+	.abus_data		= mityomapl138_aemif_abus_data,
+	.num_abus_data		= ARRAY_SIZE(mityomapl138_aemif_abus_data),
+	.sub_devices		= mityomapl138_aemif_devices,
+	.num_sub_devices	= ARRAY_SIZE(mityomapl138_aemif_devices),
+};
+
+static struct platform_device mityomapl138_aemif_device = {
+	.name		= "ti-aemif",
+	.id		= -1,
+	.dev = {
+		.platform_data	= &mityomapl138_aemif_pdata,
+	},
+	.resource	= mityomapl138_aemif_resources,
+	.num_resources	= ARRAY_SIZE(mityomapl138_aemif_resources),
 };
 
 static void __init mityomapl138_setup_nand(void)
 {
-	platform_add_devices(mityomapl138_devices,
-				 ARRAY_SIZE(mityomapl138_devices));
-
-	if (davinci_aemif_setup(&mityomapl138_nandflash_device))
-		pr_warn("%s: Cannot configure AEMIF\n", __func__);
+	if (platform_device_register(&mityomapl138_aemif_device))
+		pr_warn("%s: Cannot register AEMIF device\n", __func__);
 }
 
 static const short mityomap_mii_pins[] = {
-- 
2.17.1

