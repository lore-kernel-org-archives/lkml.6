Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164CEC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75F825D5C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mparmw2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75F825D5C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755335AbeFYPxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:53:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52421 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754579AbeFYPvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:51:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id p126-v6so9879069wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=faf1l9/9bHCj2vE9DzhzD9GnLDQrn+6rBW9qABWbX9U=;
        b=mparmw2JROAnPb4XGL28jK8hcrvmXs/IZVZBa3Z4wIFn3bgUWS/z6B1vi9dca2iHNG
         cag408x/lzDQGR//rfA09ugQVTyccXIbXFtesc9oSnAykoZxgcZ88MCAFeRRSOWe+Mf1
         iIvJi0QTmqKExSwfvsiQhmBIlaWOOXWSiXf2+XCJUYw657ljHMMSSyZWEc8eUrOIB9fK
         gbpooBIX1p419IoTlPxI5UhRENoMbSSgaWjSyGS+ebX3ULoX2AnWfaB2zfteq32rWVfW
         +YK9TgpHdDDfayq0HotpRlJ8AF0bMohZOwn0arQRc5VR7uSdXRpLP8ogFuKpH6K0dw2D
         I/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=faf1l9/9bHCj2vE9DzhzD9GnLDQrn+6rBW9qABWbX9U=;
        b=aCeeDABp4aW9f28HyHKoWTEkIh/e/Jon3DiVqOfAMx6+jQlE2b2D6mowtksJGhp24y
         wVKYv3q56o4OCEDj91xX4bPk6FPKhBNnm0nBhKWnyEBBRPKGs2xifR2EFPPThpFCG4fd
         A08+aUIOxWRRk7PD8SNV4cE/5goYkxuW2noDuXPYqOqtSnVpHdwF5ogSAqTf18w5z+bd
         Pq61B2z7G6Js2YmnnlnxBXUiRGz+x8I+2LQna/8T4iGXMyBz1Z7pclv0odxJYa3rXn6P
         QSzxjOJYjNeGZrau016ZUMpohNGShDDfZFHh7ZXMCwFjJXdVACwcKrMplCQOY8Uhp6/g
         3dzw==
X-Gm-Message-State: APt69E37pCaLXKAWzz2YnM7FE/s4LfA2xos2uKMtqHD69UK5I1x64mpl
        5X09jOe9qaU5yZpwAI61r9VuvQ==
X-Google-Smtp-Source: AAOMgpdSCBqt5wUKXp3Qg4xNfQ/ANh1/k+iRw1P9n5l7J0hDNBzchZv5yANdyOpb1UgxYoReU2qbhg==
X-Received: by 2002:a1c:5644:: with SMTP id k65-v6mr1540128wmb.50.1529941892131;
        Mon, 25 Jun 2018 08:51:32 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id x16-v6sm3523737wro.13.2018.06.25.08.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:51:31 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 10/14] ARM: davinci: da830-evm: use device properties for at24 eeprom
Date:   Mon, 25 Jun 2018 17:50:21 +0200
Message-Id: <20180625155025.12567-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625155025.12567-1-brgl@bgdev.pl>
References: <20180625155025.12567-1-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-da830-evm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 3be3e93f2f18..779d09581169 100644
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
@@ -419,12 +419,9 @@ static struct nvmem_cell_lookup da830_evm_mac_address_cell = {
 	.nvmem_name = "1-00500",
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
@@ -458,7 +455,7 @@ static struct pcf857x_platform_data __initdata da830_evm_ui_expander_info = {
 static struct i2c_board_info __initdata da830_evm_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
-		.platform_data	= &da830_evm_i2c_eeprom_info,
+		.properties = da830_evm_i2c_eeprom_properties,
 	},
 	{
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
-- 
2.17.1

