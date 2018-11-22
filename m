Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474B0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12B620864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="O7MHUe0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12B620864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406283AbeKWEKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:10:05 -0500
Received: from mail.efficios.com ([167.114.142.138]:36036 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbeKWEKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:10:04 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 62788E1FD;
        Thu, 22 Nov 2018 12:29:44 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id pIL4_smxxJaf; Thu, 22 Nov 2018 12:29:43 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A1F14E1FA;
        Thu, 22 Nov 2018 12:29:43 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A1F14E1FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1542907783;
        bh=JRB1cHnZVs2Q1494Tm4yX9b2eb8zwIL23tApa4FqV2c=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=O7MHUe0NNkZ46p2Ci3+/Cnd1wS9KO/815lRfptucOdVQPIFwpZd9mERySer175RVB
         y39KQMODBeQmmY2NsT/HDw3y01+qtm6dkZMKUPXo6qdsYe5j2CuINdhPrR4c/uKO/E
         CpcQMjiQj3ouevbysHl95r+Wnv/69df7akjxAG2f/KI/OxbU82yNPijkKP5FA33HjA
         1zKzi6J3niVQtHLbUd//n9XsMhyLw8kRBGK6M+NXbFMaesEer+8GYvfv50ImxSnlS2
         xoKdq7n2Vl+goqrI4RjfX8TYp+6K55GPxO8EKiCwBnR9uGc7SWVsZpRLnUA8Pa/bH9
         6F8M29IXt9dmw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id kFycq6WV28TC; Thu, 22 Nov 2018 12:29:43 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 80169E1EF;
        Thu, 22 Nov 2018 12:29:43 -0500 (EST)
Date:   Thu, 22 Nov 2018 12:29:43 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Rich Felker <dalias@libc.org>, carlos <carlos@redhat.com>,
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
Message-ID: <644835950.10383.1542907783295.JavaMail.zimbra@efficios.com>
In-Reply-To: <87k1l5xd33.fsf@oldenburg.str.redhat.com>
References: <20181121183936.8176-1-mathieu.desnoyers@efficios.com> <20181122143603.GD23599@brightrain.aerifal.cx> <782067422.9852.1542899056778.JavaMail.zimbra@efficios.com> <20181122151444.GE23599@brightrain.aerifal.cx> <686626451.10113.1542901620250.JavaMail.zimbra@efficios.com> <87wop5xeit.fsf@oldenburg.str.redhat.com> <1045257294.10291.1542905262086.JavaMail.zimbra@efficios.com> <87k1l5xd33.fsf@oldenburg.str.redhat.com>
Subject: Re: [RFC PATCH v4 1/5] glibc: Perform rseq(2) registration at nptl
 init and thread creation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3047 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: glibc: Perform rseq(2) registration at nptl init and thread creation
Thread-Index: 4oU0aXTlYLrkMjd1q0cczFwLPsKVtQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On Nov 22, 2018, at 11:59 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> ----- On Nov 22, 2018, at 11:28 AM, Florian Weimer fweimer@redhat.com wrote:
>>
>>> * Mathieu Desnoyers:
>>> 
>>>> Here is one scenario: we have 2 early adopter libraries using rseq which
>>>> are deployed in an environment with an older glibc (which does not
>>>> support rseq).
>>>>
>>>> Of course, none of those libraries can be dlclose'd unless they somehow
>>>> track all registered threads.
>>> 
>>> Well, you can always make them NODELETE so that dlclose is not an issue.
>>> If the library is small enough, that shouldn't be a problem.
>>
>> That's indeed what I do with lttng-ust, mainly due to use of pthread_key.
>>
>>> 
>>>> But let's focus on how exactly those libraries can handle lazily
>>>> registering rseq. They can use pthread_key, and pthread_setspecific on
>>>> first use by the thread to setup a destructor function to be invoked
>>>> at thread exit. But each early adopter library is unaware of the
>>>> other, so if we just use a "is_initialized" flag, the first destructor
>>>> to run will unregister rseq while the second library may still be
>>>> using it.
>>> 
>>> I don't think you need unregistering if the memory is initial-exec TLS
>>> memory.  Initial-exec TLS memory is tied directly to the TCB and cannot
>>> be freed while the thread is running, so it should be safe to put the
>>> rseq area there even if glibc knows nothing about it.
>>
>> Is it true for user-supplied stacks as well ?
> 
> I'm not entirely sure because the glibc terminology is confusing, but I
> think it places intial-exec TLS into the static TLS area (so that it has
> a fixed offset from the TCB).  The static TLS area is placed on the
> user-supplied stack.

You said earlier in the email thread that user-supplied stack can be
reclaimed by __free_tcb () while the thread still runs, am I correct ?
If so, then we really want to unregister the rseq TLS before that.

I notice that __free_tcb () calls __deallocate_stack (), which invokes
_dl_deallocate_tls (). Accessing the TLS from the kernel upon preemption
would appear fragile after this call.

[...]

>> One issue here is that early adopter libraries cannot always use
>> the IE model. I tried using it for other TLS variables in lttng-ust, and
>> it ended up hanging our CI tests when tracing a sample application with
>> lttng-ust under a Java virtual machine: being dlopen'd in a process that
>> possibly already exhausts the number of available backup TLS IE entries
>> seems to have odd effects. This is why I'm worried about using the IE model
>> within lttng-ust.
> 
> You can work around this by preloading the library.  I'm not sure if
> this is a compelling reason not to use initial-exec TLS memory.

LTTng-UST is meant to be used as a dependency for e.g. a java logger,
or a python logger. Those rely on dlopen, and it would be very painful
to ask all users to preload lttng-ust within their environment which is
sometimes already complex. It works today through dlopen, and I consider
this a user-facing behavior which I am very reluctant to break.

> 
>>>> The same problem arises if we have an application early adopter which
>>>> explicitly deal with rseq, with a library early adopter. The issue is
>>>> similar, except that the application will explicitly want to unregister
>>>> rseq before exiting the thread, which leaves a race window where rseq
>>>> is unregistered, but the library may still need to use it.
>>>>
>>>> The reference counter solves this: only the last rseq user for a thread
>>>> performs unregistration.
>>> 
>>> If you do explicit unregistration, you will run into issues related to
>>> destructor ordering.  You should really find a way to avoid that.
>>
>> The per-thread reference counter is a way to avoid issues that arise from
>> lack of destructor ordering. Is it an acceptable approach for you, or
>> you have something else in mind ?
> 
> Only for the involved libraries.  It will not help if other TLS
> destructors run and use these libraries.

You bring an interesting point. The reference counter suffice to ensure
that the kernel will not try to reference the TLS area beyond its registration
scope, but it does not guarantee that another destructor (or a signal
handler) won't try to use the rseq TLS area after it has been unregistered.

Unregistration of the TLS before freeing its memory is required for correctness.

However, a use-after-unregistration can be dealt with by other means. This
is one of the reasons why I want to upstream the "cpu_opv" system call into
Linux: this is a fallback mechanism to use when rseq cannot do forward
progress (e.g. debugger single-stepping), or to use in those scenarios
where rseq is not registered (early at thread creation, or late at thread
exit). Moreover, it allows handling use-cases of migration of data between
per-cpu data structures, which is pretty much impossible to do right if we
only have rseq available.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
