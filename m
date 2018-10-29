Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093B4C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEF92082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCEF92082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbeJ2UXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:23:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36001 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeJ2UXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:23:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9TBYZEj1519777
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 29 Oct 2018 04:34:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9TBYZFQ1519774;
        Mon, 29 Oct 2018 04:34:35 -0700
Date:   Mon, 29 Oct 2018 04:34:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Muchun Song <tipbot@zytor.com>
Message-ID: <tip-a68d75081aeccfb169575bea6f452a5a12b9f49b@git.kernel.org>
Cc:     tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, smuchun@gmail.com, mingo@kernel.org,
        peterz@infradead.org, hpa@zytor.com
Reply-To: hpa@zytor.com, peterz@infradead.org, mingo@kernel.org,
          smuchun@gmail.com, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, tglx@linutronix.de
In-Reply-To: <20181027030517.23292-1-smuchun@gmail.com>
References: <20181027030517.23292-1-smuchun@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/rt: Update comment in pick_next_task_rt()
Git-Commit-ID: a68d75081aeccfb169575bea6f452a5a12b9f49b
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

Commit-ID:  a68d75081aeccfb169575bea6f452a5a12b9f49b
Gitweb:     https://git.kernel.org/tip/a68d75081aeccfb169575bea6f452a5a12b9f49b
Author:     Muchun Song <smuchun@gmail.com>
AuthorDate: Sat, 27 Oct 2018 11:05:17 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 29 Oct 2018 07:18:04 +0100

sched/rt: Update comment in pick_next_task_rt()

Commit:

  f4ebcbc0d7e0 ("sched/rt: Substract number of tasks of throttled queues from rq->nr_running")

added a new rt_rq->rt_queued field, which is used to indicate the status of
rq->rt enqueue or dequeue. So, the ->rt_nr_running check was removed and we
now check ->rt_queued instead.

Fix the comment in pick_next_task_rt() as well, which was still referencing
the old logic.

Signed-off-by: Muchun Song <smuchun@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181027030517.23292-1-smuchun@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/rt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2e2955a8cf8f..a21ea6021929 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1561,7 +1561,7 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	/*
 	 * We may dequeue prev's rt_rq in put_prev_task().
-	 * So, we update time before rt_nr_running check.
+	 * So, we update time before rt_queued check.
 	 */
 	if (prev->sched_class == &rt_sched_class)
 		update_curr_rt(rq);
