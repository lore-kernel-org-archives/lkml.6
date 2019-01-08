Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36739C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AEA2089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Fu/QOCWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfAHJQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:16:31 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38275 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbfAHJQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:16:05 -0500
Received: by mail-ed1-f68.google.com with SMTP id h50so3458114ede.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oXTGXgrClMlW8LabyP51oPTHLt1d9TPP5bN7Oy9yaTQ=;
        b=Fu/QOCWKaQzM2CCroguKhoRNbbqYVmumF4ev4NEHPxj7T/7yCHXXnkIVLB0hTrpukK
         1t11LaomRucyU3qot62gzR0r9TZZAHscsL5atPEX+Ngqsj+xzuykuNkXPZjkVK/v8G5Y
         om0lBoJtgLINU53aB9oSllH3KUr19uT2CCGKp/LG0OGrXa4ermeZ20jhiKjrNcTx4FNA
         LD7MyuFMtLpw3w1vFGKSxd7Rr33nRYgCx5IhtvRzoO01e1RWawuVvfIB5XQdmxnwnmrh
         VPwt672T7X0qIPlvqwPHVNUTKby3uuhKSV5l5RP2Xrr7hGCChClmb/wgHw1bbWNJkxnJ
         mUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oXTGXgrClMlW8LabyP51oPTHLt1d9TPP5bN7Oy9yaTQ=;
        b=fC/AlAMZpA9wFI8AHoFSSqC1MFi9hOQb6RkHYfW6irWTV9oUBQTijPFkYx1nkfOEWT
         TgDzRhLLL863te7NARh57N+gNVanqwhWUhKMrwANcr+AGklTpecn+bYtsolaPfIvMJol
         OPvSbr1KAEHGPmG1bjwIy8VequucR0vIDD3nzefO7s5b9TkCPSeelYpsPrHX0R1GOS1X
         f+3axOZRWkJuk3ofegcliHHEACV0HLfhEHqGVQHKL8hhECtiDKu1bRaQf8e6RC4CQqy0
         jNEVN//fxFYy0hxuv+AMPp5hVMoacAoS1f9T2lF1FbTE/dbCmsC49vOYDdUNaZe7er/B
         BnZg==
X-Gm-Message-State: AJcUukcXx+dnnpe56sQKQg9C/cEgLBDMxXIvu3wdDJcKXMOqPT2ImFzy
        MZ6DwMxl+PanLMDXiP4S7GXDlQ==
X-Google-Smtp-Source: ALg8bN4Y0hzLVqHt9UX4a4qUt7Jtxi/praTdrf7KUCraeBLgRDkxBBiK7c3f5PBwTWZwlNSO4TE2yw==
X-Received: by 2002:aa7:de06:: with SMTP id h6mr1274531edv.137.1546938963541;
        Tue, 08 Jan 2019 01:16:03 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 01:16:03 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 11/12] ARM: davinci: mityomapl138: use device properties for at24 eeprom
Date:   Tue,  8 Jan 2019 10:15:38 +0100
Message-Id: <20190108091539.16674-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108091539.16674-1-brgl@bgdev.pl>
References: <20190108091539.16674-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to work towards phasing out the at24_platform_data structure.
There are few users and its contents can be represented using generic
device properties. Using device properties only will allow us to
significantly simplify the at24 configuration code.

Remove the at24_platform_data structure and replace it with an array
of property entries. Drop the byte_len/size property, as the model name
already implies the EEPROM's size.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index ac1a1699d185..a381b26328d8 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -14,13 +14,13 @@
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/mtd/partitions.h>
 #include <linux/notifier.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/at24.h>
 #include <linux/etherdevice.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
@@ -192,10 +192,10 @@ static struct nvmem_cell_lookup mityomapl138_nvmem_cell_lookup = {
 	.con_id		= "mac-address",
 };
 
-static struct at24_platform_data mityomapl138_fd_chip = {
-	.byte_len	= 256,
-	.page_size	= 8,
-	.flags		= AT24_FLAG_READONLY | AT24_FLAG_IRUGO,
+static const struct property_entry mityomapl138_fd_chip_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 8),
+	PROPERTY_ENTRY_BOOL("read-only"),
+	{ }
 };
 
 static struct davinci_i2c_platform_data mityomap_i2c_0_pdata = {
@@ -324,7 +324,7 @@ static struct i2c_board_info __initdata mityomap_tps65023_info[] = {
 	},
 	{
 		I2C_BOARD_INFO("24c02", 0x50),
-		.platform_data = &mityomapl138_fd_chip,
+		.properties = mityomapl138_fd_chip_properties,
 	},
 };
 
-- 
2.19.1

