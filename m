Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2888441-1522259686-2-14099383819941449522
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CA'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522259685; b=DEKUDB23AAGzR0cryZH/JMJqSvm/0iwe8NGV1A50ofzrWfQ
    Td5UOXsRS9BQUSYCG6VyhpQ09NujPJEnMymYnfYvCavwKiXullzRzOOWtU2x2vw2
    EWLDFyOzDFFTz1bAtVKK6WG29aiD7RXm4TZlJFwIpdPMlW+vVOXJzAxLCNus+RRH
    jHVzEgijEb9DdzHMlMSfP3Yy9V7gaIO6JBxIS+vQeD0l5Qk+xLiC6p8X56RVIaIt
    PU0+8eluJ5RlPPknF3y8Ltc1SHRAwGrlWdDZQUD+LVUAJhqf6fakyxAbd5vSln7l
    2LY35j1OZ3da8sOjnoMz6y6pUt9fR6oWpoaHrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522259685; bh=wD3OpPdsyHsrDREiILVfLZb1XQRRZ/ae28DV/feefuo=; b=b
    htoUK3aDj8cn+ROEXoa5Q+Rd/F5zKCak5aokLGdPxJNkqwZUWcUHYXpQmMI0JGf/
    GR7c3J1eRsZBW8HiHahQMecvcgYrPvGs+m8s1cz7/lwe86t9tto1ScM5clJG0Mg9
    trR2V+ah5vadUPCzwJN4hq9XwoALy6IPeLvVJBgTmYqiAdXyZdODbL6froPS7Kw6
    kLqrUwZkNgLovO/43CxRHe/c3M+NjimzdhqVQfRyvDGU5R5ncz5Ql2RYyuc46KwC
    CWt/khOMkFg/9NXbmwD8QvkL6CHHVhYh3i9QiKrJeTC62E9gEmHCCb7P6GOZKBsY
    /T7V2f9//NUsFHCCzLoXw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfOA6OT8279RmylvfCCblFaLISeEYMpXfbywentEHx+qu1m0yW5shbewWTiMv44/y1B22pGRWO89a0AUl7etGGTT0WflEg3MTpxBrrokCyjQdMuctP+uR
    oSfgM0DoxesT6y2ewaI9fJi+JKJNW9XQ4hCPPO7afjcmxWEQFgHzLY84t/vvdHt/GRrBxlXWl01RMPra/qh345Ll5W5A1S/uK/N5MILIV22v7uMwkZzJupqH
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10 a=FqpbrowB-PMA:10 a=JfrnYn6hAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=0ypWdCbcz3gSJ0mEFPwA:9
    a=0DvqRlEsh4XA7bhI:21 a=elC7lY2KGalG-ROU:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753339AbeC1Ryo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 13:54:44 -0400
Received: from mail.efficios.com ([167.114.142.138]:35354 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753349AbeC1Rym (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 13:54:42 -0400
Date: Wed, 28 Mar 2018 13:54:41 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>
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
        Michael Kerrisk <mtk.manpages@gmail.com>
Message-ID: <1109208604.169.1522259681295.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180328152203.GW4043@hirez.programming.kicks-ass.net>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com> <20180327160542.28457-11-mathieu.desnoyers@efficios.com> <20180328152203.GW4043@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH for 4.17 10/21] cpu_opv: Provide cpu_opv system call
 (v6)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: cpu_opv: Provide cpu_opv system call (v6)
Thread-Index: 8s+ruNV5RmeQN6e3c0jumjOKFuybzg==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Mar 28, 2018, at 11:22 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Mar 27, 2018 at 12:05:31PM -0400, Mathieu Desnoyers wrote:
> 
>> 1) Allow algorithms to perform per-cpu data migration without relying on
>>    sched_setaffinity()
>> 
>> The use-cases are migrating memory between per-cpu memory free-lists, or
>> stealing tasks from other per-cpu work queues: each require that
>> accesses to remote per-cpu data structures are performed.
> 
> I think that one completely reduces to the per-cpu (spin)lock case,
> right? Because, as per the below, your logging case (8) can 'easily' be
> done without the cpu_opv monstrosity.
> 
> And if you can construct a per-cpu lock, that can be used to construct
> aribtrary logic.

The per-cpu spinlock does not have the same performance characteristics
as lock-free alternatives for various operations. A rseq compare-and-store
is faster than a rseq spinlock for linked-list operations.

> 
> And the difficult case for the per-cpu lock is the remote acquire; all
> the other cases are (relatively) trivial.
> 
> I've not really managed to get anything sensible to work, I've tried
> several variations of split lock, but you invariably end up with
> barriers in the fast (local) path, which sucks.
> 
> But I feel this should be solvable without cpu_opv. As in, I really hate
> that thing ;-)

I have not developed cpu_opv out of any kind of love for that solution.
I just realized that it did solve all my issues after failing for quite
some time to implement acceptable solutions for the remote access
problem, and for ensuring progress of single-stepping with current
debuggers that don't know about the rseq_table section.

> 
>> 8) Allow libraries with multi-part algorithms to work on same per-cpu
>>    data without affecting the allowed cpu mask
>> 
>> The lttng-ust tracer presents an interesting use-case for per-cpu
>> buffers: the algorithm needs to update a "reserve" counter, serialize
>> data into the buffer, and then update a "commit" counter _on the same
>> per-cpu buffer_. Using rseq for both reserve and commit can bring
>> significant performance benefits.
>> 
>> Clearly, if rseq reserve fails, the algorithm can retry on a different
>> per-cpu buffer. However, it's not that easy for the commit. It needs to
>> be performed on the same per-cpu buffer as the reserve.
>> 
>> The cpu_opv system call solves that problem by receiving the cpu number
>> on which the operation needs to be performed as argument. It can push
>> the task to the right CPU if needed, and perform the operations there
>> with preemption disabled.
>> 
>> Changing the allowed cpu mask for the current thread is not an
>> acceptable alternative for a tracing library, because the application
>> being traced does not expect that mask to be changed by libraries.
> 
> We talked about this use-case, and it can be solved without cpu_opv if
> you keep a dual commit counter, one local and one (atomic) remote.

Right.

> 
> We retain the cpu_id from the first rseq, and the second part will, when
> it (unlikely) finds it runs remotely, do an atomic increment on the
> remote counter. The consumer of the counter will then have to sum both
> the local and remote counter parts.

Yes, I did a prototype of this specific case with split-counters a while
ago. However, if we need cpu_opv as fallback for other reasons (e.g. remote
accesses), then the split-counters are not needed, and there is no need to
change the layout of user-space data to accommodate the extra per-cpu
counter.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
