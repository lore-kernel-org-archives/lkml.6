Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F85C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34064217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs8D01ND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbeLSGBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 01:01:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45601 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbeLSGBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 01:01:22 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so8946161pgc.12;
        Tue, 18 Dec 2018 22:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=85H/4t6RkooDK10L2W5Uhts7AwM0xn2RPdanjNRGSLI=;
        b=bs8D01NDGRrQMYQeznQEUI87B/5jG5L0Zm2E3nB1wbgxDqkWavCfYb9XVR0iGOxhHs
         6lKf3kSAcNplpUuq4YbSGpTeb9LullDC8ZJb5kkBcDbVwzcyg3lo4GcMuNyWpju+EM6c
         E2Yw43ILSZ7qkqXfqSYPNATYje8bKhjq1YD3vkyvcD6OvHscULQp5HemeelM5OhsDr2z
         8q/nAXVYUeO4kAE5CqZdLiLpSB/en5tjMAuQMZ5itFVR1nNBYXQrixVsuMmi8owqm9ce
         lz7rWFrA5+43643xsL8F6IoMXBdQBmPnMTFwB03m+86jNkjL+z9z5PWBg1nN5Wm8Knga
         8Stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=85H/4t6RkooDK10L2W5Uhts7AwM0xn2RPdanjNRGSLI=;
        b=U3oFe061wrXUP9Wj+wmk5f4CS0EJNlQhB8szLLxi7O0b+zMUAEYh0P8uHmCwIz9Inp
         Y5Bs24bqwo+oJs/RmuhKgG/mC/2Qj4FCH7Zv7vVXJS8OFBbAN8Y0k9MRoeN8YPcRDFsY
         ZmgV4Gyt0Ysr02vSXB2G0/AR0+Sr9Ibm9PaKrPh0fFsu7Y7wi/T54n4SzAuT4UevLTGC
         SW02pmTbhfHPjMKDbQQ4uU7s5H9Kd1R1Bp3wTkrA8ZbrCtq9YhcsuLAjhGq87VdyE3RH
         GVLP+yYG8Ti8Y+Xgz2ovk1iZPyQLTq9ntWdwSIZAPYs/y0gkB7BgIGpxUnknSTbAr2EH
         y6EQ==
X-Gm-Message-State: AA+aEWahKckk7CjvyRc808qxm97IMytT/RchBHErcwpp7lSJmKcxbE26
        OqZvomuvSr4NKvE9zTgRel8zffi8
X-Google-Smtp-Source: AFSGD/UcrILknSxpVDLDAcvOQm+uq/TzPuniH98X6Cc9U0UDisgtiBR1YtRZmcMzC6rgQpWATQ7Hww==
X-Received: by 2002:a62:509b:: with SMTP id g27mr19577844pfj.48.1545199280959;
        Tue, 18 Dec 2018 22:01:20 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a2:eb51:6018:45d4:55a2:e94b])
        by smtp.gmail.com with ESMTPSA id v89sm25093381pfk.12.2018.12.18.22.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 22:01:20 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v6 5/8] gpio: gpio-mm: Utilize for_each_set_clump8 macro
Date:   Wed, 19 Dec 2018 15:01:50 +0900
Message-Id: <1a54a935c918d2b9c2dcd268e1ccc34ba3c00142.1545198260.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1545198260.git.vilhelm.gray@gmail.com>
References: <cover.1545198260.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace verbose implementation in get_multiple/set_multiple callbacks
with for_each_set_clump8 macro to simplify code and improve clarity.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-gpio-mm.c | 71 +++++++++++--------------------------
 1 file changed, 20 insertions(+), 51 deletions(-)

diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
index 8c150fd68d9d..5647abe72376 100644
--- a/drivers/gpio/gpio-gpio-mm.c
+++ b/drivers/gpio/gpio-gpio-mm.c
@@ -172,46 +172,25 @@ static int gpiomm_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	return !!(port_state & mask);
 }
 
+static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
+
 static int gpiomm_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-	size_t i;
-	static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
+	unsigned int offset;
+	unsigned long gpio_mask;
+	unsigned int port_addr;
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
-		port_state = inb(gpiommgpio->base + ports[i]);
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		port_addr = gpiommgpio->base + ports[offset / 8];
+		port_state = inb(port_addr) & gpio_mask;
 
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		bitmap_set_value8(bits, &port_state, offset);
 	}
 
 	return 0;
@@ -242,37 +221,27 @@ static void gpiomm_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-	unsigned int i;
-	const unsigned int gpio_reg_size = 8;
-	unsigned int port;
-	unsigned int out_port;
+	unsigned int offset;
+	unsigned long gpio_mask;
+	size_t index;
+	unsigned int port_addr;
 	unsigned int bitmask;
 	unsigned long flags;
 
-	/* set bits are evaluated a gpio register size at a time */
-	for (i = 0; i < chip->ngpio; i += gpio_reg_size) {
-		/* no more set bits in this mask word; skip to the next word */
-		if (!mask[BIT_WORD(i)]) {
-			i = (BIT_WORD(i) + 1) * BITS_PER_LONG - gpio_reg_size;
-			continue;
-		}
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		index = offset / 8;
+		port_addr = gpiommgpio->base + ports[index];
 
-		port = i / gpio_reg_size;
-		out_port = (port > 2) ? port + 1 : port;
-		bitmask = mask[BIT_WORD(i)] & bits[BIT_WORD(i)];
+		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
 
 		spin_lock_irqsave(&gpiommgpio->lock, flags);
 
 		/* update output state data and set device gpio register */
-		gpiommgpio->out_state[port] &= ~mask[BIT_WORD(i)];
-		gpiommgpio->out_state[port] |= bitmask;
-		outb(gpiommgpio->out_state[port], gpiommgpio->base + out_port);
+		gpiommgpio->out_state[index] &= ~gpio_mask;
+		gpiommgpio->out_state[index] |= bitmask;
+		outb(gpiommgpio->out_state[index], port_addr);
 
 		spin_unlock_irqrestore(&gpiommgpio->lock, flags);
-
-		/* prepare for next gpio register set */
-		mask[BIT_WORD(i)] >>= gpio_reg_size;
-		bits[BIT_WORD(i)] >>= gpio_reg_size;
 	}
 }
 
-- 
2.20.1

