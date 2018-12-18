Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD570C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82BF217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iw4C84++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeLRKNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:13:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39837 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeLRKNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:13:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id r136so857614pfc.6;
        Tue, 18 Dec 2018 02:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wIUcUn9NZpZ4AkNdcsel1CBOeLuu/XGaElsnv6eh2k0=;
        b=Iw4C84++IJ29lEg2R6wMOCjifBtu0xVJ7C77kHUhN4KOimHZpRzxsstUuYZ+CVgLFJ
         7I+NjzH9aVaVB3wrhfgkHF8zshuCdlhJ9NhHaF3BT8wd9FJv65I3DLjKWJTIiHCsoQOU
         Acc9f+FMW8jCi2b4rYocQ0r85vUgrnqz2yRYqDtCS/8+1z2E5a15dkTf754y+V6QKtvb
         SVlxVzdrv6/Cz8aPwTOzn+2IBnOq6Zy0KBWmXLGwJ+8OZ/z6WlMkAUoMG/SLVTC9Jy9d
         Gm/op3bX7J/tFabgjVwDB2LiguInA4Abkf5hSXzM1IO+w/R4JRothYr3tXcy1rOt7SNS
         qJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wIUcUn9NZpZ4AkNdcsel1CBOeLuu/XGaElsnv6eh2k0=;
        b=B7a9OgorBi5b260QF6MAFkQUNPj77+ufZGRuw3WwYCB8tAaHW8s7Jc8X1EtE7/P/WZ
         QlLeV2WCGVN1/u9RLeH1P+45IWx0JkNlrm4T2TIWxEiE5p8nAwfwKacgvyhFcFhIYFAS
         5U70GbVYOS0KMKwzun55F8dJSftvmOyBJBYt201CqPZamYJ4mOMmc9vlyhcOktUVfMoM
         O0Do6UanDRgp3O+4BnKh0pt5Hi73Fr8Fl2wg7822l2ggmHHigVowSRdDoNP/pN/jxEjF
         DOB3hljIFWVhlqodulufJvErUBJO62qsAZGWqBDa7LTx/aleLDz2eI+IR6ZKS0tYuP9R
         KWBQ==
X-Gm-Message-State: AA+aEWYbydgjIf9tTBgE5M2eq7nJ8+2NNk7/En/U6kQzwSiE3UEGNYL+
        pFwTwg0ohJOuzdmyNN6dhe0=
X-Google-Smtp-Source: AFSGD/VYuNC5NxAqnKIK16veOZo0kCxjh3QRLwZYEOmJw6xp0pMl6LPvHxciyxj8riMW1Bcay2KmbA==
X-Received: by 2002:a62:3811:: with SMTP id f17mr16413592pfa.206.1545128003659;
        Tue, 18 Dec 2018 02:13:23 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a5:b5e9:3c79:e26e:bf45:b953])
        by smtp.gmail.com with ESMTPSA id y71sm31996501pfi.123.2018.12.18.02.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 02:13:23 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v5 7/8] gpio: pci-idio-16: Utilize for_each_set_clump8 macro
Date:   Tue, 18 Dec 2018 19:13:51 +0900
Message-Id: <fc6a5fdb4c5368f081b2efc012a384e9acfc010d.1545126272.git.vilhelm.gray@gmail.com>
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

