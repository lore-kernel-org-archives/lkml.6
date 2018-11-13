Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBD9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730D4224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zZ2+34Dg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730D4224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbeKNAAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:00:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51414 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388097AbeKNAAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id w7-v6so12037909wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ztnUf8638FUSA3Znei2oPXxpgrZCrlfwVxJL7f5VqxM=;
        b=zZ2+34Dgw8tffkWguG4iGMsMH70bbh6uhUNdkKwDhFjL4IRxWYrOU+2yvIBpAuTHZx
         4xh5JA1UYHCUlYMAkx/bJ0Dl573316D/C8p4BroweHER1WfBAnp73CxyfRQ8x2N81O/l
         57HLn+U1/gQ0dRAKmgtEW4XmL0/PGfjW5IIEd0Kodi0H38dOQyJWnUpGobPQ7nFSvSg+
         S8o+glqZDkMR+y6PgS2rlmSF72xcTIESNGIPQIh/5lvlUZcljPRALzpcRXrDrDFNpARu
         3nL1DwDRcjN1u3nic0kAru5TCge19MNd02RjoKwGXljpk63ecdA9Lik9Wc0W9IyR0AQ/
         xIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ztnUf8638FUSA3Znei2oPXxpgrZCrlfwVxJL7f5VqxM=;
        b=FAAZcbHBQ+0F1WSxPVMzrKPbvAcbG7WVUpVKmQYC8J8IyM9nj1x4/g+D9Y3Z3toDXB
         zKwzfRDbjvQ7852JL31x+EiL2P42Z4qeqk4A/Bgk7NXcb8/ilCKKa/xTOfRb94/OX/gd
         3Edn3NI1V8iFVdX6IbfvoYHulsUpuaaMqUjRjIXmBLFqUMUZVnxJo6iKed/mlYkJmogH
         z/fryq+xYabkGAZLXt71W0xzJajiv/3RCyJbpduMF2npaPdauAyB6cnBPNjnDU0TN7Yb
         mSN7CNuNxDvjiHpQnWxxnLQxknIfje/Pj4vdc+PmR5kh/jVNdhlFjbUm+Heg4Dnh8d29
         eHeg==
X-Gm-Message-State: AGRZ1gIvQJnDllm30km1SeWDPMqA9ssP0sGFLrLUnMx3vEPMWCG5Jpdn
        DQTvT5BUS1vwWLr2HSitJnEAXg==
X-Google-Smtp-Source: AJdET5fZDtnaImMGTTAvHsDmPnjEU9pLpWpgoZ9sBGQD4RDKI5fISFfh8jg9ZcLoSmrmKmjrcKTJ9w==
X-Received: by 2002:a1c:e3d4:: with SMTP id a203-v6mr3298181wmh.16.1542117752512;
        Tue, 13 Nov 2018 06:02:32 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:02:31 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 21/25] ARM: davinci: sffsdr: use device properties for at24 eeprom
Date:   Tue, 13 Nov 2018 15:01:29 +0100
Message-Id: <20181113140133.17385-22-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 arch/arm/mach-davinci/board-sffsdr.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index acd9778ffa07..ff14de1396c8 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -26,7 +26,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/at24.h>
+#include <linux/property.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
@@ -92,16 +92,15 @@ static struct platform_device davinci_sffsdr_nandflash_device = {
 	.resource	= davinci_sffsdr_nandflash_resource,
 };
 
-static struct at24_platform_data eeprom_info = {
-	.byte_len	= (64*1024) / 8,
-	.page_size	= 32,
-	.flags		= AT24_FLAG_ADDR16,
+static const struct property_entry eeprom_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 32),
+	{ }
 };
 
 static struct i2c_board_info __initdata i2c_info[] =  {
 	{
 		I2C_BOARD_INFO("24c64", 0x50),
-		.platform_data	= &eeprom_info,
+		.properties = eeprom_properties,
 	},
 	/* Other I2C devices:
 	 * MSP430,  addr 0x23 (not used)
-- 
2.19.1

