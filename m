Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+ExK7PWNGUYaykcB7X7om3l/jqzyIMlAlolVGBXXAy8LOPTTChyHMYO9y+erRiDhFht+4X
ARC-Seal: i=1; a=rsa-sha256; t=1523393466; cv=none;
        d=google.com; s=arc-20160816;
        b=05J1oUdfcGcnECiprJ7DvevT1eozxkyGV8y3ETq6dGcFQgImjsQDC4uBTMoJ2k8IdT
         7DJ86TR5hzP3gKbpWYpIWQ3ix5+W+O1+O7FwHg9sKi5EedzRBxT9JUXmog6hTkwCCfVf
         VA86RhyN00jEWmz6HwBUcbjymqYYSX848lmnmewEIxQenjmqVtZif69qz8kKp162VeAl
         BuXmhfUSwoPVfLxgJfFEwn5aTB/wwKbdkZiQ9eX+nBaQPy34BQy5NC4r5Fc8D3LMaxV3
         JDlkdKF5XJlHMAJS0FihcAHxNr1Sd3vbJD8Jwo4j9F9uZtBQ3I6KDE/nu1O8k11/vcUc
         TZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:organization:from:references:cc:to:subject
         :arc-authentication-results;
        bh=T2svMJR48ChmquqpnyJEehQ58/FJ5EjX/fb0WXNoXEI=;
        b=QaiAwZf9kZczhsQlfWg9LsJYLQWzuapYh4/lutOztM3AOC+GZIbFCsagryrjdB+ixz
         WO5M+sSPikAzS7Jo1PejQe6cHbdxRGKK18SGFJkjsZ7rIYfZ9uF5n6yGFTwE7YW718Z7
         9jdlfNWTcCqAPDFv9BwV9GqKNCj5ZM5iFn5QuvTjrukwgf9mrntJZSZ01mXV27AImHNB
         LC6IpPV4Fkx+n+KGZLeLqLe1s4V84fHfkJVR2lkI9lYGZbdZsTtOWE8sl/F38zXkgopo
         3VFsnJrgsHpCEYyhylMvTcIUhXKuMa3rF4uPv0Q7M1bK1RGdsH3UjRtCGsuZOfK556aH
         sbYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbeDJUux (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 10 Apr 2018 16:50:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751546AbeDJUuw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Apr 2018 16:50:52 -0400
Subject: Re: [PATCH v2] selftests/livepatch: introduce tests
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        =?UTF-8?Q?Libor_Pech=c3=a1=c4=8dek?= <lpechacek@suse.com>,
        Nicolai Stange <nstange@suse.de>,
        Artem Savkov <asavkov@redhat.com>
References: <1523373354-10801-1-git-send-email-joe.lawrence@redhat.com>
 <1523373354-10801-2-git-send-email-joe.lawrence@redhat.com>
 <20180410200059.loy3hw6tcwdi4m5z@treble>
From: Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <daac17e1-6e32-fce9-51b0-24ec25bda69f@redhat.com>
Date: Tue, 10 Apr 2018 16:50:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180410200059.loy3hw6tcwdi4m5z@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597372767626625774?=
X-GMAIL-MSGID: =?utf-8?q?1597393827813782407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/10/2018 04:00 PM, Josh Poimboeuf wrote:
> On Tue, Apr 10, 2018 at 11:15:54AM -0400, Joe Lawrence wrote:
>> +static void test_klp_shadow_vars_exit(void)
>> +{
>> +}
>> +
>> +module_init(test_klp_shadow_vars_init);
>> +module_init(test_klp_shadow_vars_exit);
> 
> For this last line, s/module_init/module_exit/, though I think the exit
> function can just be removed altogether?

D'oh workspace / git user error, I posted an older version :(

But the exit function seems to be required if an init function is
provided.  Here I omitted the exit function:

  % modprobe test_klp_shadow_vars
  % lsmod | grep test_klp_shadow_vars
  test_klp_shadow_vars    16384  0
  % rmmod test_klp_shadow_vars
  rmmod: ERROR: could not remove 'test_klp_shadow_vars': Device or
    resource busy
  rmmod: ERROR: could not remove module test_klp_shadow_vars: Device or
    resource busy

and from kernel/module.c

SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
                unsigned int, flags)
...
        /* If it has an init func, it must have an exit func to unload*/
        if (mod->init && !mod->exit) {
                forced = try_force_unload(flags);
                if (!forced) {
                        /* This module can't be removed */
                        ret = -EBUSY;
                        goto out;
                }
        }
...

> 
> Also I get the following bug (run on latest Linus master + Petr's two
> patch sets):
> 
> [  106.302072] % modprobe test_klp_shadow_vars
> [  106.311165] test_klp_shadow_vars: klp_shadow_get(obj=PTR5, id=0x1234) = PTR0
> [  106.313080] test_klp_shadow_vars:   got expected NULL result
> [  106.314811] BUG: sleeping function called from invalid context at mm/slab.h:421
> [  106.316518] in_atomic(): 1, irqs_disabled(): 1, pid: 2254, name: modprobe
> [  106.318107] 1 lock held by modprobe/2254:
> [  106.319332]  #0: 00000000d0851080 (klp_shadow_lock){....}, at: __klp_shadow_get_or_alloc+0x88/0x1b0
> [  106.321220] irq event stamp: 4408
> [  106.322176] hardirqs last  enabled at (4407): [<ffffffff8114c28e>] console_unlock+0x44e/0x680
> [  106.323598] hardirqs last disabled at (4408): [<ffffffff8199e6c7>] _raw_spin_lock_irqsave+0x27/0x90
> [  106.325041] softirqs last  enabled at (4404): [<ffffffff81c0039b>] __do_softirq+0x39b/0x4fc
> [  106.326469] softirqs last disabled at (4367): [<ffffffff810d8450>] irq_exit+0xe0/0xf0
> [  106.327901] Preemption disabled at:
> [  106.327905] [<ffffffff81167c28>] __klp_shadow_get_or_alloc+0x88/0x1b0
> [  106.330117] CPU: 7 PID: 2254 Comm: modprobe Tainted: G              K  4.16.0+ #60
> [  106.331565] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-2.fc27 04/01/2014
> [  106.333143] Call Trace:
> [  106.334011]  dump_stack+0x8e/0xd5
> [  106.334962]  ___might_sleep+0x185/0x260
> [  106.335997]  ? shadow_dtor+0x40/0x40 [test_klp_shadow_vars]
> [  106.337170]  __might_sleep+0x4a/0x80
> [  106.338137]  kmem_cache_alloc_trace+0x20b/0x300
> [  106.339183]  ? ptr_id+0x5c/0xd0 [test_klp_shadow_vars]
> [  106.340341]  ? shadow_dtor+0x40/0x40 [test_klp_shadow_vars]
> [  106.341506]  ptr_id+0x5c/0xd0 [test_klp_shadow_vars]
> [  106.342725]  shadow_ctor+0x20/0x40 [test_klp_shadow_vars]
> [  106.343998]  __klp_shadow_get_or_alloc+0xc4/0x1b0
> [  106.345184]  ? shadow_dtor+0x40/0x40 [test_klp_shadow_vars]
> [  106.346494]  klp_shadow_alloc+0x10/0x20
> [  106.347583]  shadow_alloc+0x28/0xa0 [test_klp_shadow_vars]
> [  106.348871]  ? shadow_free_all+0x40/0x40 [test_klp_shadow_vars]
> [  106.350200]  test_klp_shadow_vars_init+0x96/0x400 [test_klp_shadow_vars]
> [  106.351646]  ? shadow_free_all+0x40/0x40 [test_klp_shadow_vars]
> [  106.352949]  do_one_initcall+0x61/0x37f
> [  106.353963]  ? rcu_read_lock_sched_held+0x79/0x80
> [  106.355040]  ? kmem_cache_alloc_trace+0x29d/0x300
> [  106.356098]  ? do_init_module+0x27/0x213
> [  106.357090]  do_init_module+0x5f/0x213
> [  106.358047]  load_module+0x2815/0x2e70
> [  106.358992]  ? vfs_read+0x12d/0x150
> [  106.359920]  SYSC_finit_module+0xfc/0x120
> [  106.360870]  ? SYSC_finit_module+0xfc/0x120
> [  106.361839]  SyS_finit_module+0xe/0x10
> [  106.362753]  do_syscall_64+0x7e/0x240
> [  106.363645]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> [  106.364711] RIP: 0033:0x7f26d0d40b19
> [  106.365799] RSP: 002b:00007ffee1de19a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [  106.367306] RAX: ffffffffffffffda RBX: 00005636550d54b0 RCX: 00007f26d0d40b19
> [  106.368573] RDX: 0000000000000000 RSI: 0000563654134186 RDI: 0000000000000003
> [  106.369950] RBP: 0000563654134186 R08: 0000000000000000 R09: 00005636550d4270
> [  106.371164] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
> [  106.372422] R13: 00005636550d53b0 R14: 0000000000040000 R15: 00005636550d54b0

I missed Petr's commit msg note "that the constructor is called under
klp_shadow_lock."  I'll convert the test to use GFP_ATOMIC for this
allocation.

I'll also add CONFIG_PM_SLEEP_DEBUG=y to my test VM kernel .config.  Any
other debug option suggestions?

-- Joe
