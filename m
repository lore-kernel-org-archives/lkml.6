Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2532849-1522249227-2-17896393498914724337
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522249226; b=i4ljP5304HC3b8WEnJHjJALHL5SavHLsct0kjEDBSFFwZb/
    qKR5Y//6AGVwe828YdLMQ7Qe8rVMN23TRKkZY4eMtKtxnHb2Gurv6uJIPnGHkN9L
    ixaC0dPX6ayYdCLpXtKdbgKoTnOvKOPuq7CC79fB0z3UeHPxESM4BGdmtmC2g/xY
    wR8DGwVEEEqdMfqfLVPRVVj/ZZuXRWoo6agK4SbbRPk7U23F5E+UebyICpz29tpV
    K4St6bR7mN2wy/e82yVLS64FUpk3hnRUeDP4BSzgXwVeKL2uhWJRwzlgqUYali2y
    25huQOM3WZjErpDmZt6fBrbLNrUKV+9BBJf633Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522249226; bh=iS6jQM+TMyS+1J0K0vAFomeZ1l
    Tfou2CbfzHidaiEjk=; b=kmaDO2EzgWHrihO5O5UxvbaICK12dIrSZL86938VTl
    lu/d37c+FTVYOTrywcXniXOPCVkX9vCpcbhnfHCheQnwZs7SnnmjmH1yc0gMJADb
    /tCqM0JO8LUV0e7uWMuQU19njZVmP4FmzD1jgbxrOlNva/KuharT2YDwhnJZuUS3
    T7cWk8EGoURlEMB3b7t01l9BURTYQEx6fOL1UPzHl73csHy+K1UGkTC4q9u0v5bC
    cXPdyvq3vJFhLRQSwMMYzVJIAq9ilZJHmH8LKGgM9pBgv9N6EkMBzWwLajy2kRpE
    6bvA11Rd4tFBEwn59fITK5oy5fdVadw4XGr9DfyAc3uQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Y1jerkd9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Y1jerkd9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHbpysvhM+RB3reI+22WKtoFGvxqsvZC/2MXeWdXa/DiKWERbZfyHY0W1uHPhajrKZ23oi12h+ksgVL+7ZtvY/NiN03n4cagw2ZBp56YH8ze8N/0Zzsl
    yrP6/dz5UK2ieyN5rjRkdx3fumD4WJP2BgqqDrhJ7EatFwz9d1QpZgt0AX3oDYUdeqfvDX/M+CbKn7QokolXcBau3KcDaB4/AyqFpd0IipugdX546DNp5liv
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=ug_Xh6y5OZ7u9AaQ2UMA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbeC1PAY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 11:00:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56048 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753629AbeC1PAX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 11:00:23 -0400
Date: Wed, 28 Mar 2018 16:59:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable sequences
 system call (v12)
Message-ID: <20180328145946.GH4082@hirez.programming.kicks-ass.net>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
 <20180327160542.28457-3-mathieu.desnoyers@efficios.com>
 <20180328125004.GV4043@hirez.programming.kicks-ass.net>
 <1523662633.2105.1522248474778.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523662633.2105.1522248474778.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 10:47:54AM -0400, Mathieu Desnoyers wrote:
> ----- On Mar 28, 2018, at 8:50 AM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > On Tue, Mar 27, 2018 at 12:05:23PM -0400, Mathieu Desnoyers wrote:
> >> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> >> index fb5fc458547f..66b070444a7e 100644
> >> --- a/kernel/sched/sched.h
> >> +++ b/kernel/sched/sched.h
> >> @@ -1249,6 +1249,7 @@ static inline void __set_task_cpu(struct task_struct *p,
> >> unsigned int cpu)
> >>  #endif
> >>  	p->wake_cpu = cpu;
> >>  #endif
> >> +	rseq_migrate(p);
> >>  }
> > 
> > I think you want that in set_task_cpu(), right next to nr_migrations++.
> 
> This would miss the __set_task_cpu() call from sched_fork() and wake_up_new_task().

Correct; but since those are _new_ tasks they _SHOULD_ not have an
active RSEQ to begin with.

> Those cases are not accounted as explicit "migrations", but it does change the CPU
> of the current task. So if for some weird reason userspace wants to fork() while in
> a rseq critical section, we want to trigger a rseq restart.

If at all possible I would make it SIGSEGV when issueing SYSCALL()s from
within an RSEQ.

> An alternative to this would be to call rseq_migrate() in rseq_fork().
> 
> Thoughts ?

Yes, don't try and support that at all. It's _insane_.
