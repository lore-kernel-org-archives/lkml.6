Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE9DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E9922419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="WDK4EXYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E9922419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbeKNAAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:00:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41404 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388071AbeKNAAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id v18-v6so13443494wrt.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hh5b2k/7h0Wkn2rLn6NIi7mvwMbeZ/cPsG4EAD277Kg=;
        b=WDK4EXYCVbg5UVTt1LLa9JA2tefJbGBaRGYu4BQMHUTVwo9nrZI/x2Pg9f2m6SfJqi
         gXZZE1ZXbYo4CxQKosHQtqkTQO5nZIzNSHtUS0IFQC18X7RvFcQjkpQW2uJ0GLMCwuUj
         AJ+BFW67RMtcYQUKm8llOhqDviNNsM5NY87UcplZWCENknMzcJt76olth3ghcb7bmcOv
         ot/W6azDogQYZHpmIqsZirtRURlBAZbUN2rYh9tH5KqFQ4F8nhcM+vlrnxP35T5IH5Yh
         h8Tvd8sXrlMymXWdCXXHobgUx8FJ6iUUW9fNUiDB8dpmMsTl78IBPpVY3AZU6M54XEEs
         O3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hh5b2k/7h0Wkn2rLn6NIi7mvwMbeZ/cPsG4EAD277Kg=;
        b=OxDApZtC3Cgx5QjpXtlofBPqmB35BawxOw/rcbgf287jgM31ljdSuKCQ5WdqtIbTYt
         dDTGXBnSL4pwH+HO/JlrHj882fA3JMTMgwbnlwVz1iIC3aXEnQFyvIgePpi9V0/9qq8w
         R4oskv4QALc5SfMeMhggLAJnLG391xwNYftdeh3lYIzh6nAzIaeeBtZVVPsWJHJoU/zY
         m/C+AhzDVmo46GZ/pu16SWQW28PBbCB3RB5U+ZOec485sT7JwG6QZIqcQEmnlPiMPsOs
         h+33lUycWraTYhDplgB6FpJNo8aQSLe3qfvPbfsfX2nc7F56xsPKCBzC1/hD6H7Ao60K
         yfBg==
X-Gm-Message-State: AGRZ1gKwuA6HBjtCOq6PNvwr1GK9VIppnVIboPp1w5xF0zdf9mVSX/ia
        ZkydBU97CVZ+wrkRAoh6po4LKg==
X-Google-Smtp-Source: AJdET5cMvvcmsFaY7r8GYj7Me90MKajqiYiB22Zb0Nu3oX9oxsFP2cXbd1d6owPbeGt/U3pul0Qp/Q==
X-Received: by 2002:adf:e543:: with SMTP id z3-v6mr2568196wrm.238.1542117748660;
        Tue, 13 Nov 2018 06:02:28 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:02:28 -0800 (PST)
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
Subject: [PATCH v2 19/25] ARM: davinci: dm646x-evm: use device properties for at24 eeprom
Date:   Tue, 13 Nov 2018 15:01:27 +0100
Message-Id: <20181113140133.17385-20-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-dm646x-evm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 8d5be6dd2019..02b57face113 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -22,7 +22,7 @@
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/at24.h>
+#include <linux/property.h>
 #include <linux/platform_data/pcf857x.h>
 #include <linux/platform_data/ti-aemif.h>
 
@@ -364,12 +364,9 @@ static struct nvmem_cell_lookup dm646x_evm_nvmem_cell_lookup = {
 	.con_id		= "mac-address",
 };
 
-static struct at24_platform_data eeprom_info = {
-	.byte_len       = (256*1024) / 8,
-	.page_size      = 64,
-	.flags          = AT24_FLAG_ADDR16,
-	.setup          = davinci_get_mac_addr,
-	.context	= (void *)0x7f00,
+static const struct property_entry eeprom_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 64),
+	{ }
 };
 #endif
 
@@ -440,7 +437,7 @@ static void evm_init_cpld(void)
 static struct i2c_board_info __initdata i2c_info[] =  {
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
-		.platform_data  = &eeprom_info,
+		.properties  = eeprom_properties,
 	},
 	{
 		I2C_BOARD_INFO("pcf8574a", 0x38),
-- 
2.19.1

