Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CE5C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 16:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44397219C4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 16:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WqWRK+Eh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44397219C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeHLSsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 14:48:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46046 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbeHLSsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 14:48:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id f12-v6so12186691wrv.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 09:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v4mRTz9lovuOcDxlp6+85Pwdka+3yYASS/8Q6JA5+Fc=;
        b=WqWRK+EhooOB8zO22jSGNKLlVuQnJLQ/RdvK4jHkVx663qtYtx2pnnwr0ncjiKn4UT
         E8tsB8HHZY+h5E/9abCtSeoATObCAafU+7IGV8372NNjcD+zy+GnTZL0StXLKcEofsaQ
         mSgTXhXyW2pnU+NyrCaJL3n3vMei/pkXGIsmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v4mRTz9lovuOcDxlp6+85Pwdka+3yYASS/8Q6JA5+Fc=;
        b=OgvKuHJIZhX2STj13I3BeuoweiopORYk2g+aQhtmz1cx2QNFblkASGDd7Wg3t6dExA
         Mckv5va0rgRyrs2tZe23zjaq5xdKnr+fZEJ7JbhebTICtmM5W3iHM5gqkGE4ZBGyMMSN
         qz4MsDgSoepjbQnIenx9qWZ1TPleruwTSoodK9tiTP0QPgTmhWZqRE8ctVdgMmblt1Sj
         92gkxVtt+lySmsOfPbif86hrxu1Xjqflm5zwDdwo1UyHKrnOh23upZYvgbFCUo/OdNpf
         8QXZ/aKZuX/skKMBhM+YOPvrFV66nIst7Pbc8EZMXj74QXpCeFCMlRsogXCA7NR+Z8WU
         S40w==
X-Gm-Message-State: AOUpUlGCYeKqKu/9AJ6SitdUgo6AbFfVWwyuvnifTnhzDnAQuj/5R6SD
        RfW+FS778Vh6OgCsHNiITieZ7A==
X-Google-Smtp-Source: AA+uWPwWAsKnnJ1jdYBxN7Nmjypuk1Jn2ShEhyFcS1RABpYB+XM73Jn1OFvN2KU0+X9WaiJk2G5bnQ==
X-Received: by 2002:adf:9261:: with SMTP id 88-v6mr8159181wrj.62.1534090203670;
        Sun, 12 Aug 2018 09:10:03 -0700 (PDT)
Received: from localhost.localdomain ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id t6-v6sm7437369wmf.8.2018.08.12.09.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Aug 2018 09:10:02 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 3/5] cpuidle: menu: Provide menu_decide_stopping_tick()
Date:   Mon, 13 Aug 2018 00:09:29 +0800
Message-Id: <1534090171-14464-4-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534090171-14464-1-git-send-email-leo.yan@linaro.org>
References: <1534090171-14464-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is only for code refactoring and without functional change.
It introduces a new function menu_decide_stopping_tick(); we can use
this function to focus on making stopping tick decision.  With moving
out stopping tick decision code, it lets the below piece code is
simplized only for the idle state calibration and thus save one indent
level in the loop.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/cpuidle/governors/menu.c | 76 ++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 26 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 83618ab..4f02207 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -276,6 +276,37 @@ static unsigned int get_typical_interval(struct menu_device *data)
 }
 
 /**
+ * menu_decide_stopping_tick - decides if need to stopping tick
+ * @drv: cpuidle driver containing state data
+ * @data: menu_device structure pointer
+ * @idx: the candidate idle state index
+ */
+static bool menu_decide_stopping_tick(struct cpuidle_driver *drv,
+				      struct menu_device *data, int idx)
+{
+	/*
+	 * If the tick has been stopped yet, force to stop it afterwards and
+	 * don't give chance to set *stop_tick to false.
+	 */
+	if (tick_nohz_tick_stopped())
+		return true;
+
+	/* Don't stop the tick if the selected state is a polling one */
+	if (drv->states[idx].flags & CPUIDLE_FLAG_POLLING)
+		return false;
+
+	/*
+	 * Don't stop the tick if the prediction is shorter than the
+	 * tick period length.
+	 */
+	if (data->predicted_us < TICK_USEC)
+		return false;
+
+	/* Otherwise, let's stop the tick at this time. */
+	return true;
+}
+
+/**
  * menu_select - selects the next idle state to enter
  * @drv: cpuidle driver containing state data
  * @dev: the CPU
@@ -396,33 +427,26 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	if (idx == -1)
 		idx = 0; /* No states enabled. Must use 0. */
 
-	/*
-	 * Don't stop the tick if the selected state is a polling one or if the
-	 * expected idle duration is shorter than the tick period length.
-	 */
-	if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
-	    data->predicted_us < TICK_USEC) && !tick_nohz_tick_stopped()) {
-
-		*stop_tick = false;
+	*stop_tick = menu_decide_stopping_tick(drv, data, idx);
 
-		if (idx > 0 &&
-		    drv->states[idx].target_residency > data->tick_delta_us) {
-			/*
-			 * The tick is not going to be stopped and the target
-			 * residency of the state to be returned is not within
-			 * the time until the next timer event including the
-			 * tick, so try to correct that.
-			 */
-			for (i = idx - 1; i >= 0; i--) {
-			    if (drv->states[i].disabled ||
-			        dev->states_usage[i].disable)
-					continue;
-
-				idx = i;
-				if (drv->states[i].target_residency <=
-				    data->tick_delta_us)
-					break;
-			}
+	/* Calibrate the idle state according to the tick event. */
+	if (!*stop_tick && idx > 0 &&
+	    drv->states[idx].target_residency > data->tick_delta_us) {
+		/*
+		 * The tick is not going to be stopped and the target
+		 * residency of the state to be returned is not within
+		 * the time until the next timer event including the
+		 * tick, so try to correct that.
+		 */
+		for (i = idx - 1; i >= 0; i--) {
+			if (drv->states[i].disabled ||
+			    dev->states_usage[i].disable)
+				continue;
+
+			idx = i;
+			if (drv->states[i].target_residency <=
+			    data->tick_delta_us)
+				break;
 		}
 	}
 
-- 
2.7.4

