Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeERHht (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:37:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49447 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbeERHhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:37:47 -0400
Date: Fri, 18 May 2018 00:37:21 -0700
From: tip-bot for Mathieu Malaterre <tipbot@zytor.com>
Message-ID: <tip-3febfc8a219a036633b57a34c6678e21b6a0580d@git.kernel.org>
Cc: peterz@infradead.org, mingo@kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, malat@debian.org
Reply-To: malat@debian.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com, mingo@kernel.org,
        peterz@infradead.org
In-Reply-To: <20180516200902.959-1-malat@debian.org>
References: <20180516200902.959-1-malat@debian.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/deadline: Make the grub_reclaim() function
 static
Git-Commit-ID: 3febfc8a219a036633b57a34c6678e21b6a0580d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3febfc8a219a036633b57a34c6678e21b6a0580d
Gitweb:     https://git.kernel.org/tip/3febfc8a219a036633b57a34c6678e21b6a0580d
Author:     Mathieu Malaterre <malat@debian.org>
AuthorDate: Wed, 16 May 2018 22:09:02 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 18 May 2018 09:05:22 +0200

sched/deadline: Make the grub_reclaim() function static

Since the grub_reclaim() function can be made static, make it so.

Silences the following GCC warning (W=1):

  kernel/sched/deadline.c:1120:5: warning: no previous prototype for ‘grub_reclaim’ [-Wmissing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180516200902.959-1-malat@debian.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d6196bc6cbb5..1356afd1eeb6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1117,7 +1117,7 @@ extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
  * should be larger than 2^(64 - 20 - 8), which is more than 64 seconds.
  * So, overflow is not an issue here.
  */
-u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
+static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
 {
 	u64 u_inact = rq->dl.this_bw - rq->dl.running_bw; /* Utot - Uact */
 	u64 u_act;
