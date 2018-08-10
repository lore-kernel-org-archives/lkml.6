Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001EFC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02B6223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KphW5zAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02B6223F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbeHJKgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:36:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44596 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbeHJKe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:34:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so7438443wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jx2k6guhhdaGBfaejTqdRGnDImbwefudlSdHFEKHg9Q=;
        b=KphW5zAK8TCeq5wOZ4AZmk1aBXf+mnTJA/OPbH2dTCGSe6mBs9y494lmnUisszbBtk
         mEIP6Oh7f/vXblqr/icAdT4N57BN2hM9Osa1BebjVyMl6YoBqpEmWWRXaffx5lTcf7qm
         x+ejkZtVGmYGEoEkKdzOham31doDtfvsK7yBm/wt1G/Bi+LuWRmItgL2ayYGU2nMfo7S
         REVQ0jYgIkUnE4AlxQS063AlZWc8TebNr/8enBYgdV+8QvTsJECujvCH8oLIzohkNJSN
         MALw50lmGg+HqjBdPK3d3X9KtO4rBM7ryigf10Wa5QXMSspbXtEuVTibxCgvgc2m6PpY
         XnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jx2k6guhhdaGBfaejTqdRGnDImbwefudlSdHFEKHg9Q=;
        b=mC9he9wYlNru7Tfp/lOsk0M3/E1VOePJqgphBA/Kxug7HQOjQZ2dus33nwvYBaf1gf
         i7k7jEnXO6eiTOmcf8xTacNI2iqg4PIs7VKqrZdLtTN9b79C5GT8eb1Hzlf22qXzROE4
         hYX6428iqIDoMYXIIvs6kWCzMw+f3Q25fZNluRwZGtBxRNCTcMTx75bpkHo4eOL7d1hZ
         yoFT+gFeSI/u2BELCqMVpIYntJE1k2/dEoplt50DV+fb0fjitV1iztIbcSaljTYoIr6B
         Hej+WAncmVqO3flyQqtSMO49/AIpupNS6FImafe4gJYpOtLbTXE6zdo3L9TkylGHqpSn
         Ez0w==
X-Gm-Message-State: AOUpUlFdzrjV00LBIn3+/VCBnceVuTVRvAmB4IrXGBRcV4cwrM7HC6bo
        9oIe5aeqU5Wlu5OsjC8Xh1XdUA==
X-Google-Smtp-Source: AA+uWPyd3qLqj8KFS2qjHvKvh+iViTk2XZdmNcbGuf5/UXQI16q/rPtmENImNbQgmng11ZCylUTNSQ==
X-Received: by 2002:a5d:574d:: with SMTP id q13-v6mr3396228wrw.24.1533888372261;
        Fri, 10 Aug 2018 01:06:12 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id h7-v6sm9546405wrs.8.2018.08.10.01.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:06:11 -0700 (PDT)
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
Subject: [PATCH v2 21/29] ARM: davinci: da830-evm: use device properties for at24 eeprom
Date:   Fri, 10 Aug 2018 10:05:18 +0200
Message-Id: <20180810080526.27207-22-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
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
index 9a055ebba081..fcfd1565bfdc 100644
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
 #include <linux/nvmem-provider.h>
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

