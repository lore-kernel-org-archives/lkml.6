Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B495C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57CE206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfAKWaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:30:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52164 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfAKWav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:30:51 -0500
Received: from static-50-53-47-167.bvtn.or.frontiernet.net ([50.53.47.167] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1gi5KB-00074O-PS; Fri, 11 Jan 2019 22:30:48 +0000
Subject: Re: WARNING in apparmor_cred_free
To:     Casey Schaufler <casey@schaufler-ca.com>, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com
References: <0000000000007f604f057f2b8509@google.com>
 <6213e783-4377-489d-cdfb-1a83f4497076@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <b0d2811e-87e4-21d4-c33a-2d2012a906cc@canonical.com>
Date:   Fri, 11 Jan 2019 14:30:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6213e783-4377-489d-cdfb-1a83f4497076@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 2:11 PM, Casey Schaufler wrote:
> On 1/11/2019 1:43 AM, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    b808822a75a3 Add linux-next specific files for 20190111
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=179c22f7400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c052ead0aed5001b
>> dashboard link: https://syzkaller.appspot.com/bug?extid=69ca07954461f189e808
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162d947f400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139f6c37400000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+69ca07954461f189e808@syzkaller.appspotmail.com
>>
>> ------------[ cut here ]------------
>> AppArmor WARN cred_label: ((!blob)):
>> WARNING: CPU: 0 PID: 0 at security/apparmor/include/cred.h:30 cred_label security/apparmor/include/cred.h:30 [inline]
>> WARNING: CPU: 0 PID: 0 at security/apparmor/include/cred.h:30 apparmor_cred_free+0x12f/0x1a0 security/apparmor/lsm.c:62
>> Kernel panic - not syncing: panic_on_warn set ...
>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.0.0-rc1-next-20190111 #10
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Call Trace:
>>  <IRQ>
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
>>  panic+0x2cb/0x65c kernel/panic.c:214
>>  __warn.cold+0x20/0x48 kernel/panic.c:571
>>  report_bug+0x263/0x2b0 lib/bug.c:186
>>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>>  fixup_bug arch/x86/kernel/traps.c:173 [inline]
>>  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
>>  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
>>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
>> RIP: 0010:cred_label security/apparmor/include/cred.h:30 [inline]
>> RIP: 0010:apparmor_cred_free+0x12f/0x1a0 security/apparmor/lsm.c:62
>> Code: 7c 88 48 c7 c7 00 d0 7c 88 e8 fd 70 f2 fd 0f 0b eb a9 e8 54 3f 29 fe 48 c7 c6 c0 df 7c 88 48 c7 c7 00 d0 7c 88 e8 e1 70 f2 fd <0f> 0b 48 b8 00 00 00 00 00 fc ff df 80 38 00 75 4a 4c 8b 2c 25 00
>> RSP: 0018:ffff8880ae6079f8 EFLAGS: 00010286
>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>> RDX: 0000000000000100 RSI: ffffffff81687fa6 RDI: 0000000000000006
>> RBP: ffff8880ae607a18 R08: ffffffff8987dec0 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880a86b3100
>> R13: ffff8880a86b3100 R14: ffff8880a86b3188 R15: dffffc0000000000
>>  security_cred_free+0x4b/0xf0 security/security.c:1490
> 
> The obvious thing to do is put a check in security_cred_free
> for a NULL cred->security, in which case the LSM hooks
> wouldn't get called.

Right, but the question is should we? To my thinking we shouldn't
ever have a cred without cred->security, unless the cred was
allocated but a later step in its construction, say allocating
->security failed.

In which case I'd rather see the cred directly freed and not
call into security_cred_free() as I like being able to detect
corrupt creds.

We certainly can still do the check for security on only live creds
but I would like to understand this particular failure better first

> It's not clear to me how we got a cred
> that doesn't have an allocated security blob.

I have been trying to figure that one out as well.


> 
>>  put_cred_rcu+0x21f/0x6e0 kernel/cred.c:118
>>  __rcu_reclaim kernel/rcu/rcu.h:240 [inline]
>>  rcu_do_batch kernel/rcu/tree.c:2486 [inline]
>>  invoke_rcu_callbacks kernel/rcu/tree.c:2799 [inline]
>>  rcu_core+0xc4a/0x1680 kernel/rcu/tree.c:2780
>>  __do_softirq+0x30b/0xb11 kernel/softirq.c:292
>>  invoke_softirq kernel/softirq.c:373 [inline]
>>  irq_exit+0x180/0x1d0 kernel/softirq.c:413
>>  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
>>  smp_apic_timer_interrupt+0x1b7/0x760 arch/x86/kernel/apic/apic.c:1062
>>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
>>  </IRQ>
>> RIP: 0010:native_safe_halt+0x2/0x10 arch/x86/include/asm/irqflags.h:58
>> Code: ff ff ff 48 89 c7 48 89 45 d8 e8 79 6f d0 f9 48 8b 45 d8 e9 ce fe ff ff 48 89 df e8 68 6f d0 f9 eb 82 90 90 90 90 90 90 fb f4 <c3> 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 f4 c3 90 90 90 90 90 90
>> RSP: 0018:ffffffff89807c60 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
>> RAX: 1ffffffff1325061 RBX: 1ffffffff1300f8f RCX: 0000000000000000
>> RDX: dffffc0000000000 RSI: 0000000000000001 RDI: ffffffff8987e73c
>> RBP: ffffffff89807d20 R08: ffffffff8987dec0 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>> R13: ffffffff89807cf8 R14: 0000000000000000 R15: ffffffff899282f8
>>  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:555
>>  default_idle_call+0x36/0x90 kernel/sched/idle.c:93
>>  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
>>  do_idle+0x386/0x5d0 kernel/sched/idle.c:262
>>  cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:353
>>  rest_init+0x245/0x37b init/main.c:442
>>  arch_call_rest_init+0xe/0x1b
>>  start_kernel+0x882/0x8bd init/main.c:742
>>  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:470
>>  x86_64_start_kernel+0x77/0x7b arch/x86/kernel/head64.c:451
>>  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
>> Kernel Offset: disabled
>> Rebooting in 86400 seconds..
>>
>>
>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
>> syzbot can test patches for this bug, for details see:
>> https://goo.gl/tpsmEJ#testing-patches
>>

