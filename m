Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79408C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483BB21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="N9TwKyfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfBLNQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:16:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55284 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbfBLNQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:16:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so2909038wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 05:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2P/9cB+jmoaw2Dnwldpp3xOYGEGj2ZimLHwmer8wLno=;
        b=N9TwKyfxR4kWTjYcgCqmgbbSUXyvW9k8NyGdGjt5L1rnZzRGcHCA8H7ReNjYztGMkC
         DS3tm71gbANaJofKpJXeL32aeXjNQxu/6FsDrTznFXobTRUaeywX1Lh5hmzDfYrVPSPn
         11GWpfDOTy/IXjMOn1TppmzVecx5JTGMxs8zKKJTE543wyRRJB7kf20khvOhCh9ROjrL
         dY4zs1s/NaKZ6toTD/dRALa+FddeV9M1bsGyrztptLV+ObJ/v7Oq4b8eAhLM7IAcO+yY
         +xYxQx/1ZMya32Q7kN6gw0478Afg9QVmQspDxa8OUvLIdCOd5cW9m7LZj9PmKllGLWal
         i1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2P/9cB+jmoaw2Dnwldpp3xOYGEGj2ZimLHwmer8wLno=;
        b=UFxHvBmbNlHdcYrZix0k/fsr6PYyBjcyQwFZLLgrwgp5AU1sZljlfAEni5kudIZHVh
         7EnopaWiX/AdyMK7sRC/pF+LsnrOiUvYEku9gGju1+X9igs0e0Il/57EoHpwyKnGVunO
         YpOnhq/tWVacWw+kn+IpEekyw7xW1ZD+hthkMl/QcGS/NMLTEOer6Wqh2S+TmwN7itHs
         A1Y1GtHK671ClUMblz9WakqRqekC7UeA6goQ1SIWGlncLbuXyrnwsMeeWkioOSgoLx3Y
         iyzUjWN5DKtYkgVhFmnd3tLvI322+a+S2zKowW9uwjFhlmzRibYWuKtnsnD4hQ/v6oBa
         l5bw==
X-Gm-Message-State: AHQUAuayi2KO014SmlDOiRVnG6R2Yua1HaPtdK5RLlNc3YsEBxCiG4kw
        AMN0sFebha69U+cKaZjBeKn8hA==
X-Google-Smtp-Source: AHgI3IbKcaAuGkqVqhdurCQDKWqdhEPZeudupZK7lofuateHP8vq9Sb7lUGbH3JDa1l9A8K3r7NRdg==
X-Received: by 2002:a1c:2c6:: with SMTP id 189mr2817107wmc.21.1549977392171;
        Tue, 12 Feb 2019 05:16:32 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id p6sm5478517wre.63.2019.02.12.05.16.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 05:16:31 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 6/7] gpio: mockup: change the signature of unlocked get/set helpers
Date:   Tue, 12 Feb 2019 14:15:59 +0100
Message-Id: <20190212131600.18960-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212131600.18960-1-brgl@bgdev.pl>
References: <20190212131600.18960-1-brgl@bgdev.pl>
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

