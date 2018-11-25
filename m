Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28861C04EBA
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E167E20855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E167E20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbeKZHe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 02:34:26 -0500
Received: from mout.gmx.net ([212.227.15.15]:53045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbeKZHe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 02:34:26 -0500
Received: from ovpn-120-100.rdu2.redhat.com ([98.118.28.103]) by mail.gmx.com
 (mrgmx003 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0MJBRC-1gOGLN3G7m-002m3A; Sun, 25 Nov 2018 21:42:16 +0100
Subject: Re: [PATCH v4] debugobjects: scale the static pool size
From:   Qian Cai <cai@gmx.us>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, arnd@arndb.de,
        linux kernel <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20181120232810.2503-1-cai@gmx.us>
 <20181121021157.3061-1-cai@gmx.us>
 <alpine.DEB.2.21.1811222238270.1665@nanos.tec.linutronix.de>
 <EAB01918-727E-4E6F-AC7F-0417CA469D5A@gmx.us>
Message-ID: <211af3b2-bc56-2d1b-c6c2-f6853797a7a1@gmx.us>
Date:   Sun, 25 Nov 2018 15:42:12 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <EAB01918-727E-4E6F-AC7F-0417CA469D5A@gmx.us>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:oeVEs8J40g5GIZC7zQOsuXWiCI+bgUXEbwtzsxgM5qTVCnNCawU
 myiNjo2yZBZItcbMp/jK1zXswN/f5gERVZj0Ka2/oN1TbbqBu9KUd5fRoGxdUpFUznLEV6D
 cLz3fxIhUB1PaiMKnwwj9l3Rx87P7uqut5tR/9FoZMEfQZAaG7nGUmuwKLkoW75iiCppPDD
 juYpf4Kgr/B+o8UM3D+rg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sNHUuEzOiNs=:2Cb0G8D3klR7emIY2jfLHg
 pve4B6NoFgC5K6NW/ByhVL0vyTvKNhCR3qrmJ9/CIhC2uzDFa598d6DT+TG2sSd/Q2IXhso+N
 kOE5urxk2gPWwYDp1eDjJGtQ7OsKtYqDav/0Yn0ZBE4jPrpjy5ofj5q2Rtp5AMSs8Z2EabSxY
 l/TS8eZAhDWzmhEDbRpiXvXHGckoL1n95yryOGfuzyGura3j9rIH0P9S1dBoNQITsXMjyn3YF
 R+NccaqgLMkcmhXyJjrOlGaRqFCRnZw3zA0iqRj2BAglro9d/JfxFuoQbetXVZ9Cg3ldafxwa
 S7LnSgRtsL6+CO+vGTsz09FmV+4ehMn94WD4x8C8TdEryjJYIETeRxVeB0CmUnNcjFyRJ6R9a
 0dW10nsrFljxeiG+JgNV081WCwAsKuwmq3yZoqyEDgrP4kFOVmypQHqJ014FLy2g3ZDzHQ6Ih
 6eWGm3DLt0jce0cpyxvGVdieub15PXr0d3Y5kw3PqPTxH3zBAuPC6eCA4CKEc7Yjpzy/V6tTe
 lOYV0OlpiCh2GqyYWzNHqQ/hmXhMLP5yTroS7PgNqgrykjhw5gHo3ktgsbNWPUcxwvNO1OuRv
 zDL83I9i+3/yMh2HOlE16H82QbfLzBu0XfaXE0ZckPzgAMkkrS4D9SdUQjwA0ixWXO3ZkF9NM
 Ua9x9bzRZ15LbffYTHIi+28YGUf7A/2Eb+46f5RFmFkSgIM9/xUKMWpSQjio9xwT1XJ4Ng3Ck
 y1I/miC4dmfM8gwqPBsFrtkVP9j4DBiThntbaQwe/BK43zzyquLZzBT1N+RlD4W2DfKlqC1bZ
 ogVWkUUWTao95FnDn+lAWme69IrT5bLIX3gFrcjFANB1NhkE8UkVLAEsJtIIBtpFw7COMu1vR
 GWPI57ynV4De+CwCLdi/j8/itAZOHRFbgefGrwlwg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/18 10:01 PM, Qian Cai wrote:
> 
> 
>> On Nov 22, 2018, at 4:56 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> On Tue, 20 Nov 2018, Qian Cai wrote:
>>
>> Looking deeper at that.
>>
>>> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
>>> index 70935ed91125..140571aa483c 100644
>>> --- a/lib/debugobjects.c
>>> +++ b/lib/debugobjects.c
>>> @@ -23,9 +23,81 @@
>>> #define ODEBUG_HASH_BITS	14
>>> #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
>>>
>>> -#define ODEBUG_POOL_SIZE	1024
>>> +#define ODEBUG_DEFAULT_POOL	512
>>> #define ODEBUG_POOL_MIN_LEVEL	256
>>>
>>> +/*
>>> + * Some debug objects are allocated during the early boot. Enabling some options
>>> + * like timers or workqueue objects may increase the size required significantly
>>> + * with large number of CPUs. For example (as today, 20 Nov. 2018),
>>> + *
>>> + * No. CPUs x 2 (worker pool) objects:
>>> + *
>>> + * start_kernel
>>> + *   workqueue_init_early
>>> + *     init_worker_pool
>>> + *       init_timer_key
>>> + *         debug_object_init
>>> + *
>>> + * No. CPUs objects (CONFIG_HIGH_RES_TIMERS):
>>> + *
>>> + * sched_init
>>> + *   hrtick_rq_init
>>> + *     hrtimer_init
>>> + *
>>> + * CONFIG_DEBUG_OBJECTS_WORK:
>>> + * No. CPUs x 6 (workqueue) objects:
>>> + *
>>> + * workqueue_init_early
>>> + *   alloc_workqueue
>>> + *     __alloc_workqueue_key
>>> + *       alloc_and_link_pwqs
>>> + *         init_pwq
>>> + *
>>> + * Also, plus No. CPUs objects:
>>> + *
>>> + * perf_event_init
>>> + *    __init_srcu_struct
>>> + *      init_srcu_struct_fields
>>> + *        init_srcu_struct_nodes
>>> + *          __init_work
>>
>> None of the things are actually used or required _BEFORE_
>> debug_objects_mem_init() is invoked.
>>
>> The reason why the call is at this place in start_kernel() is
>> historical. It's because back in the days when debugobjects were added the
>> memory allocator was enabled way later than today. So we can just move the
>> debug_objects_mem_init() call right before sched_init() I think.
> 
> Well, now that kmemleak_init() seems complains that debug_objects_mem_init()
> is called before it.
> 
> [    0.078805] kmemleak: Cannot insert 0xc000000dff930000 into the object search tree (overlaps existing)
> [    0.078860] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.20.0-rc3+ #3
> [    0.078883] Call Trace:
> [    0.078904] [c000000001c8fcd0] [c000000000c96b34] dump_stack+0xe8/0x164 (unreliable)
> [    0.078935] [c000000001c8fd20] [c000000000486e84] create_object+0x344/0x380
> [    0.078962] [c000000001c8fde0] [c000000000489544] early_alloc+0x108/0x1f8
> [    0.078989] [c000000001c8fe20] [c00000000109738c] kmemleak_init+0x1d8/0x3d4
> [    0.079016] [c000000001c8ff00] [c000000001054028] start_kernel+0x5c0/0x6f8
> [    0.079043] [c000000001c8ff90] [c00000000000ae7c] start_here_common+0x1c/0x520
> [    0.079070] kmemleak: Kernel memory leak detector disabled
> [    0.079091] kmemleak: Object 0xc000000ffd587b68 (size 40):
> [    0.079112] kmemleak:   comm "swapper/0", pid 0, jiffies 4294937299
> [    0.079135] kmemleak:   min_count = -1
> [    0.079153] kmemleak:   count = 0
> [    0.079170] kmemleak:   flags = 0x5
> [    0.079188] kmemleak:   checksum = 0
> [    0.079206] kmemleak:   backtrace:
> [    0.079227]      __debug_object_init+0x688/0x700
> [    0.079250]      debug_object_activate+0x1e0/0x350
> [    0.079272]      __call_rcu+0x60/0x430
> [    0.079292]      put_object+0x60/0x80
> [    0.079311]      kmemleak_init+0x2cc/0x3d4
> [    0.079331]      start_kernel+0x5c0/0x6f8
> [    0.079351]      start_here_common+0x1c/0x520
> [    0.079380] kmemleak: Early log backtrace:
> [    0.079399]    memblock_alloc_try_nid_raw+0x90/0xcc
> [    0.079421]    sparse_init_nid+0x144/0x51c
> [    0.079440]    sparse_init+0x1a0/0x238
> [    0.079459]    initmem_init+0x1d8/0x25c
> [    0.079498]    setup_arch+0x3e0/0x464
> [    0.079517]    start_kernel+0xa4/0x6f8
> [    0.079536]    start_here_common+0x1c/0x520
> 

So this is an chicken-egg problem. Debug objects need kmemleak_init() first, so 
it can make use of kmemleak_ignore() for all debug objects in order to avoid the 
overlapping like the above.

while (obj_pool_free < debug_objects_pool_min_level) {

	new = kmem_cache_zalloc(obj_cache, gfp);
	if (!new)
		return;

	kmemleak_ignore(new);

However, there seems no way to move kmemleak_init() together this early in 
start_kernel() just before vmalloc_init() [1] because it looks like it depends 
on things like workqueue (schedule_work(&cleanup_work)) and rcu. Hence, it needs 
to be after workqueue_init_early() and rcu_init()

Given that, maybe the best outcome is to stick to the alternative approach that 
works [1] rather messing up with the order of debug_objects_mem_init() in 
start_kernel() which seems tricky. What do you think?

[1] https://goo.gl/18N78g
[2] https://goo.gl/My6ig6
