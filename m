Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB322C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01232184A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMYB5SQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeLRKMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:12:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33073 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbeLRKMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:12:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so7618626plo.0;
        Tue, 18 Dec 2018 02:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=85H/4t6RkooDK10L2W5Uhts7AwM0xn2RPdanjNRGSLI=;
        b=IMYB5SQuGgtXrdAn/xxZkh+DNeUZE7ztaWqW4U2mvfeYd8TrU8oBkET58UTPC1/YVc
         45U1XNALOBODzzyuX/X4tjVQXg1G2FJht2IuXPcyMrlKgJlJ3APu8nYyOjFnJQBRUu4T
         PD+hwMMaoZucKDE1s8/RO0gydBoDZXqdKxmrSWgSWwUfnPoBe0YA/jPnwnBYTs79MwaZ
         fQeRDKhYshKDGFg6n2l/tLwAl+d+LLFImFET7TUSZUH9kHOHRgOxcVJzw8nlcvXM2ypE
         hk7XmJs4Beb1uAaqxkPB/xPPOAo72Sk8dolBQA1rbjuxbJWwKP10E3W6KL8BXz+8or3L
         12ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=85H/4t6RkooDK10L2W5Uhts7AwM0xn2RPdanjNRGSLI=;
        b=DCPhfy3wESHyFegflCCCL5MwevyUmNQbSYg+dmJ0HihuQYlHfU6GJpjAwi+s9eiiwV
         lKXC9nLBxAWRfSv2mrAWGdn2ovyC3V6uaiutyw7CxixwP3Qk8qwQ4dsz/2Giw/EuWmbS
         6njlSaLwl+8uWuqRROLa13kVK/gicnYXIrIFohCQ/QMEocFNf9AjHLjRvgEFHDbspp1T
         pLC/4+KvoC5ckg4exeujC/xRXabDLgsjAKgNXLc14qGOXsgg5xU3fOpkEsTMNbA5OqRP
         11g2xQfg+BKAnS4UKImbUv0mwm8dYMiVsBTIGZvoI0IqzJmtnKupzKeTtJmodrrib8Yt
         GBqw==
X-Gm-Message-State: AA+aEWb8yk63rKe5Lbz0w2PWwrL6rbWdvDkk7uF6YHoZw5mYPIvP8xl4
        W+yC2cNZAaMCnc6n55gf8C0=
X-Google-Smtp-Source: AFSGD/XxYWMwLNavSJlTSy3Sg+5dfxAybxJ92j5y3zXEyGcy09zPD8+antRKUCNrhPHOQxBteNAEVA==
X-Received: by 2002:a17:902:e290:: with SMTP id cf16mr16311430plb.81.1545127967494;
        Tue, 18 Dec 2018 02:12:47 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a5:b5e9:3c79:e26e:bf45:b953])
        by smtp.gmail.com with ESMTPSA id 85sm20998587pfw.17.2018.12.18.02.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 02:12:46 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v5 5/8] gpio: gpio-mm: Utilize for_each_set_clump8 macro
Date:   Tue, 18 Dec 2018 19:13:17 +0900
Message-Id: <0038b39823b7b593fb939319eda01a383303fdc1.1545126272.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1545126272.git.vilhelm.gray@gmail.com>
References: <cover.1545126272.git.vilhelm.gray@gmail.com>
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

