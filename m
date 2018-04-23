Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-977394-1524478897-2-4412114365426792933
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='jp',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524478896; b=LA+88VlJ1g4e89wj86YH2XvL7ufixkFaUSRvxBBV4q9HBF04OP
    1KnB8P9dqpZKwZFFmBRH2EKDON0rPOq2RJPjE/k08taQqHud3rMGJedSObfIsM27
    SH1TcczxCywytoqHY/3/zuhbJ1aO0vLxjjih4NgNS7S+5rWsk1dQA1RiC76lX/YQ
    IM0RxpcWTBcjeh3Cm2bWD8Fg6nffqCNEJXrt0dfhC4AcWhd5d224cbHAhtzR/tHs
    Qafg3IgLOjyPyN9Jk6oHVfL1INUn1T4k/pgff97IBbyxyjn3yDLAIYQtVEEiO0+3
    BJs8P1TZg4XXAvldAwBP3MRM/697AkUSoxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:subject:from:references:in-reply-to
    :message-id:date:mime-version:content-type:sender:list-id; s=
    fm2; t=1524478896; bh=xCV5YNE015F5/u6ZmvFrjaKmhQYLkft9VeV7rZrKzr
    s=; b=DfqQxxOhWwZO5k7vMmGPJp3KR0cHOUzmyfBA+FWWmjgC50yHJDl6GwDvM5
    4jxIYGHhGB9Z/1LnPXmN8iIwBQ8XnK4sBuzDL7Eu0wuLb7oUtX88EEBUjNwVmw/b
    84k0WanCKyuLrTwf0xEcwaqoUaVIuIw/dpPIxEIVpwboUaPs9nCd0ggFM+Lsl2T0
    82tJS252kLVaYknR8mu00R/LnHzjhPRUDHbDKxMrL4DrH4JOAo5ARAaG+hqIssy8
    mFdaQhdjWS4zuhpmer3OqUl/Li1Fk0G36Y2FFhWG4VSKL04AEu5lsbmISSeUJZPw
    9E/2zPGtYaOSVzgbBvzaQzWfmZ7Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i-love.sakura.ne.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=i-love.sakura.ne.jp header.result=pass header_org.domain=sakura.ne.jp header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i-love.sakura.ne.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=i-love.sakura.ne.jp header.result=pass header_org.domain=sakura.ne.jp header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCWf9m9+jSlp2Qk3hdQiuExgy3fqB+oA5LGN9dYARhX84PfImSd1xat2n7Aiu0A2+fggzPPj+kqAJPGoDamaPrwMHjaRtEPtuxZZqyUAqgq3E+ETQJYx
    T6wvaQgK11KKA+10jp4LUIX7CeAY/19yQBHk3VRekE/h2p+EqWIhpzFeEBw4gvhVOkXBK3R9Gkf7hY/WsZ702wAs2cGBmeqXl2mIokmHLzKmixqNmwVoJ0oQ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=aAPSQ65IO3A9JzBwx-oA:9 a=iiQ_QwEo3xzFIyTy:21 a=bHgbA5t9P-cRpNoF:21
    a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754682AbeDWKVc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 06:21:32 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:20053 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753109AbeDWKV3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 06:21:29 -0400
To: gregkh@linuxfoundation.org, ben@decadent.org.uk
Cc: linux-kernel@vger.kernel.org, tytso@mit.edu,
        stable@vger.kernel.org, jannh@google.com, stable@kernel.org,
        carnil@debian.org
Subject: Re: [PATCH 4.9 75/95] random: set up the NUMA crng instances after the CRNG is fully initialized
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20180422135210.432103639@linuxfoundation.org>
        <20180422135213.491879480@linuxfoundation.org>
        <49fa7d5f484a06f02946afec0688c33849e018de.camel@decadent.org.uk>
        <20180423071520.GC28186@kroah.com>
In-Reply-To: <20180423071520.GC28186@kroah.com>
Message-Id: <201804231921.DGB18791.QOVFLFMJFtSOHO@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Mon, 23 Apr 2018 19:21:10 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Greg Kroah-Hartman wrote:
> > I think this can be fixed by backporting commit 4a072c71f49b
> > "random: silence compiler warnings and fix race" but I'm not sure
> > whether that depends on other changes.
> 
> According to Tetsuo Handa, it's also causing problems in mainline :(
> 
> Ted, any thoughts as to what to do here?

(Resending because Webmail post was rejected by both stable ML and linux-kernel ML.)

Subject: random: GFP_KERNEL|__GFP_NOFAIL allocation from IRQ context

Hello.

Commit 8ef35c866f8862df ("random: set up the NUMA crng instances after
the CRNG is fully initialized") is causing sleep inside atomic warning
due to GFP_KERNEL|__GFP_NOFAIL allocation from IRQ context. Though it
unlikely sleeps because there will be enough free memory at boot up...

Please don't backport that patch now.

[    9.712722] BUG: sleeping function called from invalid context at mm/slab.h:421
[    9.715231] in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swapper/2
[    9.717396] INFO: lockdep is turned off.
[    9.718717] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.17.0-rc1+ #480
[    9.720857] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/19/2017
[    9.724328] Call Trace:
[    9.725176]  <IRQ>
[    9.725880]  dump_stack+0xb1/0xfc
[    9.727003]  ___might_sleep+0x23e/0x270
[    9.728285]  __might_sleep+0x45/0x80
[    9.729479]  __kmalloc+0x284/0x3e0
[    9.730642]  ? crng_reseed+0x122/0x320
[    9.731876]  crng_reseed+0x122/0x320
[    9.733078]  credit_entropy_bits+0x2f6/0x370
[    9.734503]  ? add_timer_randomness+0xb8/0xd0
[    9.735880]  add_timer_randomness+0xb8/0xd0
[    9.737201]  add_disk_randomness+0x32/0x170
[    9.738666]  scsi_end_request+0x182/0x210
[    9.740004]  scsi_io_completion+0x2cd/0x620
[    9.741448]  scsi_finish_command+0xf3/0x170
[    9.742844]  scsi_softirq_done+0x12b/0x170
[    9.744209]  blk_done_softirq+0xb2/0xd0
[    9.745501]  __do_softirq+0xcf/0x49b
[    9.746726]  irq_exit+0xbc/0xd0
[    9.747785]  smp_call_function_single_interrupt+0x17a/0x270
[    9.749603]  call_function_single_interrupt+0xf/0x20
[    9.751240]  </IRQ>
[    9.751970] RIP: 0010:native_safe_halt+0x6/0x10
[    9.753467] RSP: 0018:ffff88011963fe78 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff04
[    9.755922] RAX: ffff880119626380 RBX: ffff880119626380 RCX: 0000000000000000
[    9.758362] RDX: ffff880119626380 RSI: 0000000000000001 RDI: ffff880119626380
[    9.760743] RBP: ffff88011963fe78 R08: 0000000000000000 R09: 0000000000000000
[    9.763068] R10: 0000000000000001 R11: ffff88011a4a3693 R12: 0000000000000002
[    9.765382] R13: 0000000000000000 R14: 0000000000000000 R15: ffff880119626380
[    9.767709]  ? trace_hardirqs_on+0xd/0x10
[    9.769044]  default_idle+0x2c/0x1a0
[    9.770333]  arch_cpu_idle+0x10/0x20
[    9.771526]  default_idle_call+0x1e/0x40
[    9.772833]  do_idle+0x196/0x2a0
[    9.773923]  ? complete+0x48/0x50
[    9.775068]  cpu_startup_entry+0x5f/0x62
[    9.776392]  start_secondary+0x1a3/0x1f0
[    9.777697]  secondary_startup_64+0xa5/0xb0
[    9.779101] random: crng init done

# ./scripts/faddr2line vmlinux crng_reseed+0x122/0x320
crng_reseed+0x122/0x320:
kmalloc_array at include/linux/slab.h:631
626     {
627             if (size != 0 && n > SIZE_MAX / size)
628                     return NULL;
629             if (__builtin_constant_p(n) && __builtin_constant_p(size))
630                     return kmalloc(n * size, flags);
631             return __kmalloc(n * size, flags);
632     }
633
634     /**
635      * kcalloc - allocate memory for an array. The memory is set to zero.
636      * @n: number of elements.
(inlined by) kcalloc at include/linux/slab.h:642
637      * @size: element size.
638      * @flags: the type of memory to allocate (see kmalloc).
639      */
640     static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
641     {
642             return kmalloc_array(n, size, flags | __GFP_ZERO);
643     }
644
645     /*
646      * kmalloc_track_caller is a special version of kmalloc that records the
647      * calling function of the routine calling it for slab leak tracking instead
(inlined by) numa_crng_init at drivers/char/random.c:798
793     {
794             int i;
795             struct crng_state *crng;
796             struct crng_state **pool;
797
798             pool = kcalloc(nr_node_ids, sizeof(*pool), GFP_KERNEL|__GFP_NOFAIL);
799             for_each_online_node(i) {
800                     crng = kmalloc_node(sizeof(struct crng_state),
801                                         GFP_KERNEL | __GFP_NOFAIL, i);
802                     spin_lock_init(&crng->lock);
803                     crng_initialize(crng);
(inlined by) crng_reseed at drivers/char/random.c:923
918             memzero_explicit(&buf, sizeof(buf));
919             crng->init_time = jiffies;
920             spin_unlock_irqrestore(&crng->lock, flags);
921             if (crng == &primary_crng && crng_init < 2) {
922                     invalidate_batched_entropy();
923                     numa_crng_init();
924                     crng_init = 2;
925                     process_random_ready_list();
926                     wake_up_interruptible(&crng_init_wait);
927                     pr_notice("random: crng init done\n");
928             }
