Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD2AC46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 16:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CC1219C4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 16:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OSxffkp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CC1219C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbeHLSsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 14:48:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41839 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbeHLSsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 14:48:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so12208866wrr.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 09:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V18Yg/vtevZ0nWVd2TxyiDMrqJoQAluOHbayWFvQXps=;
        b=OSxffkp8NwJyPYpiwF1fIiewerSpTUDVO903chrUq34Ei11KpkKTlPdZubWBo51/Q7
         GbrHWJSKaJBzEnXyCV+jI7+Nrezo1178q/h9F6MM14Cop3As8v5NX8aezc3DOGnsm8xo
         xrYwzUbUVOBGD9k9dvoB0LKsbG5Sxb1gTh22o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V18Yg/vtevZ0nWVd2TxyiDMrqJoQAluOHbayWFvQXps=;
        b=DsYrSHTohqjLpdk7NqHoNzKCbf2uf+PDc9QtmLLI/lr/DIZFbSlBblLXojUvDW1LW9
         kJ3xanrzLaj/VzlkorqPRChEXb14LMU4Y+rGYwtLLS0BESagB6XBh0GI6Ov6/t8hXczW
         3Y7b6VOozS+anF2ANuU1vUwWEqIHCVTgc56XD2UrawZqv2u/lsD+DeRHCxXuv+UdF5Lk
         81oYFr4+5Lx6HAKODsiYcpfiXmW0liEIpPfqPPE9HtJdrkK1/FL9wfZNSN97xzM60yez
         Emp4Va4DhMnteGMVeoD7TJWk7s4bC1vGV0/6Ypne+HhfkfAEMPKEDlPvhuHGTg09iCE6
         4gbA==
X-Gm-Message-State: AOUpUlEZKQaJ03wPZSwYZKJ2MstjU+lex8HDElVwZXU3L3yIgUdLeIjM
        jyUnaWB+Mr16VqJuqS+DpbUJWA==
X-Google-Smtp-Source: AA+uWPzw35FdQt+zWdjk80+9C6z2ADA9CZMw40hg2gNSVOnmMHebG6LDNWqmFukwn27mOuwUBUdfmA==
X-Received: by 2002:a5d:458b:: with SMTP id p11-v6mr8555372wrq.122.1534090199872;
        Sun, 12 Aug 2018 09:09:59 -0700 (PDT)
Received: from localhost.localdomain ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id t6-v6sm7437369wmf.8.2018.08.12.09.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Aug 2018 09:09:58 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/5] cpuidle: menu: Record tick delta value in struct menu_device
Date:   Mon, 13 Aug 2018 00:09:28 +0800
Message-Id: <1534090171-14464-3-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534090171-14464-1-git-send-email-leo.yan@linaro.org>
References: <1534090171-14464-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the tick delta is used in multiple places in menu_select(), it's
better to use single one variable to record this value; furthermore, for
more readable we can refactor the code to split a separate function to
making decision for stopping tick, which also needs to use tick delta
value as one metric for consideration.

To achieve these purposes, this patch adds a new item 'tick_delta_us' in
struct menu_device to record tick delta value.  This patch also is a
preparation for optimization stopping tick in sequential patches.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/cpuidle/governors/menu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index b972db1..83618ab 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -124,6 +124,7 @@ struct menu_device {
 	int             tick_wakeup;
 
 	unsigned int	next_timer_us;
+	unsigned int	tick_delta_us;
 	unsigned int	predicted_us;
 	unsigned int	bucket;
 	unsigned int	correction_factor[BUCKETS];
@@ -305,6 +306,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
 	/* determine the expected residency time, round up */
 	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
+	data->tick_delta_us = ktime_to_us(delta_next);
 
 	get_iowait_load(&nr_iowaiters, &cpu_load);
 	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
@@ -317,7 +319,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	 * timer event for the idle state selection.
 	 */
 	if (tick_nohz_tick_stopped()) {
-		data->predicted_us = ktime_to_us(delta_next);
+		data->predicted_us = data->tick_delta_us;
 		goto select;
 	}
 
@@ -400,11 +402,11 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	 */
 	if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
 	    data->predicted_us < TICK_USEC) && !tick_nohz_tick_stopped()) {
-		unsigned int delta_next_us = ktime_to_us(delta_next);
 
 		*stop_tick = false;
 
-		if (idx > 0 && drv->states[idx].target_residency > delta_next_us) {
+		if (idx > 0 &&
+		    drv->states[idx].target_residency > data->tick_delta_us) {
 			/*
 			 * The tick is not going to be stopped and the target
 			 * residency of the state to be returned is not within
@@ -417,7 +419,8 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 					continue;
 
 				idx = i;
-				if (drv->states[i].target_residency <= delta_next_us)
+				if (drv->states[i].target_residency <=
+				    data->tick_delta_us)
 					break;
 			}
 		}
-- 
2.7.4

