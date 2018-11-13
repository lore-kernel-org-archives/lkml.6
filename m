Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCBEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56B220868
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jDdFw9kR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56B220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387782AbeKNAAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:00:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55307 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387743AbeKNAAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id i73-v6so6744028wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9klMrKm/3PJPsH9a0HqCufZa/6Vrvj6NDHHgs6SRwqk=;
        b=jDdFw9kRW9gcJvRRdAZyjHYhnvNLGzy+wQsmSewMZw3DgFsy0N44E2WjOqJg63UxgX
         3Z7tsCFbJDX/A1LvBBFuQI7ansJBzUW3ylklFfSQDmxSjVvA5gYoOPZOtQr86pYHhn3b
         C6agZtyhqW6wai5t3iC9y1MVTAgU7XJLCDHokBZ0C8Xcg2D8ZF23aj4kDiyjyAoC1CuS
         fXrN48zjXbOe5evTX8KZwLoP9WuQT4+gM69XqzU8vucZ6Kf6NWOE6QzgnhQg7LXd05cQ
         UgKZEqOKo9bBDwcjVE93vxVDw3XSQ1UPjJg+nC0g8PCgbOcw38bnkfYgAWAH5G4tHsFP
         +4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9klMrKm/3PJPsH9a0HqCufZa/6Vrvj6NDHHgs6SRwqk=;
        b=Dtl2bViuodUElE+3559MdoMrgTuJQ4fgSWYZxi2567mPJlumHzBJZ7/PJYHiE2o75l
         FU+WPckcdz0iQi9GUgAYeocaFaylj3j0fXlyIYPRzvN2VpfgwEnw5frzxyGdCorrqIDV
         e1d+qIRTAiRb0LR3WglbtYyVUu+2q/doUBO9MJIW3xGZUsG55yFtdah3DVH9jAtB4t/a
         if/azkhHq0acwN+qpMzZrqM45Wwg1JwuAbBjdo/5xxNrNEfBrt3jYmWTQ26TrHkdJS+e
         P3IJSDLBaVqyo6sC4t0dqQnSvgrvsTpW9WiyHoEzaIFh0ZgxBoC5SNXYTavBDlRcmm/I
         2kMw==
X-Gm-Message-State: AGRZ1gKB61dvEUSF67qg9x8WZu/YOSODdFa1qgc+rx9wj+M2qX/bYAFC
        tyXBFuwII8Uq2pPyZMHkI03eFA==
X-Google-Smtp-Source: AJdET5eh9qS2xiVsYcwo2W/msU20vv4lzowJVug19BE2Xd2dwUU26CVKyFE+TK95TPRYawmJ6efSsg==
X-Received: by 2002:a1c:730b:: with SMTP id d11-v6mr3319072wmb.107.1542117722512;
        Tue, 13 Nov 2018 06:02:02 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:02:01 -0800 (PST)
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
Subject: [PATCH v2 05/25] ARM: davinci: dm646x-evm: use cell nvmem lookup for mac address
Date:   Tue, 13 Nov 2018 15:01:13 +0100
Message-Id: <20181113140133.17385-6-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-dm646x-evm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 3e5ee09ee717..8d5be6dd2019 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -32,6 +32,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/nvmem-provider.h>
 #include <linux/clk.h>
 #include <linux/export.h>
 #include <linux/platform_data/gpio-davinci.h>
@@ -342,6 +343,27 @@ static struct pcf857x_platform_data pcf_data = {
  *  - ... newer boards may have more
  */
 
+static struct nvmem_cell_info dm646x_evm_nvmem_cells[] = {
+	{
+		.name		= "macaddr",
+		.offset		= 0x7f00,
+		.bytes		= ETH_ALEN,
+	}
+};
+
+static struct nvmem_cell_table dm646x_evm_nvmem_cell_table = {
+	.nvmem_name	= "1-00500",
+	.cells		= dm646x_evm_nvmem_cells,
+	.ncells		= ARRAY_SIZE(dm646x_evm_nvmem_cells),
+};
+
+static struct nvmem_cell_lookup dm646x_evm_nvmem_cell_lookup = {
+	.nvmem_name	= "1-00500",
+	.cell_name	= "macaddr",
+	.dev_id		= "davinci_emac.1",
+	.con_id		= "mac-address",
+};
+
 static struct at24_platform_data eeprom_info = {
 	.byte_len       = (256*1024) / 8,
 	.page_size      = 64,
@@ -815,6 +837,8 @@ static __init void evm_init(void)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
 
 #ifdef CONFIG_I2C
+	nvmem_add_cell_table(&dm646x_evm_nvmem_cell_table);
+	nvmem_add_cell_lookups(&dm646x_evm_nvmem_cell_lookup, 1);
 	evm_init_i2c();
 #endif
 
-- 
2.19.1

