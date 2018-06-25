Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36AAC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FFA25CBE
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zUmgjcRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FFA25CBE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934808AbeFYPbA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:31:00 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32976 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752327AbeFYP37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:29:59 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so12844540wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4zQ2Ecsff57oPNK/oQrXQHYveS2kALMPGI+zghtR8Pw=;
        b=zUmgjcRZvqcPFNpp4BJcwAFIjsWwhbpmhtSFeb5M8WjiV2X6s+35GUgBfOu4+PSdr7
         f2ffh1+wmSwGns3u5k2ISkTZpqnjpdFoEeN15aMuUopHx8yj1ICS2kf2cJpFZXwENMp2
         SKvNu7AzEj1p8Xz6raQ5Ef8S8htP+V+5b2wM6t5fm3CjOLHIZle7GFPkj3JpPFyV3rXB
         y+KuFCZkLOgHtXQvyDJql3/W1YJiFKfBX4GJ7YMQMmPTxcJQk+arNrNNl8k48zt4WkWc
         dxjSCQZMdXhKyOBP1YDJhvfiUwFTrOXvjkFHDojdqd30wAWMZh+Iv8JyHm09A9ZBcL0w
         FM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4zQ2Ecsff57oPNK/oQrXQHYveS2kALMPGI+zghtR8Pw=;
        b=JKkFQaGOEFh7udZ9TRXwy2Sg4KsvQorwfATKqMoa/V0Eqm2KDVoxIOBQYlrpqjhUjl
         969/0eMS61rWeUn4G5tFyetPYAr4MIwtdqZ0jsTK0KN3kQYU29dcZVNqm7SsMdQxMVXa
         6ho4r8YZGPAhpzy3bduv8HzXwfHEBFVZ/1FigKtJ+W4N/GMMpCx1ByHAw77M2HodFgBk
         FrdzBz3Lfc5PbZNZu7q1UomAklA3yUCIK2MSfgQy9dXxtLrc7Au/wsY2z1GMh9oWCGF3
         X1REVSnKk6HV5sjCTwNH8Iix+QH+s++pZTdBpBN7BjYn8lB4irlpizK3edTGRB37Kg9u
         RTiw==
X-Gm-Message-State: APt69E2JEDmrZ0Bji4pQtFes2Vvv2U4WhhWLSUxrYCy0yadbQhac4WOa
        CZzD61MA3A0a8S9uRg5BAVSB+A==
X-Google-Smtp-Source: ADUXVKK5D/ENQktU4dDz70Z1/i+qAGe85q9+vWCApdlx+dylR6iWTTiBf9QNwwsaIbE9urwCfIwHJw==
X-Received: by 2002:a1c:4203:: with SMTP id p3-v6mr1473002wma.111.1529940598679;
        Mon, 25 Jun 2018 08:29:58 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id l15-v6sm18829174wrs.95.2018.06.25.08.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:29:58 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 8/9] ARM: davinci: mityomapl138: use aemif platform driver
Date:   Mon, 25 Jun 2018 17:29:19 +0200
Message-Id: <20180625152920.11549-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625152920.11549-1-brgl@bgdev.pl>
References: <20180625152920.11549-1-brgl@bgdev.pl>
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
index 2cce0d7d2f2a..b0fdea355d96 100644
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
+	.dev = {
+		.platform_data	= &mityomapl138_aemif_pdata,
+	},
+	.resource	= mityomapl138_aemif_resources,
+	.num_resources	= ARRAY_SIZE(mityomapl138_aemif_resources),
+	.id		= -1,
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

