Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4124C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6158D20824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mDBWDTUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6158D20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405853AbeKWC04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:26:56 -0500
Received: from mail.efficios.com ([167.114.142.138]:52270 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbeKWC04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:26:56 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4939F133084;
        Thu, 22 Nov 2018 10:47:01 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id ZJBK8hBcCeWE; Thu, 22 Nov 2018 10:47:00 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6A08913307A;
        Thu, 22 Nov 2018 10:47:00 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6A08913307A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1542901620;
        bh=f9l8GxdJ82Q0LdlBiPs0Kd1qm98AmnPQGq5wUPcULN0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=mDBWDTUTpnLKCltzA3JWZ/2x3+BG7NOZqHra3+IZT46bdW5M0TuaC1EQdBKYwIX3f
         g1PII7f5jTj18rBKMvRdcxYTLWBWi5/XnV8PWB5LCP+EpSXym9y4a8oB09zux9em1D
         61o9SCjcXem6yFo7trgFjM/coJkzRvvUIRhqsz16zLpHvufSRJ36CjeHVx3mVxllJw
         Gc9ysTRje1RH3AAABO+cifsMi5pLst1We00unOJVRoFsOGco9jlsoXN1EuPqFEfq65
         tHoq7krgMcAAJ4KasmtWiOgZ9INet0SjeGa6kbUgblRMblWxA7T2AF3H1RpE83/46T
         Sign5FlrLl7Rw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id dszltgBJ_YBh; Thu, 22 Nov 2018 10:47:00 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 4D2BE13306D;
        Thu, 22 Nov 2018 10:47:00 -0500 (EST)
Date:   Thu, 22 Nov 2018 10:47:00 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Rich Felker <dalias@libc.org>
Cc:     carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
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
Message-ID: <686626451.10113.1542901620250.JavaMail.zimbra@efficios.com>
In-Reply-To: <20181122151444.GE23599@brightrain.aerifal.cx>
References: <20181121183936.8176-1-mathieu.desnoyers@efficios.com> <20181122143603.GD23599@brightrain.aerifal.cx> <782067422.9852.1542899056778.JavaMail.zimbra@efficios.com> <20181122151444.GE23599@brightrain.aerifal.cx>
Subject: Re: [RFC PATCH v4 1/5] glibc: Perform rseq(2) registration at nptl
 init and thread creation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3047 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: glibc: Perform rseq(2) registration at nptl init and thread creation
Thread-Index: FFMd+FaOuvuQM2PXyMkZh8poo3vAZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Nov 22, 2018, at 10:14 AM, Rich Felker dalias@libc.org wrote:

> On Thu, Nov 22, 2018 at 10:04:16AM -0500, Mathieu Desnoyers wrote:
>> ----- On Nov 22, 2018, at 9:36 AM, Rich Felker dalias@libc.org wrote:
>> 
>> > On Wed, Nov 21, 2018 at 01:39:32PM -0500, Mathieu Desnoyers wrote:
>> >> Register rseq(2) TLS for each thread (including main), and unregister
>> >> for each thread (excluding main). "rseq" stands for Restartable
>> >> Sequences.
>> > 
>> > Maybe I'm missing something obvious, but "unregister" does not seem to
>> > be a meaningful operation. Can you clarify what it's for?
>> 
>> There are really two ways rseq TLS can end up being unregistered: either
>> through an explicit call to the rseq "unregister", or when the OS frees the
>> thread's task struct.
>> 
>> You bring an interesting point here: do we need to explicitly unregister
>> rseq at thread exit, or can we leave that to the OS ?
>> 
>> The key thing to look for here is whether it's valid to access the
>> TLS area of the thread from preemption or signal delivery happening
>> at the very end of START_THREAD_DEFN. If it's OK to access it until
>> the very end of the thread lifetime, then we could do without an
>> explicit unregistration. However, if at any given point of the late
>> thread lifetime we end up in a situation where reading or writing to
>> that TLS area can cause corruption, then we need to carefully
>> unregister it before that memory is reclaimed/reused.
> 
> The thread memory cannot be reused until after kernel task exit,
> reported via the set_tid_address futex. Also, assuming signals are
> blocked (which is absolutely necessary for other reasons) nothing in
> userspace can touch the rseq state after this point anyway.

As discussed in the other leg of the email thread, disabling signals is
not enough to prevent the kernel to access the rseq TLS area on preemption.

> I was more confused about the need for reference counting, though.
> Where would anything be able to observe a state other than "refcnt>0"?
> -- in which case tracking it makes no sense. If the goal is to make an
> ABI thatsupports environments where libc doesn't have rseq support,
> and a third-party library is providing a compatible ABI, it seems all
> that would be needed it a boolean thread-local "is_initialized" flag.
> There does not seem to be any safe way such a library could be
> dynamically unloaded (which would require unregistration in all
> threads) and thus no need for a count.

Here is one scenario: we have 2 early adopter libraries using rseq which
are deployed in an environment with an older glibc (which does not
support rseq).

Of course, none of those libraries can be dlclose'd unless they somehow
track all registered threads. But let's focus on how exactly those
libraries can handle lazily registering rseq. They can use pthread_key,
and pthread_setspecific on first use by the thread to setup a destructor
function to be invoked at thread exit. But each early adopter library
is unaware of the other, so if we just use a "is_initialized" flag, the
first destructor to run will unregister rseq while the second library
may still be using it.

The same problem arises if we have an application early adopter which
explicitly deal with rseq, with a library early adopter. The issue is
similar, except that the application will explicitly want to unregister
rseq before exiting the thread, which leaves a race window where rseq
is unregistered, but the library may still need to use it.

The reference counter solves this: only the last rseq user for a thread
performs unregistration.

Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
