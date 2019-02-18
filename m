Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A169CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F43C217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="fI3dk0Lo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfBRJsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:48:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34593 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729804AbfBRJsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:48:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id f14so17643975wrg.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 01:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1WGhX7lh3GClMJMpleuT6xjtmXeQaabY429BNB+za3s=;
        b=fI3dk0Lob3xVbOYh7vzW0vq9bEuK/+s1OUeeKYrnDIb8Sgsp9YpQrICs0mJxhrKsRh
         VxpHD2W4zSc+qoHMMmxRKF6gLs+SyDiHsEte789h4JoKxLv4EY4zaB12KAWkVC6YT7RR
         lxduIXKNh87hMY/7D/j/piiIab1ZHkXFNhbLTUDeu3W465x57tWv9zAWtBxgGtF95hYn
         2oEEQu5zPVVK3hpF2pi+rMmBz5b9GEnS8gQr1d5zxrN3dVsn40z3it9cDre1eE6M3WcH
         xHBi0bkwLEnMHeUCy/VD9Eiv/1ZS7F8ujBKlQS6HBRASz1Jws4nEY1pfy+zcyyGSm7GP
         V7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1WGhX7lh3GClMJMpleuT6xjtmXeQaabY429BNB+za3s=;
        b=L6UoD3kb+5j1mKX2aOnkdhpqbZzmET4F4OqvpqvDiFMtYKq+leC3+/jOaUtnCPttt8
         OnXs7ns4hO4LBZPvIpwDoB3M/XYRnNAnJHAJTSDJupCgQkahae/sc/06kErKMgt7Wj7F
         /WIjgkDsvVHI2Cq6mDm3v9+yCOMF1OB/FQ9u3NZxznPYlUGxt4+QmZkBd5yW2KZ8lq92
         0UWvl89N8SRKLHpysXaYjn1NHz7nPurPIY4uGk1ACiid6TMazlXI053K5mZJAc1pRb5s
         gaPPXdtEs9E5BFCMnVDx5vadLM62Y6dT0bP6wQiTBVyxxDfjS3YaLe+fp2zaU8CIOeeQ
         8QUQ==
X-Gm-Message-State: AHQUAuYXHQffv5s7xbQXyaLM6mVvME4T29Iveu4UNo1h0qLRvFwIQ1xn
        4ZygXtsadKqMnhkaWZUwORqcqA==
X-Google-Smtp-Source: AHgI3Ib8PfbRy3qztrVKCsYCt4fFN0/vUhm8E2E56/IzjtVA6L6aAC8Kn/MgRGuiUmtSVKfRCn8nLw==
X-Received: by 2002:a5d:44c3:: with SMTP id z3mr15470004wrr.329.1550483290596;
        Mon, 18 Feb 2019 01:48:10 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-7-43.w90-86.abo.wanadoo.fr. [90.86.124.43])
        by smtp.gmail.com with ESMTPSA id u15sm17582974wmu.17.2019.02.18.01.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 01:48:09 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/6] gpio: mockup: implement get_multiple()
Date:   Mon, 18 Feb 2019 10:47:55 +0100
Message-Id: <20190218094759.14545-3-brgl@bgdev.pl>
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

