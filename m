Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31538C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECAF27546
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OkmCgaxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECAF27546
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966674AbeF1OdW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:33:22 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36792 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966640AbeF1OdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:33:16 -0400
Received: by mail-wm0-f54.google.com with SMTP id u18-v6so9344879wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UGz2gYHTeu1D++Ca38OeE+7ttdk0CFVrhyKKlCaVXXs=;
        b=OkmCgaxfVoCkXBNIGG2PS9VWKeU3H5fvipri13H1JWnghIQLxeMsMALjJJO4mUzely
         8mGGjqBykuuhUNh7OQ5ouXgTZaBOFhKR7X7Kfn/8oUQKG0xe0HKzuiVQMWdciWAuqmFp
         0rXD7jbrREp5jqS7pjnlZUlDjVQP6vGrAsKVv4rdjTrLSDz1GVQF6x9YUPagIqqgtLfE
         quT0PTQvpLGwu0iE4uTxoMHhnwgIXpev3pM5XqU6cqcPYk2BM819cMHsVZ5oAVQe/Lo3
         dVdKCGPMXqhG5l0N1n7UgZRemxvZXmhe3oGZXP86JvjQ5tlIlh8N/mL/3FV6iSQp5G8i
         EgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UGz2gYHTeu1D++Ca38OeE+7ttdk0CFVrhyKKlCaVXXs=;
        b=H4pCIDoUtIXRxtSRkrRp9lUsxn7c9VKpScgI3iGx4ar1aJl1EZ+y2vYDW1bEhxxE16
         JvmYuIh5mXR2E7SlCO7Oc2Mp4vP7YElgBa/geXLBlS0gR2S6FK1JpYCrZm7U4b6wfciu
         1UfGdojF6si/vJWkQ7r+epHtk/Ls0ibKyzaOKPgAtGs5QjMhOv1UK/x7nL35E1gENeoI
         N/CmJsFIZSVt3cDBBUzdKCE4U13iUdRM1nr3CNTdLcLySwdczp/NqUc9YDyk+GCTwJo6
         DY8CHtgJrzA7jCvvGQhvXTWyJNT7N0yOwm7mZyp2hNfEdB56494DP25Qb8YYG70jHkCW
         ksDg==
X-Gm-Message-State: APt69E176qkzdq6URlwuCpWvjURRZxkI+5p8kPnWFjPJxLdU1Hef+6a9
        SmCNZ5dpaBW0WOVN/V48GSTOiw==
X-Google-Smtp-Source: AAOMgpdJV85ndXL+poDBR08dPuabDdSA1Pje6JIZEs97hDDItzKvsGVotPjXIm8BTQJCxfqWZwAQhw==
X-Received: by 2002:a1c:b94a:: with SMTP id j71-v6mr8706898wmf.28.1530196395343;
        Thu, 28 Jun 2018 07:33:15 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id 4-v6sm8037499wmh.14.2018.06.28.07.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 07:33:14 -0700 (PDT)
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
Subject: [PATCH v3 05/18] ARM: davinci: dm646x-evm: use nvmem lookup for mac address
Date:   Thu, 28 Jun 2018 16:32:31 +0200
Message-Id: <20180628143244.4561-6-brgl@bgdev.pl>
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

