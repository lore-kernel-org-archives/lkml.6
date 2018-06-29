Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ED1C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFD927EA5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eknrPN+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFD927EA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755409AbeF2MK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:10:27 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36725 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754720AbeF2MKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:10:25 -0400
Received: by mail-wr0-f194.google.com with SMTP id f16-v6so8628979wrm.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 05:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zi2d56q7UEouEznscnJH/00MOynLIjXhsFYcQ6cHFIw=;
        b=eknrPN+/0+8GdA7Is1KBYlOibAoEA/bPYVGNxe3huoT9rq3k/fWQS8gtAGAqgavkdd
         i6HQV1z+cxvlcHqDrQR7+4w8uQ+HM8TYuXyGsyekGTweues9889cpkC8MJAFYaTRkjNQ
         sCyX85lUvjkl17WSNzMBrc8g1MmTqTnDVlin3hKoJ3sZfBMxqujjD7H2IMXs74N98xOk
         Tb7vJCZQTmyOA8V7wL5hKxolfPn++EjNNQgILC3WfgQQ8+mxNNXQK18j6I3eWpLUv79S
         OZ+wTWhiYUb3vXXR5rfN5b9yXsaAl/8kg91E21ZkyW9tcZeywPNMuLKA/NKHoAK70KVm
         ZeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zi2d56q7UEouEznscnJH/00MOynLIjXhsFYcQ6cHFIw=;
        b=GaS+Q2UgMvOGdKF1NF5ES6CNkWnjCWpqS0HcAlpgR9IUjoaJQr3EQDXrXhvAivmHEf
         ZV3p1kswnqWZ11JHHXbR750+AKy6CdF7Z38bQnVUw8s6Bb5A/AkhS/dTylCfSsLQAOzR
         WiPjbnbeoHjguirem1hm6S/DMBQZT5jhhAbarv78adrWOTpPDD/WzW0kymwITglRqzJF
         XA2wdx+KZbAlvyPwM70B3iwSWOIfgi6yS5aVLG8xpX8TeRtDuUpxGvYkAOgLiY2eO2s+
         J/y03B5S01GdOY8V6tk+ChQlmJafkpGbSofnj4fq4blNjGNxiR7bp93w3KUsqjz860Ze
         fvWQ==
X-Gm-Message-State: APt69E3pvhgZwQqzah9yCB63diKTgFUvzmEO3yXo69ou9R/SU6YLrQUr
        PtkEeMG/iaiVgXRJDXg9k97NbDhA
X-Google-Smtp-Source: AAOMgpcxQrp0OVNcsJ61gpqiFZnlhKf5y7gbrtGD7esBkjwYBurBTwwuqAV42rljCNul4R0v8z9GUw==
X-Received: by 2002:adf:b726:: with SMTP id l38-v6mr7154975wre.115.1530274223864;
        Fri, 29 Jun 2018 05:10:23 -0700 (PDT)
Received: from localhost.localdomain (nat-cataldo.sssup.it. [193.205.81.5])
        by smtp.googlemail.com with ESMTPSA id h12-v6sm1741524wmb.3.2018.06.29.05.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 05:10:23 -0700 (PDT)
From:   Alessio Balsini <alessio.balsini@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH] sched/deadline: sched_getattr() returns absolute dl-task information
Date:   Fri, 29 Jun 2018 14:09:47 +0200
Message-Id: <20180629120947.14579-1-alessio.balsini@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the task calls sched_getattr() with SCHED_GETATTR_FLAGS_DL_ABSOLUTE
flag set, the returned runtime and deadline parameters are, accordingly,
the remaining runtime and the absolute deadline.

To return consistent data, the scheduler and rq times, as well as the
task statistics, are updated.

Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: Claudio Scordino <claudio@evidence.eu.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Alessio Balsini <alessio.balsini@gmail.com>
---
Having a precise means for measuring the execution time of a task at
each activation is critical for real-time application design,
development, and deployment. This allows for estimating the
computational demand of the task at run-time, constituting the
fundamental information over which the runtime parameter can be set when
using the SCHED_DEADLINE policy. For example, one could set the runtime
equal to the maximum observed execution time, or a proper percentile of
its observed distribution (while a discussion of more complex WCET
estimation techniques is out of scope here). Moreover, in dynamic
workload scenarios, one needs to track the execution time changes, in
order to possibly adapt the runtime parameter as needed.

However, on platforms with frequency switching capabilities, the typical
way to perform execution time measurements for a task, based on sampling
the CLOCK_THREAD_CPUTIME_ID clock, produces unreliable results due to
the sporadic frequency switches that may happen between two
measurements, and locking down the frequency is rarely a viable
solution, anyway only acceptable during design/development, not for
dynamic adaptations while the task is running.

Execution time measurements can be done by using the remaining runtime
and absolute deadline instead, for SCHED_DEADLINE tasks. This is a
better option because (i) it only accounts for the actual runtime of the
task, and (ii) the runtime accounting is automatically normalized
(scaled) with the CPU frequency (and capacity, for heterogeneous
platforms).


This solution preserves the ability to query for the absolute
sched_{runtime, deadline} values of tasks other than itself, simplifying
the development of a task hierarchy where a manager process can allocate
the bandwidths of other deadline tasks in the system.


The simplest way to measure the normalized duration C_ns of a piece of
deadline task that does not use bandwidth reclaiming is the following:

struct sched_attr s, e;
uint64_t dl_misses;
struct sched_attr curr_attr = {
    [...]
    sched_policy = SCHED_DEADLINE,
    [...]
};

sched_setattr(0, &curr_attr, 0);

sched_getattr(0, &s, ..., SCHED_GETATTR_FLAGS_DL_ABSOLUTE);
/* calculations to be measured */
sched_getattr(0, &e, ..., SCHED_GETATTR_FLAGS_DL_ABSOLUTE);

/* SCHED_DL periods within measurement, usually 0 */
n_periods = (e.sched_deadline - s.sched_deadline) / s.sched_period;
C_ns = s.sched_runtime - e.sched_runtime + n_periods * t.sched_runtime;

 include/uapi/linux/sched.h | 12 +++++++++++-
 kernel/sched/core.c        |  4 ++--
 kernel/sched/deadline.c    | 34 +++++++++++++++++++++++++++++++---
 kernel/sched/sched.h       |  2 +-
 4 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 22627f80063e..cf290d35685e 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -45,7 +45,17 @@
 #define SCHED_RESET_ON_FORK     0x40000000
 
 /*
- * For the sched_{set,get}attr() calls
+ * For the sched_getattr() call:
+ * - DL_ABSOLUTE: returns the current absolute deadline and remaining runtime,
+ *   instead of the sched_runtime and sched_deadline values.
+ */
+#define SCHED_GETATTR_FLAGS_DL_ABSOLUTE	0x01
+
+#define SCHED_GETATTR_FLAGS_ALL ( \
+			SCHED_GETATTR_FLAGS_DL_ABSOLUTE)
+
+/*
+ * For the struct sched_attr's sched_flags
  */
 #define SCHED_FLAG_RESET_ON_FORK	0x01
 #define SCHED_FLAG_RECLAIM		0x02
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 78d8facba456..40a172200147 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4729,7 +4729,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	int retval;
 
 	if (!uattr || pid < 0 || size > PAGE_SIZE ||
-	    size < SCHED_ATTR_SIZE_VER0 || flags)
+	    size < SCHED_ATTR_SIZE_VER0 || flags & ~SCHED_GETATTR_FLAGS_ALL)
 		return -EINVAL;
 
 	rcu_read_lock();
@@ -4746,7 +4746,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	if (p->sched_reset_on_fork)
 		attr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
 	if (task_has_dl_policy(p))
-		__getparam_dl(p, &attr);
+		__getparam_dl(p, &attr, flags);
 	else if (task_has_rt_policy(p))
 		attr.sched_priority = p->rt_priority;
 	else
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fbfc3f1d368a..f75a4169cd47 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2568,13 +2568,41 @@ void __setparam_dl(struct task_struct *p, const struct sched_attr *attr)
 	dl_se->dl_density = to_ratio(dl_se->dl_deadline, dl_se->dl_runtime);
 }
 
-void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
+void __getparam_dl(struct task_struct *p, struct sched_attr *attr,
+		   unsigned int flags)
 {
 	struct sched_dl_entity *dl_se = &p->dl;
 
 	attr->sched_priority = p->rt_priority;
-	attr->sched_runtime = dl_se->dl_runtime;
-	attr->sched_deadline = dl_se->dl_deadline;
+
+	if (flags & SCHED_GETATTR_FLAGS_DL_ABSOLUTE) {
+		/*
+		 * If the task is not running, its runtime is already
+		 * properly accounted. Otherwise, update clocks and the
+		 * statistics for the task.
+		 */
+		if (task_running(task_rq(p), p)) {
+			struct rq_flags rf;
+			struct rq *rq;
+
+			rq = task_rq_lock(p, &rf);
+			sched_clock_tick();
+			update_rq_clock(rq);
+			task_tick_dl(rq, p, 0);
+			task_rq_unlock(rq, p, &rf);
+		}
+
+		/*
+		 * If the task is throttled, this value could be negative,
+		 * but sched_runtime is unsigned.
+		 */
+		attr->sched_runtime = dl_se->runtime <= 0 ? 0 : dl_se->runtime;
+		attr->sched_deadline = dl_se->deadline;
+	} else {
+		attr->sched_runtime = dl_se->dl_runtime;
+		attr->sched_deadline = dl_se->dl_deadline;
+	}
+
 	attr->sched_period = dl_se->dl_period;
 	attr->sched_flags = dl_se->flags;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6601baf2361c..25892cd502aa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -310,7 +310,7 @@ extern int  sched_dl_global_validate(void);
 extern void sched_dl_do_global(void);
 extern int  sched_dl_overflow(struct task_struct *p, int policy, const struct sched_attr *attr);
 extern void __setparam_dl(struct task_struct *p, const struct sched_attr *attr);
-extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr);
+extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr, unsigned int flags);
 extern bool __checkparam_dl(const struct sched_attr *attr);
 extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr);
 extern int  dl_task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allowed);
-- 
2.17.1

