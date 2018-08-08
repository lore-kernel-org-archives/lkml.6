Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475A2C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BC92088E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="x9M5T0Vo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BC92088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbeHHRyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:54:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40483 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729750AbeHHRyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:54:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15-v6so2399696wrs.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ThSFa5TY9AN8ejL/oFTQ9UvkNub5vaaRPx6NCkwo95U=;
        b=x9M5T0VoamSKJspU6RNUsUy6KIRSSDioe4ly7gBcHx+d13+QZGPnxFBNnsExUNjdXd
         c60SpxM2BsVd6eO7EQ8/Zr8sj4WBEeeQaSTufUH9eI4BUlNqPm3tqMDWN0PpqIfAcGg7
         HHRLA8dJWdN43Ot1HNbbrnLMi9h6XsVkANFrEnCHcIh9KZWfAza5WbjWAfz14IRp+5tm
         +d2jb37Eycq2jzQ4Lmufs0/QGSElis7cX6K24P0XJKOx2tAjfiX0aBG9uGkiGDASTshj
         Dp1HrD5LrY/WWxEF6GrqRPc61krRfGVbb9KNwEj0fA4zhz74LOs4UcYPsW6oNichH4Ks
         19iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ThSFa5TY9AN8ejL/oFTQ9UvkNub5vaaRPx6NCkwo95U=;
        b=kiy4xYXhvZPz8/YQBvgy/3Mjtgx2VLH+/eZFPiOGKF75hSTO9F2WxKk6gZeTGgStUS
         nxJ6I58c0Jp2OOZg7xCQ1wOHPpbiyHxjkyOEoYcpGtuDEU43Ldd5juhhvtFvGnzpekjp
         7PMytANRDfgF1jszgSzxqFQt0LxYs/lsOuS1eVnStvtdz7O5SueLqYhrnJzI27QixZ4t
         3HOP6dbLhJ/+8bleMsuUHYeRoaquVw46URlzgFRtkrWDIYWAvwB3+FWaFNFPXOh6HJXi
         0nf+1+/yUQ9qiyyCiZHtn7Q3dihE63pDJxnjT5tRNlOaJKXvpqN4QT3/LrR3IXpxwBjO
         a2vw==
X-Gm-Message-State: AOUpUlFGGgSIBNv2M8E0QJ1TlVtS+BBiNP18ZSwRlsIcA/wfDc1k8WUZ
        n+BMLANaG75h28HQG1sV9NQfzA==
X-Google-Smtp-Source: AA+uWPz9Q62GrVDM1cbswEJ4atfiPSujjt5s4US58San4nh5F+aJUXoWLEK5/qW6BvjlnIC5n3N6vQ==
X-Received: by 2002:adf:f091:: with SMTP id n17-v6mr2356346wro.49.1533742444479;
        Wed, 08 Aug 2018 08:34:04 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id s2-v6sm5240915wrw.52.2018.08.08.08.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:34:03 -0700 (PDT)
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
Subject: [PATCH 19/28] ARM: davinci: dm365-evm: use device properties for at24 eeprom
Date:   Wed,  8 Aug 2018 17:31:41 +0200
Message-Id: <20180808153150.23444-20-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-dm365-evm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index cb0ac92a278e..b360d26e6caa 100644
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

