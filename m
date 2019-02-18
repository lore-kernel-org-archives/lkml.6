Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3447AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02811217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DErqkuk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbfBRJs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:48:28 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37953 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729804AbfBRJsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:48:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id v26so16349325wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 01:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2P/9cB+jmoaw2Dnwldpp3xOYGEGj2ZimLHwmer8wLno=;
        b=DErqkuk3xdQVZDsUPP1dxxzv9VqBmngBn8CejR4EYPe0Cq26UVpyxmkwTbCHC16LLI
         8YjYJMrnK6RDDFxZ3HuyTrSX+I9hpIkj8tPvYj/n9nbrdYY6Jbwn1AMGTVJHqBOq3qm6
         p0J+sDVrSBGIWfBygl339MohJMeBWfDPnjtf6Us+OmZ+4/dsn3AN1yofZjY+E69/DRtU
         Pr46/bJZvQdJftfJUvzHOvOvRH3Jc69vxCCSIUd1GuOqmZElFJ0HVv/Act6p2szk2Blv
         STLw1seBFRCZLlU7UdPDuhGu1ksn5vQXhRR1ACRFoyMPbqkRS0/fURtJP+BNhmup1qUH
         vUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2P/9cB+jmoaw2Dnwldpp3xOYGEGj2ZimLHwmer8wLno=;
        b=P5s/4Q7YCUB/WWuzsClkTgjiLdo1COR71ehCGskLQES39RYwpmpiYXg7ly4sSEBeuM
         vCsU7se2XiGzGkkrTFN8hJlVg3rOqKrWZtacOY5fStjDgEQR7UQy8rhAwscle9SHkTQT
         3c+QRbZtAEy/zHozmDEvnNBQH1sY6OCaezr79Y/wU0iG+WMQgE7LD+QEl1u81RngIO1T
         c/osGxOS/yX1cine1RhS2tBxwaDVf67ilKvS5eTEGMvQXMv9RU+QC6IkRY9gSAwwV0ow
         7Z7ZvtZs8yRAm61tcJ0iD1sLeC7xgBqMg0U9vycxgmXgPnmkPuQtx8abhd8ItHCeSlop
         hSuw==
X-Gm-Message-State: AHQUAuZE3t3ezXG8xVbfJq6uFiw90YJX+Y1roI4Z4J0PW0fDpVKPlWyL
        KCJ+5ZwokZ7o2pkrDFPpusq3hw==
X-Google-Smtp-Source: AHgI3IZUq3zEabJVasui2IYO9qJ9KpRi6xpGEae/vhxMr/4EkPJOUzrJolAdX0X3tCn9td3Y1JNLAw==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr14518334wmk.47.1550483294579;
        Mon, 18 Feb 2019 01:48:14 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-7-43.w90-86.abo.wanadoo.fr. [90.86.124.43])
        by smtp.gmail.com with ESMTPSA id u15sm17582974wmu.17.2019.02.18.01.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 01:48:13 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 5/6] gpio: mockup: change the signature of unlocked get/set helpers
Date:   Mon, 18 Feb 2019 10:47:58 +0100
Message-Id: <20190218094759.14545-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218094759.14545-1-brgl@bgdev.pl>
References: <20190218094759.14545-1-brgl@bgdev.pl>
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
2.20.1

