Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id aNSpFWVyGlulPwAAmS7hNA
	; Fri, 08 Jun 2018 12:12:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F0538607E4; Fri,  8 Jun 2018 12:12:15 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9L61ZhJ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 668C6605A5;
	Fri,  8 Jun 2018 12:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 668C6605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752828AbeFHMKV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:10:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35959 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752356AbeFHMKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:10:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id v131-v6so3297210wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 05:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BBIn+dyfWNg2BP9P3LhrqhOynHzD7w3d3ReCisqZKME=;
        b=C9L61ZhJ1Sa5Y6q567YMSeE2NNegSM5WgObtDSG89B7saYRNQQQBxaq05wuD5FwLJT
         1wQ4LJcx7GASQonynvBrEv1zfjIjHOeDO2A2oiSemnYd+l+OHxH3MaHBEilJjH6Ad5he
         Lu/TBZWniV7MUesLN7clXhKEgMu25rcHaKZmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BBIn+dyfWNg2BP9P3LhrqhOynHzD7w3d3ReCisqZKME=;
        b=sIMqhBYuQXUY7MYaojtg92fkvwFmfLJ6SNGtRqvgzYfRzLqMxTXkqy+uh1RrYK3jOp
         DrbwxGo054qmYZQ7qR2sT0vHvOyuKAbgRV17wIPOV7xdZ06vFeiO/dgue3VAtBMWwv5F
         yeF8c37wRC+14xgNS+WL+esypa/bVhdfGUCAgFjO2+6cj5qKb3XSBG6jcAzOpBiNBAzG
         l8u+NomQY9nfgWHD7KcmzQINrsVhVYVMkbA/gm3lQUyeMWn/bahe+z0PPbflvXWizZd4
         iz49v+LnQ+/3vQrnlsLZhJM42UkxLndXS1eWo+LcmZYI4Tx5o7qrl52XFrOPaeNfhPOi
         vo1w==
X-Gm-Message-State: APt69E1D8HcRVN2LXCDgA99vAcujYQiNC7Gj9CyrO/1GpSbx8ws0frKs
        UOLNdOz+HyYREikPtbKM1/r9WQ==
X-Google-Smtp-Source: ADUXVKLeD+2ZyG1lq0lFlDzC9N/ANX6qGgnBAgSeSGe5dpVeGjrWCo0/mBCeSdYY6M18JuxmM21RWg==
X-Received: by 2002:a1c:9c0b:: with SMTP id f11-v6mr1362187wme.148.1528459815720;
        Fri, 08 Jun 2018 05:10:15 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:6c67:7ea:9f4d:8968])
        by smtp.gmail.com with ESMTPSA id b204-v6sm1546003wmh.22.2018.06.08.05.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jun 2018 05:10:15 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        quentin.perret@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v6 02/11] sched/pelt: remove blank line
Date: Fri,  8 Jun 2018 14:09:45 +0200
Message-Id: <1528459794-13066-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove some blank lines in __update_load_avg_se() and __update_load_avg_cfs_rq

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Reported-by: Patrick Bellasi <patrick.bellasi@arm.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/pelt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index e6ecbb2..4174582 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -287,7 +287,6 @@ int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_e
 
 	if (___update_load_sum(now, cpu, &se->avg, !!se->on_rq, !!se->on_rq,
 				cfs_rq->curr == se)) {
-
 		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
 		cfs_se_util_change(&se->avg);
 		return 1;
@@ -302,7 +301,6 @@ int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq)
 				scale_load_down(cfs_rq->load.weight),
 				scale_load_down(cfs_rq->runnable_weight),
 				cfs_rq->curr != NULL)) {
-
 		___update_load_avg(&cfs_rq->avg, 1, 1);
 		return 1;
 	}
-- 
2.7.4
