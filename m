Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05066C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95B620870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oCKWYjVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfAWOP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:15:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50720 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfAWOPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:15:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so2155729wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 06:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z770VfwimnPEUjTF5L5saIw2a2GAQPLZtqYgE1wTw+k=;
        b=oCKWYjVVwVFKVwJgc+LY6lR9zTKix2d5fs4v7joJxm0kxkWNdZNnG15w0kbLjXUNZy
         ArSH6985R1J604kDYcghQiRrwz1Prp8OpcdwTFj76+kWeA1+rr7c2TxE7FWPL4XZ1MIC
         BzfoQHBiM/TyB0a8XHZjJdgt0k94sg+1P7G5y0KQZC3+j9SvpywA2OqynNOMxoUR9Ui7
         rCjhny93Hskzf+HYRgsL8Xus3nHizplpEHYJeWdHTRGiDf2TlorOrrF5L3Q+uQPTYyIB
         TuPoXjRRjt/BT73lEeLtXbxjiFADR8WQ5TMD3+w8LEUffSASLCOSUCyYBoYSKFQv6Vi8
         OAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z770VfwimnPEUjTF5L5saIw2a2GAQPLZtqYgE1wTw+k=;
        b=f0JACzCkdVxnozmSXAdqxvjxVWHe2iTxFpUDrOY+LeRh9fwVQQk1vRTeo1gTtEkhsq
         9hVKyJx0Z1x0GWKroDt3JcmUMtOePndBa9dZ3uJLygxT/rmJyVyf//gEpSO8ZMy0ZVPm
         kyABqnXiB8L/eS/NFiaFlngGYsWQsS0hjhNGewMxBxsWw5GR2NhQEjnRqXyHJ9kaA2zx
         5W1zSx5IWD38UFe7VYbtlpf1yKpQKjN8pYHJvYAcZEfNKkF+pujRLYowMxMT/zTX/b2z
         PQDYrzuWtI7MgRZYZ2qh6NUQaqGLqoSHPjgCuckNbKjFAFpLOq3zklHdgnGZeCqgNecO
         H6ig==
X-Gm-Message-State: AJcUukdTvw+LMYUMYYq3BE1sKYGMOEq1ZLWrcj7am5pk/ieZJogLZbOP
        9Tca57ZU8KvW6Iq1rbYU9ydJ3w==
X-Google-Smtp-Source: ALg8bN6ZiIfPXtdkG7rpCXLW/usPBmqSFbV0Sh0oYZeS++iEImwmFIASPZk8ESEDZiJUEnbcYz4qPg==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr2979096wmi.144.1548252954021;
        Wed, 23 Jan 2019 06:15:54 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a8sm29072997wme.23.2019.01.23.06.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:15:53 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 7/9] gpio: mockup: change the type of 'offset' to unsigned int
Date:   Wed, 23 Jan 2019 15:15:36 +0100
Message-Id: <20190123141538.29408-8-brgl@bgdev.pl>
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

This field can never be negative.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 0317917a3678..433adb3b4617 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -60,7 +60,7 @@ struct gpio_mockup_chip {
 struct gpio_mockup_dbgfs_private {
 	struct gpio_mockup_chip *chip;
 	struct gpio_desc *desc;
-	int offset;
+	unsigned int offset;
 };
 
 static int gpio_mockup_ranges[GPIO_MOCKUP_MAX_RANGES];
-- 
2.19.1

