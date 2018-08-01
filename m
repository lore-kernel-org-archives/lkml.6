Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACCFC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1968F208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="kT802V4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1968F208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389819AbeHARDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:03:44 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35524 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389806AbeHARDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:03:43 -0400
Received: by mail-qk0-f195.google.com with SMTP id u21-v6so12919126qku.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 08:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NnxyiouhvZnUSydapW5h/V7JQgsuHd8XHvJ9oMKS3Xk=;
        b=kT802V4gaqvbzln+f7fYdlx75z3raFvWWaTBt1Ow9JJu+sYDH8AC31h2MpNN+ybowx
         kWiCmVtbOreLhY2E7Ss/RDFI5q+e71n0rRqALyj7H1GsxqyD90HGeMonuHIcCMH16La9
         d0OcbT8ER8TruLjo/js6yfJNamgONc0l0RaEaNrDbELS7WDGUe56gFohc3Wang2B/ils
         ekHw80UG/aGi4IdbXx4x294G9wbS8PW4DfBlYTJBxpUmYqT5Q3qXQ1Sf6qTCVbJpuAsU
         uqHWEUJLMkuO0nmka52QhW6d+spDzMj6+dbkZD6t/BbBAvDVb4Q9l+tye6zJkb5XxztA
         P9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NnxyiouhvZnUSydapW5h/V7JQgsuHd8XHvJ9oMKS3Xk=;
        b=qcHaiJpDyHjfyA7Mhh0im1PgW8hWvcjj/OWqWBJC32816BeCOSLRnPvW8oLONL2VCt
         Fp/EzoPMbEr7uEcHMcJCNYisO8XVlb2WHBmRagASJB7gj7y+mvqoDVXX5Iy2kmJd7WJK
         94MaJF+vzQYa2yIUmbNgpQ0kkbAjt9XEDVIiq2eYO9ZKRAjhVcMZGhngZ1gR0bWPEvPE
         VHEM8Sx35HrHKPUbtgEjEQYitY/9d6cH3tQ2JI3hDxr3K1uQ1Q9W/oFzwOQkY8QcY/+e
         V4vZv0hudnaduDwtgkjzKrC0mNXzQN7EkAbYKfeBCXFvOA4BlAJ8r6z4r3d4W8d1YQL1
         Yk4g==
X-Gm-Message-State: AOUpUlG7DLsY+HjKpLLOHYj9h+7HgVDx2NVOrq/Ouhd6uP9u6g/dQC/i
        TqKID7avTaNNUnR7GZ8loGXD7g==
X-Google-Smtp-Source: AAOMgpd6XA3VsHPvUpK58x5ONBk2skDpwBhL2vuXnT9tx3uqOGsyoxJ/SijzpC0KWqY+DZB2nZer+A==
X-Received: by 2002:a37:dd4e:: with SMTP id n75-v6mr23297165qki.370.1533136652152;
        Wed, 01 Aug 2018 08:17:32 -0700 (PDT)
Received: from localhost (216.49.36.201.res-cmts.bus.ptd.net. [216.49.36.201])
        by smtp.gmail.com with ESMTPSA id t27-v6sm13257610qkl.11.2018.08.01.08.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 08:17:31 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 6/9] sched: sched.h: make rq locking and clock functions available in stats.h
Date:   Wed,  1 Aug 2018 11:19:55 -0400
Message-Id: <20180801151958.32590-7-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801151958.32590-1-hannes@cmpxchg.org>
References: <20180801151958.32590-1-hannes@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/sched/sched.h includes "stats.h" half-way through the file. The
next patch introduces users of sched.h's rq locking functions and
update_rq_clock() in kernel/sched/stats.h. Move those definitions up
in the file so they are available in stats.h.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/sched.h | 164 +++++++++++++++++++++----------------------
 1 file changed, 82 insertions(+), 82 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cb467c221b15..b8f038497240 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -919,6 +919,8 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define raw_rq()		raw_cpu_ptr(&runqueues)
 
+extern void update_rq_clock(struct rq *rq);
+
 static inline u64 __rq_clock_broken(struct rq *rq)
 {
 	return READ_ONCE(rq->clock);
@@ -1037,6 +1039,86 @@ static inline void rq_repin_lock(struct rq *rq, struct rq_flags *rf)
 #endif
 }
 
+struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
+	__acquires(rq->lock);
+
+struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
+	__acquires(p->pi_lock)
+	__acquires(rq->lock);
+
+static inline void __task_rq_unlock(struct rq *rq, struct rq_flags *rf)
+	__releases(rq->lock)
+{
+	rq_unpin_lock(rq, rf);
+	raw_spin_unlock(&rq->lock);
+}
+
+static inline void
+task_rq_unlock(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
+	__releases(rq->lock)
+	__releases(p->pi_lock)
+{
+	rq_unpin_lock(rq, rf);
+	raw_spin_unlock(&rq->lock);
+	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
+}
+
+static inline void
+rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
+	__acquires(rq->lock)
+{
+	raw_spin_lock_irqsave(&rq->lock, rf->flags);
+	rq_pin_lock(rq, rf);
+}
+
+static inline void
+rq_lock_irq(struct rq *rq, struct rq_flags *rf)
+	__acquires(rq->lock)
+{
+	raw_spin_lock_irq(&rq->lock);
+	rq_pin_lock(rq, rf);
+}
+
+static inline void
+rq_lock(struct rq *rq, struct rq_flags *rf)
+	__acquires(rq->lock)
+{
+	raw_spin_lock(&rq->lock);
+	rq_pin_lock(rq, rf);
+}
+
+static inline void
+rq_relock(struct rq *rq, struct rq_flags *rf)
+	__acquires(rq->lock)
+{
+	raw_spin_lock(&rq->lock);
+	rq_repin_lock(rq, rf);
+}
+
+static inline void
+rq_unlock_irqrestore(struct rq *rq, struct rq_flags *rf)
+	__releases(rq->lock)
+{
+	rq_unpin_lock(rq, rf);
+	raw_spin_unlock_irqrestore(&rq->lock, rf->flags);
+}
+
+static inline void
+rq_unlock_irq(struct rq *rq, struct rq_flags *rf)
+	__releases(rq->lock)
+{
+	rq_unpin_lock(rq, rf);
+	raw_spin_unlock_irq(&rq->lock);
+}
+
+static inline void
+rq_unlock(struct rq *rq, struct rq_flags *rf)
+	__releases(rq->lock)
+{
+	rq_unpin_lock(rq, rf);
+	raw_spin_unlock(&rq->lock);
+}
+
 #ifdef CONFIG_NUMA
 enum numa_topology_type {
 	NUMA_DIRECT,
@@ -1670,8 +1752,6 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
 	sched_update_tick_dependency(rq);
 }
 
-extern void update_rq_clock(struct rq *rq);
-
 extern void activate_task(struct rq *rq, struct task_struct *p, int flags);
 extern void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
 
@@ -1752,86 +1832,6 @@ static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta) { }
 static inline void sched_avg_update(struct rq *rq) { }
 #endif
 
-struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
-	__acquires(rq->lock);
-
-struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
-	__acquires(p->pi_lock)
-	__acquires(rq->lock);
-
-static inline void __task_rq_unlock(struct rq *rq, struct rq_flags *rf)
-	__releases(rq->lock)
-{
-	rq_unpin_lock(rq, rf);
-	raw_spin_unlock(&rq->lock);
-}
-
-static inline void
-task_rq_unlock(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
-	__releases(rq->lock)
-	__releases(p->pi_lock)
-{
-	rq_unpin_lock(rq, rf);
-	raw_spin_unlock(&rq->lock);
-	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
-}
-
-static inline void
-rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
-	__acquires(rq->lock)
-{
-	raw_spin_lock_irqsave(&rq->lock, rf->flags);
-	rq_pin_lock(rq, rf);
-}
-
-static inline void
-rq_lock_irq(struct rq *rq, struct rq_flags *rf)
-	__acquires(rq->lock)
-{
-	raw_spin_lock_irq(&rq->lock);
-	rq_pin_lock(rq, rf);
-}
-
-static inline void
-rq_lock(struct rq *rq, struct rq_flags *rf)
-	__acquires(rq->lock)
-{
-	raw_spin_lock(&rq->lock);
-	rq_pin_lock(rq, rf);
-}
-
-static inline void
-rq_relock(struct rq *rq, struct rq_flags *rf)
-	__acquires(rq->lock)
-{
-	raw_spin_lock(&rq->lock);
-	rq_repin_lock(rq, rf);
-}
-
-static inline void
-rq_unlock_irqrestore(struct rq *rq, struct rq_flags *rf)
-	__releases(rq->lock)
-{
-	rq_unpin_lock(rq, rf);
-	raw_spin_unlock_irqrestore(&rq->lock, rf->flags);
-}
-
-static inline void
-rq_unlock_irq(struct rq *rq, struct rq_flags *rf)
-	__releases(rq->lock)
-{
-	rq_unpin_lock(rq, rf);
-	raw_spin_unlock_irq(&rq->lock);
-}
-
-static inline void
-rq_unlock(struct rq *rq, struct rq_flags *rf)
-	__releases(rq->lock)
-{
-	rq_unpin_lock(rq, rf);
-	raw_spin_unlock(&rq->lock);
-}
-
 #ifdef CONFIG_SMP
 #ifdef CONFIG_PREEMPT
 
-- 
2.18.0

