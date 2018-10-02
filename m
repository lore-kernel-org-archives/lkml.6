Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4925EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F472083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKNe49Oc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F472083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeJBH4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:56:32 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42950 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbeJBH4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:56:32 -0400
Received: by mail-io1-f66.google.com with SMTP id n18-v6so311001ioa.9;
        Mon, 01 Oct 2018 18:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BAIY58cG2lAF0QLUr5y2z0xC0M6YOWGQFl14m1ZUlO0=;
        b=aKNe49Ocl/ef2DiyqjmVyMOkVvqSIgjFXJWSkvCbllzDujEqGCsbx2AbH+H31mi2PZ
         U4p69kN/0Xa2qHmMlIt9iRjDqCO7EQ8jiDxTecIpRWc3eAo1SMVeT8mNu70nWfDzMF71
         o+e/gKE5YEGmu2rCXUOig1+5Volgi8VWIuO97omk6KMahcmKjko4g14fIW2cYmMqEynS
         Nc3oSTt+9Mhn/Kd8vtaI6ylGMBngCF3QQykRsMelNLU2LN9+nXkT0wYR+PiIRoJlYgAP
         IeN84HJs4YoKeCxXSiJY56NDUuiY3H29xQ2CACghJNpZ4dYxKAPy+CfzD3YLlVAS7qcR
         zKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BAIY58cG2lAF0QLUr5y2z0xC0M6YOWGQFl14m1ZUlO0=;
        b=NtHR2akqP0cGga/9Z4TnXeoW/Q6FJj27gOKML0onh233zVTqPniVQ3Dyoo55IjKs7X
         hfd5zLRR+iSCkZ2UcJdjVeLqLb8UZm+2vPbaJza/hp7doVRdPxr599PyINpRlakEDnFB
         vaJyyihZbFFDL/4mEW3sJDsMip9R3QVfB1CD86cF/1ZY164YVctrA2i3pXBrCPvci/1P
         y44r0JflPKImXn/1dESA+YA6sis+hlwtArP6OCx8z/FRb60ecZOMB9Y4RCqnLNs2qa5Y
         ucFTaw96kAa/mKLItQifGAkMq+DwWyk1+2p3rUvvyhHIWyv53WgQ5zZbpUjhM4NUjj5B
         R/Mg==
X-Gm-Message-State: ABuFfohTWKtOdiCmYV4ojDS2WwQAK++w9N6Guc5gzjbXQjx6xRzAhgt9
        xwL3RkeVDTLQFRlJydtBo4hmmtyu
X-Google-Smtp-Source: ACcGV613TMNz6lFE8MlcAz4SAMGriVpBwOY/t0+Es2sIwYIxqDwkMM/HUOzTNEPVzIYQ08Bavp30XA==
X-Received: by 2002:a62:34c4:: with SMTP id b187-v6mr13942578pfa.15.1538442957406;
        Mon, 01 Oct 2018 18:15:57 -0700 (PDT)
Received: from localhost.localdomain (122-223-50-245.fukuoka.fdn.vectant.ne.jp. [122.223.50.245])
        by smtp.gmail.com with ESMTPSA id u21-v6sm14805702pfa.176.2018.10.01.18.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 18:15:57 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RESEND PATCH v4 7/8] gpio: pci-idio-16: Utilize for_each_set_clump macro
Date:   Tue,  2 Oct 2018 10:16:00 +0900
Message-Id: <4ec0716fc3bcad6d0d90598ebd08b753cc354738.1538441919.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-pci-idio-16.c | 67 +++++++++++----------------------
 1 file changed, 21 insertions(+), 46 deletions(-)

diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
index 25d16b2af1c3..6d748c6e59cb 100644
--- a/drivers/gpio/gpio-pci-idio-16.c
+++ b/drivers/gpio/gpio-pci-idio-16.c
@@ -109,44 +109,20 @@ static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
 	size_t i;
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
-	unsigned long port_state;
+	size_t word;
+	unsigned int offset;
 	void __iomem *ports[] = {
 		&idio16gpio->reg->out0_7, &idio16gpio->reg->out8_15,
 		&idio16gpio->reg->in0_7, &idio16gpio->reg->in8_15,
 	};
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
 		port_state = ioread8(ports[i]);
-
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= port_state << word_offset;
+		bits[word] |= port_state << offset;
 	}
 
 	return 0;
@@ -186,30 +162,29 @@ static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
+	size_t i;
+	size_t word;
+	unsigned int offset;
+	void __iomem *ports[] = {
+		&idio16gpio->reg->out0_7, &idio16gpio->reg->out8_15,
+	};
+	unsigned int iomask;
+	unsigned int bitmask;
 	unsigned long flags;
 	unsigned int out_state;
 
-	raw_spin_lock_irqsave(&idio16gpio->lock, flags);
+	for_each_set_clump(i, word, offset, mask, ARRAY_SIZE(ports), 8) {
+		iomask = mask[word] >> offset;
+		bitmask = iomask & (bits[word] >> offset);
 
-	/* process output lines 0-7 */
-	if (*mask & 0xFF) {
-		out_state = ioread8(&idio16gpio->reg->out0_7) & ~*mask;
-		out_state |= *mask & *bits;
-		iowrite8(out_state, &idio16gpio->reg->out0_7);
-	}
+		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
 
-	/* shift to next output line word */
-	*mask >>= 8;
+		out_state = ioread8(ports[i]) & ~iomask;
+		out_state |= bitmask;
+		iowrite8(out_state, ports[i]);
 
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
2.19.0

