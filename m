Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260EEC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41D62088E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vJ0r2acV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41D62088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbeHHRyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:54:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54710 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbeHHRyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:54:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so3185536wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rch8KJsE+MJ0beUZglPz8x5CspIMoJnswVk3XvQsCog=;
        b=vJ0r2acVB4Nu3qPXmQW9pO5QKZOX+SwGlLyA4khrEE3dnSaQjXxpGLwc8wnnw8WpbX
         HqpKx49KnylI6lx0qm04LzWLkm7995G/rtTfD9hZ/5ovbO5Z2qgSvwiwtN6EYxv5Qsvf
         F6Apnr8/w3vY+IjhJzBR0xOeDnawxA4b9e9x6fLLtvEFiDIpn3tJ7yJROTDD/mRBjVOB
         O9LyFSa4uKGJVRTzS9XMtney42jKnmpzMBJyZIAvgBH1/9tEigkt+I1gw3HDY1WH38Uw
         vblIXEh0X4ZMV3hOFCeGp/vzLtQYmdEPRXIzl8g+ppL6+FwImtq8bLkB2gcrfJbtmy3M
         +S2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rch8KJsE+MJ0beUZglPz8x5CspIMoJnswVk3XvQsCog=;
        b=lpNuJfXk+4nvM33ECB8Y08pJd7dPKPN7rP9s8QjYu/LcXoTK47VBKMjWfPbGpIdm7j
         QCikYkPmAJVMkoun54Q2Vb0n/xgTM3StT5m6qHtnboPEw7Lx1oiqVTwz9FnWszML3c3D
         4ekvVjifyc0v5OLAlMoVHyXPXhszauCNaMhF+iqW+aadOL974BdXnDkFDHDfd47onqJh
         jEgLgeVSiKB8Su1peY8yYqPzxeVTuj2tyZGBWpM3g7B6gigvTdNWIMd5PCoJKp//NxZJ
         OqhJ5szBLa6rrkx+TssZeupRASSjp0sMP5hY1spZhze2Mj8+gThA98wD1XGd4mBY2Ux/
         JZ4g==
X-Gm-Message-State: AOUpUlEY2f4ROXjQZxrZMWtD3xC7UY9+81XRE+UgqDITJfCeWGGiUAHd
        QJrggHccTvFExzYdDwQ8/Foz+w==
X-Google-Smtp-Source: AA+uWPwz3eviP94syy6mF/DOjez6dJu8/1hZrLr2Vcp549DXnEqrfzVQF5RMbxJFvQGrCb7mFmNnZA==
X-Received: by 2002:a1c:98d6:: with SMTP id a205-v6mr2094895wme.62.1533742448491;
        Wed, 08 Aug 2018 08:34:08 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id s2-v6sm5240915wrw.52.2018.08.08.08.34.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:34:07 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 20/28] ARM: davinci: da830-evm: use device properties for at24 eeprom
Date:   Wed,  8 Aug 2018 17:31:42 +0200
Message-Id: <20180808153150.23444-21-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
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
index 4a2fe8142a2f..08a23e777eca 100644
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
2.18.0

