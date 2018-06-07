Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id D0V3Bke+GFs0HAAAmS7hNA
	; Thu, 07 Jun 2018 05:10:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EDEEE6089E; Thu,  7 Jun 2018 05:10:30 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guQzY6w5"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1133260115;
	Thu,  7 Jun 2018 05:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1133260115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeFGFK2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 01:10:28 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40124 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeFGFKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 01:10:25 -0400
Received: by mail-pf0-f196.google.com with SMTP id z24-v6so4276787pfe.7;
        Wed, 06 Jun 2018 22:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hs/im8Pln2+ChTWItiDXhNE0KEGk6PLNN7wHGwZZLe0=;
        b=guQzY6w5bZ44mhOcSCbf/9ZM7C8XDw/xup9RFnHdzph3vvCYdbPMRPmvfzddGP9Tlq
         7t81doBibD39pFEuefzs1in24chOlGbJ6zj9OxrffEwz+VOfdQbRGztKJn9tPevLk10N
         lEM+vMM2BrYlU7h2lX6JilF8S+jdWAcODo4JjmW/g30S2Jn3cJpLmHeBI/34GvDl94KN
         TFHQWCOl/Z7yzuqIwUhc5lf2iLt6vALn1uAwfmjrr36B9hBG5bzn2U/ZMb/3RM8FKoYz
         yevhD9FsClwOnNP17ZRHhbFqi3XfIR2ksVvtflmFkIS+o05ejVXOeFPinbsrH1sdWyY4
         3Q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hs/im8Pln2+ChTWItiDXhNE0KEGk6PLNN7wHGwZZLe0=;
        b=WJ+mSv0F0yz4UFGrPivyIzq/pRyEqLycQ7LXJMAW+d2lc2G+2d6L4gWOUV60rBoK5f
         0bSu56MXzxoY8yjcET27DRPDcn4I7ZiXTuOKFPu+YLm95Ppg3Utfb6vgSy9ZKzvv5nT5
         HGDCpPULdkAN0WAFGl/8mwtGaVP76X7VaZqEoxgsGW7JmQNnjQ9dJehfSiZnWkHinZn0
         EZq9tzPzh8KOBiC0HiMteW592v5VUS9HTHQMeohZMMfYxeEPhw5Q21ZjvrhCm1oOlRGd
         MCYRsPyjAvsC8b/EUOQwdePv1SJDN1MS4bfu2CK+YKRwTY+eA8tepoUkE8bL4+jIbze1
         nj2A==
X-Gm-Message-State: APt69E0i2J7wmU9105CGHjd9j4ldXlBQLFka/P4Ljix3zd8YWuHVrk58
        WnVjWj8zybFGHfaTQBf6sqhW0HTN
X-Google-Smtp-Source: ADUXVKJdI161wxYFwaPwke+SxC+ObebbffOmTR3W2g2EPs7sM9VPMB0s+s06ppKQKQ8Mk1trVd3YFA==
X-Received: by 2002:a65:578c:: with SMTP id b12-v6mr336977pgr.315.1528348224458;
        Wed, 06 Jun 2018 22:10:24 -0700 (PDT)
Received: from localhost ([39.7.47.166])
        by smtp.gmail.com with ESMTPSA id f11-v6sm10788661pgo.62.2018.06.06.22.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 22:10:23 -0700 (PDT)
Date: Thu, 7 Jun 2018 14:10:19 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: possible deadlock in console_unlock
Message-ID: <20180607051019.GA10406@jagdpanzerIV>
References: <00000000000087008b056df8fbb3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000087008b056df8fbb3@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc-ing more people
Link: lkml.kernel.org/r/00000000000087008b056df8fbb3@google.com

On (06/06/18 06:17), syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    af6c5d5e01ad Merge branch 'for-4.18' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=173d93ef800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=12ff770540994680
> dashboard link: https://syzkaller.appspot.com/bug?extid=43e93968b964e369db0b
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> userspace arch: i386
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=16e00bb7800000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com

Thanks a ton!

So tty ioctl is known to be printk-deadlock prone and we don't know
how to handle this in printk, as of now.

ioctl
 tty_ioctl
  tty_port->lock
   printk
    call_console_driver
     console_driver
      uart_port->lock

The problem is that call_console_driver->console_driver also can do
this thing

   uart_port->lock
    tty_wakeup
     tty_port->lock

So we can have the following:

ioctl
 tty_ioctl
  tty_port->lock
   printk
    call_console_driver
     console_driver
      uart_port->lock
       tty_wakeup
        tty_port->lock      << deadlock


But lockdep is complaining about another scenario:

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

So this one is  IRQ ==> uart_port->lock ==>  tty_port->lock

> -> #1 (&port_lock_key){-.-.}:
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>        serial8250_console_write+0x8d5/0xb00
> drivers/tty/serial/8250/8250_port.c:3230
>        univ8250_console_write+0x5f/0x70
> drivers/tty/serial/8250/8250_core.c:590
>        call_console_drivers kernel/printk/printk.c:1718 [inline]
>        console_unlock+0xac2/0x1100 kernel/printk/printk.c:2395
>        vprintk_emit+0x6ad/0xdd0 kernel/printk/printk.c:1907
>        vprintk_default+0x28/0x30 kernel/printk/printk.c:1947
>        vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:379
>        printk+0x9e/0xba kernel/printk/printk.c:1980
>        register_console+0x7e7/0xc00 kernel/printk/printk.c:2714
>        univ8250_console_init+0x3f/0x4b
> drivers/tty/serial/8250/8250_core.c:685
>        console_init+0x6d9/0xa38 kernel/printk/printk.c:2798
>        start_kernel+0x608/0x92d init/main.c:661
>        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
>        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
>        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242

This one is console_owner/console_sem ==> uart_port->lock


> -> #0 (console_owner){-...}:
>        lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3924
>        console_lock_spinning_enable kernel/printk/printk.c:1581 [inline]
>        console_unlock+0x5ef/0x1100 kernel/printk/printk.c:2392
>        vprintk_emit+0x6ad/0xdd0 kernel/printk/printk.c:1907
>        vprintk_default+0x28/0x30 kernel/printk/printk.c:1947
>        vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:379
>        printk+0x9e/0xba kernel/printk/printk.c:1980
>        fail_dump lib/fault-inject.c:44 [inline]
>        should_fail+0x97a/0xbcd lib/fault-inject.c:149
>        __should_failslab+0x124/0x180 mm/failslab.c:32
>        should_failslab+0x9/0x14 mm/slab_common.c:1522
>        slab_pre_alloc_hook mm/slab.h:423 [inline]
>        slab_alloc mm/slab.c:3378 [inline]
>        __do_kmalloc mm/slab.c:3716 [inline]
>        __kmalloc+0x63/0x760 mm/slab.c:3727
>        kmalloc include/linux/slab.h:517 [inline]
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
>        tty_mode_ioctl+0x871/0xb50 drivers/tty/tty_ioctl.c:781
>        n_tty_ioctl_helper+0x54/0x3b0 drivers/tty/tty_ioctl.c:940
>        n_tty_ioctl+0x54/0x320 drivers/tty/n_tty.c:2441
>        tty_ioctl+0x5e1/0x1870 drivers/tty/tty_io.c:2655
>        vfs_ioctl fs/ioctl.c:46 [inline]
>        file_ioctl fs/ioctl.c:500 [inline]
>        do_vfs_ioctl+0x1cf/0x16f0 fs/ioctl.c:684
>        __do_compat_sys_ioctl fs/compat_ioctl.c:1483 [inline]
>        __se_compat_sys_ioctl fs/compat_ioctl.c:1407 [inline]
>        __ia32_compat_sys_ioctl+0x43e/0x640 fs/compat_ioctl.c:1407
>        do_syscall_32_irqs_on arch/x86/entry/common.c:323 [inline]
>        do_fast_syscall_32+0x345/0xf9b arch/x86/entry/common.c:394
>        entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

This one is tty IOCTL ==> tty_port->lock ==> console_owner/console_sem ==> uart_port->lock

>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&(&port->lock)->rlock);
>                                lock(&port_lock_key);
>                                lock(&(&port->lock)->rlock);
>   lock(console_owner);


IOW

    tty ioctl
    tty_port->lock		IRQ
    printk			uart_port->lock
    console_owner
    uart_port->lock		tty_port->rlock


The simplest thing to do [not necessarily the right one, tho]
would be to break the IOCTL ==> tty_port->lock ==> printk ==> uart_port->lock
chain.

E.g. by adding __GFP_NOWARN

---

 drivers/tty/tty_buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index c996b6859c5e..71958ef6a831 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -167,7 +167,8 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
 	   have queued and recycle that ? */
 	if (atomic_read(&port->buf.mem_used) > port->buf.mem_limit)
 		return NULL;
-	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
+	p = kmalloc(sizeof(struct tty_buffer) + 2 * size,
+			GFP_ATOMIC | __GFP_NOWARN);
 	if (p == NULL)
 		return NULL;

---


Another way could be - switch to printk_safe mode around that
kmalloc():

	__printk_safe_enter();
	kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
	__printk_safe_exit();

This will redirect all printk()-s from kmalloc() to a special per-CPU
buffer, which will be flushed later from a safe context (irq work).


Or, may be, we even can switch to printk_safe mode every time we grab
tty_port lock.

#define tty_port_lock_irqsave(l,f)				\
	do {							\
		spin_lock_irqsave((l), f);			\
		__printk_safe_enter();				\
	} while (0)

#define tty_port_unlock_irqrestore(l,f)				\
	do {							\
		__printk_safe_exit();				\
		spin_lock_irqrestore((l),f);			\
	} while (0)

This will require some "automatic" replacement of all port->lock
operation in drivers/tty/*.

Perhaps something like this should be done for uart_port->lock
as well. Because, technically, we can have the following

	IRQ
	uart_port->lock
	tty_wakeup
	printk
	 call_console_drivers
	  console_driver
	   uart_port->lock               << deadlock

Which is totally possible.
E.g. tty_port_default_wakeup()->tty_port_tty_get()->refcount_inc()->WARN_ONCE()

Any opinions?

	-ss
