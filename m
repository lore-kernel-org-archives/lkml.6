Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7641C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B7F21473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWJXB82t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B7F21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbeJBHzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:55:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42783 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeJBHzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:55:22 -0400
Received: by mail-io1-f67.google.com with SMTP id n18-v6so307152ioa.9;
        Mon, 01 Oct 2018 18:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zwN52st+YNLAWWPCPIsOPNRGOra3Er3luxbG8KqESBQ=;
        b=uWJXB82tGIGNJqIltwT7nLTgzumIkIikUuzdOYW5hYa8FsiIJnqQqZ79BaRmPo4K96
         VTLJYGXK6+6iQzE3fhgR8cH0IPD5YR7hog+bYAIZexfi8Yj7NdP3s25mA/bA5pRQqqlr
         WPZOSQhDI3lQbaXKV9qNQIu8HVSac7RldcofiMRXVQli5UyTX30Px99d+KpLIAqAtLox
         GqiOm9TCBka/k0ru3Ig4rArfkglu4bQhLAEWEfGpdoDAwEzJrBknqghe6mo8wz1P+U1P
         SDPpXJweMg/K2+oE31B1H8Yesm112kMyBmI4D+k3fYZHjL6sSTLMX1UrVZ/BoyLSQTn3
         +mwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zwN52st+YNLAWWPCPIsOPNRGOra3Er3luxbG8KqESBQ=;
        b=PpcNMwJnjXdMq5wMk8HLesYfo7fPvZ4JUCtbjJ1rLc3PpNMCCGuw6oxe50Q4IgqQK8
         3bANxB5ht+2fxK6xrFBuIudyjRYsSBBEw9C6EEokGFIne1s1geXBb3WN+ExRmcJ/fzyw
         6Yphz7ffh7YlGnY80mYN+b0mT2FIhQIMgrjQ7tqU9RpcKoxoHQLdH660BakJQI0KoHOH
         vMGrpVocDPlSIAnCaIg7e9Zc1fGWJHJys/r9FhGXKyiWvneRDRyFyQztiC3Iowf1meII
         unN4aQaMiKBHlwEM8QsaHGx95rDFz05GvX5jx9GTCyeJnGr8AFLw3i1MVsjdjkZvrIUw
         Yq1w==
X-Gm-Message-State: ABuFfojkw4mBlvcotGc/vtLXA6ulK3xSA54Z/wvYYiNcISVMajzlQrOZ
        jwKGAMVJecqP8sTFViNOA+M=
X-Google-Smtp-Source: ACcGV627xHAtaucQUP7uy0feIW45UkTgLmAJL+jl0YA4qy2fGplZ3kdajsfXzyfM2dVj/sdkwuiVaA==
X-Received: by 2002:a17:902:5590:: with SMTP id g16-v6mr14199314pli.46.1538442887795;
        Mon, 01 Oct 2018 18:14:47 -0700 (PDT)
Received: from localhost.localdomain (122-223-50-245.fukuoka.fdn.vectant.ne.jp. [122.223.50.245])
        by smtp.gmail.com with ESMTPSA id n22-v6sm20167798pfi.185.2018.10.01.18.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 18:14:47 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RESEND PATCH v4 3/8] gpio: 104-dio-48e: Utilize for_each_set_clump macro
Date:   Tue,  2 Oct 2018 10:14:50 +0900
Message-Id: <5906381114b14d5b0359510a1d23accbd239eaa5.1538441919.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-104-dio-48e.c | 67 ++++++++-------------------------
 1 file changed, 16 insertions(+), 51 deletions(-)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index 9c4e07fcb74b..77eeaa36094c 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -183,46 +183,23 @@ static int dio48e_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return !!(port_state & mask);
 }
 
+static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
+
 static int dio48e_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
 	size_t i;
-	static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
+	size_t word;
+	unsigned int offset;
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
 		port_state = inb(dio48egpio->base + ports[i]);
-
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= port_state << word_offset;
+		bits[word] |= port_state << offset;
 	}
 
 	return 0;
@@ -252,37 +229,25 @@ static void dio48e_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-	unsigned int i;
-	const unsigned int gpio_reg_size = 8;
-	unsigned int port;
-	unsigned int out_port;
+	size_t i;
+	size_t word;
+	unsigned int offset;
+	unsigned int iomask;
 	unsigned int bitmask;
 	unsigned long flags;
 
-	/* set bits are evaluated a gpio register size at a time */
-	for (i = 0; i < chip->ngpio; i += gpio_reg_size) {
-		/* no more set bits in this mask word; skip to the next word */
-		if (!mask[BIT_WORD(i)]) {
-			i = (BIT_WORD(i) + 1) * BITS_PER_LONG - gpio_reg_size;
-			continue;
-		}
-
-		port = i / gpio_reg_size;
-		out_port = (port > 2) ? port + 1 : port;
-		bitmask = mask[BIT_WORD(i)] & bits[BIT_WORD(i)];
+	for_each_set_clump(i, word, offset, mask, ARRAY_SIZE(ports), 8) {
+		iomask = mask[word] >> offset;
+		bitmask = iomask & (bits[word] >> offset);
 
 		raw_spin_lock_irqsave(&dio48egpio->lock, flags);
 
 		/* update output state data and set device gpio register */
-		dio48egpio->out_state[port] &= ~mask[BIT_WORD(i)];
-		dio48egpio->out_state[port] |= bitmask;
-		outb(dio48egpio->out_state[port], dio48egpio->base + out_port);
+		dio48egpio->out_state[i] &= ~iomask;
+		dio48egpio->out_state[i] |= bitmask;
+		outb(dio48egpio->out_state[i], dio48egpio->base + ports[i]);
 
 		raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
-
-		/* prepare for next gpio register set */
-		mask[BIT_WORD(i)] >>= gpio_reg_size;
-		bits[BIT_WORD(i)] >>= gpio_reg_size;
 	}
 }
 
-- 
2.19.0

