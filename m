Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1186102-1525707395-2-18097689519327627559
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525707395; b=C/oOpowc1/mSgrsIACDUG0+aMIz54a34x6Th/nUuratGVhNzUK
    QMS5hzX6DGY6lAXFSJov49KMmwcHGpXl5X0+H5k4FOFNu8NQPFMyTKc/CyEnsEe0
    7+GVslkaj6zlJbv1MI1/jizL9hrhKno0iu1TwqlWL9Bgragt2vwNq5g4foD62smg
    4vpMwA4I0gKz+rcSTH+jlxOQ+KZ+0AIbLTCckSgAZisrdqbQxo6Ra9JnvmC85GQ9
    UVwU9rhFNBUX9uJekV54kY8SHncOrEO5fZLPYc1HeqWty30fzi0ybWf3ykozPWxI
    Gd9In0um1IGiNTKMtohVJMd3zaq1aAOSPZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525707395; bh=
    IBIBNhSQ0ajv4mOvaURSmQs0HFlBxEAuRaVG0JJUT0Q=; b=jQCgXBo+h4+akgVI
    77di3qUXsbUDPwQen088b6OLOaWgda4mqQYtwWcQwJeUKPIMwQQG+z86lD3cn3xD
    X0qObrX2uNzix5ElNwh4AYF+7rawqHezZvg5WtM0ouSgYFigkjhYiRQbliR5xjUc
    rUrt4z7sTjg4tBqUlqIfSb6ot4mLUzASOjaUBaxTv8DPfa/Lcf+MN27dQg66znan
    vsx2Ip8l1X6o6IiK8wJqXwgLZur0MrBLndkgvGglX9RoLQBNJ/w2WjkfltIzjzRN
    eugV1HPYydYzixDcFXqO/WGCkQ9VZ5xHW93qW9InqAWnd/n4H+W68T5A5KW/zGTV
    0jnnHQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=rjh/gO/w x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=TGE6fibs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=rjh/gO/w x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=TGE6fibs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFhOzRYERpSjR5M8ZsN81MfETYjGp8Yoond+nxhMS9QjX6Xb5TSe9rZDcKsU0AeH8huMWKe7vouBJzBIph4pyYOaWjd9PZ3qJ0fMAT24KOWgi5drf9SI
    NREemybJh6kNNnSRFrbdyvkixOr0nCHXCIQYuiEiym2m2BUPFCOdrqTZWmwrrLnDJ+DEq0GfcwFi1X6ZFlpVxUUC/fYph9Qup7IrNpo61Dv677846HfzqrCB
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=i6uMeK6BI1QA:10
    a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=jFODSNWQBTS3p6zbHPMA:9
    a=iBw-Z4FlSSqHJMQw:21 a=IV2EyU27X5A6Pmsf:21
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeEGPgc (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 11:36:32 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:45056 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbeEGPga (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 May 2018 11:36:30 -0400
X-Google-Smtp-Source: AB8JxZrHVlgXoCbBr23vwYz6SSRli7I92vSys+nrGs2NP1IXmtKgq90KBUixD8wJmcWJSw2t2YrbhQ==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 5/7] gpio: ws16c48: Utilize for_each_set_port_word macro
Date: Mon,  7 May 2018 11:36:22 -0400
Message-Id: <93b3cfe4fd47cc9b16f69816fafa17e9779bbe9d.1525704095.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525704095.git.vilhelm.gray@gmail.com>
References: <cover.1525704095.git.vilhelm.gray@gmail.com>
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
