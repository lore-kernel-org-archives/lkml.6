Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D01C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D83217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="P6FcZXhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390024AbfBRQlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:41:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45155 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733255AbfBRQlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:41:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id w17so19047636wrn.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 08:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1WGhX7lh3GClMJMpleuT6xjtmXeQaabY429BNB+za3s=;
        b=P6FcZXhquM9/aAoB0WzXCs/+tvhTlKD4swvjDljYHre3gInE7yXRHz4KjWkN6JL8dI
         Nl2wHNcvbKDG5fW9nlOyjq/g4TBAhR5XEi1bU1NiKgtIFt57ehH99cSv96NrMO2IowJ7
         MwUrbswlr9vBKl+MXpkEM/TH7LDCMARY5YmLFWWIPppAdg3djLNLRQGrrbp+QppNHPNF
         WHXPw3SMF0UDIiWOJAtkOW0zBnudcI6hjParwxYHVIEy22jP50VnhVK71o7incyMA4NO
         6u4d/KkV67U07UZBfdbUHM8VvwmgDrHG8u8Fj3AwoRdOfT5bIaDBUO4TCLXbvRIi50fj
         EkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1WGhX7lh3GClMJMpleuT6xjtmXeQaabY429BNB+za3s=;
        b=EtUULQo6dHselDAHZnX1haZTO+mx8blp3DjrbK0S40sN09EUlFTm4/yyAVeHqrhiGp
         gFHpph2Bh57j0Q5ZDjQ3T3QE+/0e03PLiBHXuOGZwODQWtKOxPeavLOBWqNFhxNdrxIY
         p0BuvQ4G6wH804qHmWapI6s6x/HN3R+Kmoe3KZKkFqdvtDnSQdSlijIs8bWUZhPSZWJR
         Wf9QglP02nFNFZNlVlwecVd/1wqwpfb6Rd/JkaMKvyoOknIuuGXRM69x+18u2bndpFD5
         NQs1+2U1KjBuA7bhRwTPPhJ8ZBVdcZbv9nrzGkeTWSLudlAvCBq0dKv8IcCOWm/qK69p
         h6WQ==
X-Gm-Message-State: AHQUAua2lRtiB3ix+RKeZTf7j8UQemgORmRIs1sauKX1w+dyDm9bCqn2
        njSac1jn3IsyWnfOJJDYTb/tMA==
X-Google-Smtp-Source: AHgI3IZoHAj+YKT6Uwibi1oy0jsrMMq8Fi/LeTaXub0CsZ0wKtbxqfo/elJwkD8yXY1Kp3r/PPsNgQ==
X-Received: by 2002:a5d:4686:: with SMTP id u6mr18227506wrq.206.1550508105746;
        Mon, 18 Feb 2019 08:41:45 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-7-43.w90-86.abo.wanadoo.fr. [90.86.124.43])
        by smtp.gmail.com with ESMTPSA id w10sm6325442wru.5.2019.02.18.08.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 08:41:45 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 3/7] gpio: mockup: implement get_multiple()
Date:   Mon, 18 Feb 2019 17:41:34 +0100
Message-Id: <20190218164138.24921-4-brgl@bgdev.pl>
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

We already support set_multiple(). Implement get_multiple() as well.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index b4c1de6acf74..1c945c967f60 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -102,6 +102,22 @@ static int gpio_mockup_get(struct gpio_chip *gc, unsigned int offset)
 	return val;
 }
 
+static int gpio_mockup_get_multiple(struct gpio_chip *gc,
+				    unsigned long *mask, unsigned long *bits)
+{
+	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
+	unsigned int bit, val;
+
+	mutex_lock(&chip->lock);
+	for_each_set_bit(bit, mask, gc->ngpio) {
+		val = __gpio_mockup_get(gc, bit);
+		__assign_bit(bit, bits, val);
+	}
+	mutex_unlock(&chip->lock);
+
+	return 0;
+}
+
 static void __gpio_mockup_set(struct gpio_chip *gc,
 			      unsigned int offset, int value)
 {
@@ -327,6 +343,7 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 	gc->parent = dev;
 	gc->get = gpio_mockup_get;
 	gc->set = gpio_mockup_set;
+	gc->get_multiple = gpio_mockup_get_multiple;
 	gc->set_multiple = gpio_mockup_set_multiple;
 	gc->direction_output = gpio_mockup_dirout;
 	gc->direction_input = gpio_mockup_dirin;
-- 
2.20.1

