Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2299BC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B15223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="O+OECH4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B15223F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbeHJKe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:34:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38891 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbeHJKe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:34:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so933099wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HPXa1j+zFmSDAVh2jGMcP3wD/npPGnLx7r1kNiFN+9Y=;
        b=O+OECH4nC1bg5wtlSFpOGT9gHilp0o7Nlfityg//si0KFiuNYA0OwATePITmZCM4PC
         blWQAKqRmehTaQnZkumesFl/qcoEjM5nFW8kFursazipXQlAfP02T8lsI4ZaA66KMY+G
         pWqfiU7os8y3GFa9Xm2lZocwn8SouFVV7qtnRn24oyISNd6zXxMBsmBy0OYwAJqFkJ1e
         WB3tB1JokligLEXKuSYyskmLiZE+0pE0xX/Z3DUBkmrPUtFyCeKQK5/13Rsqs7sAwB4c
         99bV+y+gVHxXXS94l8dx9yFX+ItRGrMV+YHv60Mf2T+df+l5vi2XQd+A3VZTsLLz00Cc
         9/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HPXa1j+zFmSDAVh2jGMcP3wD/npPGnLx7r1kNiFN+9Y=;
        b=i6EA0gP/Vl7jBmeBp5Kd5MCTz194jMG+wvwXYPlOlURT1rTGYbnfX0cR+tN7VtbcxW
         xJonYst5e6JEc4GD3JarIcNDPAwq+exF0JTk/BzH5w44DMbl96UgbJI2g+Qx6yR9V5NR
         zE+ldAW1cCo5msbZg9zF6TQALsoARvrs1vjuif6Jh3hZrvUDS4Z5pfEHrVIaS8jOCqWq
         fHDQHapcvuR9ecDSPeKnD9ZVca1J4ZYwY776Fj3vRf5bVdTR4OryCx4MU3ETZaK+5FgL
         /IJZ07v6i3/4NbJnAgKiLqGt5drUJ7bmRf2UGUWVOsNUY3cTKq92C9nlPAyE9pTmCvv0
         tXiA==
X-Gm-Message-State: AOUpUlEmmwwKq1l+aoYOszdbPk42xGF8ayMIk9LZ5pSTIkl/6Dzkg6ir
        uw8hTkMDwP/P2P5VFsnaAJJulQ==
X-Google-Smtp-Source: AA+uWPzbqN+AvO/5M/oQG93TVlVH8teA2PAB2BfHk7uXDyI0S3yEV3Zr3HSzXM3lV5M/EDJiJplu7Q==
X-Received: by 2002:a1c:8b0d:: with SMTP id n13-v6mr730702wmd.46.1533888370458;
        Fri, 10 Aug 2018 01:06:10 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id h7-v6sm9546405wrs.8.2018.08.10.01.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:06:09 -0700 (PDT)
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
Subject: [PATCH v2 20/29] ARM: davinci: dm365-evm: use device properties for at24 eeprom
Date:   Fri, 10 Aug 2018 10:05:17 +0200
Message-Id: <20180810080526.27207-21-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-dm365-evm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index cf3f2e611228..2447e08dd68d 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -18,7 +18,7 @@
 #include <linux/i2c.h>
 #include <linux/io.h>
 #include <linux/clk.h>
-#include <linux/platform_data/at24.h>
+#include <linux/property.h>
 #include <linux/leds.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -179,18 +179,15 @@ static struct nvmem_cell_lookup dm365evm_mac_address_cell = {
 	.nvmem_name = "1-00500",
 };
 
-static struct at24_platform_data eeprom_info = {
-	.byte_len       = (256*1024) / 8,
-	.page_size      = 64,
-	.flags          = AT24_FLAG_ADDR16,
-	.setup          = davinci_get_mac_addr,
-	.context	= (void *)0x7f00,
+static const struct property_entry eeprom_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 64),
+	{ }
 };
 
 static struct i2c_board_info i2c_info[] = {
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
-		.platform_data	= &eeprom_info,
+		.properties = eeprom_properties,
 	},
 	{
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
-- 
2.18.0

