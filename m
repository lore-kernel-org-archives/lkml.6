Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038EDC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC78E208FC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="qYDhdejX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC78E208FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964935AbeFZK2h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:28:37 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43138 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934712AbeFZKXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:23:20 -0400
Received: by mail-wr0-f196.google.com with SMTP id c5-v6so5502139wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CVC/eOoTlU/+PkIhjzQLRTpQV4C3GBqkw7jiGbnzbcc=;
        b=qYDhdejXW0Ofc6Db568aE20XSUq+x2o8L109R28CHP2WSMK5Road1NnGFqbjSXcVZN
         W95jrHm8C7LYMxMD4tj8l7yeHXYQsOB7r2tHwa+WnNzQtaEZKdA86wH2WaTx9hV8uSk5
         IuqunepZqYW9dTEa2TqrtFspGMUYeVbm11l+eDXwDQGF/xG4cqQof21vJNHSyMYmL8X7
         WNIP2FM6m3F4qxcYb1vRsYbcPQlkuVByeNe9mHBxi6CBGMLhr8YiQ/P97HWdRrVdNi8I
         Kt4eQEITJ1klKX0D1dcthOL6h7lwo6kxSfUNT9B7dzo/LbaLeK8AP9FBFC4scOt8xQ5q
         hvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CVC/eOoTlU/+PkIhjzQLRTpQV4C3GBqkw7jiGbnzbcc=;
        b=IPRYzkVUaJvJkqtmtHq9Q/2HiwB+1z2jtAZ8RLxrZR4esTeo55/pJbt4Q4tczpZEC6
         tV+jYNpTnOvFGWyVHM2ns7QcWpJ3O0ZhWXwWlZtZafUUoNXVdIKtSrlQbXQAEJY/3rdR
         50aAJOiLIU2t5WX0H+t+wDJ3KXWN8lZVwMeyeAbJVnx/DVWA+WVHT8OFyhZSeFN5lQik
         82ypIM0rwYm9UuNJ3/UJgCTj5CFGhwzvap4ZMhCkb8381IGuRJS5zMJk3yvMqx9WiQzC
         BYp8wdYFyDbKfNXodiF6c/Ki1Lgho8RlxNpSkZ7iiwqkl8zofbs0N28SmzWFZ9aARmE6
         Tcgw==
X-Gm-Message-State: APt69E1kopqkskiwGRIOfbljsHhHct/5/OdHD4GjpLYS2XKgqZemxlRX
        T7FVM1cVjgn3fgAgCewgvy6rrg==
X-Google-Smtp-Source: AAOMgpcjgd9fTOB/Uiur4hJgOoXJDqigucgTGlCt3H9z5C2IV9O5Kl02+G+yQACj6xFINYpRlL1EKA==
X-Received: by 2002:adf:b839:: with SMTP id h54-v6mr965338wrf.36.1530008599282;
        Tue, 26 Jun 2018 03:23:19 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2573852wmp.23.2018.06.26.03.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:23:18 -0700 (PDT)
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
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 04/15] ARM: davinci: dm646x-evm: use nvmem lookup for mac address
Date:   Tue, 26 Jun 2018 12:22:34 +0200
Message-Id: <20180626102245.30711-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626102245.30711-1-brgl@bgdev.pl>
References: <20180626102245.30711-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support nvmem lookups for machine code. Add a lookup for
mac-address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-dm646x-evm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 584064fdabf5..4c82d38033b6 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -37,6 +37,7 @@
 #include <linux/platform_data/i2c-davinci.h>
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/mtd-davinci-aemif.h>
+#include <linux/nvmem-provider.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -310,6 +311,15 @@ static struct pcf857x_platform_data pcf_data = {
  *  - ... newer boards may have more
  */
 
+static struct nvmem_cell_lookup dm646x_evm_mac_address_cell = {
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
@@ -802,6 +812,8 @@ static __init void evm_init(void)
 		davinci_init_ide();
 
 	soc_info->emac_pdata->phy_id = DM646X_EVM_PHY_ID;
+
+	nvmem_register_lookup(&dm646x_evm_mac_address_cell, 1);
 }
 
 MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
-- 
2.17.1

