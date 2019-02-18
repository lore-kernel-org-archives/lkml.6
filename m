Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C46C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77BC2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="dkbhbAiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389981AbfBRQlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:41:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45151 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389813AbfBRQlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:41:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id w17so19047562wrn.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 08:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KudoSL2eX7oA8yYhs/QJyb1yYcVSQLsZjpboPNVdhXI=;
        b=dkbhbAiN6Gcg0WRtWSknmcHvG9xqvmOYTsBWVx3dMX6LjDB8IoFKqmAPOC5LtzEBkm
         VO+Klv5dJRHUb1qYnjY+/dD27f4UaERMH3nAZsg8Bd9QQTtFHTrI1+gkY5m/AQudTPwI
         AmB89U7rBc4PQmc6lhnUhz0VslS9zaj7Lz+Tn9i9qT0pfWBF74ZfRVeaqi437H0zfiVt
         ySBNScdtpocg+xJQmmfJ6G9E6OkPC0IhsOT2kxMV5AdiBKhVEIDrERIDwS36USFbYe5u
         Haw8t/C92SyEiTZGp1XyzPtNBISO+4PsjnQhDYFCCtzj4MOpO5b2Xyr4mfGpEA2M509G
         bPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KudoSL2eX7oA8yYhs/QJyb1yYcVSQLsZjpboPNVdhXI=;
        b=ac+wuRP9ZrRu4SyFrjHGAHcRK2j5b7V0qCrWm1crkd7AHz4lBUB+0W2pTOQkL1Xy+R
         YN7IubKoXDAKdHY1avvLXrvb95YrOGHbhxi7Z6UfLV3CNtTeeVRfsJlBEg6hq42IOF4K
         AdEmRIZj8WvDGOAzSZ9/ZGYqGtDf92bi6m/pbPrsj1dHm4SHaQExbLL4bTCz3BVqw8Sj
         oyUQwFMWtW5FGMR8FrG67T8dxxoOUODpajalLnFO4U83yWlmr8YwfH7KICeNYnzGP9P7
         jP7fLOFZ6PhlometNS7CjyCrOq6j6RuFlw530eq5as0wAKxEJMsydHeigFWQSSuwdUkk
         0jyA==
X-Gm-Message-State: AHQUAubd5YwEYvWy9QJpzsNf/PeiqJYwuAP+20ftapNgVIZyqjUSBx20
        iKX6D/cqUvjEzyf9NmguxtbkzR+tko8=
X-Google-Smtp-Source: AHgI3IaWOnW2ugeey0a7+QH0IYxx9j/DCUl+ftVanFEesNP8eAIAlqWzz4TnVBbmWwevFg6UgSe6VQ==
X-Received: by 2002:adf:f00b:: with SMTP id j11mr17166314wro.57.1550508104664;
        Mon, 18 Feb 2019 08:41:44 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-7-43.w90-86.abo.wanadoo.fr. [90.86.124.43])
        by smtp.gmail.com with ESMTPSA id w10sm6325442wru.5.2019.02.18.08.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 08:41:43 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 2/7] gpio: mockup: add locking
Date:   Mon, 18 Feb 2019 17:41:33 +0100
Message-Id: <20190218164138.24921-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218164138.24921-1-brgl@bgdev.pl>
References: <20190218164138.24921-1-brgl@bgdev.pl>
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

