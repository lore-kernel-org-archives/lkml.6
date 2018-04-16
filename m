Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3845642-1523903714-2-13144604106414421691
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
    1523903713; b=ld8WKVvKqXaRjRKcCb7dnkelQ7SqUDMuQ7FDSDwG3EzJ8CKW12
    SMM7A0/rotttRM81HmVcCEEKmUvImdcAVQdn2HxI63O4NTTBryPSCdgnI/kIWe8N
    XCUsT9mkV2he0ipq1caGt/QECdg2fYeE7ZvoJ6TtDjgR1UtxIc5z6YEM74MX82ae
    SUj3WLOIdpSOhFQDsaGAgDTjBAhVLcitegqlL50JP1LgtFcKHkpUNK/skR9Ldde4
    f7aXriw90WPVzn02FMVsYh59H2oOWzT7dKbfKRMWofCDM4d3Y2e3OCz/ESOzFbRZ
    jQRJRXTQjZ+REEWlIvvz+S7J90IyF/uCpKyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523903713;
    bh=Z99mx5ZuRBn2eb22EoqCaDpn2lTQG3t5m6GaGYJD1AA=; b=pPEdLDdxpKpi
    +2Z1RIX3eRK43yRZ0TVrr36LGmRjmnOGfzyEFPwS4v+Vuui/XEehKNswrHl+8aBW
    +EyKTSg6sie9Tm85+naAxCJ+KgHvzjD2z3tdT9KaPuQcfQSlYUjaplObMp95r7O8
    XJ9d3x8E8FVbgB/HQZA95kTGgn6Rj+kwjX4gC8qgWtieVM5TGNiRnxzFC43fOtkB
    za9YR+va4OkkGy3UamUNvficlPehO4qogXag3WFKHdwaBUI0b1XyTVh7oNFnEIF0
    4QKgKjC64slQF/wusFGGg8lXJjbpf5XBcvTyprZwrmMQC7ra11j5VrWWLo5hJwPJ
    jBlaw5Hp1Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfGKH+WkmLt/E9Ux1m6+py2qGR/TqZOk7RkWlV8vEbUrjCb6YoDq3Bf+Il7J414edH7uTSglQefbRJxlKBvvHJuR7fBPTZ/KZdkn0zjrT06pl/imRdZzs
    jKM4wnNWju6DfNQ+he1g6Nc5+ZYbHMeILVjirC1aaLQQ3Logef9brSVAHdA159W1CJEMVGvVKdHiAOllN+cNz09DljXay7BZzJ95jf6gV8vFExheeG8IHtP7
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10 a=FqpbrowB-PMA:10 a=SOq6UgPBAAAA:8
    a=Z4Rwk6OoAAAA:8 a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=0N3rfshJV4VCv5SGXDcA:9
    a=A_kMucVZRLY5aBtj:21 a=XIjGI360wCJt4b1J:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=3hv5r9HjGAh9o5iR9qwG:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=jhqOcbufqs7Y1TYCrUUU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753077AbeDPSfL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 14:35:11 -0400
Received: from mail.efficios.com ([167.114.142.138]:45586 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753041AbeDPSfK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Apr 2018 14:35:10 -0400
Date: Mon, 16 Apr 2018 14:35:08 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <542721578.11358.1523903708510.JavaMail.zimbra@efficios.com>
In-Reply-To: <CALCETrVvaMWUJKx+bxXdEm3oVBzn2r5RuJ4JcXNzOPSgJAC5PA@mail.gmail.com>
References: <20180412192800.15708-1-mathieu.desnoyers@efficios.com> <20180412192800.15708-13-mathieu.desnoyers@efficios.com> <CA+55aFxcJ2V_1BoW0Cct=Kkp7REkgiU_BTimGdmoFmWHaWaZ-g@mail.gmail.com> <CALCETrVvaMWUJKx+bxXdEm3oVBzn2r5RuJ4JcXNzOPSgJAC5PA@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 12/23] cpu_opv: Provide cpu_opv system call
 (v7)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: cpu_opv: Provide cpu_opv system call (v7)
Thread-Index: NmD6hr5r2xyh9jymP4P9RCOu0pasUA==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Apr 14, 2018, at 6:44 PM, Andy Lutomirski luto@amacapital.net wrote:

> On Thu, Apr 12, 2018 at 12:43 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Thu, Apr 12, 2018 at 12:27 PM, Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:
>>> The cpu_opv system call executes a vector of operations on behalf of
>>> user-space on a specific CPU with preemption disabled. It is inspired
>>> by readv() and writev() system calls which take a "struct iovec"
>>> array as argument.
>>
>> Do we really want the page pinning?
>>
>> This whole cpu_opv thing is the most questionable part of the series,
>> and the page pinning is the most questionable part of cpu_opv for me.
>>
>> Can we plan on merging just the plain rseq parts *without* this all
>> first, and then see the cpu_opv thing as a "maybe future expansion"
>> part.
>>
>> I think that would make Andy happier too.
>>
> 
> It only makes me happier if the userspace code involved is actually
> going to work when single-stepped, which might actually be the case
> (fingers crossed).

Specifically for single-stepping, the __rseq_table section introduced
at user-level will allow newer debuggers and tools which do line and
instruction-level single-stepping to skip over rseq critical sections.
However, this breaks existing debuggers and tools.

For a userspace tracer tool such as LTTng-UST, requiring upgrade to newer
debugger versions would limit its adoption in the field. So if using rseq
breaks current debugger tools, lttng-ust won't use rseq until
single-stepping can be done in a non-breaking way, or will have to wait
until most end-user deployments (distributions used in the field) include
debugger versions that skip over the code identified by the __rseq_table
section, which will take many years.

> That being said, I'm not really convinced that
> cpu_opv() makes much difference here, since I'm not entirely convinced
> that user code will actually use it or that user code will actually be
> that well tested.  C'est la vie.

For the use-case of cpu_opv invoked as single-stepping fall-back, this path
will indeed not be executed often enough to be well-tested. I'm considering
the following approach to allow user-space to test cpu_opv more thoroughly:
we can introduce an environment variable, e.g.:

- RSEQ_DISABLE=1: Disable rseq thread registration,
- RSEQ_DISABLE=random: Randomly disable rseq thread registration (some threads
  use rseq, other threads end up using the cpu_opv fallback)

which would disable the rseq fast-path for all or some threads, and thus allow
thorough testing of cpu_opv used as single-stepping fallback.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
