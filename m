Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D98C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361A2268E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="IZ2QM7D1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361A2268E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934767AbeFZKXX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:23:23 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46073 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933581AbeFZKXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:23:19 -0400
Received: by mail-wr0-f194.google.com with SMTP id u7-v6so1386736wrn.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YUevR5Ixj5eTkRIhfoVHLcI/JheqdImeN8VTMJbrIx0=;
        b=IZ2QM7D1PZpFeqpg95k6JaWjvanpXXHD15DDd9A8BESvDiPjpKTRykMmQDbxIBhizD
         v4JM9GLpFNVTIGTYeYyVg2UkTjY8+JOhhd7Eh4wtnT4ajYIztkZ2Syam18zEdhU8NYS2
         +o35ZmCdMjYXiLVoZ6ImxT3LAhgwiQBfA1hIpWpTVrloMAP5En/rI6U1TVZELAe4j3cE
         7oh5MLJeXnvTKSdLSw8MJwqUXYb9BeYwEcKyKfNKIqoO4dfqHTthYki/Hj//HhuWy2qQ
         LKRmXv4fdqgrkNYdGYyxk3gmnVQJoPEok4YT/ATpyOwUjLpXDCbooT0FEflcJ88Dn5tn
         LDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YUevR5Ixj5eTkRIhfoVHLcI/JheqdImeN8VTMJbrIx0=;
        b=UcY5UB0oNXZo+oFuBlXt8Qx1RoTQIpFpRrHo5tKx+zl4BQtRXVPcHhVNObnT5Ri1Gj
         5XX/SxBZhU8cjpKBUyBnq2O5e7pSKlthkSTdPgqSr6h+o3Go0z/jxh6jxWuDgHGjm3rB
         Huj3UwE6E8z8yYt+Edb3XAgW004xdbPHaectJTl33hTtvLKyb77sewrB/Zhjc24CDes3
         m9VBSKqUXwJ6eNoxVyjU+kEKQTa7jJDIXkz0MU7yuvABZDPTtIQfIfE2Odk3EQ816Klg
         2RPkNBqu6c86pzVryKJLtNME+CsCAf2dFfBpQwOcnfGZ5P5xNxT0OvpeeSCPvdcLj6ug
         fGcA==
X-Gm-Message-State: APt69E1+Bu9FpULmMwvxwqzKS/ZQbAGCARoPiI4OeHe2Jg7BcW4Zu8+6
        oPWn1UEdCJ2nq44bhGYv5y6jZw==
X-Google-Smtp-Source: AAOMgpc1F5SGLq+8WdvlgkqVnwrWXa7ygk3EzZsTdv4CTlRUzskedQQr7Wv7yDHrCWocRVXh1kVhqQ==
X-Received: by 2002:adf:e207:: with SMTP id j7-v6mr919175wri.205.1530008597600;
        Tue, 26 Jun 2018 03:23:17 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2573852wmp.23.2018.06.26.03.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:23:17 -0700 (PDT)
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
Subject: [PATCH v2 03/15] ARM: davinci: dm644-evm: use nvmem lookup for mac address
Date:   Tue, 26 Jun 2018 12:22:33 +0200
Message-Id: <20180626102245.30711-4-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-dm644x-evm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 48436f74fd71..adbe8630ef19 100644
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
+	nvmem_register_lookup(&dm6446evm_mac_address_cell, 1);
 }
 
 MACHINE_START(DAVINCI_EVM, "DaVinci DM644x EVM")
-- 
2.17.1

