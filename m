Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BE0C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF736223DC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yjBx+zay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF736223DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeHJKeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:34:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52126 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbeHJKem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:34:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so935361wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sGOzUdYoefHsqeEVpETOZKTrsiIrdDWkhYzQ4MVNoLM=;
        b=yjBx+zayQEOO94lbibSVMCOe8LuflnszJtTjXhxHxnNAfEX0Xojae3oYWgqq5tkr4d
         g3vCgx5kKCd3HlMGta/hSDM4hlMZeDKGze9JbxPuf/PDDu8UUkis04ZdQelg1yVeUtFi
         vk4sUINL4U61Sk9zgsAXBTlIpBRDXknHB8QEQ/fI8sd89ekAa34atOrHYtNajWFOdEH9
         HmU/tx9YSxn0rar21U6iq197pLsU+1iYvjlJ9u0elZR2Cq543/JKhyfrkrda/dCICIM4
         yE69m7ez2k7oT2VXpmM5FwqHfzFhc9rJkrK9OMEWcJGq6d8d++Po3ma+Qw27WEGDjbkg
         bVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sGOzUdYoefHsqeEVpETOZKTrsiIrdDWkhYzQ4MVNoLM=;
        b=k2YN2aOBl5BxzPpYUsjK24wQF1x754PbunnUPkp3l39pypXJ3uncI6w/xsv9h8BvWg
         g8FTPWqJGMJ1A1PB0pjWr4uCYkOSlyTr4uT+BgLL/FY5nxCAW2RWfLxF30mNx8ZcZ7eo
         zwH8rmeO7LgJzaXPHFU1QNnqb2Q3zgCJt5c/JKQW+H/byBGGsEAwLRfuUmZ91Wrm90xQ
         56kyfMSz6uka5VB4sslq+oD6FefejmGXTIrcFaydue5ubmwfbd01fYFdRefjxCI6QExR
         5yKm1jU4B4f36VFHyr9nBbwsxjzXaNISyPbFg6Uj43qA3Ugp73qdrDEcSIPDuuYe43tn
         410A==
X-Gm-Message-State: AOUpUlHWFigXXzxyCNBmdwqZbQ1wW+yjx93oS2SdwwxadHlstZqsB22z
        Y2CDTzkH3iGgltruXHQN3E6++A==
X-Google-Smtp-Source: AA+uWPx1+GuHuc4EM7u+V6MsXntd+upjbsWfUo0og6CvAQZLwTMMwUiM1O9oh1yLd3hN3xNEEzy9Jg==
X-Received: by 2002:a1c:2094:: with SMTP id g142-v6mr731584wmg.144.1533888355605;
        Fri, 10 Aug 2018 01:05:55 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id h7-v6sm9546405wrs.8.2018.08.10.01.05.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:05:54 -0700 (PDT)
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
Subject: [PATCH v2 12/29] ARM: davinci: da850-evm: use nvmem lookup for mac address
Date:   Fri, 10 Aug 2018 10:05:09 +0200
Message-Id: <20180810080526.27207-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support nvmem lookups for machine code. Add a lookup for
mac-address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 6d5beb11bd96..5a634a04ec69 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -29,6 +29,7 @@
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_data/mtd-davinci.h>
@@ -99,6 +100,19 @@ static struct mtd_partition da850evm_spiflash_part[] = {
 	},
 };
 
+static struct nvmem_cell_lookup da850evm_mac_address_cell = {
+	.info = {
+		.name = "mac-address",
+		.offset = 0x0,
+		.bytes = ETH_ALEN,
+	},
+	/*
+	 * The nvmem name differs from the partition name because of the
+	 * internal works of the nvmem framework.
+	 */
+	.nvmem_name = "MAC-Address0",
+};
+
 static struct flash_platform_data da850evm_spiflash_data = {
 	.name		= "m25p80",
 	.parts		= da850evm_spiflash_part,
@@ -1447,6 +1461,8 @@ static __init void da850_evm_init(void)
 		pr_warn("%s: spi info registration failed: %d\n", __func__,
 			ret);
 
+	nvmem_add_lookup_table(&da850evm_mac_address_cell, 1);
+
 	ret = da8xx_register_spi_bus(1, ARRAY_SIZE(da850evm_spi_info));
 	if (ret)
 		pr_warn("%s: SPI 1 registration failed: %d\n", __func__, ret);
-- 
2.18.0

