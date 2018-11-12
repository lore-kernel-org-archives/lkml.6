Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37BEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA3B223C8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA3B223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbeKLU11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:27:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42805 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbeKLU10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:27:26 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wACAYQBM3655582
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 12 Nov 2018 02:34:26 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wACAYPmQ3655579;
        Mon, 12 Nov 2018 02:34:25 -0800
Date:   Mon, 12 Nov 2018 02:34:25 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Viresh Kumar <tipbot@zytor.com>
Message-ID: <tip-3e184501083c38fa091f640acb13af17a21fd228@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, torvalds@linux-foundation.org,
        daniel.lezcano@linaro.org, mingo@kernel.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
          peterz@infradead.org, vincent.guittot@linaro.org,
          viresh.kumar@linaro.org, torvalds@linux-foundation.org,
          daniel.lezcano@linaro.org, mingo@kernel.org
In-Reply-To: <78cbd78a615d6f9fdcd3327f1ead68470f92593e.1541482935.git.viresh.kumar@linaro.org>
References: <78cbd78a615d6f9fdcd3327f1ead68470f92593e.1541482935.git.viresh.kumar@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Clean up the #ifdef block in
 add_nr_running()
Git-Commit-ID: 3e184501083c38fa091f640acb13af17a21fd228
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3e184501083c38fa091f640acb13af17a21fd228
Gitweb:     https://git.kernel.org/tip/3e184501083c38fa091f640acb13af17a21fd228
Author:     Viresh Kumar <viresh.kumar@linaro.org>
AuthorDate: Tue, 6 Nov 2018 11:12:57 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Nov 2018 11:18:06 +0100

sched/core: Clean up the #ifdef block in add_nr_running()

There is no point in keeping the conditional statement of the #if block
outside of the #ifdef block, while all of its body is contained within
the #ifdef block.

Move the conditional statement under the #ifdef block as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: http://lkml.kernel.org/r/78cbd78a615d6f9fdcd3327f1ead68470f92593e.1541482935.git.viresh.kumar@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b7a3147874e3..e0e052a50fcd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1801,12 +1801,12 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 
 	rq->nr_running = prev_nr + count;
 
-	if (prev_nr < 2 && rq->nr_running >= 2) {
 #ifdef CONFIG_SMP
+	if (prev_nr < 2 && rq->nr_running >= 2) {
 		if (!READ_ONCE(rq->rd->overload))
 			WRITE_ONCE(rq->rd->overload, 1);
-#endif
 	}
+#endif
 
 	sched_update_tick_dependency(rq);
 }
