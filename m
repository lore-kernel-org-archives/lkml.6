Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6155EC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5A2218A1
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Zg8t0ZSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfAHJP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:15:58 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42788 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbfAHJPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:15:54 -0500
Received: by mail-ed1-f65.google.com with SMTP id y20so3438877edw.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d9WKYwfle5iDpDbapbl3IuLnt+LCk29VTN7zfdkUdEk=;
        b=Zg8t0ZSHGq5+XwEHztECZ+pq2NswnAhNF+REWdT0SKfdX9bJ4nN5h+wBoHhxfB7Hk1
         0tYBwmAbTGnqQuRkZt093/IZtkl0JToxqIqwSukwlN5wfuP8nGUS0AGWw1yteG5kpnA+
         6drX4ac/iaBeCUwrMrEzd88ZA4W20PuqHb0qfWSHYe/3BflsEDZXE465wfz+/ystnhvY
         jA4RAOzgdWuqQgrYcUs5lzYEUfdObdtiP2moeyRXDi3AAy8xgCpWla1/LltR1wp9Iu5c
         Mkjq1xQb5z30kpkoUIDPhIK0ruEuYlYqQ+JlyHMtdrL0pkG0csZF208L1zj3iBWshYHs
         drLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d9WKYwfle5iDpDbapbl3IuLnt+LCk29VTN7zfdkUdEk=;
        b=UV1ME0zccxjplQ2Bq+HM6WROJTahrqrj6CrmGkrrv0HfteZSf8u1ZIUc/7Q2H6LBUM
         m8W8Q6y5o5xDbq2B6b9qY6+iaHfDvPcj34yftinF80FnMs0AMGcTnN/Hf5FHfE5ThPH3
         Hn/SQSgZCQ+VWK3LyHhwOFL4qANMkrco5NurAjz+ZkmFsFV2vNEY1l8ySqzxQS0XKqo3
         E1XCj103QZDj6Unnc5Hp/0Oayv+wWow5jPHjAEEiLxD2xXzVRAb2OKGyDEAWhiGi1vth
         c41R6L+AuiXu/cQUVaa7YqktIxG4Kkc+BLQHnjNdS5rcGe2hdZ4QFbvAPw27nhBDSPPc
         kPdQ==
X-Gm-Message-State: AJcUukf1DpqhCOHCyckhGbHrLPHdalhyFOxip4PcYCRFkZft0ZNGhu/E
        vsbp36i7Qedt+ktxs5SCV5oJUA==
X-Google-Smtp-Source: ALg8bN7iyeVeqgk7+KcFyN4P5TwNc2Mc07Xw4RCmf0MMVwMtYaz66rhQQSMeftjM+C4+1Q1Ydkjimw==
X-Received: by 2002:a50:d753:: with SMTP id i19mr1316410edj.75.1546938952367;
        Tue, 08 Jan 2019 01:15:52 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 01:15:51 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 03/12] ARM: davinci: dm365-evm: use device properties for at24 eeprom
Date:   Tue,  8 Jan 2019 10:15:30 +0100
Message-Id: <20190108091539.16674-4-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-dm365-evm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index e3b0b701e395..f21dc8d3b28c 100644
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
@@ -225,18 +225,15 @@ static struct nvmem_cell_lookup davinci_nvmem_cell_lookup = {
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
 
 static struct i2c_board_info i2c_info[] = {
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
-		.platform_data	= &eeprom_info,
+		.properties = eeprom_properties,
 	},
 	{
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
-- 
2.19.1

