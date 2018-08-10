Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50D8C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB22223FA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1hQ9fY4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB22223FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbeHJKfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:35:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52696 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbeHJKfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:35:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id o11-v6so925264wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2XJsVm0WuqF5PCKtq4F+QgEyPMFdIFrJ0P6MxMphb2w=;
        b=1hQ9fY4fRn50E/NBrltIjcbGRbvpoX35hybYGJ/WjXssEj+a5sBJgUoiopfctEacsD
         ou7ZH3w9iE+ZWFNgBgk8KNWzSPK6J8gxHyijHjDL95XTk3SBIcffkszH25aoGUY7WGky
         eKcviDDKKDRVkyw51s5Mw9xvfVyhjXEyhpk/wFqgdetHBFjqtnrln+UgzEzrtnyZ59lD
         /LWzvHPwuhrnsSsgvZe/ZTMWzdr+RpRytfXqdwV5oByARnfG1dFarrQN7JTQg/24vHiC
         8+foTnaQGSWuZ+28/lLNC6CLfxRUF6IUA1GeIpGOj4eKJMsXMfoVemYZb/VNaqjgJPui
         J0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2XJsVm0WuqF5PCKtq4F+QgEyPMFdIFrJ0P6MxMphb2w=;
        b=rw/u2Ubr96YUqI0vncJb+HIcdmBcr9qfk81VV+ewYPg4GN3FxA7ceajxtAaBVkywRk
         0P2xRsT1sOAS0LXcD7KukP5bMB16oCp2q5gEhZkwIWcAojj3CwZhcZ/msGvU//BShRO6
         FvSurJHrrcMbAEAdu9XFyNzBF41dCykkPzk/zVFlvM/fPJVEUwZOSm4vm9veAhsbs/eS
         3/h6RhtFLDAlpcf+kunBDM+pIsPr/v3VEbaOaBN4PjjfS9mfnLmaYgbEt+N1SHLT1yDe
         3S5mlFbEhYEj4rFCexsyl33bPL40d8dUbRhcxsUBtwUYuRzTAMuBK7QeGDxAVbJWr6wQ
         VQfQ==
X-Gm-Message-State: AOUpUlEVxzUFrF13O4jPuQKMfPKk6SIL9yQ0iMB/EJC+1ABlASeQWHoc
        EMaspHlYcTK5knRaLvpc5YMkhw==
X-Google-Smtp-Source: AA+uWPxS/bjMnRwWRr6p7SEdXPfa/06EnMWo0ltWQqQMo2eRQ0yUGK+UCc7XqlSXcy4Fi4s1gaVAHA==
X-Received: by 2002:a1c:af53:: with SMTP id y80-v6mr746897wme.55.1533888374272;
        Fri, 10 Aug 2018 01:06:14 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id h7-v6sm9546405wrs.8.2018.08.10.01.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:06:13 -0700 (PDT)
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
Subject: [PATCH v2 22/29] ARM: davinci: dm644x-evm: use device properties for at24 eeprom
Date:   Fri, 10 Aug 2018 10:05:19 +0200
Message-Id: <20180810080526.27207-23-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-dm644x-evm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 829fa1c8d0b4..954296d23297 100644
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
@@ -486,12 +486,9 @@ static struct nvmem_cell_lookup dm6446evm_mac_address_cell = {
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
+	{ }
 };
 
 /*
@@ -601,7 +598,7 @@ static struct i2c_board_info __initdata i2c_info[] =  {
 	},
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
-		.platform_data	= &eeprom_info,
+		.properties = eeprom_properties,
 	},
 	{
 		I2C_BOARD_INFO("tlv320aic33", 0x1b),
-- 
2.18.0

