Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF91BC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BCA217B7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aX0AT3kG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BCA217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389599AbeHGQmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:42:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39653 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389073AbeHGQmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:42:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so15974788wre.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 07:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GF32Bje0oJAW4XeP8mIAbg+OAE7k9UA39pRZeiSkJP4=;
        b=aX0AT3kGNzJQz68KD5g0XdNbHR9IF93ol2MzrLU9f2azNlqBmztQ3iAMwf00ZzDI4D
         whxX8tF35vHTiiaObpE0/aKhPu+Mk1NV/6cpToUUfpdHcmpKhq4VYHQSSOZuTwnnpWee
         KIYGdQSO5KwXYDMPSroFYnBrwsXJsZ2F3lIlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GF32Bje0oJAW4XeP8mIAbg+OAE7k9UA39pRZeiSkJP4=;
        b=NaGUyZOVmCGJ1z/N+jBKsi0fmDBCKjViK+ub8WHRZya4jX8j5ia9WIZ7/0qOci3Z4d
         soDhkYkup7e9acRqwXeJAIPJh2Lc2YL+jNbrJIw9jY267u5IFiD4udyUrhd/Wjd+YUv3
         krT7bM0eyWRJzewDlc+Nthb6F1zaGWKiYJEhamMJCapSy7CUbkVzo+QkkzyIcQeSC9WP
         9YZR66lV7o0umv/unaT6bRdgBofdC9lb6ExPw69i8jO2wGtyg65MnGAEeqQV9PRMFRcD
         WjYXnJOXart2vv2nqOXvGf1pliBddCpAdW+zw3XtVYoJ1/MP7FmqDqLE59q8NU+nJwtB
         /SUQ==
X-Gm-Message-State: AOUpUlEQ+vGsrIZQC06S+XCWdOzwmMgdVVRVqVst7DyFno4R4/I8sgwg
        8bi5LDzAlY3BtUleLBZEY8D9NQ==
X-Google-Smtp-Source: AAOMgpc0psOdxf+D/AahzcBE1BeAVwuetNP/huAJPVCvRjM63fGHDN2VW3nmV0dCY/M6B75MHm+8og==
X-Received: by 2002:a5d:434c:: with SMTP id u12-v6mr11890243wrr.189.1533652059331;
        Tue, 07 Aug 2018 07:27:39 -0700 (PDT)
Received: from localhost.localdomain ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id t13-v6sm1478787wrr.74.2018.08.07.07.27.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Aug 2018 07:27:38 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/2] cpuidle: menu: Dismiss tick impaction on correction factors
Date:   Tue,  7 Aug 2018 22:27:04 +0800
Message-Id: <1533652024-19078-3-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533652024-19078-1-git-send-email-leo.yan@linaro.org>
References: <1533652024-19078-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the idle duration predictor detects the tick is triggered, and with
meeting the condition 'data->next_timer_us > TICK_USEC', it will give a
big compensation for the 'measured' interval; this is purposed to avoid
artificially small correction factor values.  Unfortunately, this still
cannot cover all cases of the tick impaction on correction factors,
e.g. if the predicted next event is less than ITCK_USEC, then all
wakening up by the ticks will be taken as usual case and reducing exit
latency, as results the tick events heavily impacts the correction
factors.  Moreover, the coming tick sometimes is very soon, especially
at the first time when the CPU becomes idle the tick expire time might
be vary, so ticks can introduce big deviation on correction factors.

If idle governor deliberately doesn't stop the tick timer, the tick
event is coming as expected with fixed interval, so the tick event is
predictable; if the tick event is coming early than other normal timer
event and other possible wakeup events, we need to dismiss the tick
impaction on correction factors, this can let the correction factor
array is purely used for other wakeup events correctness rather than
sched tick.

This patch is to check if it's a tick wakeup, it takes the CPU can
stay in the idle state for enough time so it gives high compensation
for the measured' interval, this can avoid tick impaction on the
correction factor array.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/cpuidle/governors/menu.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 2ce4068..43cbde3 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -525,15 +525,13 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 * assume the state was never reached and the exit latency is 0.
 	 */
 
-	if (data->tick_wakeup && data->next_timer_us > TICK_USEC) {
+	if (data->tick_wakeup) {
 		/*
-		 * The nohz code said that there wouldn't be any events within
-		 * the tick boundary (if the tick was stopped), but the idle
-		 * duration predictor had a differing opinion.  Since the CPU
-		 * was woken up by a tick (that wasn't stopped after all), the
-		 * predictor was not quite right, so assume that the CPU could
-		 * have been idle long (but not forever) to help the idle
-		 * duration predictor do a better job next time.
+		 * Since the CPU was woken up by a tick (that wasn't stopped
+		 * after all), the predictor was not quite right, so assume
+		 * that the CPU could have been idle long (but not forever)
+		 * to help the idle duration predictor do a better job next
+		 * time.
 		 */
 		measured_us = 9 * MAX_INTERESTING / 10;
 	} else {
-- 
2.7.4

