Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1476AC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1C227C72
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="IPzhrL/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1C227C72
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935732AbeF2Jk6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:40:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56286 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754722AbeF2Jkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:40:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so1476545wmv.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UGz2gYHTeu1D++Ca38OeE+7ttdk0CFVrhyKKlCaVXXs=;
        b=IPzhrL/Wfl5EHcc2OjGi/1xooGj0EAxTifM32A3NSCR/y6LSMrO03YbiChhNBBt/Wp
         jijHgGa15QFHeDK0V5+ZyPp00D7V4aWXd4S8C86DfZADwkpnGbMPM2ThQK4v60Mj8jJs
         g/Y+/H4gm86pfaQcXOXyTQgKUqqGrxiDoU8qk41Wk8jrq+cmPtyNT5KrbpETQprE6oDC
         tfR3sQFkgG2D2YmyWx55QeoViUxzjJyaQYMrPp7gMp4WnMsBlAHRc3vZbusg5RzK76Xx
         vu3nR3+Py4jqg/h8yP0kr9H1NGDtBvyjLbwqlwITc8a9HoknKRg5pZOtpkOA3jeJRTFR
         64oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UGz2gYHTeu1D++Ca38OeE+7ttdk0CFVrhyKKlCaVXXs=;
        b=Q2QbGlky7dF+33oldiVA4g62rhOJ23TGYnK75E4pYNvS36gwN44wSz1DgZC+KmKEiY
         lZkOc8WvNuIsmaK2P/qquKt/wk7DS24caX2HBKnqTJpwSjGd3K23HmtZsZg/pK3saoBc
         KZWlhMqWAUzJWcsWGX/bcmI52HWapc6JTr3vncBNf9D/WMHy6vLp/KB4gHOuwpY/pLXh
         ej3VsQsJSdK09QiHjlCfQVDUaNAxnVE2kS5LprCTQK68zUXUyRDvjZj0Ymw9+WFdOtJ1
         ahJskfleRl5bVZRq6uhMJyXvR+U4cqs2bhNZmw0jYLpQPqMVU0XQZW3KU8hpTkEVOXQu
         N3Ag==
X-Gm-Message-State: APt69E1oqACHNk44pk+WO863tnTxHfXV0Hr+X6dhI35FBjPVLr9bvsrc
        MI3jhFQrqcQUjGV24noCTprGXQ==
X-Google-Smtp-Source: AAOMgpeDUO0C0K+/mlCkuVpSDtEsyHJVWrL69tI3d2CsBvuERqwQaYuDKywNtlI2L1Ikh+KJdNSf4g==
X-Received: by 2002:a1c:8312:: with SMTP id f18-v6mr1253255wmd.127.1530265250476;
        Fri, 29 Jun 2018 02:40:50 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id d102-v6sm1386394wma.10.2018.06.29.02.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 02:40:49 -0700 (PDT)
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
Subject: [PATCH v4 05/18] ARM: davinci: dm646x-evm: use nvmem lookup for mac address
Date:   Fri, 29 Jun 2018 11:40:26 +0200
Message-Id: <20180629094039.7543-6-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-dm646x-evm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 584064fdabf5..5a9de47bc8a2 100644
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
+	nvmem_add_lookup_table(&dm646x_evm_mac_address_cell, 1);
 }
 
 MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
-- 
2.17.1

