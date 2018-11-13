Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7041AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389E120868
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="flIOjd+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389E120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387738AbeKNAAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:00:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55297 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387646AbeKNAAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id i73-v6so6743762wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gfq4XRjjbAnhbxC0lgPGakIYrPJx0tENtiXKTaGI3BI=;
        b=flIOjd+6kFlVvUssc1XI60NRDkppc7AOUcbQs8WkhSZGBtFjuBtU92y0kC3j5xhchk
         EipnF51qbtzluJ7dOwyp2IZKZnW0goqSf4MX/Em6jBiAZ4t4o9vhyxHZMfmAR5t+0HNB
         Ys3aiIuvhVa/+O3hF79UN7yh33qkyNEaBHuoHtVGfnGn5wbe9z2H+eo+f1Zc3FbVJmFH
         8wnPA/EP0FnSaiP9QX43G6lCFSupgWHMp9SxOXaEZSK+jonH5iwJ7bJ9LqtGYSorTV7D
         +WVQzV15CLUc45vAnldhnf018i57oWUwEnopThjG6YXezJDiQrsT0rb0PF0ZQqXACH93
         udbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gfq4XRjjbAnhbxC0lgPGakIYrPJx0tENtiXKTaGI3BI=;
        b=mxvqIWjFKEVOb/1imYxM5LDAwUSSnVW/rXsXOIsMXVc0qxNDynAglzszbr0jPTL6wm
         Lyj/4XsfyNtBLx343CjUMRwDb+kuTdz5nh18bhQmBfRgTvqfIN2hXNAkghQuFJwPeueN
         kSTfKpl19HpPE4+nnrbzQXm3QiNbwdfaLe2oV017iGpdXAKPHoHeAZBrsnVNDrmfX+85
         c80PuPfUBNSbc6+UV1PIoOPhcO7rB6p/06bmJVkerre3EcwedBbFH3OlIwO3RHpS4zZA
         vWoGTtTzqIwYRpqrmm9VCxsgYrmrKKOaYFVPSH7YakzfzqzzD9U9IwIyItGi++bwqyT2
         Jg3Q==
X-Gm-Message-State: AGRZ1gLwPBNtAkd1pzxjAPSMkr/sq+XNDbrYcejytaE5kif71k9s0cjC
        /H/PVFTtCWoPajn0G0qovF7YJQ==
X-Google-Smtp-Source: AJdET5dVFYdef5NnXnoThRlxYuwormlMCw9pHVyvcwkVBO5TMKrATK3PcV48UNjo/+oa88y/xv/4uw==
X-Received: by 2002:a1c:58c5:: with SMTP id m188-v6mr3181760wmb.85.1542117718885;
        Tue, 13 Nov 2018 06:01:58 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:01:58 -0800 (PST)
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
Subject: [PATCH v2 03/25] ARM: davinci: dm365-evm: use cell nvmem lookup for mac address
Date:   Tue, 13 Nov 2018 15:01:11 +0100
Message-Id: <20181113140133.17385-4-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-dm365-evm.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 8143756ff38b..8703fc18dd3b 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -24,6 +24,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/slab.h>
 #include <linux/mtd/rawnand.h>
+#include <linux/nvmem-provider.h>
 #include <linux/input.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
@@ -203,6 +204,27 @@ static struct platform_device davinci_aemif_device = {
 	.num_resources		= ARRAY_SIZE(davinci_aemif_resources),
 };
 
+static struct nvmem_cell_info davinci_nvmem_cells[] = {
+	{
+		.name		= "macaddr",
+		.offset		= 0x7f00,
+		.bytes		= ETH_ALEN,
+	}
+};
+
+static struct nvmem_cell_table davinci_nvmem_cell_table = {
+	.nvmem_name	= "1-00500",
+	.cells		= davinci_nvmem_cells,
+	.ncells		= ARRAY_SIZE(davinci_nvmem_cells),
+};
+
+static struct nvmem_cell_lookup davinci_nvmem_cell_lookup = {
+	.nvmem_name	= "1-00500",
+	.cell_name	= "macaddr",
+	.dev_id		= "davinci_emac.1",
+	.con_id		= "mac-address",
+};
+
 static struct at24_platform_data eeprom_info = {
 	.byte_len       = (256*1024) / 8,
 	.page_size      = 64,
@@ -781,6 +803,9 @@ static __init void dm365_evm_init(void)
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
 
+	nvmem_add_cell_table(&davinci_nvmem_cell_table);
+	nvmem_add_cell_lookups(&davinci_nvmem_cell_lookup, 1);
+
 	evm_init_i2c();
 	davinci_serial_init(dm365_serial_device);
 
-- 
2.19.1

