Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892CEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491142080D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vO//26UF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491142080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387847AbeKNAA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:00:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36207 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387798AbeKNAA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id z13-v6so13445544wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2dGXQZPFaTjyJ9mbBpSbIbBRV6cQuE8HcUaZBf8FEvM=;
        b=vO//26UF3txJxtF/2FCpjLmGd2dVHLNEN4upAAl6DlwQOZBtNjhOd7m652wyigewuB
         vM70iRUYi0eXzIuma6nuWHxed3jdh3GzpMtfIPEC4if70duX2MOLSrKqeyCb4B1NkQFd
         S4Iw7UqriQGMsUqkEUlNPbXVL67xhSoRsr/VUXn9jIrZDbuYqXqBRjFJ3oxg4wQI0UYt
         ZGeBxHJVDGPjsSvBiBB5fXl876Km+cBW4QVdOqGUEd3PKnd4TqpXzW/aOoHVuhZenq/2
         jYbvQYQCdWm0F/1iiDJXRnO4wC0gN7YNSNaulIS4pX7pw3JCdligOFr9VfFpSXGs9MM7
         T1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2dGXQZPFaTjyJ9mbBpSbIbBRV6cQuE8HcUaZBf8FEvM=;
        b=USdiiDKHmZjyIE/DiHd3jjGRUTEkR8mRygdiQ/l4htDd6v8iiK42WakOr4epXO3bTQ
         40MFeV/aWjP8xXCXfkHEHplux+JgbvubGFEHrJXG6ouIp/+6OW2f/4DtGicSnJ9bjf9D
         3Eur/bR/TZ3CIZSSECeG2th6aRtK+hTaEmtQY+aB9brZpZCcgXXwL7Dc9OKaF/60tjGu
         iIfigECnu4jAj24t5UDLVNQgKYrahGz2cF2RAdA0PdKYvAPyJ365UnpDSK1iiGFyzYBn
         3VgXbjNODRslM2gycFwrIL9/4BAtDkgoODInhq3OYO5mXN0jNT58dDe1aIkkPUJJNQyi
         Ds8w==
X-Gm-Message-State: AGRZ1gLOzU+Rpo24HZn3I0IJTCnjWOPyhLUt5lKHkb2ovQbXj49TzEfj
        lv4BId2m4ZpaE9tpXPsnpZV7McJG1uQ=
X-Google-Smtp-Source: AJdET5dZ1kKaEOAo9CCIMFvceqpnOF650fkNUXufEbms5NWmS8ZOjj3kjC8ZSJ0SgytoS9e22Cz6kA==
X-Received: by 2002:adf:eb0b:: with SMTP id s11-v6mr5037323wrn.102.1542117728193;
        Tue, 13 Nov 2018 06:02:08 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:02:07 -0800 (PST)
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
Subject: [PATCH v2 08/25] ARM: davinci: dm850-evm: use cell nvmem lookup for mac address
Date:   Tue, 13 Nov 2018 15:01:16 +0100
Message-Id: <20181113140133.17385-9-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-da850-evm.c | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index e1a949b47306..bac2162e2153 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -28,6 +28,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/nvmem-provider.h>
 #include <linux/mtd/physmap.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/gpio-davinci.h>
@@ -100,6 +101,31 @@ static struct mtd_partition da850evm_spiflash_part[] = {
 	},
 };
 
+static struct nvmem_cell_info da850evm_nvmem_cells[] = {
+	{
+		.name		= "macaddr",
+		.offset		= 0x0,
+		.bytes		= ETH_ALEN,
+	}
+};
+
+static struct nvmem_cell_table da850evm_nvmem_cell_table = {
+	/*
+	 * The nvmem name differs from the partition name because of the
+	 * internal works of the nvmem framework.
+	 */
+	.nvmem_name	= "MAC-Address0",
+	.cells		= da850evm_nvmem_cells,
+	.ncells		= ARRAY_SIZE(da850evm_nvmem_cells),
+};
+
+static struct nvmem_cell_lookup da850evm_nvmem_cell_lookup = {
+	.nvmem_name	= "MAC-Address0",
+	.cell_name	= "macaddr",
+	.dev_id		= "davinci_emac.1",
+	.con_id		= "mac-address",
+};
+
 static struct flash_platform_data da850evm_spiflash_data = {
 	.name		= "m25p80",
 	.parts		= da850evm_spiflash_part,
@@ -1395,6 +1421,9 @@ static __init void da850_evm_init(void)
 
 	davinci_serial_init(da8xx_serial_device);
 
+	nvmem_add_cell_table(&da850evm_nvmem_cell_table);
+	nvmem_add_cell_lookups(&da850evm_nvmem_cell_lookup, 1);
+
 	i2c_register_board_info(1, da850_evm_i2c_devices,
 			ARRAY_SIZE(da850_evm_i2c_devices));
 
-- 
2.19.1

