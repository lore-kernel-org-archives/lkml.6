Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AE5C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086BC2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN+WvYLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfBLBo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:44:27 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50904 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbfBLBo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 20:44:26 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so3402811iti.0;
        Mon, 11 Feb 2019 17:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=jviMN9mAtoYFRcMIefe3EiI1MvoCU8PQhzkLKstYdR4=;
        b=UN+WvYLeZG680YgeSCSagv2uPLtutQBkowj6PznQZ2v03pOURaPsyfa/dXkJKvf/Ks
         bbwblIgfWpMrhlz09vWaBZtUpRZ0hrvQ968EmRKVphrlezuAmFHgeJaVIzAI9a4Ghi+0
         m80f0W4hee1bpr1NkHm4fIaNTlhZq6UqYmiSHKUePtCdnP/Rb9Y17U5aqqSCFujvCGx/
         0Ub3PLc0dKIZKr2fQbCGRi+XBXhDqEqhd8JBHzYFzG6ORDOZRM0qfcth+WVT/D3Pu3uY
         59N37VYt4+kKeQyQCG5p/E8l3djEArzegQlAZZN19voVT9tLG1q4Qf2nIG2FvU4vpBHu
         O2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jviMN9mAtoYFRcMIefe3EiI1MvoCU8PQhzkLKstYdR4=;
        b=DH4eLAPSCpxaFckd3Hx3EySkXSxbYv6l0tvuczfUwV0QOI4ETeNUVMGNWufFOWHH9I
         Dsnq2OjljV7h+3mA0nIIUFn83WGgP09QXUynmyuwt0suRGsaUnsOGgCfJJbQXF7CuGc8
         Df/n8y9bPolrLp9RdpQISojZOs+6RwPAsWtgcKbzPK0IMSCMzKN1Fj7cf+g4kACx6xuS
         O3fKa8rWxJHj/DN3t16Fl6cpusLE5RnJxe6ISDQjezdTNKuPW4BH+lvGV3/cHR4Sopzw
         uGFlSYNJ4s19O1mPYvr4y4n4rBRDKZLhS9BJ8iaAT5HGwpgGvMLzTScukrXU7WDRqWL1
         d5jg==
X-Gm-Message-State: AHQUAuaWDIn/kE72tdgVQy9/yRqTe4r3O6gOuZg1YihA5um9SXzaeJWw
        jW/FzzjfIT6u81iekYSqA2cSZHowWjU8w4EJHsZKR0lnT/o=
X-Google-Smtp-Source: AHgI3IaXPcC0g7vd+cN6dquex9XzIjZh7ZpYrlLZMFMd5FcnH4xpcgU00uQu80nO2lxf9nICszcmHe1AOJcwfvF1Xgw=
X-Received: by 2002:a24:1306:: with SMTP id 6mr582508itz.69.1549935864850;
 Mon, 11 Feb 2019 17:44:24 -0800 (PST)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Mon, 11 Feb 2019 20:44:13 -0500
Message-ID: <CAEAjamumWXrLZCTkd+fataNw+k8oEWVk5g1ArvQt5eu=17s=Fw@mail.gmail.com>
Subject: INFO: task hung in reiserfs_sync_fs
To:     reiserfs-devel@vger.kernel.org
Cc:     Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm reporting a bug in linux-4.19.19: "INFO: task hung in reiserfs_sync_fs"
(no reproducer)

=========================================
INFO: task kworker/0:1:13513 blocked for more than 120 seconds.
      Not tainted 4.19.19 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/0:1     D27376 13513      2 0x80000000
Workqueue: events_long flush_old_commits
Call Trace:
 context_switch kernel/sched/core.c:2824 [inline]
 __schedule+0x809/0x2160 kernel/sched/core.c:3472
 schedule+0x88/0x1c0 kernel/sched/core.c:3516
 schedule_preempt_disabled+0x18/0x30 kernel/sched/core.c:3574
 __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
 __mutex_lock+0x50c/0x1330 kernel/locking/mutex.c:1072
 mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:1087
 reiserfs_write_lock+0x87/0x140 fs/reiserfs/lock.c:27
 reiserfs_sync_fs+0x77/0xf0 fs/reiserfs/super.c:76
 flush_old_commits+0x16d/0x210 fs/reiserfs/super.c:111
 process_one_work+0x9f7/0x1800 kernel/workqueue.c:2153
 worker_thread+0x8f/0xd20 kernel/workqueue.c:2296
 kthread+0x3a3/0x470 kernel/kthread.c:246
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
INFO: task syz-executor1:2786 blocked for more than 120 seconds.
      Not tainted 4.19.19 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor1   D27200  2786   6598 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:2824 [inline]
 __schedule+0x809/0x2160 kernel/sched/core.c:3472
 schedule+0x88/0x1c0 kernel/sched/core.c:3516
 schedule_preempt_disabled+0x18/0x30 kernel/sched/core.c:3574
 __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
 __mutex_lock+0x50c/0x1330 kernel/locking/mutex.c:1072
 mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:1087
 reiserfs_write_lock+0x87/0x140 fs/reiserfs/lock.c:27
 reiserfs_get_block+0x22c/0x45d0 fs/reiserfs/inode.c:688
 do_mpage_readpage+0x586/0x23b0 fs/mpage.c:231
 mpage_readpages+0x412/0x5a0 fs/mpage.c:404
 reiserfs_readpages+0x31/0x40 fs/reiserfs/inode.c:1167
 read_pages+0x117/0x5a0 mm/readahead.c:123
 __do_page_cache_readahead+0x503/0x660 mm/readahead.c:211
 ra_submit mm/internal.h:66 [inline]
 ondemand_readahead+0x465/0xd90 mm/readahead.c:493
 page_cache_sync_readahead+0xcd/0x120 mm/readahead.c:528
 generic_file_buffered_read mm/filemap.c:2092 [inline]
 generic_file_read_iter+0x162b/0x2520 mm/filemap.c:2362
 call_read_iter include/linux/fs.h:1805 [inline]
 new_sync_read fs/read_write.c:406 [inline]
 __vfs_read+0x535/0x6d0 fs/read_write.c:418
 vfs_read+0x139/0x370 fs/read_write.c:452
 ksys_read+0xde/0x1c0 fs/read_write.c:578
 __do_sys_read fs/read_write.c:588 [inline]
 __se_sys_read fs/read_write.c:586 [inline]
 __x64_sys_read+0x7e/0xc0 fs/read_write.c:586
 do_syscall_64+0xc4/0x510 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
Code: 72 20 6c 69 6e 65 20 73 75 63 63 65 73 73 66 75 6c 6c 79 20 70
72 6f 63 65 73 73 65 64 0a 00 50 72 6f 63 65 73 73 69 6e 67 20 <6e> 65
78 74 20 61 63 74 69 6f 6e 0a 00 54 52 55 45 00 46 41 4c 53
RSP: 002b:00007f632463ac68 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f632463b6cc RCX: 00000000004497b9
RDX: 000000000000008c RSI: 0000000020000100 RDI: 0000000000000014
RBP: 000000000071bf58 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000008298 R14: 00000000006f1338 R15: 00007f632463b700
INFO: task syz-executor4:2784 blocked for more than 120 seconds.
      Not tainted 4.19.19 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor4   D27712  2784   6606 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:2824 [inline]
 __schedule+0x809/0x2160 kernel/sched/core.c:3472
 schedule+0x88/0x1c0 kernel/sched/core.c:3516
 io_schedule+0x21/0x80 kernel/sched/core.c:5139
 wait_on_page_bit_common mm/filemap.c:1100 [inline]
 __lock_page+0x2d2/0x3b0 mm/filemap.c:1273
 lock_page include/linux/pagemap.h:483 [inline]
 pagecache_get_page+0x4b3/0x870 mm/filemap.c:1554
 find_or_create_page include/linux/pagemap.h:322 [inline]
 grab_cache_page include/linux/pagemap.h:388 [inline]
 grab_tail_page fs/reiserfs/inode.c:2206 [inline]
 reiserfs_truncate_file+0x3fa/0xe60 fs/reiserfs/inode.c:2274
 reiserfs_vfs_truncate_file+0x37/0x50 fs/reiserfs/file.c:139
 reiserfs_direct_IO+0x205/0x270 fs/reiserfs/inode.c:3275
 generic_file_direct_write+0x20d/0x4a0 mm/filemap.c:3042
 __generic_file_write_iter+0x244/0x6c0 mm/filemap.c:3221
 generic_file_write_iter+0x31e/0x6e0 mm/filemap.c:3292
 call_write_iter include/linux/fs.h:1811 [inline]
 new_sync_write fs/read_write.c:474 [inline]
 __vfs_write+0x538/0x6e0 fs/read_write.c:487
 vfs_write+0x1b3/0x520 fs/read_write.c:549
 ksys_write+0xde/0x1c0 fs/read_write.c:598
 __do_sys_write fs/read_write.c:610 [inline]
 __se_sys_write fs/read_write.c:607 [inline]
 __x64_sys_write+0x7e/0xc0 fs/read_write.c:607
 do_syscall_64+0xc4/0x510 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
Code: 72 20 6c 69 6e 65 20 73 75 63 63 65 73 73 66 75 6c 6c 79 20 70
72 6f 63 65 73 73 65 64 0a 00 50 72 6f 63 65 73 73 69 6e 67 20 <6e> 65
78 74 20 61 63 74 69 6f 6e 0a 00 54 52 55 45 00 46 41 4c 53
RSP: 002b:00007f9063a4fc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f9063a506cc RCX: 00000000004497b9
RDX: 000000000000001e RSI: 0000000020002400 RDI: 0000000000000014
RBP: 000000000071bf58 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000bda8 R14: 00000000006f4e48 R15: 00007f9063a50700

Showing all locks held in the system:
1 lock held by khungtaskd/1847:
 #0: 000000004cfccd54 (rcu_read_lock){....}, at:
debug_show_all_locks+0x5c/0x350 kernel/locking/lockdep.c:4433
1 lock held by rsyslogd/6361:
 #0: 0000000056b818c6 (&f->f_pos_lock){+.+.}, at:
__fdget_pos+0xd6/0x100 fs/file.c:766
2 locks held by getty/6453:
 #0: 00000000903a8664 (&tty->ldisc_sem){++++}, at:
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:363
 #1: 00000000697dee47 (&ldata->atomic_read_lock){+.+.}, at:
n_tty_read+0x20a/0x19e0 drivers/tty/n_tty.c:2154
2 locks held by getty/6454:
 #0: 0000000010b79e14 (&tty->ldisc_sem){++++}, at:
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:363
 #1: 00000000f9107645 (&ldata->atomic_read_lock){+.+.}, at:
n_tty_read+0x20a/0x19e0 drivers/tty/n_tty.c:2154
2 locks held by getty/6455:
 #0: 0000000080e8b82e (&tty->ldisc_sem){++++}, at:
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:363
 #1: 00000000217d9bd2 (&ldata->atomic_read_lock){+.+.}, at:
n_tty_read+0x20a/0x19e0 drivers/tty/n_tty.c:2154
2 locks held by getty/6456:
 #0: 00000000a53d12ec (&tty->ldisc_sem){++++}, at:
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:363
 #1: 0000000093e4d8c1 (&ldata->atomic_read_lock){+.+.}, at:
n_tty_read+0x20a/0x19e0 drivers/tty/n_tty.c:2154
2 locks held by getty/6457:
 #0: 00000000a1e7395b (&tty->ldisc_sem){++++}, at:
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:363
 #1: 000000001a2357cd (&ldata->atomic_read_lock){+.+.}, at:
n_tty_read+0x20a/0x19e0 drivers/tty/n_tty.c:2154
2 locks held by getty/6458:
 #0: 0000000048073f4a (&tty->ldisc_sem){++++}, at:
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:363
 #1: 000000005b6e2c95 (&ldata->atomic_read_lock){+.+.}, at:
n_tty_read+0x20a/0x19e0 drivers/tty/n_tty.c:2154
2 locks held by getty/6459:
 #0: 00000000be696ff9 (&tty->ldisc_sem){++++}, at:
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:363
 #1: 00000000947c2146 (&ldata->atomic_read_lock){+.+.}, at:
n_tty_read+0x20a/0x19e0 drivers/tty/n_tty.c:2154
4 locks held by kworker/0:1/13513:
 #0: 00000000c7a968a8 ((wq_completion)"events_long"){+.+.}, at:
__write_once_size include/linux/compiler.h:215 [inline]
 #0: 00000000c7a968a8 ((wq_completion)"events_long"){+.+.}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: 00000000c7a968a8 ((wq_completion)"events_long"){+.+.}, at:
atomic64_set include/asm-generic/atomic-instrumented.h:40 [inline]
 #0: 00000000c7a968a8 ((wq_completion)"events_long"){+.+.}, at:
atomic_long_set include/asm-generic/atomic-long.h:59 [inline]
 #0: 00000000c7a968a8 ((wq_completion)"events_long"){+.+.}, at:
set_work_data kernel/workqueue.c:617 [inline]
 #0: 00000000c7a968a8 ((wq_completion)"events_long"){+.+.}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
 #0: 00000000c7a968a8 ((wq_completion)"events_long"){+.+.}, at:
process_one_work+0x90a/0x1800 kernel/workqueue.c:2124
 #1: 0000000007d37b78
((work_completion)(&(&sbi->old_work)->work)){+.+.}, at:
process_one_work+0x941/0x1800 kernel/workqueue.c:2128
 #2: 00000000a67b6505 (&type->s_umount_key#41){.+.+}, at:
flush_old_commits+0x8a/0x210 fs/reiserfs/super.c:97
 #3: 000000005f1d7713 (&sbi->lock){+.+.}, at:
reiserfs_write_lock+0x87/0x140 fs/reiserfs/lock.c:27
2 locks held by syz-executor1/2786:
 #0: 00000000be156f84 (&f->f_pos_lock){+.+.}, at:
__fdget_pos+0xd6/0x100 fs/file.c:766
 #1: 000000005f1d7713 (&sbi->lock){+.+.}, at:
reiserfs_write_lock+0x87/0x140 fs/reiserfs/lock.c:27
5 locks held by syz-executor4/2784:
 #0: 000000005b4c5c72 (&f->f_pos_lock){+.+.}, at:
__fdget_pos+0xd6/0x100 fs/file.c:766
 #1: 0000000054b50e8f (sb_writers#12){.+.+}, at: file_start_write
include/linux/fs.h:2764 [inline]
 #1: 0000000054b50e8f (sb_writers#12){.+.+}, at: vfs_write+0x443/0x520
fs/read_write.c:548
 #2: 0000000063973fb8 (&sb->s_type->i_mutex_key#17){+.+.}, at:
inode_lock include/linux/fs.h:738 [inline]
 #2: 0000000063973fb8 (&sb->s_type->i_mutex_key#17){+.+.}, at:
generic_file_write_iter+0x9f/0x6e0 mm/filemap.c:3289
 #3: 00000000e8bc4bf8 (&ei->tailpack){+.+.}, at:
reiserfs_vfs_truncate_file+0x2a/0x50 fs/reiserfs/file.c:138
 #4: 000000005f1d7713 (&sbi->lock){+.+.}, at:
reiserfs_write_lock+0x87/0x140 fs/reiserfs/lock.c:27
=========================================

Thanks,
Kyungtae
