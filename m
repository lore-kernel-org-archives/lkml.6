Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31C6C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC2621476
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbY0dt1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC2621476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeJBH4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:56:48 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44331 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbeJBH4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:56:48 -0400
Received: by mail-io1-f65.google.com with SMTP id x26-v6so302218iog.11;
        Mon, 01 Oct 2018 18:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9i7PtM1Ao7x+iAsBKZY6clJGmtrfgNOGfKQRvviA4ko=;
        b=dbY0dt1AGBkKF7Lg0IXhDWj14ofy9dt8uDCMquirvnV6elnQVVUNOQCJF2ndeknlsI
         4QCleuChyiky17RxiyOBLmrBw4AiOM3Kyv5zF9JSLAY9Qs9gXz7rROHlLwLWzHXQ3/vL
         e/BxBRqTFkLuQQtNAdSacsYKmjcBI42IUAen4vUN4zL+cfH4wvcErvwhR0sTkHPvtXt4
         yqa8pAkRFTYy9JmDXmHF7dNCG0W4rmA8YfLcDlfeXhQVG+a8OiXUMw9XU/9d75mLicvc
         z4FoB4u9u1sSx/8lGSw7thill+NidEoahVBqb5bMDKojdvZowOOuGn/pv8LVB/XM3oQp
         f8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9i7PtM1Ao7x+iAsBKZY6clJGmtrfgNOGfKQRvviA4ko=;
        b=GOKx5HmsU3yromaKuaIKWUzMSeh4hEUgixNOivbuy62I1GaogNnxWXKcSaPAdi6ejA
         CQdCj7eGlUk0I4O1xnntZWHdsuRyU8JP1/Jg1lqmnFwdKLBhqxAr13BXTdbmSWFtNJlk
         xKtaOO264xvN25K6Ggwl5jZ92/5eoMDNjAcQoTw9Y34uOjWA8EhamkW9K96oc1DO5iE+
         25l2fFFhXmuCOJ50WtM4unGT/7gQJk2enODPkctqg1EUYcIqV/kj7kqYDhCu9P7Qdw4w
         VxMmxy0qtVJeuU7oI8VSPGZr2C/rSteSTNslEfUhM60A/Q7rZof5e8edVcVU5/7jLt6s
         VdAw==
X-Gm-Message-State: ABuFfoi8/O7vjK2KPNrj3h+HfIvCCU8Ye0dBSt+XWQ3u6j1aC/GWAP5X
        EZXUBomH3hMYR7sBecgMTvk=
X-Google-Smtp-Source: ACcGV60NW65T5Mo6vCbWg5G0ClszZBI+LLYsVU3Ud2WEnUWGsgfmOxrszwbrK2mOrNliCom1yhk1gw==
X-Received: by 2002:a62:71c4:: with SMTP id m187-v6mr13869892pfc.232.1538442972581;
        Mon, 01 Oct 2018 18:16:12 -0700 (PDT)
Received: from localhost.localdomain (122-223-50-245.fukuoka.fdn.vectant.ne.jp. [122.223.50.245])
        by smtp.gmail.com with ESMTPSA id 72-v6sm15744313pfr.115.2018.10.01.18.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 18:16:12 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RESEND PATCH v4 8/8] gpio: pcie-idio-24: Utilize for_each_set_clump macro
Date:   Tue,  2 Oct 2018 10:16:16 +0900
Message-Id: <f05ac2b1003db136a425474bfce65a3229b242e0.1538441919.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-pcie-idio-24.c | 102 +++++++++++--------------------
 1 file changed, 36 insertions(+), 66 deletions(-)

diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-idio-24.c
index f953541e7890..b4d300338a05 100644
--- a/drivers/gpio/gpio-pcie-idio-24.c
+++ b/drivers/gpio/gpio-pcie-idio-24.c
@@ -199,41 +199,21 @@ static int idio_24_gpio_get_multiple(struct gpio_chip *chip,
 {
 	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
 	size_t i;
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
-	unsigned long port_state;
+	size_t word;
+	unsigned int offset;
 	void __iomem *ports[] = {
 		&idio24gpio->reg->out0_7, &idio24gpio->reg->out8_15,
 		&idio24gpio->reg->out16_23, &idio24gpio->reg->in0_7,
 		&idio24gpio->reg->in8_15, &idio24gpio->reg->in16_23,
 	};
+	const size_t num_ports = ARRAY_SIZE(ports) + 1;
+	unsigned long port_state;
 	const unsigned long out_mode_mask = BIT(1);
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports) + 1; i++) {
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
+	for_each_set_clump(i, word, offset, mask, num_ports, 8) {
 		/* read bits from current gpio port (port 6 is TTL GPIO) */
 		if (i < 6)
 			port_state = ioread8(ports[i]);
@@ -243,7 +223,7 @@ static int idio_24_gpio_get_multiple(struct gpio_chip *chip,
 			port_state = ioread8(&idio24gpio->reg->ttl_in0_7);
 
 		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= port_state << word_offset;
+		bits[word] |= port_state << offset;
 	}
 
 	return 0;
@@ -295,58 +275,48 @@ static void idio_24_gpio_set_multiple(struct gpio_chip *chip,
 {
 	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
 	size_t i;
-	unsigned long bits_offset;
-	unsigned long gpio_mask;
-	const unsigned int gpio_reg_size = 8;
-	const unsigned long port_mask = GENMASK(gpio_reg_size, 0);
-	unsigned long flags;
-	unsigned int out_state;
+	size_t word;
+	unsigned int offset;
 	void __iomem *ports[] = {
 		&idio24gpio->reg->out0_7, &idio24gpio->reg->out8_15,
 		&idio24gpio->reg->out16_23
 	};
+	const size_t num_ports = ARRAY_SIZE(ports) + 1;
+	unsigned int iomask;
+	unsigned int bitmask;
+	unsigned long flags;
 	const unsigned long out_mode_mask = BIT(1);
-	const unsigned int ttl_offset = 48;
-	const size_t ttl_i = BIT_WORD(ttl_offset);
-	const unsigned int word_offset = ttl_offset % BITS_PER_LONG;
-	const unsigned long ttl_mask = (mask[ttl_i] >> word_offset) & port_mask;
-	const unsigned long ttl_bits = (bits[ttl_i] >> word_offset) & ttl_mask;
-
-	/* set bits are processed a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports); i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
-
-		/* check if any set bits for current port */
-		gpio_mask = (*mask >> bits_offset) & port_mask;
-		if (!gpio_mask) {
-			/* no set bits for this port so move on to next port */
+	unsigned int out_state;
+
+	for_each_set_clump(i, word, offset, mask, num_ports, 8) {
+		iomask = mask[word] >> offset;
+		bitmask = iomask & (bits[word] >> offset);
+
+		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
+
+		/* read bits from current gpio port (port 6 is TTL GPIO) */
+		if (i < 6) {
+			out_state = ioread8(ports[i]) & ~iomask;
+		} else if (ioread8(&idio24gpio->reg->ctl) & out_mode_mask) {
+			out_state = ioread8(&idio24gpio->reg->ttl_out0_7);
+		} else {
+			/* skip TTL GPIO if set for input */
+			raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
 			continue;
 		}
 
-		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
+		/* set requested bit states */
+		out_state &= ~iomask;
+		out_state |= bitmask;
 
-		/* process output lines */
-		out_state = ioread8(ports[i]) & ~gpio_mask;
-		out_state |= (*bits >> bits_offset) & gpio_mask;
-		iowrite8(out_state, ports[i]);
+		/* write bits for current gpio port (port 6 is TTL GPIO) */
+		if (i < 6)
+			iowrite8(out_state, ports[i]);
+		else
+			iowrite8(out_state, &idio24gpio->reg->ttl_out0_7);
 
 		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
 	}
-
-	/* check if setting TTL lines and if they are in output mode */
-	if (!ttl_mask || !(ioread8(&idio24gpio->reg->ctl) & out_mode_mask))
-		return;
-
-	/* handle TTL output */
-	raw_spin_lock_irqsave(&idio24gpio->lock, flags);
-
-	/* process output lines */
-	out_state = ioread8(&idio24gpio->reg->ttl_out0_7) & ~ttl_mask;
-	out_state |= ttl_bits;
-	iowrite8(out_state, &idio24gpio->reg->ttl_out0_7);
-
-	raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
 }
 
 static void idio_24_irq_ack(struct irq_data *data)
-- 
2.19.0

