Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1661C65C14
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFD820657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIaY2WQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfARUS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:18:56 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54055 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729340AbfARUS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 15:18:56 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so8536203ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 12:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XkF7gVDF25Qld0fbNrCYfXYzpd5m2RmH8NMredly944=;
        b=BIaY2WQyyzl6f/Sx1X7ve1if9C5b5B9cZSeaMeyuGPyvlCd37FXrZJquf2uDifcF3f
         JqxnNnkxMa0sENUGoVXQGxCrio+Hhsu8+zZxCTeLfVs7e1OnlbPJ/jviQb8l5+fJgpqg
         DucnfRHLZ+nnX3PPiQ0C1GFP7k+maWZ/PNi2sp1DhAhHumLD+Fj/xaVUwhoosQbJLO2V
         EcmiLJ+Gwn2XPckZzF4UQGPP8P3h3+flxnT2t35PS3waVQ8Cx1rA/+1/vVy1A4mfHHFm
         YYnbreFoq8xhm+XGUc8GtGtJCSOWPxlQw1Rn0wiPozm3YektYGkEirTM30+RAnHHW4aO
         0aFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XkF7gVDF25Qld0fbNrCYfXYzpd5m2RmH8NMredly944=;
        b=g3FBa9B0vBi2fIOS0F+mM+0jINnscfeKffqw6tGfflwTn2fPJeyoHLlhpsxLuvmI2w
         La+nxDMra8OHsjCwVrFUQ/fz/JUww/+AcDEM6ks+GeXUyqQ/+YGin1mC0x+OpU9lOTq9
         kgeBHNetonoRXP6Rg54SmuzhSkDrM7x3BcbdUq7WHLApRn9VuR/EnHsx0YLvlOMdP6a6
         uIf2tAaMWXTaiw7Ci9W43P4/PDEkWvN5ZEtaTNC1pslIfUXb27zaLgBPsHmi8pqWfaiz
         CuIAhIk43PwxUumTZDsNLXGeppGfsErGcYBzYBKzqoDFsfose/LOpplmQbVxSw5suu3b
         Rxfg==
X-Gm-Message-State: AJcUuke7yqOT07+0hrpBdSRFHThDQmnlM5DLLZYOtbZ6wDPHOLpqU2GF
        LIW/QN4kXQQ7llTL6nIOiMK0idjIqjGuLZWVNpI=
X-Google-Smtp-Source: ALg8bN7s35/z2ElY65EctfrZH5gOG6PcNJ/gjUx+rw27uwxpIo/mZI52uKKIB6ehxSuPVXcsnc194DeLccGGthLegbc=
X-Received: by 2002:a24:eb0f:: with SMTP id h15mr12150833itj.138.1547842733827;
 Fri, 18 Jan 2019 12:18:53 -0800 (PST)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Fri, 18 Jan 2019 15:18:42 -0500
Message-ID: <CAEAjamtqMwYxdm6ZM3ZchUaga=xht4yWP8=LaUaDj6nbQWFGjA@mail.gmail.com>
Subject: INFO: task hung in drop_inmem_page
To:     jaegeuk@kernel.org, yuchao0@huawei.com
Cc:     Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm reporting a bug in linux-4.17.19: "INFO: task hung in
drop_inmem_page" (no reproducer)

I think this might be somehow related to the following:
https://groups.google.com/forum/#!searchin/syzkaller-bugs/INFO$3A$20task$20hung$20in$20%7Csort:date/syzkaller-bugs/c6soBTrdaIo/AjAzPeIzCgAJ

=========================================
INFO: task syz-executor7:10822 blocked for more than 120 seconds.
      Not tainted 4.17.19 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor7   D27024 10822   6346 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:2867 [inline]
 __schedule+0x721/0x1e60 kernel/sched/core.c:3515
 schedule+0x88/0x1c0 kernel/sched/core.c:3559
 schedule_preempt_disabled+0x18/0x30 kernel/sched/core.c:3617
 __mutex_lock_common kernel/locking/mutex.c:833 [inline]
 __mutex_lock+0x5bd/0x1410 kernel/locking/mutex.c:893
 mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:908
 drop_inmem_page+0xcb/0x810 fs/f2fs/segment.c:327
 f2fs_invalidate_page+0x337/0x5e0 fs/f2fs/data.c:2401
 do_invalidatepage mm/truncate.c:165 [inline]
 truncate_cleanup_page+0x261/0x330 mm/truncate.c:187
 truncate_inode_pages_range+0x552/0x1610 mm/truncate.c:367
 truncate_inode_pages mm/truncate.c:478 [inline]
 truncate_pagecache+0x6d/0x90 mm/truncate.c:801
 truncate_setsize+0x81/0xa0 mm/truncate.c:826
 f2fs_setattr+0x44f/0x1270 fs/f2fs/file.c:781
 notify_change+0xa62/0xe80 fs/attr.c:313
 do_truncate+0x12e/0x1e0 fs/open.c:63
 do_last fs/namei.c:2955 [inline]
 path_openat+0x2042/0x29f0 fs/namei.c:3505
 do_filp_open+0x1bd/0x2c0 fs/namei.c:3540
 do_sys_open+0x35e/0x4e0 fs/open.c:1101
 __do_sys_open fs/open.c:1119 [inline]
 __se_sys_open fs/open.c:1114 [inline]
 __x64_sys_open+0x89/0xc0 fs/open.c:1114
 do_syscall_64+0xc4/0x4e0 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
RSP: 002b:00007f734e459c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f734e45a6cc RCX: 00000000004497b9
RDX: 0000000000000104 RSI: 00000000000a8280 RDI: 0000000020000080
RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000007230 R14: 00000000006f02d0 R15: 00007f734e45a700
INFO: task syz-executor7:10858 blocked for more than 120 seconds.
      Not tainted 4.17.19 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor7   D28880 10858   6346 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:2867 [inline]
 __schedule+0x721/0x1e60 kernel/sched/core.c:3515
 schedule+0x88/0x1c0 kernel/sched/core.c:3559
 __rwsem_down_write_failed_common kernel/locking/rwsem-xadd.c:565 [inline]
 rwsem_down_write_failed+0x5e6/0xc90 kernel/locking/rwsem-xadd.c:594
 call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
 __down_write arch/x86/include/asm/rwsem.h:142 [inline]
 down_write+0x58/0xa0 kernel/locking/rwsem.c:72
 inode_lock include/linux/fs.h:713 [inline]
 do_truncate+0x120/0x1e0 fs/open.c:61
 do_last fs/namei.c:2955 [inline]
 path_openat+0x2042/0x29f0 fs/namei.c:3505
 do_filp_open+0x1bd/0x2c0 fs/namei.c:3540
 do_sys_open+0x35e/0x4e0 fs/open.c:1101
 __do_sys_open fs/open.c:1119 [inline]
 __se_sys_open fs/open.c:1114 [inline]
 __x64_sys_open+0x89/0xc0 fs/open.c:1114
 do_syscall_64+0xc4/0x4e0 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
RSP: 002b:00007f734e3b4c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f734e3b56cc RCX: 00000000004497b9
RDX: 0000000000000104 RSI: 00000000000a8280 RDI: 0000000020000080
RBP: 000000000071c238 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000007230 R14: 00000000006f02d0 R15: 00007f734e3b5700
INFO: task syz-executor5:10829 blocked for more than 120 seconds.
      Not tainted 4.17.19 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor5   D28760 10829   6308 0x80000002
Call Trace:
 context_switch kernel/sched/core.c:2867 [inline]
 __schedule+0x721/0x1e60 kernel/sched/core.c:3515
 schedule+0x88/0x1c0 kernel/sched/core.c:3559
 io_schedule+0x21/0x80 kernel/sched/core.c:5179
 wait_on_page_bit_common mm/filemap.c:1100 [inline]
 __lock_page+0x2b5/0x390 mm/filemap.c:1273
 lock_page include/linux/pagemap.h:483 [inline]
 __revoke_inmem_pages+0xb35/0x11c0 fs/f2fs/segment.c:231
 drop_inmem_pages+0xa3/0x3e0 fs/f2fs/segment.c:306
 f2fs_release_file+0x2c7/0x330 fs/f2fs/file.c:1556
 __fput+0x2c7/0x780 fs/file_table.c:209
 ____fput+0x1a/0x20 fs/file_table.c:243
 task_work_run+0x151/0x1d0 kernel/task_work.c:113
 exit_task_work include/linux/task_work.h:22 [inline]
 do_exit+0x8ba/0x30a0 kernel/exit.c:865
 do_group_exit+0x13b/0x3a0 kernel/exit.c:968
 get_signal+0x6bb/0x1650 kernel/signal.c:2482
 do_signal+0x84/0x1b70 arch/x86/kernel/signal.c:810
 exit_to_usermode_loop+0x155/0x190 arch/x86/entry/common.c:162
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
 do_syscall_64+0x445/0x4e0 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
RSP: 002b:00007f1c68e74ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000071bf80 RCX: 00000000004497b9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000071bf80
RBP: 000000000071bf80 R08: 0000000000000000 R09: 000000000071bf58
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f1c68e759c0 R15: 00007f1c68e75700

Showing all locks held in the system:
1 lock held by khungtaskd/1715:
 #0: 00000000aeb8cd00 (tasklist_lock){.+.+}, at:
debug_show_all_locks+0x7c/0x2b0 kernel/locking/lockdep.c:4470
2 locks held by getty/6180:
 #0: 000000009ffda690 (&tty->ldisc_sem){++++}, at:
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
 #1: 00000000405232cd (&ldata->atomic_read_lock){+.+.}, at:
n_tty_read+0x20a/0x1860 drivers/tty/n_tty.c:2140
2 locks held by getty/6181:
 #0: 0000000084ba3035 (&tty->ldisc_sem){++++}, at:
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
 #1: 0000000071a219d9 (&ldata->atomic_read_lock){+.+.}, at:
n_tty_read+0x20a/0x1860 drivers/tty/n_tty.c:2140
2 locks held by getty/6182:
 #0: 00000000477179e0 (&tty->ldisc_sem){++++}, at:
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
 #1: 00000000be4fe263 (&ldata->atomic_read_lock){+.+.}, at:
n_tty_read+0x20a/0x1860 drivers/tty/n_tty.c:2140
2 locks held by getty/6183:
 #0: 00000000b3d05924 (&tty->ldisc_sem){++++}, at:
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
 #1: 0000000020e3b19b (&ldata->atomic_read_lock){+.+.}, at:
n_tty_read+0x20a/0x1860 drivers/tty/n_tty.c:2140
2 locks held by getty/6184:
 #0: 0000000049b0e21f (&tty->ldisc_sem){++++}, at:
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
 #1: 000000003929ab1b (&ldata->atomic_read_lock){+.+.}, at:
n_tty_read+0x20a/0x1860 drivers/tty/n_tty.c:2140
2 locks held by getty/6185:
 #0: 00000000c90895c5 (&tty->ldisc_sem){++++}, at:
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
 #1: 00000000896e1fe7 (&ldata->atomic_read_lock){+.+.}, at:
n_tty_read+0x20a/0x1860 drivers/tty/n_tty.c:2140
2 locks held by getty/6186:
 #0: 00000000eb674307 (&tty->ldisc_sem){++++}, at:
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
 #1: 00000000fa43aebb (&ldata->atomic_read_lock){+.+.}, at:
n_tty_read+0x20a/0x1860 drivers/tty/n_tty.c:2140
4 locks held by syz-executor7/10822:
 #0: 000000006dfdd6d5 (sb_writers#8){.+.+}, at: sb_start_write
include/linux/fs.h:1550 [inline]
 #0: 000000006dfdd6d5 (sb_writers#8){.+.+}, at:
mnt_want_write+0x46/0xc0 fs/namespace.c:386
 #1: 00000000dc29e189 (&sb->s_type->i_mutex_key#16){+.+.}, at:
inode_lock include/linux/fs.h:713 [inline]
 #1: 00000000dc29e189 (&sb->s_type->i_mutex_key#16){+.+.}, at:
do_truncate+0x120/0x1e0 fs/open.c:61
 #2: 000000001b235d12 (&fi->i_mmap_sem){+.+.}, at:
f2fs_setattr+0x421/0x1270 fs/f2fs/file.c:780
 #3: 000000004a9caf7f (&fi->inmem_lock){+.+.}, at:
drop_inmem_page+0xcb/0x810 fs/f2fs/segment.c:327
2 locks held by syz-executor7/10858:
 #0: 000000006dfdd6d5 (sb_writers#8){.+.+}, at: sb_start_write
include/linux/fs.h:1550 [inline]
 #0: 000000006dfdd6d5 (sb_writers#8){.+.+}, at:
mnt_want_write+0x46/0xc0 fs/namespace.c:386
 #1: 00000000dc29e189 (&sb->s_type->i_mutex_key#16){+.+.}, at:
inode_lock include/linux/fs.h:713 [inline]
 #1: 00000000dc29e189 (&sb->s_type->i_mutex_key#16){+.+.}, at:
do_truncate+0x120/0x1e0 fs/open.c:61
1 lock held by syz-executor5/10829:
 #0: 000000004a9caf7f (&fi->inmem_lock){+.+.}, at:
drop_inmem_pages+0x86/0x3e0 fs/f2fs/segment.c:305
2 locks held by syz-executor5/10893:
 #0: 000000006dfdd6d5 (sb_writers#8){.+.+}, at: sb_start_write
include/linux/fs.h:1550 [inline]
 #0: 000000006dfdd6d5 (sb_writers#8){.+.+}, at:
mnt_want_write_file+0x12a/0x340 fs/namespace.c:497
 #1: 00000000dc29e189 (&sb->s_type->i_mutex_key#16){+.+.}, at:
inode_lock include/linux/fs.h:713 [inline]
 #1: 00000000dc29e189 (&sb->s_type->i_mutex_key#16){+.+.}, at:
f2fs_ioc_start_atomic_write fs/f2fs/file.c:1671 [inline]
 #1: 00000000dc29e189 (&sb->s_type->i_mutex_key#16){+.+.}, at:
f2fs_ioctl+0x101b/0x6c50 fs/f2fs/file.c:2853
3 locks held by syz-executor5/10894:
 #0: 000000001e9f4016 (&f->f_pos_lock){+.+.}, at:
__fdget_pos+0xd6/0x100 fs/file.c:766
 #1: 000000006dfdd6d5 (sb_writers#8){.+.+}, at: file_start_write
include/linux/fs.h:2719 [inline]
 #1: 000000006dfdd6d5 (sb_writers#8){.+.+}, at: vfs_write+0x469/0x570
fs/read_write.c:548
 #2: 00000000dc29e189 (&sb->s_type->i_mutex_key#16){+.+.}, at:
inode_lock include/linux/fs.h:713 [inline]
 #2: 00000000dc29e189 (&sb->s_type->i_mutex_key#16){+.+.}, at:
f2fs_file_write_iter+0x27a/0xcd0 fs/f2fs/file.c:2917
1 lock held by syz-executor5/10895:
 #0: 000000001e9f4016 (&f->f_pos_lock){+.+.}, at:
__fdget_pos+0xd6/0x100 fs/file.c:766
2 locks held by syz-executor5/10896:
 #0: 000000006dfdd6d5 (sb_writers#8){.+.+}, at: sb_start_write
include/linux/fs.h:1550 [inline]
 #0: 000000006dfdd6d5 (sb_writers#8){.+.+}, at:
mnt_want_write_file+0x12a/0x340 fs/namespace.c:497
 #1: 00000000dc29e189 (&sb->s_type->i_mutex_key#16){+.+.}, at:
inode_lock include/linux/fs.h:713 [inline]
 #1: 00000000dc29e189 (&sb->s_type->i_mutex_key#16){+.+.}, at:
f2fs_ioc_start_atomic_write fs/f2fs/file.c:1671 [inline]
 #1: 00000000dc29e189 (&sb->s_type->i_mutex_key#16){+.+.}, at:
f2fs_ioctl+0x101b/0x6c50 fs/f2fs/file.c:2853
3 locks held by syz-executor5/10897:
 #0: 00000000b6b59b71 (&f->f_pos_lock){+.+.}, at:
__fdget_pos+0xd6/0x100 fs/file.c:766
 #1: 000000006dfdd6d5 (sb_writers#8){.+.+}, at: file_start_write
include/linux/fs.h:2719 [inline]
 #1: 000000006dfdd6d5 (sb_writers#8){.+.+}, at: vfs_write+0x469/0x570
fs/read_write.c:548
 #2: 00000000dc29e189 (&sb->s_type->i_mutex_key#16){+.+.}, at:
inode_lock include/linux/fs.h:713 [inline]
 #2: 00000000dc29e189 (&sb->s_type->i_mutex_key#16){+.+.}, at:
f2fs_file_write_iter+0x27a/0xcd0 fs/f2fs/file.c:2917
1 lock held by syz-executor5/10898:
 #0: 00000000b6b59b71 (&f->f_pos_lock){+.+.}, at:
__fdget_pos+0xd6/0x100 fs/file.c:766

=========================================

Thanks,
Kyungtae Kim
