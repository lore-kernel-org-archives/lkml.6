Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C919C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1499D2690A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="XtbnDwP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1499D2690A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934887AbeFZKZn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:25:43 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33189 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934784AbeFZKX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:23:28 -0400
Received: by mail-wr0-f194.google.com with SMTP id k16-v6so16678974wro.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=faf1l9/9bHCj2vE9DzhzD9GnLDQrn+6rBW9qABWbX9U=;
        b=XtbnDwP8+nVA1KGIeBMn1+H4oRjPuppkgrIsA1a/d8pCvkgJLpWP9rDFdARpx637Ye
         rLVydP7xPPI+aj9yrq1KM7qiu5CYT5XHiO3cbAEy9havMUvwSCMtb05l/Z3XPcKCoQBa
         N2sxQ93kzWXdKVGaOERxJCWoQvWHpP5TRakPKWH2gr1FwRS5xng4Q84npSXP2VPTxTqa
         hkpZ1x/PRrlgwNMlyZcyh5VBjshjhwkMHp2gbiFzk0aY2BZT4ioczVbVdNtc2NdlsIkI
         kIglEsGDePtImg406JL4o+dMg3NbCfcln83K9XJI4ZLX6cwBtAwDVKvOT6vnuw8u6yMT
         mr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=faf1l9/9bHCj2vE9DzhzD9GnLDQrn+6rBW9qABWbX9U=;
        b=M0Y2X8E6lvXWReBrRCXS3V76NnXqid5RPzjdkhDF0stFPflboGj1fs6mtx/YE2yX77
         4bG6RgpQpBW26IZYSTPDmKslwOk5zbDN31vE6goS3Jd8HPZiTlcAMp00s+sthLz3cFK6
         OnVBStE32ceuIwolNdA3Q9hlZnP7kEN5omu2dDVbf/Kv6nKsJ8SGVd1shx2cwCqzOl6M
         YhtfEySW+K1AQE5Cvyqk4JyP68vRcM3dkOvMfS8G8ELYR4QB+e9/yjIt0879Qa0qJGUa
         gyY85OmAheptbD/H4MdtGFZc2IshJ+pX8FUb243RLK5rM1MdvVDC5arq3vInSM5akUfF
         M+ZQ==
X-Gm-Message-State: APt69E1Lz45yQPKVVfucxLQQh+PWCZLjGh0gDRsq6+wOLfsQ1ClNmwPf
        zyQazrk+bHxnOO0ivA8tNLUZoA==
X-Google-Smtp-Source: AAOMgpel1YWFfhftu3YIBUKWSisOkx09KbFoi9pZq8EMe36i6Fv0X6Ykq+mzomAPWHWY9iNe7AN0Hw==
X-Received: by 2002:adf:80af:: with SMTP id 44-v6mr948855wrl.64.1530008607569;
        Tue, 26 Jun 2018 03:23:27 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2573852wmp.23.2018.06.26.03.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:23:27 -0700 (PDT)
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
Subject: [PATCH v2 10/15] ARM: davinci: da830-evm: use device properties for at24 eeprom
Date:   Tue, 26 Jun 2018 12:22:40 +0200
Message-Id: <20180626102245.30711-11-brgl@bgdev.pl>
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

