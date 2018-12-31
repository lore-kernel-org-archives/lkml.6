Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31690C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9F821019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeLaPCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 10:02:06 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:51822 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbeLaPCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 10:02:05 -0500
Received: by mail-io1-f72.google.com with SMTP id q207so29470387iod.18
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 07:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lKrWsMQnR9/JFmQJJSFRO4EcWAZz5/k9b3LxItMmKZ4=;
        b=NcLhPAabPs+4lvwAfrmyAqDNii0q/X5u93i3qY9RzTQGtEt8i2q6L1QKl6iF8/G1b5
         l7JlfjhSbf+gfuHnXHPuNUcQqMAfP6/VtFMWAqohzYUHRc5fIkVuzADyjQ4xaqKuT8nQ
         4d//4wa4Ka0Nyo3hs30TzvCuKzg9j84y6+2Q4WPk2/46tvN9KjLP+z6xtphxdP2VFESb
         nMEEQVPpq+PoODF89MmiR8T1W7MXKbyPzxOJyQnVbk7KpF0NB1Ri4dzOEEl0Oijdyh8W
         2Dc/IzEuO6zpc8iflbaeNVAwmQxpVKaCs15DsniSfbuhMSlxuQww7vxXN3iZBYIySrom
         vCsw==
X-Gm-Message-State: AA+aEWbjP7ShoITnr7p5ysrGB9X6FPYakqDF4qhtmGUlXhfKZcVL/+2b
        qOaA+2uylZdvc/W46ojPxCYAcGjg66MtckM2a07bws7C5mjv
X-Google-Smtp-Source: ALg8bN5+HqaevJmDdV+6cSTGbY/pg+cWhKbrBaeGAyWvs5X6vf/4JpGlcdROZPDbiRZGhEIcWAs9AqqCmH1M9zmp0QuRRxUlQNdD
MIME-Version: 1.0
X-Received: by 2002:a05:660c:4e:: with SMTP id p14mr27570744itk.31.1546268524364;
 Mon, 31 Dec 2018 07:02:04 -0800 (PST)
Date:   Mon, 31 Dec 2018 07:02:04 -0800
In-Reply-To: <000000000000b5e346057af4da06@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f4fee057e52b284@google.com>
Subject: Re: WARNING in enqueue_task_dl
From:   syzbot <syzbot+119ba87189432ead09b4@syzkaller.appspotmail.com>
To:     bp@alien8.de, bristot@redhat.com, hpa@zytor.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    195303136f19 Merge tag 'kconfig-v4.21-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118af84b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76d28549be7c27cf
dashboard link: https://syzkaller.appspot.com/bug?extid=119ba87189432ead09b4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10eb7ebf400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14156d77400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+119ba87189432ead09b4@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 9019 at kernel/sched/deadline.c:628  
setup_new_dl_entity kernel/sched/deadline.c:629 [inline]
WARNING: CPU: 0 PID: 9019 at kernel/sched/deadline.c:628 enqueue_dl_entity  
kernel/sched/deadline.c:1429 [inline]
WARNING: CPU: 0 PID: 9019 at kernel/sched/deadline.c:628  
enqueue_task_dl+0x2355/0x3dc0 kernel/sched/deadline.c:1500
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 9019 Comm: syz-executor280 Not tainted 4.20.0+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  panic+0x2cb/0x589 kernel/panic.c:189
  __warn.cold+0x20/0x4b kernel/panic.c:544
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:setup_new_dl_entity kernel/sched/deadline.c:628 [inline]
RIP: 0010:enqueue_dl_entity kernel/sched/deadline.c:1429 [inline]
RIP: 0010:enqueue_task_dl+0x2355/0x3dc0 kernel/sched/deadline.c:1500
Code: 3c 02 00 0f 85 ba 05 00 00 49 8b b5 50 0a 00 00 e9 53 fa ff ff e8 fb  
f2 64 00 48 8d 4d d8 e9 48 dd ff ff 0f 0b e9 92 f1 ff ff <0f> 0b e9 18 f1  
ff ff 4c 89 ef 4c 89 95 28 ff ff ff 4c 89 85 30 ff
RSP: 0018:ffff88809eebfaf8 EFLAGS: 00010002
RAX: 0000000000000002 RBX: 1ffff11013dd7f6a RCX: dffffc0000000000
RDX: 000000333cf09f75 RSI: 0000000000000004 RDI: ffff8880ae62d850
RBP: ffff88809eebfbf8 R08: ffff88807fb0a538 R09: ffff88807fb0a2fc
R10: ffff88807fb0a580 R11: ffff8880ae62dc7b R12: ffff88807fb0a2c0
R13: ffff8880ae62ce00 R14: ffff8880ae62ce00 R15: ffff88807fb0a58c
  enqueue_task+0xb9/0x380 kernel/sched/core.c:730
  __sched_setscheduler+0xe32/0x1fe0 kernel/sched/core.c:4336
  sched_setattr kernel/sched/core.c:4394 [inline]
  __do_sys_sched_setattr kernel/sched/core.c:4570 [inline]
  __se_sys_sched_setattr kernel/sched/core.c:4549 [inline]
  __x64_sys_sched_setattr+0x1af/0x2f0 kernel/sched/core.c:4549
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44c829
Code: e8 8c d8 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb c9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f28685e8ce8 EFLAGS: 00000246 ORIG_RAX: 000000000000013a
RAX: ffffffffffffffda RBX: 00000000006e49f8 RCX: 000000000044c829
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 00000000006e49f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006e49fc
R13: 00007ffd1981c8af R14: 00007f28685e99c0 R15: 0000000000000001

======================================================
WARNING: possible circular locking dependency detected
4.20.0+ #1 Not tainted
------------------------------------------------------
syz-executor280/9019 is trying to acquire lock:
000000001aef527c ((console_sem).lock){-.-.}, at: down_trylock+0x13/0x70  
kernel/locking/semaphore.c:136

but task is already holding lock:
000000000ba17b09 (&rq->lock){-.-.}, at: task_rq_lock+0xc8/0x290  
kernel/sched/core.c:99

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&rq->lock){-.-.}:
        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
        _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
        rq_lock kernel/sched/sched.h:1149 [inline]
        task_fork_fair+0xb5/0x7a0 kernel/sched/fair.c:10083
        sched_fork+0x437/0xb90 kernel/sched/core.c:2359
        copy_process+0x1ff6/0x8730 kernel/fork.c:1893
        _do_fork+0x1a9/0x1170 kernel/fork.c:2222
        kernel_thread+0x34/0x40 kernel/fork.c:2281
        rest_init+0x28/0x37b init/main.c:409
        arch_call_rest_init+0xe/0x1b
        start_kernel+0x882/0x8bd init/main.c:741
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:470
        x86_64_start_kernel+0x77/0x7b arch/x86/kernel/head64.c:451
        secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

-> #1 (&p->pi_lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:152
        try_to_wake_up+0xb9/0x1480 kernel/sched/core.c:1965
        wake_up_process+0x10/0x20 kernel/sched/core.c:2129
        __up.isra.0+0x1c0/0x2a0 kernel/locking/semaphore.c:262
        up+0x13e/0x1c0 kernel/locking/semaphore.c:187
        __up_console_sem+0xb7/0x1c0 kernel/printk/printk.c:236
        console_unlock+0x778/0x11e0 kernel/printk/printk.c:2426
        con_flush_chars drivers/tty/vt/vt.c:3197 [inline]
        con_flush_chars drivers/tty/vt/vt.c:3185 [inline]
        con_write+0xa2/0xb0 drivers/tty/vt/vt.c:3117
        process_output_block drivers/tty/n_tty.c:593 [inline]
        n_tty_write+0x497/0x1220 drivers/tty/n_tty.c:2331
        do_tty_write drivers/tty/tty_io.c:959 [inline]
        tty_write+0x45b/0x7a0 drivers/tty/tty_io.c:1043
        __vfs_write+0x116/0xb40 fs/read_write.c:485
        vfs_write+0x20c/0x580 fs/read_write.c:549
        ksys_write+0x105/0x260 fs/read_write.c:598
        __do_sys_write fs/read_write.c:610 [inline]
        __se_sys_write fs/read_write.c:607 [inline]
        __x64_sys_write+0x73/0xb0 fs/read_write.c:607
        do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 ((console_sem).lock){-.-.}:
        lock_acquire+0x1db/0x570 kernel/locking/lockdep.c:3841
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:152
        down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
        __down_trylock_console_sem+0xa8/0x210 kernel/printk/printk.c:219
        console_trylock+0x15/0xa0 kernel/printk/printk.c:2242
        console_trylock_spinning kernel/printk/printk.c:1662 [inline]
        vprintk_emit+0x351/0x960 kernel/printk/printk.c:1930
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1958
        vprintk_func+0x7e/0x189 kernel/printk/printk_safe.c:398
        printk+0xba/0xed kernel/printk/printk.c:1991
        __warn+0x9e/0x1d0 kernel/panic.c:526
        report_bug+0x263/0x2b0 lib/bug.c:186
        fixup_bug arch/x86/kernel/traps.c:178 [inline]
        fixup_bug arch/x86/kernel/traps.c:173 [inline]
        do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
        do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
        invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
        setup_new_dl_entity kernel/sched/deadline.c:629 [inline]
        enqueue_dl_entity kernel/sched/deadline.c:1429 [inline]
        enqueue_task_dl+0x2355/0x3dc0 kernel/sched/deadline.c:1500
        enqueue_task+0xb9/0x380 kernel/sched/core.c:730
        __sched_setscheduler+0xe32/0x1fe0 kernel/sched/core.c:4336
        sched_setattr kernel/sched/core.c:4394 [inline]
        __do_sys_sched_setattr kernel/sched/core.c:4570 [inline]
        __se_sys_sched_setattr kernel/sched/core.c:4549 [inline]
        __x64_sys_sched_setattr+0x1af/0x2f0 kernel/sched/core.c:4549
        do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   (console_sem).lock --> &p->pi_lock --> &rq->lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&rq->lock);
                                lock(&p->pi_lock);
                                lock(&rq->lock);
   lock((console_sem).lock);

  *** DEADLOCK ***

3 locks held by syz-executor280/9019:
  #0: 0000000014b8e16d (rcu_read_lock){....}, at: __do_sys_sched_setattr  
kernel/sched/core.c:4563 [inline]
  #0: 0000000014b8e16d (rcu_read_lock){....}, at: __se_sys_sched_setattr  
kernel/sched/core.c:4549 [inline]
  #0: 0000000014b8e16d (rcu_read_lock){....}, at:  
__x64_sys_sched_setattr+0x144/0x2f0 kernel/sched/core.c:4549
  #1: 00000000b31ff59d (&p->pi_lock){-.-.}, at: task_rq_lock+0x6a/0x290  
kernel/sched/core.c:97
  #2: 000000000ba17b09 (&rq->lock){-.-.}, at: task_rq_lock+0xc8/0x290  
kernel/sched/core.c:99

stack backtrace:
CPU: 0 PID: 9019 Comm: syz-executor280 Not tainted 4.20.0+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_circular_bug.isra.0.cold+0x1cc/0x28f kernel/locking/lockdep.c:1224
  check_prev_add kernel/locking/lockdep.c:1866 [inline]
  check_prevs_add kernel/locking/lockdep.c:1979 [inline]
  validate_chain kernel/locking/lockdep.c:2350 [inline]
  __lock_acquire+0x3014/0x4a30 kernel/locking/lockdep.c:3338
  lock_acquire+0x1db/0x570 kernel/locking/lockdep.c:3841
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:152
  down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
  __down_trylock_console_sem+0xa8/0x210 kernel/printk/printk.c:219
  console_trylock+0x15/0xa0 kernel/printk/printk.c:2242
  console_trylock_spinning kernel/printk/printk.c:1662 [inline]
  vprintk_emit+0x351/0x960 kernel/printk/printk.c:1930
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1958
  vprintk_func+0x7e/0x189 kernel/printk/printk_safe.c:398
  printk+0xba/0xed kernel/printk/printk.c:1991
  __warn+0x9e/0x1d0 kernel/panic.c:526
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:setup_new_dl_entity kernel/sched/deadline.c:628 [inline]
RIP: 0010:enqueue_dl_entity kernel/sched/deadline.c:1429 [inline]
RIP: 0010:enqueue_task_dl+0x2355/0x3dc0 kernel/sched/deadline.c:1500
Code: 3c 02 00 0f 85 ba 05 00 00 49 8b b5 50 0a 00 00 e9 53 fa ff ff e8 fb  
f2 64 00 48 8d 4d d8 e9 48 dd ff ff 0f 0b e9 92 f1 ff ff <0f> 0b e9 18 f1  
ff ff 4c 89 ef 4c 89 95 28 ff ff ff 4c 89 85 30 ff
RSP: 0018:ffff88809eebfaf8 EFLAGS: 00010002
RAX: 0000000000000002 RBX: 1ffff11013dd7f6a RCX: dffffc0000000000
RDX: 000000333cf09f75 RSI: 0000000000000004 RDI: ffff8880ae62d850
RBP: ffff88809eebfbf8 R08: ffff88807fb0a538 R09: ffff88807fb0a2fc
R10: ffff88807fb0a580 R11: ffff8880ae62dc7b R12: ffff88807fb0a2c0
R13: ffff8880ae62ce00 R14: ffff8880ae62ce00 R15: ffff88807fb0a58c
  enqueue_task+0xb9/0x380 kernel/sched/core.c:730
  __sched_setscheduler+0xe32/0x1fe0 kernel/sched/core.c:4336
  sched_setattr kernel/sched/core.c:4394 [inline]
  __do_sys_sched_setattr kernel/sched/core.c:4570 [inline]
  __se_sys_sched_setattr kernel/sched/core.c:4549 [inline]
  __x64_sys_sched_setattr+0x1af/0x2f0 kernel/sched/core.c:4549
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44c829
Code: e8 8c d8 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb c9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f28685e8ce8 EFLAGS: 00000246 ORIG_RAX: 000000000000013a
RAX: ffffffffffffffda RBX: 00000000006e49f8 RCX: 000000000044c829
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 00000000006e49f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006e49fc
R13: 00007ffd1981c8af R14: 00007f28685e99c0 R15: 0000000000000001
Shutting down cpus with NMI
Kernel Offset: disabled
Rebooting in 86400 seconds..

