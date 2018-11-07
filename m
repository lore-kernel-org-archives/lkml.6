Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51217C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147352081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Poswbhgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147352081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbeKHFsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:48:13 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39284 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbeKHFsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:48:12 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so12441203lfh.6;
        Wed, 07 Nov 2018 12:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=39mD7pgVBuElFJQ3mjWUtS+vlqTvSmmnI9p5XoWxu2c=;
        b=PoswbhgfLu+Y1TgpE7Vw26Nget0TxVpH0ftCItkypEY2qHc+OWSwfFzZCTCaWhL6qr
         m7sTF2yVw/orK7cwlhdCn+TWNdmuhcbVRlY05p7bSjUX/tuQf2dT7+TJEfyjYwJIDIaO
         Rw8S+og6WSoYO01OwVCJBzL/kBBiG0cibc5J7/+raSzpUfzRCY2PjI9lw6+hbpx6RBuX
         eb/9PPlPhHmx7YjIl8iHVHcwuzTTPNPaxQrQz7si0pB8S72avsJl1fmVo0kCL+O0U6tJ
         i/O+r3+NC0TbqbOrMivcIZclP3sdiv6SSqvTiGdYn13oJBG44ggiMU3oksbFrsRSZuHp
         2W7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=39mD7pgVBuElFJQ3mjWUtS+vlqTvSmmnI9p5XoWxu2c=;
        b=tuEssjzbMr2Srw/kSVexOxSnwavzErkPrhLJiHTj4vL/MxTpr7eVNJFbGzAKoiJfjg
         evzgnAkafcA5Hg90598ffMQjpF062MbU0rzDkfiUKgI1eOaneVDwcD04RxycoA+iqQVq
         vgsh0EbMQYqWCvj7L13JSEVw9qg6ekBhfFYyntpGakg5dglHQnH+ZeTDgnkZ+kRXEnid
         g+jVOp1EzE7avWq4gY94coBwT+UM+tZCyi3HPD768bR4DvlbMogKKD7OCPVOhcUOWqOb
         20asshIfdIHIXUP5HHAN7IirGj7VrWrkZlqCpAlfh9tnVtycKsgKp0HyxPmTYS2RzH0B
         32Og==
X-Gm-Message-State: AGRZ1gImFi7zTnJIEgxSQet8Yxfx3v583pzS1K88ZZ3DOtJhiAak8pRC
        XcTqkmh1EpW2JmZMTtwiTvs=
X-Google-Smtp-Source: AJdET5eeUSqla6DNbcynhxJFlwkG88h4g49E9DtL8RXu06qWx7VHqkQnsLEVI242UWjBrI6cflWqlA==
X-Received: by 2002:a19:7919:: with SMTP id u25mr962730lfc.18.1541621774451;
        Wed, 07 Nov 2018 12:16:14 -0800 (PST)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id c19sm285650lfg.86.2018.11.07.12.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 12:16:13 -0800 (PST)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 1/3] ARM: OMAP1: ams-delta: Drop board specific global GPIO numbers
Date:   Wed,  7 Nov 2018 21:17:44 +0100
Message-Id: <20181107201746.14705-2-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181107201746.14705-1-jmkrzyszt@gmail.com>
References: <20181107201746.14705-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As all users of the board specific GPIO pins have been converted from
legacy integer-based to descriptor-based interface, there is no longer
a need to maintain statically assigned GPIO pin numbers.  Drop support
for that.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c |  3 ---
 arch/arm/mach-omap1/board-ams-delta.h | 16 ----------------
 2 files changed, 19 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 19e0c071d675..a6986a83a916 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -167,7 +167,6 @@ static struct omap_usb_config ams_delta_usb_config __initdata = {
 	.pins[0]	= 2,
 };
 
-#define LATCH1_GPIO_BASE	232
 #define LATCH1_NGPIO		8
 
 static struct resource latch1_resources[] = {
@@ -183,7 +182,6 @@ static struct resource latch1_resources[] = {
 
 static struct bgpio_pdata latch1_pdata = {
 	.label	= LATCH1_LABEL,
-	.base	= LATCH1_GPIO_BASE,
 	.ngpio	= LATCH1_NGPIO,
 };
 
@@ -219,7 +217,6 @@ static struct resource latch2_resources[] = {
 
 static struct bgpio_pdata latch2_pdata = {
 	.label	= LATCH2_LABEL,
-	.base	= AMS_DELTA_LATCH2_GPIO_BASE,
 	.ngpio	= AMS_DELTA_LATCH2_NGPIO,
 };
 
diff --git a/arch/arm/mach-omap1/board-ams-delta.h b/arch/arm/mach-omap1/board-ams-delta.h
index a74a306d7e77..06e4c64a47f8 100644
--- a/arch/arm/mach-omap1/board-ams-delta.h
+++ b/arch/arm/mach-omap1/board-ams-delta.h
@@ -41,22 +41,6 @@
 #define AMS_DELTA_GPIO_PIN_CONFIG	11
 #define AMS_DELTA_GPIO_PIN_NAND_RB	12
 
-#define AMS_DELTA_GPIO_PIN_LCD_VBLEN		240
-#define AMS_DELTA_GPIO_PIN_LCD_NDISP		241
-#define AMS_DELTA_GPIO_PIN_NAND_NCE		242
-#define AMS_DELTA_GPIO_PIN_NAND_NRE		243
-#define AMS_DELTA_GPIO_PIN_NAND_NWP		244
-#define AMS_DELTA_GPIO_PIN_NAND_NWE		245
-#define AMS_DELTA_GPIO_PIN_NAND_ALE		246
-#define AMS_DELTA_GPIO_PIN_NAND_CLE		247
-#define AMS_DELTA_GPIO_PIN_KEYBRD_PWR		248
-#define AMS_DELTA_GPIO_PIN_KEYBRD_DATAOUT	249
-#define AMS_DELTA_GPIO_PIN_SCARD_RSTIN		250
-#define AMS_DELTA_GPIO_PIN_SCARD_CMDVCC		251
-#define AMS_DELTA_GPIO_PIN_MODEM_NRESET		252
-#define AMS_DELTA_GPIO_PIN_MODEM_CODEC		253
-
-#define AMS_DELTA_LATCH2_GPIO_BASE	AMS_DELTA_GPIO_PIN_LCD_VBLEN
 #define AMS_DELTA_LATCH2_NGPIO		16
 
 #endif /* CONFIG_MACH_AMS_DELTA */
-- 
2.16.4

