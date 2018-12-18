Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3D9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2B3217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuwS4jQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbeLRKNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:13:10 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36501 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeLRKNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:13:05 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so7919976pfc.3;
        Tue, 18 Dec 2018 02:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DkIxDSyjoROWp7biDXggOXD5cmZ4EeyYKd2Z/CBdLgA=;
        b=VuwS4jQb43gCuNikOgXwA9GPFv9doqun7yeDT/UGg0sLgRwbYkWVaUIa4y9m1berzx
         LquFMiE2Cxtp+pqtyGfs5OaF5OyzO2hmCU+XtWGW3B+rfurpjvI7qpbXtAGXRXdEmQ8W
         kjq1+VOQm9H/6Vf4JWX0jq4e7HiRysbs7/BS9c8QU0U8FQYRVexHJdmRcQkP14jnsVNR
         EN8sWz20T2bXpA52BaMz21ZtYSneH7isg340xrYgFQiiLw7kF46XxHQzsh6z58aJqQx5
         1M/roOdpD4AK8XFyQDfC62GlZhgXRb7O5XsQzg1jQzFGS4theNfawEV4hHAoKthIGilb
         PDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DkIxDSyjoROWp7biDXggOXD5cmZ4EeyYKd2Z/CBdLgA=;
        b=HTx4iqR4XygWvBaa+aB4tkKnWLS4OkQttdZcwREnMORk0/GVvd+fIStOBA25NhuiX4
         uyodU/mCRT2D9PC7iWI2Oa+LPKFqw6SUm1ffWkT0payA1TSBBOG1Sv/BbqnM6k3Jj5DU
         koS4yj4y3IcdKsi9QSBee6Cgfc1fGk5aYDu66Ri5b5UhYWE1zvJkKeNCGVH5w7R3M5fd
         ZhOpxqqcmovD+V/2JQvJ89UPygURffknP6vlSgJ0XqRKOmKsu7NNHHY5Zzze/xKHfGiT
         2tSlJLp9I+cH5xYPKGMB/z5djrsFk3hLONuwuAmCljP3Soo4/ackWaYO2JCMZx9/Mh4x
         XpzQ==
X-Gm-Message-State: AA+aEWaMRhlN4rk6xutF2kNq2VmE6f+OPSn4bV716CcdEhcQ4Soq2SIg
        +QMoX30O6Nn2tTWNQwSyfK8=
X-Google-Smtp-Source: AFSGD/V9J5o76PLmrWdB22Po1J0rKbNEQtLynKYDWLOil9NW6WY1RqkeYUSb/tyxulS7wdIM+//kDg==
X-Received: by 2002:a62:4b4d:: with SMTP id y74mr15930048pfa.186.1545127984677;
        Tue, 18 Dec 2018 02:13:04 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a5:b5e9:3c79:e26e:bf45:b953])
        by smtp.gmail.com with ESMTPSA id m85sm22412316pfj.171.2018.12.18.02.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 02:13:04 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v5 6/8] gpio: ws16c48: Utilize for_each_set_clump8 macro
Date:   Tue, 18 Dec 2018 19:13:33 +0900
Message-Id: <770cb1aa50178e3543b705909f51bc9e064bcb86.1545126272.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-ws16c48.c | 71 ++++++++++---------------------------
 1 file changed, 19 insertions(+), 52 deletions(-)

diff --git a/drivers/gpio/gpio-ws16c48.c b/drivers/gpio/gpio-ws16c48.c
index 5cf3697bfb15..b4c544d5da18 100644
--- a/drivers/gpio/gpio-ws16c48.c
+++ b/drivers/gpio/gpio-ws16c48.c
@@ -134,42 +134,19 @@ static int ws16c48_gpio_get_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
-	const unsigned int gpio_reg_size = 8;
-	size_t i;
-	const size_t num_ports = chip->ngpio / gpio_reg_size;
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
-	for (i = 0; i < num_ports; i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
+	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
+		port_addr = ws16c48gpio->base + offset / 8;
+		port_state = inb(port_addr) & gpio_mask;
 
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
-		port_state = inb(ws16c48gpio->base + i);
-
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		bitmap_set_value8(bits, &port_state, offset);
 	}
 
 	return 0;
@@ -203,39 +180,29 @@ static void ws16c48_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
-	unsigned int i;
-	const unsigned int gpio_reg_size = 8;
-	unsigned int port;
-	unsigned int iomask;
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
-
-		port = i / gpio_reg_size;
+	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
+		index = offset / 8;
+		port_addr = ws16c48gpio->base + index;
 
 		/* mask out GPIO configured for input */
-		iomask = mask[BIT_WORD(i)] & ~ws16c48gpio->io_state[port];
-		bitmask = iomask & bits[BIT_WORD(i)];
+		gpio_mask &= ~ws16c48gpio->io_state[index];
+		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
 
 		raw_spin_lock_irqsave(&ws16c48gpio->lock, flags);
 
 		/* update output state data and set device gpio register */
-		ws16c48gpio->out_state[port] &= ~iomask;
-		ws16c48gpio->out_state[port] |= bitmask;
-		outb(ws16c48gpio->out_state[port], ws16c48gpio->base + port);
+		ws16c48gpio->out_state[index] &= ~gpio_mask;
+		ws16c48gpio->out_state[index] |= bitmask;
+		outb(ws16c48gpio->out_state[index], port_addr);
 
 		raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
-
-		/* prepare for next gpio register set */
-		mask[BIT_WORD(i)] >>= gpio_reg_size;
-		bits[BIT_WORD(i)] >>= gpio_reg_size;
 	}
 }
 
-- 
2.20.1

