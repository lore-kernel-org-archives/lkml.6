Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A124C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD1921EFA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FZ+dmIhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD1921EFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732692AbeHITqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:46:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38442 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732432AbeHITqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:46:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14-v6so5800949wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 10:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GF32Bje0oJAW4XeP8mIAbg+OAE7k9UA39pRZeiSkJP4=;
        b=FZ+dmIhZlQcz0kpao5gO2k+08QBuZGit29vjGX6HxlGHF6NDVaw9xNgIPFqqnOBnJy
         Q+nCBblp4OhI7XsVKbeBxeqTeSwYAhFZ1G/xgyvs3By5sluJRot66KCwebPACisx1zEZ
         Nke8PFj/26ee5U2I+KFbkToWebSMH8AGKSLOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GF32Bje0oJAW4XeP8mIAbg+OAE7k9UA39pRZeiSkJP4=;
        b=NGFe6TSm5vP/Cmpg5ZlsLRHMb+ndxHBUCB383cYZJEUy1aTu3+xTO1yFytvkcaZup5
         bZ55bJT1U2Lzeza/XI0EvR1PtrXlQI6KpffvtzGex1QbR4fCZuBS/oxjoHMNJUKY+EmK
         x46LGqZZIXbSO/rsF8npsVQiYJw+6ooy1VTr9rbwEp2hFPYcrMaIBHiLrF8iUpcfUggi
         xiUU+kES0U6ErV2gV/xTV/lfSejIIgBABNk9juFaGVx/8lVb37NwIEsNZVPiKZPG8IqL
         84rwlwXIlGFauPbN4if45Tldinf1yNgm6hGHL5S0mJiKstABf3v3Xsy4U3ThwMsECpGc
         Kl4Q==
X-Gm-Message-State: AOUpUlGEZny6IT3sTzv4e7+HBMiJfuTR5qZXZONDf1OlH3yQXsPNp4au
        ZQOgMg7/WKQIsvD6PUIjVY+8qcL7OvfiDfBl
X-Google-Smtp-Source: AA+uWPwWSoeOw1sBh6X3LnbVMnjY3iVilUBHcpx07fmcOHHUST0lNpt6bMejqwvFyGdPLnrfC5LjyA==
X-Received: by 2002:adf:fdcd:: with SMTP id i13-v6mr1945680wrs.276.1533835222153;
        Thu, 09 Aug 2018 10:20:22 -0700 (PDT)
Received: from localhost.localdomain ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id u4-v6sm1815056wro.47.2018.08.09.10.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Aug 2018 10:20:21 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [RESEND PATCH v1 2/2] cpuidle: menu: Dismiss tick impaction on correction factors
Date:   Fri, 10 Aug 2018 01:20:03 +0800
Message-Id: <1533835203-5789-3-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533835203-5789-1-git-send-email-leo.yan@linaro.org>
References: <1533835203-5789-1-git-send-email-leo.yan@linaro.org>
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

