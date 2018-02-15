Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1825685-1518708356-2-1439280792446054536
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518708355; b=bsuhUtsbFshhYBZ8i+etTBGGQHdA3Dm+MgyDkGGnec3lTs6
    4+bsQWFhHpCfkVp0SwDiA/GrQkbupw0rOud6aoEX8Nb60OEu5aYfCA1hTQOKlpM5
    m7IKzi+nZEV1o6RUl7y4v47SAqhcqORqZGagZKhi1R7b4LTcpHMkeOrppekTVmKi
    5nDRj+PIgsQgPNYesEVilWWOMgj1K/y3WZx5HZaSJ5yDQQKlv7Y6W+WQe10qBQtA
    AQQxI1GXaFlf4YAgNSa1IeTu2VKxhAVrXkQBz+XZLaHtm0n9HOk+X+7zP/ImliWp
    IqnhtrQ/V8Ha0enIL8qlDtGb34aiG6kw/nNw/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518708355; bh=Or6uWLJyxBTA4fjykUfIxU4bxr
    WO4s0/9tU6kIwbANY=; b=aHEdfFfUeF2Mincxma6NwPt1DKw/84OuwIiouWdyo0
    rMWfSxelXiPOw65mJ2Bf2kLICVwYZ1N6Qbveuxdoy/J/xNV/+jqaP27pyIi1NOcY
    iUIdRV2pa6Lk82fHzJidEfgerClOD4rWuPts2/7LDBdBaozJhoM+R2qsGHQlTQQ4
    a1GKSHpv0/vfbSzj3HyoBRxlu1qeVCWSvpgdIg/NkpAW/JaGyl7RaKxyPN3XPDcN
    bTgOqKK2xahwztqtv8krcV8MZ2ClgypYF8GeeSRFOUHRIVlU3tBjhdAlLdLXpJR2
    t6f/QQSgKUXNIcufaxfUg2CVdV2+zt4mTC9AuXSWUBwA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163246AbeBOPZw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:25:52 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52372 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163232AbeBOPZo (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:25:44 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavan Kondeti <pkondeti@codeaurora.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 10/88] sched/rt: Up the root domain ref count when passing it around via IPIs
Date: Thu, 15 Feb 2018 16:16:37 +0100
Message-Id: <20180215151224.075281096@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 364f56653708ba8bcdefd4f0da2a42904baa8eeb upstream.

When issuing an IPI RT push, where an IPI is sent to each CPU that has more
than one RT task scheduled on it, it references the root domain's rto_mask,
that contains all the CPUs within the root domain that has more than one RT
task in the runable state. The problem is, after the IPIs are initiated, the
rq->lock is released. This means that the root domain that is associated to
the run queue could be freed while the IPIs are going around.

Add a sched_get_rd() and a sched_put_rd() that will increment and decrement
the root domain's ref count respectively. This way when initiating the IPIs,
the scheduler will up the root domain's ref count before releasing the
rq->lock, ensuring that the root domain does not go away until the IPI round
is complete.

Reported-by: Pavan Kondeti <pkondeti@codeaurora.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 4bdced5c9a292 ("sched/rt: Simplify the IPI based RT balancing logic")
Link: http://lkml.kernel.org/r/CAEU1=PkiHO35Dzna8EQqNSKW1fr1y1zRQ5y66X117MG06sQtNA@mail.gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/core.c  |   13 +++++++++++++
 kernel/sched/rt.c    |    9 +++++++--
 kernel/sched/sched.h |    2 ++
 3 files changed, 22 insertions(+), 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5864,6 +5864,19 @@ static void rq_attach_root(struct rq *rq
 		call_rcu_sched(&old_rd->rcu, free_rootdomain);
 }
 
+void sched_get_rd(struct root_domain *rd)
+{
+	atomic_inc(&rd->refcount);
+}
+
+void sched_put_rd(struct root_domain *rd)
+{
+	if (!atomic_dec_and_test(&rd->refcount))
+		return;
+
+	call_rcu_sched(&rd->rcu, free_rootdomain);
+}
+
 static int init_rootdomain(struct root_domain *rd)
 {
 	memset(rd, 0, sizeof(*rd));
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1978,8 +1978,11 @@ static void tell_cpu_to_push(struct rq *
 
 	rto_start_unlock(&rq->rd->rto_loop_start);
 
-	if (cpu >= 0)
+	if (cpu >= 0) {
+		/* Make sure the rd does not get freed while pushing */
+		sched_get_rd(rq->rd);
 		irq_work_queue_on(&rq->rd->rto_push_work, cpu);
+	}
 }
 
 /* Called from hardirq context */
@@ -2009,8 +2012,10 @@ void rto_push_irq_work_func(struct irq_w
 
 	raw_spin_unlock(&rd->rto_lock);
 
-	if (cpu < 0)
+	if (cpu < 0) {
+		sched_put_rd(rd);
 		return;
+	}
 
 	/* Try the next RT overloaded CPU */
 	irq_work_queue_on(&rd->rto_push_work, cpu);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -590,6 +590,8 @@ struct root_domain {
 };
 
 extern struct root_domain def_root_domain;
+extern void sched_get_rd(struct root_domain *rd);
+extern void sched_put_rd(struct root_domain *rd);
 
 #ifdef HAVE_RT_PUSH_IPI
 extern void rto_push_irq_work_func(struct irq_work *work);
