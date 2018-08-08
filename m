Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3776C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F723208DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="aJkLKR3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F723208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbeHHR5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:57:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33697 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbeHHRxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:53:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id g6-v6so2426058wrp.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3wRKI0ad1H2vl0yNJFc7xc7E5f/unJTGeQQy+eD1Wno=;
        b=aJkLKR3bbxHEvPsHktybDHMDjy8Or0i5AfpgguA+wvFfLA/nY9ls2YSzs1tEKn4V9x
         P+o36ClWOqMj1Advaed1Z0ga5zZQdXXtWHsGQuqVnIkIvkVqyyeu/+/XyHHuaHHL+OZ2
         rBcr2W0DMDRW8+D2HfoO06Zz6pnrDpvaZDQRRtuVPYXRx4/UE226U5DZnwqZG7LnaYAP
         hlpfBbBXv64mPAfxxOQjiXcdCbTLYXJaja25aXaFuJnrATzXhFrRxOkpHhk1ET0dfXlv
         h/LBjsVnENhIfMR+Ajx0LsK+BlrR/+YD5EJqHuouER3WZ0Z4UQWeUnssUSwycbROWtOC
         zclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3wRKI0ad1H2vl0yNJFc7xc7E5f/unJTGeQQy+eD1Wno=;
        b=BCCIUXR0o5K7Xoy/4Y4S7QIqx1AdZ4jK2AVH8xwKPyDch6vnPOSHvk9/uvph6bbZ+n
         HWYo78hRBbLYSIURpr4QjIcNV5XjZ16pdhkDNlax1sZKz42apOtIVwjNxarozHiBh+EO
         fPfxlpgrs4dVGAhXv6rYXaSr7yMwkQZHwJ/txP5P9fAdZUbasyQYZ3lTQLCLKeUk6QGr
         X4x5x3gejIXFmm8Q2Ntzfyhkrcf+CVC0y4Kw1xs/fvzZC/ivzUgUWUPW/7t/+wavnDOb
         xMq5tOQtfvXv8+3q8WHSk5Mh9uyJLAfYL3fYKPO0pzoNHCm0aBqAWJW/CJBRezhYyZMG
         wIBQ==
X-Gm-Message-State: AOUpUlEJlBef/Xll/A/AzuJhje3iq5oIxEsJKM9GbVvvq//cKu1z5M9Z
        EvuxF2DkSbbpcJt4bKUxYLfGoA==
X-Google-Smtp-Source: AA+uWPwJYWYegcNZbeKMBZMz2f9+sA8gZ70FgajA1DqoBnfzNa2LMBRAIYx1EGku1SjfhgcmiS3nlQ==
X-Received: by 2002:adf:8362:: with SMTP id 89-v6mr2319554wrd.147.1533742421830;
        Wed, 08 Aug 2018 08:33:41 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id s2-v6sm5240915wrw.52.2018.08.08.08.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:33:41 -0700 (PDT)
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
Subject: [PATCH 08/28] ARM: davinci: dm644-evm: use nvmem lookup for mac address
Date:   Wed,  8 Aug 2018 17:31:30 +0200
Message-Id: <20180808153150.23444-9-brgl@bgdev.pl>
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
2.18.0

