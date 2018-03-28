Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2300974-1522241470-2-11875116548284994312
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
    t=1522241469; b=i4SJ+CXJEMRosI+u5H+0u87bItBOdWMtQAAYICdKofvnyOl
    NPggziA6iWAzpGO83s6C9flz01OVJIVjbWH3D9iZBJX201+LKzfR4EZG5y2loKkZ
    ua3OUpKnhyqOjhU3EkWusdNRsSeh0ikLe3avu/TWm549dXJ6oz0iq8ys3kz3X3wV
    uUNHViDCcYeMRuskW6ympmsVkGbHBrZwwRN9Vm872x6dlbfGsZF8o8kIYmWzJLf3
    oQ411nAnP7H0eDwhCKKKhjhgemhtduzI0HinRqgSP1r2SjkbnXjlttuYmoOLijEW
    rcYDPISddpRKXpfjHE4fzj7RWHUvoy6zmZIJUmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522241469; bh=a3j8DyfJy640RlUNrnXkxe3HWZ
    nRkufiH8mHuP/2fuE=; b=qRgeIxKacgh2j5eYusgUOOTTDRQtbOB4F70sQBYxM5
    fa7BfMFvdeWyV/IUF3j4bYUVGwdm5vd57WvJ6FpuU3hq8LtfXsnrG9dVeOtQqddl
    fGHm2FaYSzZbY4uBHzAlNxTy9DEvEq2FseG+zboLR+bRzm92fEsgOttv/HZtI6z9
    VeB6QxJtyXr61MUd8PjYm12+GFf+ZkiuQ5f+Jgzh94iD0rYDQZlEiEacnDx8ERF5
    z/2Z06InZCFncBfasuKvqOeQ0AUfYq49rORjp7R4YboFumvrnLrp+2d9N3l9AQb1
    zYERbnvBNeJMynYegBuE52+W+UgTmOmhJMgQd372zmgg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=vSBr2O6O x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=vSBr2O6O x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI7acFBBq5j7wA8VrPY+mQ/FRWSdO/9ueitGKK08Uoad01sq3UeOkGDrF5Y7kqLRyxpwa2gWvkwHUQZpUhdkphwDT7mBm6XoBbiIHUqsKxAhKIGfIFUO
    kPOcVYTE46uP+tv/WJs3x9Wx2kfSaPSwQQmrt4Bko/Z26+CjqoGbCdPq9Bdss+fLE04bu3DNoSZ8gWLS6T74+ROGpUeWHEX5/RCDn15PqLh5R1yMsK5S36N0
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=fUSZZkATYxXnQMecnGkA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbeC1MvH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 08:51:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55036 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeC1MvG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 08:51:06 -0400
Date: Wed, 28 Mar 2018 14:50:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
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
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable sequences
 system call (v12)
Message-ID: <20180328125004.GV4043@hirez.programming.kicks-ass.net>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
 <20180327160542.28457-3-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327160542.28457-3-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 12:05:23PM -0400, Mathieu Desnoyers wrote:
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index fb5fc458547f..66b070444a7e 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1249,6 +1249,7 @@ static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
>  #endif
>  	p->wake_cpu = cpu;
>  #endif
> +	rseq_migrate(p);
>  }

I think you want that in set_task_cpu(), right next to nr_migrations++.
