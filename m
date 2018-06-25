Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74387C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DD825CD2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uL1ooztA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DD825CD2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753271AbeFYPbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:31:55 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40814 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbeFYP3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:29:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id z13-v6so4324918wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2UH877besiw3Xt3tpfBHoSa8bF07wvI52ICwOieVC9c=;
        b=uL1ooztAuih0HqVAs/nkTJFDsQxch8kgBHyFkGM2Bvqi8t7eG3qavTaSg3CD5DkwRX
         MWtDbCx6HG8GvRm/xYOM/xAqER9vvazfRkg8Svo1TrzK1xV4EbPICvhbhkv5xN7yx/Ev
         TM7GshrBvPkpzXfIGfvokGAsMu0MJPP3zRpFs+bUSz6FfOc2qHXPdZWnancLim+2lV9f
         QucwysQyijhQQIQVOYM2BYJYKZegwNdB8ytZwiNQsG+HvOINmClRsZByXV6bhtsgSChr
         66tNyKVB/OOiGt8qXVeRjGUDaXIdXaL5MJqAxTxtw7pfyx3k2REnoiMiRpKSCMy4tuNq
         SLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2UH877besiw3Xt3tpfBHoSa8bF07wvI52ICwOieVC9c=;
        b=D5LXEjW74CKYDUOI+WM6uu7gV48AaQ0NjgGcF1FqV5973QHYNJkeQ4+8OSBMDyvC4N
         5jX3g2HXD9VgusNNE4+HGpTM4W42XQ4TDKzTOrgVejmUpUB/eVfYxgLSMs4AKDV61hBg
         VjUBIugufA+v5Rs7aPx3Uof3g8CeRUKuaMugURsEGMhR8HjTGemBvmCWSrGz1V7ehmXq
         JPmvtyY5FHP4MY7PPPEqTrxh4D3Iw6uxS3GsiUux//UQoVUOJh2b/erqBhEB8Wn8phlK
         /vj43GtaGQvxb2iDoIuxUuVCEUdnnS9Lv5/YVaVKEZOPooX7hATAeK4C2L11HYPUgdZ0
         GopQ==
X-Gm-Message-State: APt69E1O8gHbxXYWx0d2WwBtTMCLBfWZGVSl3+NyYAF4IZMRtgV6Cs11
        WgNGs0O5bmYukR+LTWB4hTMBqw==
X-Google-Smtp-Source: ADUXVKLI2kLZlWd/SgrFbSjvtktwAyuLx1BjvLTPLts9hq2SUi3qIX1xAosEa5n+pfHUi7cz/CXr7A==
X-Received: by 2002:a1c:4203:: with SMTP id p3-v6mr1472704wma.111.1529940592260;
        Mon, 25 Jun 2018 08:29:52 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id l15-v6sm18829174wrs.95.2018.06.25.08.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:29:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/9] ARM: davinci: omapl138-hawk: add aemif & nand support
Date:   Mon, 25 Jun 2018 17:29:13 +0200
Message-Id: <20180625152920.11549-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625152920.11549-1-brgl@bgdev.pl>
References: <20180625152920.11549-1-brgl@bgdev.pl>
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
index 466e87b24e9a..02c0f36633e9 100644
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
+	.dev = {
+		.platform_data	= &omapl138_hawk_aemif_pdata,
+	},
+	.resource	= omapl138_hawk_aemif_resource,
+	.num_resources	= ARRAY_SIZE(omapl138_hawk_aemif_resource),
+	.id		= -1,
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

