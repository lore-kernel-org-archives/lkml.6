Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F226C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67CB214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tFtdgmeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390084AbfBRQmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:42:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37712 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389956AbfBRQlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:41:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id c8so19095361wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 08:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2P/9cB+jmoaw2Dnwldpp3xOYGEGj2ZimLHwmer8wLno=;
        b=tFtdgmeSEfLXBWexpF0a6CIK7rP4GudZIGUAUQfj8fAjnob6TRnT3JC2/y5gtm2G+I
         LMtuM53/fSXzWCsvGNmsbQ0QL7gcJBo39X/3yDASJ0VXRrXWJm0ljiNChoJQf8Nr+DrN
         3l6t/rhUBK+8Mr4LZ3N+XlGmaZoo+POS29x5+nxS+h+F3icyw2DPlJvvLglhNXRhMLxI
         dWd7NpQ18HiA5BYXdEThTIt1T7VqX/QWkbDGL+1X4E16zm5LSP1UJi1oQxQ0qoQmBsg+
         wdzRHCcIpgn727AfMOn96jwZuMTy6xBoGn6P9utOWtSHLZfcrWz40fj5CIiymleSHFwe
         Njsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2P/9cB+jmoaw2Dnwldpp3xOYGEGj2ZimLHwmer8wLno=;
        b=SUwB3RL5NGFFb+Pq5z68p7m9CJ3xOKfZAlkCpmNZKkAxKy1e915/sF9oVViH8Fsn9i
         ilJp3BZX/hlF2ZvhWYvUrPOQFwHCI2zuChMQCfRxNctQLR/g4qhtkpW4DeMh8auBcyBg
         ERci7CtR3dC0b4c+b8jkB62xc9kK33WilkQB0Q0gmGwfqVZM3miyhTbZycyTVkZNs1+u
         164hbtN3zzIdFxuizu3yrLt6ESriSnCSvKBL9smYFr1frTST4TTR58iri1cPHXXhrb6V
         gEMlvArWuXZqWRKNi9cS5nHEPHT96WHn6vJeYG/rE89QIup9UDeWcDv1bRlg9CWLCjpA
         KCqg==
X-Gm-Message-State: AHQUAubnt2uUIxjgv7d6B86/2koiaxq1lnb6yPXH1L9olYcTENJojJ1+
        Lcq6lpXZXpeYn3paZvyrtnET2g==
X-Google-Smtp-Source: AHgI3IZe1mt9ICtwOhvEW2P1PyCMYa1bI7fuHIdrkz0ren9l6siNlirhPv5C+T5ov09cQiBI7kIgMA==
X-Received: by 2002:adf:fa47:: with SMTP id y7mr17519894wrr.301.1550508109106;
        Mon, 18 Feb 2019 08:41:49 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-7-43.w90-86.abo.wanadoo.fr. [90.86.124.43])
        by smtp.gmail.com with ESMTPSA id w10sm6325442wru.5.2019.02.18.08.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 08:41:48 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 6/7] gpio: mockup: change the signature of unlocked get/set helpers
Date:   Mon, 18 Feb 2019 17:41:37 +0100
Message-Id: <20190218164138.24921-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218164138.24921-1-brgl@bgdev.pl>
References: <20190218164138.24921-1-brgl@bgdev.pl>
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

