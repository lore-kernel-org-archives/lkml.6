Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx49LBkdQsK00It4uRGNIMca/gUTb2IRdp4w7XFnPvEZIAYN6YISllobnpgo4VM9RYWaxcIKl
ARC-Seal: i=1; a=rsa-sha256; t=1523390464; cv=none;
        d=google.com; s=arc-20160816;
        b=cDyxlGzSnVl7HJLum0wcmxvUd1L2Wws+pygE1wvUqU0JsfJjYpPDC5e+G1Fng9RfYz
         Cg/qa+o77ceLGTa8HcYCtsr9Xup5OFE07UUs4qaB64uDxUP8/6RkOLXz1XlNDgcJ+c42
         2xTSLv7ceu5GoJzLszTXGKMs8fYdVd6ozAcCxRHcNjnL7EYRNU0QICcV3IO82olGijFu
         PswlFizVpCyOFPlHXf312+QNwKyfaVRJgXs3dpIxLQ9GjlbmK34+pptXwp7sI7XH/OMG
         2yVRp1GtHNPdncRlQJWB/mZNcvJYO+l3QDG+sz5Bxyk10QuQevBEimGYOsyC4UCnU8Ad
         qnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=IkCfN0LNELAqjrWf4qnBy3hphEP2fUkLffFQxmh5mqA=;
        b=osTVIQjW53B43n/u86yOfgjwwsuHH9cuKr92XIIL7sPLhG2BejS6j1BJsK93F3/O3s
         Jif7BJ6OwqBNHkr0r3s8ohwMKbE+vIlkwvK+/9Qw4bPNzFZ2MkTe9NLCPl7soncFS1E3
         3ZoyKX+OU/8Hlk3rtvJHCJnZq6oKTYyWQ2e963Rl83sQtJtNiUnPzq+WJ1qKIUUBuQgD
         bFJGpTiZ945KolU+1eNOuovLb12lCFd2yKjW+ur3SfMQnSziX8F/6QeZfz62KkZrJncP
         1Pr5Az/qYJ0BS5Hi7+1J+lLw0zgLsaiIvwzCAth+ZTWC8Mh/QUthLnQ0F7uM7eBXxlrC
         Owgg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeDJUBC (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 10 Apr 2018 16:01:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752274AbeDJUBB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Apr 2018 16:01:01 -0400
Date: Tue, 10 Apr 2018 15:00:59 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Libor =?utf-8?B?UGVjaMOhxI1law==?= <lpechacek@suse.com>,
        Nicolai Stange <nstange@suse.de>,
        Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCH v2] selftests/livepatch: introduce tests
Message-ID: <20180410200059.loy3hw6tcwdi4m5z@treble>
References: <1523373354-10801-1-git-send-email-joe.lawrence@redhat.com>
 <1523373354-10801-2-git-send-email-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1523373354-10801-2-git-send-email-joe.lawrence@redhat.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597372767626625774?=
X-GMAIL-MSGID: =?utf-8?q?1597390679354855282?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 11:15:54AM -0400, Joe Lawrence wrote:
> +static void test_klp_shadow_vars_exit(void)
> +{
> +}
> +
> +module_init(test_klp_shadow_vars_init);
> +module_init(test_klp_shadow_vars_exit);

For this last line, s/module_init/module_exit/, though I think the exit
function can just be removed altogether?

Also I get the following bug (run on latest Linus master + Petr's two
patch sets):

[  106.302072] % modprobe test_klp_shadow_vars
[  106.311165] test_klp_shadow_vars: klp_shadow_get(obj=PTR5, id=0x1234) = PTR0
[  106.313080] test_klp_shadow_vars:   got expected NULL result
[  106.314811] BUG: sleeping function called from invalid context at mm/slab.h:421
[  106.316518] in_atomic(): 1, irqs_disabled(): 1, pid: 2254, name: modprobe
[  106.318107] 1 lock held by modprobe/2254:
[  106.319332]  #0: 00000000d0851080 (klp_shadow_lock){....}, at: __klp_shadow_get_or_alloc+0x88/0x1b0
[  106.321220] irq event stamp: 4408
[  106.322176] hardirqs last  enabled at (4407): [<ffffffff8114c28e>] console_unlock+0x44e/0x680
[  106.323598] hardirqs last disabled at (4408): [<ffffffff8199e6c7>] _raw_spin_lock_irqsave+0x27/0x90
[  106.325041] softirqs last  enabled at (4404): [<ffffffff81c0039b>] __do_softirq+0x39b/0x4fc
[  106.326469] softirqs last disabled at (4367): [<ffffffff810d8450>] irq_exit+0xe0/0xf0
[  106.327901] Preemption disabled at:
[  106.327905] [<ffffffff81167c28>] __klp_shadow_get_or_alloc+0x88/0x1b0
[  106.330117] CPU: 7 PID: 2254 Comm: modprobe Tainted: G              K  4.16.0+ #60
[  106.331565] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-2.fc27 04/01/2014
[  106.333143] Call Trace:
[  106.334011]  dump_stack+0x8e/0xd5
[  106.334962]  ___might_sleep+0x185/0x260
[  106.335997]  ? shadow_dtor+0x40/0x40 [test_klp_shadow_vars]
[  106.337170]  __might_sleep+0x4a/0x80
[  106.338137]  kmem_cache_alloc_trace+0x20b/0x300
[  106.339183]  ? ptr_id+0x5c/0xd0 [test_klp_shadow_vars]
[  106.340341]  ? shadow_dtor+0x40/0x40 [test_klp_shadow_vars]
[  106.341506]  ptr_id+0x5c/0xd0 [test_klp_shadow_vars]
[  106.342725]  shadow_ctor+0x20/0x40 [test_klp_shadow_vars]
[  106.343998]  __klp_shadow_get_or_alloc+0xc4/0x1b0
[  106.345184]  ? shadow_dtor+0x40/0x40 [test_klp_shadow_vars]
[  106.346494]  klp_shadow_alloc+0x10/0x20
[  106.347583]  shadow_alloc+0x28/0xa0 [test_klp_shadow_vars]
[  106.348871]  ? shadow_free_all+0x40/0x40 [test_klp_shadow_vars]
[  106.350200]  test_klp_shadow_vars_init+0x96/0x400 [test_klp_shadow_vars]
[  106.351646]  ? shadow_free_all+0x40/0x40 [test_klp_shadow_vars]
[  106.352949]  do_one_initcall+0x61/0x37f
[  106.353963]  ? rcu_read_lock_sched_held+0x79/0x80
[  106.355040]  ? kmem_cache_alloc_trace+0x29d/0x300
[  106.356098]  ? do_init_module+0x27/0x213
[  106.357090]  do_init_module+0x5f/0x213
[  106.358047]  load_module+0x2815/0x2e70
[  106.358992]  ? vfs_read+0x12d/0x150
[  106.359920]  SYSC_finit_module+0xfc/0x120
[  106.360870]  ? SYSC_finit_module+0xfc/0x120
[  106.361839]  SyS_finit_module+0xe/0x10
[  106.362753]  do_syscall_64+0x7e/0x240
[  106.363645]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
[  106.364711] RIP: 0033:0x7f26d0d40b19
[  106.365799] RSP: 002b:00007ffee1de19a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  106.367306] RAX: ffffffffffffffda RBX: 00005636550d54b0 RCX: 00007f26d0d40b19
[  106.368573] RDX: 0000000000000000 RSI: 0000563654134186 RDI: 0000000000000003
[  106.369950] RBP: 0000563654134186 R08: 0000000000000000 R09: 00005636550d4270
[  106.371164] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
[  106.372422] R13: 00005636550d53b0 R14: 0000000000040000 R15: 00005636550d54b0
[  106.373900] test_klp_shadow_vars: shadow_ctor: PTR6 -> PTR1
[  106.375249] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR5, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR7, ctor_data=PTR1 = PTR6
[  106.378893] test_klp_shadow_vars: shadow_ctor: PTR8 -> PTR2
[  106.380305] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR7, ctor_data=PTR2 = PTR8
[  106.382779] test_klp_shadow_vars: shadow_ctor: PTR10 -> PTR3
[  106.384131] test_klp_shadow_vars: klp_shadow_alloc(obj=PTR5, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR7, ctor_data=PTR3 = PTR10
[  106.386584] test_klp_shadow_vars: klp_shadow_get(obj=PTR5, id=0x1234) = PTR6
[  106.387929] test_klp_shadow_vars:   got expected PTR6 -> PTR1 result
[  106.389181] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR8
[  106.390488] test_klp_shadow_vars:   got expected PTR8 -> PTR2 result
[  106.391731] test_klp_shadow_vars: klp_shadow_get(obj=PTR5, id=0x1235) = PTR10
[  106.393066] test_klp_shadow_vars:   got expected PTR10 -> PTR3 result
[  106.394347] test_klp_shadow_vars: shadow_ctor: PTR11 -> PTR4
[  106.395523] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR12, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR7, ctor_data=PTR4 = PTR11
[  106.398033] test_klp_shadow_vars: klp_shadow_get_or_alloc(obj=PTR12, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR7, ctor_data=PTR4 = PTR11
[  106.400554] test_klp_shadow_vars:   got expected PTR11 -> PTR4 result
[  106.401937] test_klp_shadow_vars: shadow_dtor(obj=PTR5, shadow_data=PTR6)
[  106.403592] test_klp_shadow_vars: klp_shadow_free(obj=PTR5, id=0x1234, dtor=PTR13)
[  106.405083] test_klp_shadow_vars: klp_shadow_get(obj=PTR5, id=0x1234) = PTR0
[  106.406500] test_klp_shadow_vars:   got expected NULL result
[  106.407735] test_klp_shadow_vars: shadow_dtor(obj=PTR9, shadow_data=PTR8)
[  106.409252] test_klp_shadow_vars: klp_shadow_free(obj=PTR9, id=0x1234, dtor=PTR13)
[  106.410867] test_klp_shadow_vars: klp_shadow_get(obj=PTR9, id=0x1234) = PTR0
[  106.412232] test_klp_shadow_vars:   got expected NULL result
[  106.413461] test_klp_shadow_vars: shadow_dtor(obj=PTR12, shadow_data=PTR11)
[  106.414888] test_klp_shadow_vars: klp_shadow_free(obj=PTR12, id=0x1234, dtor=PTR13)
[  106.416319] test_klp_shadow_vars: klp_shadow_get(obj=PTR12, id=0x1234) = PTR0
[  106.417681] test_klp_shadow_vars:   got expected NULL result
[  106.418947] test_klp_shadow_vars: klp_shadow_get(obj=PTR5, id=0x1235) = PTR10
[  106.420314] test_klp_shadow_vars:   got expected PTR10 -> PTR3 result
[  106.421658] test_klp_shadow_vars: shadow_dtor(obj=PTR5, shadow_data=PTR10)
[  106.423065] test_klp_shadow_vars: klp_shadow_free_all(id=0x1235, dtor=PTR13)
[  106.424421] test_klp_shadow_vars: klp_shadow_get(obj=PTR5, id=0x1234) = PTR0
[  106.425745] test_klp_shadow_vars:   shadow_get() got expected NULL result
[  106.438719] % rmmod test_klp_shadow_vars


-- 
Josh
