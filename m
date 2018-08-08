Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD69C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5773A2088E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wx8KUUpD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5773A2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbeHHRzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:55:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36251 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730232AbeHHRy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:54:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so2422627wro.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dK61Sm/OZ4gXBZLrnJshFkdxHXIagaw+2DY/FsoCvvI=;
        b=wx8KUUpDrXR1Yk8TEQeY2WiyIeyoTJOeBd43Kz2X1m8jbY0l2rDH9rnaauh6kSiv5d
         FctheraTETsKIZy1woSQCbBbz0MbtAMtsSZrioYwb9K9bTUyZkitk6VPRyE84NwAbpom
         kCqS7oxgxKj0m2OKqf8DxC+gaY/r6LiIHfzO9/m7cgo95buiVQ7nvrbd6FJtqEL9cmhR
         r8CATQ6/MB/ZxhA6pNVStq1a9fcXHNuGZywEdskRH3LLQKg+LR7j7XjU1UxOL9De6W6O
         wNr2H99NmVWD0ijZ3vxgUPYXe0L92typj+9+KxDNLWyC8aSqFdg5PDaUXzBmWdPAkiAJ
         qCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dK61Sm/OZ4gXBZLrnJshFkdxHXIagaw+2DY/FsoCvvI=;
        b=YcDOn1cpIR1EGnW5XVPgU2nIfZzf/0CgXavnF4Xlx+tnd6S84pT/zKZ9Cmjoj1xx1W
         3CqLNUdKwwgh94+RjY5kcmlVZbgnoQD5C+TNOr2/1ps4ToiARLxkMAzSP4xUQsfBBkcT
         /Sv4J6TY0ir7VrjSN1O0MGXp9lfH71zrk1fpQRphnDBN8x76pQQFTMbqSU3P0uopJqLk
         0kqjqJV65Rcog4oxXT6FqJDYeyappOXcmbXfpVNVij3oXUAX0MiQvUuId4WlycXT/I6W
         Q7ottnqBDlm5oWaeORul/0qrbF4btoyLvRrChWKpnlxi/cfoBR3cADkLNJ/ZxNtmLUQs
         vpgQ==
X-Gm-Message-State: AOUpUlGiggS40dYGnRzBJttjEcjgpFWBek6LA7TYGAB6956XOP75IX/J
        njCuDikZ/mAu5l2mHd95QD4Iqg==
X-Google-Smtp-Source: AA+uWPzxoGpu7emTO/neCYjOUZMXauI/VlSPU0CcyhJ0k+8pENeySiJE1yVk0PhrI70YNs7KID+5DQ==
X-Received: by 2002:adf:9e84:: with SMTP id a4-v6mr2236524wrf.70.1533742456417;
        Wed, 08 Aug 2018 08:34:16 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id s2-v6sm5240915wrw.52.2018.08.08.08.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:34:15 -0700 (PDT)
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
Subject: [PATCH 24/28] ARM: davinci: sffsdr: use device properties for at24 eeprom
Date:   Wed,  8 Aug 2018 17:31:46 +0200
Message-Id: <20180808153150.23444-25-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-sffsdr.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index f6a4d094cbc3..680e5d7628a8 100644
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
+	{ },
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
2.18.0

