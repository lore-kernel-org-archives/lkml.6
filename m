Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FBBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F60C2089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SkoiwJ7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfAHJRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:17:01 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39886 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbfAHJP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:15:58 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so3460944edt.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hh5b2k/7h0Wkn2rLn6NIi7mvwMbeZ/cPsG4EAD277Kg=;
        b=SkoiwJ7mSICbm05UcVobOCupwPj7xv1ZeuUR0Khw9wxNITzWgKNtdimlgv7XTUWAis
         2ugNlNJEvdY9KG5yJ9922gDbYhSWs5Nz0ghJwbYqrg2Y51kMeueMvewtjf1UVBc8gaWc
         M4VV7MPIDiv95So++iXt/5Dlv1ec3R0cYyZeRKB4nPJUSFcz5c6891WOdCbX42Oo42lo
         p5NvKyBdNhLXTJNFUR+eNNVOkNn6R4yORHZIhX9d+EqjcR3mWEdymo0ZNxDztspCSXxF
         XB3wFSYErdZYf/WSdhYwIE59inECFrbHcoMCxrrsWjLlcYfiLOIZCDifDpUgJXcVORKn
         bsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hh5b2k/7h0Wkn2rLn6NIi7mvwMbeZ/cPsG4EAD277Kg=;
        b=jGKCP83wvgnMm9guYMWp/w2bAvxn9pC4pc6HDPBRVbqprMC24/vI2mFvDG4XGr8gxO
         irVLfYXQE0HC1LT+g5cbLyN7I41hu2e6dd9r9xHdhFVGIDikZX/OE3LlNFuIBKbfS/3D
         EzWZZDdqrST0XOl5luPez6peOh4UnLrrPVwynpFRvPBDeENh/QEQRpHhJTQpqso7VaPa
         Pr89KtLhFAslzdhw7euNHuswtVs0+eVkEKc2EMG7/kvvb3vLcN+2yQk9gleF2tpSBEqH
         uJpWjT0EjsAs5NFdPyoTLU89MSCSTmcOatSuFwsKbanBTZfAw/w2pKHdL7gWc0UcwC8L
         oGdQ==
X-Gm-Message-State: AJcUukf/YaHD0yiYkwROw6b5ZeJlpuv4A9lQW8zG3FdbGKXhAFEvxM9q
        nK17mn3rJMpELvStxBAQjca20Q==
X-Google-Smtp-Source: ALg8bN5F3/ZKizjRyhig9R6zB1qpI+G0nZ57edJzgP5cBXVtwrjxKMkPImYuXsbq4gITuBWf0HljYg==
X-Received: by 2002:a50:ad55:: with SMTP id z21mr1310568edc.74.1546938956451;
        Tue, 08 Jan 2019 01:15:56 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 01:15:55 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 06/12] ARM: davinci: dm646x-evm: use device properties for at24 eeprom
Date:   Tue,  8 Jan 2019 10:15:33 +0100
Message-Id: <20190108091539.16674-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108091539.16674-1-brgl@bgdev.pl>
References: <20190108091539.16674-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 arch/arm/mach-davinci/board-dm646x-evm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 8d5be6dd2019..02b57face113 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -22,7 +22,7 @@
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/at24.h>
+#include <linux/property.h>
 #include <linux/platform_data/pcf857x.h>
 #include <linux/platform_data/ti-aemif.h>
 
@@ -364,12 +364,9 @@ static struct nvmem_cell_lookup dm646x_evm_nvmem_cell_lookup = {
 	.con_id		= "mac-address",
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
 
@@ -440,7 +437,7 @@ static void evm_init_cpld(void)
 static struct i2c_board_info __initdata i2c_info[] =  {
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
-		.platform_data  = &eeprom_info,
+		.properties  = eeprom_properties,
 	},
 	{
 		I2C_BOARD_INFO("pcf8574a", 0x38),
-- 
2.19.1

