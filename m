Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1684311-1523561566-2-1728952105144541845
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523561565; b=XKfGyxba9C8Rb4hX6FH5snKkwVAthQqMGNAAX3Ys8tE1mLgZ4p
    4n1fKF9uss6kHhEkLc3cAvoASfpzxz3vPvOu8DLWE8dGuzfFQ+Ym9F9GgasJHSBO
    JXxKfZdYzN4GGhYoMgpQ1CYv1EudL+BkogY6xyPoiQhHlcM6Pc5qx/mKX7bVmXp1
    DvhbhBfjp0AIvFUP+cQmrdvyGWqS5hdMSgBv8YXa4isJYo0sv6mnI5d2EwRugfFL
    POj/4iN8yo1enzk8s2cmdTgqIJRjoL7iwZXSUtfMfR6ZjFPc73xWNAqh0sfmo5vV
    AHsR7v/NcKqW55SKG9s+NTrROqaPJ7rswiZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523561565; bh=
    vNkVdEI3NqYS7Qlvsp31bIHaPvWXsxv/ZF5zmpOhLMY=; b=G+NyWGlFa0MWSCmG
    ldWY2uBO0LNyng7DcyXNzSiQU3eDNrLP+M39l/bflTpuSeAJO38T0tf4uOuCd1d0
    tjKj9vsPBO+RuNQwIq7PZxt3AxbVsSD6j7Jerk/gV/3aIJArQgb/fZVlrQA/dVtz
    F33zRPhZT9d1QY4OIxoeL2NYeGyEb8YALINZfHYgB5oktVI5jDknspxFWVOKiJ4+
    r26C25qlD/2FPMlU1D44Or7xGUcyLEOR6jvZNaYYKUYisffCSIfzL73xuXqw69li
    wQvgoQo4vZCAKDXwLB1wLBkqM6py1zJQVXfZ+vs/AYYOOeg73UmXEtoGbPJHUt03
    VMgrbQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIo1b2B1tIX93oJg+x9IWh3bKZjx4cyWiymkAhXjcYqTpqtNiUBBYxZPybwfmyLkFZFzB9HRxihqau9RLJcZMMYlZvvvbrXuYbLfIBCbwPPkX3BaszlY
    CYxmruuIJhFSJgObucEx3dcF/oFiU5Jw7Yh5kicFX4LMy1MmTt+8MgRQxFTpycgWsuf0OcyxjXl9sxiEs7sksjMe1mYCODQVmilGuaytWoaTaZW2QcW1nXG3
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=7d_E57ReAAAA:8
    a=VnNF1IyMAAAA:8 a=JfrnYn6hAAAA:8 a=1XWaLZrsAAAA:8 a=SOq6UgPBAAAA:8
    a=WfulkdPnAAAA:8 a=FOH2dFAWAAAA:8 a=NufY4J3AAAAA:8 a=20KFwNOVAAAA:8
    a=oGMlB6cnAAAA:8 a=meVymXHHAAAA:8 a=UPm3pfgAAAAA:8 a=Z4Rwk6OoAAAA:8
    a=drOt6m5kAAAA:8 a=7CQSdrXTAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=K9fvYg9zRn_gSVpeIkAA:9 a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=3hv5r9HjGAh9o5iR9qwG:22 a=56QPVbyS4OZCpcuOg7Z9:22
    a=i3VuKzQdj-NEYjvDI-p3:22 a=TPcZfFuj8SYsoCJAFAiX:22 a=NdAtdrkLVvyUPsUoGJp4:22
    a=2JgSa4NbpEOStq-L5dxp:22 a=uD9XBtlS4o1URY3aiGdj:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=RMMjzBEyIzXRtoq5n5K6:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753999AbeDLTbn (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 15:31:43 -0400
Received: from mail.efficios.com ([167.114.142.138]:45756 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753258AbeDLT2X (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 15:28:23 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH for 4.18 09/23] sched: Implement push_task_to_cpu (v2)
Date: Thu, 12 Apr 2018 15:27:46 -0400
Message-Id: <20180412192800.15708-10-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180412192800.15708-1-mathieu.desnoyers@efficios.com>
References: <20180412192800.15708-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Implement push_task_to_cpu(), which moves the task received as argument
to the destination cpu's runqueue. It only does so if the CPU is within
the CPU allowed mask of the task and if the CPU is active. If the CPU is
not part of the allowed mask, -EINVAL is returned. If the CPU is not
active, -EBUSY is returned.

It does not change the CPU allowed mask, and can therefore be used
within applications which rely on owning the sched_setaffinity() state.

It does not pin the task to the destination CPU, which means that the
scheduler may choose to move the task away from that CPU before the
task executes. Code invoking push_task_to_cpu() must be prepared to
retry in that case.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Paul Turner <pjt@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Andrew Hunter <ahh@google.com>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Andi Kleen <andi@firstfloor.org>
CC: Dave Watson <davejwatson@fb.com>
CC: Chris Lameter <cl@linux.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ben Maurer <bmaurer@fb.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Michael Kerrisk <mtk.manpages@gmail.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: linux-api@vger.kernel.org

---
Change since v1:
- Return -EBUSY if CPU is not active.
---
 kernel/sched/core.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  9 +++++++++
 2 files changed, 51 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8e8bd91b9bd7..d65f227b0f18 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1062,6 +1062,48 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 		set_curr_task(rq, p);
 }
 
+int push_task_to_cpu(struct task_struct *p, unsigned int dest_cpu)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+	int ret = 0;
+
+	rq = task_rq_lock(p, &rf);
+	update_rq_clock(rq);
+
+	if (!cpumask_test_cpu(dest_cpu, &p->cpus_allowed)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!cpumask_test_cpu(dest_cpu, cpu_active_mask)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (task_cpu(p) == dest_cpu)
+		goto out;
+
+	if (task_running(rq, p) || p->state == TASK_WAKING) {
+		struct migration_arg arg = { p, dest_cpu };
+		/* Need help from migration thread: drop lock and wait. */
+		task_rq_unlock(rq, p, &rf);
+		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
+		tlb_migrate_finish(p->mm);
+		return 0;
+	} else if (task_on_rq_queued(p)) {
+		/*
+		 * OK, since we're going to drop the lock immediately
+		 * afterwards anyway.
+		 */
+		rq = move_queued_task(rq, &rf, p, dest_cpu);
+	}
+out:
+	task_rq_unlock(rq, p, &rf);
+
+	return ret;
+}
+
 /*
  * Change a given task's CPU affinity. Migrate the thread to a
  * proper CPU and schedule it away if the CPU it's executing on
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fb5fc458547f..43fdfcb0738a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1251,6 +1251,15 @@ static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
 #endif
 }
 
+#ifdef CONFIG_SMP
+int push_task_to_cpu(struct task_struct *p, unsigned int dest_cpu);
+#else
+static inline int push_task_to_cpu(struct task_struct *p, unsigned int dest_cpu)
+{
+	return 0;
+}
+#endif
+
 /*
  * Tunables that become constants when CONFIG_SCHED_DEBUG is off:
  */
-- 
2.11.0

