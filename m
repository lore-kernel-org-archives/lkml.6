Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C109C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054CD20868
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="IDljafRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054CD20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388053AbeKNAAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:00:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53085 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388012AbeKNAAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so12019895wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sPuMqMq9r2hIniTC2IBiHD0FDPb8NBERuqBhYrjNhTE=;
        b=IDljafRjAEOauqjxFmN1aBn6PcPzI03ubbHWQId+R0m8iLm5HwH7ZGWm8DF/0zk6D6
         8Y+9C5jWPK6BYd/oFQWB6zUQd1b3/QXbcKuqSIMX5uVo6NkhdSuofrD08F3N1cETUgOG
         mPBe4SwESiWeFOTf4A3iyKd4TbiL1rZTXAGVAY+z3658ZbFky24wuJ9dUHSUjh0tuMmU
         U5lMPlHr4gDFBSpB4fMTm/uGaDAp0TYEdwcvWNwh4oBPLexahiUYfO9nQ2484xx+INkQ
         69IcVq1iuDC/3VIuwOkkh/FGMKa0WNPB86qnO+Az1ECSQjV5pVontyGkxpVUo3a7R2Wf
         s76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sPuMqMq9r2hIniTC2IBiHD0FDPb8NBERuqBhYrjNhTE=;
        b=GE3DIQjSlmbctAfyLGn0KcKPuXIUx0Ry4E9NnlH3CvhgrQJQb/EF6g1rYBGFKlLXd3
         hWeQTq2z0IV79MXnPA6scoBRUVAnByRBrDqtnfsjLJ07iptJeiMb5c/4sVripUMI+XHm
         N/AKcv4yuSMUKXvwxYSAzKCaGuXXywqFUf4dzXjtgsVlTb3jN8qvwX4oFN/ztUWQrqVl
         TzlD08wzx2+Oq5hMLC15Q9VjctIVoOrh4cSChSUJgfNj408AA1+O/iCgkmCm6yWCjseb
         Fw3cbTcjVfmGdzSdz2I10MhOdbCcZqh/b+N94Rqum/+XxJfAqjdWypDYt20p4TnN7hSx
         fHvA==
X-Gm-Message-State: AGRZ1gLNIq8VjqTgNmdL4/xxgbvaAleyfyuKNNJq3W/1che4sJIwch/w
        ybH2fFC8ySABw7Se582oWNFHhg==
X-Google-Smtp-Source: AJdET5ffOXzcrmnj/X9DmPRLspwEQNS02Hmpuhdm53pLYF5ldj1o5KZ1HztDac1HlLqZ965HC/gAGQ==
X-Received: by 2002:a1c:38c5:: with SMTP id f188-v6mr3269738wma.19.1542117744928;
        Tue, 13 Nov 2018 06:02:24 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:02:24 -0800 (PST)
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
Subject: [PATCH v2 17/25] ARM: davinci: da830-evm: use device properties for at24 eeprom
Date:   Tue, 13 Nov 2018 15:01:25 +0100
Message-Id: <20181113140133.17385-18-brgl@bgdev.pl>
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

