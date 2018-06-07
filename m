Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id s/mpA7m3GFt+cgAAmS7hNA
	; Thu, 07 Jun 2018 04:44:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 58B82607F7; Thu,  7 Jun 2018 04:44:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,FROM_LOCAL_HEX,
	MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DDCD6601C3;
	Thu,  7 Jun 2018 04:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DDCD6601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbeFGEoE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 00:44:04 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:36370 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbeFGEoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 00:44:03 -0400
Received: by mail-io0-f198.google.com with SMTP id j26-v6so6555603ioa.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 21:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Mt8w1z138/NfZuF6ZluqxASHQKtRT3jkZroeaFOSmR8=;
        b=dKbQfQ/QFFqfRxuJinR4c6C2EmiGHrOi8yVjit0oI98jBPlaf4N5W52wOqpH16EpaA
         INLjrQYMi4OaRtu8R4IwenigoMmz1UN9fr03hCHJYkdMIXO1E9lfEcJ/GRRZTCUNTPnU
         QgD6jPGzrA0Z2cEgj2uLynaZbzRQZ0ralG8Z21xfi265ShqdvymCmqzYyZFWZawYz+0W
         pdSKcfh0WI/eG4ZP9UKQhyg5ads4hwDJCHod7vMXz3n24VeVjPALFBdNRkwz92dfKhib
         lDHSOUn8g3IZ7baX8sMOd14254XUQRw8PnImefmfqfcmFtgYzFYfJJvg4TGawPIbpybr
         L6Kw==
X-Gm-Message-State: APt69E3ACPlL9JvLhbHOUVlmy47ahD47jr8Z2HM9tNcmlYAXWd4bOj3I
        CBil94YuMcS7Q2ronvW4my073FAa4VCPcH3wIyi5OzZyjx5c
X-Google-Smtp-Source: ADUXVKLPRiXc4ymJJg98tme015nLAi46sNTrg/cQdQ/kBC/HRNeYpBAvnWcajE+jX5+ZwDeq4gc+DWpGj9DLk9o9aiMa6RZLtpL2
MIME-Version: 1.0
X-Received: by 2002:a6b:f119:: with SMTP id e25-v6mr143930iog.50.1528346642546;
 Wed, 06 Jun 2018 21:44:02 -0700 (PDT)
Date: Wed, 06 Jun 2018 21:44:02 -0700
In-Reply-To: <00000000000087008b056df8fbb3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b914a7056e05ee8a@google.com>
Subject: Re: possible deadlock in console_unlock
From: syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    0ad39cb3d70f Merge tag 'kconfig-v4.18' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1158868f800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9a1f3aa8b8ddd16
dashboard link: https://syzkaller.appspot.com/bug?extid=43e93968b964e369db0b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=14c89b9f800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167f596f800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3350380d80 R14: 0000000000000004 R15: 6d74702f7665642f
CPU: 1 PID: 4456 Comm: syz-executor589 Not tainted 4.17.0+ #87

======================================================
WARNING: possible circular locking dependency detected
4.17.0+ #87 Not tainted
------------------------------------------------------
syz-executor589/4455 is trying to acquire lock:
         (ptrval) (console_owner){-...}, at: log_next  
kernel/printk/printk.c:496 [inline]
         (ptrval) (console_owner){-...}, at: console_unlock+0x583/0x1100  
kernel/printk/printk.c:2382

but task is already holding lock:
         (ptrval) (&(&port->lock)->rlock){-.-.}, at: pty_write+0xf9/0x1f0  
drivers/tty/pty.c:119

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&(&port->lock)->rlock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        tty_port_tty_get+0x20/0x80 drivers/tty/tty_port.c:288
        tty_port_default_wakeup+0x15/0x40 drivers/tty/tty_port.c:47
        tty_port_tty_wakeup+0x5d/0x70 drivers/tty/tty_port.c:390
        uart_write_wakeup+0x44/0x60 drivers/tty/serial/serial_core.c:103
        serial8250_tx_chars+0x4be/0xb60  
drivers/tty/serial/8250/8250_port.c:1808
        serial8250_handle_irq.part.25+0x1ee/0x280  
drivers/tty/serial/8250/8250_port.c:1881
        serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1867  
[inline]
        serial8250_default_handle_irq+0xc8/0x150  
drivers/tty/serial/8250/8250_port.c:1897
        serial8250_interrupt+0xfa/0x1d0  
drivers/tty/serial/8250/8250_core.c:125
        __handle_irq_event_percpu+0x1c0/0xad0 kernel/irq/handle.c:149
        handle_irq_event_percpu+0x98/0x1c0 kernel/irq/handle.c:189
        handle_irq_event+0xa7/0x135 kernel/irq/handle.c:206
        handle_edge_irq+0x20f/0x870 kernel/irq/chip.c:791
        generic_handle_irq_desc include/linux/irqdesc.h:159 [inline]
        handle_irq+0x18c/0x2e7 arch/x86/kernel/irq_64.c:77
        do_IRQ+0x78/0x190 arch/x86/kernel/irq.c:245
        ret_from_intr+0x0/0x1e
        arch_local_irq_restore arch/x86/include/asm/paravirt.h:783 [inline]
        __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160  
[inline]
        _raw_spin_unlock_irqrestore+0xa1/0xc0 kernel/locking/spinlock.c:184
        spin_unlock_irqrestore include/linux/spinlock.h:365 [inline]
        uart_write+0x3df/0x620 drivers/tty/serial/serial_core.c:591
        process_output_block drivers/tty/n_tty.c:579 [inline]
        n_tty_write+0x6b9/0x1180 drivers/tty/n_tty.c:2308
        do_tty_write drivers/tty/tty_io.c:958 [inline]
        tty_write+0x3f1/0x880 drivers/tty/tty_io.c:1042
        redirected_tty_write+0xaf/0xc0 drivers/tty/tty_io.c:1063
        __vfs_write+0x10b/0x960 fs/read_write.c:485
        vfs_write+0x1f8/0x560 fs/read_write.c:549
        ksys_write+0xf9/0x250 fs/read_write.c:598
        __do_sys_write fs/read_write.c:610 [inline]
        __se_sys_write fs/read_write.c:607 [inline]
        __x64_sys_write+0x73/0xb0 fs/read_write.c:607
        do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&port_lock_key){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        serial8250_console_write+0x8d5/0xb00  
drivers/tty/serial/8250/8250_port.c:3230
        univ8250_console_write+0x5f/0x70  
drivers/tty/serial/8250/8250_core.c:590
        call_console_drivers kernel/printk/printk.c:1718 [inline]
        console_unlock+0xac2/0x1100 kernel/printk/printk.c:2395
        vprintk_emit+0x6ad/0xdd0 kernel/printk/printk.c:1907
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1947
        vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:379
        printk+0x9e/0xba kernel/printk/printk.c:1980
        register_console+0x7e7/0xc00 kernel/printk/printk.c:2714
        univ8250_console_init+0x3f/0x4b  
drivers/tty/serial/8250/8250_core.c:685
        console_init+0x6d9/0xa38 kernel/printk/printk.c:2798
        start_kernel+0x608/0x92d init/main.c:661
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242

-> #0 (console_owner){-...}:
        lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3924
        console_lock_spinning_enable kernel/printk/printk.c:1581 [inline]
        console_unlock+0x5ef/0x1100 kernel/printk/printk.c:2392
        vprintk_emit+0x6ad/0xdd0 kernel/printk/printk.c:1907
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1947
        vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:379
        printk+0x9e/0xba kernel/printk/printk.c:1980
        fail_dump lib/fault-inject.c:44 [inline]
        should_fail+0x97a/0xbcd lib/fault-inject.c:149
        __should_failslab+0x124/0x180 mm/failslab.c:32
        should_failslab+0x9/0x14 mm/slab_common.c:1522
        slab_pre_alloc_hook mm/slab.h:423 [inline]
        slab_alloc mm/slab.c:3378 [inline]
        __do_kmalloc mm/slab.c:3716 [inline]
        __kmalloc+0x63/0x760 mm/slab.c:3727
        kmalloc include/linux/slab.h:517 [inline]
        tty_buffer_alloc drivers/tty/tty_buffer.c:170 [inline]
        __tty_buffer_request_room+0x2d2/0x7f0 drivers/tty/tty_buffer.c:268
        tty_insert_flip_string_fixed_flag+0x8d/0x1f0  
drivers/tty/tty_buffer.c:313
        tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
        pty_write+0x12c/0x1f0 drivers/tty/pty.c:121
        n_tty_write+0xc41/0x1180 drivers/tty/n_tty.c:2331
        do_tty_write drivers/tty/tty_io.c:958 [inline]
        tty_write+0x3f1/0x880 drivers/tty/tty_io.c:1042
        do_loop_readv_writev fs/read_write.c:703 [inline]
        do_iter_write+0x491/0x5f0 fs/read_write.c:961
        vfs_writev+0x1c7/0x330 fs/read_write.c:1004
        do_writev+0x112/0x2f0 fs/read_write.c:1039
        __do_sys_writev fs/read_write.c:1112 [inline]
        __se_sys_writev fs/read_write.c:1109 [inline]
        __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
        do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   console_owner --> &port_lock_key --> &(&port->lock)->rlock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&(&port->lock)->rlock);
                                lock(&port_lock_key);
                                lock(&(&port->lock)->rlock);
   lock(console_owner);

  *** DEADLOCK ***

6 locks held by syz-executor589/4455:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&tty->atomic_write_lock){+.+.}, at:  
tty_write_lock+0x57/0x90 drivers/tty/tty_io.c:887
  #2:         (ptrval) (&tty->termios_rwsem){++++}, at:  
n_tty_write+0x25a/0x1180 drivers/tty/n_tty.c:2291
  #3:         (ptrval) (&ldata->output_lock){+.+.}, at:  
n_tty_write+0xc05/0x1180 drivers/tty/n_tty.c:2330
  #4:         (ptrval) (&(&port->lock)->rlock){-.-.}, at:  
pty_write+0xf9/0x1f0 drivers/tty/pty.c:119
  #5:         (ptrval) (console_lock){+.+.}, at: console_trylock_spinning  
kernel/printk/printk.c:1643 [inline]
  #5:         (ptrval) (console_lock){+.+.}, at: vprintk_emit+0x694/0xdd0  
kernel/printk/printk.c:1906

stack backtrace:
CPU: 0 PID: 4455 Comm: syz-executor589 Not tainted 4.17.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_circular_bug.isra.36.cold.56+0x1bd/0x27d  
kernel/locking/lockdep.c:1227
  check_prev_add kernel/locking/lockdep.c:1867 [inline]
  check_prevs_add kernel/locking/lockdep.c:1980 [inline]
  validate_chain kernel/locking/lockdep.c:2421 [inline]
  __lock_acquire+0x343e/0x5140 kernel/locking/lockdep.c:3435
  lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3924
  console_lock_spinning_enable kernel/printk/printk.c:1581 [inline]
  console_unlock+0x5ef/0x1100 kernel/printk/printk.c:2392
  vprintk_emit+0x6ad/0xdd0 kernel/printk/printk.c:1907
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1947
  vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:379
  printk+0x9e/0xba kernel/printk/printk.c:1980
  fail_dump lib/fault-inject.c:44 [inline]
  should_fail+0x97a/0xbcd lib/fault-inject.c:149
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1522
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x63/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:517 [inline]
  tty_buffer_alloc drivers/tty/tty_buffer.c:170 [inline]
  __tty_buffer_request_room+0x2d2/0x7f0 drivers/tty/tty_buffer.c:268
  tty_insert_flip_string_fixed_flag+0x8d/0x1f0 drivers/tty/tty_buffer.c:313
  tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
  pty_write+0x12c/0x1f0 drivers/tty/pty.c:121
  n_tty_write+0xc41/0x1180 drivers/tty/n_tty.c:2331
  do_tty_write drivers/tty/tty_io.c:958 [inline]
  tty_write+0x3f1/0x880 drivers/tty/tty_io.c:1042
  do_loop_readv_writev fs/read_write.c:703 [inline]
  do_iter_write+0x491/0x5f0 fs/read_write.c:961
  vfs_writev+0x1c7/0x330 fs/read_write.c:1004
  do_writev+0x112/0x2f0 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445959
Code: e8 9c bc 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 8b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f3350380d78 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000006dbc3c RCX: 0000000000445959
RDX: 0000000000000001 RSI: 0000000020000600 RDI: 0000000000000003
RBP: 00000000006dbc38 R08: 0000000000000001 R09: 0000000000000031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3350380d80 R14: 0000000000000004 R15: 6d74702f7665642f
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1522
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x63/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:517 [inline]
  tty_buffer_alloc drivers/tty/tty_buffer.c:170 [inline]
  __tty_buffer_request_room+0x2d2/0x7f0 drivers/tty/tty_buffer.c:268
  tty_insert_flip_string_fixed_flag+0x8d/0x1f0 drivers/tty/tty_buffer.c:313
  tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
  pty_write+0x12c/0x1f0 drivers/tty/pty.c:121
  n_tty_write+0xc41/0x1180 drivers/tty/n_tty.c:2331
  do_tty_write drivers/tty/tty_io.c:958 [inline]
  tty_write+0x3f1/0x880 drivers/tty/tty_io.c:1042
  do_loop_readv_writev fs/read_write.c:703 [inline]
  do_iter_write+0x491/0x5f0 fs/read_write.c:961
  vfs_writev+0x1c7/0x330 fs/read_write.c:1004
  do_writev+0x112/0x2f0 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445959
Code: e8 9c bc 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 8b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f335035fd78 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000006dbc54 RCX: 0000000000445959
RDX: 0000000000000001 RSI: 0000000020000600 RDI: 0000000000000005
RBP: 00000000006dbc50 R08: 0000000000000001 R09: 0000000000000031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f335035fd80 R14: 0000000000000006 R15: 6d74702f7665642f
CPU: 0 PID: 4457 Comm: syz-executor589 Not tainted 4.17.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1522
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x63/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:517 [inline]
  tty_buffer_alloc drivers/tty/tty_buffer.c:170 [inline]
  __tty_buffer_request_room+0x2d2/0x7f0 drivers/tty/tty_buffer.c:268
  tty_insert_flip_string_fixed_flag+0x8d/0x1f0 drivers/tty/tty_buffer.c:313
  tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
  pty_write+0x12c/0x1f0 drivers/tty/pty.c:121
  n_tty_write+0xc41/0x1180 drivers/tty/n_tty.c:2331
  do_tty_write drivers/tty/tty_io.c:958 [inline]
  tty_write+0x3f1/0x880 drivers/tty/tty_io.c:1042
  do_loop_readv_writev fs/read_write.c:703 [inline]
  do_iter_write+0x491/0x5f0 fs/read_write.c:961
  vfs_writev+0x1c7/0x330 fs/read_write.c:1004
  do_writev+0x112/0x2f0 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445959
Code: e8 9c bc 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 8b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f335033ed78 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000006dbc6c RCX: 0000000000445959
RDX: 0000000000000001 RSI: 0000000020000600 RDI: 0000000000000007
RBP: 00000000006dbc68 R08: 0000000000000001 R09: 0000000000000031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f335033ed80 R14: 0000000000000008 R15: 6d74702f7665642f
CPU: 1 PID: 4458 Comm: syz-executor589 Not tainted 4.17.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1522
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x63/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:517 [inline]
  tty_buffer_alloc drivers/tty/tty_buffer.c:170 [inline]
  __tty_buffer_request_room+0x2d2/0x7f0 drivers/tty/tty_buffer.c:268
  tty_insert_flip_string_fixed_flag+0x8d/0x1f0 drivers/tty/tty_buffer.c:313
  tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
  pty_write+0x12c/0x1f0 drivers/tty/pty.c:121
  n_tty_write+0xc41/0x1180 drivers/tty/n_tty.c:2331
  do_tty_write drivers/tty/tty_io.c:958 [inline]
  tty_write+0x3f1/0x880 drivers/tty/tty_io.c:1042
  do_loop_readv_writev fs/read_write.c:703 [inline]
  do_iter_write+0x491/0x5f0 fs/read_write.c:961
  vfs_writev+0x1c7/0x330 fs/read_write.c:1004
  do_writev+0x112/0x2f0 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445959
Code: e8 9c bc 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 8b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f335031dd78 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000006dbc84 RCX: 0000000000445959
RDX: 0000000000000001 RSI: 0000000020000600 RDI: 0000000000000009
RBP: 00000000006dbc80 R08: 0000000000000001 R09: 0000000000000031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f335031dd80 R14: 000000000000000a R15: 6d74702f7665642f
CPU: 0 PID: 4459 Comm: syz-executor589 Not tainted 4.17.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1522
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x63/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:517 [inline]
  tty_buffer_alloc drivers/tty/tty_buffer.c:170 [inline]
  __tty_buffer_request_room+0x2d2/0x7f0 drivers/tty/tty_buffer.c:268
  tty_insert_flip_string_fixed_flag+0x8d/0x1f0 drivers/tty/tty_buffer.c:313
  tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
  pty_write+0x12c/0x1f0 drivers/tty/pty.c:121
  n_tty_write+0xc41/0x1180 drivers/tty/n_tty.c:2331
  do_tty_write drivers/tty/tty_io.c:958 [inline]
  tty_write+0x3f1/0x880 drivers/tty/tty_io.c:1042
  do_loop_readv_writev fs/read_write.c:703 [inline]
  do_iter_write+0x491/0x5f0 fs/read_write.c:961
  vfs_writev+0x1c7/0x330 fs/read_write.c:1004
  do_writev+0x112/0x2f0 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445959
Code: e8 9c bc 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 8b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f33502fcd78 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000006dbc9c RCX: 0000000000445959
RDX: 0000000000000001 RSI: 0000000020000600 RDI: 000000000000000b
RBP: 00000000006dbc98 R08: 0000000000000001 R09: 0000000000000031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f33502fcd80 R14: 000000000000000c R15: 6d74702f7665642f
CPU: 1 PID: 4460 Comm: syz-executor589 Not tainted 4.17.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1522
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x63/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:517 [inline]
  tty_buffer_alloc drivers/tty/tty_buffer.c:170 [inline]
  __tty_buffer_request_room+0x2d2/0x7f0 drivers/tty/tty_buffer.c:268
  tty_insert_flip_string_fixed_flag+0x8d/0x1f0 drivers/tty/tty_buffer.c:313
  tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
  pty_write+0x12c/0x1f0 drivers/tty/pty.c:121
  n_tty_write+0xc41/0x1180 drivers/tty/n_tty.c:2331
  do_tty_write drivers/tty/tty_io.c:958 [inline]
  tty_write+0x3f1/0x880 drivers/tty/tty_io.c:1042
  do_loop_readv_writev fs/read_write.c:703 [inline]
  do_iter_write+0x491/0x5f0 fs/read_write.c:961
  vfs_writev+0x1c7/0x330 fs/read_write.c:1004
  do_writev+0x112/0x2f0 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445959
Code: e8 9c bc 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 8b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f33502dbd78 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000006dbcb4 RCX: 0000000000445959
RDX: 0000000000000001 RSI: 0000000020000600 RDI: 000000000000000d
RBP: 00000000006dbcb0 R08: 0000000000000001 R09: 0000000000000031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f33502dbd80 R14: 000000000000000e R15: 6d74702f7665642f
CPU: 0 PID: 4461 Comm: syz-executor589 Not tainted 4.17.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1522
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x63/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:517 [inline]
  tty_buffer_alloc drivers/tty/tty_buffer.c:170 [inline]
  __tty_buffer_request_room+0x2d2/0x7f0 drivers/tty/tty_buffer.c:268
  tty_insert_flip_string_fixed_flag+0x8d/0x1f0 drivers/tty/tty_buffer.c:313
  tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
  pty_write+0x12c/0x1f0 drivers/tty/pty.c:121
  n_tty_write+0xc41/0x1180 drivers/tty/n_tty.c:2331
  do_tty_write drivers/tty/tty_io.c:958 [inline]
  tty_write+0x3f1/0x880 drivers/tty/tty_io.c:1042
  do_loop_readv_writev fs/read_write.c:703 [inline]
  do_iter_write+0x491/0x5f0 fs/read_write.c:961
  vfs_writev+0x1c7/0x330 fs/read_write.c:1004
  do_writev+0x112/0x2f0 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445959
Code: e8 9c bc 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 8b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f33502bad78 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000006dbccc RCX: 0000000000445959
RDX: 0000000000000001 RSI: 0000000020000600 RDI: 000000000000000f
RBP: 00000000006dbcc8 R08: 0000000000000001 R09: 0000000000000031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f33502bad80 R14: 0000000000000010 R15: 6d74702f7665642f
CPU: 1 PID: 4462 Comm: syz-executor589 Not tainted 4.17.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1522
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x63/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:517 [inline]
  tty_buffer_alloc drivers/tty/tty_buffer.c:170 [inline]
  __tty_buffer_request_room+0x2d2/0x7f0 drivers/tty/tty_buffer.c:268
  tty_insert_flip_string_fixed_flag+0x8d/0x1f0 drivers/tty/tty_buffer.c:313
  tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
  pty_write+0x12c/0x1f0 drivers/tty/pty.c:121
  n_tty_write+0xc41/0x1180 drivers/tty/n_tty.c:2331
  do_tty_write drivers/tty/tty_io.c:958 [inline]
  tty_write+0x3f1/0x880 drivers/tty/tty_io.c:1042
  do_loop_readv_writev fs/read_write.c:703 [inline]
  do_iter_write+0x491/0x5f0 fs/read_write.c:961
  vfs_writev+0x1c7/0x330 fs/read_write.c:1004
  do_writev+0x112/0x2f0 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445959
Code: e8 9c bc 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 8b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f3350299d78 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000006dbce4 RCX: 0000000000445959
RDX: 0000000000000001 RSI: 0000000020000600 RDI: 0000000000000011
RBP: 00000000006dbce0 R08: 0000000000000001 R09: 0000000000000031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3350299d80 R14: 0000000000000012 R15: 6d74702f7665642f
CPU: 0 PID: 4463 Comm: syz-executor589 Not tainted 4.17.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1522
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x63/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:517 [inline]
  tty_buffer_alloc drivers/tty/tty_buffer.c:170 [inline]
  __tty_buffer_request_room+0x2d2/0x7f0 drivers/tty/tty_buffer.c:268
  tty_insert_flip_string_fixed_flag+0x8d/0x1f0 drivers/tty/tty_buffer.c:313
  tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
  pty_write+0x12c/0x1f0 drivers/tty/pty.c:121
  n_tty_write+0xc41/0x1180 drivers/tty/n_tty.c:2331
  do_tty_write drivers/tty/tty_io.c:958 [inline]
  tty_write+0x3f1/0x880 drivers/tty/tty_io.c:1042
  do_loop_readv_writev fs/read_write.c:703 [inline]
  do_iter_write+0x491/0x5f0 fs/read_write.c:961
  vfs_writev+0x1c7/0x330 fs/read_write.c:1004
  do_writev+0x112/0x2f0 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445959
Code: e8 9c bc 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 8b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f3350278d78 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000006dbcfc RCX: 0000000000445959
RDX: 0000000000000001 RSI: 0000000020000600 RDI: 0000000000000013
RBP: 00000000006dbcf8 R08: 0000000000000001 R09: 0000000000000031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3350278d80 R14: 0000000000000014 R15: 6d74702f7665642f
CPU: 1 PID: 4464 Comm: syz-executor589 Not tainted 4.17.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1522
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x63/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:517 [inline]
  tty_buffer_alloc drivers/tty/tty_buffer.c:170 [inline]
  __tty_buffer_request_room+0x2d2/0x7f0 drivers/tty/tty_buffer.c:268
  tty_insert_flip_string_fixed_flag+0x8d/0x1f0 drivers/tty/tty_buffer.c:313
  tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
  pty_write+0x12c/0x1f0 drivers/tty/pty.c:121
  n_tty_write+0xc41/0x1180 drivers/tty/n_tty.c:2331
  do_tty_write drivers/tty/tty_io.c:958 [inline]
  tty_write+0x3f1/0x880 drivers/tty/tty_io.c:1042
  do_loop_readv_writev fs/read_write.c:703 [inline]
  do_iter_write+0x491/0x5f0 fs/read_write.c:961
  vfs_writev+0x1c7/0x330 fs/read_write.c:1004
  do_writev+0x112/0x2f0 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445959
Code: e8 9c bc 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 8b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f3350257d78 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000006dbd14 RCX: 0000000000445959
RDX: 0000000000000001 RSI: 0000000020000600 RDI: 0000000000000015
RBP: 00000000006dbd10 R08: 0000000000000001 R09: 0000000000000031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3350257d80 R14: 0000000000000016 R15: 6d74702f7665642f
CPU: 0 PID: 4465 Comm: syz-executor589 Not tainted 4.17.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1522
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x63/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:517 [inline]
  tty_buffer_alloc drivers/tty/tty_buffer.c:170 [inline]
  __tty_buffer_request_room+0x2d2/0x7f0 drivers/tty/tty_buffer.c:268
  tty_insert_flip_string_fixed_flag+0x8d/0x1f0 drivers/tty/tty_buffer.c:313
  tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
  pty_write+0x12c/0x1f0 drivers/tty/pty.c:121
  n_tty_write+0xc41/0x1180 drivers/tty/n_tty.c:2331
  do_tty_write drivers/tty/tty_io.c:958 [inline]
  tty_write+0x3f1/0x880 drivers/tty/tty_io.c:1042
  do_loop_readv_writev fs/read_write.c:703 [inline]
  do_iter_write+0x491/0x5f0 fs/read_write.c:961
  vfs_writev+0x1c7/0x330 fs/read_write.c:1004
  do_writev+0x112/0x2f0 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445959
Code: e8 9c bc 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 8b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f3350236d78 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000006dbd2c RCX: 0000000000445959
RDX: 0000000000000001 RSI: 0000000020000600 RDI: 0000000000000017
RBP: 00000000006dbd28 R08: 0000000000000001 R09: 0000000000000031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3350236d80 R14: 0000000000000018 R15: 6d74702f7665642f
CPU: 1 PID: 4466 Comm: syz-executor589 Not tainted 4.17.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1522
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x63/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:517 [inline]
  tty_buffer_alloc drivers/tty/tty_buffer.c:170 [inline]
  __tty_buffer_request_room+0x2d2/0x7f0 drivers/tty/tty_buffer.c:268
  tty_insert_flip_string_fixed_flag+0x8d/0x1f0 drivers/tty/tty_buffer.c:313
  tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
  pty_write+0x12c/0x1f0 drivers/tty/pty.c:121
  n_tty_write+0xc41/0x1180 drivers/tty/n_tty.c:2331
  do_tty_write drivers/tty/tty_io.c:958 [inline]
  tty_write+0x3f1/0x880 drivers/tty/tty_io.c:1042
  do_loop_readv_writev fs/read_write.c:703 [inline]
  do_iter_write+0x491/0x5f0 fs/read_write.c:961
  vfs_writev+0x1c7/0x330 fs/read_write.c:1004
  do_writev+0x112/0x2f0 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445959
Code: e8 9c bc 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 8b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f3350215d78 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000006dbd44 RCX: 0000000000445959
RDX: 0000000000000001 RSI: 0000000020000600 RDI: 0000000000000019
RBP: 00000000006dbd40 R08: 0000000000000001 R09: 0000000000000031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3350215d80 R14: 000000000000001a R15: 6d74702f7665642f
CPU: 0 PID: 4467 Comm: syz-executor589 Not tainted 4.17.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1522
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x63/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:517 [inline]
  tty_buffer_alloc drivers/tty/tty_buffer.c:170 [inline]
  __tty_buffer_request_room+0x2d2/0x7f0 drivers/tty/tty_buffer.c:268
  tty_insert_flip_string_fixed_flag+0x8d/0x1f0 drivers/tty/tty_buffer.c:313
  tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
  pty_write+0x12c/0x1f0 drivers/tty/pty.c:121
  n_tty_write+0xc41/0x1180 drivers/tty/n_tty.c:2331
  do_tty_write drivers/tty/tty_io.c:958 [inline]
  tty_write+0x3f1/0x880 drivers/tty/tty_io.c:1042
  do_loop_readv_writev fs/read_write.c:703 [inline]
  do_iter_write+0x491/0x5f0 fs/read_write.c:961
  vfs_writev+0x1c7/0x330 fs/read_write.c:1004
  do_writev+0x112/0x2f0 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445959
Code: e8 9c bc 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 8b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f33501f4d78 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000006dbd5c RCX: 0000000000445959
RDX: 0000000000000001 RSI: 0000000020000600 RDI: 000000000000001b
RBP: 00000000006dbd58 R08: 0000000000000001 R09: 0000000000000031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f33501f4d80 R14: 000000000000001c R15: 6d74702f7665642f
CPU: 1 PID: 4468 Comm: syz-executor589 Not tainted 4.17.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1522
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x63/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:517 [inline]
  tty_buffer_alloc drivers/tty/tty_buffer.c:170 [inline]
  __tty_buffer_request_room+0x2d2/0x7f0 drivers/tty/tty_buffer.c:268
  tty_insert_flip_string_fixed_flag+0x8d/0x1f0 drivers/tty/tty_buffer.c:313
  tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
  pty_write+0x12c/0x1f0 drivers/tty/pty.c:121
  n_tty_write+0xc41/0x1180 drivers/tty/n_tty.c:2331
  do_tty_write drivers/tty/tty_io.c:958 [inline]
  tty_write+0x3f1/0x880 drivers/tty/tty_io.c:1042
  do_loop_readv_writev fs/read_write.c:703 [inline]
  do_iter_write+0x491/0x5f0 fs/read_write.c:961
  vfs_writev+0x1c7/0x330 fs/read_write.c:1004
  do_writev+0x112/0x2f0 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445959
Code: e8 9c bc 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 8b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f33501d3d78 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000006dbd74 RCX: 0000000000445959
RDX: 0000000000000001 RSI: 0000000020000600 RDI: 000000000000001d
RBP: 00000000006dbd70 R08: 0000000000000001 R09: 0000000000000031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f33501d3d80 R14: 000000000000001e R15: 6d74702f7665642f
random: crng init done
