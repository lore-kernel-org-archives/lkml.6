Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75583C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B6720660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="twEF5vVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfANGUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 01:20:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34204 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfANGUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 01:20:09 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so9866344pfg.1;
        Sun, 13 Jan 2019 22:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7s7wYeX/GD7rWEVAPX5wPgr67IG4VRsYD+ssbUVyFFk=;
        b=twEF5vVaZkG8Sp8D0/br++Ki6dABNQ+C6olAR/vu00RUIjUQVsPoGZskmGl6QMxF2w
         HpZo6c3cKrDzBj9j4duhO1aDtjLm0jluuok9jUzvMhJCgU5TmgiiIsLkaH93YnJBXvDJ
         ZBGZXsKe3xZSk8tWzkeJSxMkzIFqQPlM+YGXEEhIOH+Wo4SQ25ZjDRO80qIPKJByyq+o
         HFxSSwtE5oxjvtaZMpwrXOQwKyEiK1YZiSNYzB8tboPYJgFlq8codMVSQ33ptEYoRqG3
         5Ypf7ZSxbZTaDKy8UV7kvJ4u/IVAeUTFgTIb5RBPn78emBKQVDlTlj0KhSCaanPp7xSi
         W/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7s7wYeX/GD7rWEVAPX5wPgr67IG4VRsYD+ssbUVyFFk=;
        b=ALIRQGvhL1rwsjfhB4HQ4sAvyE5AGPVyxDYMLcSlUWPXoRDa7gMm61xglmTUErCXnJ
         gwhhvde2118PeIu11kJHXvzwz/FcWKdLDIpM3HP/XKWCzyv8W/eKxHkD6E9Zyo2Fj7fb
         m890fk1gEyytKjuGjEcpApZTVbsVk3umjinlVX+bMBHWj1O4FJCtezP/SZV1FzjL1FF1
         dyPe9mRPnq0sb54nRTPgD+ylsckTOqYd0k+XTu2VxZG7GyvzTYJcWnpfFDektpncfF8C
         HmzH60P9xOKDNcc7lF8qWh1F+nMZQzWd+vKAZJ+z6Ct8aH9608xKHWWKdiJH68fBXRD6
         BGUw==
X-Gm-Message-State: AJcUukcrRpCHC4+5EdugaFV8TJxO5OXIGZe8qJSgTcmGozUjLMlkEuz/
        sEeZtlWhAuPXv4IWadYeQjw=
X-Google-Smtp-Source: ALg8bN67cP97HIf0oKL1TNRgmFifWLDG9aEvScZk81L7B04KKLb9m32WSferSNzrCUfZO4q4NZLl7w==
X-Received: by 2002:a63:7418:: with SMTP id p24mr11708492pgc.196.1547446808865;
        Sun, 13 Jan 2019 22:20:08 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a3:70f2:4411:7de2:8afe:823b])
        by smtp.gmail.com with ESMTPSA id i184sm117311947pfc.41.2019.01.13.22.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 22:20:08 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v8 4/8] gpio: 104-idi-48: Utilize for_each_set_clump8 macro
Date:   Mon, 14 Jan 2019 15:20:44 +0900
Message-Id: <fa5f30ee2cc69a3432405c5ffa0c5e8a10a46100.1547445576.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1547445576.git.vilhelm.gray@gmail.com>
References: <cover.1547445576.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-104-idi-48.c | 37 ++++++++--------------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index 88dc6f2449f6..59c571aecf9a 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -93,42 +93,21 @@ static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
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
+	const unsigned int ngpio = ARRAY_SIZE(ports) * 8;
+	unsigned int port_addr;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports); i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
+	for_each_set_clump8(offset, gpio_mask, mask, ngpio) {
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
+		bitmap_set_value8(bits, ngpio, port_state, offset);
 	}
 
 	return 0;
-- 
2.20.1

