Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BA6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6047D20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vk0klhZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394105AbfAPPgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:36:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40849 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387867AbfAPPgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:36:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id f188so2431976wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 07:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6zLLpdXDNbxxW4MvbghkOOmp94mw3IDbzzKNrvQc84w=;
        b=vk0klhZ6jDRBn0Ys3f3UGTmN6Up/ouWL2pdlPiQfyqBhLVJvQm5L9dw6hRBMgfFpWb
         A3WAOlbqADlFFRIqXeqh/3qQ3++Pee62puQmiUxJ4gqabcGjQGyKIb4OK10mYj/VMu+N
         DNSfFLJ5mqTGsAp+g/5v5cgwVNFsImbRM8CakstEkYy41uzCqJoyJqkt6GtG6LRFN1lR
         lg3RM2RG6dgeJOmS1QoN62nhntZo1iCA3pzo/TKFCbiyQjgco2lcY1zj16PuMsmz56e3
         xMcj9SOFk1RYcAIsAex6exLsuOMvQk7P3jUGZZl98NIqmyk7d6i44md/7u6JxW+xe8Ix
         Beqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6zLLpdXDNbxxW4MvbghkOOmp94mw3IDbzzKNrvQc84w=;
        b=Hk0J5BeuCBmzyRvOz9QFZQDkVyB9dcHY+SCRMG9Mb0QG19hcIVVM32XDSG5PMAZx68
         OhANRk2FjkdBZ1GELa3TvHkk7beu6/xrcBIPafL0grU4Cgtq6cnh43lz2EVYhrjDvpgn
         lnrx4t63MbggI78dbNF53ub8/WPdBXjpM0RjTGDUh1cg4pOnNsHM/KePXy+Bt4ZzTRET
         +A8Q2mpd4ZZYeR6luGiinq0o1O03eYnXbC3qjUyp3zZxrEa8f2uRysulVDQ9CKbXL7T2
         nVt7oUmzX9clEn38/ujAQBySz7fHe3bmkxqLO0KOcz9yTzSHA8smxkACg+gqAW52isqd
         etBQ==
X-Gm-Message-State: AJcUukfXXjrduK8DY2/w7u/ZnC1Hn/6cWSrdt0ySo4g0H0Ax2iJgmpy4
        +4T9hGrl1pMXiXlEZeLuTWOkUA==
X-Google-Smtp-Source: ALg8bN4lYk1t7+n8iL8pjxFjUcZcw6iucvcpn/TXQu5/FAqHYPP91x/2mNH5m5hs2VCqsahQEEmc5g==
X-Received: by 2002:a1c:2c44:: with SMTP id s65mr8484233wms.80.1547652964990;
        Wed, 16 Jan 2019 07:36:04 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id c21sm28758364wre.71.2019.01.16.07.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 07:36:03 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH STABLE v4.19.15] gpiolib: fix line event timestamps for nested irqs
Date:   Wed, 16 Jan 2019 16:35:57 +0100
Message-Id: <20190116153557.13720-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Nested interrupts run inside the calling thread's context and the top
half handler is never called which means that we never read the
timestamp.

This issue came up when trying to read line events from a gpiochip
using regmap_irq_chip for interrupts.

Fix it by reading the timestamp from the irq thread function if it's
still 0 by the time the second handler is called.

Fixes: d58f2bf261fd ("gpio: Timestamp events in hardirq handler")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
Hi Sasha,

this is a backport for v4.19.y series. The original patch didn't apply
due to a conflict.

 drivers/gpio/gpiolib.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a8e01d99919c..b3ab6c428423 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -817,7 +817,15 @@ static irqreturn_t lineevent_irq_thread(int irq, void *p)
 	/* Do not leak kernel stack to userspace */
 	memset(&ge, 0, sizeof(ge));
 
-	ge.timestamp = le->timestamp;
+	/*
+	 * We may be running from a nested threaded interrupt in which case
+	 * we didn't get the timestamp from lineevent_irq_handler().
+	 */
+	if (!le->timestamp)
+		ge.timestamp = ktime_get_real_ns();
+	else
+		ge.timestamp = le->timestamp;
+
 	level = gpiod_get_value_cansleep(le->desc);
 
 	if (le->eflags & GPIOEVENT_REQUEST_RISING_EDGE
-- 
2.19.1

