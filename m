Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3053CC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CE221A27
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wrfabtZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CE221A27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeHHRx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:53:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35741 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbeHHRx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:53:56 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so3249457wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fI+k8Vv3yG+m9/MHc2+cp7aa8pgPxuuoC1DpPepTxjM=;
        b=wrfabtZwU/d/lWONYUx0VOtQu0zRo8SDOMXGZaxGqjyRN8QWvxmyd6SbS3aq7lswg/
         S9hPghko6V8V3f8jt6p4L6xkFi8AoJxRmBJHLLzrQXQrxjDTw1+Ysm+1wzTx4ELwjlNY
         t48/wtltq44OJVKx9fmN3gMtDLRvE5ElvSNAQDwAj2qnsvezlONIf1sZJQRSQh55hRj6
         37cUooOzfaTwRD835fPQAugWzVe5139PKPLxSXfqbNmUweCECgZqFePK8OKH6uihv3L1
         SIBBPnWxdwQNOoAVph2Ir7hv628hKFY6pj7rXguqwP0/yTZ0/CSTFZJVDKlLtsxSOtsj
         gvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fI+k8Vv3yG+m9/MHc2+cp7aa8pgPxuuoC1DpPepTxjM=;
        b=UbCRKvE2wBmpeT42+7hz9nEnOz7KVGvzU/UggnA6cC1+qQWm7YGKABonncU2lMc7r8
         RWvQhJWaJ0wV5tHOyxj/oti3lIkJduOCeTFn2LSqk5/s0caSIvl96Ic7kcdTw3NP4905
         8apcA0JqZdCD6m6Nb6bKNKzG4E1FHDie2ueGpzt0gtp4Z8GP9cSGDiiFaiXpPbZuyIlC
         MsoACjoILaRgao0h2zXIUOI43HFDUogoVDzku/8biQKr/djWX6KdoUR9xkSvKDf9IMUF
         vQbB8Ty6H3RnOQugynbF5b+qMVkkrE+rT/CRxrv3y5++t/WR2gUIBCwsAySHFVEq1Xty
         rPWA==
X-Gm-Message-State: AOUpUlEgiVqQWxL+zJuWZcwHYl1zxryLUwXyw1K9cqK7K/G2DKEfbsA0
        SgS+2oMzZQCx0vgVA1av8Gvwnw==
X-Google-Smtp-Source: AA+uWPwazS5HeG9UE/Vvb9p8w/R3WbqH+H5qN34D7bAmSZJ2/5xRLNYNJdPw+q4bssU/6gkiZ1Kb2Q==
X-Received: by 2002:a1c:55c2:: with SMTP id j185-v6mr2240121wmb.104.1533742424512;
        Wed, 08 Aug 2018 08:33:44 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id s2-v6sm5240915wrw.52.2018.08.08.08.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:33:43 -0700 (PDT)
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
Subject: [PATCH 09/28] ARM: davinci: dm646x-evm: use nvmem lookup for mac address
Date:   Wed,  8 Aug 2018 17:31:31 +0200
Message-Id: <20180808153150.23444-10-brgl@bgdev.pl>
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
2.18.0

