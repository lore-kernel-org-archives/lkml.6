Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD22C46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 16:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6430219C4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 16:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aqw4vA0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6430219C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbeHLSs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 14:48:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53849 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbeHLSs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 14:48:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id s9-v6so6473898wmh.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7syOievGKU1gnJa8oh05y8DUlQgWF5NjJ3xt3wLMcp0=;
        b=Aqw4vA0xT3WxMfTUxnd2mwPWd8CNO/XKIvCXki9jTDnHbOsEpUGb8lNr5DxnTeREod
         RtqC2bdKn0+llD37F45FFVZkE3+SCLiR5wyX/knNX9M8hLOei8vErZgtXqz8CuzNhE1W
         OtoVDdXcF8fJUARQ4SjmDJL1uS57JPBz+gdfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7syOievGKU1gnJa8oh05y8DUlQgWF5NjJ3xt3wLMcp0=;
        b=GfMFuxMZ2VLWTqK3ZFcWjHVWqWwimw/gTaqSDnLuK6kqt0krRbu8tyNSRbee6IyVY9
         TtDUNqMgSLAjdRANYqMUaDyUh0Ka3fakKZG5KQ4jClBacVWcOIaGSNd6gyKnF1qPN02G
         3vHO8CwFukgsQHufYBL0nj1OErP0zCoGPcgkvQPhiwDMPxTS1rfY8gty/HhhqsGCXzNp
         U3UJD+88lA4mK4aTTRYUf7pKQUxk5Hhe9rZLYeItmHU/zppnifltWV0X/okoxygKmvOb
         A5es1nrASyQFcSlLl5K35ERRrBn7wklEK7y3ixIoTluN9sOs5fDqYblbg595hW85XF+j
         k3uA==
X-Gm-Message-State: AOUpUlG2b4Z7J3Sb18GTCpe0LspnbU12EBuMfkm3hKdxzP8zSvBa5u+x
        38jC68VZr4npmqJUPVg5EY/XWg==
X-Google-Smtp-Source: AA+uWPw7s5O072Udhi0wx1PE6Pr4V4AHd6MaUxCYSajv11b1UuYlphjFpTQ/V31jboWyqOhGW9JodQ==
X-Received: by 2002:a1c:28c2:: with SMTP id o185-v6mr6159731wmo.40.1534090195777;
        Sun, 12 Aug 2018 09:09:55 -0700 (PDT)
Received: from localhost.localdomain ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id t6-v6sm7437369wmf.8.2018.08.12.09.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Aug 2018 09:09:55 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/5] cpuidle: menu: Clean up variables usage in menu_select()
Date:   Mon, 13 Aug 2018 00:09:27 +0800
Message-Id: <1534090171-14464-2-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534090171-14464-1-git-send-email-leo.yan@linaro.org>
References: <1534090171-14464-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage for two variables 'data->predicted_us' and 'expected_interval'
in menu_select() are confused, especially these two variables are
assigned with each other: firstly 'data->predicted_us' is assigned to
the minimum value between 'data->predicted_us' and 'expected_interval',
so it presents the prediction period for taking account different
factors and include consideration for expected interval; but later
'data->predicted_us' is assigned back to 'expected_interval' and from
then on the function uses 'expected_interval' to select idle state; this
results in 'expected_interval' has two different semantics between the
top half and the bottom half of the same function.

This patch is to clean up the usage of these two variables, we always
use 'data->predicted_us' to present the idle duration predictions and
it can be used to compare with idle state target residency or tick
boundary for choosing idle state; we purely use 'expected_interval' to
record the expected interval value, which is mainly for interval
interrupt estimation.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/cpuidle/governors/menu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 5eb7d6f..b972db1 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -363,7 +363,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		latency_req = interactivity_req;
 
 select:
-	expected_interval = data->predicted_us;
 	/*
 	 * Find the idle state with the lowest power while satisfying
 	 * our constraints.
@@ -386,7 +385,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 			 * expected idle duration so that the tick is retained
 			 * as long as that target residency is low enough.
 			 */
-			expected_interval = drv->states[idx].target_residency;
+			data->predicted_us = drv->states[idx].target_residency;
 			break;
 		}
 		idx = i;
@@ -400,7 +399,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	 * expected idle duration is shorter than the tick period length.
 	 */
 	if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
-	    expected_interval < TICK_USEC) && !tick_nohz_tick_stopped()) {
+	    data->predicted_us < TICK_USEC) && !tick_nohz_tick_stopped()) {
 		unsigned int delta_next_us = ktime_to_us(delta_next);
 
 		*stop_tick = false;
-- 
2.7.4

