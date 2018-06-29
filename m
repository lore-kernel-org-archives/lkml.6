Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F1CC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8FF24D73
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="CTHB5EMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8FF24D73
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966626AbeF2JmK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:42:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50292 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935787AbeF2JlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:41:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id v25-v6so497750wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lfsaVkyOCkKnfk4OcZ4zCb05BERfpaU/u2IQUf/oijI=;
        b=CTHB5EMrCvEVYe8P3MALhMiSHnJVXg9paIFpUL9+sMLlEGOtYC/Ufgnx65AcXV1R0Y
         XuNy5TEKyBFBsxS+AG2fapX6AI4gU2cqI4SrDueeJhdUvNzfTlpUEF7tC4CcWEU0SSfw
         7xLTNXNyST8670njVC4ZAk8yDKmlFJb2kWeOcG1tlz4t1IownSfuYMStV4gM0IjoldNI
         0Bn4DTb8MV1Fj+B3+Amor/chn1LZLOamTbHNRXg3TdwRYBubc3MLUooQWgV1ryZquTyE
         DeE/Jdk+mjcMYiwQDsbd7GY4XMwUTEpgotcBSdwvqnaqmQOvVPBqMU8bOCQzqovnkvk6
         fJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lfsaVkyOCkKnfk4OcZ4zCb05BERfpaU/u2IQUf/oijI=;
        b=JmEvB0qfccKPAc9zjI0Ccw/fjvb1tuA4WKHnwpj3CGvcrrC+MRtwQxU+tY+9+84Osy
         6noCZZg/unI/ZJeG8BgFfedlTtZqnUiVZT3ybcHyQ+YbSXPLvblWexHYsPlloIv71CXp
         Eo5+C7EJE2ysRUd7kA7bcZvzu01PDdFgWno55Dd1tOg8SrdSMRXOoXCTsUq9iLsG7yEC
         LdX8ZeNesWVnPj0ZEWGkfScbQzlXCW6O7fJPuPOlkxDfHz7Y0NkGTO3nlYbiYUq27tZp
         Qtruvgr6eqyREoUiVbHEMzlvU3TWyj9aqXlf/lh9AdNHF5pIKOmln4mu4mp7YAPaY4FS
         MFug==
X-Gm-Message-State: APt69E170G47LSF8UptlSNeXkN+HEgoNAjf/lyz9/Jsn+kxXEWax475E
        moxVO0tYSA9Hp1JL27vXLYlZzg==
X-Google-Smtp-Source: AAOMgpd/rFPDytL5Y9DvTqDUUDQN/Cze38g9xUCwkbOBb1xu1LnNt/+mi4vr3By4WduapRzq0XnW2w==
X-Received: by 2002:a1c:8893:: with SMTP id k141-v6mr1221777wmd.133.1530265264555;
        Fri, 29 Jun 2018 02:41:04 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id d102-v6sm1386394wma.10.2018.06.29.02.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 02:41:04 -0700 (PDT)
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
Subject: [PATCH v4 15/18] ARM: davinci: dm646x-evm: use device properties for at24 eeprom
Date:   Fri, 29 Jun 2018 11:40:36 +0200
Message-Id: <20180629094039.7543-16-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-dm646x-evm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 5a9de47bc8a2..5049f0c6cd1a 100644
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

