Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01901C282C5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F8A20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uGpUQW0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfAWOQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:16:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54814 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfAWOPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:15:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so2133465wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 06:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lxsbnWY+u5ZD2HJ8Gj47byZdwyvd+a73Kv/KMI9VfHI=;
        b=uGpUQW0tYNkDz+t0BNndB2i4PWinvJadgy4277/VcnjfkcKOPd0x1RHrgZmGGSARqw
         46JYT5OZuBBtwAtC1sSC3z/zd0M8imvbEzgnZtiULEOEs29HzpR8dQCSrqtSzkfm78zA
         pv+aMeXt+cbvFJMEkBE/74ovNGGiQ2B9VQwZ68DOyl4oH6CwsPgpz9ky5KrW4SNecILv
         qjZlAvaFvLTXw2RwwSSjqCsBqz3cuIrMQeIYMxwJEINgjB26nPIsdOk3J9LfC6N3A3Pa
         MWujK8tYZWAlhHvMzM5q53MeO6rEIcSGSdqVncCdU8DuKHPXAw2DHTB+VbqRJBiZYThm
         5LhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lxsbnWY+u5ZD2HJ8Gj47byZdwyvd+a73Kv/KMI9VfHI=;
        b=U6Hr35Wo7OStvzOtADvoby2oL+oW1Bw1oGL8BeuTuFiL/M2W3tnhRACP4QsYAbf5c1
         3JBbUu175u/quu+/B2lYwkQPqhmPeMfOCuKoacx1v+kb7jwEgG99Jb+MIEXqHrROVQY9
         aZalFXezuKeRheYsQJAi77HPOuiThtpWPv+LOuranIJygyExSXfy87vYIz7UDcUq+e4g
         NNpqi6yVI6tmCQagjCJ9Bep1QX9bAlenzDN0G2rRL0pR2/TZqOTne8pkOd7iLddENnUF
         f3G6HHd38HbLJUfpBhk7TPTW/T3Ub3oWs1MJC0CQEPP5AD2UiatryZfENkbiTCO23lW9
         ha2Q==
X-Gm-Message-State: AJcUukcp83oFYVjLQI5eZBafjYwlA6AyfV1ya0h5WdlpZqGofsbVlwsE
        wNda0uIkbHj5ZrxEBT4Mm7TSt2/GL5E=
X-Google-Smtp-Source: ALg8bN4OXc8aT70YhNURo9o0CEY4ZRYfzv2KtxkGiyevA9M6RVXjnot5ZG4nSh2jdvcv4AiBV7zvhw==
X-Received: by 2002:a1c:b456:: with SMTP id d83mr3035253wmf.115.1548252950171;
        Wed, 23 Jan 2019 06:15:50 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a8sm29072997wme.23.2019.01.23.06.15.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:15:49 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 4/9] gpio: mockup: add locking
Date:   Wed, 23 Jan 2019 15:15:33 +0100
Message-Id: <20190123141538.29408-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190123141538.29408-1-brgl@bgdev.pl>
References: <20190123141538.29408-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While no user reported any race condition problems with gpio-mockup,
let's be on the safe side and use a mutex when performing any changes
on the dummy chip structures.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpio-mockup.c | 50 ++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 6a50f9f59c90..b4c1de6acf74 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -54,6 +54,7 @@ struct gpio_mockup_chip {
 	struct gpio_mockup_line_status *lines;
 	struct irq_sim irqsim;
 	struct dentry *dbg_dir;
+	struct mutex lock;
 };
 
 struct gpio_mockup_dbgfs_private {
@@ -82,29 +83,53 @@ static int gpio_mockup_range_ngpio(unsigned int index)
 	return gpio_mockup_ranges[index * 2 + 1];
 }
 
-static int gpio_mockup_get(struct gpio_chip *gc, unsigned int offset)
+static int __gpio_mockup_get(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
 	return chip->lines[offset].value;
 }
 
-static void gpio_mockup_set(struct gpio_chip *gc,
-			    unsigned int offset, int value)
+static int gpio_mockup_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
+	int val;
+
+	mutex_lock(&chip->lock);
+	val = __gpio_mockup_get(gc, offset);
+	mutex_unlock(&chip->lock);
+
+	return val;
+}
+
+static void __gpio_mockup_set(struct gpio_chip *gc,
+			      unsigned int offset, int value)
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
 	chip->lines[offset].value = !!value;
 }
 
+static void gpio_mockup_set(struct gpio_chip *gc,
+			   unsigned int offset, int value)
+{
+	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
+
+	mutex_lock(&chip->lock);
+	__gpio_mockup_set(gc, offset, value);
+	mutex_unlock(&chip->lock);
+}
+
 static void gpio_mockup_set_multiple(struct gpio_chip *gc,
 				     unsigned long *mask, unsigned long *bits)
 {
+	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 	unsigned int bit;
 
+	mutex_lock(&chip->lock);
 	for_each_set_bit(bit, mask, gc->ngpio)
-		gpio_mockup_set(gc, bit, test_bit(bit, bits));
-
+		__gpio_mockup_set(gc, bit, test_bit(bit, bits));
+	mutex_unlock(&chip->lock);
 }
 
 static int gpio_mockup_dirout(struct gpio_chip *gc,
@@ -112,8 +137,10 @@ static int gpio_mockup_dirout(struct gpio_chip *gc,
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
-	gpio_mockup_set(gc, offset, value);
+	mutex_lock(&chip->lock);
 	chip->lines[offset].dir = GPIO_MOCKUP_DIR_OUT;
+	__gpio_mockup_set(gc, offset, value);
+	mutex_unlock(&chip->lock);
 
 	return 0;
 }
@@ -122,7 +149,9 @@ static int gpio_mockup_dirin(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
+	mutex_lock(&chip->lock);
 	chip->lines[offset].dir = GPIO_MOCKUP_DIR_IN;
+	mutex_unlock(&chip->lock);
 
 	return 0;
 }
@@ -130,8 +159,13 @@ static int gpio_mockup_dirin(struct gpio_chip *gc, unsigned int offset)
 static int gpio_mockup_get_direction(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
+	int direction;
 
-	return !chip->lines[offset].dir;
+	mutex_lock(&chip->lock);
+	direction = !chip->lines[offset].dir;
+	mutex_unlock(&chip->lock);
+
+	return direction;
 }
 
 static int gpio_mockup_to_irq(struct gpio_chip *gc, unsigned int offset)
@@ -283,6 +317,8 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 			return -ENOMEM;
 	}
 
+	mutex_init(&chip->lock);
+
 	gc = &chip->gc;
 	gc->base = base;
 	gc->ngpio = ngpio;
-- 
2.19.1

