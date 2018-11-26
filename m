Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD54C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB2220865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB2220865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeKZPrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 10:47:20 -0500
Received: from mout.gmx.net ([212.227.15.19]:46849 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbeKZPrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 10:47:20 -0500
Received: from ovpn-120-189.rdu2.redhat.com ([98.118.28.103]) by mail.gmx.com
 (mrgmx001 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0MBExR-1gJ88s3Vyv-00ADGN; Mon, 26 Nov 2018 05:52:28 +0100
Subject: Re: [PATCH v4] debugobjects: scale the static pool size
To:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>, arnd@arndb.de,
        linux kernel <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20181120232810.2503-1-cai@gmx.us>
 <20181121021157.3061-1-cai@gmx.us>
 <alpine.DEB.2.21.1811222238270.1665@nanos.tec.linutronix.de>
 <EAB01918-727E-4E6F-AC7F-0417CA469D5A@gmx.us>
 <211af3b2-bc56-2d1b-c6c2-f6853797a7a1@gmx.us>
 <473f6a6e-1a14-d07c-b0f0-4d96e3232d1a@redhat.com>
From:   Qian Cai <cai@gmx.us>
Message-ID: <5abb31e1-b5f2-718d-3a48-b0d8a73d6e5c@gmx.us>
Date:   Sun, 25 Nov 2018 23:52:24 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <473f6a6e-1a14-d07c-b0f0-4d96e3232d1a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TlKFsfLcnk/FkXxpGZMJAP2sdQfPtNgIrpna+BBndXr4JUD45nI
 cYCH4g5E1mdTGLiRnw5wTZn54jWYFiuMSx1DAE2WTMfSQOAd8EJt9Q27TF8Zy5YKvyRVWaH
 wtmPAhxNRF9wWJ1YfmHvd1prEpBYpjfaK/KstDVsBVYxlfYO7pcD0O1lMYByqfCNzA18YK7
 0BBAPfbEc99PBL3pXym/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m9yhuncOcnY=:NpmUUmytR2KJSi3WY0JlEk
 PmFa/R5g01z1ZwFE1w9Bi9TE8qg3ISLAmXQN3r/68ly9oJhFNxsWRjMYMkBwXHZYrT+sa0YSX
 zXPIvQVt2zhnCCzuN0WPEPQZf44sAVIiYWFBPZHd31wT1y34KB5saYXauvqDEdaYMrL0k+nht
 oIie86ASaHwfchqQ2TqzBKy42pdw3XecIAqcpeiB/19H5EwoBRFqc1IuTrAewwxpz5W0vghVH
 4XQiOi2NYI7aa210yowScBsEpvQpAPCFYTkXQCYSmQlxi4BptJbKjCtZPjbVijREmQtEOR/Os
 MDvka10TJH2XNkZ9N8gyqTD1Enz8hGZuiap+2Ex6eqfHM5rWHDfHg3vTEDCXw2Ywe38QuB2YW
 h+ksOiHjx7Ap5wcQakT38jwLbRlzXPwjCeTW/gyeea8m7AZ0hLyFmieUrqKNW2uWjBGJnxeoO
 fYS4VqbXzhH99AUhsPkQjnJJj80p3EBiVq09K+zAc2c7+Wl6dGdvkV+VVISheBEKJaBACFIi6
 mILweZ1rAEG0qS2qcVolSl3BVx2yEmLnL16cI+6hnSkYzvWQOfwtz0xv9EGlAJSvajms+eI4l
 Ta+HKNCROSxxXyEJG+UipONnP1eSUOBAueXgSUP+sunfDPlc+WkXqWsjl6S/S1O1zzNy6CImj
 qI1GBJZydPEU1VCGYWDTXgwTx+UrmI99My+P6PCyhchRcRPxHESIFxlq6Ferf+sEWFAtTulgq
 UFn/1a3vw9hbOXabTJm9rmtSHkymqe9IQHc3g8jv0VyPCFe5BOq/jy4B8fMUayWSuUbAqmxr0
 PJKZFqTW7aLuGBxXE0+xAAPpcy3pSKz1jghO8VSGJJ0/nQNcvDdSJQnIjE62iRLOfs5RkoRjY
 aWznYwxOOQ3ovnIfdYawl1Guk82Ak3CnL+EJCgqvQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/25/18 8:31 PM, Waiman Long wrote:
> On 11/25/2018 03:42 PM, Qian Cai wrote:
>>
>>
>> On 11/23/18 10:01 PM, Qian Cai wrote:
>>>
>>>
>>>> On Nov 22, 2018, at 4:56 PM, Thomas Gleixner <tglx@linutronix.de>
>>>> wrote:
>>>>
>>>> On Tue, 20 Nov 2018, Qian Cai wrote:
>>>>
>>>> Looking deeper at that.
>>>>
>>>>> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
>>>>> index 70935ed91125..140571aa483c 100644
>>>>> --- a/lib/debugobjects.c
>>>>> +++ b/lib/debugobjects.c
>>>>> @@ -23,9 +23,81 @@
>>>>> #define ODEBUG_HASH_BITS    14
>>>>> #define ODEBUG_HASH_SIZE    (1 << ODEBUG_HASH_BITS)
>>>>>
>>>>> -#define ODEBUG_POOL_SIZE    1024
>>>>> +#define ODEBUG_DEFAULT_POOL    512
>>>>> #define ODEBUG_POOL_MIN_LEVEL    256
>>>>>
>>>>> +/*
>>>>> + * Some debug objects are allocated during the early boot.
>>>>> Enabling some options
>>>>> + * like timers or workqueue objects may increase the size required
>>>>> significantly
>>>>> + * with large number of CPUs. For example (as today, 20 Nov. 2018),
>>>>> + *
>>>>> + * No. CPUs x 2 (worker pool) objects:
>>>>> + *
>>>>> + * start_kernel
>>>>> + *   workqueue_init_early
>>>>> + *     init_worker_pool
>>>>> + *       init_timer_key
>>>>> + *         debug_object_init
>>>>> + *
>>>>> + * No. CPUs objects (CONFIG_HIGH_RES_TIMERS):
>>>>> + *
>>>>> + * sched_init
>>>>> + *   hrtick_rq_init
>>>>> + *     hrtimer_init
>>>>> + *
>>>>> + * CONFIG_DEBUG_OBJECTS_WORK:
>>>>> + * No. CPUs x 6 (workqueue) objects:
>>>>> + *
>>>>> + * workqueue_init_early
>>>>> + *   alloc_workqueue
>>>>> + *     __alloc_workqueue_key
>>>>> + *       alloc_and_link_pwqs
>>>>> + *         init_pwq
>>>>> + *
>>>>> + * Also, plus No. CPUs objects:
>>>>> + *
>>>>> + * perf_event_init
>>>>> + *    __init_srcu_struct
>>>>> + *      init_srcu_struct_fields
>>>>> + *        init_srcu_struct_nodes
>>>>> + *          __init_work
>>>>
>>>> None of the things are actually used or required _BEFORE_
>>>> debug_objects_mem_init() is invoked.
>>>>
>>>> The reason why the call is at this place in start_kernel() is
>>>> historical. It's because back in the days when debugobjects were
>>>> added the
>>>> memory allocator was enabled way later than today. So we can just
>>>> move the
>>>> debug_objects_mem_init() call right before sched_init() I think.
>>>
>>> Well, now that kmemleak_init() seems complains that
>>> debug_objects_mem_init()
>>> is called before it.
>>>
>>> [    0.078805] kmemleak: Cannot insert 0xc000000dff930000 into the
>>> object search tree (overlaps existing)
>>> [    0.078860] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.20.0-rc3+ #3
>>> [    0.078883] Call Trace:
>>> [    0.078904] [c000000001c8fcd0] [c000000000c96b34]
>>> dump_stack+0xe8/0x164 (unreliable)
>>> [    0.078935] [c000000001c8fd20] [c000000000486e84]
>>> create_object+0x344/0x380
>>> [    0.078962] [c000000001c8fde0] [c000000000489544]
>>> early_alloc+0x108/0x1f8
>>> [    0.078989] [c000000001c8fe20] [c00000000109738c]
>>> kmemleak_init+0x1d8/0x3d4
>>> [    0.079016] [c000000001c8ff00] [c000000001054028]
>>> start_kernel+0x5c0/0x6f8
>>> [    0.079043] [c000000001c8ff90] [c00000000000ae7c]
>>> start_here_common+0x1c/0x520
>>> [    0.079070] kmemleak: Kernel memory leak detector disabled
>>> [    0.079091] kmemleak: Object 0xc000000ffd587b68 (size 40):
>>> [    0.079112] kmemleak:   comm "swapper/0", pid 0, jiffies 4294937299
>>> [    0.079135] kmemleak:   min_count = -1
>>> [    0.079153] kmemleak:   count = 0
>>> [    0.079170] kmemleak:   flags = 0x5
>>> [    0.079188] kmemleak:   checksum = 0
>>> [    0.079206] kmemleak:   backtrace:
>>> [    0.079227]      __debug_object_init+0x688/0x700
>>> [    0.079250]      debug_object_activate+0x1e0/0x350
>>> [    0.079272]      __call_rcu+0x60/0x430
>>> [    0.079292]      put_object+0x60/0x80
>>> [    0.079311]      kmemleak_init+0x2cc/0x3d4
>>> [    0.079331]      start_kernel+0x5c0/0x6f8
>>> [    0.079351]      start_here_common+0x1c/0x520
>>> [    0.079380] kmemleak: Early log backtrace:
>>> [    0.079399]    memblock_alloc_try_nid_raw+0x90/0xcc
>>> [    0.079421]    sparse_init_nid+0x144/0x51c
>>> [    0.079440]    sparse_init+0x1a0/0x238
>>> [    0.079459]    initmem_init+0x1d8/0x25c
>>> [    0.079498]    setup_arch+0x3e0/0x464
>>> [    0.079517]    start_kernel+0xa4/0x6f8
>>> [    0.079536]    start_here_common+0x1c/0x520
>>>
>>
>> So this is an chicken-egg problem. Debug objects need kmemleak_init()
>> first, so it can make use of kmemleak_ignore() for all debug objects
>> in order to avoid the overlapping like the above.
>>
>> while (obj_pool_free < debug_objects_pool_min_level) {
>>
>>      new = kmem_cache_zalloc(obj_cache, gfp);
>>      if (!new)
>>          return;
>>
>>      kmemleak_ignore(new);
>>
>> However, there seems no way to move kmemleak_init() together this
>> early in start_kernel() just before vmalloc_init() [1] because it
>> looks like it depends on things like workqueue
>> (schedule_work(&cleanup_work)) and rcu. Hence, it needs to be after
>> workqueue_init_early() and rcu_init()
>>
>> Given that, maybe the best outcome is to stick to the alternative
>> approach that works [1] rather messing up with the order of
>> debug_objects_mem_init() in start_kernel() which seems tricky. What do
>> you think?
>>
>> [1] https://goo.gl/18N78g
>> [2] https://goo.gl/My6ig6
> 
> Could you move kmemleak_init() and debug_objects_mem_init() as far up as
> possible, like before the hrtimer_init() to at least make static count
> calculation as simple as possible?
>

Well, there is only 2 x NR_CPUS difference after moved both calls just after 
rcu_init().

          Before After
64-CPU:  1114   974
160-CPU: 2774   2429
256-CPU: 3853   4378

I suppose it is possible that the timers only need the scale factor 5 instead of 
10. However, it needs to be retested for all the configurations to be sure, and 
likely need to remove all irqs calls in kmemleak_init() and subroutines because 
it is now called with irq disabled. Given the initdata will be freed anyway, 
does it really worth doing?

BTW, calling debug_objects_mem_init() before kmemleak_init() actually could 
trigger a loop on machines with 160+ CPUs until the pool is filled up,

debug_objects_pool_min_level += num_possible_cpus() * 4;

[1] while (obj_pool_free < debug_objects_pool_min_level)

kmemleak_init
   kmemleak_ignore (from replaced static debug objects)
     make_black_object
       put_object
         __call_rcu (kernel/rcu/tree.c)
           debug_rcu_head_queue
             debug_object_activate
               debug_object_init
                 fill_pool
                   kmemleak_ignore (looping in [1])
                     make_black_object
                       ...

I think until this is resolved, there is no way to move debug_objects_mem_init() 
before kmemleak_init().
