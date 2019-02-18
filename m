Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE98C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BF3217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="k7R9ezNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbfBRPWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:22:35 -0500
Received: from mail.efficios.com ([167.114.142.138]:42114 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731378AbfBRPWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:22:35 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 08093B1A0C;
        Mon, 18 Feb 2019 10:22:33 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id hqBsxFHMIrsh; Mon, 18 Feb 2019 10:22:32 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 485C5B1A05;
        Mon, 18 Feb 2019 10:22:32 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 485C5B1A05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1550503352;
        bh=lXkCyckZpSRAjF2zRdn15O5o0bokbhDFPs3s15evYn4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=k7R9ezNZHuGP5lqk8mfOyHEqsEHFy40BnnJBgixwKiGqVQ2Kb3DbdQhCExE8JiQdV
         NVQhYRJr8a6r+EdRkLkZKoXzFFgDuayPVOaLjOnKKXX5oDUHmIyQ72UOv1NvcDn+1T
         T8tHfRgxldNRaGashLjLDfMu82HM4RVbg6n5w/IaUTuuyCt95TRqA9/n6mYiXLH7mv
         F4A44EqYH/Bn8KC7lwd8sBVz32BPZnF9oY9g4Vp7VeQre31+CHDtVhgZXhkfUmJNvi
         a8X8tkAArcyHQdfV1wYKkz6RbhjzRpHvwL8Ao8la6tlvCyToSl/uzg8dy+YsEZI7WV
         Ib321R/Bo9GQA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id K-9TXYDLSX1n; Mon, 18 Feb 2019 10:22:32 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 248E0B19FE;
        Mon, 18 Feb 2019 10:22:32 -0500 (EST)
Date:   Mon, 18 Feb 2019 10:22:32 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Rich Felker <dalias@libc.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <424503257.251.1550503352008.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190217220805.GI23599@brightrain.aerifal.cx>
References: <20190217184800.GA16118@brightrain.aerifal.cx> <53623603.9626.1550439285362.JavaMail.zimbra@efficios.com> <20190217215235.GH23599@brightrain.aerifal.cx> <20190217220805.GI23599@brightrain.aerifal.cx>
Subject: Re: Regression in SYS_membarrier expedited
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3758 (ZimbraWebClient - FF65 (Linux)/8.8.10_GA_3745)
Thread-Topic: Regression in SYS_membarrier expedited
Thread-Index: PDkCyWG/jfLeU9Q/+slHDceFcHU3aw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 17, 2019, at 5:08 PM, Rich Felker dalias@libc.org wrote:

> On Sun, Feb 17, 2019 at 04:52:35PM -0500, Rich Felker wrote:
>> On Sun, Feb 17, 2019 at 04:34:45PM -0500, Mathieu Desnoyers wrote:
>> > ----- On Feb 17, 2019, at 1:48 PM, Rich Felker dalias@libc.org wrote:
>> > 
>> > > commit a961e40917fb14614d368d8bc9782ca4d6a8cd11 made it so that the
>> > > MEMBARRIER_CMD_PRIVATE_EXPEDITED command cannot be used without first
>> > > registering intent to use it. However, registration is an expensive
>> > > operation since commit 3ccfebedd8cf54e291c809c838d8ad5cc00f5688, which
>> > > added synchronize_sched() to it; this means it's no longer possible to
>> > > lazily register intent at first use, and it's unreasonably expensive
>> > > to preemptively register intent for possibly extremely-short-lived
>> > > processes that will never use it. (My usage case is in libc (musl),
>> > > where I can't know if the process will be short- or long-lived;
>> > > unnecessary and potentially expensive syscalls can't be made
>> > > preemptively, only lazily at first use.)
>> > > 
>> > > Can we restore the functionality of MEMBARRIER_CMD_PRIVATE_EXPEDITED
>> > > to work even without registration? The motivation of requiring
>> > > registration seems to be:
>> > > 
>> > >    "Registering at this time removes the need to interrupt each and
>> > >    every thread in that process at the first expedited
>> > >    sys_membarrier() system call."
>> > > 
>> > > but interrupting every thread in the process is exactly what I expect,
>> > > and is not a problem. What does seem like a big problem is waiting for
>> > > synchronize_sched() to synchronize with an unboundedly large number of
>> > > cores (vs only a few threads in the process), especially in the
>> > > presence of full_nohz, where it seems like latency would be at least a
>> > > few ms and possibly unbounded.
>> > > 
>> > > Short of a working SYS_membarrier that doesn't require expensive
>> > > pre-registration, I'm stuck just implementing it in userspace with
>> > > signals...
>> > 
>> > Hi Rich,
>> > 
>> > Let me try to understand the scenario first.
>> > 
>> > musl libc support for using membarrier private expedited
>> > would require to first register membarrier private expedited for
>> > the process at musl library init (typically after exec). At that stage, the
>> > process is still single-threaded, right ? So there is no reason
>> > to issue a synchronize_sched() (or now synchronize_rcu() in newer
>> > kernels):
>> > 
>> > membarrier_register_private_expedited()
>> > 
>> >         if (!(atomic_read(&mm->mm_users) == 1 && get_nr_threads(p) == 1)) {
>> >                 /*
>> >                  * Ensure all future scheduler executions will observe the
>> >                  * new thread flag state for this process.
>> >                  */
>> >                 synchronize_rcu();
>> >         }
>> > 
>> > So considering that pre-registration carefully done before the process
>> > becomes multi-threaded just costs a system call (and not a synchronize_sched()),
>> > does it make the pre-registration approach more acceptable ?
>> 
>> It does get rid of the extreme cost, but I don't think it would be
>> well-received by users who don't like random unnecessary syscalls at
>> init time (each adding a few us of startup time cost). If it's so
>> cheap, why isn't it just the default at kernel-side process creation?
>> Why is there any requirement of registration to begin with? Reading
>> the code, it looks like all it does is set a flag, and all this flag
>> is used for is erroring-out if it's not set.
> 
> On further thought, pre-registration could be done at first
> pthread_create rather than process entry, which would probably be
> acceptable. But the question remains why it's needed at all, and
> neither of these approaches is available to code that doesn't have the
> privilege of being part of libc. For example, library code that might
> be loaded via dlopen can't safely use SYS_membarrier without
> introducing unbounded latency before the first use.

For membarrier private expedited, the need for pre-registration is currently
there because of powerpc not wanting to slow down switch_mm() for processes
not needing that command.

That's the only reason I see for it. If we would have accepted to add
a smp_mb() to the powerpc switch_mm() scheduler path, we could have done
so without registration for the private expedited membarrier command.

commit a961e40917fb hints at the sync_core private expedited membarrier
commands (which was being actively designed at that time) which may
require pre-registration. However, things did not turn out that way: we
ended up adding the required core serializing barriers unconditionally
into each architecture.

Considering that sync_core private expedited membarrier ended up not needing
pre-registration, I think this pre-registration optimization may have been
somewhat counter-productive, since I doubt the overhead of smp_mb() in a
switch_mm() for powerpc is that high, but I don't have the hardware handy
to provide numbers. So we end up slowing down everyone by requiring a
registration system call after exec. :-(

One possible way out of this would be to make MEMBARRIER_CMD_PRIVATE_EXPEDITED
and MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE work fine without pre-registration
in future kernels. Therefore, the application could try using them without
registration. If it works, all is fine, else it would treat the error how it
sees fit, either through explicit registration and trying again, or returning
the error to the caller.

The only change I see we would require to make this work is to turn
arch/powerpc/include/asm/membarrier.h membarrier_arch_switch_mm() into
an unconditional smp_mb().

Thoughts ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
