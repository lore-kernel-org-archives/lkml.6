Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B936C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB12D25D72
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="NZDrb4LZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB12D25D72
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755425AbeFYPz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:55:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36899 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753027AbeFYPv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:51:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id r125-v6so10572164wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qDcomHocfb0UTWNpKg09I19AVkb09J7DVriHdyGCECI=;
        b=NZDrb4LZLkSDqZfojWGWuejLVM4ujk3TzuHgSzlm2p5RPvLFxgIf7M++AM1+9+92Jt
         PpXWgEoQ+TXN2ryG82HXieONOlG1WKALBMTcixCb3pr9spcbtYsnQhk+cNcm4ZVs5Ell
         0MyME9I/6+roHcR1WKi5G6L6ghZB8NvWTzSLIyTxP5FIg/K2aVNIDa4OSXHOs7xyedrr
         eVymJAc0M7BSCywdhPBz8tiyAqkusRWxOV7XoXF19iRBmV74HLvkzmnXOiNoTpbE2mMt
         UNoBQKJhJ3RTtSakjZEh395jAZRYM4IBZuG5pibb34OoIR8EoMG+WKx80j5vuuGWd2Y4
         cJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qDcomHocfb0UTWNpKg09I19AVkb09J7DVriHdyGCECI=;
        b=aeySRP78SasV6dGJjpbRCPG9KFb6+uOQEgKgHDNhOygqNaV1KhuUuZ7t2t0d2t5A6X
         rNGvNsEQFVAe2GxBCzOJl2y7w5ezecZXxrFSG8RN8XARlH66zBzB+GM2C++CWmtfqZXp
         ZpHoDEO4nWRfV+oMrYjOYdSAJUb5sJ9m+w9AGRs+N0I5BWGNMsnqBIkOujqV2AJcoNEN
         Ov8LaK87dXaIiYLxJZ0CwTLBi5I+HJ4628Gt2UIS5atqe6ImmZv/kanmuLAMtqKeoSD2
         OKbygxbfISeE0Uj1jdv3/b/ZntY7r+j1rqcsU6lhpP/NbYy0eOcZBsFRLm4BpFZJKkeY
         7d3w==
X-Gm-Message-State: APt69E1tFkPI+keeWk/g2+E/xuK6IH4W8xqb1tDcxQMABj8NpOxAyKWZ
        xafZTGYECj4iktvx6U8av8KBxA==
X-Google-Smtp-Source: ADUXVKK7L0YfEl6wV7fAUrHzRba9obcauKxKfgL2nTZ+lv63HHlYZDwLlpQqI0mysPUlrF7HSPS+fw==
X-Received: by 2002:a1c:7212:: with SMTP id n18-v6mr1447596wmc.5.1529941884857;
        Mon, 25 Jun 2018 08:51:24 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id x16-v6sm3523737wro.13.2018.06.25.08.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:51:24 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 05/14] ARM: davinci: da830-evm: use nvmem lookup for mac address
Date:   Mon, 25 Jun 2018 17:50:16 +0200
Message-Id: <20180625155025.12567-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625155025.12567-1-brgl@bgdev.pl>
References: <20180625155025.12567-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support nvmem lookups for machine code. Add a lookup for
mac-address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 14a6fc061744..3be3e93f2f18 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -29,6 +29,7 @@
 #include <linux/platform_data/spi-davinci.h>
 #include <linux/platform_data/usb-davinci.h>
 #include <linux/regulator/machine.h>
+#include <linux/nvmem-provider.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -409,6 +410,15 @@ static inline void da830_evm_init_lcdc(int mux_mode)
 static inline void da830_evm_init_lcdc(int mux_mode) { }
 #endif
 
+static struct nvmem_cell_lookup da830_evm_mac_address_cell = {
+	.info = {
+		.name = "mac-address",
+		.offset = 0x7f00,
+		.bytes = ETH_ALEN,
+	},
+	.nvmem_name = "1-00500",
+};
+
 static struct at24_platform_data da830_evm_i2c_eeprom_info = {
 	.byte_len	= SZ_256K / 8,
 	.page_size	= 64,
@@ -618,6 +628,8 @@ static __init void da830_evm_init(void)
 		pr_warn("%s: spi 0 registration failed: %d\n", __func__, ret);
 
 	regulator_has_full_constraints();
+
+	nvmem_register_lookup(&da830_evm_mac_address_cell, 1);
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-- 
2.17.1

