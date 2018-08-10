Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857CBC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E580223FE
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vHThuMMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E580223FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbeHJKfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:35:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35593 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbeHJKfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:35:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so954059wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lM+xHiYLR4UYi5F2NXWnALiFOQcF0j1BgcM3dz4IWYQ=;
        b=vHThuMMI0Qcou5hHH/sIA6W37T74NlFtZcOLijBnjUCv/af63PSw94DC2iZbHRck+a
         OKAxCZ0VIUJQJZTaAhkMHTOyCng95OSorHUwVQe5VwTFdpTJfu0q2cYi3CLuWh+DajIz
         tEpyAChEzphKPqWdHoIg4BLHZ/xcHaHwmoTyZnfQ3qgB/m5x6Dw4CbgsqFEi0aHODZZZ
         IOUZJT/zzB0Ai5G9/ZgEiiweyo9/ZNh5Xut0MdO5TjJe85Kel9GxjUw5JnWOHjqo/Jzb
         S2gFxEjFA9c0JKUVH4trc2MLNBXxMl87mpa46sutK0Ji5BuEOzWvbuI9yfObUvKaewk9
         Qf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lM+xHiYLR4UYi5F2NXWnALiFOQcF0j1BgcM3dz4IWYQ=;
        b=Wuvwyhv3YmG+oDzVoXuMhZjB7+7bnithMeVuMiD1HnfeGjmXAN+hXRDtmeQff9kJA8
         32gGyKkjkJcBnQxGGjMpunwW6gxNT2B+11AHHtEPPmPmBiQxDImE9Ko1JMa0EyuwSo5D
         apcfde+ENY57/gamtU+YNrQ8YPZiDlkHk6xnr4P9gtUACCQcHX73koh78cY73dr4fvfX
         DFHdTycKKol+WhBqwaDaqQxk9kHL7fIjjLfGc32gAv5CQ72VyuCMUF4ZW09DgMpMpkv3
         lmAX//Cxm5/GA/CNtk+2rvYwmCsVd6MqAR7f8fFmflTdlAF+p9MWtAsbH65nD6YSSOqA
         Grmg==
X-Gm-Message-State: AOUpUlEvje8OKlNZZUJ3sTlRvuTidyQs36KtajlxZOR+3CX/2UmzWLJv
        9FBDErAYzzSF7lIJ9VPdxDKdDg==
X-Google-Smtp-Source: AA+uWPyZ6dhQY5ntZh4vggV3EizWJfYtC6h8L98pOBZkCq81N6X+VzofNeO5r8hSzMubAr6CF7D/IQ==
X-Received: by 2002:a1c:a691:: with SMTP id p139-v6mr781536wme.42.1533888376791;
        Fri, 10 Aug 2018 01:06:16 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id h7-v6sm9546405wrs.8.2018.08.10.01.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:06:16 -0700 (PDT)
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
Subject: [PATCH v2 23/29] ARM: davinci: dm646x-evm: use device properties for at24 eeprom
Date:   Fri, 10 Aug 2018 10:05:20 +0200
Message-Id: <20180810080526.27207-24-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-dm646x-evm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 943ab0ca6db8..04d293096962 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -22,7 +22,7 @@
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/at24.h>
+#include <linux/property.h>
 #include <linux/platform_data/pcf857x.h>
 
 #include <media/i2c/tvp514x.h>
@@ -320,12 +320,9 @@ static struct nvmem_cell_lookup dm646x_evm_mac_address_cell = {
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
 #endif
 
@@ -396,7 +393,7 @@ static void evm_init_cpld(void)
 static struct i2c_board_info __initdata i2c_info[] =  {
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
-		.platform_data  = &eeprom_info,
+		.properties  = eeprom_properties,
 	},
 	{
 		I2C_BOARD_INFO("pcf8574a", 0x38),
-- 
2.18.0

