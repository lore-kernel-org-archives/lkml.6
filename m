Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2C9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54FD22419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="2JE+mT1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54FD22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbeKNAA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:00:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37563 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387791AbeKNAAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id o15-v6so13421923wrv.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0nBaGmCe8u5S4UVpGAAxUhIXM3J5gHJ7tC52GdLpEYw=;
        b=2JE+mT1MHwAJB9tMw7ZKBp/ZTRI9D1TvxAJJi+MOUi9GyzhUTfoCywDSOLBlpvnf9u
         LLdzWD/qqqRyaGwTmvCZh82uJVEXArdE5iGRdZshN2ym4q9Bt510dJ1jcLdpVIAfk2TK
         7r65XjuS+KsX6897coZMa4La9TbNLn1R9fIFw61FXKyHr1KLBXmoEuwPzX6oVKZaObiZ
         ULWBfXRMOgXsFHb9fszKVRQEWnEUoLM4d4mv7py/Me2OK5iOoX+bo+pB0O05aPojZbMC
         Pw4N7k77lPVTvbsc7xJYpH1l9dRWJBsTqXuDn6D090NhjL/36px6Bm3m62WXPxKiApWd
         jAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0nBaGmCe8u5S4UVpGAAxUhIXM3J5gHJ7tC52GdLpEYw=;
        b=qTqKLoR9gjvOxdLRfI7MUjqKLMNUnZ+wAIoWUb6PaP3yuMhEGT1CQy+NtMhl8ClUXe
         JhDca0OK3IdCUWY9H9SNGNWoGWFT5SnCsF3OqMsbvq3ussYTm2E89pE1BQKaaGmc4X8v
         W9qL1g4Zv/ShlC5f9j/lz6VkCHgNbvwLdn1/gtET6g6NLQCD6FrKEgQ6dAE34+nVe+fk
         qh8VeuDsJX6rmaKB22WZ9i4vn5FA+K9PWZduqMdE7njoKJLMeYtmAYwmkJj1LdOw/X0m
         ia3BUPUw7ydomwCqAxwbqgnH6pNuSg493OO7e3SI/97bEyIG4Dd7XDPcoYkPQcma5T25
         JlTw==
X-Gm-Message-State: AGRZ1gLsZRrBkCNLXKWqkXLfdwT31V0ZrO0pmK/q7yvBb50sBN1NjCDk
        6247Gu4IYZf0NmPQwlMNKpeEsA==
X-Google-Smtp-Source: AJdET5edcxTPvfdf26vGBHt0p8MJGe74nWAFbrLFpUABbvq1P0sFXZKijao2Y5aEZMtYGy8ZPU627Q==
X-Received: by 2002:adf:93e6:: with SMTP id 93-v6mr4932479wrp.311.1542117726462;
        Tue, 13 Nov 2018 06:02:06 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:02:05 -0800 (PST)
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
Subject: [PATCH v2 07/25] ARM: davinci: mityomapl138: use cell nvmem lookup for mac address
Date:   Tue, 13 Nov 2018 15:01:15 +0100
Message-Id: <20181113140133.17385-8-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-mityomapl138.c | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 2933e0c87cfa..8df16e81b69e 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -15,6 +15,7 @@
 #include <linux/console.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/partitions.h>
+#include <linux/nvmem-provider.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c.h>
 #include <linux/platform_data/at24.h>
@@ -161,6 +162,31 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
 	mityomapl138_cpufreq_init(partnum);
 }
 
+/*
+ * We don't define a cell for factory config as it will be accessed from the
+ * board file using the nvmem notifier chain.
+ */
+static struct nvmem_cell_info mityomapl138_nvmem_cells[] = {
+	{
+		.name		= "macaddr",
+		.offset		= 0x64,
+		.bytes		= ETH_ALEN,
+	}
+};
+
+static struct nvmem_cell_table mityomapl138_nvmem_cell_table = {
+	.nvmem_name	= "1-00500",
+	.cells		= mityomapl138_nvmem_cells,
+	.ncells		= ARRAY_SIZE(mityomapl138_nvmem_cells),
+};
+
+static struct nvmem_cell_lookup mityomapl138_nvmem_cell_lookup = {
+	.nvmem_name	= "1-00500",
+	.cell_name	= "macaddr",
+	.dev_id		= "davinci_emac.1",
+	.con_id		= "mac-address",
+};
+
 static struct at24_platform_data mityomapl138_fd_chip = {
 	.byte_len	= 256,
 	.page_size	= 8,
@@ -543,6 +569,9 @@ static void __init mityomapl138_init(void)
 
 	davinci_serial_init(da8xx_serial_device);
 
+	nvmem_add_cell_table(&mityomapl138_nvmem_cell_table);
+	nvmem_add_cell_lookups(&mityomapl138_nvmem_cell_lookup, 1);
+
 	ret = da8xx_register_i2c(0, &mityomap_i2c_0_pdata);
 	if (ret)
 		pr_warn("i2c0 registration failed: %d\n", ret);
-- 
2.19.1

