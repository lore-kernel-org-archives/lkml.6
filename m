Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D212C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6052087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OSyyM/24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbfA3IM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:12:28 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37132 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfA3IM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:12:28 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so9133141iti.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 00:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7JpusZRSPBdbjHLwM9PopsxkJa2uXwopbUI8jGfqnmk=;
        b=OSyyM/24GTiUNAi2dExYl3L1QArG2E/m9Dlh8UlChSB0YNev2AdJrdFEEfe8z/0vld
         R3IyuZUsqMTiLembKLknVG/3N9WgkU9J3tYNeS2eQzVdIqOcTVV5OXpxDkQ42pHZ46Yi
         JSJHY7zl81WQbPze/RM5L5ILCd+1UACU82pfZD+FGf5cYVa2/pE6xo2KQcwthJF1AsOK
         nCkJcWculG22plpfGMple8tWPyEe4/DVRwsruD3PlLfaY8NYizA13uD1RwaoptSgNJR0
         mPdOotGjfZ8e/+NsEGaJ2jkUuxBSDeDVfHp5QEw1s+vxfQnIZAxYg7vifr6nEromEU1p
         v7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7JpusZRSPBdbjHLwM9PopsxkJa2uXwopbUI8jGfqnmk=;
        b=ud+JYq8eRgvw7xWsYnFHqWq0gY/nnWeQfOtu1GQWS+YtW2IiPQDDFykCI+E+eVCSOW
         hJasb7mMMdn+lPAfCySW8gc5hktgnMdihseopaVdBNsRYjD0pR/tQyaDknIucHdp7IIg
         XCRXjd7zb6VA9o/JbCajcdEND0jkDi6LeeLAAeIAkRBswEmbrM2lsh30T+gq5fqcrPKx
         pJr6KDmWPX6aIx7Nl8bh5zu2vTLWs6V1uP9hbeVh6zek2/I2P4lBIgKU5aEcKnzpKYPU
         mOeoWR8cpsTgiAxf0I9HeOtwQZLya+tvgOG5zziLafrqx/o7m1IJwp0gBDqZUmHbWTur
         YcHg==
X-Gm-Message-State: AJcUukeOiS+C3hI5B5YEhdhIHDC/tPmR9kE/xxYT5VFUXwh0hBpDOKeS
        tXQmdvAkbkLCa76eZFMXuIEP96PKHqXKGoOT0vPoEA==
X-Google-Smtp-Source: ALg8bN4CubbQdF9gmMTWkOYg82D6JdWA/i9KXndwPd1GkqIa3NAoTSCdDrAavlfsGZHQMIrohCAwZLuQ6j9WnpDnO0U=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr12227462iti.166.1548835946518;
 Wed, 30 Jan 2019 00:12:26 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007e86fd058095533f@google.com> <20190129105957-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190129105957-mutt-send-email-mst@kernel.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 30 Jan 2019 09:12:15 +0100
Message-ID: <CACT4Y+Yiz2NpDMNLSP+Z-qf9Swo56Yhb0CbmrUyPHojmMZzCAQ@mail.gmail.com>
Subject: Re: INFO: task hung in vhost_init_device_iotlb
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     syzbot <syzbot+40e28a8bd59d10ed0c42@syzkaller.appspotmail.com>,
        Jason Wang <jasowang@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 5:06 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jan 29, 2019 at 01:22:02AM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    983542434e6b Merge tag 'edac_fix_for_5.0' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17476498c00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=505743eba4e4f68
> > dashboard link: https://syzkaller.appspot.com/bug?extid=40e28a8bd59d10ed0c42
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
>
> Hmm nothing obvious below. Generic corruption elsewhere?

Hard to say, a silent memory corruption is definitely possible.
If there is nothing obvious let's wait, maybe syzbot will come up with
a repro or we get more such hangs so that it will be possible to rule
out flakes/corruptions.


> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+40e28a8bd59d10ed0c42@syzkaller.appspotmail.com
> >
> > protocol 88fb is buggy, dev hsr_slave_1
> > protocol 88fb is buggy, dev hsr_slave_0
> > protocol 88fb is buggy, dev hsr_slave_1
> > protocol 88fb is buggy, dev hsr_slave_0
> > protocol 88fb is buggy, dev hsr_slave_1
> > INFO: task syz-executor5:9417 blocked for more than 140 seconds.
> >       Not tainted 5.0.0-rc3+ #48
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > syz-executor5   D27576  9417   8469 0x00000004
> > Call Trace:
> >  context_switch kernel/sched/core.c:2831 [inline]
> >  __schedule+0x897/0x1e60 kernel/sched/core.c:3472
> >  schedule+0xfe/0x350 kernel/sched/core.c:3516
> > protocol 88fb is buggy, dev hsr_slave_0
> > protocol 88fb is buggy, dev hsr_slave_1
> >  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3574
> >  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
> >  __mutex_lock+0xa3b/0x1670 kernel/locking/mutex.c:1072
> >  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
> >  vhost_init_device_iotlb+0x124/0x280 drivers/vhost/vhost.c:1606
> >  vhost_net_set_features drivers/vhost/net.c:1674 [inline]
> >  vhost_net_ioctl+0x1282/0x1c00 drivers/vhost/net.c:1739
> >  vfs_ioctl fs/ioctl.c:46 [inline]
> >  file_ioctl fs/ioctl.c:509 [inline]
> >  do_vfs_ioctl+0x107b/0x17d0 fs/ioctl.c:696
> >  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
> >  __do_sys_ioctl fs/ioctl.c:720 [inline]
> >  __se_sys_ioctl fs/ioctl.c:718 [inline]
> >  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
> >  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
> > protocol 88fb is buggy, dev hsr_slave_0
> > protocol 88fb is buggy, dev hsr_slave_1
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x458099
> > Code: Bad RIP value.
> > RSP: 002b:00007efd7ca9bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458099
> > RDX: 0000000020000080 RSI: 000000004008af00 RDI: 0000000000000003
> > RBP: 000000000073bfa0 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007efd7ca9c6d4
> > R13: 00000000004c295b R14: 00000000004d5280 R15: 00000000ffffffff
> > INFO: task syz-executor5:9418 blocked for more than 140 seconds.
> >       Not tainted 5.0.0-rc3+ #48
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > syz-executor5   D27800  9418   8469 0x00000004
> > Call Trace:
> >  context_switch kernel/sched/core.c:2831 [inline]
> >  __schedule+0x897/0x1e60 kernel/sched/core.c:3472
> >  schedule+0xfe/0x350 kernel/sched/core.c:3516
> >  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3574
> >  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
> >  __mutex_lock+0xa3b/0x1670 kernel/locking/mutex.c:1072
> >  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
> >  vhost_net_set_owner drivers/vhost/net.c:1697 [inline]
> >  vhost_net_ioctl+0x426/0x1c00 drivers/vhost/net.c:1754
> >  vfs_ioctl fs/ioctl.c:46 [inline]
> >  file_ioctl fs/ioctl.c:509 [inline]
> >  do_vfs_ioctl+0x107b/0x17d0 fs/ioctl.c:696
> >  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
> >  __do_sys_ioctl fs/ioctl.c:720 [inline]
> >  __se_sys_ioctl fs/ioctl.c:718 [inline]
> >  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
> >  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x458099
> > Code: Bad RIP value.
> > RSP: 002b:00007efd7ca7ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458099
> > RDX: 0000000000000000 RSI: 000040010000af01 RDI: 0000000000000003
> > RBP: 000000000073c040 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007efd7ca7b6d4
> > R13: 00000000004c33a4 R14: 00000000004d5e80 R15: 00000000ffffffff
> >
> > Showing all locks held in the system:
> > 1 lock held by khungtaskd/1040:
> >  #0: 00000000b7479fbe (rcu_read_lock){....}, at:
> > debug_show_all_locks+0xc6/0x41d kernel/locking/lockdep.c:4389
> > 1 lock held by rsyslogd/8285:
> >  #0: 000000006d9ccf7d (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1b3/0x1f0
> > fs/file.c:795
> > 2 locks held by getty/8406:
> >  #0: 00000000052e805b (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40
> > drivers/tty/tty_ldsem.c:341
> >  #1: 00000000b90dc267 (&ldata->atomic_read_lock){+.+.}, at:
> > n_tty_read+0x30a/0x1eb0 drivers/tty/n_tty.c:2154
> > 2 locks held by getty/8407:
> >  #0: 000000009fdef632 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40
> > drivers/tty/tty_ldsem.c:341
> >  #1: 00000000ff2b1a16 (&ldata->atomic_read_lock){+.+.}, at:
> > n_tty_read+0x30a/0x1eb0 drivers/tty/n_tty.c:2154
> > 2 locks held by getty/8408:
> >  #0: 00000000e48a8e78 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40
> > drivers/tty/tty_ldsem.c:341
> >  #1: 000000008fcf2060 (&ldata->atomic_read_lock){+.+.}, at:
> > n_tty_read+0x30a/0x1eb0 drivers/tty/n_tty.c:2154
> > 2 locks held by getty/8409:
> >  #0: 0000000063f3f4f5 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40
> > drivers/tty/tty_ldsem.c:341
> >  #1: 000000001dc973ca (&ldata->atomic_read_lock){+.+.}, at:
> > n_tty_read+0x30a/0x1eb0 drivers/tty/n_tty.c:2154
> > 2 locks held by getty/8410:
> >  #0: 00000000f3c14150 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40
> > drivers/tty/tty_ldsem.c:341
> >  #1: 000000007987cec5 (&ldata->atomic_read_lock){+.+.}, at:
> > n_tty_read+0x30a/0x1eb0 drivers/tty/n_tty.c:2154
> > 2 locks held by getty/8411:
> >  #0: 00000000d04f4305 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40
> > drivers/tty/tty_ldsem.c:341
> >  #1: 000000003f47e3a6 (&ldata->atomic_read_lock){+.+.}, at:
> > n_tty_read+0x30a/0x1eb0 drivers/tty/n_tty.c:2154
> > 2 locks held by getty/8412:
> >  #0: 0000000082430560 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40
> > drivers/tty/tty_ldsem.c:341
> >  #1: 0000000094609d81 (&ldata->atomic_read_lock){+.+.}, at:
> > n_tty_read+0x30a/0x1eb0 drivers/tty/n_tty.c:2154
> > 2 locks held by syz-executor5/9417:
> >  #0: 0000000020a0f0a1 (&dev->mutex#4){+.+.}, at: vhost_net_set_features
> > drivers/vhost/net.c:1668 [inline]
> >  #0: 0000000020a0f0a1 (&dev->mutex#4){+.+.}, at:
> > vhost_net_ioctl+0x204/0x1c00 drivers/vhost/net.c:1739
> >  #1: 00000000a7b5872b (&vq->mutex){+.+.}, at:
> > vhost_init_device_iotlb+0x124/0x280 drivers/vhost/vhost.c:1606
> > 1 lock held by syz-executor5/9418:
> >  #0: 0000000020a0f0a1 (&dev->mutex#4){+.+.}, at: vhost_net_set_owner
> > drivers/vhost/net.c:1697 [inline]
> >  #0: 0000000020a0f0a1 (&dev->mutex#4){+.+.}, at:
> > vhost_net_ioctl+0x426/0x1c00 drivers/vhost/net.c:1754
> > 1 lock held by vhost-9408/9413:
> >
> > =============================================
> >
> > NMI backtrace for cpu 0
> > CPU: 0 PID: 1040 Comm: khungtaskd Not tainted 5.0.0-rc3+ #48
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
> >  nmi_cpu_backtrace.cold+0x63/0xa4 lib/nmi_backtrace.c:101
> >  nmi_trigger_cpumask_backtrace+0x1be/0x236 lib/nmi_backtrace.c:62
> >  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
> >  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
> >  check_hung_uninterruptible_tasks kernel/hung_task.c:203 [inline]
> >  watchdog+0xbbb/0x1170 kernel/hung_task.c:287
> >  kthread+0x357/0x430 kernel/kthread.c:246
> >  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
> > Sending NMI from CPU 0 to CPUs 1:
> > NMI backtrace for cpu 1
> > CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 5.0.0-rc3+ #48
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Workqueue: bat_events batadv_nc_worker
> > RIP: 0010:__sanitizer_cov_trace_const_cmp1+0x15/0x20 kernel/kcov.c:174
> > Code: 00 48 89 e5 48 8b 4d 08 e8 18 ff ff ff 5d c3 66 0f 1f 44 00 00 55 40
> > 0f b6 d6 40 0f b6 f7 bf 01 00 00 00 48 89 e5 48 8b 4d 08 <e8> f6 fe ff ff 5d
> > c3 0f 1f 40 00 55 0f b7 d6 0f b7 f7 bf 03 00 00
> > RSP: 0018:ffff8880a947f8a8 EFLAGS: 00000246
> > RAX: ffff8880a94701c0 RBX: ffff8880a05efc40 RCX: ffffffff87d36c97
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
> > RBP: ffff8880a947f8a8 R08: ffff8880a94701c0 R09: ffffed1015ce5b90
> > R10: ffffed1015ce5b8f R11: ffff8880ae72dc7b R12: 0000000000000000
> > R13: 0000000000000000 R14: 000000000000019e R15: dffffc0000000000
> > FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffffffffff600400 CR3: 00000000a005a000 CR4: 00000000001426e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  rcu_read_unlock include/linux/rcupdate.h:657 [inline]
> >  batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:423 [inline]
> >  batadv_nc_worker+0x2f7/0x920 net/batman-adv/network-coding.c:730
> >  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
> >  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
> >  kthread+0x357/0x430 kernel/kthread.c:246
> >  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> > syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20190129105957-mutt-send-email-mst%40kernel.org.
> For more options, visit https://groups.google.com/d/optout.
