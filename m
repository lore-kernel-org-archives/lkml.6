Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35267C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F147E214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bzvT4yHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfA2Iou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:44:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55710 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfA2Io2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:44:28 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so16681359wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 00:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z770VfwimnPEUjTF5L5saIw2a2GAQPLZtqYgE1wTw+k=;
        b=bzvT4yHrth8hQqClKtQsifaxCoVXHOrRa/tm/EttPukcflaK6v6VJbAsiSewuJZRnE
         OjO4nJoSvgq8ARcsL6jICcHK2HOulaVYYHi4dasWveANeahgb5v/pw2+xKXUCDsjt2yc
         ZSQlgE72CSf0HvbtglIrNM+DsthNsg2hDFUFRf0wprj780mpvHeEdtJZNmQq0y9rI/uC
         EfAJfcXiFRzTh+LNEDxewsAi3CenCQgAigzGHcDdhLGqQo8vROCmmRj1V+hGXrUhGwwt
         1zPC88HLpmBxVEOQmElvSf5psKrQz0y6iElTJdofVgXvbC5FIlx/oFTB3cYo1iBbc2w1
         GIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z770VfwimnPEUjTF5L5saIw2a2GAQPLZtqYgE1wTw+k=;
        b=ZG1bHPcEabGj3MAhq7QN2F9z91U5agP26eHBIKpiY07/BKS9z+V6F7L+kmlqx0r52g
         hWTHA5vw9+0aPKcxgQuW/h08DqrdOYcYE/FrntuWlD3w33WA6f/epo0RvrJOIo/E6H6D
         zMMYzjp4fVUu58ztvMYdVkbTs51tOmB58JVXv+eqmQyEwEuUBvhP270xTsBkRLZJpqA0
         6yhi3YNkCxG81J8fMne0/L+qm40tCsy8tqQtf3X9u91dBhXTdIu6fWPX26Mne+jQsI1I
         MbsVhs+TMn96z5fiGAuyEn3nXXNUMQE117FxjG6gbWpV/RjQ2gLcTjwhuEfKd3lpR9/8
         GhpA==
X-Gm-Message-State: AJcUukc/Bs6QRlIMky4m79mPdtQzv3ki7phgYBYgrfLSRGBvyaWdUNkM
        fWi4N67nfDEQhg7RRY4tmZ6wEg==
X-Google-Smtp-Source: ALg8bN4mruzQd6zEc+el217ASavkSee1JAuNMSFZXAhxyd0xXW1X9glanCV3pnhFKMjG26Pg4U/edQ==
X-Received: by 2002:a1c:dd04:: with SMTP id u4mr20207089wmg.84.1548751466628;
        Tue, 29 Jan 2019 00:44:26 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id c1sm3979319wmb.14.2019.01.29.00.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 00:44:26 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 7/9] gpio: mockup: change the type of 'offset' to unsigned int
Date:   Tue, 29 Jan 2019 09:44:09 +0100
Message-Id: <20190129084411.30495-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190129084411.30495-1-brgl@bgdev.pl>
References: <20190129084411.30495-1-brgl@bgdev.pl>
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

