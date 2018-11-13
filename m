Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294EEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D1D20868
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="JoZ1fiVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D1D20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388039AbeKNAAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:00:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43473 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387993AbeKNAAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id y3-v6so13412797wrh.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nCKNyyyX49gJ9CaNap8tpDC+pK+u47mv+sMMopDxMTM=;
        b=JoZ1fiVE9ZF9GTDTPgNWKBckmgnqA1IB3gWL7zEF47gEGDK1+c59xiqItVL7kGGzUy
         dpyiuUUBsS8uXZoOraEzosPpYXdotzv/aGqX1RuNtxEWdZTqa7IpQ03wq+dKz6wtOuxb
         z85vrevS5euHqqIsIGzROloIry2wZrsTpK4hqkwVhbmM5skOGrAMJIxTK5wR1D2sxYaK
         VdZ+BuGqCpooXV9vGPFfrAwk3OtNb8WrlzFxpsCcCqz710Sc4mj64K1pIV3DLuTrq6Nn
         rii9XOkFbEtRdo/Pvf4wrrPNDyTWx4J/7WC7T00ZsHOVqAmkXSjHFDB4hOogAqdhlOeJ
         +zOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nCKNyyyX49gJ9CaNap8tpDC+pK+u47mv+sMMopDxMTM=;
        b=Nb0h2uL0Qqe4WQewCENpoi4mDRqM7q632bjSJwUr5wBuJY4avj/x7ukdJDlTRvFI2+
         5EaTfbznJBklitNHPMK8oylY9atoNDsSr9KOlB+7PwNBBp9I7czru86tMpzPAGPVlQzp
         3XAJ8VEvn6Y0QX9hkAl2JejabWsiOn4WWuIy73+QxHhpGhtrgRrAhp0VLw23XOylasH6
         CKj91g7p3JZrLZF08V0u1tPtHXThJWdFBTAfRN++0CtDUUvJEqn3w8R4BGHYskxaDJWW
         1PRJtap2bQffY20mRAFxHALKJcjlY3wAYkQPgug+NLaVHGge7Sb2C8QAjSOXl+ioHnNs
         26og==
X-Gm-Message-State: AGRZ1gLewxHVHwPAof5eU7MSO10gwAowsCdedeqOHg2EPfvzABhSoHbk
        GPU1eG7uRm8fxwBpHeBsyjl/rw==
X-Google-Smtp-Source: AJdET5dx7aWCy2FTz6P99trjv8Or2uBMgv0C6q57D9QHMF9jLch6v+RP2iHksk6DIXv07QNT8LqFEQ==
X-Received: by 2002:a5d:4b05:: with SMTP id v5-v6mr5000343wrq.5.1542117743205;
        Tue, 13 Nov 2018 06:02:23 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:02:22 -0800 (PST)
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
Subject: [PATCH v2 16/25] ARM: davinci: dm365-evm: use device properties for at24 eeprom
Date:   Tue, 13 Nov 2018 15:01:24 +0100
Message-Id: <20181113140133.17385-17-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-dm365-evm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 8703fc18dd3b..f016584285b0 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -18,7 +18,7 @@
 #include <linux/i2c.h>
 #include <linux/io.h>
 #include <linux/clk.h>
-#include <linux/platform_data/at24.h>
+#include <linux/property.h>
 #include <linux/leds.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -225,18 +225,15 @@ static struct nvmem_cell_lookup davinci_nvmem_cell_lookup = {
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
 
 static struct i2c_board_info i2c_info[] = {
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
-		.platform_data	= &eeprom_info,
+		.properties = eeprom_properties,
 	},
 	{
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
-- 
2.19.1

