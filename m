Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDDFC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A09220878
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R15Vlkdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfALBsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 20:48:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33375 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfALBsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 20:48:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so7560546plo.0;
        Fri, 11 Jan 2019 17:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QRpQERtbKh/21jrrs3pu0HDTwJ5Ec3WzG9pqSzCr2+g=;
        b=R15VlkduRMAQy3j1tg+tp/SRVMObJbWXfb6snpuzaM2ozfURF5iLGORBdM2ez3kq16
         q+vyWVownlBg/18AwUe7TYhUllIda5UhaqPEehy6vAZEbnMgGDt4NTkVYDZx18qaaCwx
         mWGS+3Ca1YiZoWxsKr6LAWjFizBOM0WSVahjlhw3CyWAE04Tz19Edur8m8WtNrF6w1e6
         yuCeN3b06naTC7dW6iXXlKJBdG+69npNaKnP5ehPEy/QAHLn6RYpt4BXIIbgSDL8ZVXt
         zSOOUlL9OVXpVw6c+jNMNyLC5p8mz9L4wJfBLlys4oqoaqUhWsRVhMCGkAihH40Mc5a+
         BMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QRpQERtbKh/21jrrs3pu0HDTwJ5Ec3WzG9pqSzCr2+g=;
        b=JJRDp+qvPWXj5Sl50aCzgG/AGLRNziJ12hOpGabR1RI9/8/TJ6IB8B4hgb7D8lgFUj
         TWaW3NAikFSQPgw9+2RJS+xgAq/2yLnE1t6KXesQd46bcGEA8NzMgcyEpCAyqPQ155Gr
         3qs46t/WmgEGojMC+O9ciw67u+C2pYhi6VmwoFhV2hOilMLGjHv51tvioVTIimiugXGZ
         buRGRp/QvhohE1hz0OWDJA06Ui69GZf/KDC8iL7XxiI8+v1vyXbGDT2Od1Aw0UnCNgUi
         GWa1WU57U3FcKTyzb9PHPLwJ3KKQSySbNJQGCXxc7BRMGqrtad/lR3HItOfn/CJkOPPt
         SmMw==
X-Gm-Message-State: AJcUukcc42+d5+E+LLl0GqXtvVqejBd1dDNdG/v8FIP1iZrpa7UIHCDt
        69akCo0F+t8jHXSz9IL5NA4=
X-Google-Smtp-Source: ALg8bN6S2XwQ/uQx7rxzVVAkXQHcg+VdM8UhTG9tH+X2+nlsrHZtGRLtRwz+2mqOIHn8+tqUwmdyfw==
X-Received: by 2002:a17:902:2ec1:: with SMTP id r59mr17098176plb.254.1547257684728;
        Fri, 11 Jan 2019 17:48:04 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a3:ffc5:36e2:bccb:ba63:9e84])
        by smtp.gmail.com with ESMTPSA id c13sm117586446pfo.121.2019.01.11.17.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 17:48:04 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v7 3/8] gpio: 104-dio-48e: Utilize for_each_set_clump8 macro
Date:   Sat, 12 Jan 2019 10:48:41 +0900
Message-Id: <5a82cc7b828945a27d97b21f13410eb1404e5180.1547257386.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1547257386.git.vilhelm.gray@gmail.com>
References: <cover.1547257386.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-104-dio-48e.c | 71 ++++++++++-----------------------
 1 file changed, 20 insertions(+), 51 deletions(-)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index 92c8f944bf64..1093a1403d77 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -183,46 +183,25 @@ static int dio48e_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return !!(port_state & mask);
 }
 
+static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
+
 static int dio48e_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
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
-		port_state = inb(dio48egpio->base + ports[i]);
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		port_addr = dio48egpio->base + ports[offset / 8];
+		port_state = inb(port_addr) & gpio_mask;
 
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		bitmap_set_value8(bits, port_state, offset);
 	}
 
 	return 0;
@@ -252,37 +231,27 @@ static void dio48e_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
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
+		port_addr = dio48egpio->base + ports[index];
 
-		port = i / gpio_reg_size;
-		out_port = (port > 2) ? port + 1 : port;
-		bitmask = mask[BIT_WORD(i)] & bits[BIT_WORD(i)];
+		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
 
 		raw_spin_lock_irqsave(&dio48egpio->lock, flags);
 
 		/* update output state data and set device gpio register */
-		dio48egpio->out_state[port] &= ~mask[BIT_WORD(i)];
-		dio48egpio->out_state[port] |= bitmask;
-		outb(dio48egpio->out_state[port], dio48egpio->base + out_port);
+		dio48egpio->out_state[index] &= ~gpio_mask;
+		dio48egpio->out_state[index] |= bitmask;
+		outb(dio48egpio->out_state[index], port_addr);
 
 		raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
-
-		/* prepare for next gpio register set */
-		mask[BIT_WORD(i)] >>= gpio_reg_size;
-		bits[BIT_WORD(i)] >>= gpio_reg_size;
 	}
 }
 
-- 
2.20.1

