Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF2CC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F77B27C9C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="b5hkPCCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F77B27C9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966685AbeF2JmN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:42:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50291 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935782AbeF2JlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:41:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id v25-v6so497682wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2R2pRkql6LoH2xOm2fmjKzzNX2yYTgI9nhj9RYkWkCs=;
        b=b5hkPCCrceqkkr2anLWkL7IMaLOQo1wmulTPC3BCPmAL+XwxlJFNBjNlx6ZiCWcGyE
         jXq3xzQs2CGOORAUYdoLCMEODHhgGpEjjBa1lViwWI06KGsrrbd4F/M3NhoH/EUdcHfB
         +HtAbZxWYPXdYHx6IhL6yXGFLnYIVHyS+hkRNJjx1GiXr613e7tjeuc8WfLnBXmjgOMQ
         316XFy6b0lgsgOACQK7yuJTHMBQW8LsxPvhC/BrcsogjabTdPg5ai/55/8/pgtfNVkPJ
         7LB5dHF/Xx3UoqEQInVCP0snLBPHgpt+TXyIphUYTgc9VgV+xQF/3CDdNinEcmqVqfUj
         nyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2R2pRkql6LoH2xOm2fmjKzzNX2yYTgI9nhj9RYkWkCs=;
        b=jPPw2hV5z2iMoxIU4oVoRgVpibF4F7xJbdTTPXSPYJt2yZOeiwzUtWMtnntKpEzorG
         5+1lVcJbPivhHzPWpAaLqFkP4aAcugD7kbuHJPkPj9C3e9BuP0kQ92gOj3Psqxa0FuOY
         vVPKkOa4yQUlnT3uoG2ktwtKeIDAOSt5H5XB0GFqWNEeBakd1nCXKyq8gOFH6QHbdF7i
         QptBDo3QSIzMQ1Z3iGM/bwUVoFTxpPF1mFpbkw5S7fZgwOLyseVQQZ0No/+l/FYTppBF
         9JdJMBvqrrSElWTlJm4EQ5Jj0UjSo9Ibybj2RamwtVJltqhovVDBMDrrzGQ5p/XMNKGb
         aaMA==
X-Gm-Message-State: APt69E3zOgtfgLgbh0KEPGeOpxGeFhRlQpI2bbkP0dydZ83j2wNWhruY
        Hk4hLg5AN3VyE8U9NFzisIAPvg==
X-Google-Smtp-Source: AAOMgpcszy9NUuG/QiXrEpOFtk40sHlkL3VNaPJ/jUx4WSkn3YOpzqbc+wkB9laMCUJIUEcaoEOOog==
X-Received: by 2002:a1c:8803:: with SMTP id k3-v6mr1290605wmd.6.1530265263229;
        Fri, 29 Jun 2018 02:41:03 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id d102-v6sm1386394wma.10.2018.06.29.02.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 02:41:02 -0700 (PDT)
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
Subject: [PATCH v4 14/18] ARM: davinci: dm644x-evm: use device properties for at24 eeprom
Date:   Fri, 29 Jun 2018 11:40:35 +0200
Message-Id: <20180629094039.7543-15-brgl@bgdev.pl>
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

