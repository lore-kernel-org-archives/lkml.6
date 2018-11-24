Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57CFC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A682B20868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A682B20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbeKXNs1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 08:48:27 -0500
Received: from mout.gmx.net ([212.227.15.19]:48949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbeKXNs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 08:48:27 -0500
Received: from [192.168.1.153] ([98.118.28.103]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MdKkd-1g9gIB2VJz-00IWBS; Sat, 24
 Nov 2018 04:01:24 +0100
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH v4] debugobjects: scale the static pool size
From:   Qian Cai <cai@gmx.us>
In-Reply-To: <alpine.DEB.2.21.1811222238270.1665@nanos.tec.linutronix.de>
Date:   Fri, 23 Nov 2018 22:01:20 -0500
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, arnd@arndb.de,
        linux kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <EAB01918-727E-4E6F-AC7F-0417CA469D5A@gmx.us>
References: <20181120232810.2503-1-cai@gmx.us>
 <20181121021157.3061-1-cai@gmx.us>
 <alpine.DEB.2.21.1811222238270.1665@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3445.101.1)
X-Provags-ID: V03:K1:hUBchp+F7xE/uK3swm/ZNd2CGJ4HQsL4HUMWDf2LaEV0fY5h9dN
 mjmP3ZfPmwi05G+kCtyMO4miHzYfM/PFm/p4AuFxt/FcK8I/z6V31Xy2qqrst2h5aGie9ON
 18nXLpr1CjJfeM262TEyXNDeVkJBbxFi/5xNeDdZNPS13fF1V4eX4PVgI2hTZBXMVBpxgNX
 t0l08llJk117S2AuM/vVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tx8qpXHwCXo=:RO9bgdjIqqgw0qp2TT6zeA
 WiJGydAsrqphp5lWrAS3kpyc1s15wCjFxH0qxtJzEXwGJHoFoZF6azf5jfUyWg0chtw7jZOUX
 DScF1+F6NO1qgAYK9FSvtfDxx5+rfUEIHAU89jjDcBalvV2XyoX3JZakYaU6k5TfSjGrPEfDh
 fa3U4aZBgT3Y+7XzL3vxV9vfx4cQnYLl4znD8E1ZvqJdgXiJQSsG0I5m2CoOChuwsx+8Dq5Z7
 HEgG04G8LfBD1kdaq4FLVcSrtSAxev0Gc5ysh+VyjhgajSOegeMNS6gOedwMH2I+hZ7cO9/Da
 xM3jrrGduhkCrdpFDTJjg9m5IdZjjHpjBFwzzl9e8cbSSDNwUrklToTbZ3zpFN9nO5VhHA9QZ
 R20533U262cM27BDenE2WuueJ18/xHdPKYTAUpU+9ecClfPvN+sXfcV9tmztSuiRSxYLnf69B
 OdEkQHMuu5HDesaQaENodZt25A7/v9xlBU4h/jnltk2VUR5Jj+38kGA+tsy5gw+ZQd3GhqmEN
 o8kVHf8FnfR1bXa2KFPUOX8PuhxDqm/j5bSnh+O0vr8NKZniL8x/Ge02KJYHJ5QHy7xT+mQbl
 Y84+ACytMaDsDy9K9XXLD2UoAI7duAFiG4CduCHUvAJKp6HBHLZXUFXsTUOR/NhE2u9Ob37Mv
 otfS79qmOqHW3IUfTVc+UZG7QTHRoOYhviigHUz6buKS42OCGlXY1UgmfbKLpxgoS5cGNmrDv
 fBzLouPya5RveCCIYkMizxRk/pCA5H5e1yiV3Okpr1sw7RIIF3PnURopxY9hzVFUHxIUuDL7Y
 +f9ulkAtZ4vqaY/IyHZScUlp9XXlsoUSzjqFBmHF/ut4HNpLRdVcLeRKjeOE3xPrOkeW3GI9/
 U09JXV/KCJU+pBAlsEBDoIgPb3TEyOlBsYGv/IlN8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 22, 2018, at 4:56 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> On Tue, 20 Nov 2018, Qian Cai wrote:
> 
> Looking deeper at that.
> 
>> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
>> index 70935ed91125..140571aa483c 100644
>> --- a/lib/debugobjects.c
>> +++ b/lib/debugobjects.c
>> @@ -23,9 +23,81 @@
>> #define ODEBUG_HASH_BITS	14
>> #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
>> 
>> -#define ODEBUG_POOL_SIZE	1024
>> +#define ODEBUG_DEFAULT_POOL	512
>> #define ODEBUG_POOL_MIN_LEVEL	256
>> 
>> +/*
>> + * Some debug objects are allocated during the early boot. Enabling some options
>> + * like timers or workqueue objects may increase the size required significantly
>> + * with large number of CPUs. For example (as today, 20 Nov. 2018),
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
> 
> None of the things are actually used or required _BEFORE_
> debug_objects_mem_init() is invoked.
> 
> The reason why the call is at this place in start_kernel() is
> historical. It's because back in the days when debugobjects were added the
> memory allocator was enabled way later than today. So we can just move the
> debug_objects_mem_init() call right before sched_init() I think.

Well, now that kmemleak_init() seems complains that debug_objects_mem_init()
is called before it.

[    0.078805] kmemleak: Cannot insert 0xc000000dff930000 into the object search tree (overlaps existing)
[    0.078860] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.20.0-rc3+ #3
[    0.078883] Call Trace:
[    0.078904] [c000000001c8fcd0] [c000000000c96b34] dump_stack+0xe8/0x164 (unreliable)
[    0.078935] [c000000001c8fd20] [c000000000486e84] create_object+0x344/0x380
[    0.078962] [c000000001c8fde0] [c000000000489544] early_alloc+0x108/0x1f8
[    0.078989] [c000000001c8fe20] [c00000000109738c] kmemleak_init+0x1d8/0x3d4
[    0.079016] [c000000001c8ff00] [c000000001054028] start_kernel+0x5c0/0x6f8
[    0.079043] [c000000001c8ff90] [c00000000000ae7c] start_here_common+0x1c/0x520
[    0.079070] kmemleak: Kernel memory leak detector disabled
[    0.079091] kmemleak: Object 0xc000000ffd587b68 (size 40):
[    0.079112] kmemleak:   comm "swapper/0", pid 0, jiffies 4294937299
[    0.079135] kmemleak:   min_count = -1
[    0.079153] kmemleak:   count = 0
[    0.079170] kmemleak:   flags = 0x5
[    0.079188] kmemleak:   checksum = 0
[    0.079206] kmemleak:   backtrace:
[    0.079227]      __debug_object_init+0x688/0x700
[    0.079250]      debug_object_activate+0x1e0/0x350
[    0.079272]      __call_rcu+0x60/0x430
[    0.079292]      put_object+0x60/0x80
[    0.079311]      kmemleak_init+0x2cc/0x3d4
[    0.079331]      start_kernel+0x5c0/0x6f8
[    0.079351]      start_here_common+0x1c/0x520
[    0.079380] kmemleak: Early log backtrace:
[    0.079399]    memblock_alloc_try_nid_raw+0x90/0xcc
[    0.079421]    sparse_init_nid+0x144/0x51c
[    0.079440]    sparse_init+0x1a0/0x238
[    0.079459]    initmem_init+0x1d8/0x25c
[    0.079498]    setup_arch+0x3e0/0x464
[    0.079517]    start_kernel+0xa4/0x6f8
[    0.079536]    start_here_common+0x1c/0x520

