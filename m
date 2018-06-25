Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B410C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E6825D49
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jbE1U9Yi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E6825D49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754900AbeFYPvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:51:41 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34587 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754682AbeFYPvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:51:35 -0400
Received: by mail-wr0-f195.google.com with SMTP id a12-v6so14223293wro.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YRVJnNJ2ae2CGqrvnfy5XFewS/vJWfahXE5VW7+PeLI=;
        b=jbE1U9YiHksGbbwZ6BIvlpe3jMU17bsQsH+zTgWDCOxjRSo4ZDEAfqIACi//AthD1N
         /u8Zxfb7XLoM8olSVcZ4ppLnq/Nqhk5tdKlixrAyvc1vLRyV9aA223BH8eqMgB3tyNIa
         B+CbJI9qhNQ/LNuzgSKhXkGjwwe+T+3i/yV9SVd3DxKqtKmzIfRWL6obVjD0GxU8S8C2
         hs1KN0r/dIJrgcfEpg3R5M+riiM+QDv2Om95hhxDAxIwdUxZW/DBmXshJsNJRfa13uW+
         yJpJCdFnVUUayKaBFgQ7gqdSR5/Hrdis/BTQINK+vfhGEaLcvj0fE0A7woMoYvfAhO96
         O10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YRVJnNJ2ae2CGqrvnfy5XFewS/vJWfahXE5VW7+PeLI=;
        b=jHusGnUzZoAwvMAinFEiwur5Vaqf9uhbnlhd64Q6VSZBpAVQ1kqrvFZMAR+h9vQDBk
         wajpXc3OjuU6SGFKb35d5pztAW3bBPP2zmvyEYevoTNsl/+oT0en8g1nvJUi/faV1XlE
         40GBUwghHsmkr43Mi7CANkZAOOLYNfJy9ZHJet7oU04unp8bW+eJUai9EialdC52ioga
         khddvPjdR+0M8s7XhBix0tNzcRORYAMj2cy2cUA4ADvc9j+wow5aeXr/8uVY7vXFk2+U
         P9TXPV/yUU3Fd2nG0x75j3MAq3Z2V8YWnqqgTsoF8XnhoSl/yHndw1A7cC+GRMIZT4Ze
         38nw==
X-Gm-Message-State: APt69E26GIccDQCVynVZvtjmH6teYBWXDLf8Mx11AJYJ8RJhVVFPwFEA
        3FscbwevV7Tiwwk34ID+JTd8RA==
X-Google-Smtp-Source: ADUXVKLin2kWqL3YQT71MaMPUiSjPRw3T7K/RVzcNwXB4exeppV/9jYbPpIQ8Z0dPv6OtH5IpCpeiQ==
X-Received: by 2002:adf:e311:: with SMTP id b17-v6mr11083088wrj.158.1529941894771;
        Mon, 25 Jun 2018 08:51:34 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id x16-v6sm3523737wro.13.2018.06.25.08.51.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:51:34 -0700 (PDT)
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
Subject: [PATCH 12/14] ARM: davinci: dm646x-evm: use device properties for at24 eeprom
Date:   Mon, 25 Jun 2018 17:50:23 +0200
Message-Id: <20180625155025.12567-13-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-dm646x-evm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 4c82d38033b6..8c585e7be180 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -22,7 +22,7 @@
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/at24.h>
+#include <linux/property.h>
 #include <linux/platform_data/pcf857x.h>
 
 #include <media/i2c/tvp514x.h>
@@ -320,12 +320,9 @@ static struct nvmem_cell_lookup dm646x_evm_mac_address_cell = {
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
 #endif
 
@@ -396,7 +393,7 @@ static void evm_init_cpld(void)
 static struct i2c_board_info __initdata i2c_info[] =  {
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
-		.platform_data  = &eeprom_info,
+		.properties  = eeprom_properties,
 	},
 	{
 		I2C_BOARD_INFO("pcf8574a", 0x38),
-- 
2.17.1

