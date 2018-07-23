Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C099CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B79D20874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rRRvAOnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B79D20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388013AbeGWJMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:12:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43710 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387794AbeGWJMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:12:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so743269pfi.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 01:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4njhivIPXdH4z/Mkza0Me+LOkhttioqSmF5SXHGQ78c=;
        b=rRRvAOnQO5gXyBKnh6lmcxP9/G13C0VnxlpSIthruTwxvEOZT6kwfiwP3GUJNnF31Q
         Hq4kOHezG0s1uVcvuVA1IG8AIbikVATc3sNOJMtMc2u7FmZYu7yG7/nINIyH5hyxENpL
         X7FABmboyTcbOXJTcQ75dU3W522ePKMx7SN7NiK/OK0oFed3oE/RrCIjTo4vKWp/aToM
         xxhlbpBhFstHUqLFUOtf1JjTUIOr4E3XBYuTl7AIh0X9radyAhRZWdIhC0Xleetc9o/n
         7kWVX2W/Z2PAdAjQKrl3xWd+dmxoyE7tH1IPdwZ8jFAN47uBfLUhjFASeX9V9qYkud8z
         yayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4njhivIPXdH4z/Mkza0Me+LOkhttioqSmF5SXHGQ78c=;
        b=MpjkecFTo9dR55VesfGNrhTq1oMpD1XLiD5Z7DVEJ94NAkWfdLOEgcu6/UV1NowozM
         NoNJVHIFIsFFcx0eU8AtdgyxZ7ZRo4x5BoCHLZ+rb4zekHREqhrtQg6R01sPgO3pdd4s
         vEcnthlUNlfyyO8et7sO7HJdgXllTQrO4Ij3NCDIEwD6yXwEzVYyqNgPM/+q8sQqRu9L
         ZfdPPqDlwIEE+G+m1GOc3L/orggSU7JiBFPMzN/eWIcAuxiG9iV2B/ueSJM8im5y6zPQ
         xdXt3UZpEvb3kHZsQrJnX5SMq5RvKr7JLagpFqJDMzew217RcIUmzWQ89OzaKaw4UuMh
         odbA==
X-Gm-Message-State: AOUpUlHndNzQbA9K6SldayQ4zd2VKpLPaOSPRe8maEeXeELddFuVZw0M
        LBWN1F46jU6Lbxbvv7PA689hjSJLlrpxCKjfaPIJA5WvzzE=
X-Google-Smtp-Source: AAOMgpemumtw643VMARLB+ItqtmlFkmYvnPnkKe5kSPPVeC6tT/eAE+1wVIqknUiQKI5t+960+4oToRifyQJSid7VRc=
X-Received: by 2002:a63:e742:: with SMTP id j2-v6mr11295772pgk.114.1532333536029;
 Mon, 23 Jul 2018 01:12:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 23 Jul 2018 01:11:55
 -0700 (PDT)
In-Reply-To: <000000000000bc17b60571a60434@google.com>
References: <000000000000bc17b60571a60434@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 23 Jul 2018 10:11:55 +0200
Message-ID: <CACT4Y+bKU8f4jVENYHX=fzNVd95A4vce2F=UCV12paVNFv-LNg@mail.gmail.com>
Subject: Re: INFO: task hung in fuse_reverse_inval_entry
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+bb6d800770577a083f8c@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 9:59 AM, syzbot
<syzbot+bb6d800770577a083f8c@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    d72e90f33aa4 Linux 4.18-rc6
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1324f794400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=68af3495408deac5
> dashboard link: https://syzkaller.appspot.com/bug?extid=bb6d800770577a083f8c
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=11564d1c400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fc570c400000


Hi fuse maintainers,

We are seeing a bunch of such deadlocks in fuse on syzbot. As far as I
understand this is mostly working-as-intended (parts about deadlocks
in Documentation/filesystems/fuse.txt). The intended way to resolve
this is aborting connections via fusectl, right? The doc says "Under
the fuse control filesystem each connection has a directory named by a
unique number". The question is: if I start a process and this process
can mount fuse, how do I kill it? I mean: totally and certainly get
rid of it right away? How do I find these unique numbers for the
mounts it created? Taking into account that there is usually no
operator attached to each server, I wonder if kernel could somehow
auto-abort fuse on kill? E.g. if all processes holding the fuse fd are
killed, it would be reasonable to abort the fuse conn and auto-resolve
deadlocks. Is it possible?



> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+bb6d800770577a083f8c@syzkaller.appspotmail.com
>
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> INFO: task syz-executor842:4559 blocked for more than 140 seconds.
>       Not tainted 4.18.0-rc6+ #160
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> syz-executor842 D23528  4559   4556 0x00000004
> Call Trace:
>  context_switch kernel/sched/core.c:2853 [inline]
>  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
>  schedule+0xfb/0x450 kernel/sched/core.c:3545
>  __rwsem_down_write_failed_common+0x95d/0x1630
> kernel/locking/rwsem-xadd.c:566
>  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:595
>  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
>  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
>  down_write+0xaa/0x130 kernel/locking/rwsem.c:72
>  inode_lock include/linux/fs.h:715 [inline]
>  fuse_reverse_inval_entry+0xae/0x6d0 fs/fuse/dir.c:969
>  fuse_notify_inval_entry fs/fuse/dev.c:1491 [inline]
>  fuse_notify fs/fuse/dev.c:1764 [inline]
>  fuse_dev_do_write+0x2b97/0x3700 fs/fuse/dev.c:1848
>  fuse_dev_write+0x19a/0x240 fs/fuse/dev.c:1928
>  call_write_iter include/linux/fs.h:1793 [inline]
>  new_sync_write fs/read_write.c:474 [inline]
>  __vfs_write+0x6c6/0x9f0 fs/read_write.c:487
>  vfs_write+0x1f8/0x560 fs/read_write.c:549
>  ksys_write+0x101/0x260 fs/read_write.c:598
>  __do_sys_write fs/read_write.c:610 [inline]
>  __se_sys_write fs/read_write.c:607 [inline]
>  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x445869
> Code: Bad RIP value.
> RSP: 002b:00007ffa2ef7fda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00000000006dac24 RCX: 0000000000445869
> RDX: 0000000000000029 RSI: 00000000200000c0 RDI: 0000000000000003
> RBP: 00000000006dac20 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
> R13: 64695f70756f7267 R14: 2f30656c69662f2e R15: 0000000000000001
> INFO: task syz-executor842:4560 blocked for more than 140 seconds.
>       Not tainted 4.18.0-rc6+ #160
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> syz-executor842 D26008  4560   4556 0x00000004
> Call Trace:
>  context_switch kernel/sched/core.c:2853 [inline]
>  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
>  schedule+0xfb/0x450 kernel/sched/core.c:3545
>  request_wait_answer+0x4c8/0x920 fs/fuse/dev.c:463
>  __fuse_request_send+0x12a/0x1d0 fs/fuse/dev.c:483
>  fuse_request_send+0x62/0xa0 fs/fuse/dev.c:496
>  fuse_simple_request+0x33d/0x730 fs/fuse/dev.c:554
>  fuse_lookup_name+0x3ee/0x830 fs/fuse/dir.c:323
>  fuse_lookup+0xf9/0x4c0 fs/fuse/dir.c:360
>  __lookup_hash+0x12e/0x190 fs/namei.c:1505
>  filename_create+0x1e5/0x5b0 fs/namei.c:3646
>  user_path_create fs/namei.c:3703 [inline]
>  do_mkdirat+0xda/0x310 fs/namei.c:3842
>  __do_sys_mkdirat fs/namei.c:3861 [inline]
>  __se_sys_mkdirat fs/namei.c:3859 [inline]
>  __x64_sys_mkdirat+0x76/0xb0 fs/namei.c:3859
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x445869
> Code: Bad RIP value.
> RSP: 002b:00007ffa2ef5eda8 EFLAGS: 00000297 ORIG_RAX: 0000000000000102
> RAX: ffffffffffffffda RBX: 00000000006dac3c RCX: 0000000000445869
> RDX: 0000000000000000 RSI: 0000000020000500 RDI: 00000000ffffff9c
> RBP: 00000000006dac38 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000297 R12: 0030656c69662f2e
> R13: 64695f70756f7267 R14: 2f30656c69662f2e R15: 0000000000000001
>
> Showing all locks held in the system:
> 1 lock held by khungtaskd/901:
>  #0: (____ptrval____) (rcu_read_lock){....}, at:
> debug_show_all_locks+0xd0/0x428 kernel/locking/lockdep.c:4461
> 1 lock held by rsyslogd/4441:
>  #0: (____ptrval____) (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1bb/0x200
> fs/file.c:766
> 2 locks held by getty/4531:
>  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
> drivers/tty/tty_ldsem.c:365
>  #1: (____ptrval____) (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
> 2 locks held by getty/4532:
>  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
> drivers/tty/tty_ldsem.c:365
>  #1: (____ptrval____) (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
> 2 locks held by getty/4533:
>  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
> drivers/tty/tty_ldsem.c:365
>  #1: (____ptrval____) (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
> 2 locks held by getty/4534:
>  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
> drivers/tty/tty_ldsem.c:365
>  #1: (____ptrval____) (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
> 2 locks held by getty/4535:
>  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
> drivers/tty/tty_ldsem.c:365
>  #1: (____ptrval____) (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
> 2 locks held by getty/4536:
>  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
> drivers/tty/tty_ldsem.c:365
>  #1: (____ptrval____) (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
> 2 locks held by getty/4537:
>  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
> drivers/tty/tty_ldsem.c:365
>  #1: (____ptrval____) (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
> 2 locks held by syz-executor842/4559:
>  #0: (____ptrval____) (&fc->killsb){.+.+}, at: fuse_notify_inval_entry
> fs/fuse/dev.c:1488 [inline]
>  #0: (____ptrval____) (&fc->killsb){.+.+}, at: fuse_notify
> fs/fuse/dev.c:1764 [inline]
>  #0: (____ptrval____) (&fc->killsb){.+.+}, at:
> fuse_dev_do_write+0x2b2d/0x3700 fs/fuse/dev.c:1848
>  #1: (____ptrval____) (&type->i_mutex_dir_key#4){+.+.}, at: inode_lock
> include/linux/fs.h:715 [inline]
>  #1: (____ptrval____) (&type->i_mutex_dir_key#4){+.+.}, at:
> fuse_reverse_inval_entry+0xae/0x6d0 fs/fuse/dir.c:969
> 3 locks held by syz-executor842/4560:
>  #0: (____ptrval____) (sb_writers#9){.+.+}, at: sb_start_write
> include/linux/fs.h:1554 [inline]
>  #0: (____ptrval____) (sb_writers#9){.+.+}, at: mnt_want_write+0x3f/0xc0
> fs/namespace.c:386
>  #1: (____ptrval____) (&type->i_mutex_dir_key#3/1){+.+.}, at:
> inode_lock_nested include/linux/fs.h:750 [inline]
>  #1: (____ptrval____) (&type->i_mutex_dir_key#3/1){+.+.}, at:
> filename_create+0x1b2/0x5b0 fs/namei.c:3645
>  #2: (____ptrval____) (&fi->mutex){+.+.}, at: fuse_lock_inode+0xaf/0xe0
> fs/fuse/inode.c:363
>
> =============================================
>
> NMI backtrace for cpu 1
> CPU: 1 PID: 901 Comm: khungtaskd Not tainted 4.18.0-rc6+ #160
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
>  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
>  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>  trigger_all_cpu_backtrace include/linux/nmi.h:138 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:196 [inline]
>  watchdog+0x9c4/0xf80 kernel/hung_task.c:252
>  kthread+0x345/0x410 kernel/kthread.c:246
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0 skipped: idling at native_safe_halt+0x6/0x10
> arch/x86/include/asm/irqflags.h:54
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
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000bc17b60571a60434%40google.com.
> For more options, visit https://groups.google.com/d/optout.
