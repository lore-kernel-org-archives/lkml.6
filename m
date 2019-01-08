Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14755C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47392089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="prSU80XT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfAHJQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:16:05 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33571 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfAHJQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:16:01 -0500
Received: by mail-ed1-f68.google.com with SMTP id p6so3498442eds.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ztnUf8638FUSA3Znei2oPXxpgrZCrlfwVxJL7f5VqxM=;
        b=prSU80XT5greSTVvVxfOdqS7GZRxlEzsOboNskP7xXdW54w+/BME4EN85MiqNC7ck0
         CwUFThI7MB4Q6ikITGr7in1oMAtOpVJANUCbnae/IBMczruA4tcnj9sZLjZRSUMeI8gz
         LcFm/zxTvdkBW/KLBLcxC8thvjK7MUpb6+XnHYR/UBUhAjr4Q5cNka3oqdobmNxvYfco
         O1jKN5VEYdv/Q7NM8PTUmkmmYZHEzDkMfYB2PAOhKYt3IVtONOmV83soefGatUFWTb1k
         H3HpuNZgNwmGnynLgoSpMZVtCpBODL/ovUuWWuZ6aHQzRcRZYbZ2sQDM7M/O2+4SSNQ6
         uTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ztnUf8638FUSA3Znei2oPXxpgrZCrlfwVxJL7f5VqxM=;
        b=uNpHVUnQpxuJTfYeH5L3k7H9dLXMldlccq42rhUrzSZ952q31BXuuZSVa/ebE1z0Ok
         BZ6J85bFF0NEeIYfXkuOXoaoLf+NcfOSnF3Hh9lMTCywdpuNZ1a6BHAZHOMrg6LXsTmf
         fMshLBApODQqMSwI1qk3MKZUPIaVAs7msBk5cEUQoLkhCQ8qNnV1D5bMV81P4OG3O7RR
         4pKrO11KDw8/A6iwsRjy4/iUUOf9X0LZHBhwptxHN6p3JDBwcichaZ0FIDkUiPAOxpO6
         c0VyNNaPk410BDyy/+qsW6GjGlkbjb8EmGTjHmAnRtvpxKkpO9iKul/g9HkM1qgffyxq
         QQUQ==
X-Gm-Message-State: AJcUukej22aLQx8D6ErR7bTt3Cyp27tDMy4V+D3HasynDFplInUBVxr7
        uFUTcP/FXyHpApEEYamu01nNHQ==
X-Google-Smtp-Source: ALg8bN4QFqzh3AdeWeDBlsfg2cR86a//RrCnjhZ5x9WbdegyD1YONe6smD1jiDCacPnVszleRmXT/g==
X-Received: by 2002:a17:906:23f1:: with SMTP id j17-v6mr1180789ejg.155.1546938959455;
        Tue, 08 Jan 2019 01:15:59 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 01:15:58 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 08/12] ARM: davinci: sffsdr: use device properties for at24 eeprom
Date:   Tue,  8 Jan 2019 10:15:35 +0100
Message-Id: <20190108091539.16674-9-brgl@bgdev.pl>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 arch/arm/mach-davinci/board-sffsdr.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index acd9778ffa07..ff14de1396c8 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -26,7 +26,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/at24.h>
+#include <linux/property.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
@@ -92,16 +92,15 @@ static struct platform_device davinci_sffsdr_nandflash_device = {
 	.resource	= davinci_sffsdr_nandflash_resource,
 };
 
-static struct at24_platform_data eeprom_info = {
-	.byte_len	= (64*1024) / 8,
-	.page_size	= 32,
-	.flags		= AT24_FLAG_ADDR16,
+static const struct property_entry eeprom_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 32),
+	{ }
 };
 
 static struct i2c_board_info __initdata i2c_info[] =  {
 	{
 		I2C_BOARD_INFO("24c64", 0x50),
-		.platform_data	= &eeprom_info,
+		.properties = eeprom_properties,
 	},
 	/* Other I2C devices:
 	 * MSP430,  addr 0x23 (not used)
-- 
2.19.1

