Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1168001-1522337946-2-3165254203642319072
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
    1522337946; b=KyYaLMcKIQcCVLTfjsL9ttHuapJMc+0PZnNnDpb6Rbv1JYtsoc
    p+emRbUUg49RC/RiyVmHdw1BHvieBb0OpqE0eNmYUnQv5LRZelRMAaENlSTYZRg/
    qItIwb2yc7qVIpq3mmfsp5kAMeCxZp3utKOrjXBjssDtHimVWLTh57RmWrAAHYDi
    kJ/YgIVGSR80dkOeEL9nqMxwZL4OgQ0fHiUNz4dfdA6MCPa9h7z0kRtXn5tGAVy4
    jCoZ+SedEPerNZD1ToKjcWAVeB6YhDSGKQC3yXkjVBWA83wzMDcWVgsW8UsJmYGT
    FlEN6Eaoz/GYfEiZj0og/NwcMdUIoRuQkJHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522337946;
    bh=DnBOVB/AbRZzKUNB2s7vfyorYx5X4f6tsYgnBdIpQ1c=; b=wYoK/wKzd/tt
    9mOWSgbfdX9rBlxuf+46Dp8cDyPAvGKEn3GIXEfYkU1QMPisnzdN8sndQ6GxZeI9
    f4CfpUbglOTwQmRid/bluJjFhK8gn1XY9gY+KCFwPVt/jpm2dygFRqQLbRqtVLIp
    qxZjf4NIha5jVLuteX9WrTOdA0K9ZYgIg6qaKxwoj1/wvNqGThWVPwTGA92512Qy
    UoYMuLygusjZGFO/JzUXxVCZs2hXEyid85Kmjwp6zXcON319QcDPh2wWl99lmuLZ
    C+JgXl1899bC/2Cq58JDFJc8CbRs2rwqbI3JCAoHgXX35KZApTy/0btHgBip/ZN0
    ZLbLVk2q8A==
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
X-CM-Envelope: MS4wfGnicGAvjWrlwJIfT+hmL8bOwmMmRp/jJ2iyJ/mVjIoCRtZvRBoZZpB51JjfpvcSuKBEeNxMZEXFsaxw0NrO1WrG0tUX9Z2S48nXa+NWZISlCaZ8Wmea
    vFW1IicBU0ZTvBUQa0TeQyG1NdLFzaqCSi6B7yOOqJBw27wr9DigmsbC+6GyIzwbH8EnqqNm5XsCcZJLkWrH51kGTF1nMU8tpvR3MlB+nK9jLT54lCX2DUlP
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10 a=FqpbrowB-PMA:10 a=JfrnYn6hAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=xo8iJNfg0IuUtnz2bnwA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeC2PjD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 11:39:03 -0400
Received: from mail.efficios.com ([167.114.142.138]:43006 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbeC2PjC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 11:39:02 -0400
Date: Thu, 29 Mar 2018 11:39:00 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <544124089.623.1522337940950.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180329142338.GD4043@hirez.programming.kicks-ass.net>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com> <20180328152814.GI4082@hirez.programming.kicks-ass.net> <533214853.56.1522251426819.JavaMail.zimbra@efficios.com> <20180328174935.GK4082@hirez.programming.kicks-ass.net> <181076499.279.1522268382303.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1803282305030.1496@nanos.tec.linutronix.de> <87410797.545.1522331641598.JavaMail.zimbra@efficios.com> <20180329142338.GD4043@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable
 sequences system call (v12)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: rseq: Introduce restartable sequences system call (v12)
Thread-Index: qC/xnCwBJOliD3esxkq63c7Ywg8nxg==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Mar 29, 2018, at 10:23 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Thu, Mar 29, 2018 at 09:54:01AM -0400, Mathieu Desnoyers wrote:
>> Let's say we disallow system calls from rseq critical sections. A few points
>> arise:
>> 
>> - We still need to allow traps (page faults, breakpoints, ...) within rseq c.s.,
>> 
>> - We still need to allow interrupts within rseq c.s.,
> 
> Sure, but all those are different entry points, so that shouldn't be a
> problem.

Yes, indeed.

> 
>> - We need to decide whether we just document that syscalls within rseq c.s.
>>   are not supported, or we enforce a behavior if this happens (e.g. SIGSEGV).
>>   If we enforce a SIGSEGV, we'd have to figure out whether it's worth it to
>>   add extra branches to the system call fast path to validate this.
> 
> Without enforcement someone will eventually do this :/ We might (maybe)
> get away with it being a debug option somewhere, but even that sounds
> like trouble.

I find it unlikely that someone will issue a syscall from a rseq critical
section without really intending it. The system call would need to be
crafted within the rseq assembly block.

Enforcing SIGSEGV on syscall entry when nested in a rseq critical section
will not be free both in terms of syscall overhead, and in terms of code
maintenance: we'd need to add those checks into entry.S for each architecture
supported, which pretty much doubles the amount of architecture-specific
code we need to implement for rseq. Currently, all we need is to hook in
signal delivery and wire up the system call numbers.

If there is some clever arch-agnostic way to enforce SIGSEGV in those
situations, I'm all ears. But I don't think it's worthwhile to enforce
this if it costs in terms of system call speed and adds extra arch-specific
code to maintain.

We could simply document that issuing a system call within a rseq critical
section will cause the restart behavior (whether the critical section is
restarted or not) to be undefined.

> 
>> - We need to carefully consider the case of system calls issued within signal
>>   handlers nested on top of rseq. When RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL is
>>   _not_ set, neither in the rseq c.s. descriptor nor in the TLS @flags,
>>   it's pretty much straightforward: upon signal delivery, the kernel moves the
>>   ip to abort, and clears the tls @rseq_cs pointer. This means that any system
>>   call issued within the signal handler is not actually within the rseq c.s.
>>   upon which the signal is nested.
>> 
>>   The case I worry about is if a thread sets the RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
>>   flag in its TLS @flags field (useful in a debugging scenario where we want a
>>   debugger to single-step through the rseq c.s. and observe registers at each
>>   step).
>>   Arguably, this is only ever used in development. However, it does allow a
>>   situation
>>   where a system call executed within a signal handler can nest over a rseq c.s..
>>   So if we choose to be very strict and SIGSEGV any syscall nested over rseq
>>   c.s., we may very well end up killing the process for no good reason in this
>>   scenario.
> 
> Yes, that needs a little thought; but when we run the signal handler,
> the IP would no longer be inside the active RSEQ, right?

Good point, I missed that. So yes, even with the RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
flag set, the instruction pointer comparison would detect that we're not actually
running in the rseq critical section if a syscall is issued from the signal handler.

> 
>> - We need to decide whether all syscalls are disallowed, or if we want to pick
>>   specific ones (e.g. fork()).
> 
> All.

I'm fine with that.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
