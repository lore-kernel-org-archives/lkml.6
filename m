Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1186102-1525707345-2-14197578169285422485
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525707345; b=IdxX2ALoRwW1lOl7bSC+MjyMA6ckDwycwqI4ge3H8te7/DMleM
    4FTwDza9UX0UIppu9E0bKC0iOAhNh0jJrcvOFsECCmgNAP8Y4RI8E1L99K00oWku
    4+8KCF7eYI7gs6xfGf8GZxxC31qsz92SQrbybnwPmDLW9TeJbmvwOin2zn25wwE8
    cQq8FXQ6Oaj7gXegG4NrpJSaE9a4J/JDRRzqH24qk7Uxi9iVyJGby0vVOvdfL2uw
    sUAwePm1bYcFLr2E32EpEMPAfbXBoqw9+fck7dNHybUCIvOfQK7N9IV6AZS4nflP
    n0FKEZf/Er9w5igjLLOCp1Ckw4j5hHZQvbzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525707345; bh=
    7Yqxn8f02xGv64GoRNMIvu3lBrnW81qZRBJYu4SXOtE=; b=dpUqr2sm/0khARoG
    OMQnJCzduxUOjrJa35Dj7duY4+0xHYOrkERYzTh9ZPsHAXf+sWyGP2c/ArGBw4rS
    Vt6KygVTyWsQQaAeuistuQuVAw16AyM6VcuKpqewFXnerBJEz8eyx0VY8oEgLIEc
    aT7il07BpcatdGcQQzh0DmWBdWMMVzmGuOfQmidc+PY7u97jyxL2faqgkWnFk4Z7
    IDApJ2Z/FdTUgp5l8YSQlCX1MsTEGGUXPUYecULH3/Hvg+NUK02BtG5Rg1FkooK0
    ZtWRGt690TP2RQwLoWIBLUvR7XIoIxnBMQNH2PICy33FjkDbBVGhe4vtUJ9gsCKy
    wltZtA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=YXVwlrZZ x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=lojXOiSx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=YXVwlrZZ x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=lojXOiSx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPmOtmY0hCjDud48miOZoeF/Ot/1n/GxHhxMd/2z/k1uPwVN3FwaTwLP+ZgVsJryB1P2+DqSTLj9S2pXIlRJ6aRsgc1jo7r4pb/4v0qOh8wR1zqdp75f
    HNtvZBXIfn43/B1NtM1S8+2BpPTIoVcMQPUFeO/nkE2F8sDnAZ31yxA3lIcP+cn1B1A2awD7Islf6iD5s+UrWxJ4+WYxZIbTHzC1xfJH2pO2rXENM8PdCKWI
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=i6uMeK6BI1QA:10
    a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=23zcXjzEi2UVHqVrFbEA:9
    a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeEGPfm (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 11:35:42 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36027 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752309AbeEGPfj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 May 2018 11:35:39 -0400
X-Google-Smtp-Source: AB8JxZrAoeacKT63RdgoMmOdrn/SuHEraPvwpA2TqZRlMnTTDQ7PluDj51cPBUOb24HRAmylat+8HA==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 2/7] gpio: 104-dio-48e: Utilize for_each_set_port_word macro
Date: Mon,  7 May 2018 11:35:31 -0400
Message-Id: <1ae1bf3604e0fe5136322c26054770a29a129f20.1525704095.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525704095.git.vilhelm.gray@gmail.com>
References: <cover.1525704095.git.vilhelm.gray@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace boilerplate code in get_multiple/set_multiple callbacks with
for_each_set_port_word macro to simplify code and improve clarity.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-104-dio-48e.c | 67 ++++++++-------------------------
 1 file changed, 16 insertions(+), 51 deletions(-)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index 9c4e07fcb74b..843f1c71e814 100644
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
+	for_each_set_port_word(i, word, offset, mask, ARRAY_SIZE(ports), 8) {
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
+	for_each_set_port_word(i, word, offset, mask, ARRAY_SIZE(ports), 8) {
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
2.17.0
