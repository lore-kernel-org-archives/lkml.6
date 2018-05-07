Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1216624-1525707369-2-14432355337854677851
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525707368; b=eMhZktwotP3P3NHZUTLhYkh3WAfFvtWGK+CdsU44twacWvAkUX
    wtTg07XKRqB/B7zlFcgJPqPiVXHtUwnWUq0DITwTMQfOIEo+aMia8pKe4aRU30em
    DoxfbY+O2aq5jaDzZJD+E5ISvK110XawGLe7AIgrfYxe+beQF+XFIzjDurV9gO5m
    mEsXEM7HYGsHzADV3xuKYwQPctAEjJcowIqxTi6wqoiy2AKVZui1u++JuCXwPpfJ
    mfisEHsWHxs9axVgrNfdUKe97iQ5kWwZhJB+vMb1JgE33J5KuaeOuch5nmji/9y6
    VJAQN1Diiflz1wOP4m56CqVpRaseYKVYZu7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525707368; bh=
    slf1J3iHpjNeA4Hre3fVutRjHc1MIIIvq7nrD4k34rM=; b=gYwCP5xQYdeGxnPn
    viKUOfDYGoqlk0gFHxeqOSVP4+4br2Bd+K3hoANuwaRKHbOdr7yjizpzerK6sIkK
    c6I30AXW2iTmsdqPAtKhXQSO5acMhFClsemSD2K6KF8E5IE7ZmjyQxg9nfZVzYaj
    ZhE8QcRZLtFnJxqZvFRKAScBV5lQ/7xKLeYE9W2rsNxZtSRd4IOo3oFnggjXVA9b
    ahSFmDVtG4eDEZf2fMyuleUzmT62VQzD0PKkAt/J5v08uIq0LJ0qJq7O8zcE3Egb
    qAnH6kggl3r1ONNULVRbOyqkZwaYoGmdS9R4g2UXgwsSY4XvLwIh4+xexG9w/Ydj
    tMVEVA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=jzbjUguM x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=KLwnQUYf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=jzbjUguM x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=KLwnQUYf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAeD0DDgJzVLosmat08xk/JvYXqQ6TznjvQ4hcb0inz41RpOqlW+gekzFN0JavRDvlfXpgHnOs+B4dCRiBSRxIW7RAR2rhbGBB9/4xXFDzTYilWynMIv
    MEx90JvDuuoM3JRwGtNjOm2tMFCAlb0Ky8i6wTgZX1M1d7yJMGA6G3/laSNgXpGAkniCuOY/UCf6TL2LaHaePWLRtuvjEIqK36WnshILl2EaQTqIdGgnJOIU
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=i6uMeK6BI1QA:10
    a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=xm1hxhbfDqyH1FrBhKYA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752444AbeEGPgH (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 11:36:07 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:37649 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbeEGPgG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 May 2018 11:36:06 -0400
X-Google-Smtp-Source: AB8JxZqzEtUy/mWVkc1Vk7EXFkryU8lQWiquLZgh/v46XjIR43YogekF7pEhFqXOuz5Hn2gH/5AB6Q==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 3/7] gpio: 104-idi-48: Utilize for_each_set_port_word macro
Date: Mon,  7 May 2018 11:35:59 -0400
Message-Id: <b2d8341e7776ae0b756c0f3470aed0bec65ea77d.1525704095.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525704095.git.vilhelm.gray@gmail.com>
References: <cover.1525704095.git.vilhelm.gray@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace boilerplate code in the get_multiple callback with the
for_each_set_port_word macro in order to simplify and improve clarity.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-104-idi-48.c | 32 ++++----------------------------
 1 file changed, 4 insertions(+), 28 deletions(-)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index 2c9738adb3a6..414dc8de0bd8 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -94,41 +94,17 @@ static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 {
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
 	size_t i;
+	size_t word;
+	unsigned int offset;
 	static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
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
 		port_state = inb(idi48gpio->base + ports[i]);
-
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= port_state << word_offset;
+		bits[word] |= port_state << offset;
 	}
 
 	return 0;
-- 
2.17.0
