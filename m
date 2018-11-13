Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CCAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833512086A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="w014nPI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833512086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388274AbeKNACC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:02:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53406 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388057AbeKNAAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id f10-v6so12018706wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NtdPGnoNcOA+uAMeykOlFvJi5M25GSj2otU8Jlp5mq4=;
        b=w014nPI1uJ7XLo9ncewVaZ4F3wu8fqdaXRgFGCsxn5ZsTiXFGgW8T+bc8vpPfzKJx8
         g8vkxFQ2VzBmEDQ37zLwng0EVbgn0Z5b4Lr4vSmo1oQcaDy/PmrITZ/b8MXCbarvNwzP
         f/OGvH4iIKmWWo9ibBjb1LRaD43qlMciij1OCUqjM/XjMJ2nLJ8Q+mylydEHvj8l8Jgp
         7789G2xZdpCi5eYrMggu+ZglSi3o9lCnqeVYnS0X3fdFuv27r3gkPCdTNX27PPJzS5Xv
         3+vkukmuOlvhkZe2B0WlFmC/WS413912TxnPtz/uqEv19c7D2sFzO8NGpr626Nmrn3EQ
         CWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NtdPGnoNcOA+uAMeykOlFvJi5M25GSj2otU8Jlp5mq4=;
        b=QQyE9EY9As8EJeyanS9shRYyL0D+YY76BXBLJlxNbJf0kN53rETlASy7/nnp+eNI5/
         nE83wke9BpoK7YDBDt42vVG6vypM1uo7fMrj3okAo3nMCSb5AOg0anonxk1msFGqTb4d
         zEIo+5aSxIVr7Y/rbeNRxRVKHVBlJ6iZ11kiph10a+OHtck03ltvR7B7UcLALXhZT40u
         oqlK4aMs6i53yKc6ZM5Zae2MBTlW0GrBFxhBkh4NpzgFVm+rpG4yudP7Dd5gQYl0IITn
         nopl0hSsIHpcQEHQ9r76fg6lrvv/yLxc9z+4/M8yM5FwJ7XhKdVPOUCVQAeNGpzGCyFJ
         HKvg==
X-Gm-Message-State: AGRZ1gJBvRrL7I8IYCjQHsEDB8Z0A8Vq0NGluY943Xfm7rQMIoEOdLgj
        sDxJnhhXOt9X1Fz8mCbxRxR0WA==
X-Google-Smtp-Source: AJdET5fLy10Q+h27Bzq/mjdp88BBAVLtFCdLs2zd+Oh1qCRYRTe/HiO6Yxd4u0R30FeSSyuhnJgtbg==
X-Received: by 2002:a1c:730b:: with SMTP id d11-v6mr3320577wmb.107.1542117746750;
        Tue, 13 Nov 2018 06:02:26 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:02:26 -0800 (PST)
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
Subject: [PATCH v2 18/25] ARM: davinci: dm644x-evm: use device properties for at24 eeprom
Date:   Tue, 13 Nov 2018 15:01:26 +0100
Message-Id: <20181113140133.17385-19-brgl@bgdev.pl>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index e1428115067f..efe4e170e87d 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -16,8 +16,8 @@
 #include <linux/gpio/machine.h>
 #include <linux/i2c.h>
 #include <linux/platform_data/pcf857x.h>
-#include <linux/platform_data/at24.h>
 #include <linux/platform_data/gpio-davinci.h>
+#include <linux/property.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
@@ -532,12 +532,9 @@ static struct nvmem_cell_lookup dm644evm_nvmem_cell_lookup = {
 	.con_id		= "mac-address",
 };
 
-static struct at24_platform_data eeprom_info = {
-	.byte_len	= (256*1024) / 8,
-	.page_size	= 64,
-	.flags		= AT24_FLAG_ADDR16,
-	.setup          = davinci_get_mac_addr,
-	.context	= (void *)0x7f00,
+static const struct property_entry eeprom_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 64),
+	{ }
 };
 
 /*
@@ -647,7 +644,7 @@ static struct i2c_board_info __initdata i2c_info[] =  {
 	},
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
-		.platform_data	= &eeprom_info,
+		.properties = eeprom_properties,
 	},
 	{
 		I2C_BOARD_INFO("tlv320aic33", 0x1b),
-- 
2.19.1

