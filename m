Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5B2C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8989727CC6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gAqKxmwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8989727CC6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753840AbeF2Jqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:46:54 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46264 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754672AbeF2Jku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:40:50 -0400
Received: by mail-wr0-f196.google.com with SMTP id t6-v6so8186567wrq.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8vikMWRVd5RpNbpIMgIoO4AUKuTDf/0imXwnHOpRp0w=;
        b=gAqKxmwQ6nNvtV8JzUC0NcVxi+XZIxU9MdjN+s8vFbeI6e5d+bZ49ObILCbbdek8o+
         wodO+sE/AMoAvg0seWrqzHe1stZ/TvPSRIpJz1WC81akB17BlNWZCsZu737wvAY9fT2W
         c9cprrVKAmZ3ATc4Cc8Y3mpN1yPNdHKyw1ln4TGNQ11WeYrIu6lEVz9cjWYb37X6OF8m
         8hEIQZYIvlgPUF2Z29ctA5+atB00SUmFEaVP+xhTz3tPDsYZd7kb1ofbcmRGwWT7xTGy
         wSxXAfsdWP6ESDmno+Qodi3lfhxle1DBzJenj4B7bamWcR8ybI6w4ebq+ezd9lcTYDAR
         /4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8vikMWRVd5RpNbpIMgIoO4AUKuTDf/0imXwnHOpRp0w=;
        b=cqOg5BegS7XFIkROfU3jGI+aRom3Kv///q1tgbXiic8jVXTf4pjsTRS+2yd38F1oew
         fU8Gpe91Uf7x2rDQ04Y6j8cuS1IfCELFty4sagRxOhXMEUYmybU49hO6MwqKF6UzVjUs
         oxVo3mETpg/GQvAGEONoIquMSKee/inMcyPeZHMA2T/GUq3/VMyp4GaAGYTEXJd6KBLc
         aAxShnOq+/KuVJYmRnshatdYD9SOfs/jCAHo86Hywa+1yyfk3321vqeSgUz6dgkq89AT
         c608iU/FIaRANynh2ntsz8Bfm0mP5dOzLn09gGWhHuE1E2pGLt9HTXmaDkF6XUqmHT+Z
         TXAw==
X-Gm-Message-State: APt69E034jxLS5xxlLc1IVXugK3WPpt1IpCHWzfT/v5ZgaQ3JsMP4hpP
        d9XjTweT7iUgN3UjpkSpqTAGsQ==
X-Google-Smtp-Source: AAOMgpf1qN5eVzpltpqvBoH+9Bc1OEfaP87a/MtRLl4vDZJuAGVGtKWtPYFfIyPkxQKMOWT39nwJSA==
X-Received: by 2002:adf:b219:: with SMTP id u25-v6mr11586114wra.1.1530265248807;
        Fri, 29 Jun 2018 02:40:48 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id d102-v6sm1386394wma.10.2018.06.29.02.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 02:40:48 -0700 (PDT)
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
Subject: [PATCH v4 04/18] ARM: davinci: dm644-evm: use nvmem lookup for mac address
Date:   Fri, 29 Jun 2018 11:40:25 +0200
Message-Id: <20180629094039.7543-5-brgl@bgdev.pl>
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

