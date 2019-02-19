Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B3BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5101321902
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZXmSZc8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfBSQHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:07:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40434 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbfBSQHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:07:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id t15so3323836wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 08:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KudoSL2eX7oA8yYhs/QJyb1yYcVSQLsZjpboPNVdhXI=;
        b=ZXmSZc8ZBRyYpknUWf1ePL65IQi0O7h8xp3kpuc/+FhAIDjxuhEWmB50EhfdC3TKaD
         NrswTZsYvnhHGJpz+Alq90Vyy1LQQFccJRiTZaoEXjphzu9AWJ8yULiOxBqO4IRman5L
         ie9UvxYvO9Yl69zmHNCVsKQnFqeN0B9ahFhhE1HXoKjjIIBhzsn6h5jR5jHreZnbcfHT
         Vhx9ElWBhz57MmucR9vXeqAoGH8xXD0ciOQXJUicpnZRPRGe8JYShUz4c38LKRsdF7/o
         5fodf7Aqu1qotFHw/MiJlrdMRPoHzTcJHED6Z1oxUznnqFgvopJymjffVNKW3GLEdqG1
         InBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KudoSL2eX7oA8yYhs/QJyb1yYcVSQLsZjpboPNVdhXI=;
        b=clWLoRMh7zIiUB+wXJ5WObbJqieGRP9zuHY2dGy2awFpnjP2pzq709KHsJ0y9+055P
         tIOTUkxC02ayJwdVr/8m0IkHr16bJBhTw7Z9qILmL81RYxnRb1XVf+t3qcUjvWkUGKIE
         pAOGMcuW3BuZvxXdlXrSASt4hKPthOVI/XJdUnnTYborKPDRvMGZXxJpCguHQOKRlKmR
         sNURp/2EGJme9ouasx56oRzxGKwOQnJaPx7sYlrWv6ytkHC1H6x5pi8l6vp/2m/tbCLo
         pVohImjNHoaNSZadg2cwAMJMNOSV+YwNQ6M4K0BVKD+PaXT89O1P9ERgHrdfIKnIahVl
         oE/w==
X-Gm-Message-State: AHQUAua+9xZ3br1JwRfZjhYFRrjeW2y+8SwiG/F2BVpxwDpr5i5eKF9L
        bQZCfVAynytCD9i3lY1YTIkCog==
X-Google-Smtp-Source: AHgI3IZBAO4WC1k0fn2wKEr4NL8X+sLa/jvuRc4ICoQLnw2y8bEpSSsrGJ7g2DPVF/J29v2fE10sEA==
X-Received: by 2002:a1c:2d42:: with SMTP id t63mr3579161wmt.9.1550592418361;
        Tue, 19 Feb 2019 08:06:58 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h17sm12161381wrq.17.2019.02.19.08.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 08:06:57 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v6 2/7] gpio: mockup: add locking
Date:   Tue, 19 Feb 2019 17:06:45 +0100
Message-Id: <20190219160650.9614-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219160650.9614-1-brgl@bgdev.pl>
References: <20190219160650.9614-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

While no user reported any race condition problems with gpio-mockup,
let's be on the safe side and use a mutex when performing any changes
on the dummy chip structures.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
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
2.20.1

