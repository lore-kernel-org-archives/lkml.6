Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07594C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF46620868
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="fXXuDk4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF46620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441018AbeKXEhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:37:39 -0500
Received: from mail.efficios.com ([167.114.142.138]:44994 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbeKXEhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:37:39 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5B70380DC6;
        Fri, 23 Nov 2018 12:52:22 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id hYq9d5zcCxay; Fri, 23 Nov 2018 12:52:21 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 8FB6D80DBF;
        Fri, 23 Nov 2018 12:52:21 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8FB6D80DBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1542995541;
        bh=W3C9jppVpnmK0YZX4i7gGbENo5LXaJ+HUqqmIA0Yc4M=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=fXXuDk4UvA8Nw+IwMMUyaeEqpqIfe/tJR2gKZFKuktSYEMUxl/a+334j0kD1vHmS5
         942AiS8p2nrd6PzpJ8ZMcZKIuUxvRniSIyIdzPFjRro9blAIXG+DPSpscF37O3Fj8y
         NSqBIRQzAF2nE+aAednF+bWoegIoYINzkQpnCNtMwnjQXV+hmow8mYGCqlYn0ZHFoS
         n3xO4gg8Za10IhmrliQYuP7Jp3521mh75r7VVwtEjFQ1Do3LjHaryX/XiuoCEzObcJ
         ggLQMN64UrVsMqcVHHhOICH5kiwfzMUZlk1iJ1nkQrtc3HWdzuAzVQF22W13EuAIC1
         +FfS6zkMe6iLQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id gR0nWQ2QjrrA; Fri, 23 Nov 2018 12:52:21 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 6F5EB80DB7;
        Fri, 23 Nov 2018 12:52:21 -0500 (EST)
Date:   Fri, 23 Nov 2018 12:52:21 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Rich Felker <dalias@libc.org>
Cc:     Florian Weimer <fweimer@redhat.com>, carlos <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <865273158.11687.1542995541389.JavaMail.zimbra@efficios.com>
In-Reply-To: <20181123173019.GK23599@brightrain.aerifal.cx>
References: <20181121183936.8176-1-mathieu.desnoyers@efficios.com> <1045257294.10291.1542905262086.JavaMail.zimbra@efficios.com> <87k1l5xd33.fsf@oldenburg.str.redhat.com> <20181122171010.GH23599@brightrain.aerifal.cx> <871s7cvt1l.fsf@oldenburg.str.redhat.com> <20181123142843.GJ23599@brightrain.aerifal.cx> <1150466925.11664.1542992720871.JavaMail.zimbra@efficios.com> <20181123173019.GK23599@brightrain.aerifal.cx>
Subject: Re: [RFC PATCH v4 1/5] glibc: Perform rseq(2) registration at nptl
 init and thread creation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3047 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: glibc: Perform rseq(2) registration at nptl init and thread creation
Thread-Index: +tP/nHsSVTVHcfxkwhXbP9/nYqpEyA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Nov 23, 2018, at 12:30 PM, Rich Felker dalias@libc.org wrote:

> On Fri, Nov 23, 2018 at 12:05:20PM -0500, Mathieu Desnoyers wrote:
>> ----- On Nov 23, 2018, at 9:28 AM, Rich Felker dalias@libc.org wrote:
>> [...]
>> > 
>> > Absolutely. As long as it's in libc, implicit destruction will happen.
>> > Actually I think the glibc code shound unconditionally unregister the
>> > rseq address at exit (after blocking signals, so no application code
>> > can run) in case a third-party rseq library was linked and failed to
>> > do so before thread exit (e.g. due to mismatched ref counts) rather
>> > than respecting the reference count, since it knows it's the last
>> > user. This would make potentially-buggy code safer.
>> 
>> OK, let me go ahead with a few ideas/questions along that path.
>                                                 ^^^^^^^^^^^^^^^
>> 
>> Let's say our stated goal is to let the "exit" system call from the
>> glibc thread exit path perform rseq unregistration (without explicit
>> unregistration beforehand). Let's look at what we need.
> 
> This is not "along that path". The above-quoted text is not about
> assuming it's safe to make SYS_exit without unregistering the rseq
> object, but rather about glibc being able to perform the
> rseq-unregister syscall without caring about reference counts, since
> it knows no other code that might depend on rseq can run after it.

When saying "along that path", what I mean is: if we go in that direction,
then we should look into going all the way there, and rely on thread
exit to implicitly unregister the TLS area.

Do you see any reason for doing an explicit unregistration at thread
exit rather than simply rely on the exit system call ?


> 
>> First, we need the TLS area to be valid until the exit system call
>> is invoked by the thread. If glibc defines __rseq_abi as a weak symbol,
>> I'm not entirely sure we can guarantee the IE model if another library
>> gets its own global-dynamic weak symbol elected at execution time. Would
>> it be better to switch to a "strong" symbol for the glibc __rseq_abi
>> rather than weak ?
> 
> This doesn't help; still whichever comes first in link order would
> override. Either way __rseq_abi would be in static TLS, though,
> because any dynamically-loaded library is necessarily loaded after
> libc, which is loaded at initial exec time.

OK, AFAIU so you argue for leaving the __rseq_abi symbol "weak". Just making
sure I correctly understand your position.

Something can be technically correct based on the current implementation,
but fragile with respect to future changes. We need to carefully distinguish
between the two when exposing ABIs.

> 
>> There has been presumptions about signals being blocked when the thread
>> exits throughout this email thread. Out of curiosity, what code is
>> responsible for disabling signals in this situation ?

This question is still open.

> Related to this,
>> is it valid to access a IE model TLS variable from a signal handler at
>> _any_ point where the signal handler nests over thread's execution ?
>> This includes early start and just before invoking the exit system call.
> 
> It should be valid to access *any* TLS object like this, but the
> standards don't cover it well. Right now access to dynamic TLS from
> signal handlers is unsafe in glibc, but static is safe.

Which is a shame for the lttng-ust tracer, which needs global-dynamic
TLS variables so it can be dlopen'd, but aims at allowing tracing from
signal handlers. It looks like due to limitations of global-dynamic
TLS, tracing from instrumented signal handlers with lttng-ust tracepoints
could crash the process if the signal handler nests early at thread start
or late before thread exit. One way out of this would be to ensure signals
are blocked at thread start/exit, but I can't find the code responsible for
doing this within glibc.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
