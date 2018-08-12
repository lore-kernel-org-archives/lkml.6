Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9950C46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 16:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839BD219C4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 16:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HdnB8Nat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839BD219C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeHLSsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 14:48:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52295 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbeHLSsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 14:48:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so6452901wmh.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SX0m3tGLxDNEaSJcRwiLoR6t4RrqbIncbJJxqLoIX9o=;
        b=HdnB8NatpocGEL93w0XRHehbE84HUhV/wb/KWqRlt4/m3a3yrGKkZEratVTpaarNKQ
         EjqDQIshLQT01QbrZqGG/CJX39qrxEfXaJ9Wk132TKDlcchpBqygOcrQwHp1UquQXCKL
         0nIGiLHmbhTbfoy3tE8GrerVdc1/PNgi1XnPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SX0m3tGLxDNEaSJcRwiLoR6t4RrqbIncbJJxqLoIX9o=;
        b=g4VzybVMR3VwRXK6diSJjnB8Hwp59Xb7IxKm0jTXpXPe2SNiBUnND/EZGYYPusSrET
         bNrMgatAcpCa5d04ZnW7JdJ4RVrVqD9Dhg5p2CoWfyqIY6J2DzdOyriFmvYwlsuKhZ49
         3pm7uHvPvvcY1TxhLQT8GiwDaZ8pVJYBGu5SHfD0Sj8iG3xW+fy0GeN2v1cRpgI3MWpm
         PQ2UvkxUKLbHs/4jDZnP+7k9BEBCV5gkP8S5zrqfVtU8ox13Xt/JfyEm5IvwsBM+XaiC
         wvOyKOeIIo92ZOEZ1y0oYteycuR7dS47ugN0JZebSA1ir8aDDRDeL83NAoSwokSl4uyA
         JiYA==
X-Gm-Message-State: AOUpUlENdehbuvPVI+DvMXxGYQ+82K4NitGh1mPCcs6cVwYek1/+YA7K
        MRQlE6haDAzP6QxAgXGogvcCfw==
X-Google-Smtp-Source: AA+uWPyLiUo5B2rbJHEm0BkcnWYqQfm14cjj4pNytZM+5CkRTB7lO9YCmhOW9IjwzfAUN1H7MzU7Ig==
X-Received: by 2002:a1c:1188:: with SMTP id 130-v6mr5942158wmr.138.1534090211534;
        Sun, 12 Aug 2018 09:10:11 -0700 (PDT)
Received: from localhost.localdomain ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id t6-v6sm7437369wmf.8.2018.08.12.09.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Aug 2018 09:10:10 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 5/5] cpuidle: menu: Change to compare prediction with tick delta
Date:   Mon, 13 Aug 2018 00:09:31 +0800
Message-Id: <1534090171-14464-6-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534090171-14464-1-git-send-email-leo.yan@linaro.org>
References: <1534090171-14464-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tick stopping decision is made by comparing the prediction with
TICK_USEC, if the prediction is shorter than TICK_USEC then this means
the CPU is likely waken up before the tick event so it's pointless to
stop tick.  In reality when make the decision, though the tick period is
fixed to TICK_USEC, but the CPU is randomly entering/exiting idle
states so the next tick delta is float and should be in the range
[0, TICK_USEC].  This can result in wrong decision for stopping tick,
e.g. if the prediction is 3ms idle duration and we compare with
TICK_USEC=4000 (HZ=250), this can lead to a wrong conclusion is the tick
event will be later than the prediction duration so the governor doesn't
stop the tick; but in fact the tick is expired for 1ms, so the tick
wakes up the CPU ahead and the CPU cannot stay in idle for 3ms as
expected.

Alternatively, 'data->tick_delta_us' is for the tick delta value and
it's a accurate estimation for tick event coming.  This patch changes to
compare prediction with tick delta rather than comparing with the static
tick interval.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/cpuidle/governors/menu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 566c65c..06d5942 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -300,10 +300,11 @@ static bool menu_decide_stopping_tick(struct cpuidle_driver *drv,
 		return false;
 
 	/*
-	 * Don't stop the tick if the prediction is shorter than the
-	 * tick period length.
+	 * If the prediction is shorter than the next tick event, means
+	 * the CPU will be waken up before the tick event; don't stop
+	 * the tick.
 	 */
-	if (data->predicted_us < TICK_USEC)
+	if (data->predicted_us < data->tick_delta_us)
 		return false;
 
 	/*
-- 
2.7.4

