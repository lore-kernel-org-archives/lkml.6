Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB4FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118E320868
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hPfwQE70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118E320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387761AbeKNAAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:00:19 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54631 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387721AbeKNAAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so12089027wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H8x7i2Y0NQGhPOwYVcZG4ieMSrsXoI3OcuJ/XVYngLQ=;
        b=hPfwQE70p7pPEvw9+TUWD5NNH4b9dL17YrJaEUNEtZ7KYndN9V+FdRwV5aYAMttn0v
         QXve1XUIFOuEJJRuCd1VqaBj5QqxVpR9PMgABcgvfqvwoSl0undeasFfaTHFdE4oMd99
         NcpL+1vyCCTTCfw1FOPmuveSOihp2RQpm3badhB9t273Qfu75hsUKkZx6PVqGP2zSMAJ
         M26MNR9rMwfRrVJYb4xVlmgb06t1aAnvUvPlHJ0ObUd95oNDAVMKAyVLecHO/OHTS9yf
         ejOGxnb6Vpp0Gmee1NYG2V4oHSrfk/ZF1Xcg9k9Z4EcjX+pATrJuI8AN4Lo8A7xNiw/7
         /eNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H8x7i2Y0NQGhPOwYVcZG4ieMSrsXoI3OcuJ/XVYngLQ=;
        b=O7oIpJ+8eH38eMaCXV36XTj6O7/Cp4qxOyjns72pbLnI1jw+E1wOSyI3KNSWBRfDFt
         vNoX0Ruh2A0R6foOsDoha8innXs9jRj75B7JRZNIl4ysdNHmQRu9mizlf71rA55eQk7l
         th5XuRCo53Ioty9OYUoeewpGe4VDsYavXWjlrBwYU7XXwNDf8lqPxJAOeghWQAAVZZhP
         8pFLBXq71ZFpnREvLTjHfttPgaYoWR9zX/NDkIOgji+Jy7Cuecs/vZkg8G5JTg5gYW2g
         yTmSvJUuum5vE33nMXhKh4beJznk8PQY1eIzFe57s53wZ0zufkYmlVuEESC98dWzsOw1
         tfXw==
X-Gm-Message-State: AGRZ1gLOFLh5h5OlVo24eK70JcheLyR04GRZPh/gEXnXH5M7jEJBS0op
        FFYfY62dS5toiHHwDbP4xLCNjA==
X-Google-Smtp-Source: AJdET5dFcmh9LMc8AGT0EEsXUesVg/vqWwWx5Zo9mOUI6KdJwAKlRZQfUs9KoHRfAeOBsCksGprZXg==
X-Received: by 2002:a1c:bc82:: with SMTP id m124-v6mr3337326wmf.76.1542117720757;
        Tue, 13 Nov 2018 06:02:00 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.01.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:02:00 -0800 (PST)
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
Subject: [PATCH v2 04/25] ARM: davinci: dm644x-evm: use cell nvmem lookup for mac address
Date:   Tue, 13 Nov 2018 15:01:12 +0100
Message-Id: <20181113140133.17385-5-brgl@bgdev.pl>
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

We now support nvmem lookups and cell definitions for machine code.
Add relevant data structures for the mac-address stored in at24 EEPROM.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index e4a8f9225d16..e1428115067f 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -22,6 +22,7 @@
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/nvmem-provider.h>
 #include <linux/phy.h>
 #include <linux/clk.h>
 #include <linux/videodev2.h>
@@ -510,6 +511,27 @@ static struct pcf857x_platform_data pcf_data_u35 = {
  *  - ... newer boards may have more
  */
 
+static struct nvmem_cell_info dm644evm_nvmem_cells[] = {
+	{
+		.name		= "macaddr",
+		.offset		= 0x7f00,
+		.bytes		= ETH_ALEN,
+	}
+};
+
+static struct nvmem_cell_table dm644evm_nvmem_cell_table = {
+	.nvmem_name	= "1-00500",
+	.cells		= dm644evm_nvmem_cells,
+	.ncells		= ARRAY_SIZE(dm644evm_nvmem_cells),
+};
+
+static struct nvmem_cell_lookup dm644evm_nvmem_cell_lookup = {
+	.nvmem_name	= "1-00500",
+	.cell_name	= "macaddr",
+	.dev_id		= "davinci_emac.1",
+	.con_id		= "mac-address",
+};
+
 static struct at24_platform_data eeprom_info = {
 	.byte_len	= (256*1024) / 8,
 	.page_size	= 64,
@@ -842,6 +864,8 @@ static __init void davinci_evm_init(void)
 	platform_add_devices(davinci_evm_devices,
 			     ARRAY_SIZE(davinci_evm_devices));
 #ifdef CONFIG_I2C
+	nvmem_add_cell_table(&dm644evm_nvmem_cell_table);
+	nvmem_add_cell_lookups(&dm644evm_nvmem_cell_lookup, 1);
 	evm_init_i2c();
 	davinci_setup_mmc(0, &dm6446evm_mmc_config);
 #endif
-- 
2.19.1

