Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3143389-1522268387-2-3534333954888684868
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
    t=1522268387; b=XLYFfVisurSK31VPLYJORHc+XiZdXTUzezId8/s7QQvQxIx
    vlD2OjZUwkj2jD9qGeQLIsX3bRETxvcdNOqxbsNnuA2vdRKtwGk5lI4fkkvu98xP
    9pa9+FeBjnJVi99g78QqMF8vf1N3DP0l0wZ9QP1DY5Ap5zRtrIE81SoU2MCfgL+0
    SdVgALy1EYpQzky1Xt519jjY/5W2xjMkNvYEJAJdP7dAAVj0EDYiqmyCHFgntAeE
    yXwtTSdu8M8QXoziflJS8U6nA68ew2FBIzEEShPYP39S3FbObWSNd71UctiHyktJ
    qtIzxOivnlCgCZc+ysGhw2IocpzyHB4ch10JnSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522268387; bh=FmTJQKbq78b3rL+3OEcqa2X24tKSy+y98lq4D/F7RTk=; b=g
    GfDDeu1PtsC4bah3S8mDxrd36UFzVg6G34qOJYUA4VsPnNqRoEY0QJHwsnuwxfl6
    ruzvlQOND7/zvwajZwVrTvuSVfIwNDO3vDVio5Y9031EQ+a03XL1eFm2KIHtP49i
    RN7YVFeC3jlcAohjTjTC75kE0MMbOtXZ6HYcZ0EDGwmbctD7gMXuuCBIa6AL54mF
    HjlZLqJy3+nXBQytGQ5LzqpNuIyGVWELH4fXSmAhkQjMv36gcBcehwCqnu/p2t7i
    nczEZ6qcvBT9faFQ1JLawCf8pPxWhW6YhiWrj1StqqZnHu+hBufpYusDSXS3jNAv
    DICB7JISPdNKS8lcYWCsg==
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
X-CM-Envelope: MS4wfIJw/CfxzxJ7a6AxKR6DDAd4hgCl6hF4fsEUD8cLhnIwR8ES/nEIZvhbXs3O52cMcyl7k3xo12YDkq0IgpwGjp54FCOgHFkFa6a0vK5BmCoFLkBQUb4A
    anjb0/EMDs67l6j59GEv9Ho5IeLrzKnfiBd1anL0odAndEuy81dnsKiwehUOZ1oFjTUKzExIZh/QTq+pRz3jwSLo+zQpIDTILQrAoBrYcf7o5GEcmf3iJOoQ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10 a=FqpbrowB-PMA:10 a=JfrnYn6hAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=00oK3br-KyTmRtsW3bcA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbeC1UTo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 16:19:44 -0400
Received: from mail.efficios.com ([167.114.142.138]:43406 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753117AbeC1UTo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 16:19:44 -0400
Date: Wed, 28 Mar 2018 16:19:42 -0400 (EDT)
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
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Message-ID: <181076499.279.1522268382303.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180328174935.GK4082@hirez.programming.kicks-ass.net>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com> <20180328125004.GV4043@hirez.programming.kicks-ass.net> <1523662633.2105.1522248474778.JavaMail.zimbra@efficios.com> <20180328145946.GH4082@hirez.programming.kicks-ass.net> <265889560.1.1522250045589.JavaMail.zimbra@efficios.com> <20180328152814.GI4082@hirez.programming.kicks-ass.net> <533214853.56.1522251426819.JavaMail.zimbra@efficios.com> <20180328174935.GK4082@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable
 sequences system call (v12)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: rseq: Introduce restartable sequences system call (v12)
Thread-Index: bEjhuarc8VPJ++TKQ/ToKu8jnOwSeA==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Mar 28, 2018, at 1:49 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Wed, Mar 28, 2018 at 11:37:06AM -0400, Mathieu Desnoyers wrote:
>> ----- On Mar 28, 2018, at 11:28 AM, Peter Zijlstra peterz@infradead.org wrote:
>> 
>> > On Wed, Mar 28, 2018 at 11:14:05AM -0400, Mathieu Desnoyers wrote:
>> > 
>> >> > If at all possible I would make it SIGSEGV when issueing SYSCALL()s from
>> >> > within an RSEQ.
>> >> 
>> >> What's the goal there ? rseq critical sections can technically do system calls
>> >> if they wish. Why prevent this ?
>> > 
>> > This all started as a way to do 'small' _fast_ per-cpu ops, System calls
>> > do NOT fit in that pattern. If you're willing to do a system calls the
>> > cost of atomics is not a problem.
>> 
>> I'm not arguing that a typical rseq would do a system call. I'm merely
>> pointing out that if we start putting arbitrary limitations like "SIGSEGV
>> when a fork or system call is encountered on top of rseq", this will cause
>> pain in user-space.
> 
> I don't think disallowing system calls is arbitrary. And I think that is
> something we really want to enforce, because it's batshit insane to
> allow.
> 
> And if we allow now, people _will_ use it and we can't ever take it
> away again.

Here are some examples of how I would like to use system calls within
rseq critical sections, for testing purposes:

- Issue poll(NULL, 0, ms_timeout) from a rseq critical section, to introduce
  a delay in the critical section and test the effect,
- Issue sched_yield() from a rseq critical section, to introduce preemption at
  that point,
- Issue kill() on self, thus testing interruption by signals over rseq c.s.,
- Invoke sched_setaffinity to tweak the cpu affinity mask to force thread
  migration within a rseq c.s.

I currently have only implemented the poll(), sched_yield() and kill()
test-cases outside of the rseq critical sections, instead relying on
assembly loops to introduce delays in rseq c.s.. However, if we disallow
system calls in rseq critical sections, I'll never be able to use those
systems calls to extend the test matrix.

I see other use-cases where having a system call in a rseq critical section
could make sense: if vDSO data shared between kernel and user-space rely
on rseq for synchronization, but a fallback sometimes needs to issue a system
call for part of the operation.

Therefore I'd really want to keep allowing system calls within rseq critical
sections, even though we don't expect this to be the typical use-case.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
