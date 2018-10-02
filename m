Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD763C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C6A2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbZY2XGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C6A2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeJBHz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:55:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40687 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbeJBHzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:55:55 -0400
Received: by mail-io1-f65.google.com with SMTP id w16-v6so315991iom.7;
        Mon, 01 Oct 2018 18:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FfjiSpjEIlqvsaN2IbZddJTCUXN2kDGkMsnfNg0Mraw=;
        b=kbZY2XGg9ETA1qErsEcjLNWDDpYd7ynkMZ185q72m0U5toxTkfJ8tdKLJk+IpmToPW
         KZ/IW81DLHVR40ZL2z+aHMm6v8UdESAilCcrwxabvc5S4ZWVbRaQhrtZBrIBfyUe8y0z
         vAf6dsql9XBlMBdKZPysPL/sXYO79wN1D+iFjagGqW1sS4UwLYlmwIwCnwoVvVYdfMxp
         LAmOCN8qAuC2ny8/OsYp+c+TEuS1AX8VDW/H76e/pqgm26v2eBA9odRUh+/zF5I55EcD
         TVsBx7vP3ADYoE2G4xf0Fu9kTAk1S9EMasKFLJAX2AT8aLMMyBQi1h1TwjojsfaNLLWn
         UVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FfjiSpjEIlqvsaN2IbZddJTCUXN2kDGkMsnfNg0Mraw=;
        b=f5G+enSnH0jCwa+vudad4mZxY3wSyDwK686hrHR2juhwFDZZJVrHljN1tIoYlv+UD2
         n17XX+OeJJMg73T16TVRbtL7ssNqGTAA0S7tfm5A8/dygT/Z+yL+vzy4wd4LwFlMo0vQ
         LNJwQOtRgxFWmotnzQY0NaboZdj1zEEBvX55VZm/idW+IPWrJeHKBRguI6A4+Oe3a3H1
         2DOzBk4Hq0wQUn4nDXupKsk/5r6xj4o4GPGZX8Gnhe7gNCAzxj7BHRmxlGTyN1gUjSAh
         IGjzeKtRoF8ck4pFJ2Rn+ZCmMUs5nfNmzgqcbYaJeOEgtTL8P4FTlGiZf+otonsZHdvr
         hrFg==
X-Gm-Message-State: ABuFfohfkx+ypQUaJYJbCbYmTK6g0WefCmxqR01HJlf9O7/b4LIwkPnX
        1P6VZvvz91jmj6gtyX/n1+k=
X-Google-Smtp-Source: ACcGV62TNkZ6JV4dKaJq6dOKrkF2LHmmlG0Xs0gXWhbpVQzi2kzQx7pE9RFY6HR87OsiwJ2qdB88Sw==
X-Received: by 2002:a17:902:8a4:: with SMTP id 33-v6mr14211915pll.65.1538442920611;
        Mon, 01 Oct 2018 18:15:20 -0700 (PDT)
Received: from localhost.localdomain (122-223-50-245.fukuoka.fdn.vectant.ne.jp. [122.223.50.245])
        by smtp.gmail.com with ESMTPSA id x24-v6sm21006464pfh.67.2018.10.01.18.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 18:15:20 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RESEND PATCH v4 5/8] gpio: gpio-mm: Utilize for_each_set_clump macro
Date:   Tue,  2 Oct 2018 10:15:24 +0900
Message-Id: <400c6325cf6311c87ff1d2093caba85f45618308.1538441919.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-gpio-mm.c | 67 +++++++++----------------------------
 1 file changed, 16 insertions(+), 51 deletions(-)

diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
index b56ff2efbf36..72668da8bf8d 100644
--- a/drivers/gpio/gpio-gpio-mm.c
+++ b/drivers/gpio/gpio-gpio-mm.c
@@ -172,46 +172,23 @@ static int gpiomm_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	return !!(port_state & mask);
 }
 
+static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
+
 static int gpiomm_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
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
 		port_state = inb(gpiommgpio->base + ports[i]);
-
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= port_state << word_offset;
+		bits[word] |= port_state << offset;
 	}
 
 	return 0;
@@ -242,37 +219,25 @@ static void gpiomm_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
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
 
 		spin_lock_irqsave(&gpiommgpio->lock, flags);
 
 		/* update output state data and set device gpio register */
-		gpiommgpio->out_state[port] &= ~mask[BIT_WORD(i)];
-		gpiommgpio->out_state[port] |= bitmask;
-		outb(gpiommgpio->out_state[port], gpiommgpio->base + out_port);
+		gpiommgpio->out_state[i] &= ~iomask;
+		gpiommgpio->out_state[i] |= bitmask;
+		outb(gpiommgpio->out_state[i], gpiommgpio->base + ports[i]);
 
 		spin_unlock_irqrestore(&gpiommgpio->lock, flags);
-
-		/* prepare for next gpio register set */
-		mask[BIT_WORD(i)] >>= gpio_reg_size;
-		bits[BIT_WORD(i)] >>= gpio_reg_size;
 	}
 }
 
-- 
2.19.0

