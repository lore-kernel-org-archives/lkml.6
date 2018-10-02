Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1995FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11612083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNNu7Qje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11612083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbeJBHzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:55:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38001 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbeJBHzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:55:37 -0400
Received: by mail-io1-f65.google.com with SMTP id y3-v6so318724ioc.5;
        Mon, 01 Oct 2018 18:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xpGa80iX9fEfLAyCX1u+8anej+FtjsNOpOw/QFUH+P0=;
        b=UNNu7QjelsALz/AaO1AXGNT/UNj3VDIB7ggZ7BZztC31dlwej5eNxQ/YcLco92wKDc
         ReOSRXg3h1mYPJyuSmjnjxTviSzVKcpRorAcYslWA79TowcKPQzxlu2GDc+Y/+/yJCCV
         BIH/96IwVm1ItqpzoIElZPDfRDaxt2DOpejcvw8m/Be6ropgBnRVR1l40Rb9BQHVpwED
         nMdWhtKGOcWPI8Oj3/Lf2S9CLdrd67n57O2htwS0fWD10kh229U1KEuP+jPT7CG5Iry6
         EHjMo4nr10zTNfAA9CE5aEW1UVsL3426AD378x9gZMGMfCJ3Xcu8ToSVMVKg9Ntu72xY
         mSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xpGa80iX9fEfLAyCX1u+8anej+FtjsNOpOw/QFUH+P0=;
        b=Yvyl+kNCBov4LEgBtMz2vQT/rmqwpGAWciFatuptk36zB+/vrU7tufu9TjEWrgXUdu
         oPR5DpVmzS5Z/LeVSYZE1xxFBSz9s/Onhbo98ZTmkWkx4dZUMdhl4WoyNMiCGQ7/7t1X
         dzcbRFcbP+yKERm/LuT5YifGOrrW/Ff0o2/zn+gR4LDF1gPLFdyZWiIlxS9ui/p1VT9+
         z2HsuMx9F/WJJ+GvJxRrl1K25iWMXJSwxpA/PsDuxt/7cP9uwXWVuiNNCpAJjCOOBgUQ
         vxjMybI2YYOlTDOr8q3LMlqSEx/L+kW5YX9qY9Rj0Z2y93i5lb1mwqE2ahxLvyUHC7HR
         ImDA==
X-Gm-Message-State: ABuFfoijyc9iOJ8ILt/k0xo/jU/0inZte03u9Lm93CMMFg8MlKRdjbjc
        kIZz1pIQHPgYhbAu5kweysKOw5YS
X-Google-Smtp-Source: ACcGV61pVZsQzj9/QMMT4cgIMBKRE6NMiH5+fkjI8nzuVNtmKzlLJoeWpTA5M59lBKcmE9om39s+6w==
X-Received: by 2002:a17:902:187:: with SMTP id b7-v6mr8445436plb.150.1538442902675;
        Mon, 01 Oct 2018 18:15:02 -0700 (PDT)
Received: from localhost.localdomain (122-223-50-245.fukuoka.fdn.vectant.ne.jp. [122.223.50.245])
        by smtp.gmail.com with ESMTPSA id r1-v6sm20202905pff.145.2018.10.01.18.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 18:15:02 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RESEND PATCH v4 4/8] gpio: 104-idi-48: Utilize for_each_set_clump macro
Date:   Tue,  2 Oct 2018 10:15:05 +0900
Message-Id: <0f69499043ff2ea312c358f9042e495cf5c34449.1538441919.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1538441919.git.vilhelm.gray@gmail.com>
References: <cover.1538441919.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace verbose implementation in get_multiple/set_multiple callbacks
with for_each_set_clump macro to simplify code and improve clarity.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-104-idi-48.c | 32 ++++----------------------------
 1 file changed, 4 insertions(+), 28 deletions(-)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index 2c9738adb3a6..f8de5560174f 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -94,41 +94,17 @@ static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 {
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
 	size_t i;
+	size_t word;
+	unsigned int offset;
 	static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports); i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
-
-		/* word index for bits array */
-		word_index = BIT_WORD(bits_offset);
-
-		/* gpio offset within current word of bits array */
-		word_offset = bits_offset % BITS_PER_LONG;
-
-		/* mask of get bits for current gpio within current word */
-		word_mask = mask[word_index] & (port_mask << word_offset);
-		if (!word_mask) {
-			/* no get bits in this port so skip to next one */
-			continue;
-		}
-
-		/* read bits from current gpio port */
+	for_each_set_clump(i, word, offset, mask, ARRAY_SIZE(ports), 8) {
 		port_state = inb(idi48gpio->base + ports[i]);
-
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= port_state << word_offset;
+		bits[word] |= port_state << offset;
 	}
 
 	return 0;
-- 
2.19.0

