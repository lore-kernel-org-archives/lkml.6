Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1936C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F5020870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRnxm6Xl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfALBs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 20:48:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41295 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfALBs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 20:48:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so7755488pfi.8;
        Fri, 11 Jan 2019 17:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ee1QyAa1N2Ih1UTUQsFUgosd6lppQCkmPJ1LX1IRxh8=;
        b=sRnxm6XlguEcP7Y7xA94mg9LjdTv3VwEzOJWSan8l6mm37M8hHn9kH6fStS7SwHPq+
         U+Rn/j0XRInBIGwBGP8SIBkyurk3yzzexWIJWq8I5+MXjY2yD9eo2PU0FuSAkIVVCV0E
         tx7Scyc7nUTsRoqlPjh/XzAF4My9omT5Qt47l4MGVPNWtvlkCB/JXEsGg3BlCOJB1uSN
         Tt0nZLZnju/m3nBzWA8rwhmUlsu9mdYqh8s0F6u5KDwvvfYLBcUa5FlAW0Ja2L1zEZSA
         K1FNJSJYzarya6Sde2i1H8ZmqiS1CXy+ULm60vqv53Hzx4fNc33NdVBpNmJpszSQkMCD
         J5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ee1QyAa1N2Ih1UTUQsFUgosd6lppQCkmPJ1LX1IRxh8=;
        b=ljJDGB7MfIbDjhhMefmsXRc2mJtTJU+zO0ZNELfXAZeWD9a7qdpn9ARyv5hO+4hrtK
         oL7TfU9RmS/234ZJRyhmbLauvFxJLwNMSZwBf+Lcj4Pw9UZalx8JoNyhy3ZJdSwKaSdc
         xFXinvOw+zkGVQGj5HqeMEIRR6ZfSC4jec3k81AF7uzVxBjSNUcqsLQFqZwapr9kJiWa
         98LAEAKDfz7cCJ7uI0Ck5nx4DzpmRld9jvO0tQvMCyFASlnQiKmZ0Qpxfhm1x+0eht1D
         ONKnH8hRj0CdH4TI7v75axvqUpmLqQwWD3fesgZzDh+p8CtTF8vzeXJOe+8y/fGPjFje
         klMQ==
X-Gm-Message-State: AJcUukeP4EpAWkkYuHij/sqFKSqdS7cmp+tKDdmeg5gxkWitHRlfV80J
        9yoiiyILADw7pfZYebPOfcI=
X-Google-Smtp-Source: ALg8bN5z0ml+/Qns/rYRpD4KNOMjYe+qqyIeCzAYOc79+rve4wjhs1p2W21VtC8wU0JnQt5mASMwbw==
X-Received: by 2002:a63:6984:: with SMTP id e126mr15624649pgc.143.1547257705852;
        Fri, 11 Jan 2019 17:48:25 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a3:ffc5:36e2:bccb:ba63:9e84])
        by smtp.gmail.com with ESMTPSA id j9sm102086832pfi.86.2019.01.11.17.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 17:48:25 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v7 4/8] gpio: 104-idi-48: Utilize for_each_set_clump8 macro
Date:   Sat, 12 Jan 2019 10:49:00 +0900
Message-Id: <cc6a9aabc25caf246e2858c119b70f07e23355ac.1547257386.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-104-idi-48.c | 36 +++++++---------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index 88dc6f2449f6..d58382958bd5 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -93,42 +93,20 @@ static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	size_t i;
+	unsigned int offset;
+	unsigned long gpio_mask;
 	static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
+	unsigned int port_addr;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports); i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		port_addr = idi48gpio->base + ports[offset / 8];
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
-		port_state = inb(idi48gpio->base + ports[i]);
-
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		bitmap_set_value8(bits, port_state, offset);
 	}
 
 	return 0;
-- 
2.20.1

