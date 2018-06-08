Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id yAs+Ok41Glu8aAAAmS7hNA
	; Fri, 08 Jun 2018 07:50:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D2FA3607E4; Fri,  8 Jun 2018 07:50:38 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DCjDJ0kf"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7E681606FA;
	Fri,  8 Jun 2018 07:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E681606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeFHHue (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 03:50:34 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46594 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbeFHHud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 03:50:33 -0400
Received: by mail-pl0-f67.google.com with SMTP id 30-v6so7798751pld.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 00:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CoUJWZW/9PwdmKE9CEB9FSWHZ0HlVtNCJ9RaSsRgoIc=;
        b=DCjDJ0kfE97AFWhsSaK1Q7LPjXm7SO0B7SUcE1ApYLJfQT3+z09BfreiA5t3ENTVVI
         H39rDjL7OyMVtb8rGGW/vsxRE34IwYnjsdwc1kPNXusxtL9M4+TufcpReFpE+cwom5Er
         hdG4zdePL294uYegkEbPOUYzYYf26xYmrYqt/Dco+y1wWk2eBF6YUNGBkL8GxPrRxGxS
         dDII0Rn8qDPHpJWCYMjIOSEEUAXMtzcVGObRKzhw7nYewD80+l7olm7buFjBc2pvxpix
         CZYdXpDF67aurQFkfQerjHRcou5RZpRCTap99vefCObtU1lDsEFvGB2vUx13UBjoCsDc
         ZJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CoUJWZW/9PwdmKE9CEB9FSWHZ0HlVtNCJ9RaSsRgoIc=;
        b=ZMn0Vx4vKs6jKScQL+6dbVp/RqGVjQtbzm96ctdi/3ubcll/b+BoburJ0HkhgYWjse
         g/S7h+2de0KzeAyGfAe4CPFk+uX0H+Fuk9axagEapHQpbUftdmyGRusW3HNy7x2lEUR6
         6F99wsV05V1kTbM9rk2W1G1iRLD8fLDuBqB50HTeSGj92MTLIY47KuhjJQv+/0go6rS7
         k4H8PVKaHDiSr1Zyvqh+Trrxsogs4vT+X9x3Z2TtfN3/01nyR/rWK8qAizYFyBemuH9a
         UmxHJeiJtHF2X5X1Bp4CWauaeLYOArZ61X+1+p4AeNm+xtFTpmwI0Oq8j0fumVh8mZZs
         lSIA==
X-Gm-Message-State: APt69E1ZxeiUg2cQJDBQ9rQrdd3gAdUfHZGEHlw5xLP8gUP0s8j7djhN
        ZaHlP/YWGh40fNDGT8Ag/4M+o+EZs0gNA0QHLawHv8Gish0=
X-Google-Smtp-Source: ADUXVKLvZ1sIjvGSLp9kDLKn6teoBredWOsoj6sLKZTJQi1izaoKqF3X5BiEZivGszV0judcnmXzNezTr8kv6ZFHlkY=
X-Received: by 2002:a17:902:264:: with SMTP id 91-v6mr5392580plc.341.1528444232365;
 Fri, 08 Jun 2018 00:50:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Fri, 8 Jun 2018 00:50:11
 -0700 (PDT)
In-Reply-To: <000000000000d557e7056e1c7a01@google.com>
References: <000000000000d557e7056e1c7a01@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 8 Jun 2018 09:50:11 +0200
Message-ID: <CACT4Y+aPPuC+VopRpfJj41TBiN5ke-gVdQCBvD5ohxsXmz=hbA@mail.gmail.com>
Subject: Re: possible deadlock in vprintk_emit
To: syzbot <syzbot+831ee52a258e90882b4d@syzkaller.appspotmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 9:38 AM, syzbot
<syzbot+831ee52a258e90882b4d@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    1c8c5a9d38f6 Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=131d4ddf800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4f1acdf888c9d4e9
> dashboard link: https://syzkaller.appspot.com/bug?extid=831ee52a258e90882b4d
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+831ee52a258e90882b4d@syzkaller.appspotmail.com


This is the same as that one, right?

#syz dup: possible deadlock in console_unlock

https://syzkaller.appspot.com/bug?id=39ea6caa479af471183997376dc7e90bc7d64a6a



> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000016
> R13: 00000000004be500 R14: 00000000004ccad8 R15: 0000000000000000
> CPU: 0 PID: 19202 Comm: syz-executor2 Not tainted 4.17.0+ #89
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 4.17.0+ #89 Not tainted
> ------------------------------------------------------
> syz-executor6/19187 is trying to acquire lock:
> 000000006e810651 (console_owner){-.-.}, at: console_trylock_spinning
> kernel/printk/printk.c:1651 [inline]
> 000000006e810651 (console_owner){-.-.}, at: vprintk_emit+0x826/0xde0
> kernel/printk/printk.c:1906
>
> but task is already holding lock:
> 000000004ec3be2c (&(&port->lock)->rlock){-.-.}, at: pty_write+0xf9/0x1f0
> drivers/tty/pty.c:119
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (&(&port->lock)->rlock){-.-.}:
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>        tty_port_tty_get+0x20/0x80 drivers/tty/tty_port.c:288
>        tty_port_default_wakeup+0x15/0x40 drivers/tty/tty_port.c:47
>        tty_port_tty_wakeup+0x5d/0x70 drivers/tty/tty_port.c:390
>        uart_write_wakeup+0x44/0x60 drivers/tty/serial/serial_core.c:103
>        serial8250_tx_chars+0x4be/0xb60
> drivers/tty/serial/8250/8250_port.c:1808
>        serial8250_handle_irq.part.25+0x1ee/0x280
> drivers/tty/serial/8250/8250_port.c:1881
>        serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1867
> [inline]
>        serial8250_default_handle_irq+0xc8/0x150
> drivers/tty/serial/8250/8250_port.c:1897
>        serial8250_interrupt+0xfa/0x1d0
> drivers/tty/serial/8250/8250_core.c:125
>        __handle_irq_event_percpu+0x1c0/0xad0 kernel/irq/handle.c:149
>        handle_irq_event_percpu+0x98/0x1c0 kernel/irq/handle.c:189
>        handle_irq_event+0xa7/0x135 kernel/irq/handle.c:206
>        handle_edge_irq+0x20f/0x870 kernel/irq/chip.c:791
>        generic_handle_irq_desc include/linux/irqdesc.h:159 [inline]
>        handle_irq+0x18c/0x2e7 arch/x86/kernel/irq_64.c:77
>        do_IRQ+0x78/0x190 arch/x86/kernel/irq.c:245
>        ret_from_intr+0x0/0x1e
>        native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:54
>        arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
>        default_idle+0xc2/0x440 arch/x86/kernel/process.c:500
>        arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:491
>        default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
>        cpuidle_idle_call kernel/sched/idle.c:153 [inline]
>        do_idle+0x395/0x560 kernel/sched/idle.c:262
>        cpu_startup_entry+0x104/0x120 kernel/sched/idle.c:368
>        start_secondary+0x42b/0x5c0 arch/x86/kernel/smpboot.c:265
>        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242
>
> -> #1 (&port_lock_key){-.-.}:
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>        serial8250_console_write+0x8d5/0xb00
> drivers/tty/serial/8250/8250_port.c:3230
>        univ8250_console_write+0x5f/0x70
> drivers/tty/serial/8250/8250_core.c:590
>        call_console_drivers kernel/printk/printk.c:1718 [inline]
>        console_unlock+0xa9d/0x10a0 kernel/printk/printk.c:2389
>        vprintk_emit+0x6b2/0xde0 kernel/printk/printk.c:1907
>        vprintk_default+0x28/0x30 kernel/printk/printk.c:1948
>        vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:382
>        printk+0x9e/0xba kernel/printk/printk.c:1981
>        register_console+0x7e7/0xc00 kernel/printk/printk.c:2704
>        univ8250_console_init+0x3f/0x4b
> drivers/tty/serial/8250/8250_core.c:685
>        console_init+0x6d9/0xa38 kernel/printk/printk.c:2788
>        start_kernel+0x608/0x92d init/main.c:661
>        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
>        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
>        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242
>
> -> #0 (console_owner){-.-.}:
>        lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3924
>        console_trylock_spinning kernel/printk/printk.c:1672 [inline]
>        vprintk_emit+0x884/0xde0 kernel/printk/printk.c:1906
>        vprintk_default+0x28/0x30 kernel/printk/printk.c:1948
>        vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:382
>        printk+0x9e/0xba kernel/printk/printk.c:1981
>        fail_dump lib/fault-inject.c:44 [inline]
>        should_fail+0x97a/0xbcd lib/fault-inject.c:149
>        __should_failslab+0x124/0x180 mm/failslab.c:32
>        should_failslab+0x9/0x14 mm/slab_common.c:1522
>        slab_pre_alloc_hook mm/slab.h:423 [inline]
>        slab_alloc mm/slab.c:3378 [inline]
>        __do_kmalloc mm/slab.c:3716 [inline]
>        __kmalloc+0x63/0x760 mm/slab.c:3727
>        kmalloc include/linux/slab.h:518 [inline]
>        tty_buffer_alloc drivers/tty/tty_buffer.c:170 [inline]
>        __tty_buffer_request_room+0x2d2/0x7f0 drivers/tty/tty_buffer.c:268
>        tty_insert_flip_string_fixed_flag+0x8d/0x1f0
> drivers/tty/tty_buffer.c:313
>        tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
>        pty_write+0x12c/0x1f0 drivers/tty/pty.c:121
>        tty_put_char+0x129/0x150 drivers/tty/tty_io.c:2865
>        __process_echoes+0x4d9/0x8d0 drivers/tty/n_tty.c:703
>        process_echoes+0xfc/0x170 drivers/tty/n_tty.c:781
>        n_tty_set_termios+0xb56/0xe80 drivers/tty/n_tty.c:1837
>        tty_set_termios+0x7a0/0xac0 drivers/tty/tty_ioctl.c:341
>        set_termios+0x41e/0x7d0 drivers/tty/tty_ioctl.c:414
>        tty_mode_ioctl+0x535/0xb50 drivers/tty/tty_ioctl.c:747
>        n_tty_ioctl_helper+0x54/0x3b0 drivers/tty/tty_ioctl.c:940
>        n_tty_ioctl+0x54/0x320 drivers/tty/n_tty.c:2441
>        tty_ioctl+0x5e1/0x1870 drivers/tty/tty_io.c:2655
>        vfs_ioctl fs/ioctl.c:46 [inline]
>        file_ioctl fs/ioctl.c:500 [inline]
>        do_vfs_ioctl+0x1cf/0x16f0 fs/ioctl.c:684
>        ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
>        __do_sys_ioctl fs/ioctl.c:708 [inline]
>        __se_sys_ioctl fs/ioctl.c:706 [inline]
>        __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
>        do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> other info that might help us debug this:
>
> Chain exists of:
>   console_owner --> &port_lock_key --> &(&port->lock)->rlock
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&(&port->lock)->rlock);
>                                lock(&port_lock_key);
>                                lock(&(&port->lock)->rlock);
>   lock(console_owner);
>
>  *** DEADLOCK ***
>
> 5 locks held by syz-executor6/19187:
>  #0: 000000007080a3ba (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
> drivers/tty/tty_ldsem.c:365
>  #1: 000000006fe00659 (&o_tty->termios_rwsem/1){++++}, at:
> tty_set_termios+0xfd/0xac0 drivers/tty/tty_ioctl.c:328
>  #2: 000000007080a3ba (&tty->ldisc_sem){++++}, at: tty_ldisc_ref+0x22/0x90
> drivers/tty/tty_ldisc.c:284
>  #3: 00000000f8d1ab16 (&ldata->output_lock){+.+.}, at:
> process_echoes+0xb6/0x170 drivers/tty/n_tty.c:779
>  #4: 000000004ec3be2c (&(&port->lock)->rlock){-.-.}, at:
> pty_write+0xf9/0x1f0 drivers/tty/pty.c:119
>
> stack backtrace:
> CPU: 1 PID: 19187 Comm: syz-executor6 Not tainted 4.17.0+ #89
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  print_circular_bug.isra.36.cold.56+0x1bd/0x27d
> kernel/locking/lockdep.c:1227
>  check_prev_add kernel/locking/lockdep.c:1867 [inline]
>  check_prevs_add kernel/locking/lockdep.c:1980 [inline]
>  validate_chain kernel/locking/lockdep.c:2421 [inline]
>  __lock_acquire+0x343e/0x5140 kernel/locking/lockdep.c:3435
>  lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3924
>  console_trylock_spinning kernel/printk/printk.c:1672 [inline]
>  vprintk_emit+0x884/0xde0 kernel/printk/printk.c:1906
>  vprintk_default+0x28/0x30 kernel/printk/printk.c:1948
>  vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:382
>  printk+0x9e/0xba kernel/printk/printk.c:1981
>  fail_dump lib/fault-inject.c:44 [inline]
>  should_fail+0x97a/0xbcd lib/fault-inject.c:149
>  __should_failslab+0x124/0x180 mm/failslab.c:32
>  should_failslab+0x9/0x14 mm/slab_common.c:1522
>  slab_pre_alloc_hook mm/slab.h:423 [inline]
>  slab_alloc mm/slab.c:3378 [inline]
>  __do_kmalloc mm/slab.c:3716 [inline]
>  __kmalloc+0x63/0x760 mm/slab.c:3727
>  kmalloc include/linux/slab.h:518 [inline]
>  tty_buffer_alloc drivers/tty/tty_buffer.c:170 [inline]
>  __tty_buffer_request_room+0x2d2/0x7f0 drivers/tty/tty_buffer.c:268
>  tty_insert_flip_string_fixed_flag+0x8d/0x1f0 drivers/tty/tty_buffer.c:313
>  tty_insert_flip_string include/linux/tty_flip.h:37 [inline]
>  pty_write+0x12c/0x1f0 drivers/tty/pty.c:121
>  tty_put_char+0x129/0x150 drivers/tty/tty_io.c:2865
>  __process_echoes+0x4d9/0x8d0 drivers/tty/n_tty.c:703
>  process_echoes+0xfc/0x170 drivers/tty/n_tty.c:781
>  n_tty_set_termios+0xb56/0xe80 drivers/tty/n_tty.c:1837
>  tty_set_termios+0x7a0/0xac0 drivers/tty/tty_ioctl.c:341
>  set_termios+0x41e/0x7d0 drivers/tty/tty_ioctl.c:414
>  tty_mode_ioctl+0x535/0xb50 drivers/tty/tty_ioctl.c:747
>  n_tty_ioctl_helper+0x54/0x3b0 drivers/tty/tty_ioctl.c:940
>  n_tty_ioctl+0x54/0x320 drivers/tty/n_tty.c:2441
>  tty_ioctl+0x5e1/0x1870 drivers/tty/tty_io.c:2655
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:500 [inline]
>  do_vfs_ioctl+0x1cf/0x16f0 fs/ioctl.c:684
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
>  __do_sys_ioctl fs/ioctl.c:708 [inline]
>  __se_sys_ioctl fs/ioctl.c:706 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4559f9
> Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> Lost 23 message(s)!
> IPVS: length: 236 != 24
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
> IPVS: length: 236 != 24
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
>  __should_failslab+0x124/0x180 mm/failslab.c:32
>  should_failslab+0x9/0x14 mm/slab_common.c:1522
>  slab_pre_alloc_hook mm/slab.h:423 [inline]
>  slab_alloc_node mm/slab.c:3299 [inline]
>  kmem_cache_alloc_node_trace+0x26f/0x770 mm/slab.c:3661
>  __do_kmalloc_node mm/slab.c:3681 [inline]
>  __kmalloc_node_track_caller+0x33/0x70 mm/slab.c:3696
>  __kmalloc_reserve.isra.39+0x3a/0xe0 net/core/skbuff.c:137
>  __alloc_skb+0x14d/0x780 net/core/skbuff.c:205
>  alloc_skb include/linux/skbuff.h:987 [inline]
>  netlink_alloc_large_skb net/netlink/af_netlink.c:1182 [inline]
>  netlink_sendmsg+0xb01/0xfa0 net/netlink/af_netlink.c:1876
>  sock_sendmsg_nosec net/socket.c:633 [inline]
>  sock_sendmsg+0xd5/0x120 net/socket.c:643
>  ___sys_sendmsg+0x805/0x940 net/socket.c:2149
>  __sys_sendmsg+0x115/0x270 net/socket.c:2187
>  __do_sys_sendmsg net/socket.c:2196 [inline]
>  __se_sys_sendmsg net/socket.c:2194 [inline]
>  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2194
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4559f9
> Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fe47fbe2c68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fe47fbe36d4 RCX: 00000000004559f9
> RDX: 0000000000000000 RSI: 0000000020000900 RDI: 0000000000000014
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000015
> R13: 00000000004c08de R14: 00000000004d00d8 R15: 0000000000000001
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor2'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor2'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor2'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor2'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor2'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor2'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor2'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor2'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor2'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor2'.
> nla_parse: 5 callbacks suppressed
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor2'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor2'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor2'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor2'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor2'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor2'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor2'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor2'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor2'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor2'.
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000d557e7056e1c7a01%40google.com.
> For more options, visit https://groups.google.com/d/optout.
