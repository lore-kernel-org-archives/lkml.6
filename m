Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1175CC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C253F27C8D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="JpmVzGsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C253F27C8D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935868AbeF2Jls (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:41:48 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43407 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935796AbeF2JlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:41:08 -0400
Received: by mail-wr0-f194.google.com with SMTP id c5-v6so8199151wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EMXs7v3ptxT9vNOclT7VSTCrCsz0f0HMpiip+jVy0Kw=;
        b=JpmVzGsAfNZmtbOHkuMKLNjQgB32JpgQssbqJUl25CPxudKhlSfdPCSq1HhO5QAkGw
         6l41ksbovVx/fYH4o9DpLtx7DuoN11vZo3NAMCUoyIh/3TzoPX1DgG3eZgSgbr/mJAwM
         bGsqGmVIZ0f8LpdmaZ+bJDgymx6Rqwy70/UMFLukgMhFKDPROeN5wWp7aZdzU8wn3UPm
         wQU9YXp50/QxMevm7DiN8iDX3gfWmF5pgxMymkrauIklvRzaLOivy54P291Bq+mZK+ST
         LmO5/pS0orsfw/dVcXckR8+hj9+TDUGOi7E639ped8zqjSoqx+PNWEPBbhZH4O/DQ92A
         /wHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EMXs7v3ptxT9vNOclT7VSTCrCsz0f0HMpiip+jVy0Kw=;
        b=XCNn6rtGjTRT4yZCEH3Jv1/8AW750+WjNSCX5k15IfLa27Qal9CrjDVVeyf2KFSKsR
         LlePjN1CIGprp/9HloggqtufqRRank3vPxKvoDWthqD0XjjdenOBosIDdZzSkCRXtOWz
         JcJEy8+1PUw+VFfRfJ0TBVvsr8eX470DYsu7HKMW681oE9KaVVhWPjtkghw/1Y99Sxyi
         nALh0cY+oGeV18zHB6hQzEaW+qomlybaaOz9B9TplHbLa8phfRne9Hv3Xq6i3tlIwk9T
         5B5lYe3+NThEP17AQKl4AfQnW+IXPpVfKAf+OVlsM3aMbA31Ahkdpbd259V2+yudnze3
         IXcg==
X-Gm-Message-State: APt69E1uQhh1wXWfDEEuHRH02rIAs8V+2l+TTe2WUp9kI27ZwjwOkAlL
        +87n3xzbbX+k3mAXT3WKLJsr/A==
X-Google-Smtp-Source: AAOMgpekA1jS5QrMK53VTdVm9ABedO0fBg2TKYsGKKWdfzIkjBNMhMQkrj+RnPAz2liwOkdw7uWfTg==
X-Received: by 2002:adf:9d1c:: with SMTP id k28-v6mr643356wre.29.1530265267220;
        Fri, 29 Jun 2018 02:41:07 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id d102-v6sm1386394wma.10.2018.06.29.02.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 02:41:06 -0700 (PDT)
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
Subject: [PATCH v4 17/18] ARM: davinci: sffsdr: use device properties for at24 eeprom
Date:   Fri, 29 Jun 2018 11:40:38 +0200
Message-Id: <20180629094039.7543-18-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-sffsdr.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index f6a4d094cbc3..680e5d7628a8 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -26,7 +26,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/at24.h>
+#include <linux/property.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
@@ -92,16 +92,15 @@ static struct platform_device davinci_sffsdr_nandflash_device = {
 	.resource	= davinci_sffsdr_nandflash_resource,
 };
 
-static struct at24_platform_data eeprom_info = {
-	.byte_len	= (64*1024) / 8,
-	.page_size	= 32,
-	.flags		= AT24_FLAG_ADDR16,
+static const struct property_entry eeprom_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 32),
+	{ },
 };
 
 static struct i2c_board_info __initdata i2c_info[] =  {
 	{
 		I2C_BOARD_INFO("24c64", 0x50),
-		.platform_data	= &eeprom_info,
+		.properties = eeprom_properties,
 	},
 	/* Other I2C devices:
 	 * MSP430,  addr 0x23 (not used)
-- 
2.17.1

