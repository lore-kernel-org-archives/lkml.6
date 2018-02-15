Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518720097-2-12083070971232974181
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
    t=1518720097; b=l/75yjxg/31SqinFtsuMb6eh4ZZ2V1QStVYW4CFWqJdUhxs
    UL5jHuK62GwU2k9FUJ0acZ0ojkBt04tzwm9D2uyYRod9B95yMR2F8WDkB1oTRXFP
    JwJBnCYNQaCrr9cXNsCm4jkoxkmZfrz5nniIIjhZnqMMzBGlHzagVh8ftQ7Wf44l
    v9Ct5MKad0JvcL92ydPOThswCBieVwbsRP0ImWkmlbEQpjmbRUKdchLov+bXNCed
    EFxM+P7OLzMIRPlY78xBpIj/mVWWH6izOtG4TM0pV0EI2dWZlitTvG6XP8RwOa2c
    5B7I3Q0v3Aiwp+dLqcd2Yo58dDL6wONzNhumyUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720097; bh=hpWvIKjBHBIm+VbP77eWt2Xz5j
    OkoWb4Gcf9D8vxgvc=; b=YK/nkvgQRik5IWs8hlsIVrhbET4hajjyPcKevZBz7g
    6IeVApVKY2BOGYDkzcQ69y0zNRRNq521yZoVNu49hu0P5J0q9h7WwnNlgBBvL0SC
    Q4KWpyTerOvKI+0efpMpJOMAI7cfHsC6Alfk5QpUOTB+G8MMkgd4Af+JkOgCxEUn
    1trlfLiD+eb6dZL9dJIdIo3/V2JNWSgfUytxq4HWmOlgUM/01c8nOBmnSw9bRwLp
    31NVP2rzSuAD8ez+T5iMczbgrdffN+LrEqD/la4j/6pz6o8OMvu7mzgC419/gsRX
    NswC5AUfyTyZHf7bFJ3mpMvxoYJAdh2k+Ks7GfsyoClA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162745AbeBOSld (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:41:33 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51556 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162720AbeBOPXp (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:45 -0500
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
Subject: [PATCH 4.4 049/108] sched/rt: Use container_of() to get root domain in rto_push_irq_work_func()
Date: Thu, 15 Feb 2018 16:16:46 +0100
Message-Id: <20180215151229.282612884@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit ad0f1d9d65938aec72a698116cd73a980916895e upstream.

When the rto_push_irq_work_func() is called, it looks at the RT overloaded
bitmask in the root domain via the runqueue (rq->rd). The problem is that
during CPU up and down, nothing here stops rq->rd from changing between
taking the rq->rd->rto_lock and releasing it. That means the lock that is
released is not the same lock that was taken.

Instead of using this_rq()->rd to get the root domain, as the irq work is
part of the root domain, we can simply get the root domain from the irq work
that is passed to the routine:

 container_of(work, struct root_domain, rto_push_work)

This keeps the root domain consistent.

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
 kernel/sched/rt.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1833,9 +1833,8 @@ static void push_rt_tasks(struct rq *rq)
  * the rt_loop_next will cause the iterator to perform another scan.
  *
  */
-static int rto_next_cpu(struct rq *rq)
+static int rto_next_cpu(struct root_domain *rd)
 {
-	struct root_domain *rd = rq->rd;
 	int next;
 	int cpu;
 
@@ -1911,7 +1910,7 @@ static void tell_cpu_to_push(struct rq *
 	 * Otherwise it is finishing up and an ipi needs to be sent.
 	 */
 	if (rq->rd->rto_cpu < 0)
-		cpu = rto_next_cpu(rq);
+		cpu = rto_next_cpu(rq->rd);
 
 	raw_spin_unlock(&rq->rd->rto_lock);
 
@@ -1924,6 +1923,8 @@ static void tell_cpu_to_push(struct rq *
 /* Called from hardirq context */
 void rto_push_irq_work_func(struct irq_work *work)
 {
+	struct root_domain *rd =
+		container_of(work, struct root_domain, rto_push_work);
 	struct rq *rq;
 	int cpu;
 
@@ -1939,18 +1940,18 @@ void rto_push_irq_work_func(struct irq_w
 		raw_spin_unlock(&rq->lock);
 	}
 
-	raw_spin_lock(&rq->rd->rto_lock);
+	raw_spin_lock(&rd->rto_lock);
 
 	/* Pass the IPI to the next rt overloaded queue */
-	cpu = rto_next_cpu(rq);
+	cpu = rto_next_cpu(rd);
 
-	raw_spin_unlock(&rq->rd->rto_lock);
+	raw_spin_unlock(&rd->rto_lock);
 
 	if (cpu < 0)
 		return;
 
 	/* Try the next RT overloaded CPU */
-	irq_work_queue_on(&rq->rd->rto_push_work, cpu);
+	irq_work_queue_on(&rd->rto_push_work, cpu);
 }
 #endif /* HAVE_RT_PUSH_IPI */
 
