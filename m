Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52174C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5EA246DB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mW7xrqRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5EA246DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964835AbeFZKXh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:23:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53595 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934853AbeFZKXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:23:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id x6-v6so1250832wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YRVJnNJ2ae2CGqrvnfy5XFewS/vJWfahXE5VW7+PeLI=;
        b=mW7xrqRNPT+9ocitITxyMhsLokhvxok+GxbX/Uo+4+zlnThNmHeGnmWPnGsZ2uRNJd
         Sgp1Lq+fWnsQav7wjeqQcS4oLlQZLypIA9JL4DV6rTIhNimPlgKg8VME9RVi6L6zymfd
         az3zzlWQ/mNxzh+5yP7oRvqSv2WSyNnAFyKdrC662xNhkNZa/KMo9bnwqv3xhNsZzrON
         YHDprjkxitY8tSNjEVFbQGmBRgTy6j8sAh+2udgc2ArK6aQriH0izaLn+Rq+90qblaNV
         J1q2GfO4alGi9Znv4IYdiHzWRwLeFc/6npJUm6o1D9hSdK6WCeA6yMPN/S6p0nl0Xk9R
         uHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YRVJnNJ2ae2CGqrvnfy5XFewS/vJWfahXE5VW7+PeLI=;
        b=iJTAmLJs9/vyZBIBw7htSYPnDyfnIyrQL+EgXcVVoiugMESaeQFQtT7HgLnwL2220/
         IplPN/w+OcqD5S5nHRX/QoldOSKQrN4QEyMZ57voM0ad1Zd/d2wJe8OzniwsCh97spD9
         lu3xXf9syI7Ptj43z39dOwkQGUK8p8/folR01TaDBaC1HJBW9yshfGEtnKkUzCnOHMLj
         4w7NL4VjGLLrobh0l+QIpRio1RckJG3xnVZGkcN/+ntmzO8OrLgpITh6/2XisXSxvd4/
         bjqRFHOSVLEelHZIURbeoGsbiKR43GVAzmUVCeAUXR8bhqzP2ccsdJa2lNDFaW4sqVQP
         iXUA==
X-Gm-Message-State: APt69E3J/wjp9cP2hol7N27n95MHzTAg0rKS7AY2NZh57+IjjbPDSy2f
        GKNUm39/Xf1Sg2Ba2UiDhdpNbA==
X-Google-Smtp-Source: AAOMgpfARrynGl2crzTCME4qr86yAjDLT7d9MKOX+PRj6B0XFOqfQkGC/bO0F/OWLjV6OQ9CZl5Lug==
X-Received: by 2002:a1c:d8:: with SMTP id 207-v6mr1047003wma.99.1530008612851;
        Tue, 26 Jun 2018 03:23:32 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2573852wmp.23.2018.06.26.03.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:23:32 -0700 (PDT)
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
Subject: [PATCH v2 12/15] ARM: davinci: dm646x-evm: use device properties for at24 eeprom
Date:   Tue, 26 Jun 2018 12:22:42 +0200
Message-Id: <20180626102245.30711-13-brgl@bgdev.pl>
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

