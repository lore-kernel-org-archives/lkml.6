Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C81C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DEB271A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Ukr4xMMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DEB271A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965140AbeF1J6Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:58:16 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44451 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965101AbeF1J6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:58:10 -0400
Received: by mail-wr0-f196.google.com with SMTP id p12-v6so4848884wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xn0TQaIyLWB0HDP/8rvd9dfNDRKBIZ2xXAWWSdTqIuQ=;
        b=Ukr4xMMA1fWmLhVPb8CFuGK9UhEbpxrgzz1XtCRg21Jh7pzh0A1+c6Y2JNWA1DegZw
         FNVioYGy9cHJk00Ov55/DjZHSrfMPgIKmdW/1/gA2jirPRNhSJ33AbDCI8C6rRlWt84I
         A2Rvy3ISbZqev9tKO6uOvuYsf+9CUn9P0QMCvnyf6gHh+4SjyqmoiEMaHCsTK6iV+QNr
         VZITRYjcolVLufsWcCZ5pFoWV2+MvIyk2WjFptSlZnjtzleT+86gHaqMN+M1AKa4mSqK
         qEeyesJ37v4Sfp8osm3LLJ3QrCdTVRS3V9Jrq01Gfiv+FF/NISsYNN2VusSaYeRWgcoP
         rjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xn0TQaIyLWB0HDP/8rvd9dfNDRKBIZ2xXAWWSdTqIuQ=;
        b=YANHcL4LsOCqmnFIMFkrggBSyGeEwwdgKNjbaqJ7Vj0hYviiz6JVqqU3O2r+pOff6k
         KtzfAUCAkuNMisHVY9PilTM5e5MP9NH/9lUs1zxsG8koiK4H6qPbZUkdN2+ApLNnmjug
         JwHzzJJYskeysg6AvWJp/BJGSrhUZ0j4x/AF7Fu4bYbBzmHl3QG3DP84T16VshBxdULw
         VtE1zoFcQrPZ3IJffygMUHRVQsSTIkLxZ6avUhst7kske0RWsOOdp3y2cSB3nRo4nXZB
         V5jswzS2Q2DgzKEekt3iUQPdCc7jnpuKJMUY1gk+tSehIl1PbzNi4io9vQDXDh3KVlof
         fgLA==
X-Gm-Message-State: APt69E2Sg2tfpdsMr0ZhGbiRMmH93A4mELfOJLNC4BvXwB5jKTghRGGQ
        mlXwhDRSuOBf8Gfm/nAhSGZnag==
X-Google-Smtp-Source: AAOMgpcDAw3vivwVxrk4i2AOASNKGtNzQawZB6oQaLW4mC1BElGDvn6cGzzPhfi957Jkc8mA8DSzPQ==
X-Received: by 2002:adf:8286:: with SMTP id 6-v6mr8009859wrc.175.1530179888901;
        Thu, 28 Jun 2018 02:58:08 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id s8-v6sm1550352wrm.84.2018.06.28.02.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 02:58:08 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 12/13] ARM: davinci: mityomapl138: use aemif platform driver
Date:   Thu, 28 Jun 2018 11:57:47 +0200
Message-Id: <20180628095748.4462-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628095748.4462-1-brgl@bgdev.pl>
References: <20180628095748.4462-1-brgl@bgdev.pl>
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

