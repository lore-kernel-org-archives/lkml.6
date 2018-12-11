Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D54C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE3920672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE3920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeLKPag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:30:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45599 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeLKPaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:30:35 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFUFLZ4041892
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:30:15 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFUFep4041885;
        Tue, 11 Dec 2018 07:30:15 -0800
Date:   Tue, 11 Dec 2018 07:30:15 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-80eb865768703c0f85a0603762742ae1dedf21f0@git.kernel.org>
Cc:     andrea.parri@amarulasolutions.com, peterz@infradead.org,
        torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          vincent.guittot@linaro.org, andrea.parri@amarulasolutions.com,
          peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
          torvalds@linux-foundation.org
In-Reply-To: <20181127110110.5533-1-andrea.parri@amarulasolutions.com>
References: <20181127110110.5533-1-andrea.parri@amarulasolutions.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] sched/fair: Clean up comment in
 nohz_idle_balance()
Git-Commit-ID: 80eb865768703c0f85a0603762742ae1dedf21f0
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

Commit-ID:  80eb865768703c0f85a0603762742ae1dedf21f0
Gitweb:     https://git.kernel.org/tip/80eb865768703c0f85a0603762742ae1dedf21f0
Author:     Andrea Parri <andrea.parri@amarulasolutions.com>
AuthorDate: Tue, 27 Nov 2018 12:01:10 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 14:54:57 +0100

sched/fair: Clean up comment in nohz_idle_balance()

Concerning the comment associated to the atomic_fetch_andnot() in
nohz_idle_balance(), Vincent explains [1]:

  "[...] the comment is useless and can be removed [...]  it was
   referring to a line code above the comment that was present in
   a previous iteration of the patchset. This line disappeared in
   final version but the comment has stayed."

So remove the comment.

Vincent also points out that the full ordering associated to the
atomic_fetch_andnot() primitive could be relaxed, but this patch
insists on the current more conservative/fully ordered solution:

"Performance" isn't a concern, stay away from "correctness"/subtle
relaxed (re)ordering if possible..., just make sure not to confuse
the next reader with misleading/out-of-date comments.

[1] http://lkml.kernel.org/r/CAKfTPtBjA-oCBRkO6__npQwL3+HLjzk7riCcPU1R7YdO-EpuZg@mail.gmail.com

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20181127110110.5533-1-andrea.parri@amarulasolutions.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ac855b2f4774..db514993565b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9533,9 +9533,7 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 		return false;
 	}
 
-	/*
-	 * barrier, pairs with nohz_balance_enter_idle(), ensures ...
-	 */
+	/* could be _relaxed() */
 	flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
 	if (!(flags & NOHZ_KICK_MASK))
 		return false;
