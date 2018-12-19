Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A07CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DEA217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMztUl/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeLSGBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 01:01:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35931 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbeLSGBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 01:01:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so9332616pfc.3;
        Tue, 18 Dec 2018 22:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eB7spxvnRVzN64veVyAd+oRPwk/YF9AvoB3zSfrDoHQ=;
        b=EMztUl/CYTQJiwZMzKATY8ZZgFmNoEEOhNlEGGP06aROo5hQ0f7GoIMQfTzQSdM6M5
         fkF4o/oqL/9aX86vWsMUbQsaxdBfzwlqvNajRafjQTIg3ogUlTdNEnlA/VxKN+fYSoHp
         Cq4hhxgjyG9UZdLRtPFTawdcNexYV1G/lRkB29/mENrc5ZzE/FYbJ0eqNhFC8WfYa67a
         HRx6xfSjZbvJJIiPXMAWi+fonjcsdoiOfhcyOtx0cCTulG3YcDPBOdoWxITWAdTIPxh/
         FzBjVpOXT5BCp4qTIR0oRNA1/ovzCE5G9sPSTd4zWfnyRSi3t4/ufKKiVyXpePvhRzeT
         Xc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eB7spxvnRVzN64veVyAd+oRPwk/YF9AvoB3zSfrDoHQ=;
        b=BssbxclL1ajJKUKeBjRMIzBJNuoOenABoNv9oww0wnq5Mh/bWbMtrvsJPOV8WcyOba
         BU02UNUo5CqFqrbkrjaVI5zIbdE3dxZFV88R7foI3RVKcms+IxLkHlNYKUNOpNxG627R
         slHxS+IsOg9P4lQKsm50xT3NTABtq8aPTMYc9aNJqBaV3lHQFzc+HJMII7FVQpgHmjeR
         qb/U9qvat9N9pyCQB8/PybGcTUo1pMj04qZH7fvX4bRXBztnC5+6Qpl8IzBeRtYk8sKy
         BBGKsHHkNFedgCDShUbvbG6bg9NcRouGThO2/BN300oXnokmKKlguEigQjwqTgUKrXht
         Bkvw==
X-Gm-Message-State: AA+aEWZ9Z2lz5gjGgc76vMdZ3BqT//aFCN52otyMNy2Fuz628AwaA2cs
        Ds6RwiEMPr7lOjMAoH3rczg=
X-Google-Smtp-Source: AFSGD/X8qlK2n2hplDG4tQv2vtWc0LV4NfhJ1pj+xYVqIzWvNUyv6n93sVcwGp3e8NfA1x/ZuORuog==
X-Received: by 2002:a63:2946:: with SMTP id p67mr18573591pgp.317.1545199266042;
        Tue, 18 Dec 2018 22:01:06 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a2:eb51:6018:45d4:55a2:e94b])
        by smtp.gmail.com with ESMTPSA id o7sm22396064pfb.34.2018.12.18.22.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 22:01:05 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v6 4/8] gpio: 104-idi-48: Utilize for_each_set_clump8 macro
Date:   Wed, 19 Dec 2018 15:01:35 +0900
Message-Id: <67e0105ad1718d3fd1cdf991d56427ac38969891.1545198260.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1545198260.git.vilhelm.gray@gmail.com>
References: <cover.1545198260.git.vilhelm.gray@gmail.com>
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
index 88dc6f2449f6..fdf1b8b64cc4 100644
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
+		bitmap_set_value8(bits, &port_state, offset);
 	}
 
 	return 0;
-- 
2.20.1

