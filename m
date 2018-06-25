Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D55BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB59725D54
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZvgJakj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB59725D54
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754795AbeFYPvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:51:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40391 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754670AbeFYPve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:51:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id z13-v6so4404798wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vh5PxE8A0277G3WQQO6l1yJcncYmyUvGiKsoSO9LfR8=;
        b=ZvgJakj1bHcDDAUUFEkkW5OK41/mJlFTGf35o60wpVivrpPDuQ6goUesHx3T1P5POA
         cLCwK6CXBLxbPJng4xr+/7JLq0Orix8XQPqVBNdjqCpbSmkRAEqr8yXi1aMt2YTaXTop
         x5es+EnwdS5HQsCoIZIqqIYRVUpTf0N0zDxozN9cZX+bblRonEgBzYDJtLeyGFRC1wVx
         Xma/QNzodN8YK525n9b/GSjUIPlGetd3dvdFBmCkjVe63e33KV41ylUINiSlsNZCiU42
         3dqD5FcXhv6pnRK48RuzDYrBFk8cysF1QYx79+/FS5VD9Up2cSbcJHr3Zj3QAPnArCVr
         gfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vh5PxE8A0277G3WQQO6l1yJcncYmyUvGiKsoSO9LfR8=;
        b=uAnHA9fHVBnYINSacWkBFc3WgrfyvE+7N0s27qDyodZTG4SIJZvPAOheZ6wbUsBKdm
         fnlYhMraY0ftE/+UB0OicKjtYo2pycQ4+wEpSWCqKBxggdzB83HS4kVPkBoLn9gWeJJo
         NV38Ohu4nq9hH1goYimUQHOxozp2lK6gYGT80k3q+yLnVSaZkFcQ70t6OOzLnB0hFHOA
         Dq4AJZkkq+T1mji60nE67LYfe5FiUwoR56oC7Fo3c4c2Mip3bbW+5MjaQvOxIRSTn2jq
         HK7nQVeigyL7ZYi+P3il4gKn16gaKC70TJxQJfDwOh1ZmWm33FxBnkzOewj9+/3Bj7Gw
         jgfQ==
X-Gm-Message-State: APt69E1Wk97StI5pOnSxoTfe90FPjVsHjakTHbz534I0vKmiLdxlF3eY
        wr4/sz2gS4X2/t3VgIDUVKnbdw==
X-Google-Smtp-Source: AAOMgpdndumOYQRTXXyIxIT4lkYpViR+tOjIsL1WHolvA0c4uFF7rcSd7G7FBs/ZumocfiM87qq2ew==
X-Received: by 2002:a1c:e846:: with SMTP id f67-v6mr1438396wmh.63.1529941893516;
        Mon, 25 Jun 2018 08:51:33 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id x16-v6sm3523737wro.13.2018.06.25.08.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:51:32 -0700 (PDT)
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
Subject: [PATCH 11/14] ARM: davinci: dm644x-evm: use device properties for at24 eeprom
Date:   Mon, 25 Jun 2018 17:50:22 +0200
Message-Id: <20180625155025.12567-12-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-dm644x-evm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index adbe8630ef19..5b26a8c5bbd8 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -16,8 +16,8 @@
 #include <linux/gpio/machine.h>
 #include <linux/i2c.h>
 #include <linux/platform_data/pcf857x.h>
-#include <linux/platform_data/at24.h>
 #include <linux/platform_data/gpio-davinci.h>
+#include <linux/property.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
@@ -486,12 +486,8 @@ static struct nvmem_cell_lookup dm6446evm_mac_address_cell = {
 	.nvmem_name = "1-00500",
 };
 
-static struct at24_platform_data eeprom_info = {
-	.byte_len	= (256*1024) / 8,
-	.page_size	= 64,
-	.flags		= AT24_FLAG_ADDR16,
-	.setup          = davinci_get_mac_addr,
-	.context	= (void *)0x7f00,
+static const struct property_entry eeprom_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 64),
 };
 
 /*
@@ -601,7 +597,7 @@ static struct i2c_board_info __initdata i2c_info[] =  {
 	},
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
-		.platform_data	= &eeprom_info,
+		.properties = eeprom_properties,
 	},
 	{
 		I2C_BOARD_INFO("tlv320aic33", 0x1b),
-- 
2.17.1

