Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C1BC43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8392F2183F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="I4DyHWq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfAHJRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:17:16 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35927 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbfAHJPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:15:55 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so3467733edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sPuMqMq9r2hIniTC2IBiHD0FDPb8NBERuqBhYrjNhTE=;
        b=I4DyHWq89nlR8aZjx0D2q2aocdrlMqm+kG+aFvw5KJ9VXv++ZoDBxE1IAl74cHcyyL
         EtQHjI/DLHFbuBO3/AjDqmV42fw4a2HAhICGty37EUJJaW82RYFBmjH67SfNn6ju3KJT
         DJyG+CQvP4F6ABz3Y/LO/Td/i+cRbg1o1nWeDXIGBE+0NE/RCW1EKceOq7YmCdkyx0xN
         1O2znckPFYdrLCMVb4m6n745ZnMxVCKSam1YHkyBeYZHVo9fQ9t90rjL3Lk36D+ncMqU
         Q4Orgl4USZSFhqBu3tcOacpbBS7Q9DyHevEkhy+mqgcTZHkdyuuyMVVF+1QeZ/8t/cW9
         ZfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sPuMqMq9r2hIniTC2IBiHD0FDPb8NBERuqBhYrjNhTE=;
        b=BirTtK/yrca5qDBhOcmpmrpbEA2S+nSUsUwgu2EhtYMVd0/0yPdxtObaDIHXy7ewd1
         gULm2lXf805pzoLOSoQHmpd4qR3wZAz+mZfgCvaPiLXGfLPM+1ug/NwqnEzO6xPcCUcT
         j9HOSh+GBVlgqoUNfJV89yRVdD8WtP9RtGlyfEmZttgDOsbLopkIoTM7eW6RqJ1cIzMS
         MHIsgcAJy0Cirk6tyqvDp9/9HlBLNcIkj8AbuWPmxrFpE/iexOUbNqJOJCzIIIZlVkwa
         Wu5SgJSaYazJyN622kYdTHWJ2Trfg4HwbZAloAcwxcpxhnv0LjJDFsi4oWqSVFFiZzv9
         mRbA==
X-Gm-Message-State: AJcUukefffhMRXVPVGSypEL+QRROThSA3gG5MPKinQSee+/vKprFz7vf
        HtGwg2mNALlFGZzEDKtrjR8BCw==
X-Google-Smtp-Source: ALg8bN7vQdt9vfA9gw8T0N8u72GrIInXFjQyFHqNKGgwEEwOOXm5i+Aznh5L0f1FzvV1eyhNkNUTNg==
X-Received: by 2002:a17:906:6c9:: with SMTP id v9-v6mr1190940ejb.203.1546938953822;
        Tue, 08 Jan 2019 01:15:53 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 01:15:53 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 04/12] ARM: davinci: da830-evm: use device properties for at24 eeprom
Date:   Tue,  8 Jan 2019 10:15:31 +0100
Message-Id: <20190108091539.16674-5-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-da830-evm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index e52ec1619b70..ddd871d8b44c 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -18,7 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 #include <linux/platform_data/pcf857x.h>
-#include <linux/platform_data/at24.h>
+#include <linux/property.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/spi/spi.h>
@@ -457,12 +457,9 @@ static struct nvmem_cell_lookup da830_evm_nvmem_cell_lookup = {
 	.con_id		= "mac-address",
 };
 
-static struct at24_platform_data da830_evm_i2c_eeprom_info = {
-	.byte_len	= SZ_256K / 8,
-	.page_size	= 64,
-	.flags		= AT24_FLAG_ADDR16,
-	.setup		= davinci_get_mac_addr,
-	.context	= (void *)0x7f00,
+static const struct property_entry da830_evm_i2c_eeprom_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 64),
+	{ }
 };
 
 static int __init da830_evm_ui_expander_setup(struct i2c_client *client,
@@ -496,7 +493,7 @@ static struct pcf857x_platform_data __initdata da830_evm_ui_expander_info = {
 static struct i2c_board_info __initdata da830_evm_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
-		.platform_data	= &da830_evm_i2c_eeprom_info,
+		.properties = da830_evm_i2c_eeprom_properties,
 	},
 	{
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
-- 
2.19.1

