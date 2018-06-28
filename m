Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE33C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C0223C46
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="xW/y215G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C0223C46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966917AbeF1Oim (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:38:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37491 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966620AbeF1OdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:33:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id n17-v6so8802901wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8vikMWRVd5RpNbpIMgIoO4AUKuTDf/0imXwnHOpRp0w=;
        b=xW/y215GlSBadHN52RnfIpsFowaA1AI0wsrYAd7ssAs+XAt3SSS0AtIxNA7IMBofdS
         guk1tabXrUU0w27ZnC+x++nmXHrVRZx/WDmokp3NGwn/+LM9Xq+7BFw+K5+8hq5Cryix
         SIRRrNzVSsvM/KDcB4p5jiUEhdmWrrBd9QFEg3CEfia7IoT22uZGPSWp7uhiKS4kOg3K
         VbIMtOENoa4e/pztNfk4fhIjPZiwHEe+IaRjnlo1LVOdc89APsA6koluAWMrHT6VD1FV
         pOMrchLXuZ4MebN4+TeIBeXNYBICuB3LnMLF1yJ7fZEi+RvltYw+xY/HEKvPRvxSRlec
         CUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8vikMWRVd5RpNbpIMgIoO4AUKuTDf/0imXwnHOpRp0w=;
        b=tcUuyPv4bPgOzXn+xSyAh4dh9TL/sSeWtqL3oRF55QfLcQLjKrO1RTI0hBit0uu4Rr
         5nLvgt0RqGkhqaRR8+a+dOlov3qeSu7nC/f4gHDvo0nkP89sVmrJKm+gkAnyLS821ZWj
         DhY6f4QDGYHQvUMyOHSakz55I0C4Qzerw4+aIyl9IfSm0d1Oj23I93zzBPSU+hfqF/d0
         QRTJ3BhAF2pBsREp0xKa/Re80k71xHsaX6fV/BMUBRLZ6/L2e+G58CZDow0Yzda3P+kr
         kbnmz5sQ0xG8ewavyxfsRGCyYwiCvsJML86fU0R8SaiM3MWgZwvrQtkQrLvh1BildAOf
         vPYQ==
X-Gm-Message-State: APt69E0GzCAOo9/LwhwnVPLQXUFBrtT1400FW4BmFxFpqEBbMqM3EhVn
        NfFbpfEFXM1YhW6CZuBz5ULG8g==
X-Google-Smtp-Source: AAOMgpcfZ88YhmHAEgyRsx1BLSKtfKtajgjhIpDDixA+zBfo2tdRB0/AqAgmuqqPDCTYzdYfgUhXvA==
X-Received: by 2002:a1c:7d47:: with SMTP id y68-v6mr1935224wmc.62.1530196393996;
        Thu, 28 Jun 2018 07:33:13 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id 4-v6sm8037499wmh.14.2018.06.28.07.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 07:33:13 -0700 (PDT)
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
Subject: [PATCH v3 04/18] ARM: davinci: dm644-evm: use nvmem lookup for mac address
Date:   Thu, 28 Jun 2018 16:32:30 +0200
Message-Id: <20180628143244.4561-5-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-dm644x-evm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 48436f74fd71..6d35c6e1b0bd 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -28,6 +28,7 @@
 #include <linux/v4l2-dv-timings.h>
 #include <linux/export.h>
 #include <linux/leds.h>
+#include <linux/nvmem-provider.h>
 
 #include <media/i2c/tvp514x.h>
 
@@ -476,6 +477,15 @@ static struct pcf857x_platform_data pcf_data_u35 = {
  *  - ... newer boards may have more
  */
 
+static struct nvmem_cell_lookup dm6446evm_mac_address_cell = {
+	.info = {
+		.name = "mac-address",
+		.offset = 0x7f00,
+		.bytes = ETH_ALEN,
+	},
+	.nvmem_name = "1-00500",
+};
+
 static struct at24_platform_data eeprom_info = {
 	.byte_len	= (256*1024) / 8,
 	.page_size	= 64,
@@ -828,6 +838,8 @@ static __init void davinci_evm_init(void)
 		phy_register_fixup_for_uid(LXT971_PHY_ID, LXT971_PHY_MASK,
 						davinci_phy_fixup);
 	}
+
+	nvmem_add_lookup_table(&dm6446evm_mac_address_cell, 1);
 }
 
 MACHINE_START(DAVINCI_EVM, "DaVinci DM644x EVM")
-- 
2.17.1

