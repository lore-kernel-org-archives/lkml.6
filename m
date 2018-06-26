Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF49C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DA825453
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="cjyjvVMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DA825453
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964912AbeFZKXo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:23:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40631 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964782AbeFZKXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:23:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id z13-v6so1214523wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EMXs7v3ptxT9vNOclT7VSTCrCsz0f0HMpiip+jVy0Kw=;
        b=cjyjvVMU7F5GTQFQhivwgUsngm8qbaXunSstdbOGc7CYhkfUd5OHD8mFmgfTiV/LBr
         mqQrpdVaicnVt0+Iv58cJ07//OmQGq5q+Otbqi0v7QfPUUp4W0zEDs09vLkD03pnwYy9
         ahK+RFOXKtdmXRpTFb50s6kaXj+FaaIt89VlBlA3JQWCMAe4NjNY2uQjDLwrgtsyZmJP
         8aMec7BYNdxSP+5690x2p6sVQpwfq2GkMzAfxJrXzanyukjreQqcWSU1ND6hLn0pgeca
         Chtxuci/itHke2Pc3W+EspHFzNmVxhGdDKSxV8CpkL9Aw41z7Iz4r2AmdZsU7gbiG1NE
         KvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EMXs7v3ptxT9vNOclT7VSTCrCsz0f0HMpiip+jVy0Kw=;
        b=Nt7Oygabj17z6alw+1mAjSHkYvZH6KDZvvVVSg6xYQWPP87ODh1wg7ZC6o/jAxobyx
         ZVHMnrIn5agS8s0eJcF1B+uOc6uKQHxDWk2tXQdCzbQwrnofjhQTifHiaZPtOyBKNIPA
         JTq257b644xl7whnOpq4/zHX955sI8DMQ+c7Gs4cegadLfS/HuhBcOjbrMtnUuqbOYvf
         ziNhCP0SDacRiaol8VFyRYZGJuRTPTvnkKOXRJptf2LMMXCZraGDayG6xUWfGirgW7SU
         q9JiAcxATjFf/cQR1zo4zxfSmtgPxbw52YNv4AKWXSFqlfZ/2RIs+U9W9WCtK3JAfq1o
         cAZQ==
X-Gm-Message-State: APt69E2nnM2Sr/DSECi+QkeLZlkIKZb1PQic9EOTOycuWIIh+bMVMjdF
        p64awnrArJHdhIpN1+LyofIq9g==
X-Google-Smtp-Source: AAOMgpf+8E5cxzIKOnk8RdqjhYSxQYQrajQ0NLTW/NRJMnuUynST1hJHWa+/bDQzmg7hB55v0hMjOQ==
X-Received: by 2002:a1c:f407:: with SMTP id z7-v6mr1047544wma.143.1530008616070;
        Tue, 26 Jun 2018 03:23:36 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2573852wmp.23.2018.06.26.03.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:23:35 -0700 (PDT)
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
Subject: [PATCH v2 14/15] ARM: davinci: sffsdr: use device properties for at24 eeprom
Date:   Tue, 26 Jun 2018 12:22:44 +0200
Message-Id: <20180626102245.30711-15-brgl@bgdev.pl>
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

