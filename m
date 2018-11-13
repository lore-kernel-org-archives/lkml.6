Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF26C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B4C2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="qExkY58T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B4C2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388208AbeKNABJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:01:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33145 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388130AbeKNAA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id u9-v6so13460840wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oXTGXgrClMlW8LabyP51oPTHLt1d9TPP5bN7Oy9yaTQ=;
        b=qExkY58TSHKmcZ1oSE4ta3JVB/dZ7ysem4RkJ7UwxHTzIVAaaqhUGZFtX5xnJZEO7B
         W3SAjTgBoTp9oHtINAtFynUeoz0Sqjyb9mQ2TJdrO19sk+arZqmg+nkLiSartLtzhP+f
         P23j1odqmOwAr5DE1Ic/aXE4uKDvJx68JSx92otoazG1b6ObvBw2AhXK5nvHkeRkd84d
         j2B8OWBC0gSZGNAolUa8THCZ7pO3cbrHtPgWP0+LbeglVSFHL1f38OYA9N0NTX+l5JDj
         F9wBKtNYmOsZsedkleyU/+91f58h2VEKaMgSL3LJOg63TNKdkhDhygme2UDB97oCl9Xq
         733A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oXTGXgrClMlW8LabyP51oPTHLt1d9TPP5bN7Oy9yaTQ=;
        b=hE+4VU6fs6viAh8iVxrFuwcq/kovVhNFJT9VzHW6DV65TH2PfsquDzA8lOQOYzg8Yd
         Ye8DXkJmJ42PZIVmjGvawpClSBCJ/KjqSh8piUJBbADgvPrq2Q1/Q+QDGW1rQGHwfTOG
         /6Paf8NmxyywfQ2+zEED6MDDCJBjgqI5lmTHrBP7cblSJHznEHx89cDc4WrAOnzAM1GG
         N8V2vCjkBJu7fw9OPvRx1x7LrBAbanMOcmISSbGb+c8lO5xg1kGCzUD7+htf0eeyUaP1
         nPv07CUeGK40hw9o9xHYdt+dX6vj3/VRkyyxUZxMp/WKxxl+jlzGb6s9sNt7iHAiuymE
         MwMA==
X-Gm-Message-State: AGRZ1gIzPwi2yaY+Wlgsc5tPy3Lsmapt3SCrbEOGJZNS9bqiPue9Wzv1
        Itpr35wIyuhlaGy9oqf0+J9eYQ==
X-Google-Smtp-Source: AJdET5flT2RltjYvUfFa01zp/XWVLFWbb6gSf/AtfAY9TcWAKa6PTi5TTrKaXY9u4JY8vhtJ5NX6uw==
X-Received: by 2002:a5d:6405:: with SMTP id z5-v6mr4882632wru.64.1542117758021;
        Tue, 13 Nov 2018 06:02:38 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.02.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:02:37 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 24/25] ARM: davinci: mityomapl138: use device properties for at24 eeprom
Date:   Tue, 13 Nov 2018 15:01:32 +0100
Message-Id: <20181113140133.17385-25-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
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

