Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D24C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0BE20838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfBKKyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:54:24 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41149 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfBKKyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:54:23 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1BAsCUS3499547
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 11 Feb 2019 02:54:12 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1BAsBbh3499543;
        Mon, 11 Feb 2019 02:54:11 -0800
Date:   Mon, 11 Feb 2019 02:54:11 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Viresh Kumar <tipbot@zytor.com>
Message-ID: <tip-1b5500d73466c62fe048153f0cea1610d2543c7f@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org, hpa@zytor.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Reply-To: peterz@infradead.org, vincent.guittot@linaro.org,
          mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org
In-Reply-To: <f91c5e118183e79d4a982e9ac4ce5e47948f6c1b.1549536337.git.viresh.kumar@linaro.org>
References: <f91c5e118183e79d4a982e9ac4ce5e47948f6c1b.1549536337.git.viresh.kumar@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Remove unused 'sd' parameter from
 select_idle_smt()
Git-Commit-ID: 1b5500d73466c62fe048153f0cea1610d2543c7f
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

Commit-ID:  1b5500d73466c62fe048153f0cea1610d2543c7f
Gitweb:     https://git.kernel.org/tip/1b5500d73466c62fe048153f0cea1610d2543c7f
Author:     Viresh Kumar <viresh.kumar@linaro.org>
AuthorDate: Thu, 7 Feb 2019 16:16:05 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 11 Feb 2019 08:48:27 +0100

sched/fair: Remove unused 'sd' parameter from select_idle_smt()

The 'sd' parameter isn't getting used in select_idle_smt(), drop it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: http://lkml.kernel.org/r/f91c5e118183e79d4a982e9ac4ce5e47948f6c1b.1549536337.git.viresh.kumar@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f44da9b491ff..8abd1c271499 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6117,7 +6117,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 /*
  * Scan the local SMT mask for idle CPUs.
  */
-static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
+static int select_idle_smt(struct task_struct *p, int target)
 {
 	int cpu;
 
@@ -6141,7 +6141,7 @@ static inline int select_idle_core(struct task_struct *p, struct sched_domain *s
 	return -1;
 }
 
-static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
+static inline int select_idle_smt(struct task_struct *p, int target)
 {
 	return -1;
 }
@@ -6246,7 +6246,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
-	i = select_idle_smt(p, sd, target);
+	i = select_idle_smt(p, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
