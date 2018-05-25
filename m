Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965625AbeEYJrT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:47:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49971 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965197AbeEYJrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:47:14 -0400
Date: Fri, 25 May 2018 02:46:12 -0700
From: tip-bot for Juri Lelli <tipbot@zytor.com>
Message-ID: <tip-bf5015a50f1fdb248b48405b67cae24dc02605d6@git.kernel.org>
Cc: torvalds@linux-foundation.org, juri.lelli@redhat.com, mingo@kernel.org,
        patrick.bellasi@arm.com, hpa@zytor.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de
Reply-To: tglx@linutronix.de, peterz@infradead.org, dietmar.eggemann@arm.com,
        hpa@zytor.com, patrick.bellasi@arm.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, juri.lelli@redhat.com, mingo@kernel.org
In-Reply-To: <20180524152936.17611-1-juri.lelli@redhat.com>
References: <20180524152936.17611-1-juri.lelli@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/topology: Clarify root domain(s) debug
 string
Git-Commit-ID: bf5015a50f1fdb248b48405b67cae24dc02605d6
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

Commit-ID:  bf5015a50f1fdb248b48405b67cae24dc02605d6
Gitweb:     https://git.kernel.org/tip/bf5015a50f1fdb248b48405b67cae24dc02605d6
Author:     Juri Lelli <juri.lelli@redhat.com>
AuthorDate: Thu, 24 May 2018 17:29:36 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 25 May 2018 08:03:38 +0200

sched/topology: Clarify root domain(s) debug string

When scheduler debug is enabled, building scheduling domains outputs
information about how the domains are laid out and to which root domain
each CPU (or sets of CPUs) belongs, e.g.:

 CPU0 attaching sched-domain(s):
  domain-0: span=0-5 level=MC
   groups: 0:{ span=0 }, 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }
 CPU1 attaching sched-domain(s):
  domain-0: span=0-5 level=MC
   groups: 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 }

 [...]

 span: 0-5 (max cpu_capacity = 1024)

The fact that latest line refers to CPUs 0-5 root domain doesn't however look
immediately obvious to me: one might wonder why span 0-5 is reported "again".

Make it more clear by adding "root domain" to it, as to end with the
following:

 CPU0 attaching sched-domain(s):
  domain-0: span=0-5 level=MC
   groups: 0:{ span=0 }, 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }
 CPU1 attaching sched-domain(s):
  domain-0: span=0-5 level=MC
   groups: 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 }

 [...]

 root domain span: 0-5 (max cpu_capacity = 1024)

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180524152936.17611-1-juri.lelli@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 64cc564f5255..61a1125c1ae4 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1708,7 +1708,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	rcu_read_unlock();
 
 	if (rq && sched_debug_enabled) {
-		pr_info("span: %*pbl (max cpu_capacity = %lu)\n",
+		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
 			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
 	}
 
