Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8696C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEA424C21
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3U+AFWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEA424C21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753867AbeGCEa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 00:30:28 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46179 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752527AbeGCEa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 00:30:26 -0400
Received: by mail-pf0-f195.google.com with SMTP id l123-v6so351501pfl.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 21:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yfxNY3tklC6M9vr1y0Iu0LWfFe7HXDbw9iOiKyATP4w=;
        b=Q3U+AFWTitJReEhgQ/bZdjXfxmfoYoSXw1RsMtC26vPe54BK5XVpBvO4uh8/sVpuL0
         o0afJO/+XjgMRuYDW+DEyAzPWVCg8fhRWdJOMeez2AdlYXyQ1qyNo0UDXsPQbBqGIe4X
         N5HcqS+6p1ovovJ71N7eADCP75i8R1nzXlHsrfqgQxDVapIRONHu93TNfS+rFfg3jgLl
         7tCjbJXZLRZHQo/BLEbUNvnGNc7Fd7gC+zfMsv3irBJsS0ReZSws0hfGvywfeSROzlDV
         CiWrDFSc0RFPHAPgOxjLK/Trh924l5LJXGGMzbTBgYfuObJeZCBTjtHksNILBpqurhcS
         Dq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yfxNY3tklC6M9vr1y0Iu0LWfFe7HXDbw9iOiKyATP4w=;
        b=jbk/8Jr8NvzsYM9CgX59vHXSPVzz9npWJ5apG9p7wbJQwr+YOj9OIz2Pyjm/GH7+MD
         lUXQVjF0Z+X2AZe+ZZNqM0dSgfdNXsG2NOkxgfsPHw8dHQaZEmpJsJyl6SnyIxEMxGbm
         KUWwr92EfrVOSrCiWF53I2D5QWf7ejtVqHiH8POojXn58qacYQ9g3RXQjQE3+7whd9Zq
         DQRGhmFUprfmeQkNiMiZCEBOvrmpaesdsbX0dIgsLyrQHJB3QGE7gcj0IyDITxO1M2Xp
         gieYwjbEhssTdUxPl5jIZbcUkze8NixQ+MVsLzts/WRnq8ic++34wgDEaBMGm6IUqR5N
         BGcA==
X-Gm-Message-State: APt69E07ycK/xLxwsfYPf7VjfjagA54h2w92XoKZfFcr3Av+7T1uBlEI
        IxI6SPhe4r8DhcSx2ptu01I=
X-Google-Smtp-Source: AAOMgpfxCnSwko9+8mUc/4da01XyTV5v05mFl7xTC+ZbPA/vWdd1Qtucw2eQju1wPOuOSwiMfdRmJQ==
X-Received: by 2002:a65:4b4e:: with SMTP id k14-v6mr15426966pgt.31.1530592225688;
        Mon, 02 Jul 2018 21:30:25 -0700 (PDT)
Received: from localhost ([175.223.22.36])
        by smtp.gmail.com with ESMTPSA id c8-v6sm282713pgu.19.2018.07.02.21.30.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 21:30:24 -0700 (PDT)
Date:   Tue, 3 Jul 2018 13:30:21 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: printk() from NMI backtrace can delay a lot
Message-ID: <20180703043021.GA547@jagdpanzerIV>
References: <bf037670-c647-b34a-486b-53ec3661b48e@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf037670-c647-b34a-486b-53ec3661b48e@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc-ing Linus, Tejun, Andrew
[I'll keep the entire lockdep report]

On (07/02/18 19:26), Tetsuo Handa wrote:
[..]
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606834] swapper/0/0 is trying to acquire lock:
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606835] 00000000316e1432 (console_owner){-.-.}, at: console_unlock+0x1ce/0x8b0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606840] 
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606841] but task is already holding lock:
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606842] 000000009b45dcb4 (&(&pool->lock)->rlock){-.-.}, at: show_workqueue_state+0x3b2/0x900
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606847] 
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606848] which lock already depends on the new lock.
> ...
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606851] the existing dependency chain (in reverse order) is:
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606852] 
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606852] -> #4 (&(&pool->lock)->rlock){-.-.}:
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606857]        _raw_spin_lock+0x2a/0x40
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606858]        __queue_work+0xfb/0x780
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606859]        queue_work_on+0xde/0x110
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606861]        put_pwq+0x85/0x90
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606862]        put_pwq_unlocked.part.29+0x1d/0x30
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606863]        destroy_workqueue+0x2df/0x320
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606865]        tipc_topsrv_stop+0x1a0/0x290
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606866]        tipc_exit_net+0x15/0x40
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606867]        ops_exit_list.isra.8+0x4e/0x90
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606869]        cleanup_net+0x219/0x390
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606870]        process_one_work+0x2ec/0x800
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606871]        worker_thread+0x45/0x4d0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606872]        kthread+0x14c/0x170
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606874]        ret_from_fork+0x3a/0x50

I assume this one is

	pwq->pool->lock -> last_pool->lock ?

> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606874] 
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606875] -> #3 (&pool->lock/1){-.-.}:
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606880]        _raw_spin_lock+0x2a/0x40
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606881]        __queue_work+0xfb/0x780
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606882]        queue_work_on+0xde/0x110
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606884]        tty_flip_buffer_push+0x2f/0x40
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606885]        pty_write+0xb0/0xc0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606886]        n_tty_write+0x244/0x620
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606887]        tty_write+0x1e3/0x3f0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606888]        __vfs_write+0x54/0x270
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606890]        vfs_write+0xf0/0x230
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606891]        redirected_tty_write+0x61/0xb0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606892]        do_iter_write+0x1ce/0x220
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606893]        vfs_writev+0xb0/0x140
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606895]        do_writev+0x6d/0x120
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606896]        __x64_sys_writev+0x20/0x30
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606897]        do_syscall_64+0x81/0x260
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606899]        entry_SYSCALL_64_after_hwframe+0x49/0xbe

So #3 is

	tty_port->lock -> WQ pool->lock

> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606900] -> #2 (&(&port->lock)->rlock){-.-.}:
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606905]        _raw_spin_lock_irqsave+0x56/0x70
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606906]        tty_port_tty_get+0x20/0x60
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606907]        tty_port_default_wakeup+0x15/0x40
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606909]        tty_port_tty_wakeup+0x20/0x30
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606910]        uart_write_wakeup+0x26/0x40
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606911]        serial8250_tx_chars+0x1ae/0x2d0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606913]        serial8250_handle_irq.part.23+0x108/0x130
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606915]        serial8250_default_handle_irq+0x7a/0x90
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606916]        serial8250_interrupt+0x77/0x110
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606918]        __handle_irq_event_percpu+0x80/0x480
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606919]        handle_irq_event_percpu+0x35/0x90
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606920]        handle_irq_event+0x39/0x60
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606922]        handle_edge_irq+0xa5/0x230
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606923]        handle_irq+0xae/0x120
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606924]        do_IRQ+0x53/0x110
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606925]        ret_from_intr+0x0/0x1e
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606927]        free_unref_page_list+0x333/0x590
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606928]        release_pages+0x44a/0x5c0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606930]        free_pages_and_swap_cache+0x107/0x150
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606931]        tlb_flush_mmu_free+0x4e/0x70
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606932]        arch_tlb_finish_mmu+0x61/0xa0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606934]        tlb_finish_mmu+0x36/0x50
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606935]        exit_mmap+0x10a/0x230
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606936]        mmput+0x92/0x1c0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606937]        do_exit+0x365/0x10b0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606938]        do_group_exit+0x60/0x100
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606940]        __x64_sys_exit_group+0x1c/0x20
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606941]        do_syscall_64+0x81/0x260
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606943]        entry_SYSCALL_64_after_hwframe+0x49/0xbe

#2 is
	hard IRQ uart_port->lock -> tty_port->lock

> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606943] 
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606944] -> #1 (&port_lock_key){-.-.}:
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606948]        _raw_spin_lock_irqsave+0x56/0x70
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606950]        serial8250_console_write+0x30c/0x3b0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606951]        univ8250_console_write+0x35/0x40
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606953]        console_unlock+0x650/0x8b0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606954]        register_console+0x339/0x540
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606955]        univ8250_console_init+0x30/0x3a
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606957]        console_init+0x2c6/0x424
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606958]        start_kernel+0x466/0x61f
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606959]        x86_64_start_reservations+0x2a/0x2c
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606961]        x86_64_start_kernel+0x72/0x75
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606962]        secondary_startup_64+0xa5/0xb0

Must be
  console_sem / console_owner -> uart_port->lock ?

> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606963] 
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606963] -> #0 (console_owner){-.-.}:
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606968]        lock_acquire+0xbf/0x220
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606969]        console_unlock+0x23e/0x8b0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606970]        vprintk_emit+0x394/0x680
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606971]        vprintk_default+0x28/0x30
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606973]        vprintk_func+0x57/0xc0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606974]        printk+0x5e/0x7d
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606975]        show_workqueue_state+0x448/0x900
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606977]        wq_watchdog_timer_fn+0x1df/0x320
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606978]        call_timer_fn+0xb0/0x420
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606979]        run_timer_softirq+0x2da/0x870
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606981]        __do_softirq+0xd0/0x4fe
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606982]        irq_exit+0xd4/0xe0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606983]        smp_apic_timer_interrupt+0x9a/0x2b0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606985]        apic_timer_interrupt+0xf/0x20
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606986]        native_safe_halt+0x6/0x10
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606987]        default_idle+0x2e/0x1a0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606988]        arch_cpu_idle+0x10/0x20
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606990]        default_idle_call+0x1e/0x40
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606991]        do_idle+0x205/0x2e0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606992]        cpu_startup_entry+0x6e/0x70
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606993]        rest_init+0xc7/0xd0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606995]        start_kernel+0x5fc/0x61f
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606996]        x86_64_start_reservations+0x2a/0x2c
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606997]        x86_64_start_kernel+0x72/0x75
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606999]        secondary_startup_64+0xa5/0xb0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606999] 

#0 is
	softirq WQ pool->lock -> console_sem / console_owner -> uart_port->lock

> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607001] other info that might help us debug this:
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607001] 
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607002] Chain exists of:
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607003]   console_owner --> &pool->lock/1 --> &(&pool->lock)->rlock

I don't quite understand how that direct "console_owner -> pool->lock" is
possible, there should be uart/tty somewhere in between. For instance:

	console_owner -> uart_port->lock -> pool->lock -> &(&pool->lock)->rlock


But anyway. So we can have [but I'm not completely sure. Maybe lockdep has
something else on its mind] something like this:

	CPU1					CPU0

	#IRQ					#soft irq
	serial8250_handle_irq()			wq_watchdog_timer_fn()
	 spin_lock(&uart_port->lock)		 show_workqueue_state()
	  serial8250_rx_chars()			   spin_lock(&pool->lock)
	   tty_flip_buffer_push()		    printk()
	    tty_schedule_flip()			     serial8250_console_write()
	     queue_work()			      spin_lock(&uart_port->lock)
	      __queue_work()
	       spin_lock(&pool->lock)

We need to break the pool->lock -> uart_port->lock chain.

- use printk_deferred() to show WQs states [show_workqueue_state() is
  a timer callback, so local IRQs are enabled]. But show_workqueue_state()
  is also available via sysrq.

- what Alan Cox suggested: use spin_trylock() in serial8250_console_write()
  and just discard (do not print anything on console) console->writes() that
  can deadlock us [uart_port->lock is already locked]. This basically means
  that sometimes there will be no output on a serial console, or there
  will be missing line. Which kind of contradicts the purpose of print
  out.

We are facing the risk of no output on serial consoles in both case. Thus
there must be some other way out of this.

Any thoughts?


> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607009] 
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607010]  Possible unsafe locking scenario:
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607011] 
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607012]        CPU0                    CPU1
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607014]        ----                    ----
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607014]   lock(&(&pool->lock)->rlock);
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607017]                                lock(&pool->lock/1);
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607021]                                lock(&(&pool->lock)->rlock);
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607024]   lock(console_owner);
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607026] 
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607027]  *** DEADLOCK ***
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607027] 
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607028] 4 locks held by swapper/0/0:
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607029]  #0: 00000000acb744a0 ((&wq_watchdog_timer)){+.-.}, at: call_timer_fn+0x0/0x420
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607034]  #1: 00000000918be876 (rcu_read_lock_sched){....}, at: show_workqueue_state+0x0/0x900
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607040]  #2: 000000009b45dcb4 (&(&pool->lock)->rlock){-.-.}, at: show_workqueue_state+0x3b2/0x900
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607045]  #3: 000000005fd39989 (console_lock){+.+.}, at: vprintk_emit+0x386/0x680
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607050] 
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607051] stack backtrace:
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607053] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O      4.18.0-rc3 #643
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607056] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/19/2017
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607057] Call Trace:
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607058]  <IRQ>
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607059]  dump_stack+0xe9/0x148
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607061]  print_circular_bug.isra.39+0x1f3/0x201
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607062]  __lock_acquire+0x135f/0x1400
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607063]  lock_acquire+0xbf/0x220
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607065]  ? console_unlock+0x215/0x8b0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607066]  ? lock_acquire+0xbf/0x220
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607067]  ? console_unlock+0x1ce/0x8b0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607068]  console_unlock+0x23e/0x8b0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607070]  ? console_unlock+0x1ce/0x8b0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607071]  vprintk_emit+0x394/0x680
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607072]  vprintk_default+0x28/0x30
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607073]  vprintk_func+0x57/0xc0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607074]  printk+0x5e/0x7d
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607076]  show_workqueue_state+0x448/0x900
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607077]  ? wq_watchdog_timer_fn+0x1a6/0x320
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607078]  wq_watchdog_timer_fn+0x1df/0x320
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607080]  ? show_workqueue_state+0x900/0x900
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607081]  ? show_workqueue_state+0x900/0x900
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607082]  call_timer_fn+0xb0/0x420
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607084]  ? show_workqueue_state+0x900/0x900
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607085]  run_timer_softirq+0x2da/0x870
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607086]  __do_softirq+0xd0/0x4fe
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607087]  irq_exit+0xd4/0xe0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607089]  smp_apic_timer_interrupt+0x9a/0x2b0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607090]  apic_timer_interrupt+0xf/0x20
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607091]  </IRQ>
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607092] RIP: 0010:native_safe_halt+0x6/0x10
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607093] Code: 53 18 fe 65 48 8b 04 25 40 5e 01 00 f0 80 48 02 20 48 8b 00 a8 08 0f 84 57 ff ff ff eb a6 90 90 90 90 90 90 55 48 89 e5 fb f4 <5d> c3 0f 1f 84 00 00 00 00 00 55 48 89 e5 f4 5d c3 90 90 90 90 90 
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607135] RSP: 0018:ffffffff84003df8 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607138] RAX: ffffffff8406d7c0 RBX: 0000000000000000 RCX: 0000000000000000
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607140] RDX: ffffffff8406d7c0 RSI: 0000000000000001 RDI: ffffffff8406d7c0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607142] RBP: ffffffff84003df8 R08: 0000000000000001 R09: 0000000000000000
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607144] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607146] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff84098920
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607148]  ? trace_hardirqs_on+0xd/0x10
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607149]  default_idle+0x2e/0x1a0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607150]  arch_cpu_idle+0x10/0x20
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607151]  default_idle_call+0x1e/0x40
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607152]  do_idle+0x205/0x2e0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607154]  ? do_idle+0xf9/0x2e0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607155]  cpu_startup_entry+0x6e/0x70
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607156]  rest_init+0xc7/0xd0
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607158]  ? trace_event_define_fields_vector_alloc_managed+0x8b/0x8b
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607159]  start_kernel+0x5fc/0x61f
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607161]  x86_64_start_reservations+0x2a/0x2c
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607162]  x86_64_start_kernel+0x72/0x75
> 2018-07-02 12:13:13 192.168.159.129:6666 [  151.607163]  secondary_startup_64+0xa5/0xb0
> 2018-07-02 12:13:44 192.168.159.129:6666 [  182.238928] BUG: workqueue lockup - pool cpus=2 node=0 flags=0x0 nice=0 stuck for 92s!
> 2018-07-02 12:13:44 192.168.159.129:6666 [  182.241803] Showing busy workqueues and worker pools:
> 2018-07-02 12:13:44 192.168.159.129:6666 [  182.243616] workqueue mm_percpu_wq: flags=0x8
> 2018-07-02 12:13:44 192.168.159.129:6666 [  182.245141]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=1/256
> 2018-07-02 12:13:44 192.168.159.129:6666 [  182.247130]     pending: vmstat_update
> 2018-07-02 12:14:11 192.168.159.129:6666 [  209.030165] INFO: rcu_sched detected stalls on CPUs/tasks:
> 2018-07-02 12:14:11 192.168.159.129:6666 [  209.032175] 	2-...0: (0 ticks this GP) idle=0be/1/4611686018427387904 softirq=5544/5544 fqs=27833 
> 2018-07-02 12:14:11 192.168.159.129:6666 [  209.035069] 	(detected by 3, t=120007 jiffies, g=2553, c=2552, q=1155)
> 2018-07-02 12:14:11 192.168.159.129:6666 [  209.037220] Sending NMI from CPU 3 to CPUs 2:

	-ss
