Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2775900-1525363947-5-10673359975011145715
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CA'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525363947; b=eywm058aRO6VdeIqz2GgLbU05tZxcfN62PgjGhv/cIRYm36Wp0
    yhDGSbWXvnN1jpLMeImBEEBLjpgiOZKhfTRzlR31+YLsD6JObwrrgcxv0pQHAqi1
    1YCSDEU+qsng8gLgquFDh9D3CQDPD1g9Z5TZw46a2T3B6ShzimWz9UG/c+Vwhr+F
    hdytzGfDVLu3MOwekinlkJJRuKdAkI0XwGyanwoX612ibb3nfU1nodLc4rOAGaL5
    VDy52MLAPBbgg0xg0OqkwrI04qVlQPR4lIb9qBKzomMC9dFN0/+zFFx5y4Y/YvRi
    OY2bGiSWoOpa3rq36Q0hr6UrRvNMbZX3C8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525363947;
    bh=nhPaatCTdQF/MwhcenfAyfB0Wq41HZrrPcQ1OUsS+1I=; b=Y2HQixMARPAF
    0C5Ry6+J56Rj/7h5pj7VuOBSp6ZVM+ASiGc9A2lPbggfcml2TpmlWn9TasXTWXsd
    +H42nzLitwnb3H3UiFC5uKInGE0phbECvRxpq8Zvm1IKJHB2XpRerEIoS5y4Eojf
    3JxBvSW5WU6vazO5X3ExLDlG0yWsTghos8s8hvkujTHS57GNXJA+LMquk0qUHqEY
    NNUmsY9WbWKqH0ht24hBdWWPkbWYCwYDE0BHYURQZzvo/mAG3pk3IG1OuX8IasAc
    EzzYuQ1lgtf8qmCp3GnhOHN+X+7iLBVZyp+lCitFk04kk7L/IyxvEpIGLO/2LvCr
    rO+oVpcFfw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=efficios.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=efficios.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBCHzXIyT7I+BOaokbsppZDBwwQ3gE04V6cKcVZLm+S5mkd1h/MjmMx2rb5JbzXxUEk6IPZdHGRqSyeSiDGqxuPPpaPzAel+mreFMJEBBLbJ9Imb//B5
    VF5N9R7I3YFZyZTmkKYG5YrhvJoRH54o9MFhU7Gcu+oMDfpN6eHrJ46lsvJ1S/qIZSRQ3IgUs/EfqDRSlWNH9k+HYuTaGUKItPchtFyB2WgVZPLEV5s3fiOY
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10 a=FqpbrowB-PMA:10 a=1XWaLZrsAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=ttjPp6rkgr7zkfrUtUMA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeECQMY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 12:12:24 -0400
Received: from mail.efficios.com ([167.114.142.138]:51388 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbeECQMX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 12:12:23 -0400
Date: Thu, 3 May 2018 12:12:21 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Daniel Colascione <dancol@google.com>
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
        Joel Fernandes <joelaf@google.com>
Message-ID: <1718748931.10084.1525363941807.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAKOZueu_7Ha_WXMyxqMEScXo1aHWr9qYRxqyb-Rpd4k1JP3xHA@mail.gmail.com>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com> <CAKOZuesa338sc_=w6-wvro25idrSN_zx_zrHFyo-bDiORs7FZw@mail.gmail.com> <660904075.9201.1525276988842.JavaMail.zimbra@efficios.com> <CAKOZueu_7Ha_WXMyxqMEScXo1aHWr9qYRxqyb-Rpd4k1JP3xHA@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 00/14] Restartable Sequences
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2009 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_2009)
Thread-Topic: Restartable Sequences
Thread-Index: 7fukaqctSGjCOecB52A5d9zYEWZiUg==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On May 2, 2018, at 12:07 PM, Daniel Colascione dancol@google.com wrote:

> On Wed, May 2, 2018 at 9:03 AM Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
> 
>> ----- On May 1, 2018, at 11:53 PM, Daniel Colascione dancol@google.com
> wrote:
>> [...]
>> >
>> > I think a small enhancement to rseq would let us build a perfect
> userspace
>> > mutex, one that spins on lock-acquire only when the lock owner is
> running
>> > and that sleeps otherwise, freeing userspace from both specifying ad-hoc
>> > spin counts and from trying to detect situations in which spinning is
>> > generally pointless.
>> >
>> > It'd work like this: in the per-thread rseq data structure, we'd
> include a
>> > description of a futex operation for the kernel would perform (in the
>> > context of the preempted thread) upon preemption, immediately before
>> > schedule(). If the futex operation itself sleeps, that's no problem: we
>> > will have still accomplished our goal of running some other thread
> instead
>> > of the preempted thread.
> 
>> Hi Daniel,
> 
>> I agree that the problem you are aiming to solve is important. Let's see
>> what prevents the proposed rseq implementation from doing what you
> envision.
> 
>> The main issue here is touching userspace immediately before schedule().
>> At that specific point, it's not possible to take a page fault. In the
> proposed
>> rseq implementation, we get away with it by raising a task struct flag,
> and using
>> it in a return to userspace notifier (where we can actually take a
> fault), where
>> we touch the userspace TLS area.
> 
>> If we can find a way to solve this limitation, then the rest of your
> design
>> makes sense to me.
> 
> Thanks for taking a look!
> 
> Why couldn't we take a page fault just before schedule? The reason we can't
> take a page fault in atomic context is that doing so might call schedule.
> Here, we're about to call schedule _anyway_, so what harm does it do to
> call something that might call schedule? If we schedule via that call, we
> can skip the manual schedule we were going to perform.

By the way, if we eventually find a way to enhance user-space mutexes in the
fashion you describe here, it would belong to another TLS area, and would
be registered by another system call than rseq. I proposed a more generic
"TLS area registration" system call a few years ago, but Linus told me he
wanted a system call that was specific to rseq. If we need to implement
other use-cases in a TLS area shared between kernel and user-space in a
similar fashion, the plan is to do it in a distinct system call.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
