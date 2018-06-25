Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5964C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BE5243E6
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jxaDcf/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BE5243E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754496AbeFYPxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:53:39 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42564 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754488AbeFYPvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:51:31 -0400
Received: by mail-wr0-f196.google.com with SMTP id w10-v6so14199792wrk.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B4ss2jSj7tKkAK/ffxVGa8iIGwohRFcM3Cy7QOHtOY0=;
        b=jxaDcf/wbnp94S658GQkqkc4cAOhi2mhXdWo2Un3J4+jeGKwTD+bLmvyus1qnQ33Q3
         SVQ8NjqjobNClGXzXIWB64sYoLtR/IZCFttvy1TSuF98qqm64I22B1mi7P6lc97Z8ex7
         I0zMWvhndS8Q4udocll8MAJ8Lh+Cwc9DOGEZZXLxYZgysNVp2if7YWmQGx9CEIlGHfaI
         gtD0pt2EzYQPqqpD9+/Z56Xj3XkoFM8OaWVIo/l5vblO/RXdJloVyEr8pr3PWbO1pj4q
         KT14SxjnPL4TmJ47Qdsxag7ybvGfMS29bvn5ArQUtHJgedrzy/GbLCD15Z3sMJCX2VlZ
         PSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B4ss2jSj7tKkAK/ffxVGa8iIGwohRFcM3Cy7QOHtOY0=;
        b=QtCZ0QFNLCvgXrnPMbnvtXV9e5QcqwhUXPRgIzvwt2NbgN/qXihcxkT+gpyRxOrxLy
         ImmzyCIF5apnxf2hin7tSceLS7JXJOsdeLJoRtv12HHUy/37nThCbzuGk0JuzojdOih7
         m56aRBdSOaeir4Y0as80q4/1JJieB8jIHNZE3EXiUJj5F3fAZRc+RzKMTY2ZdXHGBnzr
         QSjbuvIZFOYaozeNqEHm54Ihb46b8UFHnCp50/mA/aeqsNZB5iQ6NIgLgk7skIa92Xiq
         zzkCkYgpJfa1LgHtD8IAhFTgVzpNTi7GeHRFr3S4dCAEkl6jtXrh4PkkYmbAzzv1YOP4
         CBrg==
X-Gm-Message-State: APt69E3AbE2it7VriyPrQcXfhJ9mrM4mCc5J6xQR3Wqdv/C/8YaIxqAx
        1YNn3nTN2OlFI0Msww2KvCkhHg==
X-Google-Smtp-Source: AAOMgpeLCujPzHwrtWT9ohN2lb6Sx+ux8ETOrfdvfbS/nQAmE6pp0+cJM7bMvW5+vt88z/64isxvaA==
X-Received: by 2002:adf:a0b3:: with SMTP id m48-v6mr10278781wrm.125.1529941890799;
        Mon, 25 Jun 2018 08:51:30 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id x16-v6sm3523737wro.13.2018.06.25.08.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:51:30 -0700 (PDT)
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
Subject: [PATCH 09/14] ARM: davinci: dm365-evm: use device properties for at24 eeprom
Date:   Mon, 25 Jun 2018 17:50:20 +0200
Message-Id: <20180625155025.12567-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625155025.12567-1-brgl@bgdev.pl>
References: <20180625155025.12567-1-brgl@bgdev.pl>
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

