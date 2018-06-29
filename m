Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802F6C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3690C27C92
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="HXMSNWUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3690C27C92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966732AbeF2JmP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:42:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34902 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935774AbeF2JlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:41:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id z137-v6so1378036wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bR3ra0J3nB9yOQmIhsiBHpNBXbsCR87+f3+DqJeGKRU=;
        b=HXMSNWUYFXG2LlozwToJ1ahIrMAcIc2pkhdv3XLKwj1G1Mq+p/kIGOM3ajtp0iRg9W
         DJTv7dz1DfcHA7/qAnfnA6gYa/Nz9ovUVp8E4OcdYzVNsUGeffqa2l6XZY7Zvt5esrEe
         xOjkslX0OqhBMXrhgfZXrZzYIXQELJ79hQtkTdREnT/yRbO5wFVcMw4Ntf34ks9O1LjL
         6eDJ9VIARDlQsQlunBkr3aL6wGy6QQCIuBQfzRjuZIjpjLpFKrcopTHFUqhRAmg4dpSY
         rr0+BLEVlVvpn/S9N+KOetfoUlqeGm2fqILJl0ItExD4z/xZ+kfRptv8uuoIkXk13mge
         1xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bR3ra0J3nB9yOQmIhsiBHpNBXbsCR87+f3+DqJeGKRU=;
        b=mKTmSW65yeco7PQK4LMjbRlmmjuY5gljJYh1fLkT3hAjk7JhS0Qa6/hTDMR6Yf1WtY
         1OVMbMv4xt2QOi52x7EMsam4QFlX5+cQ0pnOUIG8GDU41I3Av3YfS3DjqNR3MT2wjLcY
         ZlGdcI3UqV7SlcI6cqbSES/l594VtB2KClhfB9rEdxF/1a0sVd1IvdxBdNJ80XQ5FGxx
         kj06Vxin2B0FpNeTY9BbBM0pZlZKYGluNZcso+L0MROfK+C8Kob882DTl64U0ahMXLdO
         tDsPXZnaRy+tWE6BE9wXl1QVsZfOFn8LvB5Bu59qwjwE9aHbTNZnhqNIYjJZAYy7oVHb
         7hhQ==
X-Gm-Message-State: APt69E0FKm9/6OE5WktfFYKn28pitXFPAr8L9p/YXZ+n6wiFX+LLsdGn
        Yxy3IFvKF4rZVPMLcRmX5jLU0g==
X-Google-Smtp-Source: AAOMgpden8xWnij+CSd0JNgGpYkcu783uc8VaFLP5mTvmznX5W2DpRJP49DRh29HDOoM4nFF1CfLRA==
X-Received: by 2002:a1c:29c5:: with SMTP id p188-v6mr1176952wmp.45.1530265261897;
        Fri, 29 Jun 2018 02:41:01 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id d102-v6sm1386394wma.10.2018.06.29.02.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 02:41:01 -0700 (PDT)
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
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 13/18] ARM: davinci: da830-evm: use device properties for at24 eeprom
Date:   Fri, 29 Jun 2018 11:40:34 +0200
Message-Id: <20180629094039.7543-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629094039.7543-1-brgl@bgdev.pl>
References: <20180629094039.7543-1-brgl@bgdev.pl>
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
2.17.1

