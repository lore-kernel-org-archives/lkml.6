Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53C7C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78260223F6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="i7Jvdqv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78260223F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeHJKej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:34:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50658 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbeHJKeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:34:37 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so936658wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tD44cwr7sXYWqErJJIfO3Bw2kiDKPPT7OrF4lHBn54Q=;
        b=i7Jvdqv359c3LP6OxStHLZ7WdU4oXFsEe8+hVERmjmFAEBoR8qmvSggSTMdYxFlNkC
         BCLq7T8HJOrb0i4rZQy24/Afr07dzjSmQXu4d2zbgAdXcsosxzWFMX32XPlnMGR/ZRDq
         pgXbxP7pTUzvFNsfn1YOSihDxggLE3H132nAUQbJykILNhNssDIBGFOT4/Xxj3iTKw7v
         +RNlbQbxGNpAmLAtlIhWdgNWmkqUYtl5dtuhzSVrirK1X/fr/uIWQv9Hnw4LMwWjCtcG
         lzL9KKvAsng4e7nkGXgO0WQA8luehep9Cvfbl4h//9hc15IfokThlYgIhTpe6KnqGlur
         szkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tD44cwr7sXYWqErJJIfO3Bw2kiDKPPT7OrF4lHBn54Q=;
        b=H+DCDcLEsM1k/8tHUHD8xApVpftykxZEfAXx0mZHtbcknHq4XiXfvyP7+/O3zJGarp
         clRkll4Dbz6f2vk3GpeyAzJrm9A6rpFNKZlmkaEnHvjQFqLnMN3cTYGcKXikJKGTek4y
         rv1KTjzgOGnXtmAM3JH8fFsW+KCyZRQnn/hHsuXcXluAWiQ1pA9o71ECgSMqJHdVcFou
         xt0uCygpFChlSE/yHszQVsVtvbXya3kUvGpr1UFiJ6m7Dt2zk/qawPPF7uCSsnEXvZgz
         ytjnSs8bBQ1oDJgjVOmGhxHiXD7wwtSAXEtzn4E5VVz8wabMi2HfqZwPRU8hSJHr9wOL
         X10w==
X-Gm-Message-State: AOUpUlEDwwnL+1P9di6Ib3sbJlNzj2bR/uCQ/JbP71+4cL4urNXyJIAy
        pxdIQHSNgPyxGt+eqFIkJ53rmQ==
X-Google-Smtp-Source: AA+uWPxSqDTuMTV7oYEcvCP+1ZUjY3alEqyp4JhrzX4gBH2zMvJFr39/CHVFYpBBApjiJGLbrz80DQ==
X-Received: by 2002:a1c:cf0a:: with SMTP id f10-v6mr762990wmg.32.1533888351724;
        Fri, 10 Aug 2018 01:05:51 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id h7-v6sm9546405wrs.8.2018.08.10.01.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:05:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 10/29] ARM: davinci: da830-evm: use nvmem lookup for mac address
Date:   Fri, 10 Aug 2018 10:05:07 +0200
Message-Id: <20180810080526.27207-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support nvmem lookups for machine code. Add a lookup for
mac-address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 14a6fc061744..9a055ebba081 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -21,6 +21,7 @@
 #include <linux/platform_data/at24.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/nvmem-provider.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
 #include <linux/platform_data/gpio-davinci.h>
@@ -409,6 +410,15 @@ static inline void da830_evm_init_lcdc(int mux_mode)
 static inline void da830_evm_init_lcdc(int mux_mode) { }
 #endif
 
+static struct nvmem_cell_lookup da830_evm_mac_address_cell = {
+	.info = {
+		.name = "mac-address",
+		.offset = 0x7f00,
+		.bytes = ETH_ALEN,
+	},
+	.nvmem_name = "1-00500",
+};
+
 static struct at24_platform_data da830_evm_i2c_eeprom_info = {
 	.byte_len	= SZ_256K / 8,
 	.page_size	= 64,
@@ -618,6 +628,8 @@ static __init void da830_evm_init(void)
 		pr_warn("%s: spi 0 registration failed: %d\n", __func__, ret);
 
 	regulator_has_full_constraints();
+
+	nvmem_add_lookup_table(&da830_evm_mac_address_cell, 1);
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-- 
2.18.0

