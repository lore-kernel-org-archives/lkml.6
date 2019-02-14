Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6262C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FE3222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="RRiJ8WHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438922AbfBNNnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:43:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44095 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436806AbfBNNnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:43:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id v16so6499997wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 05:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GC+n/jTkiJeclZfnsvak2DYAHje9HHQVbgEzbwl1h8U=;
        b=RRiJ8WHYgIBmuVZgQb7X5VBCo2glq6x/hLColZh9Sah3akDsalph9pt9dkZQhZI/CE
         YJqkvrMoJTvcxI+PqVGsxLi88VHO3ks6iqemfJofNKR+UolMKAPLgT1+rGS44VUabf+j
         G7sFVhw1me+lqG2kxFoqGj2y0d7W9esRr7jLpyrTfFcxd8w9D8LqDFQpmqDdXHVwS5EB
         pkrnHus5cdQlrDwsUHYVIrKpYyGYCzaL/2U0Wblzoq1x/HbAy84w3WEGjcr6zRH+s9rs
         uuKn2z/727l2QnnULUu33OaZRES+AeT7kS2cnacstC5B/wfPhGjygZXsQRa9fLQ6QHCX
         S6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GC+n/jTkiJeclZfnsvak2DYAHje9HHQVbgEzbwl1h8U=;
        b=mBrFBCiuJoGWFReondOpflr00YgRi5bryhR/rcV59BG4DRhE2NYC2bTflafDOy3FxL
         HoxFmgEZeeKm1Fv8IL0ZzUWmKztVhAW6FFw/27xwXshXrAy6ms4XhMOan8s5u3PVu8EF
         YV7Wub2hMfNN8iAdpXAayE45EnZY5t07cpuUVxOM9fkb3lhLVQjz/FFkoewv6zicx2Lp
         ZZyHq6FJebKehvmOQSAWMSHrV3wMWWS0U9y9rjsU/s7vmjmDW5NOydIsIBEIIWFlvTDR
         Sos7l917MUuV/Xo/7/bL78lNnM0xhn9TwMew5+994i+0BFt+6p5J/0/4sq+tLILsbaJW
         uP4g==
X-Gm-Message-State: AHQUAua9nWhnjU//iTJPsAfD/ZBNzz11L/ZTeRRsuyGGSjVzTZdgv4N6
        faPNp8o3owvtJTJUc5mRRXeg9Q==
X-Google-Smtp-Source: AHgI3Iaurwk3D39LwZkjUBltMG84gw7qexsg7DrssKGMopEJcuhQKjmPOqE4YPgLH/M5YGBpYo0pdg==
X-Received: by 2002:a5d:4fc5:: with SMTP id h5mr2859767wrw.84.1550151782812;
        Thu, 14 Feb 2019 05:43:02 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id 62sm4963460wra.46.2019.02.14.05.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 05:43:02 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 6/7] gpio: mockup: change the signature of unlocked get/set helpers
Date:   Thu, 14 Feb 2019 14:42:31 +0100
Message-Id: <20190214134232.3821-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214134232.3821-1-brgl@bgdev.pl>
References: <20190214134232.3821-1-brgl@bgdev.pl>
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
index 4e7688348c0e..f1807afd44ba 100644
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
 
 	spin_lock(&chip->lock);
-	val = __gpio_mockup_get(gc, offset);
+	val = __gpio_mockup_get(chip, offset);
 	spin_unlock(&chip->lock);
 
 	return val;
@@ -110,7 +109,7 @@ static int gpio_mockup_get_multiple(struct gpio_chip *gc,
 
 	spin_lock(&chip->lock);
 	for_each_set_bit(bit, mask, gc->ngpio) {
-		val = __gpio_mockup_get(gc, bit);
+		val = __gpio_mockup_get(chip, bit);
 		__assign_bit(bit, bits, val);
 	}
 	spin_unlock(&chip->lock);
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
 
 	spin_lock(&chip->lock);
-	__gpio_mockup_set(gc, offset, value);
+	__gpio_mockup_set(chip, offset, value);
 	spin_unlock(&chip->lock);
 }
 
@@ -144,7 +141,7 @@ static void gpio_mockup_set_multiple(struct gpio_chip *gc,
 
 	spin_lock(&chip->lock);
 	for_each_set_bit(bit, mask, gc->ngpio)
-		__gpio_mockup_set(gc, bit, test_bit(bit, bits));
+		__gpio_mockup_set(chip, bit, test_bit(bit, bits));
 	spin_unlock(&chip->lock);
 }
 
@@ -155,7 +152,7 @@ static int gpio_mockup_dirout(struct gpio_chip *gc,
 
 	spin_lock(&chip->lock);
 	chip->lines[offset].dir = GPIO_MOCKUP_DIR_OUT;
-	__gpio_mockup_set(gc, offset, value);
+	__gpio_mockup_set(chip, offset, value);
 	spin_unlock(&chip->lock);
 
 	return 0;
-- 
2.20.1

