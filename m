Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9953DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1F12175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfA2QF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:05:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfA2QF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:05:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 258828B104;
        Tue, 29 Jan 2019 16:05:58 +0000 (UTC)
Received: from redhat.com (ovpn-123-79.rdu2.redhat.com [10.10.123.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2B1465D6A6;
        Tue, 29 Jan 2019 16:05:57 +0000 (UTC)
Date:   Tue, 29 Jan 2019 11:05:51 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     syzbot <syzbot+40e28a8bd59d10ed0c42@syzkaller.appspotmail.com>
Cc:     jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
Subject: Re: INFO: task hung in vhost_init_device_iotlb
Message-ID: <20190129105957-mutt-send-email-mst@kernel.org>
References: <0000000000007e86fd058095533f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007e86fd058095533f@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 29 Jan 2019 16:05:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 01:22:02AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    983542434e6b Merge tag 'edac_fix_for_5.0' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17476498c00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=505743eba4e4f68
> dashboard link: https://syzkaller.appspot.com/bug?extid=40e28a8bd59d10ed0c42
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.

Hmm nothing obvious below. Generic corruption elsewhere?

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+40e28a8bd59d10ed0c42@syzkaller.appspotmail.com
> 
> protocol 88fb is buggy, dev hsr_slave_1
> protocol 88fb is buggy, dev hsr_slave_0
> protocol 88fb is buggy, dev hsr_slave_1
> protocol 88fb is buggy, dev hsr_slave_0
> protocol 88fb is buggy, dev hsr_slave_1
> INFO: task syz-executor5:9417 blocked for more than 140 seconds.
>       Not tainted 5.0.0-rc3+ #48
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> syz-executor5   D27576  9417   8469 0x00000004
> Call Trace:
>  context_switch kernel/sched/core.c:2831 [inline]
>  __schedule+0x897/0x1e60 kernel/sched/core.c:3472
>  schedule+0xfe/0x350 kernel/sched/core.c:3516
> protocol 88fb is buggy, dev hsr_slave_0
> protocol 88fb is buggy, dev hsr_slave_1
>  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3574
>  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
>  __mutex_lock+0xa3b/0x1670 kernel/locking/mutex.c:1072
>  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
>  vhost_init_device_iotlb+0x124/0x280 drivers/vhost/vhost.c:1606
>  vhost_net_set_features drivers/vhost/net.c:1674 [inline]
>  vhost_net_ioctl+0x1282/0x1c00 drivers/vhost/net.c:1739
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:509 [inline]
>  do_vfs_ioctl+0x107b/0x17d0 fs/ioctl.c:696
>  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
>  __do_sys_ioctl fs/ioctl.c:720 [inline]
>  __se_sys_ioctl fs/ioctl.c:718 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
>  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
> protocol 88fb is buggy, dev hsr_slave_0
> protocol 88fb is buggy, dev hsr_slave_1
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x458099
> Code: Bad RIP value.
> RSP: 002b:00007efd7ca9bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458099
> RDX: 0000000020000080 RSI: 000000004008af00 RDI: 0000000000000003
> RBP: 000000000073bfa0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007efd7ca9c6d4
> R13: 00000000004c295b R14: 00000000004d5280 R15: 00000000ffffffff
> INFO: task syz-executor5:9418 blocked for more than 140 seconds.
>       Not tainted 5.0.0-rc3+ #48
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> syz-executor5   D27800  9418   8469 0x00000004
> Call Trace:
>  context_switch kernel/sched/core.c:2831 [inline]
>  __schedule+0x897/0x1e60 kernel/sched/core.c:3472
>  schedule+0xfe/0x350 kernel/sched/core.c:3516
>  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3574
>  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
>  __mutex_lock+0xa3b/0x1670 kernel/locking/mutex.c:1072
>  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
>  vhost_net_set_owner drivers/vhost/net.c:1697 [inline]
>  vhost_net_ioctl+0x426/0x1c00 drivers/vhost/net.c:1754
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:509 [inline]
>  do_vfs_ioctl+0x107b/0x17d0 fs/ioctl.c:696
>  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
>  __do_sys_ioctl fs/ioctl.c:720 [inline]
>  __se_sys_ioctl fs/ioctl.c:718 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
>  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x458099
> Code: Bad RIP value.
> RSP: 002b:00007efd7ca7ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458099
> RDX: 0000000000000000 RSI: 000040010000af01 RDI: 0000000000000003
> RBP: 000000000073c040 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007efd7ca7b6d4
> R13: 00000000004c33a4 R14: 00000000004d5e80 R15: 00000000ffffffff
> 
> Showing all locks held in the system:
> 1 lock held by khungtaskd/1040:
>  #0: 00000000b7479fbe (rcu_read_lock){....}, at:
> debug_show_all_locks+0xc6/0x41d kernel/locking/lockdep.c:4389
> 1 lock held by rsyslogd/8285:
>  #0: 000000006d9ccf7d (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1b3/0x1f0
> fs/file.c:795
> 2 locks held by getty/8406:
>  #0: 00000000052e805b (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40
> drivers/tty/tty_ldsem.c:341
>  #1: 00000000b90dc267 (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x30a/0x1eb0 drivers/tty/n_tty.c:2154
> 2 locks held by getty/8407:
>  #0: 000000009fdef632 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40
> drivers/tty/tty_ldsem.c:341
>  #1: 00000000ff2b1a16 (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x30a/0x1eb0 drivers/tty/n_tty.c:2154
> 2 locks held by getty/8408:
>  #0: 00000000e48a8e78 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40
> drivers/tty/tty_ldsem.c:341
>  #1: 000000008fcf2060 (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x30a/0x1eb0 drivers/tty/n_tty.c:2154
> 2 locks held by getty/8409:
>  #0: 0000000063f3f4f5 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40
> drivers/tty/tty_ldsem.c:341
>  #1: 000000001dc973ca (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x30a/0x1eb0 drivers/tty/n_tty.c:2154
> 2 locks held by getty/8410:
>  #0: 00000000f3c14150 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40
> drivers/tty/tty_ldsem.c:341
>  #1: 000000007987cec5 (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x30a/0x1eb0 drivers/tty/n_tty.c:2154
> 2 locks held by getty/8411:
>  #0: 00000000d04f4305 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40
> drivers/tty/tty_ldsem.c:341
>  #1: 000000003f47e3a6 (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x30a/0x1eb0 drivers/tty/n_tty.c:2154
> 2 locks held by getty/8412:
>  #0: 0000000082430560 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40
> drivers/tty/tty_ldsem.c:341
>  #1: 0000000094609d81 (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x30a/0x1eb0 drivers/tty/n_tty.c:2154
> 2 locks held by syz-executor5/9417:
>  #0: 0000000020a0f0a1 (&dev->mutex#4){+.+.}, at: vhost_net_set_features
> drivers/vhost/net.c:1668 [inline]
>  #0: 0000000020a0f0a1 (&dev->mutex#4){+.+.}, at:
> vhost_net_ioctl+0x204/0x1c00 drivers/vhost/net.c:1739
>  #1: 00000000a7b5872b (&vq->mutex){+.+.}, at:
> vhost_init_device_iotlb+0x124/0x280 drivers/vhost/vhost.c:1606
> 1 lock held by syz-executor5/9418:
>  #0: 0000000020a0f0a1 (&dev->mutex#4){+.+.}, at: vhost_net_set_owner
> drivers/vhost/net.c:1697 [inline]
>  #0: 0000000020a0f0a1 (&dev->mutex#4){+.+.}, at:
> vhost_net_ioctl+0x426/0x1c00 drivers/vhost/net.c:1754
> 1 lock held by vhost-9408/9413:
> 
> =============================================
> 
> NMI backtrace for cpu 0
> CPU: 0 PID: 1040 Comm: khungtaskd Not tainted 5.0.0-rc3+ #48
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
>  nmi_cpu_backtrace.cold+0x63/0xa4 lib/nmi_backtrace.c:101
>  nmi_trigger_cpumask_backtrace+0x1be/0x236 lib/nmi_backtrace.c:62
>  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:203 [inline]
>  watchdog+0xbbb/0x1170 kernel/hung_task.c:287
>  kthread+0x357/0x430 kernel/kthread.c:246
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 5.0.0-rc3+ #48
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: bat_events batadv_nc_worker
> RIP: 0010:__sanitizer_cov_trace_const_cmp1+0x15/0x20 kernel/kcov.c:174
> Code: 00 48 89 e5 48 8b 4d 08 e8 18 ff ff ff 5d c3 66 0f 1f 44 00 00 55 40
> 0f b6 d6 40 0f b6 f7 bf 01 00 00 00 48 89 e5 48 8b 4d 08 <e8> f6 fe ff ff 5d
> c3 0f 1f 40 00 55 0f b7 d6 0f b7 f7 bf 03 00 00
> RSP: 0018:ffff8880a947f8a8 EFLAGS: 00000246
> RAX: ffff8880a94701c0 RBX: ffff8880a05efc40 RCX: ffffffff87d36c97
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
> RBP: ffff8880a947f8a8 R08: ffff8880a94701c0 R09: ffffed1015ce5b90
> R10: ffffed1015ce5b8f R11: ffff8880ae72dc7b R12: 0000000000000000
> R13: 0000000000000000 R14: 000000000000019e R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffff600400 CR3: 00000000a005a000 CR4: 00000000001426e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  rcu_read_unlock include/linux/rcupdate.h:657 [inline]
>  batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:423 [inline]
>  batadv_nc_worker+0x2f7/0x920 net/batman-adv/network-coding.c:730
>  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
>  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
>  kthread+0x357/0x430 kernel/kthread.c:246
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
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
