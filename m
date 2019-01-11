Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CE1C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CA520874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gDSadxU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbfAKRny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:43:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52890 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731396AbfAKRnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:43:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so3192315wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=73ZZ4fNLAhFNtb9hEaivYNzAY6zrbpKkLXaUVSUSU2A=;
        b=gDSadxU1et7O7+rVNReKBU+SI2e8zUA3yfc/XNGLlC+37bmoxWI8LiIebDH1uLpH5Y
         gF6DlxelE0/ELmF7X2OgthLI9ia/jwp6ymv62MUZ4ZRtX5cwu31n6vxKoD+zl2ZCyDAt
         S1ybI2b25oO3j8HcV2zrh6k1wf99fKhM//ZFfHay97U25cuhspeF7qb9EOuohfX7LR0B
         lpgwt69YNR7qndQwRLEIbd0jMIhLmvY66T4v4sCg1bYfYt+SMs1Qbq/oLlmsL9iwuIbL
         eIiMfGhbQLPbas6YcEBwTbbDrtiwigRfy1qBmLomdbgfM08sYT2euvcK1hXlvgcfZdl2
         tZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=73ZZ4fNLAhFNtb9hEaivYNzAY6zrbpKkLXaUVSUSU2A=;
        b=mEEjCozt8gMYndUvD7JjgzkJa0WTVABglgoJJGRr6l4I4Cht8KJ2QaXvE+YoydbdO3
         hF9ULyGOyyc8DMq41tXz8ltzFxrpMlIuU/6J+zRdIrFW+9shvbRZHUFknh1C9+AXp/La
         SvGbxp3mX0DBo0pe0fq3IX8mVjsglUqdgZfb7rl3nvC4cNf/DngxfeoKl3yO7j9IIi+K
         yW2s4hR6MafxAhnLdHWPKA44F0Pc4oGanf6kqpMarcuEeMFptpRGL1f8eY8WE9aS7xhs
         SLnQm5cYSibkj6qZjY8VdDGJEgMAvaJzJfhAH2/aG0hb/G64Z5JNH02W2vynh5xmZYnA
         TllQ==
X-Gm-Message-State: AJcUukf7RVE8FZo1VG37YhskiNArHCKL35Xfi1pKKvv4Js+fInUOEPBv
        2k68GQQ9kwSVyQL0W3huVsS5Cg==
X-Google-Smtp-Source: ALg8bN4uZgkSLTUZjmvBnlIS/Jvw6R9aKNb5wnDZ69Gs5lGAJRYK+eaI4Z0eUcUnUkM1GS/4vEjSHw==
X-Received: by 2002:a1c:f509:: with SMTP id t9mr3337128wmh.76.1547228631152;
        Fri, 11 Jan 2019 09:43:51 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id 129sm28839338wmd.18.2019.01.11.09.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:43:50 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] gpiolib: fix line event timestamps for nested irqs
Date:   Fri, 11 Jan 2019 18:43:47 +0100
Message-Id: <20190111174347.25040-1-brgl@bgdev.pl>
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
v1 -> v2:
- add Fixes: to the commit message and Cc stable
- directly assing ktime_get_real_ns() to ge.timestamp

 drivers/gpio/gpiolib.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 1651d7f0a303..d1adfdf50fb3 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -828,7 +828,14 @@ static irqreturn_t lineevent_irq_thread(int irq, void *p)
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
 
 	if (le->eflags & GPIOEVENT_REQUEST_RISING_EDGE
 	    && le->eflags & GPIOEVENT_REQUEST_FALLING_EDGE) {
-- 
2.19.1

