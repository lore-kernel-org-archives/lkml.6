Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A006C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AF5271AC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KAUxG9nV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21AF5271AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935323AbeF1J7N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:59:13 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35440 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935258AbeF1J6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:58:07 -0400
Received: by mail-wr0-f196.google.com with SMTP id c13-v6so4860395wrq.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DD+tegRkL77MXGQNOF6Vh7wMcrPvGgbRls6E01LtcQY=;
        b=KAUxG9nVhpwOE6npDohIvKeIU9uaX0YQAD3Qnbf9S7LrKUyum7JrLlpZAbZ0FJZBqG
         LhZEj+cBnLqtFw/byt7jUHcxCcDzY/t8iUDz/Ffkj/GiNTGhEM48CvNwJDHwFi08j/5I
         /Ujg81yIV8PytUVHyCQ2lnCYRO169vkpHBmF+21fjOv1xJLdECciK0m/fjM75xBC30nX
         UPlRL1992Oy9BQ6wMoNfqjxjBjGQO68l7SrwMCoe30/RSqaRwdzs3MTbn//AeMnXlZfX
         SmGvNpN5HH73pW69nMewkqCnKNGj38YiYqjzKexO3VmZwrzRnLAD1Ms0VfQuhqY5Ssch
         Nbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DD+tegRkL77MXGQNOF6Vh7wMcrPvGgbRls6E01LtcQY=;
        b=l5y+c6dKUISZ18AREtWhGMUz4Hq3iSK/7b0ugMY97Dnuwyi6GPEQYGGzqpJy5viSYG
         /hV36XyePxwAObkmK1e+90dGTUJQOIex27zbF4USw9uV1IYMQc2rPanzBkhS1RZDNrIo
         Cg5r2QmBl4Ls85Q84IeNUCWRX4vX9cBN54TCZcy0Tq74sE4nUMgycsuaQA9rgUcw99w3
         bWXj49KThBU8p7Go8PHbthr5mUUN2kULBrjkv3W7AzDyzp3OAmK22vKg/Z45onwioYv0
         pY1yLMH/wjomZ7hitHCLc3teUaGsYe8jmAPkTL5RyC5jMQa8ftoMJC1cO41ntnqkdQxq
         ZiKg==
X-Gm-Message-State: APt69E2Yrd9jgIHp4Lr5dlDAjgc7xhVoL9GYqlS2nITr2oIsMuEs2AoK
        HPKG+T7Zj6bJ8bm8occ7uSIQwQ==
X-Google-Smtp-Source: AAOMgpd2pe1jtkeStc12SwIE/7ciHo/tbzukxLuHCKk/R+rKXoaTwaFMie3NzFgJfIqMlS/T0dYFnA==
X-Received: by 2002:adf:a14a:: with SMTP id r10-v6mr7952775wrr.104.1530179886538;
        Thu, 28 Jun 2018 02:58:06 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id s8-v6sm1550352wrm.84.2018.06.28.02.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 02:58:06 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 10/13] ARM: davinci: da830-evm: use aemif platform driver
Date:   Thu, 28 Jun 2018 11:57:45 +0200
Message-Id: <20180628095748.4462-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628095748.4462-1-brgl@bgdev.pl>
References: <20180628095748.4462-1-brgl@bgdev.pl>
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
index b2470141dba3..7d8ab36ff83d 100644
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
+	.id		= -1,
+	.dev = {
+		.platform_data = &da830_evm_aemif_pdata,
+	},
+	.resource	= da830_evm_aemif_resource,
+	.num_resources	= ARRAY_SIZE(da830_evm_aemif_resource),
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

