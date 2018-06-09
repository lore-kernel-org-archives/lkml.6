Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SLx4EjfYG1taKwAAmS7hNA
	; Sat, 09 Jun 2018 14:02:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 245F7608BA; Sat,  9 Jun 2018 14:02:43 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8rRgTOQ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DABE76074D;
	Sat,  9 Jun 2018 14:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DABE76074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753319AbeFIOCk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 10:02:40 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38169 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753062AbeFIOCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 10:02:37 -0400
Received: by mail-lf0-f65.google.com with SMTP id i83-v6so24177401lfh.5;
        Sat, 09 Jun 2018 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KqMR5MOiwe8rDPnpmEXsY4mPzCR9+MDFfmVGp35l1fk=;
        b=c8rRgTOQR3h0EK3AeiRK/DuGd6y3FmRNLhkFeBHyuI7diXXpvGNxI+idLx24zfLvmu
         YMoumiSLbV4JPj+I3JbZkPsfykU9+SpcYRv6BoJkoQ3EIOcAG2cNuFjvna9QFBa/FQIk
         mWRM1Uxa2oiCcAX7FOZcX2HZQ1edbPvwtG2z0zAmDrUhYcwc8Ml8zxZ8FkBZlVFNNi5h
         MHvhFC201fQDhsOnD5TzuPJ/pBAbI6+GpCjT32v7Fs12o8spuSSBM4gSZdNUZcLGrZS1
         5TulQFxQJ7aWkMZRq9dByEOt59aiJg6XTW0VyOIx/FxiY4i0H0MYKI3p1t4bifUkxdzx
         UNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KqMR5MOiwe8rDPnpmEXsY4mPzCR9+MDFfmVGp35l1fk=;
        b=miCz/7NRfStfXPmtWu7pDHAcg3+BdHxnm5Okkwh0/gKEv+ftKHhxkwZazTN06bHgwI
         4aEedZAb9xI4BHOhUxYIi3vH9fCctLB7ZUA+6KgN53Z0pp4UG8OrlY1mzxtc/nspz/Um
         /y3kXbsqEZgm3KwRbLK2N326/ADt96hrvqregNo3ZRicNg7hHDctMusOcFZD80RqKIxW
         cNfsYovnGj6MiU22yQBcAQCb3/mOtvIGOJxE9urWQLcATXknXviUA7iqoERCRa6pK0Dy
         bLlEHTyqVOwhEWhYH3QkdA+rJEMLII8Pj26vjzfvQwu4mLXzdy66gAgUzfBSLBog3oEP
         a9YA==
X-Gm-Message-State: APt69E3lRkonxuTSW4kgwBWWtMEn80eR8xtmlSiyq9fSIQ1/OW0s1sog
        p2JDhFkUw6DZcb8RZl2t8wQ=
X-Google-Smtp-Source: ADUXVKJtTVVAWwhgWd0C15mEp86/PWpbpAgiLwVfjt6AzUOJGmSmF+YB5dhDsp0+1PvYxHWVEsLxmA==
X-Received: by 2002:a19:7:: with SMTP id 7-v6mr6644480lfa.62.1528552955633;
        Sat, 09 Jun 2018 07:02:35 -0700 (PDT)
Received: from localhost.localdomain (apn-31-0-40-98.dynamic.gprs.plus.pl. [31.0.40.98])
        by smtp.gmail.com with ESMTPSA id n84-v6sm4477727lfi.19.2018.06.09.07.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jun 2018 07:02:34 -0700 (PDT)
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 01/10] ARM: OMAP1: ams-delta: drop GPIO lookup table for serio device
Date: Sat,  9 Jun 2018 16:02:15 +0200
Message-Id: <20180609140224.32606-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO lookup table for ams-delta-serio device was introduced by commit
0486738928bf ("ARM: OMAP1: ams-delta: add GPIO lookup tables").
Unfortunately, a follow up patch "Input: ams_delta_serio: use GPIO
lookup table" was not accepted by subystem maintainer who requested
conversion of the driver to a platform driver, replacepemnt of IRQ GPIO
pin with IRQ resource, replacement of GPIO pin providing keyboard power
with a regulator and removal of remaining GPIO pins from the driver as
not handled by it.

Let's start with removal of no the longer needed GPIO lookup table from
the board init file.

Series created and tested on top of next-20180608 tag from linux-next
tree.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 80f54cb54276..18e0ff437b27 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -504,20 +504,6 @@ static struct platform_device cx20442_codec_device = {
 	.id     = -1,
 };
 
-static struct gpiod_lookup_table ams_delta_serio_gpio_table = {
-	.table = {
-		GPIO_LOOKUP(OMAP_GPIO_LABEL, AMS_DELTA_GPIO_PIN_KEYBRD_DATA,
-			    "data", 0),
-		GPIO_LOOKUP(OMAP_GPIO_LABEL, AMS_DELTA_GPIO_PIN_KEYBRD_CLK,
-			    "clock", 0),
-		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_KEYBRD_PWR,
-			    "power", 0),
-		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_KEYBRD_DATAOUT,
-			    "dataout", 0),
-		{ },
-	},
-};
-
 static struct platform_device *ams_delta_devices[] __initdata = {
 	&latch1_gpio_device,
 	&latch2_gpio_device,
@@ -534,7 +520,6 @@ static struct platform_device *late_devices[] __initdata = {
 
 static struct gpiod_lookup_table *ams_delta_gpio_tables[] __initdata = {
 	&ams_delta_audio_gpio_table,
-	&ams_delta_serio_gpio_table,
 };
 
 static struct gpiod_lookup_table *late_gpio_tables[] __initdata = {
@@ -580,10 +565,6 @@ static void __init ams_delta_init(void)
 	 */
 	ams_delta_audio_gpio_table.dev_id =
 			dev_name(&ams_delta_audio_device.dev);
-	/*
-	 * No device name is assigned to GPIO lookup table for serio device
-	 * as long as serio driver is not converted to platform device driver.
-	 */
 
 	gpiod_add_lookup_tables(ams_delta_gpio_tables,
 				ARRAY_SIZE(ams_delta_gpio_tables));
-- 
2.16.1
