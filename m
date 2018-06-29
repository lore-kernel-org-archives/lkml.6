Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45199C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1A427CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="U+sAWmvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1A427CB6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753591AbeF2JpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:45:24 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46267 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754795AbeF2Jkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:40:53 -0400
Received: by mail-wr0-f194.google.com with SMTP id t6-v6so8186706wrq.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+RU0zhV5JnY9YYfpoe84W+S+N50VABMSZ3/deF1RX7Y=;
        b=U+sAWmvNuSrgbDC6BrFdeoaZ4hyFWBfqcGBPACt4D858L3dP5g6pjLquMX3gZb0gXl
         /b2I9Kctj0DMA6DEVzpcFAczMrDC1z23hLmFCyiT09qE+gb3lGuP4OBa4CSh8tFFceHB
         0ps4fDMOdN8yfbxN3TFFKQ/DciZc0+Sb7XZzv51M2K3zckjW3HVPaeGGLfuaSqE+ytdW
         5hP4+pB0umzi7QrvV7Q6HLo0Nx+o/Q5qRX8xiuevqfhhrAV8xOF1IZEORK5mTH9xq7/4
         dzip8EMi1Bxm6PmXEhVbWjiEKxEORRvxTsPYRQAWnxwb8Ywi1qMHgktRLjMh1yjQ5rXd
         FHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+RU0zhV5JnY9YYfpoe84W+S+N50VABMSZ3/deF1RX7Y=;
        b=jShHCJ2cuRfI/ApuUMgzVcmDJ2Gm3kF3JSxI5hVMk7j4cUjROpCsMEJLQtwxCEzXEV
         NzncwibpBq05s7MBROu7qyzgyRHAWp8gcvOlN+spsevt8i1p7UwQOCdDsmiAfyLN/o3s
         SioZvdsUurMMPjEmJVtPpLh0utZolHMw3PyiXy9MKbOyq2tEhGevTkBIFjwuxf9W678v
         Ku9koX9bznEypeEsYezJc8U0NAqd0Hi2zZC36Uxls3qDSlDF4+6LRmY02irUyfUcTxNS
         PTfiWhVhAUB1Z6dw5Dfg03jn0RICcCZ6EEvW5DZygbMZRdGY/dogR9aZjodODBHwLJto
         L48Q==
X-Gm-Message-State: APt69E21dgQ6edcYns/fo0MaZdHzQdBmlzZCyRQHrsyg5bjiTAkH4Sin
        hpTrbLHvmkjDFCIZIUm/QIPV2A==
X-Google-Smtp-Source: AAOMgpcQLYxARCCDDtLyUrBAdXY7rPJDbg/vv7on3yIx5vG8hnF0KNxPLQC7yRKkGWR5mELm1Oz4+A==
X-Received: by 2002:adf:86ae:: with SMTP id 43-v6mr10691949wrx.281.1530265251847;
        Fri, 29 Jun 2018 02:40:51 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id d102-v6sm1386394wma.10.2018.06.29.02.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 02:40:51 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 06/18] ARM: davinci: da830-evm: use nvmem lookup for mac address
Date:   Fri, 29 Jun 2018 11:40:27 +0200
Message-Id: <20180629094039.7543-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629094039.7543-1-brgl@bgdev.pl>
References: <20180629094039.7543-1-brgl@bgdev.pl>
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
index 14a6fc061744..4a2fe8142a2f 100644
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
+	nvmem_add_lookup_table(&da830_evm_mac_address_cell, 1);
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-- 
2.17.1

