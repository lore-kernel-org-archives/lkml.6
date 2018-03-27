Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4170472-1522167675-5-4146840905687704768
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522167672; b=gitJkz6qHZMS9bmffdBaTtVDn1m2KY8BXUZ1LQnD3AgaLar
    3dvElyYA9kQpEvlRauMoJrIWIWjfoGVVNK14aGO1Yx9scYduAFd3R9zTGjGEbg0L
    +vYnv1os/ypfdgFzfDZzZSDi77Sq+yXBeaoQ/k2A+9qeOo62tvGtbmMl5W67/gZ4
    ZxKScfIo91LrybSny8QL+xeXlx1tW29FarMrvCkBdQts3nrFzS6uFtv43hFkNfY1
    F7w4vj/IVibU2bj+1QOjsEL7livML0h46ysuKktodjZiFS9edfQIAdNd8e10gQh/
    IcFXL8s6hEpCJlZV2AklykVVZcH3F7PskrUDy+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522167672;
    bh=9bWIcR+T7Ajow68HrPj87pXHGRM+vleWkG5tqV4B4Vk=; b=PRK4Y5yyxSwG
    KVTLuMDeXN/brPyJcFZi5luAw6sDc9eDBb2OC6MchW3i+oYTqy5rWkaVb+mSYl0x
    nu3u2kLrW3ThYfYHz/xQUQvEW9IffbLMEQ0YQTJMwQCiWJYUZnSsjMn2W4IJ6jWx
    tb/GAYomtfDsrihi3bJ9/tupoFir6zxmtZKsvp1TGfdT3RFFqVRsupbyECzrWSSm
    mU88gfVR/BRpnpqa99g6X0N6P/ed+9anfEYGHUaZVzldvLdiR0jY6omJx/UKtLrz
    TTiFzEjsPX7aewFHRLrbW2oPaIO1+BXhIQ5H4YkJJ8HQ1+P6JOB/0QssBuIZVASO
    xza+zyxGEw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfIHn77UifRCe2vcIHZ2NZhM+HHjngvpsNGE0QnKRNVj3fkv0itYhBbzIRMfQI3F2tuSh8b9tUSRNUK4wKInhcemBnJwEEEbnZy57p6y/cuBJiGB81+dU
    ZREh9cfi97sipm99XvBMAdPuW7grftuKpJoNsbcPLYE1gLl42LUk5OWv816XhQOQOrq/gHwppTY++nVELn6ibExpZS/sn6q6dcYDl0TwVDilMAm8hdXq+aVJ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=7d_E57ReAAAA:8
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
        id S1752278AbeC0QVJ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:21:09 -0400
Received: from mail.efficios.com ([167.114.142.138]:53980 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeC0QVB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Mar 2018 12:21:01 -0400
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
Subject: [RFC PATCH for 4.17 09/21] sched: Implement push_task_to_cpu (v2)
Date: Tue, 27 Mar 2018 12:05:30 -0400
Message-Id: <20180327160542.28457-10-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
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
index 771caa7e95c6..ef7f5eb5d56e 100644
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
index 66b070444a7e..4aaf70d54afc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1252,6 +1252,15 @@ static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
 	rseq_migrate(p);
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

