Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D164C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF3925D7B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ms+hgwKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF3925D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932266AbeFYP4E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:56:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39509 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbeFYPvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:51:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id p11-v6so10554004wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CVC/eOoTlU/+PkIhjzQLRTpQV4C3GBqkw7jiGbnzbcc=;
        b=ms+hgwKVZsIIwcZ0lnDLW1Wuthnhzt6U71ETgeVlrk+hnAy81riPHeN11pQ2qVmgHD
         M6GVxPwROTHcPBzYbgZVFJ2uxYktTn9JenIsG6AzhVVCBsDteAEGGyjVcziy7qS7xB70
         k2ZZcEEOzyL49Y4f6DwJlafMDozI2NTVNollu5QrnAuwl1IX+7foI6rwbBEc95mhItTC
         44wycrrPKkygOdqLclwx4VUsj9xtsIuWlVA80+KztvGZHSST+vVOinA9QruX0TtzEOvp
         gO6J5jt4neljzmnXfQjhCx/l/7GKxStx9Z43Jw0YDSWYGN7Xs0CsB/ZZxHexfgYiXwrL
         ytqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CVC/eOoTlU/+PkIhjzQLRTpQV4C3GBqkw7jiGbnzbcc=;
        b=esKQQL0gNmpyFQSBbtyNTq6kgcb1SGw1jqpzMGdCVX3VZGZh1Wj5AJVLnwDOa4xlEO
         H+5Djuag3OJK1XRyZ45jbJCEIVK4jAgg823s0CYFLX5l1UvvKYLkw8cvEBqo/OtvzrJ5
         FNlA69D9BugkXFTBihZeI2APp4D5QnpDM49msKTsqVh0DM4s1oE3/9Wqrxeg806fOAbv
         wfSFQHQ2jOTC2dbcBF5uvDJeh4pfQzLm5TFMOE9jeFC3/TS1cxHYtdmpYazm92y1UIPP
         E1gI++gI+Z9p9RRGQNRENqbvVzbg3LnSJjcFvxe8wN+zS3wIY8rBeX79k6YF9g+FXl27
         FYqQ==
X-Gm-Message-State: APt69E04APs6Eescz1PH9OHXmoi/P95PQFx7o++0drkO8ugavZ61ykE/
        Mrx5xAnN4hZUXtKlfF3msABv2Q==
X-Google-Smtp-Source: AAOMgpdfOLg1h1DnMJ+i1Q8DWd+Ch7dTFRRz2TM9MGhg6yYOnIg6cg9I/HjR2KS2VLRz/91gefP+lA==
X-Received: by 2002:a1c:cb8e:: with SMTP id b136-v6mr1486661wmg.112.1529941883454;
        Mon, 25 Jun 2018 08:51:23 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id x16-v6sm3523737wro.13.2018.06.25.08.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:51:22 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 04/14] ARM: davinci: dm646x-evm: use nvmem lookup for mac address
Date:   Mon, 25 Jun 2018 17:50:15 +0200
Message-Id: <20180625155025.12567-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625155025.12567-1-brgl@bgdev.pl>
References: <20180625155025.12567-1-brgl@bgdev.pl>
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

