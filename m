Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-219062-1525444392-2-4650878315493392476
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CA'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525444391; b=AW3FHWJBCeg/k69iaulUKkxGLqM/32KP5ZcsrOn07Vtf1suQqg
    Z2gvjWWOZp9imrimQp4LvQ0SH01ytdQwutMvPHDE7s6m2nVxWnGxqk45hRmz867A
    iTjuRs76OtDroJ49+NhKQkP7hdLA0t8TBz7wz4tYhPbOXw6+6/L8ieIcTvalfYeV
    i6kyB0Hf2ACHYql122ALghG0DRfVEL7NLSf8WnYTz/GGQ3U2Z9aaIpkeGbshWtvk
    PnnS7GeFqTKyhGPhmlTTbskL4WJD1g73pkMpP5VCn3f2K2Jb8KqJVJ4LWwF3x12w
    ly/tE6+sJypObQqMNFlxelGVaBMAWZIj4RPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525444391;
    bh=kTPGRncpv1b7A9tFc0+bnaSvugxPfV7nAGqbSCQqiLE=; b=EoUeIAHJ+XKS
    55jbz3CRoEW20THcoVUDWXKCmOQwaf0bFeqq/zizXFa41ylmn1P/wlHVE9v1KpUe
    4yXSpTFH8NIejfb8CM0HmN53X9Qyab/tpb6SYXara4KzC2YgLrF7VZEna1TdG0gO
    KHUiOfhtgplnxYptN/eNOw/WLFRB4btx1v2I/GZWt+sDYIZYrFFGnWXrZTGdvjDp
    iV8ysdNiTDQQjgHNkmMtD44paHcXDmJjB1AZ65W9dmgvEEjAKBBf43Vep/tWe5sS
    jpxbxMu00CtlaN+a+ZmLDHm/89amjs+yVA1NTKzn9RmIhKakE/3ij3s9n+JSYx/j
    fUdhGEcczA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfCwnN0VZx37Roov22WzliIz1Qz8aNrG3p8M+NJ52yYyKFhYoXvmuXi9dTuhvMzQwbj+2VFF24fFiXCfAz3ohHDr/iqVpfoQ3EqOqb2kkgu2eP7N0AY/Y
    ea2k/ySIL8ly6ADjCDZPMT+s8mUIolb01y6YCgRaOzdy39us0tti7GLHHoZf0J5sqJuu7l45oHY/YiKLnugMsEGt0T1c2UUH2LsBTPNd92JUEXld55RGVa4J
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10 a=FqpbrowB-PMA:10 a=7d_E57ReAAAA:8
    a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=P_bkSVp_PKxj2KBXSR8A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeEDOc5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 10:32:57 -0400
Received: from mail.efficios.com ([167.114.142.138]:47024 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751341AbeEDOcz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 May 2018 10:32:55 -0400
Date: Fri, 4 May 2018 10:32:53 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Message-ID: <1883133260.11283.1525444373208.JavaMail.zimbra@efficios.com>
In-Reply-To: <1248652824.11527.1523912317964.JavaMail.zimbra@efficios.com>
References: <20180412192800.15708-1-mathieu.desnoyers@efficios.com> <CA+55aFxcJ2V_1BoW0Cct=Kkp7REkgiU_BTimGdmoFmWHaWaZ-g@mail.gmail.com> <CALCETrVvaMWUJKx+bxXdEm3oVBzn2r5RuJ4JcXNzOPSgJAC5PA@mail.gmail.com> <542721578.11358.1523903708510.JavaMail.zimbra@efficios.com> <CA+55aFzZtY5ELKc+TGf9BA6px300BNzedadm_yNXzODTKN=HgQ@mail.gmail.com> <435471300.11403.1523906479091.JavaMail.zimbra@efficios.com> <CA+55aFxtZXi05UNLmtbKcZ=2N_ROE5pLnu9+v6FaXiuK=VbErA@mail.gmail.com> <1248652824.11527.1523912317964.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC PATCH for 4.18 12/23] cpu_opv: Provide cpu_opv system call
 (v7)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2009 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_2009)
Thread-Topic: cpu_opv: Provide cpu_opv system call (v7)
Thread-Index: RuF2OosSEg2Wu4cnvUvTkLUnST/FrbZ7wM3c
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Apr 16, 2018, at 4:58 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Apr 16, 2018, at 3:26 PM, Linus Torvalds torvalds@linux-foundation.org
> wrote:
> 
>> On Mon, Apr 16, 2018 at 12:21 PM, Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:
>>>
>>> And I try very hard to avoid being told I'm the one breaking
>>> user-space. ;-)
>> 
>> You *can't* be breaking user space. User space doesn't use this yet.
>> 
>> That's actually why I'd like to start with the minimal set - to make
>> sure we don't introduce features that will come back to bite us later.
>> 
>> The one compelling use case I saw was a memory allocator that used
>> this for getting per-CPU (vs per-thread) memory scaling.
>> 
>> That code didn't need the cpu_opv system call at all.
>> 
>> And if somebody does a ldload of a malloc library, and then wants to
>> analyze the behavior of a program, maybe they should ldload their own
>> malloc routines first? That's pretty much par for the course for those
>> kinds of projects.
>> 
>> So I'd much rather we first merge the non-contentious parts that
>> actually have some numbers for "this improves performance and makes a
>> nice fancy malloc possible".
>> 
>> As it is, the cpu_opv seems to be all about theory, not about actual need.
> 
> I fully get your point about getting the minimal feature in. So let's focus
> on rseq only.
> 
> I will rework the patchset so the rseq selftests don't depend on cpu_opv,
> and remove the cpu_opv stuff. I think it would be a good start for the
> Facebook guys (jemalloc), given that just rseq seems to be enough for them
> for now. It should be enough for the arm64 performance counters as well.
> 
> Then we'll figure out what is needed to make other projects use it based on
> their needs (e.g. lttng-ust, liburcu, glibc malloc), and whether jemalloc
> end up requiring cpu_opv for memory migration between per-cpu pools after all.

So, having done this, I find myself in need of advice regarding smoothly
transitioning existing user-space programs/libraries to rseq. Let's consider
a situation where only rseq (without cpu_opv) eventually gets merged into
4.18.

The proposed rseq implementation presents the following constraints:

- Only a single rseq TLS can be registered per thread, therefore rseq needs
  to be "owned" by a single library (let's say it's librseq.so),
- User-space rseq critical sections need to be inlined into applications and
  libraries for performance reasons (extra branches and calls significantly
  degrade performance of those fast-paths).

I have a ring buffer "space reservation" use-case in my user-space tracer
which requires both rseq and cpu_opv.

My original plan to transition this fast-path to rseq was to test the
@cpu_id field value from the rseq TLS and use a fallback based on
atomic instructions if it is negative. rseq is already designed to ensure
we can compare @cpu_id against @cpu_id_start and detect both migration
(cpu id differs) and rseq ENOSYS with a single branch in the fast path.

Once rseq gets merged and deployed into kernels, this means librseq.so
will actually populate the rseq TLS, and this @cpu_id field will be >= 0.
If kernels are released with rseq but without cpu_opv, then I cannot use
this @cpu_id field to detect whether *both* rseq and cpu_opv are available.

I see a few possible ways to handle this, none of which are particularly
great:

1) Duplicate the entire implementation of the user-space functions where
   the rseq critical sections are inlined, and dynamically detect whether
   cpu_opv is available, and select the right function at runtime. If those
   functions are relatively small this could be acceptable,

2) Code patching based on asm goto. There is no user-space library for
   this at the moment AFAIK, and patching user-space code triggers COW,
   which is bad for TLB and cache locality,

3) Add an extra branch in the rseq fast-path. I would like to avoid this
   especially on arm32, where the cost of an extra branch is significant
   enough to outweigh the benefit of rseq compared to ll/sc.

So far, only option (1) seems relatively acceptable from my perspective,
but that's only because my functions using rseq are relatively small.
If this code bloat is not seen as acceptable, then we should revisit
merging both rseq and cpu_opv at the same time, and make sure CONFIG_RSEQ
selects CONFIG_CPU_OPV.

Thoughts ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
