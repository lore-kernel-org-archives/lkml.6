Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E307C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DBE223F6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1tQfPHxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DBE223F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbeHJKfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:35:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55945 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbeHJKfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:35:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so919344wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bCbrQHeuPnC+JDn+6qaI1RwzcN05FDYJKKTaYUupgdQ=;
        b=1tQfPHxchGSIBzdu1CdyJ3+sxsPvNbB7Jf+N2w8yfLAogC8MwJ/gToB3EqKlhwn7Rf
         2oHaYtcEcH9JT5zsei0r+iphNwjjWhjlT9ZNNTxTMzqyCW9HcrJSckUHkx0LBx7IbMyL
         Z3iu3tQeF0Tkh3pmTIYf+sM6RAWYVrzz4TiBHtvIdyLlNxnnq8Tr8vW3/Sqhn7TaxHTC
         z/qODO1CVMNgGusQ2PMhCRKDzs0JtS9g7ofM1v2jtA8+f4ZUkPGwsvcppwe58kykzGJo
         L4qoUMFe85hXsjFZpc7bf8ReYgvT7/HY3LJ2V7k+DSh2912yFzMDyv8p3dkUhZO4lmSV
         Wh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bCbrQHeuPnC+JDn+6qaI1RwzcN05FDYJKKTaYUupgdQ=;
        b=qruO0vVRTo7Po3eEOWZSQpdO+L+B87rS2jq5kxVu4a+qFjEi4MmgG2SuyLEHYK7cRJ
         lYDBf7oQ5OqMY03ofZ6FuGAKz9CXiSjk+IlGlSg8nf/hk6JBb0SsS57oytRInO7GBxNf
         i0qu4KbVZLxTM/2ZQiq/bsl8NH+PIkHsg1euMmZwdG/oMDvbDHQHqi4FaNj1oY2462W+
         n4KBL9Mb/EPtlXyVf+wxAJaZONbS6ECY2XdJlNO4p594Ucg2GdkRrExtVMJYmDar6qzt
         PNqBE1w8JVVS8mQPtcH3BJqcRL9m5+G/VurqCZg3kERSiFR9BT7KwgoGabHjXQzB8axC
         p7dA==
X-Gm-Message-State: AOUpUlEIP0Ouzaz9bZv+GF7cwT9bQRm156zUyskD04Ww9GvnQg38X9u8
        u4mtBCji6jj7PA3OQlBgkyh7ZQ==
X-Google-Smtp-Source: AA+uWPynUmGYa48u4xm44HZ/Y8pTcflvhUT9mEUFwclmi2m/wcBtKScj4dFtxlzhONOLvBNmPoZJgQ==
X-Received: by 2002:a1c:aa8f:: with SMTP id t137-v6mr761379wme.54.1533888386561;
        Fri, 10 Aug 2018 01:06:26 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id h7-v6sm9546405wrs.8.2018.08.10.01.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:06:25 -0700 (PDT)
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
Subject: [PATCH v2 28/29] ARM: davinci: mityomapl138: use device properties for at24 eeprom
Date:   Fri, 10 Aug 2018 10:05:25 +0200
Message-Id: <20180810080526.27207-29-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-mityomapl138.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index dacc5292f9bd..db50fcce5976 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -14,13 +14,13 @@
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/mtd/partitions.h>
 #include <linux/notifier.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/at24.h>
 #include <linux/etherdevice.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
@@ -185,10 +185,10 @@ static struct nvmem_cell_lookup mityomapl138_nvmem_cells[] = {
 	}
 };
 
-static struct at24_platform_data mityomapl138_fd_chip = {
-	.byte_len	= 256,
-	.page_size	= 8,
-	.flags		= AT24_FLAG_READONLY | AT24_FLAG_IRUGO,
+static const struct property_entry mityomapl138_fd_chip_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 8),
+	PROPERTY_ENTRY_BOOL("read-only"),
+	{ }
 };
 
 static struct davinci_i2c_platform_data mityomap_i2c_0_pdata = {
@@ -317,7 +317,7 @@ static struct i2c_board_info __initdata mityomap_tps65023_info[] = {
 	},
 	{
 		I2C_BOARD_INFO("24c02", 0x50),
-		.platform_data = &mityomapl138_fd_chip,
+		.properties = mityomapl138_fd_chip_properties,
 	},
 };
 
-- 
2.18.0

