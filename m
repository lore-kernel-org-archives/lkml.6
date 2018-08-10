Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF137C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C0B223FA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hpbHyybq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C0B223FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeHJKed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:34:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43698 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbeHJKeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:34:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id b15-v6so7446506wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FwyNGSHiOJtGONRaDr8ThVu1ERv+Zjqtryg9AOfSNOg=;
        b=hpbHyybqOz4E2uVHyVT+2GgLMXrKdt6w6C6XcRDtPYAW54YvGdyDToBmubnIZk9suH
         tOtjJw2FS2UqReoSnuvU4XivlJJUN8WiMeC1xwnpNq3rtBWrtWFtQ5VB8MYaLkCKoQ1Y
         eHgQ050yRpH7mCSqzyvgWT5NuflUn53IZqT1prc0qDrrWjkhQUzMFX36a7SHyaebOT/n
         TB4vJDBG+DPwD+V8QZzRCqLRHwuLEptjkuOC1MLRUTTzwE4k45rGO33kiJ5YgFsxL7wI
         LO6eHX6+Rf3F5UvAxT1TfsShXgNG71xGwSvRZ3gOVdhREWBCiAWtllK8F4zVEPtH4heU
         ImcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FwyNGSHiOJtGONRaDr8ThVu1ERv+Zjqtryg9AOfSNOg=;
        b=DBRCBaWiMSWGHR/9HvUZ7dRDuRSYM3EItp0dw7yFDOn/8sD+6LzAdWQguLD2uOVF+9
         4FGjTNga2jh5tHaSGnhtL6zJUv9WphB1c5u0nYJjwf8J7leX207gdpE/R2FiWP1JZjbl
         jbOf0Gd0zWOviV0IqHt7EOAStUs13FjQhMtjxjdQsB2OFhd/iRLSF7qeT88aAl26HOPT
         x01kDd25BEvyyL7Jn4AxbZnh5V1ImSK36oqrPwPJTZydje6qN1Dyz91xr+XOaLzHiLTW
         xTVZllvHnnCeXN35oaovE92UCY+mGL3kxXKL0oN60YLZVANNK7i1nPNtQ+h0XADneqhE
         ZZJQ==
X-Gm-Message-State: AOUpUlFvvnwFgUOdadYR1xyIEXAYTy657pQhkLchGXtvfgIvg7IoxgV0
        RMfSh9/HcF6UuqVJUFxOcjFCdA==
X-Google-Smtp-Source: AA+uWPwbRZ4qbxJYpAg+IYZPFTqoclehtJo2xzwKjACWoVjj9ER+07jUmdmdQUzbJBGsORJ7A2umQQ==
X-Received: by 2002:a5d:5349:: with SMTP id t9-v6mr3377951wrv.186.1533888345376;
        Fri, 10 Aug 2018 01:05:45 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id h7-v6sm9546405wrs.8.2018.08.10.01.05.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:05:44 -0700 (PDT)
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
Subject: [PATCH v2 07/29] ARM: davinci: dm365-evm: use nvmem lookup for mac address
Date:   Fri, 10 Aug 2018 10:05:04 +0200
Message-Id: <20180810080526.27207-8-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-dm365-evm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 435f7ec7d9af..cf3f2e611228 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -22,6 +22,7 @@
 #include <linux/leds.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/nvmem-provider.h>
 #include <linux/slab.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/input.h>
@@ -169,6 +170,15 @@ static struct platform_device davinci_nand_device = {
 	},
 };
 
+static struct nvmem_cell_lookup dm365evm_mac_address_cell = {
+	.info = {
+		.name = "mac-address",
+		.offset = 0x7f00,
+		.bytes = ETH_ALEN,
+	},
+	.nvmem_name = "1-00500",
+};
+
 static struct at24_platform_data eeprom_info = {
 	.byte_len       = (256*1024) / 8,
 	.page_size      = 64,
@@ -769,6 +779,8 @@ static __init void dm365_evm_init(void)
 
 	dm365_init_spi0(BIT(0), dm365_evm_spi_info,
 			ARRAY_SIZE(dm365_evm_spi_info));
+
+	nvmem_add_lookup_table(&dm365evm_mac_address_cell, 1);
 }
 
 MACHINE_START(DAVINCI_DM365_EVM, "DaVinci DM365 EVM")
-- 
2.18.0

