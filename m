Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA79C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E052086A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="s82lrLNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E052086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbeKNADa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:03:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50839 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387763AbeKNAAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id 124-v6so12120157wmw.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MBcgf2nPd9qfbo4Sweh/oy//ofcxfsuOB7x8NJzIAM8=;
        b=s82lrLNEYvwtPScP0erBPVI689DjeHX8K4Z2YOKi/1SbNbd5eo7CfaNHSJrgMzuut8
         zO9Bk5ivNlOydFEoQPPxnbcqLp/U4mY2k4zRm7qjZMBma4vcA71t7SDjzF2DoXfqwRUk
         laP2HhyYakJMGwV8sacGOq2A3J7+j4hCQKw5rnguQdLzm4fWk1zrLnNZVbaPz6T8yl+D
         GEjGlToCDSuoQyN/7vRoBRg59OXWmif238qYqlvAuxVy+dukgnvPQqlnJBwOp3e6FNF0
         5ax3cKWrCE+n/67huJiBalkiyMjGD5PL/H+thxMH3HmaxR5DpbPPGcTbx+wXAjfqxZ+I
         I6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MBcgf2nPd9qfbo4Sweh/oy//ofcxfsuOB7x8NJzIAM8=;
        b=FJPhtBsvPiw/ICu2lsrE5D0ZRLWU1l7ClrecFFKqBt6kilPcPkGzHXrk07Mw2d+iiY
         R3BKMGK6D0tmK+Ve0Zpk9Ar+JOcUKM66LbrcEA1/Jqo/P7xgTgaxt6LVTpXYzb9ozriH
         u1C2S1+vXpmgjl0U/Erne2SJ3NN3aPDVXJNlBVbGS6HBkOqHpd/5zD+/u3N0JcZPAO7I
         8PF+wi0hKH1Ba6431FdzGHWWwogzNno2CJmBBOr6CI1GGi305qP9kQDHxcWFToZRXjoH
         DD/g08HqMK3F0hjDEvop5qj0mOvmXGkyEwl0i7MarqJOsReWeV2nRT4aOsv2chXSu8eJ
         b6ig==
X-Gm-Message-State: AGRZ1gIo+r/xKN1zLpvNsvaczjfAMLqvveLBjV5UG6LvudQ5G9WwvIKc
        PIDn++Hq2sYkrGTFfLgFZ6MWmg==
X-Google-Smtp-Source: AJdET5eo0yk9C4P5t7GkAu/UgDBxNFHT6slEZbPHc0cit4MGTQjXPt6qB9J90xv8PBV774TU6lRppQ==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19-v6mr3147764wmk.151.1542117724688;
        Tue, 13 Nov 2018 06:02:04 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:02:03 -0800 (PST)
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
Subject: [PATCH v2 06/25] ARM: davinci: da830-evm: use cell nvmem lookup for mac address
Date:   Tue, 13 Nov 2018 15:01:14 +0100
Message-Id: <20181113140133.17385-7-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-da830-evm.c | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 7d8ab36ff83d..e52ec1619b70 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -30,6 +30,7 @@
 #include <linux/platform_data/usb-davinci.h>
 #include <linux/platform_data/ti-aemif.h>
 #include <linux/regulator/machine.h>
+#include <linux/nvmem-provider.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -435,6 +436,27 @@ static inline void da830_evm_init_lcdc(int mux_mode)
 static inline void da830_evm_init_lcdc(int mux_mode) { }
 #endif
 
+static struct nvmem_cell_info da830_evm_nvmem_cells[] = {
+	{
+		.name		= "macaddr",
+		.offset		= 0x7f00,
+		.bytes		= ETH_ALEN,
+	}
+};
+
+static struct nvmem_cell_table da830_evm_nvmem_cell_table = {
+	.nvmem_name	= "1-00500",
+	.cells		= da830_evm_nvmem_cells,
+	.ncells		= ARRAY_SIZE(da830_evm_nvmem_cells),
+};
+
+static struct nvmem_cell_lookup da830_evm_nvmem_cell_lookup = {
+	.nvmem_name	= "1-00500",
+	.cell_name	= "macaddr",
+	.dev_id		= "davinci_emac.1",
+	.con_id		= "mac-address",
+};
+
 static struct at24_platform_data da830_evm_i2c_eeprom_info = {
 	.byte_len	= SZ_256K / 8,
 	.page_size	= 64,
@@ -620,6 +642,10 @@ static __init void da830_evm_init(void)
 			__func__, ret);
 
 	davinci_serial_init(da8xx_serial_device);
+
+	nvmem_add_cell_table(&da830_evm_nvmem_cell_table);
+	nvmem_add_cell_lookups(&da830_evm_nvmem_cell_lookup, 1);
+
 	i2c_register_board_info(1, da830_evm_i2c_devices,
 			ARRAY_SIZE(da830_evm_i2c_devices));
 
-- 
2.19.1

