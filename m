Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F5AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DA920870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VH2sbDqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfALBsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 20:48:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45039 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfALBsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 20:48:50 -0500
Received: by mail-pl1-f196.google.com with SMTP id e11so7533065plt.11;
        Fri, 11 Jan 2019 17:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nHEyzaj0Xe6lvGvK4uNO3cxht7LVWKgKLecVOkA5AJQ=;
        b=VH2sbDqESi0AnunOAsfDSuIVoNd42nu1gfA+bSGRS+j4Z9nHZI4QKuaKLCyNITzqRL
         +12MwkhkkW4rE1IDF9J1RjoSCYcx3Cv0EjdQyNmfy+IcO6pviKuxQHH5u3yYBLGiKjpH
         PdQ+Vml/Pa+886Ct6AHygrgqNUnPXq00PVBcUvL07GpkHrGrBp2eI4GfnxRoo8GT275e
         kD6ZPR6hYxY8YxEKuKzr2X7dFDftTncewZq0grrYEj3rIQ4N0DUQGZMF6b9gxo4tdPnq
         5tvxid+IEX1hJSTNR+tD1zXVxAppgbo7/KMpvRSxNLTBWjcthSpsrqlOvM/rv4UO0yN4
         ZexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nHEyzaj0Xe6lvGvK4uNO3cxht7LVWKgKLecVOkA5AJQ=;
        b=gabkbgrAifLLADi83MgdBvf/auUglaiiGchAntx65GXINTilC1FGJp/Kp0iZbxAVJs
         kuk6HtRk4Gq7NLyN1DgT+CpjS/7umu+eVdX6jUq50Ki4vhi9FqdTBs9EZelQVuqFjJMn
         yygg1QxWekBg6r/2cfnSdfhC4nawe58+UG8pztuSl3jgZ81tOp8ge5bMHOcYMuoSKPu3
         AqeD9MIuSPqkUGUFJpnBnYxc44D/CMNGWeaHZWO3hHh5oFG4C3fz+n6t30V/9PAhdUkj
         BIzeBSir+KaRJb91OT1cpcb2cLcRf9fYvuE/p/7CkWTtJqvqSJkC3tnqoqU97F8kpis0
         3HAQ==
X-Gm-Message-State: AJcUukeFAUozQsWHNDZmvX6r7umRGJsmV3M497uyiaWS0tUpIRUkeQ4x
        eNlTVhyPBpjlEoM3UZYrCqw=
X-Google-Smtp-Source: ALg8bN4PCamluMdLU0hkgebW1ttPbfO74CfvEYNuCmS3/QWZ5thQuxE5CG8AVaqjL4CF7JlVWnPDbg==
X-Received: by 2002:a17:902:22f:: with SMTP id 44mr16736941plc.137.1547257729798;
        Fri, 11 Jan 2019 17:48:49 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a3:ffc5:36e2:bccb:ba63:9e84])
        by smtp.gmail.com with ESMTPSA id w5sm104233368pfn.89.2019.01.11.17.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 17:48:49 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v7 5/8] gpio: gpio-mm: Utilize for_each_set_clump8 macro
Date:   Sat, 12 Jan 2019 10:49:22 +0900
Message-Id: <e42a59cafae7f18b7a84a3750b6dff57b6e89675.1547257386.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-gpio-mm.c | 71 +++++++++++--------------------------
 1 file changed, 20 insertions(+), 51 deletions(-)

diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
index 8c150fd68d9d..ad80f874e004 100644
--- a/drivers/gpio/gpio-gpio-mm.c
+++ b/drivers/gpio/gpio-gpio-mm.c
@@ -172,46 +172,25 @@ static int gpiomm_gpio_get(struct gpio_chip *chip, unsigned int offset)
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
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		port_addr = gpiommgpio->base + ports[offset / 8];
+		port_state = inb(port_addr) & gpio_mask;
 
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		bitmap_set_value8(bits, port_state, offset);
 	}
 
 	return 0;
@@ -242,37 +221,27 @@ static void gpiomm_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
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
+		port_addr = gpiommgpio->base + ports[index];
 
-		port = i / gpio_reg_size;
-		out_port = (port > 2) ? port + 1 : port;
-		bitmask = mask[BIT_WORD(i)] & bits[BIT_WORD(i)];
+		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
 
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

