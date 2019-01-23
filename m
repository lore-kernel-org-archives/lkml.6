Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6279C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D322184B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ox6ry/Cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfAWOP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:15:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42872 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfAWOP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:15:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so2619316wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 06:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=758F2G6mHwZtHqDlM/wuN9QC0Q3bwGTIieLyA4J0jgo=;
        b=ox6ry/CuI12etkFm4WDAmMwu0mXBDuOJ4lHU7XPGiMhPw1aPXZ6Wo+FIuM4wApFHbP
         fa4wdGWuF9SdiCb0VhN2tVki8Vgx7QbTuAxYgtQwj+HHIqc7toNluMut1Ncnw2mkkODl
         FOI5W/zLcNLz8+xnU6d31Y9Ql0V5UX5twySkfO2uHCI2olacIJAlflrzBcDsI4UfwRm5
         myZDA9yz0Fu5FyILY+jFxC/Gaj+jbX2O8Q7/P+80ZvebcizskE2t9xs3v/zhVKNZmyob
         jM/RMqmLxe/wsaUnPNlJL3G4qhpIg2afWhl75NsR/FRKjKnznt46oqz3hbGiwDXCrGXM
         7/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=758F2G6mHwZtHqDlM/wuN9QC0Q3bwGTIieLyA4J0jgo=;
        b=RwBB7DdunbocSlFTOpL5NOj9wdkmin8qz3QtCJ3QPzYkA+OQ/8ZTq2wRuzEUgjh9XG
         XPGgfriIs2HbLY1AGILpY0LVyaFpaPsuNqOPBJ8SZfPPnOIGCSkvmLOdE295Yu/zY0y2
         ovLdr2ErXiCRPU61KJ17qex7fpvdjbQl2F0e3GvxSFy+5rhCoz0W4iepejJjHT4lTRbW
         /EVp7EVKx06zTMAEm7i0tpG61MqIpf/HOEZqI8w19NMf3sU6IEyLnbkBBb3WKtkF1/sV
         qnurgYKOyZ2hm4DW27Vyan0TwH9OjiLUqXu8pi0e42oRpXLcuuqqSbJib8Eqdmcq+mB4
         L+oQ==
X-Gm-Message-State: AJcUukdnUS+JD9jsrjcfvLzziAoMbIWV9ZWFJSCxgnRaZW8sPb/cVFyy
        h6luWfixjYv/dVZv+YOkhByAZw==
X-Google-Smtp-Source: ALg8bN4bmnrlVydvG7UIZy4ZDYQr7FgwlSjaN5f0TvVLgzWxgSNhSVQsSNvZNuY5dIl4lPPd5Cb/qg==
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr2890432wrq.5.1548252955121;
        Wed, 23 Jan 2019 06:15:55 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a8sm29072997wme.23.2019.01.23.06.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:15:54 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 8/9] gpio: mockup: change the signature of unlocked get/set helpers
Date:   Wed, 23 Jan 2019 15:15:37 +0100
Message-Id: <20190123141538.29408-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190123141538.29408-1-brgl@bgdev.pl>
References: <20190123141538.29408-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The unlocked variants only get called from places where we already have
the pointer to the underlying gpio_mockup_chip structure, so take it
as parameter instead of struct gpio_chip.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 433adb3b4617..c498b0fbbec8 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -83,10 +83,9 @@ static int gpio_mockup_range_ngpio(unsigned int index)
 	return gpio_mockup_ranges[index * 2 + 1];
 }
 
-static int __gpio_mockup_get(struct gpio_chip *gc, unsigned int offset)
+static int __gpio_mockup_get(struct gpio_mockup_chip *chip,
+			     unsigned int offset)
 {
-	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
-
 	return chip->lines[offset].value;
 }
 
@@ -96,7 +95,7 @@ static int gpio_mockup_get(struct gpio_chip *gc, unsigned int offset)
 	int val;
 
 	mutex_lock(&chip->lock);
-	val = __gpio_mockup_get(gc, offset);
+	val = __gpio_mockup_get(chip, offset);
 	mutex_unlock(&chip->lock);
 
 	return val;
@@ -110,7 +109,7 @@ static int gpio_mockup_get_multiple(struct gpio_chip *gc,
 
 	mutex_lock(&chip->lock);
 	for_each_set_bit(bit, mask, gc->ngpio) {
-		val = __gpio_mockup_get(gc, bit);
+		val = __gpio_mockup_get(chip, bit);
 		__assign_bit(bit, bits, val);
 	}
 	mutex_unlock(&chip->lock);
@@ -118,11 +117,9 @@ static int gpio_mockup_get_multiple(struct gpio_chip *gc,
 	return 0;
 }
 
-static void __gpio_mockup_set(struct gpio_chip *gc,
+static void __gpio_mockup_set(struct gpio_mockup_chip *chip,
 			      unsigned int offset, int value)
 {
-	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
-
 	chip->lines[offset].value = !!value;
 }
 
@@ -132,7 +129,7 @@ static void gpio_mockup_set(struct gpio_chip *gc,
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
 	mutex_lock(&chip->lock);
-	__gpio_mockup_set(gc, offset, value);
+	__gpio_mockup_set(chip, offset, value);
 	mutex_unlock(&chip->lock);
 }
 
@@ -144,7 +141,7 @@ static void gpio_mockup_set_multiple(struct gpio_chip *gc,
 
 	mutex_lock(&chip->lock);
 	for_each_set_bit(bit, mask, gc->ngpio)
-		__gpio_mockup_set(gc, bit, test_bit(bit, bits));
+		__gpio_mockup_set(chip, bit, test_bit(bit, bits));
 	mutex_unlock(&chip->lock);
 }
 
@@ -155,7 +152,7 @@ static int gpio_mockup_dirout(struct gpio_chip *gc,
 
 	mutex_lock(&chip->lock);
 	chip->lines[offset].dir = GPIO_MOCKUP_DIR_OUT;
-	__gpio_mockup_set(gc, offset, value);
+	__gpio_mockup_set(chip, offset, value);
 	mutex_unlock(&chip->lock);
 
 	return 0;
-- 
2.19.1

