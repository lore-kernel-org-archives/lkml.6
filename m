Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2893015-1526401390-2-7016604498915106085
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526401390; b=hLta5k2QtKoDwPZMDszyvCO7Rz4Q42qilSALY2rH25M3BoN+kW
    QyytBIvgFzB7SRNWs+YmaLhfaNCZL47HShDK3zkERwAfGOcsRQK1yYk+oQyCvAAj
    Tidhc8TBuUy6//yHi5crUTE/bB/S9TYPiy11L+8vbtCnbjeT9uSG252rzbCyWWrZ
    tB8C8C+UrnDx3xmUxU+Up8rS6/eT8N/IK5qX+4H2H2KERZ5tDDPu9Rq6OARy0nuY
    Yu1xh8PZ5UbbtRi9use8kf/w5MfiOUnQqExWGZ7lrhpUbww/qVQntfB7GgP8mVKR
    x/GZ29vhkeUVV0qQGftrBLP13imiC9V6lD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526401390; bh=
    2U7Ozw2SgAQBqAZnsfCoNU2PQB0sCh7oHKc5SOqZD3A=; b=fZ+KPK4TDAAc+oWQ
    yCR93qlcjQo1mz21P1pErF+z9AbRQrySjtEESK9H/8ym+V8iBEvSm+dHTSe8LuRm
    uzkPy38ttLUHpqwnZLBbWOAM1gN3vKx6ITvZKuKx326wNwUASenTdRwy7NdNjJYf
    GBw0wV+MGZc9FjIeLLCiiHEJho6jhKGfA4VeEAtKF4hhfI39hvnrwsd5oH28pVuT
    KL8i832WzvwymEDBoJCy7nC3u1Pj8eO9Ojfy0wkw2lFFX9ZRTLlZfBVOcAU6O+F3
    OJjq9N7ph9589rb5XkavNZVyj8ZjnZlS4X2QAzGQ29heSjxEDiENG0IZe0AvGuOn
    H8+JOw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=NQMGzK9d x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=rSz/B5eo;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=NQMGzK9d x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=rSz/B5eo;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEmCF/+lj6rvrlJCqJFHSryDkRi9llRN2ApfhKhRNnbOM+g8vMV6pR9dgIKOuck1Wsy1+2Pxk+3V+iywiN8R7eo7foVnQLAehQzgunVXd/uVv6l0glX/
    bvLMTMglxOlkoUEKw/6a+vr52XhcYaxhJDxiFJyVncejoA+26ZT8JzwUSpFRjRfWajXaIOBxwBms/jfL0YKXmxd1J7zo466bXALCwUt5mkYM/BeTQkKpH3Jf
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=i6uMeK6BI1QA:10
    a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=fciruN5rOnnPl2tpXIkA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754135AbeEOQXH (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 12:23:07 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35029 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752750AbeEOQXF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 May 2018 12:23:05 -0400
X-Google-Smtp-Source: AB8JxZqTTvPBgCQjOWGDQ5DjEVUKcQJ1EG2Uu49bemPgoOE35R5U34s/t2sB5v5ChXfqMiPdg+bq8A==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 4/8] gpio: 104-idi-48: Utilize for_each_set_clump macro
Date: Tue, 15 May 2018 12:22:59 -0400
Message-Id: <2dd756692d0fdd20be629ea341a0e563c079f374.1526400945.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1526400945.git.vilhelm.gray@gmail.com>
References: <cover.1526400945.git.vilhelm.gray@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace verbose implementation in get_multiple/set_multiple callbacks
with for_each_set_clump macro to simplify code and improve clarity.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-104-idi-48.c | 32 ++++----------------------------
 1 file changed, 4 insertions(+), 28 deletions(-)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index 2c9738adb3a6..f8de5560174f 100644
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
+	for_each_set_clump(i, word, offset, mask, ARRAY_SIZE(ports), 8) {
 		port_state = inb(idi48gpio->base + ports[i]);
-
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= port_state << word_offset;
+		bits[word] |= port_state << offset;
 	}
 
 	return 0;
-- 
2.17.0
