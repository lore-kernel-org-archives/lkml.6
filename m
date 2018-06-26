Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D59C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71507267B8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Gy/BGYMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71507267B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934049AbeFZJ2A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:28:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53845 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934379AbeFZJZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:25:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id x6-v6so1037140wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GUfHyn6VK1PqeVsGt0SkIxjoM2BJY7WdUiFWdv18igw=;
        b=Gy/BGYMSDpI/Mmofe6kQfwzE92tqDkLk/C/QS1MxeUtROqI6PypJYfI2F1HN14p2A0
         cy6xN/4/ewbHemFIJBJ8tOd3qPGcmuqEP8WE2/5ziUvA+ZN9vETSoEPZ94PfJHtHHQFX
         Z6WYToL+P/tt2GmR1VdS98M9BAzegUZd01WpwbU0f89QHEIr8QWrp9Ea9l2mYqID34cy
         DgeEFwjBUjr1idlUFHbM/S8WlLRFpuNzi81XRp6TpRMt4JA8u7z2Cn/ReXT0UZjln34H
         HQsooMObdFgTNHYD+PCpbZsbf4mcQH/L8sPzoeEbuJnGIsNKEZ9QK/vhzS6GWGwxm8E3
         LFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GUfHyn6VK1PqeVsGt0SkIxjoM2BJY7WdUiFWdv18igw=;
        b=Ua+MtcrQOleCI9dz8oxP0D5kNSbCDReQ8LMPP2a41BT+Sh5RBd6woEPRg5IY2W2d4s
         EQodKUlc9RGJos57NtnGz05l5ebp4w6zdJ6VHSW+qYCMRjyQndYAmu/5aZvgOxI6aIZj
         8HhyWxL/BifjrYhlxCiBZLJQCdWTMuptnsXoouzWrkyqhMestXiFCGFIJB+FW4wARdVZ
         CEqvFrc2IHZk/o3aUReh1w4arIXVdrcbkqp8ghNtaAPwe1le2Fxtb8y/iMLcqH9o97fg
         iYT6UFFJWZZjOD8zAnVBqktn8cao5Z8wZVFVMkZrwO6GcN4O39gSVaNiIeP/+b2mrsxM
         qQ/g==
X-Gm-Message-State: APt69E0I0BQxJKXT9iFtkxHKSc1hA5+X1FBR68HA8Q88fpHPPdPZDSwv
        mtXb5Vj0IAxuEjaPmPVyXJ055g==
X-Google-Smtp-Source: AAOMgpe1gbMhQo6ZH8kZCe/ZROVLmB10lmy7ko/4WTExKpgmzMKDI3nIVQNkcY3v8tl3Jx5zeWQ9oA==
X-Received: by 2002:a1c:ca01:: with SMTP id a1-v6mr988375wmg.128.1530005148536;
        Tue, 26 Jun 2018 02:25:48 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id a8-v6sm1528791wrn.50.2018.06.26.02.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 02:25:47 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 06/13] ARM: davinci: omapl138-hawk: add aemif & nand support
Date:   Tue, 26 Jun 2018 11:25:30 +0200
Message-Id: <20180626092537.6737-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626092537.6737-1-brgl@bgdev.pl>
References: <20180626092537.6737-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now have support for aemif & nand from board files. As an example
add support for nand to da850-hawk.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-omapl138-hawk.c | 132 ++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 466e87b24e9a..8d8e3165a45c 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -16,6 +16,11 @@
 #include <linux/gpio.h>
 #include <linux/gpio/machine.h>
 #include <linux/platform_data/gpio-davinci.h>
+#include <linux/platform_data/ti-aemif.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/platform_data/mtd-davinci.h>
+#include <linux/platform_data/mtd-davinci-aemif.h>
 #include <linux/regulator/machine.h>
 
 #include <asm/mach-types.h>
@@ -166,6 +171,129 @@ static __init void omapl138_hawk_mmc_init(void)
 	gpiod_remove_lookup_table(&mmc_gpios_table);
 }
 
+static struct mtd_partition omapl138_hawk_nandflash_partition[] = {
+	{
+		.name		= "u-boot env",
+		.offset		= 0,
+		.size		= SZ_128K,
+		.mask_flags	= MTD_WRITEABLE,
+	 },
+	{
+		.name		= "u-boot",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= SZ_512K,
+		.mask_flags	= MTD_WRITEABLE,
+	},
+	{
+		.name		= "free space",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= MTDPART_SIZ_FULL,
+		.mask_flags	= 0,
+	},
+};
+
+static struct davinci_aemif_timing omapl138_hawk_nandflash_timing = {
+	.wsetup		= 24,
+	.wstrobe	= 21,
+	.whold		= 14,
+	.rsetup		= 19,
+	.rstrobe	= 50,
+	.rhold		= 0,
+	.ta		= 20,
+};
+
+static struct davinci_nand_pdata omapl138_hawk_nandflash_data = {
+	.core_chipsel	= 1,
+	.parts		= omapl138_hawk_nandflash_partition,
+	.nr_parts	= ARRAY_SIZE(omapl138_hawk_nandflash_partition),
+	.ecc_mode	= NAND_ECC_HW,
+	.ecc_bits	= 4,
+	.bbt_options	= NAND_BBT_USE_FLASH,
+	.options	= NAND_BUSWIDTH_16,
+	.timing		= &omapl138_hawk_nandflash_timing,
+	.mask_chipsel	= 0,
+	.mask_ale	= 0,
+	.mask_cle	= 0,
+};
+
+static struct resource omapl138_hawk_nandflash_resource[] = {
+	{
+		.start	= DA8XX_AEMIF_CS3_BASE,
+		.end	= DA8XX_AEMIF_CS3_BASE + SZ_32M,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= DA8XX_AEMIF_CTL_BASE,
+		.end	= DA8XX_AEMIF_CTL_BASE + SZ_32K,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct resource omapl138_hawk_aemif_resource[] = {
+	{
+		.start	= DA8XX_AEMIF_CTL_BASE,
+		.end	= DA8XX_AEMIF_CTL_BASE + SZ_32K,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
+static struct aemif_abus_data omapl138_hawk_aemif_abus_data[] = {
+	{
+		.cs	= 3,
+	}
+};
+
+static struct platform_device omapl138_hawk_aemif_devices[] = {
+	{
+		.name		= "davinci_nand",
+		.id		= 1,
+		.dev		= {
+			.platform_data	= &omapl138_hawk_nandflash_data,
+		},
+		.resource	= omapl138_hawk_nandflash_resource,
+		.num_resources	= ARRAY_SIZE(omapl138_hawk_nandflash_resource),
+	}
+};
+
+static struct aemif_platform_data omapl138_hawk_aemif_pdata = {
+	.cs_offset = 2,
+	.abus_data = omapl138_hawk_aemif_abus_data,
+	.num_abus_data = ARRAY_SIZE(omapl138_hawk_aemif_abus_data),
+	.sub_devices = omapl138_hawk_aemif_devices,
+	.num_sub_devices = ARRAY_SIZE(omapl138_hawk_aemif_devices),
+};
+
+static struct platform_device omapl138_hawk_aemif_device = {
+	.name		= "ti-aemif",
+	.id		= -1,
+	.dev = {
+		.platform_data	= &omapl138_hawk_aemif_pdata,
+	},
+	.resource	= omapl138_hawk_aemif_resource,
+	.num_resources	= ARRAY_SIZE(omapl138_hawk_aemif_resource),
+};
+
+static const short omapl138_hawk_nand_pins[] = {
+	DA850_EMA_WAIT_1, DA850_NEMA_OE, DA850_NEMA_WE, DA850_NEMA_CS_3,
+	DA850_EMA_D_0, DA850_EMA_D_1, DA850_EMA_D_2, DA850_EMA_D_3,
+	DA850_EMA_D_4, DA850_EMA_D_5, DA850_EMA_D_6, DA850_EMA_D_7,
+	DA850_EMA_D_8, DA850_EMA_D_9, DA850_EMA_D_10, DA850_EMA_D_11,
+	DA850_EMA_D_12, DA850_EMA_D_13, DA850_EMA_D_14, DA850_EMA_D_15,
+	DA850_EMA_A_1, DA850_EMA_A_2,
+	-1
+};
+
+static int omapl138_hawk_register_aemif(void)
+{
+	int ret;
+
+	ret = davinci_cfg_reg_list(omapl138_hawk_nand_pins);
+	if (ret)
+		pr_warn("%s: NAND mux setup failed: %d\n", __func__, ret);
+
+	return platform_device_register(&omapl138_hawk_aemif_device);
+}
+
 static irqreturn_t omapl138_hawk_usb_ocic_irq(int irq, void *dev_id);
 static da8xx_ocic_handler_t hawk_usb_ocic_handler;
 
@@ -298,6 +426,10 @@ static __init void omapl138_hawk_init(void)
 
 	omapl138_hawk_usb_init();
 
+	ret = omapl138_hawk_register_aemif();
+	if (ret)
+		pr_warn("%s: aemif registration failed: %d\n", __func__, ret);
+
 	ret = da8xx_register_watchdog();
 	if (ret)
 		pr_warn("%s: watchdog registration failed: %d\n",
-- 
2.17.1

