Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EEEC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBB52086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393551AbfBMR4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:56:14 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:59825 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393537AbfBMR4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:56:07 -0500
Received: by mail-it1-f197.google.com with SMTP id m136so3898321ita.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 09:56:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rw1u1E/Y0WN2t7/1UjBw4YH7Rz4n/OUD0yPyuovl1dQ=;
        b=Zx1gJN9aGP4WbFYxEwFMOg8eaB5hlMB3z6iAW0OBZidQyOp7RXpKm9X0XhsVGC3aZz
         SEDXrYE3TQHDe9oJpFhP/Ds/s25VVIbaIdsHxhmsIOGbRZirDcs051b/8JYJHA/5p2Cu
         Eyqw6yfaQhWUvChPkN7Eddn+TYxd4o97VaUHJ8ySMeYxw7JPYBobq1wRco6EOdkb1p2D
         SSsY+xpv2uW+Lrx932cvPH91ZgudODPj52RONvR+4lH66e6jKTcAeKb/yXZHTfe8zyp6
         tBgXQmdZxqYmyW/+nevSfY7FNMwv4b8Kx3MVEacWsIQKlx3q4g6yNUEBQmUGMMqEWYG2
         5EGg==
X-Gm-Message-State: AHQUAuaCFYfdMOazVyNAy77syBe6kUcSRCBplALkRjIXWgEygnjWNYAp
        cjnyC30ykK4m0IHhN2jFUe9D3xWTJfDZT8F1gHQQJcb/LVgQ
X-Google-Smtp-Source: AHgI3IYA7DXug7n8UUiqKXJcDl2B9/CFmFAol9N7BkAa3X8FWXWvGZWilgVFVOsZsXoT3njymiwI1p72dEmDjOyYF9euptMcXnyD
MIME-Version: 1.0
X-Received: by 2002:a02:a899:: with SMTP id l25mr1111299jam.5.1550080564900;
 Wed, 13 Feb 2019 09:56:04 -0800 (PST)
Date:   Wed, 13 Feb 2019 09:56:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071be120581ca41ed@google.com>
Subject: BUG: soft lockup in kvm_vm_release
From:   syzbot <syzbot+6349a512c2938b2ad058@syzkaller.appspotmail.com>
To:     jpoimboe@redhat.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        peterz@infradead.org, riel@surriel.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    57902dc0670c Merge tag 'riscv-for-linus-5.0-rc7' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=153b7958c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee434566c893c7b1
dashboard link: https://syzkaller.appspot.com/bug?extid=6349a512c2938b2ad058
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14287e78c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6349a512c2938b2ad058@syzkaller.appspotmail.com

kvm: vcpu 0: requested 34784 ns lapic timer period limited to 200000 ns
kvm: vcpu 0: requested 34784 ns lapic timer period limited to 200000 ns
kvm: vcpu 0: requested 34784 ns lapic timer period limited to 200000 ns
kvm: vcpu 0: requested 34784 ns lapic timer period limited to 200000 ns
kvm: vcpu 0: requested 34784 ns lapic timer period limited to 200000 ns
watchdog: BUG: soft lockup - CPU#1 stuck for 123s! [syz-executor.5:21491]
Modules linked in:
irq event stamp: 31290
hardirqs last  enabled at (31289): [<ffffffff81006673>]  
trace_hardirqs_on_thunk+0x1a/0x1c
hardirqs last disabled at (31290): [<ffffffff8100668f>]  
trace_hardirqs_off_thunk+0x1a/0x1c
softirqs last  enabled at (9202): [<ffffffff87400662>]  
__do_softirq+0x662/0x95a kernel/softirq.c:319
softirqs last disabled at (9159): [<ffffffff8144d800>] invoke_softirq  
kernel/softirq.c:373 [inline]
softirqs last disabled at (9159): [<ffffffff8144d800>] irq_exit+0x180/0x1d0  
kernel/softirq.c:413
CPU: 1 PID: 21491 Comm: syz-executor.5 Not tainted 5.0.0-rc6+ #69
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:csd_lock_wait kernel/smp.c:108 [inline]
RIP: 0010:smp_call_function_single+0x13e/0x420 kernel/smp.c:302
Code: 00 48 8b 4c 24 08 48 8b 54 24 10 48 8d 74 24 40 8b 7c 24 1c e8 23 fa  
ff ff 41 89 c5 eb 07 e8 99 7c 0a 00 f3 90 44 8b 64 24 58 <31> ff 41 83 e4  
01 44 89 e6 e8 04 7e 0a 00 45 85 e4 75 e1 e8 7a 7c
RSP: 0018:ffff888070747620 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
RAX: ffff8880770b82c0 RBX: 1ffff1100e0e8ec8 RCX: ffffffff8165649c
RDX: 0000000000000000 RSI: ffffffff81656487 RDI: 0000000000000005
RBP: ffff888070747700 R08: ffff8880770b82c0 R09: ffffed1015d05be9
R10: ffffed1015d05be8 R11: ffff8880ae82df47 R12: 0000000000000003
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
FS:  00007fdaeb8f5700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffda65e1330 CR3: 000000009f959000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  smp_call_function_many+0x750/0x8c0 kernel/smp.c:434
  smp_call_function+0x42/0x90 kernel/smp.c:492
  on_each_cpu+0x31/0x200 kernel/smp.c:602
  text_poke_bp+0x12a/0x19b arch/x86/kernel/alternative.c:826
  __jump_label_transform+0x263/0x330 arch/x86/kernel/jump_label.c:91
  arch_jump_label_transform+0x2b/0x40 arch/x86/kernel/jump_label.c:99
  __jump_label_update+0x16a/0x210 kernel/jump_label.c:389
  jump_label_update kernel/jump_label.c:752 [inline]
  jump_label_update+0x1ce/0x3d0 kernel/jump_label.c:731
  __static_key_slow_dec_cpuslocked+0x61/0x150 kernel/jump_label.c:228
  __static_key_slow_dec kernel/jump_label.c:238 [inline]
  static_key_slow_dec+0x60/0xa0 kernel/jump_label.c:252
  kvm_arch_vcpu_uninit+0x192/0x1d0 arch/x86/kvm/x86.c:9091
  kvm_vcpu_uninit+0x44/0x90 arch/x86/kvm/../../../virt/kvm/kvm_main.c:335
  vmx_free_vcpu+0x1f6/0x340 arch/x86/kvm/vmx/vmx.c:6683
  kvm_arch_vcpu_free arch/x86/kvm/x86.c:8707 [inline]
  kvm_free_vcpus arch/x86/kvm/x86.c:9159 [inline]
  kvm_arch_destroy_vm+0x25f/0x4f0 arch/x86/kvm/x86.c:9256
  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:748 [inline]
  kvm_put_kvm+0x55b/0xc70 arch/x86/kvm/../../../virt/kvm/kvm_main.c:769
  kvm_vm_release+0x44/0x60 arch/x86/kvm/../../../virt/kvm/kvm_main.c:780
  __fput+0x2df/0x8d0 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  get_signal+0x1969/0x1d60 kernel/signal.c:2388
  do_signal+0x87/0x1940 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x244/0x2c0 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ca7
Code: 48 83 c4 08 48 89 d8 5b 5d c3 66 0f 1f 84 00 00 00 00 00 48 89 e8 48  
f7 d8 48 39 c3 0f 92 c0 eb 92 66 90 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fdaeb8f3098 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 0000000000000013 RCX: 0000000000457ca7
RDX: 00007fdaeb8f3510 RSI: 000000004020ae46 RDI: 0000000000000007
RBP: 0000000020ff3000 R08: 00007fdaeb8f30a0 R09: 000000000073bfa0
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000fec00000
R13: 0000000000000007 R14: 00000000004dbaf0 R15: 00000000ffffffff
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.0.0-rc6+ #69
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: rcu_gp process_srcu
RIP: 0010:find_held_lock+0xc/0x130 kernel/locking/lockdep.c:3436
Code: d0 e9 9e fc ff ff 4c 89 f7 48 89 75 d0 e8 3c 5a 50 00 48 8b 75 d0 e9  
15 fd ff ff 0f 1f 00 55 48 89 e5 41 57 44 8d 7a ff 41 56 <49> 89 f6 49 63  
c7 41 55 48 8d 04 80 41 54 4c 8d a4 c7 80 08 00 00
RSP: 0018:ffff8880a98b7b28 EFLAGS: 00000006
RAX: 0000000000000003 RBX: 1ffff11015316f6f RCX: ffff8880a98b7b98
RDX: 0000000000000003 RSI: ffffffff88a41640 RDI: ffff8880a98a8300
RBP: ffff8880a98b7b38 R08: ffff8880a98a8300 R09: 0000000000000003
R10: ffffed1015316f72 R11: 0000000000000003 R12: ffffffff88a41640
R13: ffffffff815d7751 R14: ffffffff8a556aa0 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000018 CR3: 000000009b9db000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __lock_release kernel/locking/lockdep.c:3599 [inline]
  lock_release+0x262/0xa00 kernel/locking/lockdep.c:3860
  __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:166 [inline]
  _raw_spin_unlock_irq+0x1b/0x90 kernel/locking/spinlock.c:192
  spin_unlock_irq include/linux/spinlock.h:379 [inline]
  srcu_reschedule+0xa1/0x130 kernel/rcu/srcutree.c:1246
  process_srcu+0x125/0xec0 kernel/rcu/srcutree.c:1262
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2173
  worker_thread+0x98/0xe40 kernel/workqueue.c:2319
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
