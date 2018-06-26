Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D578AC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC7325C40
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OZpcw8s3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC7325C40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934585AbeFZJ0b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:26:31 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36995 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934152AbeFZJZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:25:54 -0400
Received: by mail-wr0-f193.google.com with SMTP id k6-v6so16470688wrp.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DD+tegRkL77MXGQNOF6Vh7wMcrPvGgbRls6E01LtcQY=;
        b=OZpcw8s3WOhiEnQDlGrRMjFedTDuF/I8JHmSFf12/YTSclsoZwVJmJZviSX83HTKWX
         37I61rzi72H5Kcx9nIX9RddKy36LbJWxtCFgKEXksHtutSDKUGa/dzz2/g9YKWzQl33B
         tW3UmO+Og5OnxPD+6zOdfkKgEhGOOXssjaIKOmeDRtBoAv5mVtVM9+Y8/Xv8yHACeaBe
         dj9/ATb6dLe6SUJDcHUrsjL7A4BsTKwm3/NJODagXR0+qa66qeeKE0W4M0xgqBNvZZmr
         Oh56gC1vPX+zI6lk39go3l+wvVMQFbrB7iUIde3ivTToye3T1r0noGDGx13K7AzxMTz2
         92Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DD+tegRkL77MXGQNOF6Vh7wMcrPvGgbRls6E01LtcQY=;
        b=NvaXfrIsDw+ABB2/L41oHdQK5VsAgEDEqVtLcVBcVNSgNykkB1oHGIp2SUHa1PPAXP
         +2YedIiLWUaTbGc+JnuN/ZKCI8dO2eyQHiWYUQGMuYeIP9ln9/Q98QZmm21X8gYhgAXH
         aBuRVKJuI0MY6fICsAcOpiqN2f8bWCaA7lfQ0whzfR1mrCmMQBxXY3iNzyeVrveKxGkz
         F8b4Ctd5/4rIoXXX4H55zAud+Uu3a44WY4UpkTIa09yFrDQrwrboqyjAXhft9zWN8EVO
         YGu/D/CzdRiJG1uUpG9qeiPcvtO+w3ugMduUrfzD9eeOwigBscXZb9mA9vZh1pnr5Hkr
         wbHw==
X-Gm-Message-State: APt69E0Yx8SSzbBpgHmEUu2lR95ab5Kkwqks2doSuhf9eEEI24QXCLHH
        L/GzCM0jZg2MzUi+vN4hfp5XzA==
X-Google-Smtp-Source: AAOMgpc367oVAjiYXtIjo/GVNimVUQHcQFbT+8roSZ6PKnwJh0a30wwTuc8wPhf9FzcJdbyvGubQaA==
X-Received: by 2002:adf:fe46:: with SMTP id m6-v6mr719675wrs.171.1530005152907;
        Tue, 26 Jun 2018 02:25:52 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id a8-v6sm1528791wrn.50.2018.06.26.02.25.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 02:25:52 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 10/13] ARM: davinci: da830-evm: use aemif platform driver
Date:   Tue, 26 Jun 2018 11:25:34 +0200
Message-Id: <20180626092537.6737-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626092537.6737-1-brgl@bgdev.pl>
References: <20180626092537.6737-1-brgl@bgdev.pl>
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

