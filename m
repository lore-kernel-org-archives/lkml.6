Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE80C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A282184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mq/SKHN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbeLSGB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 01:01:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41276 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbeLSGB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 01:01:58 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so8969721plm.8;
        Tue, 18 Dec 2018 22:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wIUcUn9NZpZ4AkNdcsel1CBOeLuu/XGaElsnv6eh2k0=;
        b=Mq/SKHN1Pa1jJV/gK8xYyQVVXSeSxSKLvUSNyDtEOSaTc51svpF4JLwagxE6Bwk5lo
         VsaZ9UNZuPx8c3y00lXdiYWuuaUKe3QhReyuFBv8y0vlFtx6SIa2RyGnzeWRgEStNuoN
         CpAwEq+uNe5HD6WE5dVlGMqsM2exDcEgsrHF6mxFusok3NFt+emtb/z6RsAqffk+PF4l
         moehez3veCXjdUVyzd1LAjwRXWF1BwHYJ4/6gO0Ck5chBb1ey4Zl8z661XPSZna9bjsu
         3GXC/9gYm7hKq2V2jAObn98i9AFSvWv4QWUJDsRLj4Gk0qzP5hLroKo+pV3OQ+iyAFDm
         gesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wIUcUn9NZpZ4AkNdcsel1CBOeLuu/XGaElsnv6eh2k0=;
        b=ex80MNp8ErLIj26a5k1nPQM8+KYqFTLisum8O7CHjMYfrw4eg1G1tLfSPaQSd5hN/8
         0u5tmg8lYISIlFxsQ5D2fAv+GMjLk524DCPIW3PChJgmj8rb0RX8JXVlnOkA6PiKsHl+
         WVltgt8ruaH9mTJvkWUcHNkYubWpFgMFKpe+C6QX9qZ0o1J3nZ0NWPXQc8PUt8fApsV3
         wUy1lSTCsffoSOZaBxIVgyqkQ/CmhmNILkaJOFzz4vp7f4aYRXY4zcY/HkYzGzPcp0jk
         2CnPv8aEZ3uNRIUlwB6joSeF6j3OHTxBLt/1VAF8+I78LZ/Wk6cYKKrurOWMxmY4oYJf
         X/Fw==
X-Gm-Message-State: AA+aEWblyTIOeWhDHLSjITwpp2mXxD/rb9U5PGXOGCwKVJaIz6zGEFSu
        pxdAMOBRN4tFeTLyvCrV2Xo=
X-Google-Smtp-Source: AFSGD/Wkeu9DAc0W3L/E3CARwVCVrK8ODHNnlVX8e1Ps9CNkuZU2PX/dvrjuAsObgNHhPV0fkGKLxA==
X-Received: by 2002:a17:902:7614:: with SMTP id k20mr19383438pll.285.1545199317307;
        Tue, 18 Dec 2018 22:01:57 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a2:eb51:6018:45d4:55a2:e94b])
        by smtp.gmail.com with ESMTPSA id r12sm19801353pgv.83.2018.12.18.22.01.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 22:01:56 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v6 7/8] gpio: pci-idio-16: Utilize for_each_set_clump8 macro
Date:   Wed, 19 Dec 2018 15:02:21 +0900
Message-Id: <20f43bb1c4b9d7b5f0a0cd044258f2eec8c68a2a.1545198260.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-pci-idio-16.c | 73 ++++++++++++---------------------
 1 file changed, 26 insertions(+), 47 deletions(-)

diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
index 6b7349783223..4eb89f8b5f9b 100644
--- a/drivers/gpio/gpio-pci-idio-16.c
+++ b/drivers/gpio/gpio-pci-idio-16.c
@@ -108,45 +108,23 @@ static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-	size_t i;
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
-	unsigned long port_state;
+	unsigned int offset;
+	unsigned long gpio_mask;
 	void __iomem *ports[] = {
 		&idio16gpio->reg->out0_7, &idio16gpio->reg->out8_15,
 		&idio16gpio->reg->in0_7, &idio16gpio->reg->in8_15,
 	};
+	void __iomem *port_addr;
+	unsigned long port_state;
 
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
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		port_addr = ports[offset / 8];
+		port_state = ioread8(port_addr) & gpio_mask;
 
-		/* mask of get bits for current gpio within current word */
-		word_mask = mask[word_index] & (port_mask << word_offset);
-		if (!word_mask) {
-			/* no get bits in this port so skip to next one */
-			continue;
-		}
-
-		/* read bits from current gpio port */
-		port_state = ioread8(ports[i]);
-
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		bitmap_set_value8(bits, &port_state, offset);
 	}
 
 	return 0;
@@ -186,30 +164,31 @@ static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
+	unsigned int offset;
+	unsigned long gpio_mask;
+	void __iomem *ports[] = {
+		&idio16gpio->reg->out0_7, &idio16gpio->reg->out8_15,
+	};
+	size_t index;
+	void __iomem *port_addr;
+	unsigned int bitmask;
 	unsigned long flags;
 	unsigned int out_state;
 
-	raw_spin_lock_irqsave(&idio16gpio->lock, flags);
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		index = offset / 8;
+		port_addr = ports[index];
 
-	/* process output lines 0-7 */
-	if (*mask & 0xFF) {
-		out_state = ioread8(&idio16gpio->reg->out0_7) & ~*mask;
-		out_state |= *mask & *bits;
-		iowrite8(out_state, &idio16gpio->reg->out0_7);
-	}
+		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
+
+		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
 
-	/* shift to next output line word */
-	*mask >>= 8;
+		out_state = ioread8(port_addr) & ~gpio_mask;
+		out_state |= bitmask;
+		iowrite8(out_state, port_addr);
 
-	/* process output lines 8-15 */
-	if (*mask & 0xFF) {
-		*bits >>= 8;
-		out_state = ioread8(&idio16gpio->reg->out8_15) & ~*mask;
-		out_state |= *mask & *bits;
-		iowrite8(out_state, &idio16gpio->reg->out8_15);
+		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
 	}
-
-	raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
 }
 
 static void idio_16_irq_ack(struct irq_data *data)
-- 
2.20.1

