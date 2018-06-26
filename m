Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5805C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFF4267A5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OsGmsgvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFF4267A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934623AbeFZJ0c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:26:32 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34864 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934394AbeFZJZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:25:53 -0400
Received: by mail-wr0-f196.google.com with SMTP id c13-v6so6521371wrq.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ahqoiiTcjlh/wyXMEWUU//ONxQ8k9wdMzGQvnnctcxI=;
        b=OsGmsgvx0I1s1nugGhEtCt6LPvOsAIWBuEe1h4sWQQ2zOJv2WJcdaT/oorKcP1L15g
         cbElphsJwy5YqQd/zZqbYCLdWS2MJpli8rCYXW5Mo/7tUN5NK9F8p6spFKYRXkbBoYbM
         qXA9xtjvkeGGR+rK9yaHwcTbg0jIO9+xckP+4/gt94oxtFGi8SbfKi7IjvGMJZwZZ9RV
         X0gf5n3xe9ssK8PvTMSGuZXP3LLLRcEDnrx4Vez+0QqK5m1A6yBfampznOalDKTDClkH
         NK+9jTsysBUzz67UNXER3Bfg5YRUHE8Si8zvYf8cyypAME1gMJVUiiErc6587U3aBgFX
         eZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ahqoiiTcjlh/wyXMEWUU//ONxQ8k9wdMzGQvnnctcxI=;
        b=YmRiLGv0aJ7yaVqHErbP3OgCfdJG7UAd1MImZfbuatzT4ce2oHR08Gj1W1xsH29UDZ
         oUKxNfnZgnSlFBTCXxCTLtLsbSedkXsSrAFaShuLR4JB43QjhDiDsUPUq4xv4ohf3GQq
         yFT1QTjAtbeYliXmPfRoO+6kSTvE77TRkgMGIcIHFwAQYpU+OvS+Er2PzhTxn1jZ3Bgb
         neLTitjvUd8bkd3+enzhjZl/j9V20EWGgWsbTf1s4RfchQSvugQU7OKQY8o3tuAhhRaw
         8V7GylgZQu0ZZvtL5Fv2uS6jcFEAbaY7uDXg2H9MLK8IndZ6F9S7o+H1okUtm8hjBd6K
         JmvA==
X-Gm-Message-State: APt69E07JL3GzfBr+evnY/voSOaEX6K8lJ3JxmIzKe2NKwq4lgEWKmfJ
        BfQdnnkpcRN2WVGMOGMT2wCang==
X-Google-Smtp-Source: AAOMgpcVqvbnBzHSLGE1qVpgXdPlVIsEq9B2rFg995Dm16Lew9yfPUT65Vmy3h4qi3Vcx99LQYTovw==
X-Received: by 2002:adf:80c4:: with SMTP id 62-v6mr714949wrl.95.1530005151720;
        Tue, 26 Jun 2018 02:25:51 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id a8-v6sm1528791wrn.50.2018.06.26.02.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 02:25:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 09/13] ARM: davinci: dm644x-evm: use aemif platform driver
Date:   Tue, 26 Jun 2018 11:25:33 +0200
Message-Id: <20180626092537.6737-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626092537.6737-1-brgl@bgdev.pl>
References: <20180626092537.6737-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support board files in the aemif driver. Register a platform
device instead of using the handcrafted API in dm644x-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c | 55 ++++++++++++++++++------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 738e443ab15f..e4a8f9225d16 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -42,6 +42,7 @@
 #include <linux/platform_data/mmc-davinci.h>
 #include <linux/platform_data/usb-davinci.h>
 #include <linux/platform_data/mtd-davinci-aemif.h>
+#include <linux/platform_data/ti-aemif.h>
 
 #include "davinci.h"
 
@@ -174,14 +175,47 @@ static struct resource davinci_evm_nandflash_resource[] = {
 	},
 };
 
-static struct platform_device davinci_evm_nandflash_device = {
-	.name		= "davinci_nand",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &davinci_evm_nandflash_data,
+static struct resource davinci_evm_aemif_resource[] = {
+	{
+		.start		= DM644X_ASYNC_EMIF_CONTROL_BASE,
+		.end		= DM644X_ASYNC_EMIF_CONTROL_BASE + SZ_4K - 1,
+		.flags		= IORESOURCE_MEM,
 	},
-	.num_resources	= ARRAY_SIZE(davinci_evm_nandflash_resource),
-	.resource	= davinci_evm_nandflash_resource,
+};
+
+static struct aemif_abus_data davinci_evm_aemif_abus_data[] = {
+	{
+		.cs		= 1,
+	},
+};
+
+static struct platform_device davinci_evm_nandflash_devices[] = {
+	{
+		.name		= "davinci_nand",
+		.id		= 0,
+		.dev		= {
+			.platform_data	= &davinci_evm_nandflash_data,
+		},
+		.num_resources	= ARRAY_SIZE(davinci_evm_nandflash_resource),
+		.resource	= davinci_evm_nandflash_resource,
+	},
+};
+
+static struct aemif_platform_data davinci_evm_aemif_pdata = {
+	.abus_data = davinci_evm_aemif_abus_data,
+	.num_abus_data = ARRAY_SIZE(davinci_evm_aemif_abus_data),
+	.sub_devices = davinci_evm_nandflash_devices,
+	.num_sub_devices = ARRAY_SIZE(davinci_evm_nandflash_devices),
+};
+
+static struct platform_device davinci_evm_aemif_device = {
+	.name			= "ti-aemif",
+	.id			= -1,
+	.dev = {
+		.platform_data	= &davinci_evm_aemif_pdata,
+	},
+	.resource		= davinci_evm_aemif_resource,
+	.num_resources		= ARRAY_SIZE(davinci_evm_aemif_resource),
 };
 
 static u64 davinci_fb_dma_mask = DMA_BIT_MASK(32);
@@ -795,12 +829,7 @@ static __init void davinci_evm_init(void)
 
 		/* only one device will be jumpered and detected */
 		if (HAS_NAND) {
-			platform_device_register(&davinci_evm_nandflash_device);
-
-			if (davinci_aemif_setup(&davinci_evm_nandflash_device))
-				pr_warn("%s: Cannot configure AEMIF\n",
-					__func__);
-
+			platform_device_register(&davinci_evm_aemif_device);
 #ifdef CONFIG_I2C
 			evm_leds[7].default_trigger = "nand-disk";
 #endif
-- 
2.17.1

