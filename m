Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2891730-1525369644-2-12321895932568071280
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525369643; b=FoFFFyhyrHSUF/HKN//2HU8HFFDNE/kDIrA862/vNvL1m250nk
    EAeaNiZqZ6PoueEq76/3bSSqJ0Q/bc3A7DQXBLRosG2Hr+rtw8kaY2Q4TOoHXiud
    zETWtGV2CwGcGoSaMAVNY97SQ6AZApQIP34fPlXmYINQo7ATqNN6WDKVxeHSsU/L
    QWMXGZ6T4/vIuPF7RsDk8xC9U2pVGwSCpuG2rQZNBzvXXNdXlpqdxc4PMRSfeLQh
    Y6u2u3RCo4h0cCAgQi2ylkgZSEM3OWL817zV19DTxamyyLhGf+xwbvnta3wcexr7
    2xNFlESMFwYjqT8LdM+Ca83ZO8f4mtI+uc0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525369643; bh=8E+fBa59yL6fgVPqbx6aKqILOe2ZqyaFG8Aei3VjBg
    g=; b=ihj96FDAyZ3++Q4MLqcngiV2T86/+iT4lm8GIt3sKxyYfKEXXUOBi+vQQ3
    ab0Bd2TrWyeLjmZkdVC9iNZbMqMQzpZvovi95puMMJQ3GkrYQ4BYD8I1JbmL+wd0
    gwZeWiWNEiCK6jxlHjVBe0jsHuP3ElDt+ir1l48iE46sMm7n7k8ba5ERegNsk+i7
    NeFyHKE2Ih3qeLIBrpk9f62TBxSj1hqyvI2VMDOv4RzH3j0YCxE3D0jDRv+6SB2G
    6TknSG3Sh+1VxB7qnxFCK+8OykqH9stflBcsUpIeJHbx2rgRo+ykC0csjwCyUkBt
    05pro70ce4NfhbNHzRDEZOnyk4wg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=HQcD4lpT x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=DEH09IsA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=HQcD4lpT x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=DEH09IsA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCHQCxgW9pAuWH5yePOQSohyjhSfRya7ohziq/v/AhbolCk8hLWKl4tkrnuGTFRnAH2kdYwJ6ZUHYjmC7MU08434agWfBYk/1S1s1zIETSBp20xa3mvm
    xLUwpFbB40uqywj3SzbcVcFGb7Z/ABWvmLBt8uVW6oVRVhEL/krL99k/5Mja3KhxR5frLbjmbPlTOqIf7lmDjAntGAmRFUXBCECNwtER10vPhwW8KeG7y5g3
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=DuHxDvBwUJnmfPQpNwQA:9
    a=M9Dq_LPNR4ndO0sm:21 a=2PPVzPv7XD1yL-Ok:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbeECRrK (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 13:47:10 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35692 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbeECRrI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 13:47:08 -0400
X-Google-Smtp-Source: AB8JxZpzfBscIu6cg1pxdR6tSbWLUuCTn3GGl4Jpvi3I4680m6B7kyop7Hy9CO00pEmXJcFc7BW5ej3gi8JElaJpjTc=
MIME-Version: 1.0
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <CAKOZuesa338sc_=w6-wvro25idrSN_zx_zrHFyo-bDiORs7FZw@mail.gmail.com>
 <660904075.9201.1525276988842.JavaMail.zimbra@efficios.com>
 <CAKOZueu_7Ha_WXMyxqMEScXo1aHWr9qYRxqyb-Rpd4k1JP3xHA@mail.gmail.com>
 <1718748931.10084.1525363941807.JavaMail.zimbra@efficios.com>
 <CAJWu+opXjYrjrz1=k0TjjCqiYQ0y=6jRMiRWNvb8_dHAtSByug@mail.gmail.com> <CAKOZueve1K8bmS0pmeCAAburoJtzRA4DeN=OCyW3kHiNo8WO=A@mail.gmail.com>
In-Reply-To: <CAKOZueve1K8bmS0pmeCAAburoJtzRA4DeN=OCyW3kHiNo8WO=A@mail.gmail.com>
From: Joel Fernandes <joelaf@google.com>
Date: Thu, 03 May 2018 17:46:55 +0000
Message-ID: <CAJWu+opkzpmwY5jJ0353JKyaOFCqa95AKGhxUdQZ6pZf_omsaQ@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 00/14] Restartable Sequences
To: Daniel Colascione <dancol@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>, davejwatson@fb.com,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux@arm.linux.org.uk, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Andrew Hunter <ahh@google.com>, andi@firstfloor.org,
        cl@linux.com, bmaurer@fb.com, Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        torvalds@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, mtk.manpages@gmail.com,
        longman@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Daniel,
Nice to have this healthy discussion about pros/cons. Adding Waiman to the
discussion as well. Curious to hear what Waiman and Peter think about all
this. Some more comments inline.

On Thu, May 3, 2018 at 10:19 AM Daniel Colascione <dancol@google.com> wrote:

> On Thu, May 3, 2018 at 9:48 AM Joel Fernandes <joelaf@google.com> wrote:
> > > > can skip the manual schedule we were going to perform.

> > > By the way, if we eventually find a way to enhance user-space mutexes
in
> > the
> > > fashion you describe here, it would belong to another TLS area, and
> would
> > > be registered by another system call than rseq. I proposed a more
> generic

> > Right. Also I still don't see any good reason why optimistic spinning in
> > the kernel with FUTEX_LOCK, as Peter described, can't be used instead of
> > using the rseq implementation and spinning in userspace, for such a
case.
> I
> > don't really fully buy that we need to design this interface assuming
any
> > privilege transition level time.

> > If privilege level transitions are slow,
> > we're going to have bad performance anyway.

> That's not the case. There's a large class of program that does useful
work
> while seldom entering the kernel: just ask the user-space network stack
> people.

Yes, I am aware of that. I was just saying in general, a system such as an
Android embedded system, not an HPC based system does make a lot of system
calls. I am not arguing that doing more things in userspace is good or bad
here. I am just talking about why do something else for no good reasons
(see below) when work has already been done on this area.

> It's not wise to design interfaces around system calls being cheap. Even
if
> system calls are currently cheap enough on some architectures some of the
> time, there's no guarantee that they'll stay that way, especially relative
> to straight-line user-mode execution. A pure user-space approach, on the
> other hand, involves no work in the kernel, and doing nothing is always
the
> optimal strategy. Besides, there are environments where system calls end
up
> being more expensive than you might think: consider strace or rr. If the
> kernel needs to get involved on some path, it's best that its involvement
> be as light as possible.

Ofcourse, but I think we shouldn't do a premature optimization here without
real data on typical Android devices about the cost of system calls
entry/exit, vs spin time. I am not against userspace lock based on rseq if
there is data and good reason, before investing significant time on
reinventing the wheel.

> > we should really stick to using FUTEX_LOCK and
> > reuse all the work that went into that area for Android and otherwise
(and
> > work with Waiman and others on improving that if there are any problems
> > with it).

> FUTEX_LOCK is a return to the bad old days when systems gave you a fixed
> list of synchronization primitives and if you wanted something else,
tough.

I am not saying we should fix sync. primitives made available to userspace,
or anything. I am talking about yours/our usecase and whether another sync
primitive interface is needed. For example, have another syscall to
register TLS area is a new interface, vs using the existing futex
interface. Linus is also against adding new sycalls unnecessarily.

> That the latest version of the FUTEX_LOCK patch includes a separate
> FUTEX_LOCK_SHARED mode is concerning. The functionality the kernel
provides

Why? That's just for reader-locks. What's the concern there? I know you had
something in mind about efficient userspace rw locks but I am curious
either way what you have in mind.

> to userspace should be more general-purpose and allow more experimentation
> without changes in the kernel. I see no reason to force userspace into 1)
> reserving 30 bits of its lockword for a TID and 2) adopting the kernel's

Based on our offline chat, this is for only 32-bit only systems though
right? Also based on Peter's idea of putting the recursion counter outside,
there shouldn't be a space issue?

> idea of spin time heuristics and lock stealing when the same basic
> functionality can be provided in a generic way while reserving only one
> bit. That this mechanism happens to be more efficient as well is a bonus.

And also probably easy to get wrong. Heuristics are hard and it would be
good to work with community on getting best approach for that and improving
existing code. Also about "generic way", that's even more reason in my view
to do it in the kernel.

> "Mechanism not policy" is still a good design principle.

Again, I am not advocating forcing of interfaces anything, but I'm against
reinventing the wheel and am all for spending time on improving existing
things.

thanks!

- Joel
