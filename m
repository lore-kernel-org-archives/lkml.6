Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40807C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A57274C5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KHtzkdsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A57274C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966712AbeF1Od0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:33:26 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46328 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966644AbeF1OdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:33:17 -0400
Received: by mail-wr0-f195.google.com with SMTP id t6-v6so5743390wrq.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+RU0zhV5JnY9YYfpoe84W+S+N50VABMSZ3/deF1RX7Y=;
        b=KHtzkdsOz9x/UgL+SoPpO/zrS4R+XN+tmNso9TvAsAN+D9Dr+hNFgePT1Lp0Op46rS
         +Fst7BB6HbRNzS6iqZiJGncTEg8Gemzfqx2BajYrB2fvV0n/4frJI7zRVB+LCJVFbI03
         M0aocuVD7ja/ILi03DUAp9ScaVKe35oU+sPTAg5QLOlxErMyBs5raxJ3E4xdJN/mBYJ1
         L0xuqMO2DFk2+eVlBn1Vy3qV4jVI/Y6QwHUb9RcK9ej79kF4wAeDuQ+wVyRW/bA22FtB
         Dbu3/83kPzaykWbM+ZaSJ6fREhvpvVORati0SnLKX/4RcFBKFhgcIUvdAZGr2lvG4cjC
         /SBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+RU0zhV5JnY9YYfpoe84W+S+N50VABMSZ3/deF1RX7Y=;
        b=s/FnJWgDkc/v2D9UXmSOEtx9kM3kthQBHsyNfHJjkPQUC9Rh7RhEWfq9qxg4UhUGlY
         Spce/p3ew672OWDRHhPfXiKFoSHWE3sAtlR4zFwdpqhQM35DloSR02FyqOlk1/hLiFbr
         /1yuldeJk5kc701lIQGC/qLefLMNrmZbRQDABtaBOJOzEJdJ7pmgLLJONwotMdhCGQSY
         SiZ56h8/wQbO1Dj7/sTmuiZQaSpZ8xG4HJO1UzQl7IGTRkxItDsi/AUqtnRwkK4mpZnb
         uJrZLRcy3BX5DKK9Jglx3P/jrTxJyPd/gAl+KbGLoagbyfy97Gy6E4TXmFEiVHoTTpZn
         Ijrw==
X-Gm-Message-State: APt69E0S6GHa1MTjMKIvZKWzC8NteGOmJlo688VGvd/xQIgOS1YTwwIM
        JmiFm+Abr/niPlcMiC72zIiTgDEIxYQ=
X-Google-Smtp-Source: AAOMgpcK4f3S+nFzcKzMfeSOy55ns231SscYLa/PhBscI5P3ZYcgckZBW3nDzg0NeSr8dlbQL5YlgQ==
X-Received: by 2002:a5d:4e49:: with SMTP id r9-v6mr8574652wrt.27.1530196396588;
        Thu, 28 Jun 2018 07:33:16 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id 4-v6sm8037499wmh.14.2018.06.28.07.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 07:33:16 -0700 (PDT)
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
Subject: [PATCH v3 06/18] ARM: davinci: da830-evm: use nvmem lookup for mac address
Date:   Thu, 28 Jun 2018 16:32:32 +0200
Message-Id: <20180628143244.4561-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628143244.4561-1-brgl@bgdev.pl>
References: <20180628143244.4561-1-brgl@bgdev.pl>
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

