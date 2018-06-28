Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CC1C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1892752E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="eXl1ulra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1892752E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966861AbeF1Off (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:35:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38288 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966718AbeF1Od1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:33:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so9273605wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2R2pRkql6LoH2xOm2fmjKzzNX2yYTgI9nhj9RYkWkCs=;
        b=eXl1ulravYLvwWSvbnTDHEMRSJn+QLapwWirlW/qHFRb/sH+4KN2G7RiCDQoBMayO5
         tAo1zA6tzT1whN3e+z5l3jmFzXvinokPJ19NaobD/E8ooaahIP4b2TiDzJK6UELhjunl
         WPO1rBfUoD2xTveAfvi3XIQcJXKeG2gfVKpsp+PjG9SWG2LZW6m93cpZgHCFStbr3GDO
         S47Dfdl6HzvPWqZ92y6AmS1dzRDTJd/VFNSdB5bbo80uyTI8imeKMWceJQcSf8fh5Nz6
         IPBhFp+8PyaRMgiVK6Ob8DVwbetoK8ejpquY4y1bsYxtqXuUzznrTf+P9hbiWm2yIOe8
         zScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2R2pRkql6LoH2xOm2fmjKzzNX2yYTgI9nhj9RYkWkCs=;
        b=e8giIqEq709SOUqWza8vSQCToUqNI2PkA5bTgdRi3ocxHAb6ZCoKju/0uM7G3Ip4hU
         614xDrYMgDRpjirLQpfQubp5y2pVInYOnjHBp8CegbSww5/cQ3EM3swzgWKxPXQ31XgU
         +0lc8NFdOKETGPPgBvZ2HVj6+zuHmRINnrsqZ4kKI6Ho856lHIcsFVRpcXW1fULPh1rh
         OGxcfcy+1QiAD/yGmIdCfK150hMiHc7px/v5USNpoPSv8mU+yVTaMIYshHyVhcszSSaB
         Gl9b5UMFpxAS5dOZ3EavxWCZSGjLBB2vJyRyiawTxRVlnmwLPJj3tWZaNtzncmdzxgxD
         Pzgg==
X-Gm-Message-State: APt69E1K+SLanF1NQm4Dd+2+tHlr9r0hICsvhw2NDeDQx5tQkYsMbJWW
        tIxwKcCS0qrRb1l8jToMBCERRw==
X-Google-Smtp-Source: AAOMgpcfZy8DwqhSsE3gLu8ra5qrqE074DSDPypa9+j2luF9BZYJf2C/sCVMRFsqXrjR52zPdcjEFQ==
X-Received: by 2002:a1c:cf81:: with SMTP id f123-v6mr8179264wmg.83.1530196406774;
        Thu, 28 Jun 2018 07:33:26 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id 4-v6sm8037499wmh.14.2018.06.28.07.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 07:33:26 -0700 (PDT)
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
Subject: [PATCH v3 14/18] ARM: davinci: dm644x-evm: use device properties for at24 eeprom
Date:   Thu, 28 Jun 2018 16:32:40 +0200
Message-Id: <20180628143244.4561-15-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-dm644x-evm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 6d35c6e1b0bd..abfcf42da6fb 100644
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

