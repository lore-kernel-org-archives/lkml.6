Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B6FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6652690F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FuQlFA+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6652690F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935020AbeFZKZq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:25:46 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42644 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934781AbeFZKX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:23:27 -0400
Received: by mail-wr0-f196.google.com with SMTP id p1-v6so1068630wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B4ss2jSj7tKkAK/ffxVGa8iIGwohRFcM3Cy7QOHtOY0=;
        b=FuQlFA+BOnhK8qLM873QEkwxYwdEYRZQ62mxwexyKTeqW9OZU9g/FcRQ+xmAN64nSF
         IPG9oPFxLI9DK89EIx2YSIXOZ+pXEufnEqEkqKc7NfECWTxfboJ3hKfwLz3HsnUcefix
         ePV9JvBM8Lj6h/3gIO6gNF45qare8mEgbVYBqP/mR/iKRizgSZnVoaoqjhfV6ZJBdCCo
         zbypuU6DOAJMcgjXQv10f6F8VtP8yxxrXiBdZfu7rmug1i4GeLD0nus/9LoEcsQULtmV
         j2gvmKl0FrBwVA9mRXsSOj6e4nhuSFVOjBPgdSinQ4WJQIHZckoWtQ6d/3UzqNIe9PTP
         kHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B4ss2jSj7tKkAK/ffxVGa8iIGwohRFcM3Cy7QOHtOY0=;
        b=pTQ3r488nBe70iZ9cbPI6/mt1RXkumF2zh3JVudgPCnnVXoOV4YYa7wyfpc2q00zYd
         sjHF2cVzjUgqXpfyR6ZZI/2FzlLtCw9FNKxdUorUVVCGXAP3EM0ZeSJf37l/gIQ8N/mF
         zVfHekyBm9WtcGlLF2wzBwMUorf8dhI9gB4t2uHKFdk0x5p+hwFGeUeztLOjDafJwQgb
         dknIoFdFh454Q++0t17mi/BnDsZ9wDB9FD1MagCVyn1ZMcrZJX1yN5iIsoawOTRGCLfa
         dZXNjJIQBMlmH/lgqvlzJSA13sHnNBU01VrYAHuVVnX3JaZJG2g0uN+zzsH8TeDB2SzA
         wlnQ==
X-Gm-Message-State: APt69E1JWvQzzt774FidFTALrXxTdPkhoBOvuaEPAEYHeHYw48E2EDTu
        s7ZucPHljJXcu3ugODUnOiYg3OPUE1c=
X-Google-Smtp-Source: AAOMgpebS+tAcxKN42gbuW+wZ2wij+NCs2wxWughUhoitpJ463o+Lf4vPtE5M/i/z48uLVEtA5egeg==
X-Received: by 2002:adf:cc82:: with SMTP id p2-v6mr889175wrj.226.1530008606224;
        Tue, 26 Jun 2018 03:23:26 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2573852wmp.23.2018.06.26.03.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:23:25 -0700 (PDT)
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
Subject: [PATCH v2 09/15] ARM: davinci: dm365-evm: use device properties for at24 eeprom
Date:   Tue, 26 Jun 2018 12:22:39 +0200
Message-Id: <20180626102245.30711-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626102245.30711-1-brgl@bgdev.pl>
References: <20180626102245.30711-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to work towards phasing out the at24_platform_data structure.
There are few users and its contents can be represented using generic
device properties. Using device properties only will allow us to
significantly simplify the at24 configuration code.

Remove the at24_platform_data structure and replace it with an array
of property entries. Drop the byte_len/size property, as the model name
already implies the EEPROM's size.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index df640d977bfa..ffe93265f565 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -18,7 +18,7 @@
 #include <linux/i2c.h>
 #include <linux/io.h>
 #include <linux/clk.h>
-#include <linux/platform_data/at24.h>
+#include <linux/property.h>
 #include <linux/leds.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -179,18 +179,15 @@ static struct nvmem_cell_lookup dm365evm_mac_address_cell = {
 	.nvmem_name = "1-00500",
 };
 
-static struct at24_platform_data eeprom_info = {
-	.byte_len       = (256*1024) / 8,
-	.page_size      = 64,
-	.flags          = AT24_FLAG_ADDR16,
-	.setup          = davinci_get_mac_addr,
-	.context	= (void *)0x7f00,
+static const struct property_entry eeprom_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 64),
+	{ }
 };
 
 static struct i2c_board_info i2c_info[] = {
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
-		.platform_data	= &eeprom_info,
+		.properties = eeprom_properties,
 	},
 	{
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
-- 
2.17.1

