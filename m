Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2825552-1525786080-2-16163693134644190801
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525786080; b=gTGBwm5j0wBWLblDzVLzVmg+dK3YQew7OM+baQ+KU/mi8ANc2s
    8LUHEcsRSYX5EY5RNO/j6XRA9bgsSDTKc1lljSaZa2Fb+L/NcpRdadI4waj1ucdm
    hN7yycutgvCmZ1XLep1KIBYQ6zk/1MCjoxaMzOjYGeVW3jNTvi53JeMVcWw84lMz
    5tct6oUOuW2uX6NuK2jFgKbfdw3YOpSibHKtLR125Nxv9CJ9jXDTATVsuZIiCira
    nVa6l74/ZdxymgXvyO++DyR9cfhnkJbdhrJoinfumNfD38XFYOPTYMJaI5vXdKct
    ttqqPFdGQk8XZc7ssQSyzs1NumCVHK0rfsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525786080; bh=
    IBIBNhSQ0ajv4mOvaURSmQs0HFlBxEAuRaVG0JJUT0Q=; b=f56/8Br8WOXAcqii
    f3rJOIV6l32+EqeHzf4YmRqkYNFsItJ4z5SZqRJoeI5D31EOjZBGxHKxbj6840tr
    qzw65Zo/c9OGo4SGmqYiM5pbvwAwhfkcKU6ISIgnFhzZLy4fRZRxG+ljw1F/cAhe
    4HVibm56a3UFWU25iUUfmSL1a8BTuFUI9iLojtWHFnadkqn8/LeFSyJJfGC6qDju
    fAk4WI5VV9bOPeaGZBuvF4muVOOLnAR90kdbs5BC062oxg3iIIdrrQf9/fzXZtIk
    3gx5hi/34nt07c9DOh4x/yjyEh2nqw4lDvcp/iD+ZRh44wUAbepCbHIhjvgB4cJI
    h6CJCQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=nDY9zCXn x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=IlrnrR/0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=nDY9zCXn x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=IlrnrR/0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKK+B9w5GVYdIhFkLMTRAPUG+FQ08np+750fJmYINwj+tlrllOoX21z999qL0g1wWJWvhJRnoFknYbpWH6IlFNGdlkCBNf6YcY07cY6U3iEdKprAZ3EV
    X9hyJwb4sbfRo7ulKao3mYlfwdNUEC397ssrPqo1f8/Ip669Dc9FzghhNfrRi1+9H3Y8xePwuZ18XFtAslcacX2t8oRDxwzJIzzD6HSRXlUaZUi9mIruUULK
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=i6uMeK6BI1QA:10
    a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=jFODSNWQBTS3p6zbHPMA:9
    a=iBw-Z4FlSSqHJMQw:21 a=IV2EyU27X5A6Pmsf:21
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932101AbeEHN15 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 8 May 2018 09:27:57 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:43398 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754099AbeEHN1z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 May 2018 09:27:55 -0400
X-Google-Smtp-Source: AB8JxZrYAtack1lVHujS3xD2tEtX9XeREMYRTD/uWcs6/ZFDcPQpFGkmBwkRq4x4Op6wN314wjGtoQ==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 5/7] gpio: ws16c48: Utilize for_each_set_port_word macro
Date: Tue,  8 May 2018 09:27:48 -0400
Message-Id: <7be4cbc599a8437e031a6f0286b765620d3713e7.1525785532.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525785532.git.vilhelm.gray@gmail.com>
References: <cover.1525785532.git.vilhelm.gray@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace boilerplate code in get_multiple/set_multiple callbacks with
for_each_set_port_word macro to simplify code and improve clarity.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-ws16c48.c | 66 +++++++++----------------------------
 1 file changed, 16 insertions(+), 50 deletions(-)

diff --git a/drivers/gpio/gpio-ws16c48.c b/drivers/gpio/gpio-ws16c48.c
index c7028eb0b8e1..ab8b36f3595c 100644
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
+	for_each_set_port_word(port, word, offset, mask, num_ports, port_size) {
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
+	for_each_set_port_word(port, word, offset, mask, num_ports, port_size) {
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
2.17.0
