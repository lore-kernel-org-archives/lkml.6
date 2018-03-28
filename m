Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2556150-1522250558-2-15825499337109030530
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
    t=1522250558; b=Gk7CXSN2DGHe0o960gwuAMDXqCnFFgGW+M1OTrd8wPbpAuZ
    EB7u0YioUxobuTuGlUtW5NhkBCh2nLn9OsXZrZXidskwp5rxO+N7DKBg0YjNyXSP
    y0QOhGXFlAqMwldcIP0g0cD31N2YMbidxBK5LpBg+SlEStjhFtK6RPo5eZkP+ujr
    NSucYPjXBkCrFykty2Ysn+uLviZnWapxVjFIczWGc+UwW3sIr9/FeagdmjEMFCse
    /bP/mM95US7mClpM2/zyBWCpBwTN8+VW+Xu+OecHSo+rx6Pi0ecUesJWjf1b9HGQ
    5EDBn8Nd73Sk+eyLObap9KItKvBhZvKLohLSrFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522250558; bh=D2pPVFo0aELYVJS2GKtZRr0cVl
    UxGRKsMj5Au3jtrHs=; b=fykC8w8H2WgqcilR3vki7C3Xz0t24CBin94V/7QXGv
    F6N7DzIjEbE7+PNSLFUyU7wFSk+/4Oj8YQ5azPJbQVySY7y1wkMDYkJEZ67Z7Qr7
    KsqYW2ouv+hDVqrEqE3m+UFOHN1lyTL24dSx3qsZh0QGrLVmFN3L3ysm3HgZu4um
    oQjTmrWrdfv/ODfmLWgGXCHc0Pn67W0ita+UvNp6Auc65HtUXInJ03YVQ+NFp/uY
    0oLgeZS1qUch/a4ByE1Y4ph0ClfvN9YFa6IexRT/AclH9x8AR6bTQJbmXepB2eKr
    qc89ca45zrjJLr/heRaUsnlBmTQ5fcuaEYb/R2HkldYg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=SFjRUU7n x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=SFjRUU7n x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGs5VMZkTSirml0oFuIq6Q9ZwBT6KWzl6QTL+aONnFNdAXw7mz4NJ3tgn7pApn9ChyRKotVN2b3iSFQiz6ylb00qNi9DjntpWxuXhoh8C+YmxeXAkjmb
    YbfaNr/mgHUyAt1xU7rJK3Koxn9KA9b7Xo0bKn25hkpIRFtdgQnp+3+ByIpOUdACQ5cKOgM5YX8BhzidqqHMNv+KK9itwfwiT/4udd1Tcy4yWpx/gAv9B6sD
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=K0BWzCqdF3uVCNhIY2cA:9 a=D4yyuzNtsRvy9OPo:21
    a=EeAU6hQfqLpjbK6h:21 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753611AbeC1PWg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 11:22:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56300 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753444AbeC1PWg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 11:22:36 -0400
Date: Wed, 28 Mar 2018 17:22:03 +0200
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
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [RFC PATCH for 4.17 10/21] cpu_opv: Provide cpu_opv system call
 (v6)
Message-ID: <20180328152203.GW4043@hirez.programming.kicks-ass.net>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
 <20180327160542.28457-11-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327160542.28457-11-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 12:05:31PM -0400, Mathieu Desnoyers wrote:

> 1) Allow algorithms to perform per-cpu data migration without relying on
>    sched_setaffinity()
> 
> The use-cases are migrating memory between per-cpu memory free-lists, or
> stealing tasks from other per-cpu work queues: each require that
> accesses to remote per-cpu data structures are performed.

I think that one completely reduces to the per-cpu (spin)lock case,
right? Because, as per the below, your logging case (8) can 'easily' be
done without the cpu_opv monstrosity.

And if you can construct a per-cpu lock, that can be used to construct
aribtrary logic.

And the difficult case for the per-cpu lock is the remote acquire; all
the other cases are (relatively) trivial.

I've not really managed to get anything sensible to work, I've tried
several variations of split lock, but you invariably end up with
barriers in the fast (local) path, which sucks.

But I feel this should be solvable without cpu_opv. As in, I really hate
that thing ;-)

> 8) Allow libraries with multi-part algorithms to work on same per-cpu
>    data without affecting the allowed cpu mask
> 
> The lttng-ust tracer presents an interesting use-case for per-cpu
> buffers: the algorithm needs to update a "reserve" counter, serialize
> data into the buffer, and then update a "commit" counter _on the same
> per-cpu buffer_. Using rseq for both reserve and commit can bring
> significant performance benefits.
> 
> Clearly, if rseq reserve fails, the algorithm can retry on a different
> per-cpu buffer. However, it's not that easy for the commit. It needs to
> be performed on the same per-cpu buffer as the reserve.
> 
> The cpu_opv system call solves that problem by receiving the cpu number
> on which the operation needs to be performed as argument. It can push
> the task to the right CPU if needed, and perform the operations there
> with preemption disabled.
> 
> Changing the allowed cpu mask for the current thread is not an
> acceptable alternative for a tracing library, because the application
> being traced does not expect that mask to be changed by libraries.

We talked about this use-case, and it can be solved without cpu_opv if
you keep a dual commit counter, one local and one (atomic) remote.

We retain the cpu_id from the first rseq, and the second part will, when
it (unlikely) finds it runs remotely, do an atomic increment on the
remote counter. The consumer of the counter will then have to sum both
the local and remote counter parts.

