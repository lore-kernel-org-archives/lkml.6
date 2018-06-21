Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B96C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DCC223D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drE3vXJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4DCC223D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933905AbeFUWlv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:41:51 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44307 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933653AbeFUWls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:41:48 -0400
Received: by mail-lf0-f67.google.com with SMTP id p23-v6so6578255lfh.11;
        Thu, 21 Jun 2018 15:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TPhhFsd9FVMMGCxESDpS33/hjvQqU5CleXZVyVaf5pU=;
        b=drE3vXJvPdfuCp13P6QOu/PZYo70ZIjrgdzDAPZj8OYYKBom8ZOr4p6dhuLxbh1Yov
         Qj37RMSPBkP/CLbBaR91Ko+9wv/t0qJtN9vxHQVbDqEFZIS1uP93vXWicTV+kQMuNH+3
         pkoFDLyjLoFM7SG2P0yCESEYr02HJ3/D3UaEbd5q2GF0isnHyHWRRwJwvt4aoonpMQOb
         ZiYO5U87vVaR4dXvKhyt2XsZDcnAzYUkuOg2SNaGd30J1u7RfIUamE0gZGT4saUGvqRH
         EDzQf/M7pehbzQdIQAAPwqLbw6lcLTlJBS6XWZ6h6SLTEoLRo+DfGxIPjG3H4rAvuDR4
         zFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TPhhFsd9FVMMGCxESDpS33/hjvQqU5CleXZVyVaf5pU=;
        b=D8F98OJP6pPKqFRZJlwGV1BIPdFEsqNYV3MMCLlNTFmLwyN4FK/RI8xb3i6oFLVftV
         p0CrnOryMWrG6q2zkTnLoiHZLyFErILJZUvt1v2kmEau9XufwIf16qVO3SCRVUIddPZl
         1c7C0FMMiI6ATFcYZH42CH4KJOjZJDMivglmMCLRugJS3HmCbF/ouE7WzZC3YBojk/1U
         Bd8Itk+oP+MwL8ZXch3SLcFVPPGD4k+jE26gsj4prb5F+tvzpgy1ARrEK/qHizxgb87E
         3mdShUTtq9gozm62z3BXPbUZTabJtqJvuBARG/wkMPlZ1olfbYaxXSi5+Q4xgeE5OtVP
         VS2w==
X-Gm-Message-State: APt69E30A/R1Bw8+Orpw9MLjUJ2+Djs4HKw6PEALSLQysVJhZOuTtlMu
        ssu45R10zlStL2WHv6h9QXg=
X-Google-Smtp-Source: ADUXVKIar34fqaKLVdeNLepms4mazRhLKBCZvylqaNv7AGiDqTEQkbuoA2+vXJ79cS2F2gACLWezhw==
X-Received: by 2002:a19:141f:: with SMTP id k31-v6mr12877314lfi.23.1529620906628;
        Thu, 21 Jun 2018 15:41:46 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id t6-v6sm1046153lje.18.2018.06.21.15.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 15:41:45 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     "David S . Miller " <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2 01/10] ARM: OMAP1: ams-delta: drop GPIO lookup table for serio device
Date:   Fri, 22 Jun 2018 00:41:19 +0200
Message-Id: <20180621224128.17623-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180609140224.32606-1-jmkrzyszt@gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
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

Let's start with removal of the no longer needed GPIO lookup table from
the board init file.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Changelog:
v2: rebased on v4.18-rc1, no conflicts

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
2.16.4

