Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16FDC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB4F27535
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Z2v3sDcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB4F27535
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966872AbeF1Of5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:35:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54503 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966709AbeF1Od0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:33:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id i139-v6so9918270wmf.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bR3ra0J3nB9yOQmIhsiBHpNBXbsCR87+f3+DqJeGKRU=;
        b=Z2v3sDcZhrzjxrKzXBicFeIdMJfWZ7kpd898A5CFvEguC14+2Ag820J2s0a3U6hwms
         XkWxNtzl931u4h7s8Ju0R9ODOyokde6sWppdPvtrkFsbjcybXk7hmOHZUIW+QyiJwgfn
         +Z3ZvomhOElbp7unVvhuOEmF5VHI2pXXrrjvsRpWkv+VtYasaxUk5bfmWNrQzFswnBFY
         aFVpKF/iTEW0n2eEyH/u58nMJUPRx1O97/upLrcwl2XUPnmlSQO2juJRoaDkzU55aT+C
         SVSVNIK+Co1CFg1ASnGyMzsUZIcbaS2mXKa4MLGonjg34unGhS+BoO1POSgxjTvyBFja
         WWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bR3ra0J3nB9yOQmIhsiBHpNBXbsCR87+f3+DqJeGKRU=;
        b=eMHxk65gsppjMb+PiU2+qqMyfxHw06dkajO0G4EfpMRWgP2JCRcRrIkdxqdjY4mMfU
         eREf4WMoTXJYDbjIAO3lljsR+/9uIY2cWbW99LJRZrrVyStahZ1sELhxi+qoIzHyd3Sj
         WvtWxkrtfAzubSyMPJrqdZdA0YjRYdBRfySUUnm6pkED8WFpjUxNBXGiD/ubCvJkmVVi
         hCGP6uH5rUnC5iAukrp2w1EpsWj6/UmME3dOySGnFqWKCSyJaitvUB0Gyhm+LzIo7gCh
         0aGOwsbuADWRF7s5HA36+V/3ClsxK+qIlstD9Wc7vElVH+7eCWXb8+Ge1CNw9s5zZi7b
         Q26w==
X-Gm-Message-State: APt69E0EOthtISkmUA0A3CVF1AJImUScq1F7KclqbWEPe71rP935qF9l
        ZFHcHy8IHgMtsp5vb+IVdZ/VzQ==
X-Google-Smtp-Source: AAOMgpcOAEfzvwYS3+eOtBpSlWVJw3l/4X8J58ssSDNCD+lTc6YH7srqTHgznZwIwoHjJDv0aXbAzA==
X-Received: by 2002:a1c:d509:: with SMTP id m9-v6mr8692371wmg.69.1530196405479;
        Thu, 28 Jun 2018 07:33:25 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id 4-v6sm8037499wmh.14.2018.06.28.07.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 07:33:24 -0700 (PDT)
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
Subject: [PATCH v3 13/18] ARM: davinci: da830-evm: use device properties for at24 eeprom
Date:   Thu, 28 Jun 2018 16:32:39 +0200
Message-Id: <20180628143244.4561-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628143244.4561-1-brgl@bgdev.pl>
References: <20180628143244.4561-1-brgl@bgdev.pl>
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

