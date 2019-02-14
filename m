Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD0BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CCE222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jkd0PUwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438950AbfBNNn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:43:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54817 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394833AbfBNNnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:43:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so6341223wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 05:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3tT9dI2HnjqRSVUEzTyodAkGk3Ngn/N6QgaGevUjPNY=;
        b=jkd0PUwjOzPH4qsvwvqjF2fkDSxYBg/G06zCfYzsxOeYrQ0vQRJCssYxQcrL5QVNme
         kgTy6tUaGUmALn7WEY8m8cizyyz3JDSxiuQWXUppkR4+9Rzq7u77l7rG3WU086ifvA3G
         1TupZ44wEFmp3wXNtU1d+Q3YOdZP00PMTv9R89PBdVlkRkalRXntZ3uEawetyFDA0pSQ
         zbeul3aBZUj6ubwnOC8N2uGGr91bc8qv0xlL4EvsgIvZpHlj76SJ74s4zva1khleqOu4
         WVxF4Z9lvxXMrmNgTxfVDnQteIuyOnuHhWYlowPwnWydc5PlrOQe1zG3Fd9Y1+Y950xg
         Vg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tT9dI2HnjqRSVUEzTyodAkGk3Ngn/N6QgaGevUjPNY=;
        b=ZhdJO/wfw5EPDK9/dx+hmFP2WTfw9mi6xHl/QWpRIKo8RC0v9q82w4BR5gtiwqmvVd
         6gKmRdo8wj5XAtPHJmCONIPQ7pRAnubyOCsIeGrQRxD4nrDYKK0lmcg0dUEjdRwvtgct
         CCQyQZfk95voIlmU22WqMT5BBqJyVrvwYfpg4p7O1y0/nbxWlPRt1ojhQ6rPTHhvQTSb
         ZugTFlUS+zSe2kJFWVbNaP6pCNoxGxXnNTw0LtzFy7+mEemiQt1aUQCJpjgnkRgdUkNd
         iIzCCzE2qYX9HC89apFe+s9nrZqzMjWbuKfTojpdRC3W4mIoZrWBSCHJiGNKaeh9Z9TC
         woOA==
X-Gm-Message-State: AHQUAubJtMhuDNIwNejgUcWh/wPL9EmLZELsg+lCrwVssdLMMHaLFLfN
        MkKGzPAfUxVkeod2g9wtj7VdvQ==
X-Google-Smtp-Source: AHgI3Ib/FDyR2aGbifEGhAcZlod8zSN17S2mMYzgY6Xhm3uv1LXS3FApCXtgH4jVlHK816Irx1eqLg==
X-Received: by 2002:a1c:c904:: with SMTP id f4mr3001486wmb.42.1550151778163;
        Thu, 14 Feb 2019 05:42:58 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id 62sm4963460wra.46.2019.02.14.05.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 05:42:57 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 2/7] gpio: mockup: add locking
Date:   Thu, 14 Feb 2019 14:42:27 +0100
Message-Id: <20190214134232.3821-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214134232.3821-1-brgl@bgdev.pl>
References: <20190214134232.3821-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

While no user reported any race condition problems with gpio-mockup,
let's be on the safe side and use a spinlock when performing any
changes on the dummy chip structures. We're using a spinlock because
a subsequent patch will register an irq_sim notifier which holds
the irq_desc lock and if using a mutex we'd get the
"HARDIRQ-safe -> HARDIRQ-unsafe" lockdep error.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 50 ++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 6a50f9f59c90..9697bf622284 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -54,6 +54,7 @@ struct gpio_mockup_chip {
 	struct gpio_mockup_line_status *lines;
 	struct irq_sim irqsim;
 	struct dentry *dbg_dir;
+	spinlock_t lock;
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
+	spin_lock(&chip->lock);
+	val = __gpio_mockup_get(gc, offset);
+	spin_unlock(&chip->lock);
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
+	spin_lock(&chip->lock);
+	__gpio_mockup_set(gc, offset, value);
+	spin_unlock(&chip->lock);
+}
+
 static void gpio_mockup_set_multiple(struct gpio_chip *gc,
 				     unsigned long *mask, unsigned long *bits)
 {
+	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 	unsigned int bit;
 
+	spin_lock(&chip->lock);
 	for_each_set_bit(bit, mask, gc->ngpio)
-		gpio_mockup_set(gc, bit, test_bit(bit, bits));
-
+		__gpio_mockup_set(gc, bit, test_bit(bit, bits));
+	spin_unlock(&chip->lock);
 }
 
 static int gpio_mockup_dirout(struct gpio_chip *gc,
@@ -112,8 +137,10 @@ static int gpio_mockup_dirout(struct gpio_chip *gc,
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
-	gpio_mockup_set(gc, offset, value);
+	spin_lock(&chip->lock);
 	chip->lines[offset].dir = GPIO_MOCKUP_DIR_OUT;
+	__gpio_mockup_set(gc, offset, value);
+	spin_unlock(&chip->lock);
 
 	return 0;
 }
@@ -122,7 +149,9 @@ static int gpio_mockup_dirin(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
+	spin_lock(&chip->lock);
 	chip->lines[offset].dir = GPIO_MOCKUP_DIR_IN;
+	spin_unlock(&chip->lock);
 
 	return 0;
 }
@@ -130,8 +159,13 @@ static int gpio_mockup_dirin(struct gpio_chip *gc, unsigned int offset)
 static int gpio_mockup_get_direction(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
+	int direction;
 
-	return !chip->lines[offset].dir;
+	spin_lock(&chip->lock);
+	direction = !chip->lines[offset].dir;
+	spin_unlock(&chip->lock);
+
+	return direction;
 }
 
 static int gpio_mockup_to_irq(struct gpio_chip *gc, unsigned int offset)
@@ -283,6 +317,8 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 			return -ENOMEM;
 	}
 
+	spin_lock_init(&chip->lock);
+
 	gc = &chip->gc;
 	gc->base = base;
 	gc->ngpio = ngpio;
-- 
2.20.1

