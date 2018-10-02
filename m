Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC625C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AFC2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/z/KIKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AFC2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeJBH4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:56:16 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54673 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbeJBH4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:56:16 -0400
Received: by mail-it1-f194.google.com with SMTP id l191-v6so1045709ita.4;
        Mon, 01 Oct 2018 18:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w26BhDHPFDJv0PJt1w2A7SW4osNkWAfFdxRkrvjKYkw=;
        b=l/z/KIKfXglmdtqYUhD408SCVqff+dLTkQSfUcHXJvCwQ3fQKlnX85fQjUmqKAwCDd
         GlVByn70sNeKC0t/HZ/qo+gB6JigPIjyW/aeUEZnM31e3EBRsMEt6sffCTntI6fmYDgs
         TkTkffgE2RJcUEekaRg/rdXtHrXe4FPVmaYmCTJ4dX6GoEv4mwSE+rbwBJZjksEBucLR
         aprBBUfGf7vD1zC8tT12hFlpiR9aEAdF7Ki2CSrj2QZfPD5LwgtmYg1C7QgvFCWCDUS0
         LAkaz9jlg95fxkZryqIfi3tyL1DI5U90oNlJJXho+Uwi0DQVX1fRCckYVoF+WDo+FWxe
         CtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w26BhDHPFDJv0PJt1w2A7SW4osNkWAfFdxRkrvjKYkw=;
        b=g4ggl+KnSJUYh7PXpIULdKqAUqmNAwN43glTOXODIhPm+AsYJEAMnZjDynrFTSx4iL
         GWe7qsXPF6VepGkXjJOeccIofR9hL57FEazz79tipZKR25000G6Ph4DC6eZVHCh3JvVp
         Cqh1Psm+SoWXpf/PTZpyubkfBclN2Iq+WPODq8RkB43ROTDHbGxwUhaZimE8kSZA25Et
         MPQ2h9b9TpO9SdUk2DYzPLDJqSHUcoWIDq/sC/zblQvKUumzUSqOcjtwNV/skp2NHeWR
         +4Sm6b3Q1zQ8kUavV4+IHKnmAPWOmrawHDK20/FZ972WxDexrhOZULcZLEG1mkecKley
         Tv8w==
X-Gm-Message-State: ABuFfojwJRMLGEqJ7tBqJ0ldClU/6bWNLES0TV4sbk2FZh7sxUR+0fU4
        QT2HBaga9ZL03LPiHPH9G/o=
X-Google-Smtp-Source: ACcGV60HxmR9GWaBTL3f/NmF45aYGlt0XI+6pbA1/dFMegtR8WmweFiIuxERBVtOvHynClW10igXJg==
X-Received: by 2002:a63:c608:: with SMTP id w8-v6mr12470119pgg.16.1538442940870;
        Mon, 01 Oct 2018 18:15:40 -0700 (PDT)
Received: from localhost.localdomain (122-223-50-245.fukuoka.fdn.vectant.ne.jp. [122.223.50.245])
        by smtp.gmail.com with ESMTPSA id x20-v6sm26104075pfe.131.2018.10.01.18.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 18:15:40 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RESEND PATCH v4 6/8] gpio: ws16c48: Utilize for_each_set_clump macro
Date:   Tue,  2 Oct 2018 10:15:44 +0900
Message-Id: <1e3f316850b1138e0969c32f9db0236b8a7a8197.1538441919.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-ws16c48.c | 66 +++++++++----------------------------
 1 file changed, 16 insertions(+), 50 deletions(-)

diff --git a/drivers/gpio/gpio-ws16c48.c b/drivers/gpio/gpio-ws16c48.c
index c7028eb0b8e1..625336376b5d 100644
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
+	size_t port;
+	size_t word;
+	unsigned int offset;
+	const unsigned int port_size = 8;
+	const size_t num_ports = chip->ngpio / port_size;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < num_ports; i++) {
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
-		port_state = inb(ws16c48gpio->base + i);
-
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= port_state << word_offset;
+	for_each_set_clump(port, word, offset, mask, num_ports, port_size) {
+		port_state = inb(ws16c48gpio->base + port);
+		bits[word] |= port_state << offset;
 	}
 
 	return 0;
@@ -203,26 +180,19 @@ static void ws16c48_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
-	unsigned int i;
-	const unsigned int gpio_reg_size = 8;
-	unsigned int port;
+	size_t port;
+	size_t word;
+	unsigned int offset;
+	const unsigned int port_size = 8;
+	const size_t num_ports = chip->ngpio / port_size;
 	unsigned int iomask;
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
-
+	for_each_set_clump(port, word, offset, mask, num_ports, port_size) {
 		/* mask out GPIO configured for input */
-		iomask = mask[BIT_WORD(i)] & ~ws16c48gpio->io_state[port];
-		bitmask = iomask & bits[BIT_WORD(i)];
+		iomask = (mask[word] >> offset) & ~ws16c48gpio->io_state[port];
+		bitmask = iomask & (bits[word] >> offset);
 
 		raw_spin_lock_irqsave(&ws16c48gpio->lock, flags);
 
@@ -232,10 +202,6 @@ static void ws16c48_gpio_set_multiple(struct gpio_chip *chip,
 		outb(ws16c48gpio->out_state[port], ws16c48gpio->base + port);
 
 		raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
-
-		/* prepare for next gpio register set */
-		mask[BIT_WORD(i)] >>= gpio_reg_size;
-		bits[BIT_WORD(i)] >>= gpio_reg_size;
 	}
 }
 
-- 
2.19.0

