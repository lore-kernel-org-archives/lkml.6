Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581BCC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112C424A79
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jzHfC9K7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112C424A79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934956AbeFZKY5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:24:57 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45072 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934824AbeFZKXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:23:32 -0400
Received: by mail-wr0-f193.google.com with SMTP id u7-v6so1387514wrn.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vh5PxE8A0277G3WQQO6l1yJcncYmyUvGiKsoSO9LfR8=;
        b=jzHfC9K7d896Xglq0MteB8RHnC29VLbXOQmkTqzjDBsCshzWi9Q1P4FvWTiqNIGa1R
         fnvvtiNwOlToIhrZbe+hl92DvM38bUKscPnkXqr1zW+oIZYAlZm+ztxhPFtKnHQwdKAL
         AmFvj3zZpz5SLY5l6PY2s0vyVLExUr3XUBE44CdL8zIDVs6GC2fky9AvfamHN2oSMi6o
         f5rak5p5e0Z/RRXwSQuVqAshjpOnc7Y+PVi/R8+14l1p8bx9J12Strq/I2apHSl03zid
         h5NAChMEDiwix2knda8GQsxS5TJbzng2tFjahYYrGxR/wGF9Es/5deiAVPpA1LqjfxO9
         EYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vh5PxE8A0277G3WQQO6l1yJcncYmyUvGiKsoSO9LfR8=;
        b=ImJ2mWeI42RxR+1oZWHnoglTTzQ3/ktiES6V/yeA8L0henoBQ/b4iENIpm/vZkQfho
         IJHdp0ZOmR/rFz/V1po5LBmTLuOwlZZyYVoG9xQpm8WK/OfFBsJMX6bsSA22kbplRZGx
         pB66RFa7hcKvuv+QibHYBMoBQ2ppxUBqisL5oFXUWIGhLgSXRUReS52+fLa0BUlSB53v
         G0XNZ92OHk2Vf9OBthh8x4DIQr7mBnbnVygBQXXPWUsZ6wmLqV+FY7sOoNzBWtRhVmf7
         l3p96iawV3XiI2Ly7rAKwYgqa4Y7Q7nRmgIv1tvj8aigcHoTr0qbVvyf9nMbelUrRu3d
         hjeA==
X-Gm-Message-State: APt69E1nz9jPyslp4oP6xTHtPWDSQH68ebKNgb3QsjFCQI2mYikXwWgm
        cKsC6ydjzioNIEBRIXU5r9NFzw==
X-Google-Smtp-Source: AAOMgpcstc33K9uQhBPndB8AoB+3Z1EH2uELbOY6Ymrg9TAUDb9ERDj2dwOH26nVO2LPOZ6otmc8kQ==
X-Received: by 2002:adf:fed2:: with SMTP id q18-v6mr961124wrs.165.1530008611267;
        Tue, 26 Jun 2018 03:23:31 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2573852wmp.23.2018.06.26.03.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:23:30 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 11/15] ARM: davinci: dm644x-evm: use device properties for at24 eeprom
Date:   Tue, 26 Jun 2018 12:22:41 +0200
Message-Id: <20180626102245.30711-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626102245.30711-1-brgl@bgdev.pl>
References: <20180626102245.30711-1-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-dm644x-evm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index adbe8630ef19..5b26a8c5bbd8 100644
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
@@ -486,12 +486,8 @@ static struct nvmem_cell_lookup dm6446evm_mac_address_cell = {
 	.nvmem_name = "1-00500",
 };
 
-static struct at24_platform_data eeprom_info = {
-	.byte_len	= (256*1024) / 8,
-	.page_size	= 64,
-	.flags		= AT24_FLAG_ADDR16,
-	.setup          = davinci_get_mac_addr,
-	.context	= (void *)0x7f00,
+static const struct property_entry eeprom_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 64),
 };
 
 /*
@@ -601,7 +597,7 @@ static struct i2c_board_info __initdata i2c_info[] =  {
 	},
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
-		.platform_data	= &eeprom_info,
+		.properties = eeprom_properties,
 	},
 	{
 		I2C_BOARD_INFO("tlv320aic33", 0x1b),
-- 
2.17.1

