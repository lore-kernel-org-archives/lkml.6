Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31FFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F0F20660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsKQj8oZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfANGU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 01:20:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43620 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfANGU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 01:20:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so9846882pfk.10;
        Sun, 13 Jan 2019 22:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qk6urxPIgJJYGoEW+onEogrBASL2VWd+ofU4Pr23QDg=;
        b=UsKQj8oZ33fue4em3GCAo9MWSPlxltCxIb4VCrknsekLfiDbzC+Y9ngrHrPyId3Ew2
         K0OQb4/Xfr3NptOo8A3UziE9xlYPs6q8ywhpfOa1oGMjKGlhtnJl1zfbl8r7VLJJIBzG
         UyMiE0pnDS14NRDNkGgAmNCmnWdu+a6RKhuyIrFkQCKgj1XBp51Rz3MP3ErUokz3aUBO
         kJPt0zdp3aVn4CfC+trGy3CLNGjtkfL0bQYRo8yHmtFFCAl6qokFaxGzOmILg9wT4R7p
         h39Gbe8CJ34SvTY/8g1M/IMbQ3jlxkqKJo4SethRXBxQbH2nWt9XYSvvAOIlT+WQloQA
         oNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qk6urxPIgJJYGoEW+onEogrBASL2VWd+ofU4Pr23QDg=;
        b=BFfxd4DeUi2aSPIsbWQxFIiSppixtZUuO/MgAe1EbhNLfMXtEiDmBoAOBgYqZuPVCK
         GQvnzrK9Gvkm+N5m+u+Oqmve9HLh56AxjpwqrmU5XpYqHkw76WwfCq5+Ob76WPpID1ht
         uH2mUj/Oo5gFAU4uII68BmmnDEklvEDeJzQXGv2lLxs+apo+DLK8RxoKBPMBiKCyJDhB
         0zFBmoz5RjPZ203DkoV27Oh14hCLf5BQzeG2i+aVu8G01V/JAb6QwTzdel+Od1/NqZmG
         K9xRbaVY0jOlOHa5RjyQSCWIgH+sk7SvwVKda1u0yuAyBVM9ip5tBmiTOytxmMIlsjsg
         sQ5w==
X-Gm-Message-State: AJcUukeXcwm3NJaUZcFUfmHE1iJ2z7WoGimvBp6dNMe2ukQxeKrOCc76
        BrOmNgw7tsXXq4tMPN4PajY=
X-Google-Smtp-Source: ALg8bN4HFl9gFfW+9+NQbEuT1ssM8Jh0Uk5p1FH10j99Sab/hdaDlKeGTcUfgh5zgKobXco5Gk+C9Q==
X-Received: by 2002:a65:62da:: with SMTP id m26mr21849195pgv.278.1547446826226;
        Sun, 13 Jan 2019 22:20:26 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a3:70f2:4411:7de2:8afe:823b])
        by smtp.gmail.com with ESMTPSA id b7sm123033949pfa.52.2019.01.13.22.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 22:20:25 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v8 5/8] gpio: gpio-mm: Utilize for_each_set_clump8 macro
Date:   Mon, 14 Jan 2019 15:21:02 +0900
Message-Id: <c05cd8bde1a13a18080d6261bf4f0ace96fbd13a.1547445576.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1547445576.git.vilhelm.gray@gmail.com>
References: <cover.1547445576.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-gpio-mm.c | 73 +++++++++++--------------------------
 1 file changed, 22 insertions(+), 51 deletions(-)

diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
index 8c150fd68d9d..4c1037a005ab 100644
--- a/drivers/gpio/gpio-gpio-mm.c
+++ b/drivers/gpio/gpio-gpio-mm.c
@@ -172,46 +172,26 @@ static int gpiomm_gpio_get(struct gpio_chip *chip, unsigned int offset)
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
+	const unsigned int ngpio = ARRAY_SIZE(ports) * 8;
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
+	for_each_set_clump8(offset, gpio_mask, mask, ngpio) {
+		port_addr = gpiommgpio->base + ports[offset / 8];
+		port_state = inb(port_addr) & gpio_mask;
 
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		bitmap_set_value8(bits, ngpio, port_state, offset);
 	}
 
 	return 0;
@@ -242,37 +222,28 @@ static void gpiomm_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-	unsigned int i;
-	const unsigned int gpio_reg_size = 8;
-	unsigned int port;
-	unsigned int out_port;
+	unsigned int offset;
+	unsigned long gpio_mask;
+	const unsigned int ngpio = ARRAY_SIZE(ports) * 8;
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
+	for_each_set_clump8(offset, gpio_mask, mask, ngpio) {
+		index = offset / 8;
+		port_addr = gpiommgpio->base + ports[index];
 
-		port = i / gpio_reg_size;
-		out_port = (port > 2) ? port + 1 : port;
-		bitmask = mask[BIT_WORD(i)] & bits[BIT_WORD(i)];
+		bitmask = bitmap_get_value8(bits, ngpio, offset) & gpio_mask;
 
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

