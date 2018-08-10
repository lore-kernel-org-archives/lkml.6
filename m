Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168C7C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C5C223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="d8jmMSS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C5C223F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbeHJKee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:34:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37998 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbeHJKee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:34:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14-v6so7466457wro.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XaPQ4DQ6E4mkvE8/vjM2arlDkF10+DPHDgPAjo5lV1o=;
        b=d8jmMSS0r7+bNNo9YTWkd0N3UUg9gNZCUwkFuspa7Gad0bgKdmW/SeArVPVrICkkua
         FQqpNjEcVPxQySfOunIGiXl6cz7TL6ZiMji570BUqzEEsKx5rA4G0H6bN4HQgEDubpfj
         3zWoapKg2/vI+/i/ahfY/KQmexgSBloSnXPmIHK5zcelobeGazNfZqbb+frzVRqE5pbS
         8vB8HQt41QuBYNax/SCdrX0x2nl6TKXU80Z+3iyHk18vtYyVDbuI2bOlNAvNBQypGXbt
         Om6P0IJxqvIHvT2a+7TsLHhZxOkdHD3smm7hy7Ft9aJtqmHUvQj7C43je8QxC9mH4p+r
         9qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XaPQ4DQ6E4mkvE8/vjM2arlDkF10+DPHDgPAjo5lV1o=;
        b=FQ7sjOLWvjzkIb4XtIsf9ieGKKyfzPttleFWBW79RWFhNQ8z2xnwz4nSnpwrO4NNxS
         eT9tWrf6i3cgE+Do3DGz8FS9L4nG8/nBk4Q/2sCcec5CyTbzjqYYjuyiPaYhhKXZZStl
         Z9H0p3zUhtCgiWXyfdxFvDhmGQkvfPp95KkQrsCyrpDNPoNHLWtGrFT5qnEyK59qz01g
         wXX3k9GNYzW8YtEkxszludqffa2OloadPoSmebb1/o4FE+q28wyKTpQWjKN4fl73dmwW
         q4U5BXvAHqaRbtFRU4APKMhHoxH1w2MR6uZYBGVlLxqvw45+rNJALwv2+Fbo+pH55XWU
         TmYQ==
X-Gm-Message-State: AOUpUlEqN5OwGWSm00xk6JidVRvzZbvUFwd9epluE4/IiQb4fkrLYKsM
        hJpBddsbn0lGOB1ioGhMvfmhoA==
X-Google-Smtp-Source: AA+uWPwQ3qUFHPIEb7YNFm4XR8ZZUcQKNFNhNJMaN7NNGTv93XBpAeecOSbYW+Y3pEJI32GxaQ0evg==
X-Received: by 2002:adf:ecc6:: with SMTP id s6-v6mr3665670wro.160.1533888348097;
        Fri, 10 Aug 2018 01:05:48 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id h7-v6sm9546405wrs.8.2018.08.10.01.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:05:47 -0700 (PDT)
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
Subject: [PATCH v2 08/29] ARM: davinci: dm644-evm: use nvmem lookup for mac address
Date:   Fri, 10 Aug 2018 10:05:05 +0200
Message-Id: <20180810080526.27207-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
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
index 48436f74fd71..829fa1c8d0b4 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -22,6 +22,7 @@
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/nvmem-provider.h>
 #include <linux/phy.h>
 #include <linux/clk.h>
 #include <linux/videodev2.h>
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

