Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC441C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 18:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9C720815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 18:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9C720815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbeKSFSH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 00:18:07 -0500
Received: from mout.gmx.net ([212.227.15.19]:59807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbeKSFSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 00:18:07 -0500
Received: from qians-mbp.fios-router.home ([98.118.28.103]) by mail.gmx.com
 (mrgmx002 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0M4WRI-1fWTYC3JF6-00ykj7; Sun, 18 Nov 2018 19:56:49 +0100
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] debugobjects: add a new Kconfig for POOL_SIZE
From:   Qian Cai <cai@gmx.us>
In-Reply-To: <alpine.DEB.2.21.1811181919170.9459@nanos.tec.linutronix.de>
Date:   Sun, 18 Nov 2018 13:56:45 -0500
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, arnd@arndb.de,
        linux kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <5939F7F3-E332-4112-861E-C6C0DF86717E@gmx.us>
References: <20181118082255.1275-1-cai@gmx.us>
 <alpine.DEB.2.21.1811181919170.9459@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3445.100.39)
X-Provags-ID: V03:K1:vR5BwMhU4oDjH27a+ImJbsq6AZ8q4ey6908YspEJVf8nyBcYMKg
 WKtI5ByX7Fn/NPgh4qFXY74pc6HPiUmAGnMhH89qwFolbZTaQCGPsphJlAv0d45mdFYWP9z
 U7DlTgBfOo5OOiP1Z33RdKO+jL8hoRYfU0RNDkZ4u95FRwfcZ3JGqd68RKg2LJ9/ryWiDmm
 XwbJxxZy4MYqRXEO3/9Qg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nDtCMvFp7U0=:LppxwqxcTwVfYb5GoMS3Oz
 YNFQvb/fNmQHKdj0W/xxbZmrpk9iwxD2QZRbPNzRcM2hmtkqdN7SP1W1F1enGtoO8/SWgCuci
 RvvBVyLXuB7/nUDb5zC/QNF0z8peTdbwodhDjXN5PYKQbCkXtlTgUY2X/DA2eZJ0EuOkkcaBd
 Zw+UyB3mxqG0n4+n/vH1tL4Hoc988cWO2Pf+8I1IihU5rifA6OhKS0GZ+dx7GTOQ4fKkYiZza
 hae8+XxPxzKY59AQO4lz8fEc7ZLDSuXz/0unQ6ergTOsYILUZHxpp9HGZGajZP6gQ0Xw/bheY
 z6sRwgX9CjwCMnQ39ZcA7qIlLhcjjkER/R+kDkJvbHlEApLUKSMAB9g0HzB2vIhEQ1kumlXpL
 LPUHCN8CQC0yuL3F0trG3d6xjFoqqiBxEDAtnbJ1EfeYNKJD6ZBhmCaSPVHhLcbnRsJYWaWDT
 8ZMtqp2+zjzsckCi4p54HZYMEwau1c/YS7jSJe6SioRP9R0+1gG5I95REyGuLo7OrLhBB32XG
 CNUTcVR9Ya5602LkItgCyp0efmicRRxhjVSU9/ID63QGcWNOdpUjTP9cs0fq/0XcOVRo3DvUS
 K5SW/x4huzWXY0ubtQQoslS0dZxz12RiqEYk1kRJnZgA0XJtvXPO3VIj1AlPIQHvvmTp0U+J9
 jiDdEPUx5VjcBASNjcgmSapJDVvTw0douK2yIA1TaVbw4AXczdqQ/YY3Qjl5diuo4yR6JR/PS
 QUjYT5mWYZX4UJp4/I2Ze/GmWF2G59LrnJSvuYaz3Ym+Q+JcBUJy7pUYh/QFEw4+vN3bo9pGL
 P6RAH+mcUmZPB/hj26aMBXjNWj/1EVKsL25NPWYsVNE2ZapPG3SRMNCbLcThHS7d0pRvH7L5J
 IcntWK0DKBT0zR/1MaFCrr1e+at8gVWzNxGL6lhrP8ryMeb9e6SV4YDh61KLpv
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 18, 2018, at 1:21 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> Qian,
> 
> On Sun, 18 Nov 2018, Qian Cai wrote:
> 
>> The current value of ODEBUG_POOL_SIZE is not big enough for large memory
>> systems with timer or/and workqueue objects because during the early
>> boot, timer objects needs at least the size equals to
>> 
>> No. CPUs x 2 (worker pool)
>> 
>> start_kernel
>>  workqueue_init_early
>>    init_worker_pool
>>      init_timer_key
>>        debug_object_init
>> 
>> puls, No. CPUs
>> 
>> start_kernel
>>  sched_init
>>    hrtimer_init
>>     debug_object_init
>> 
>> Then, workqueue objects requires even more,
>> 
>> No. CPUs x 2 (worker pool) x 6 (workqueue)
>> 
>> start_kernel
>>  workqueue_init_early
>>    __alloc_workqueue_key
>>      alloc_workqueue
>>        init_pwq
>>          debug_object_init
>> 
>> plus, No, CPUs x 2 (worker pool)
>> 
>> start_kernel
>>  perf_event_init
>>    __init_srcu_struct
>>      init_srcu_struct_fields
>>        __init_work
>>          debug_object_init
>> 
>> As the results, systems have 60+ CPUs with both timer and workqueue
>> objects enabled could trigger "ODEBUG: Out of memory. ODEBUG disabled".
>> 
>> Hence, add a new Kconfig option so users could adjust ODEBUG_POOL_SIZE
>> accordingly if either timer or workqueue objects are selected.
> 
> why do we need a config option, when the required number can be deduced
> already from the active CONFIG_DEBUG_OBJECTS_* and NR_CPUS?
> 
It because I am worry about the coupling between the implementation details of
timers and workqueue objects, and the computation in the code you mentioned
here. For example, people could change workqueue.c to have different number
of worekqueues initialized during the early boot in the future which is going to
affect the required pool size, and I am not sure if people are going to adjust the
code in debugobjects.c here as well when they made changes like that.

Also, the computation could become so complex depends on lots of config
options like perf, hrtimer, and combinations that I have not tested so far which is
difficult to exhausted all the possibilities.

Hence, I feel like the Kconfig option is more flexible and less error-prone.
