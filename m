Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAF8C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917EB206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917EB206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbeKUBmh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:42:37 -0500
Received: from mout.gmx.net ([212.227.17.21]:39553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbeKUBmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:42:37 -0500
Received: from [192.168.1.153] ([98.118.28.103]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MY3Ho-1fuNOy0equ-00Uohr; Tue, 20
 Nov 2018 16:12:40 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] debugobjects: scale the static pool size
From:   Qian Cai <cai@gmx.us>
In-Reply-To: <f4c9756e-08c9-ce18-19a8-771977e95ac9@redhat.com>
Date:   Tue, 20 Nov 2018 10:12:36 -0500
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <0DFA87D5-2B2D-48A6-933A-B94E6258395A@gmx.us>
References: <20181120064254.1594-1-cai@gmx.us>
 <f4c9756e-08c9-ce18-19a8-771977e95ac9@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: Apple Mail (2.3445.100.39)
X-Provags-ID: V03:K1:ANYz3Sfpy2g/13xikKEQQGPuhy3Prx4I9RDUASFRr6M52QqWceG
 lWyQykjmqTvvsJVPbHGNJ7bV2GAtG8sJYFc3/T/l9te7wrHfTxswfdow+lv2kSVPyDSFMqA
 /cZTQ8X7Cf74cy4W91G50ApxFDL8M9JKV6Cq9hZUt84+ss9WzlRtWzc0s4knIkZXXFK8/X1
 J8GMNfUS0yb+n55ZUe7fw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/R2e8+iZHWQ=:prg0oosopNMt1caIBGcrNE
 vYuW7hL2uAJjI2Bb+SRK5+07KYwCi0s69sJ27T+vWxXs0b+FcH0CGlRKTvDnFBhe2bTaqOweK
 JNrX+GXTiuOhJvXHz83LKUPQEuiHvNvE+NGKfd1+FRqPS/KwVPbLXKDR4tRIwizqA0eSV2SSB
 nVHCQKFoEa8iLabXOWrHIKC8WzYnO3aNMU44RXnzu8GZ3hHcYJ4j7x2hIcODw5yR+jokyE3Bh
 eRObjPSPhWQlzqPv3L6AxN+GPjkOxsumNNgeqICEwD9i2R9THf2OeyW6zEnevcHlmWSsO9i/4
 ilIdUxOm4zH7K3CJ2M/jspztei8JdHQkf+kjQPOtqdBAM8QIfoN3MvsRIN2vz3qOBUmAsu5Pp
 OmmMAKJdZ2giJdR3eH7Fivx+0dA6l8Ae7Sqh2UB0qkb4H8p2hPBzBKGwh2OgqtoStnf1Pcs17
 erqemfHZT/TEhESFserhiAtpWrcKvMth9ltbv85xHIlHtBvEbE8cD5DT4P95Hnos+XP4EuF9Y
 SO880iBBqh4F+Wkn8gQ4LiQUgCSdjZdO+sMTG5xECo2SntL9lf1jum9862jx8pksLSBwviPmX
 widkPQR6sojmV9oE+VxMbIuSQUtCR5ha7HO/o+ZxWlnK4UNiE1mBPKWXPhjVSTx7c3GAOg5K2
 byWCVXca3SXqommPLOUbImilZTTygkKW9wBQ+scLu6/khCUrI/dmSqRN4ITHHPyOkVnw+Fplo
 Q/HJ9RkjIF/KXeAS8y2F3vN/otc5kR0MdDcznUCCX00pPuEtCWdDHsqZ7RXUp9ovZ1tLvSR9C
 9w77eQAzAqZLHKqqcJ4twTV6tYoASBo0X290fNwTgGlStjsnE8zBem0JhC8SAR/zN1lUSvGcd
 5nVq0ngpzhb1zSjeZWIGAplKRPIPhPqVVsQc2u2VJiE0HRFYucQoy5gBW+UDMB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 20, 2018, at 8:50 AM, Waiman Long <longman@redhat.com> wrote:
> 
> On 11/20/2018 01:42 AM, Qian Cai wrote:
>> The current value of the early boot static pool size is not big enough
>> for systems with large number of CPUs with timer or/and workqueue
>> objects selected. As the results, systems have 60+ CPUs with both timer
>> and workqueue objects enabled could trigger "ODEBUG: Out of memory.
>> ODEBUG disabled". Hence, fixed it by computing it according to
>> CONFIG_NR_CPUS and CONFIG_DEBUG_OBJECTS_* options.
>> 
>> Signed-off-by: Qian Cai <cai@gmx.us>
>> ---
>> lib/debugobjects.c | 53 +++++++++++++++++++++++++++++++++++++++++++++-
>> 1 file changed, 52 insertions(+), 1 deletion(-)
>> 
>> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
>> index 70935ed91125..372dc34206d5 100644
>> --- a/lib/debugobjects.c
>> +++ b/lib/debugobjects.c
>> @@ -23,7 +23,53 @@
>> #define ODEBUG_HASH_BITS	14
>> #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
>> 
>> +/*
>> + * Some debug objects are allocated during the early boot. Enabling some
>> + * options like timers or workqueue objects may increase the size required
>> + * significantly with large number of CPUs. For example,
>> + *
>> + * No. CPUs x 2 (worker pool) objects:
>> + *
>> + * start_kernel
>> + *   workqueue_init_early
>> + *     init_worker_pool
>> + *       init_timer_key
>> + *         debug_object_init
>> + *
>> + * No. CPUs objects (CONFIG_HIGH_RES_TIMERS):
>> + *
>> + * sched_init
>> + *   hrtick_rq_init
>> + *     hrtimer_init
>> + *
>> + * CONFIG_DEBUG_OBJECTS_WORK:
>> + * No. CPUs x 6 (workqueue) objects:
>> + *
>> + * workqueue_init_early
>> + *   alloc_workqueue
>> + *     __alloc_workqueue_key
>> + *       alloc_and_link_pwqs
>> + *         init_pwq
>> + *
>> + * Also, plus No. CPUs objects:
>> + *
>> + * perf_event_init
>> + *    __init_srcu_struct
>> + *      init_srcu_struct_fields
>> + *        init_srcu_struct_nodes
>> + *          __init_work
>> + *
>> + * Increase the number a bit more in case the implmentatins are changed in
>> + * the future.
>> + */
>> +#if defined(CONFIG_NR_CPUS) && defined(CONFIG_DEBUG_OBJECTS_TIMERS) && \
>> +!defined(CONFIG_DEBUG_OBJECTS_WORK)
>> +#define ODEBUG_POOL_SIZE	(CONFIG_NR_CPUS * 10)
>> +#elif defined(CONFIG_NR_CPUS) && defined(CONFIG_DEBUG_OBJECTS_WORK)
>> +#define ODEBUG_POOL_SIZE	(CONFIG_NR_CPUS * 30)
>> +#else
>> #define ODEBUG_POOL_SIZE	1024
>> +#endif /* CONFIG_NR_CPUS */
>> #define ODEBUG_POOL_MIN_LEVEL	256
>> 
> 
> CONFIG_NR_CPUS is always defined. You don't need to put that as a #if
> condition. Where does the scaling factor 30 come from? It looks high to me.

Hmm, looks like some architectures could have it undefined since it depends
on CONFIG_SMP where the later can be disabled. For example alpha,

config NR_CPUS
        int "Maximum number of CPUs (2-32)"
        range 2 32
        depends on SMP

Scaling factor 30 came from the data, with all the debug_objects options
enabled, I have,

64-CPU:   ODEBUG: 1114 of 1114 active objects replaced
256-CPU: ODEBUG: 4378 of 4378 active objects replaced

I also give a bit room for growth in the future since the implementation details
could always change.

> 
> For UP system, CONFIG_NR_CPUS will be 1. I think it is better to have a
> guarantee minimum plus a multiplier of the # of configured CPUs.
> Something like
> 
> 512 + CONFIG_NR_CPUS * <multiplier>
> 
> where <multiplier> should be the sum of all early allocation objects
> that scale with the number of cpus. The guarantee minimum will cover
> other miscellaneous objects.

That is a good catch. I’ll fix that.

