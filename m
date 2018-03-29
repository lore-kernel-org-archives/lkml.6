Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-890949-1522331659-2-10339749286252162164
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
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522331659; b=aLNYxlNtgMcDnnzv+bAC3npIY8e5JV40GlmnAKu3lUM8De1Ot8
    UK330POeBHeBAZyd5cckp+fZfeS0Yapic69DmMghCJHy6RjArKL87f1LMQlyqDQd
    KGDSrth3Gb7OsXrIZNb+2uicahmI3QiCbrYaxz53JfIHLqAzIF3XWlPyuVktnMkQ
    PjUn7EwSeAdb7swTfOd0tRt1UfB8y+f3IRITSqRK+LYwy0dmdNgC/tlfXP4K+8Ge
    41oDNXvGJfUq43CSLHbvQ70993mSVKDF6jowbB+Fh0dB3UqlZDv10BnnHhSuXR/6
    ZE6XQJ/mk4du6yZMkOICzVR7L/dmagWVO1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522331659;
    bh=wNdAQygjl9JWIRMpQEPUVCgvTLFscEufP8uI21ywpCY=; b=YkYiJ5U7hiHq
    Cq61FuiWSdCVPOgZaZ/AYTNNq/NKyNBc3UUfezCAVQhpZeoC1pPGGapEVBO9ZSZe
    y4ITkvnpsr6+v8/DtXZVjO3rTpDAmdKWObOM5YWocaXBFiGnV5sZrexayFvY0u9y
    sNWBd3NiyeMsGe1BnpPY/iakczqsvvSzGP5JW6m624DqAO3mCXmh+bymultqCmJ/
    sx9lFVKEHa+nYDGLy6AP9/nYcbiepM/R5uKfABoDxQRHyd4G3VPk67/w42abCC1G
    QeKKTBxi6tydiJLXn439IVsddkmEcabL/oigwsikuJVkf4tu4jFnFIhoCXSFlVnI
    jTcFsMzo4w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfEWtG8/B+zxfZPOlR4NaP9AUHD10VQb5NKLWEaT5qq8/ePFi5Zasx3/Jlxw0g/OMTGoVmgU5fje1IKNY1n3siqW869tzqd0PYYheBpRWFOpY5g25tRSH
    8Ys3neh2JUKdWUaqxE+bf/HL4DnSkJxZHq5OWN1xElPTy4Wlv55/hShG/yqjav2uiONeITgXHa6huDFEINTIRs2o7jsPlFcfomRasod1424qqFFRr87uEq4E
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10 a=FqpbrowB-PMA:10 a=JfrnYn6hAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=Uel8A51_dBA4mFCjvucA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeC2NyF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 09:54:05 -0400
Received: from mail.efficios.com ([167.114.142.138]:37302 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbeC2NyE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 09:54:04 -0400
Date: Thu, 29 Mar 2018 09:54:01 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
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
Message-ID: <87410797.545.1522331641598.JavaMail.zimbra@efficios.com>
In-Reply-To: <alpine.DEB.2.21.1803282305030.1496@nanos.tec.linutronix.de>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com> <20180328145946.GH4082@hirez.programming.kicks-ass.net> <265889560.1.1522250045589.JavaMail.zimbra@efficios.com> <20180328152814.GI4082@hirez.programming.kicks-ass.net> <533214853.56.1522251426819.JavaMail.zimbra@efficios.com> <20180328174935.GK4082@hirez.programming.kicks-ass.net> <181076499.279.1522268382303.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1803282305030.1496@nanos.tec.linutronix.de>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable
 sequences system call (v12)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: rseq: Introduce restartable sequences system call (v12)
Thread-Index: RdfTFUXIFmZrGPQhqX2Rgzxsfz+lIA==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Mar 28, 2018, at 5:25 PM, Thomas Gleixner tglx@linutronix.de wrote:

> On Wed, 28 Mar 2018, Mathieu Desnoyers wrote:
>> ----- On Mar 28, 2018, at 1:49 PM, Peter Zijlstra peterz@infradead.org wrote:
>> > I don't think disallowing system calls is arbitrary. And I think that is
>> > something we really want to enforce, because it's batshit insane to
>> > allow.
>> > 
>> > And if we allow now, people _will_ use it and we can't ever take it
>> > away again.
>> 
>> Here are some examples of how I would like to use system calls within
>> rseq critical sections, for testing purposes:
>> 
>> - Issue poll(NULL, 0, ms_timeout) from a rseq critical section, to introduce
>>   a delay in the critical section and test the effect,
> 
> It's simple enough to use a delay loop for that. It's testing after all.
> 
>> - Issue sched_yield() from a rseq critical section, to introduce preemption at
>>   that point,
> 
> Make it loop on a varible and use secondary threads to force preemption.
> 
>> - Issue kill() on self, thus testing interruption by signals over rseq c.s.,
> 
> Second thread can do that
> 
>> - Invoke sched_setaffinity to tweak the cpu affinity mask to force thread
>>   migration within a rseq c.s.
> 
> Second thread can do that
> 
>> I currently have only implemented the poll(), sched_yield() and kill()
>> test-cases outside of the rseq critical sections, instead relying on
>> assembly loops to introduce delays in rseq c.s.. However, if we disallow
>> system calls in rseq critical sections, I'll never be able to use those
>> systems calls to extend the test matrix.
> 
> All of these tests can be implemented without system calls and there is no
> justification to allow system calls just because it makes writing test
> cases simpler. Nice try.

You bring good points. As a logical consequence, I indeed don't need to issue
system calls from rseq c.s. for testing.

> 
>> I see other use-cases where having a system call in a rseq critical section
>> could make sense: if vDSO data shared between kernel and user-space rely
>> on rseq for synchronization, but a fallback sometimes needs to issue a system
>> call for part of the operation.
> 
> What in the VDSO relies on rseqs? Nothing AFAICT. If the VDSO ever goes to
> use that then it's going to be a kernel/vdso specific variant and we'll
> figure out how that needs to be handled if at all.

Sure, and we can craft the vDSO so the system call does not need to be
issued within a rseq c.s.. So this one is a non-issue I think.

> 
> But we are not misdesigning now to accomodate artificial scenarios dreamed
> up for argumentation sake,

If we decide to impose limitations on the rseq c.s. abilities, we need to
think this through very carefully.

Let's say we disallow system calls from rseq critical sections. A few points
arise:

- We still need to allow traps (page faults, breakpoints, ...) within rseq c.s.,

- We still need to allow interrupts within rseq c.s.,

- We need to decide whether we just document that syscalls within rseq c.s.
  are not supported, or we enforce a behavior if this happens (e.g. SIGSEGV).
  If we enforce a SIGSEGV, we'd have to figure out whether it's worth it to
  add extra branches to the system call fast path to validate this.

- If we document that syscalls are not supported within rseq c.s., we should
  specify whether doing so terminates the process, or if it merely does not
  guarantee proper abort behavior of the critical section.

- We need to carefully consider the case of system calls issued within signal
  handlers nested on top of rseq. When RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL is
  _not_ set, neither in the rseq c.s. descriptor nor in the TLS @flags,
  it's pretty much straightforward: upon signal delivery, the kernel moves the
  ip to abort, and clears the tls @rseq_cs pointer. This means that any system
  call issued within the signal handler is not actually within the rseq c.s.
  upon which the signal is nested.

  The case I worry about is if a thread sets the RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
  flag in its TLS @flags field (useful in a debugging scenario where we want a
  debugger to single-step through the rseq c.s. and observe registers at each step).
  Arguably, this is only ever used in development. However, it does allow a situation
  where a system call executed within a signal handler can nest over a rseq c.s..
  So if we choose to be very strict and SIGSEGV any syscall nested over rseq
  c.s., we may very well end up killing the process for no good reason in this
  scenario.

- We need to decide whether all syscalls are disallowed, or if we want to pick
  specific ones (e.g. fork()).

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
