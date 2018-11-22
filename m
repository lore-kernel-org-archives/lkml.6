Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31813C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D991120684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jHTiVEEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D991120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391885AbeKWD1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:27:54 -0500
Received: from mail.efficios.com ([167.114.142.138]:35804 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732442AbeKWD1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:27:53 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D95CE7B342;
        Thu, 22 Nov 2018 11:47:42 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id WWjduBERekzg; Thu, 22 Nov 2018 11:47:42 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6CEEE7B33D;
        Thu, 22 Nov 2018 11:47:42 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6CEEE7B33D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1542905262;
        bh=zEUD2cv3m9QoBxqFrRcnLu6dRfjO+JYa50ASikZlxrY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=jHTiVEEbmNQBBlZPisA4639XmLuEEFGzX2ziBILLaPdDpqLwIUR6fhtMABv6CiNeV
         MHy2Of2dJqc2KvJ9JdABYjhyVhrXmAJLtRt1mGa1cRGrRdR07s7qf7jmk55GLPuZis
         EUjPVdLUJJzP1hsQSN1UjU3UDkU96WNWa5sZJT8/89rpjoZDnG2X7m5TDFwRPX17Vh
         QD7X9WcSrKEtZZqlLvcdxZA7BrbDEpNM0Be1X1ViJlGcpVAPsq/vKpMElNHaOajB5l
         yYtSuqajiJYjRTpwfPM8RUeWl0UnV0aKTqEBUKgLxdtx0w3nwM/18Cnh3Nd30R8gq8
         8KjPAVqQzrDrA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 2zCcVB0wB0Oc; Thu, 22 Nov 2018 11:47:42 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 4EB217B331;
        Thu, 22 Nov 2018 11:47:42 -0500 (EST)
Date:   Thu, 22 Nov 2018 11:47:42 -0500 (EST)
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
Message-ID: <1045257294.10291.1542905262086.JavaMail.zimbra@efficios.com>
In-Reply-To: <87wop5xeit.fsf@oldenburg.str.redhat.com>
References: <20181121183936.8176-1-mathieu.desnoyers@efficios.com> <20181122143603.GD23599@brightrain.aerifal.cx> <782067422.9852.1542899056778.JavaMail.zimbra@efficios.com> <20181122151444.GE23599@brightrain.aerifal.cx> <686626451.10113.1542901620250.JavaMail.zimbra@efficios.com> <87wop5xeit.fsf@oldenburg.str.redhat.com>
Subject: Re: [RFC PATCH v4 1/5] glibc: Perform rseq(2) registration at nptl
 init and thread creation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3047 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: glibc: Perform rseq(2) registration at nptl init and thread creation
Thread-Index: daNrSODWQpbUGqf0EEqpOD2sZf2NSQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Nov 22, 2018, at 11:28 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> Here is one scenario: we have 2 early adopter libraries using rseq which
>> are deployed in an environment with an older glibc (which does not
>> support rseq).
>>
>> Of course, none of those libraries can be dlclose'd unless they somehow
>> track all registered threads.
> 
> Well, you can always make them NODELETE so that dlclose is not an issue.
> If the library is small enough, that shouldn't be a problem.

That's indeed what I do with lttng-ust, mainly due to use of pthread_key.

> 
>> But let's focus on how exactly those libraries can handle lazily
>> registering rseq. They can use pthread_key, and pthread_setspecific on
>> first use by the thread to setup a destructor function to be invoked
>> at thread exit. But each early adopter library is unaware of the
>> other, so if we just use a "is_initialized" flag, the first destructor
>> to run will unregister rseq while the second library may still be
>> using it.
> 
> I don't think you need unregistering if the memory is initial-exec TLS
> memory.  Initial-exec TLS memory is tied directly to the TCB and cannot
> be freed while the thread is running, so it should be safe to put the
> rseq area there even if glibc knows nothing about it.

Is it true for user-supplied stacks as well ?

> Then you'll only
> need a mechanism to find the address of the actually active rseq area
> (which you probably have to store in a TLS variable for performance
> reasons).  And that part you need whether you have reference counter or
> not.

I'm not sure I follow your thoughts here. Currently, the __rseq_abi
TLS symbol identifies a structure registered to the kernel. The
"currently active" rseq critical section is identified by the field
"rseq_cs" within the __rseq_abi structure.

So here when you say "actually active rseq area", do you mean the
currently registered struct rseq (__rseq_abi) or the currently running
rseq critical section ? (pointed to by __rseq_abi.rseq_cs)

One issue here is that early adopter libraries cannot always use
the IE model. I tried using it for other TLS variables in lttng-ust, and
it ended up hanging our CI tests when tracing a sample application with
lttng-ust under a Java virtual machine: being dlopen'd in a process that
possibly already exhausts the number of available backup TLS IE entries
seems to have odd effects. This is why I'm worried about using the IE model
within lttng-ust.

So using the IE model for glibc makes sense, because nobody dlopen
glibc AFAIK. But it's not so simple for early adopter libraries which
can be dlopen'd.

> 
>> The same problem arises if we have an application early adopter which
>> explicitly deal with rseq, with a library early adopter. The issue is
>> similar, except that the application will explicitly want to unregister
>> rseq before exiting the thread, which leaves a race window where rseq
>> is unregistered, but the library may still need to use it.
>>
>> The reference counter solves this: only the last rseq user for a thread
>> performs unregistration.
> 
> If you do explicit unregistration, you will run into issues related to
> destructor ordering.  You should really find a way to avoid that.

The per-thread reference counter is a way to avoid issues that arise from
lack of destructor ordering. Is it an acceptable approach for you, or
you have something else in mind ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
