Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547AAC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4D721700
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="fO4u90gR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4D721700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbeHHRxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:53:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40443 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbeHHRxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:53:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15-v6so2398424wrs.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3db+EwdA0BE/nKODKMaepKnhT1t81s2qEJflbfjuR1A=;
        b=fO4u90gRjcwJ1PkoMrvfUoqbmGq/lYuIUldc48QmVBYbNkJFkz2gyQukVu4JTNrBCu
         4UsEvaLrpuXhZlqYiH84ZBdMbEFONdoKwjKVbhJHQ26B7ebLQTjJH9pUDWMZ0KVwKRlE
         pdvJmEfg6MMindvOSEtSu/pqYSQQsbsT/jLgSOMC698QYXGPLMgB8Ca2LTqeTfJWYokE
         GNrAil+tILe7xAbtMnNqOkNbqC0PM6Z//6DnRbbR8PPJRFjGIt+ZgOTKi6tC1LYidaOq
         M3Jl95Rbiblq+r9g0Y/3ciiOog9D2AZXZTAJ8S/czLde/bQe1HlWLqDGI+ZSEQcW/AEN
         tmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3db+EwdA0BE/nKODKMaepKnhT1t81s2qEJflbfjuR1A=;
        b=V1YLmkeLCfrlhOlWCRipo7v/4tjJs5FtZ8GbQC1jfnXmwJiCt9rRitwsNyitSHf4VS
         ix6iB2bd3aHAwwuAVffn8lzFdMKLMAideXdmSnl9ysN96x/XJh+cdCbG+SGoaiSMQpBB
         qDig2ugKxcTSfTrp0WymCW+UEdF6Je6IMZjHrDgNHQhF5MHuOZVyCdWnAIWaQglwfyRT
         XB9LyPTaLUygjLZa5cjIJT4yyexaWaWXq1C+Q6uN+nAxxtHzq1h8/ioxweQDGPZA9X36
         aapdOuVYWMv/umhpUG7XJyHuQNLjycqwdeOaa1gAW5k9FIfMGMrdT/d2/Nk6vflWoE86
         OW8g==
X-Gm-Message-State: AOUpUlHT4/5aA8J8Z9afEiFimRv19jvdXuWAai3rOl+sufVlwtytnfnI
        3wz626t8oFSNOVN3O5ylJTsPrw==
X-Google-Smtp-Source: AA+uWPzi/DfnxkWlzRJWkuCz9Vk5iiOrkjRdGpqxGNn1tqWZ1Bwdhofy38dZ4+bn8pt48LHVGuy/XQ==
X-Received: by 2002:adf:9e84:: with SMTP id a4-v6mr2234951wrf.70.1533742419840;
        Wed, 08 Aug 2018 08:33:39 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id s2-v6sm5240915wrw.52.2018.08.08.08.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:33:39 -0700 (PDT)
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
Subject: [PATCH 07/28] ARM: davinci: dm365-evm: use nvmem lookup for mac address
Date:   Wed,  8 Aug 2018 17:31:29 +0200
Message-Id: <20180808153150.23444-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
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
index 435f7ec7d9af..cb0ac92a278e 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -28,6 +28,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
 #include <linux/v4l2-dv-timings.h>
+#include <linux/nvmem-provider.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
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

