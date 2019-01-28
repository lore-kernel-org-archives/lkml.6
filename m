Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F302AC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C7D21783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="l/4me7O/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfA1WqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:46:19 -0500
Received: from mail.efficios.com ([167.114.142.138]:57356 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfA1WqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:46:19 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 8727DB5B44;
        Mon, 28 Jan 2019 17:46:17 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 9nPEb_SFXI2O; Mon, 28 Jan 2019 17:46:17 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id DA414B5B31;
        Mon, 28 Jan 2019 17:46:16 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DA414B5B31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1548715576;
        bh=u2ZJQSzFWWabv10A7syOIBo1KSvEdAg69/MNdXhZrmc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=l/4me7O/OT+/CSKcxolF+sBD73kPZmWB+C9Ow/etXBeN8cRcZY2yJTjPjCetnZKMs
         a0O/NIjhx3Tz6NyrpRrHce9SF8p464gYGwUkQVQ+5nHEZwzFYSYX5QwAIX/75Lta8q
         NwHmem+pdSQ86p6dnLBz6Sq5jITRNU9B3eIhaVygKVk/ow5SDaaZHp8mGFSIyePEMp
         CK3446a6aggW/0W2NP0+DyrsElXlvkZn4sm7bLLq2Y1n0l2C6HqrspcFqU6yuX4iMR
         E4tvOCeSF4uNN/Y7lqZd8+ImTLbcBEzT6X+nL6XrgOFtJjhm81lPZZjYE3c59GTYlK
         TmUnGwhrJVf+w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id qt1L0QNMIFOA; Mon, 28 Jan 2019 17:46:16 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id B095CB5B29;
        Mon, 28 Jan 2019 17:46:16 -0500 (EST)
Date:   Mon, 28 Jan 2019 17:46:16 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@linux.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, David Sehr <sehr@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        maged michael <maged.michael@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        stable <stable@vger.kernel.org>
Message-ID: <1379691574.2815.1548715576651.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190128223948.GD4240@linux.ibm.com>
References: <20190128220707.30774-1-mathieu.desnoyers@efficios.com> <20190128223948.GD4240@linux.ibm.com>
Subject: Re: [PATCH] Fix: membarrier: racy access to p->mm in
 membarrier_global_expedited()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3745)
Thread-Topic: membarrier: racy access to p->mm in membarrier_global_expedited()
Thread-Index: ZfRJD31a1/45FGqSuggcx6nywDiJmA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 28, 2019, at 5:39 PM, paulmck paulmck@linux.ibm.com wrote:

> On Mon, Jan 28, 2019 at 05:07:07PM -0500, Mathieu Desnoyers wrote:
>> Jann Horn identified a racy access to p->mm in the global expedited
>> command of the membarrier system call.
>> 
>> The suggested fix is to hold the task_lock() around the accesses to
>> p->mm and to the mm_struct membarrier_state field to guarantee the
>> existence of the mm_struct.
>> 
>> Link:
>> https://lore.kernel.org/lkml/CAG48ez2G8ctF8dHS42TF37pThfr3y0RNOOYTmxvACm4u8Yu3cw@mail.gmail.com
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Tested-by: Jann Horn <jannh@google.com>
>> CC: Jann Horn <jannh@google.com>
>> CC: Thomas Gleixner <tglx@linutronix.de>
>> CC: Peter Zijlstra (Intel) <peterz@infradead.org>
>> CC: Ingo Molnar <mingo@kernel.org>
>> CC: Andrea Parri <parri.andrea@gmail.com>
>> CC: Andy Lutomirski <luto@kernel.org>
>> CC: Avi Kivity <avi@scylladb.com>
>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> CC: Boqun Feng <boqun.feng@gmail.com>
>> CC: Dave Watson <davejwatson@fb.com>
>> CC: David Sehr <sehr@google.com>
>> CC: H. Peter Anvin <hpa@zytor.com>
>> CC: Linus Torvalds <torvalds@linux-foundation.org>
>> CC: Maged Michael <maged.michael@gmail.com>
>> CC: Michael Ellerman <mpe@ellerman.id.au>
>> CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> CC: Paul Mackerras <paulus@samba.org>
>> CC: Russell King <linux@armlinux.org.uk>
>> CC: Will Deacon <will.deacon@arm.com>
>> CC: stable@vger.kernel.org # v4.16+
>> CC: linux-api@vger.kernel.org
>> ---
>>  kernel/sched/membarrier.c | 27 +++++++++++++++++++++------
>>  1 file changed, 21 insertions(+), 6 deletions(-)
>> 
>> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
>> index 76e0eaf4654e..305fdcc4c5f7 100644
>> --- a/kernel/sched/membarrier.c
>> +++ b/kernel/sched/membarrier.c
>> @@ -81,12 +81,27 @@ static int membarrier_global_expedited(void)
>> 
>>  		rcu_read_lock();
>>  		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
>> -		if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
>> -				   MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
>> -			if (!fallback)
>> -				__cpumask_set_cpu(cpu, tmpmask);
>> -			else
>> -				smp_call_function_single(cpu, ipi_mb, NULL, 1);
>> +		/*
>> +		 * Skip this CPU if the runqueue's current task is NULL or if
>> +		 * it is a kernel thread.
>> +		 */
>> +		if (p && READ_ONCE(p->mm)) {
>> +			bool mm_match;
>> +
>> +			/*
>> +			 * Read p->mm and access membarrier_state while holding
>> +			 * the task lock to ensure existence of mm.
>> +			 */
>> +			task_lock(p);
>> +			mm_match = p->mm && (atomic_read(&p->mm->membarrier_state) &
> 
> Are we guaranteed that this p->mm will be the same as the one loaded via
> READ_ONCE() above?  Either way, wouldn't it be better to READ_ONCE() it a
> single time and use the same value everywhere?

The first "READ_ONCE()" above is _outside_ of the task_lock() critical section.
Those two accesses _can_ load two different pointers, and this is why we
need to re-read the p->mm pointer within the task_lock() critical section to
ensure existence of the mm_struct that we use.

If we move the READ_ONCE() into the task_lock(), we need to uselessly
take a lock before we can skip kernel threads.

If we lead the READ_ONCE() outside the task_lock(), then p->mm can be updated
between the READ_ONCE() and reference to the mm_struct content within the
task_lock(), which is racy and does not guarantee its existence.

Or am I missing your point ?

Thanks,

Mathieu


> 
>							Thanx, Paul
> 
>> +					     MEMBARRIER_STATE_GLOBAL_EXPEDITED);
>> +			task_unlock(p);
>> +			if (mm_match) {
>> +				if (!fallback)
>> +					__cpumask_set_cpu(cpu, tmpmask);
>> +				else
>> +					smp_call_function_single(cpu, ipi_mb, NULL, 1);
>> +			}
>>  		}
>>  		rcu_read_unlock();
>>  	}
>> --
>> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
