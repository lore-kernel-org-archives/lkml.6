Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F4FC43145
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2D727C92
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Y+s+UZjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2D727C92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966757AbeF2JmR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:42:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33205 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935768AbeF2JlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:41:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so1516827wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4HmaRzKQAmCOBggqSSt2FK2DrG4yPKo8UnlMTio/XQo=;
        b=Y+s+UZjjsaNYF+3Mk1l81sxkrK7PlSnDdg+N8ldjp/0XBRpmzU8YvB8cf8GWYEKjnV
         v0ORUJ3ysIr0zO46Zs1rcjs7bxVL+KyI/A8EmX/6Vha8MOsn6pVfhaWyDzwsP3YH+QkI
         eALD1qPDMOAyIo5AKocs6eRfWLfB0eU+8BYmHeCG/L1FQhGsRMjZ5U+UaEvByRsy6dpS
         0YljRQmhSa85uLYRagmldjyUF8krErYucx1d+6XY9sJ1FFHNsMdbrJVQnZMG1eqRU6II
         H/4BCcStfawH3+P8NHFUCZehxqX8pmPvLAkQbnL5pVcVVQZgQkZptT/QNE4OBMxERsMQ
         U5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4HmaRzKQAmCOBggqSSt2FK2DrG4yPKo8UnlMTio/XQo=;
        b=aUkddyNuWIqIcWIBIlvtCrjX1Fdp9z4DYP24AxEb1XstFtUAYMfcjc0u7RGrux6LX0
         63x5ENCDgbcROgftqIm1txk77vzwT5W9YBIz8HFUsJB4rAMDTwQKtQjObYcI/ZrqMllE
         8AnmumRk+OsJepAYfFgStl0A86D/oM57W7D7ZQHLGIg9wr3yDc6eCORSg4jL1zcca1tW
         IGcl1mw5Q37R9TVWLDCjlIWTx+TTDUrSFr+iId6vpQ/yMOFAu/b4sdPAhw8teroTL2WO
         qjVGFU8OtGHEf/hypf6y90JR/q5R7Kx84kZQroWSX+YzJtodtyCdEN9PoePlZyd6ETFZ
         35mQ==
X-Gm-Message-State: APt69E0epZqyin5EPN/GadTyaymQo3n3IFmsZUJPAFJZEz/A60Zjpva7
        SyZzJ7/Elq/K6xAHvySp9aDv7g==
X-Google-Smtp-Source: AAOMgpcDpkcX2Uq1fRiXuISKVDvCI3OWRTvdmVtLiV7qw3rcpYoP4TQusNphfdvMyfESfv3yITASuA==
X-Received: by 2002:a1c:d884:: with SMTP id p126-v6mr1148849wmg.110.1530265260416;
        Fri, 29 Jun 2018 02:41:00 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id d102-v6sm1386394wma.10.2018.06.29.02.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 02:40:59 -0700 (PDT)
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
Subject: [PATCH v4 12/18] ARM: davinci: dm365-evm: use device properties for at24 eeprom
Date:   Fri, 29 Jun 2018 11:40:33 +0200
Message-Id: <20180629094039.7543-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629094039.7543-1-brgl@bgdev.pl>
References: <20180629094039.7543-1-brgl@bgdev.pl>
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
index cb0ac92a278e..b360d26e6caa 100644
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

