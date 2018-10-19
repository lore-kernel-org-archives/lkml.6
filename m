Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275A9C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3DB20C0E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3DB20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeJSKN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:13:58 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:42733 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeJSKN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 06:13:58 -0400
Received: by mail-io1-f69.google.com with SMTP id m7-v6so29951448iop.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 19:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ygHq1F1uhg3WLPnry/2Y5yqFwkmVKUp+m0wFNUBra08=;
        b=dVlwSMdadPOFtfUhBCKwP35f85rsH0f6U/i/u+WUZAAnDG/beH24t9knMDnhaR5+3S
         JgLcrVf1QBeNBmVrxS/oROF8SRR5QNfg/K7qhyFptOFUnDRQGxaHjaVs8DLywfA1d2Ei
         ljIju3xRAxGyYfl3RlrKdmszEfmbL4ZS7pT4k9FNxt6s6pgm9W9mf07L360iDZck3men
         Pnsr8TdZDZLBSLweN+4X+WS3JSRzn0MvMtTut3mQSgHkY0COlBUr4S+SD4mh8JvK+SFe
         nfMAHbV9KUq2lhMKSowLrhWzEpHQqDrhOT2y8EC2j3FZRA+y8D1yGTuUGlQKxi3yPwXn
         Lwuw==
X-Gm-Message-State: AGRZ1gLh5txnXReycFno6WZLV1gOF9nbMHB5CKqRA5OsPWscyXonVNsC
        a0DZgdJ5nWAaqt/1zvqpL4ZhI96YceMnFFAg17F0dw5t0Zn6
X-Google-Smtp-Source: AJdET5fB3mIAWWQN29trklqELw02V+ci+iQe4u1ORHNm+c87aKhuHeht5n4Tx+EMnOkwinTTpVOn1hgZ7j7aWd55ILHnhdJ4eMB6
MIME-Version: 1.0
X-Received: by 2002:a5e:d80f:: with SMTP id l15-v6mr2147231iok.30.1539915002051;
 Thu, 18 Oct 2018 19:10:02 -0700 (PDT)
Date:   Thu, 18 Oct 2018 19:10:02 -0700
In-Reply-To: <000000000000cd1e2205785951c2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae9d3305788b66c0@google.com>
Subject: Re: possible deadlock in __generic_file_fsync
From:   syzbot <syzbot+5cd33f0e6abe2bb3e397@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    fa520c47eaa1 fscache: Fix out of bound read in long cookie..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130da8ee400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3f55cb3dfcc6c33
dashboard link: https://syzkaller.appspot.com/bug?extid=5cd33f0e6abe2bb3e397
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1299be09400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5cd33f0e6abe2bb3e397@syzkaller.appspotmail.com


======================================================
WARNING: possible circular locking dependency detected
4.19.0-rc8+ #290 Not tainted
------------------------------------------------------
kworker/0:1/14 is trying to acquire lock:
00000000722efb72 (&sb->s_type->i_mutex_key#10){+.+.}, at: inode_lock  
include/linux/fs.h:738 [inline]
00000000722efb72 (&sb->s_type->i_mutex_key#10){+.+.}, at:  
__generic_file_fsync+0xb5/0x200 fs/libfs.c:981

but task is already holding lock:
000000000144bfd5 ((work_completion)(&dio->complete_work)){+.+.}, at:  
process_one_work+0xb9a/0x1b90 kernel/workqueue.c:2128

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 ((work_completion)(&dio->complete_work)){+.+.}:
        process_one_work+0xc0a/0x1b90 kernel/workqueue.c:2129
        worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
        kthread+0x35a/0x420 kernel/kthread.c:246
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413

-> #1 ((wq_completion)"dio/%s"sb->s_id){+.+.}:
        flush_workqueue+0x30a/0x1e10 kernel/workqueue.c:2655
        drain_workqueue+0x2a9/0x640 kernel/workqueue.c:2820
        destroy_workqueue+0xc6/0x9c0 kernel/workqueue.c:4155
        __alloc_workqueue_key+0xed8/0x1170 kernel/workqueue.c:4138
        sb_init_dio_done_wq+0x37/0x90 fs/direct-io.c:623
        do_blockdev_direct_IO+0x12ea/0x9d70 fs/direct-io.c:1283
        __blockdev_direct_IO+0x9d/0xc6 fs/direct-io.c:1417
        ext4_direct_IO_write fs/ext4/inode.c:3743 [inline]
        ext4_direct_IO+0xae8/0x2230 fs/ext4/inode.c:3870
        generic_file_direct_write+0x275/0x4b0 mm/filemap.c:3042
        __generic_file_write_iter+0x2ff/0x630 mm/filemap.c:3221
        ext4_file_write_iter+0x390/0x1420 fs/ext4/file.c:266
        call_write_iter include/linux/fs.h:1808 [inline]
        aio_write+0x3b1/0x610 fs/aio.c:1561
        io_submit_one+0xaa1/0xf80 fs/aio.c:1835
        __do_sys_io_submit fs/aio.c:1916 [inline]
        __se_sys_io_submit fs/aio.c:1887 [inline]
        __x64_sys_io_submit+0x1b7/0x580 fs/aio.c:1887
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&sb->s_type->i_mutex_key#10){+.+.}:
        lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3900
        down_write+0x8a/0x130 kernel/locking/rwsem.c:70
        inode_lock include/linux/fs.h:738 [inline]
        __generic_file_fsync+0xb5/0x200 fs/libfs.c:981
        ext4_sync_file+0xa4f/0x1510 fs/ext4/fsync.c:120
        vfs_fsync_range+0x140/0x220 fs/sync.c:197
        generic_write_sync include/linux/fs.h:2732 [inline]
        dio_complete+0x75c/0x9e0 fs/direct-io.c:329
        dio_aio_complete_work+0x20/0x30 fs/direct-io.c:341
        process_one_work+0xc90/0x1b90 kernel/workqueue.c:2153
        worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
        kthread+0x35a/0x420 kernel/kthread.c:246
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413

other info that might help us debug this:

Chain exists of:
   &sb->s_type->i_mutex_key#10 --> (wq_completion)"dio/%s"sb->s_id -->  
(work_completion)(&dio->complete_work)

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock((work_completion)(&dio->complete_work));
                                lock((wq_completion)"dio/%s"sb->s_id);
                                lock((work_completion)(&dio->complete_work));
   lock(&sb->s_type->i_mutex_key#10);

  *** DEADLOCK ***

2 locks held by kworker/0:1/14:
  #0: 0000000013da2705 ((wq_completion)"dio/%s"sb->s_id){+.+.}, at:  
__write_once_size include/linux/compiler.h:215 [inline]
  #0: 0000000013da2705 ((wq_completion)"dio/%s"sb->s_id){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 0000000013da2705 ((wq_completion)"dio/%s"sb->s_id){+.+.}, at:  
atomic64_set include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 0000000013da2705 ((wq_completion)"dio/%s"sb->s_id){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:59 [inline]
  #0: 0000000013da2705 ((wq_completion)"dio/%s"sb->s_id){+.+.}, at:  
set_work_data kernel/workqueue.c:617 [inline]
  #0: 0000000013da2705 ((wq_completion)"dio/%s"sb->s_id){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 0000000013da2705 ((wq_completion)"dio/%s"sb->s_id){+.+.}, at:  
process_one_work+0xb43/0x1b90 kernel/workqueue.c:2124
  #1: 000000000144bfd5 ((work_completion)(&dio->complete_work)){+.+.}, at:  
process_one_work+0xb9a/0x1b90 kernel/workqueue.c:2128

stack backtrace:
CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 4.19.0-rc8+ #290
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: dio/sda1 dio_aio_complete_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_circular_bug.isra.33.cold.54+0x1bd/0x27d  
kernel/locking/lockdep.c:1221
  check_prev_add kernel/locking/lockdep.c:1861 [inline]
  check_prevs_add kernel/locking/lockdep.c:1974 [inline]
  validate_chain kernel/locking/lockdep.c:2415 [inline]
  __lock_acquire+0x33e4/0x4ec0 kernel/locking/lockdep.c:3411
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3900
  down_write+0x8a/0x130 kernel/locking/rwsem.c:70
  inode_lock include/linux/fs.h:738 [inline]
  __generic_file_fsync+0xb5/0x200 fs/libfs.c:981
  ext4_sync_file+0xa4f/0x1510 fs/ext4/fsync.c:120
  vfs_fsync_range+0x140/0x220 fs/sync.c:197
  generic_write_sync include/linux/fs.h:2732 [inline]
  dio_complete+0x75c/0x9e0 fs/direct-io.c:329
  dio_aio_complete_work+0x20/0x30 fs/direct-io.c:341
  process_one_work+0xc90/0x1b90 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000003e90fb85): kobject_uevent_env
kobject: 'loop2' (000000003e90fb85): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000003d995dbe): kobject_uevent_env
kobject: 'loop4' (000000003d995dbe): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (00000000b1bc7aa3): kobject_uevent_env
kobject: 'loop3' (00000000b1bc7aa3): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (000000008d3717c1): kobject_uevent_env
kobject: 'loop0' (000000008d3717c1): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (000000003375a90c): kobject_uevent_env
kobject: 'loop1' (000000003375a90c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000f7f6b8db): kobject_uevent_env
kobject: 'loop5' (00000000f7f6b8db): fill_kobj_path: path  
= '/devices/virtual/block/loop5'

