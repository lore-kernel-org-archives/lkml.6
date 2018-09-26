Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C16C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C117820843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C117820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeIZOBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:01:43 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:38734 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbeIZOBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:01:42 -0400
Received: by mail-it1-f198.google.com with SMTP id p62-v6so2021936ite.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6uv0/qcqlepuvEb1lcXfug9nrwD4TQwaCyvg4WrFTrQ=;
        b=HIv9G6Vy9WKQNLCGe4+NV48gZnQUD5NcZvzbXg5UU+VGdLLi1C8RfRy5qrv6FSA0UD
         k2mfifVMP0U6oFP0a8FPeqZHWo9LgJMQ0SnhdFTDAJa6o6nW9iVUGvc4XPAKSm0n34cv
         2WIs5gROeFT4kUJ2AlJGvX/fE4jsfhbaLLUJrwuabyEdmuCBESWNSpuwkYuQ1x1JXMEm
         AIR0jCSNf88XtJ+5WXl8YgpaZkHTG2oEbuNsW/lQIGUSAjmW6qJu7gCiIkzEzbvuFSQh
         8gW/HJH7glL7YCqHT/96F4wjqrYgs0zYGkRYklUh200mmSuTBlRg/Bfcuh0En9AmdAWg
         S4/w==
X-Gm-Message-State: ABuFfoimK7HmuFE8Zf2JK4GjdXJkZ+2aBDL+HGqqrAN2fhPZZhy0YejN
        E+SgufKFDSbucPh4LD7d/foYb3ir/elOtp/2hA5iaoOqwud1
X-Google-Smtp-Source: ACcGV63+JKk1mjodyzM8q0b/1rmOpVylq5ZTPvRDjWq8eWLqUDsYvl5KzHDfjWH7KVvU4iNpJWuwpDL728hXs+yZ1RzxUcwMhkW2
MIME-Version: 1.0
X-Received: by 2002:a6b:8c41:: with SMTP id o62-v6mr3432660iod.2.1537948204428;
 Wed, 26 Sep 2018 00:50:04 -0700 (PDT)
Date:   Wed, 26 Sep 2018 00:50:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068750f0576c178ab@google.com>
Subject: KASAN: use-after-free Read in vhost_transport_cancel_pkt
From:   syzbot <syzbot+e3e074963495f92a89ed@syzkaller.appspotmail.com>
To:     jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, stefanha@redhat.com,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    4ca719a338d5 Merge branch 'linus' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16861f99400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa12be50bca08d8
dashboard link: https://syzkaller.appspot.com/bug?extid=e3e074963495f92a89ed
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e3e074963495f92a89ed@syzkaller.appspotmail.com

QAT: Invalid ioctl
==================================================================
BUG: KASAN: use-after-free in perf_trace_lock_acquire+0x66b/0x800  
include/trace/events/lock.h:13
Read of size 8 at addr ffff880196f584e8 by task syz-executor1/30556

CPU: 1 PID: 30556 Comm: syz-executor1 Not tainted 4.19.0-rc4+ #148
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  perf_trace_lock_acquire+0x66b/0x800 include/trace/events/lock.h:13
  trace_lock_acquire include/trace/events/lock.h:13 [inline]
  lock_acquire+0x385/0x520 kernel/locking/lockdep.c:3899
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
  _raw_spin_lock_bh+0x31/0x40 kernel/locking/spinlock.c:168
  spin_lock_bh include/linux/spinlock.h:334 [inline]
  vhost_transport_cancel_pkt+0x15e/0x910 drivers/vhost/vsock.c:244
  vsock_transport_cancel_pkt net/vmw_vsock/af_vsock.c:1114 [inline]
  vsock_stream_connect+0x903/0xe40 net/vmw_vsock/af_vsock.c:1241
  __sys_connect+0x37d/0x4c0 net/socket.c:1664
  __do_sys_connect net/socket.c:1675 [inline]
  __se_sys_connect net/socket.c:1672 [inline]
  __ia32_sys_connect+0x72/0xb0 net/socket.c:1672
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f8fca9
Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 0c 24 c3 8b 1c 24 c3 90 90  
90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f5f280cc EFLAGS: 00000296 ORIG_RAX: 000000000000016a
RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 0000000020000080
RDX: 0000000000000010 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 30547:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc_node mm/slab.c:3682 [inline]
  __kmalloc_node+0x47/0x70 mm/slab.c:3689
  kmalloc_node include/linux/slab.h:555 [inline]
  kvmalloc_node+0xb9/0xf0 mm/util.c:423
QAT: Invalid ioctl
  kvmalloc include/linux/mm.h:577 [inline]
  vhost_vsock_dev_open+0xa2/0x5a0 drivers/vhost/vsock.c:511
  misc_open+0x3ca/0x560 drivers/char/misc.c:141
  chrdev_open+0x25a/0x710 fs/char_dev.c:417
  do_dentry_open+0x499/0x1250 fs/open.c:771
  vfs_open+0xa0/0xd0 fs/open.c:880
  do_last fs/namei.c:3418 [inline]
  path_openat+0x12bf/0x5160 fs/namei.c:3534
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_sys_open+0x568/0x700 fs/open.c:1063
  __do_compat_sys_openat fs/open.c:1109 [inline]
  __se_compat_sys_openat fs/open.c:1107 [inline]
  __ia32_compat_sys_openat+0x98/0xf0 fs/open.c:1107
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

Freed by task 30546:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3813
  kvfree+0x61/0x70 mm/util.c:452
  vhost_vsock_free drivers/vhost/vsock.c:499 [inline]
  vhost_vsock_dev_release+0x4f4/0x720 drivers/vhost/vsock.c:604
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_32_irqs_on arch/x86/entry/common.c:341 [inline]
  do_fast_syscall_32+0xcd5/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

The buggy address belongs to the object at ffff880196f4f7c0
  which belongs to the cache kmalloc-65536 of size 65536
The buggy address is located 36136 bytes inside of
  65536-byte region [ffff880196f4f7c0, ffff880196f5f7c0)
The buggy address belongs to the page:
page:ffffea00065bd000 count:1 mapcount:0 mapping:ffff8801da802500 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea00071cf008 ffffea0007199808 ffff8801da802500
raw: 0000000000000000 ffff880196f4f7c0 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff880196f58380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff880196f58400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff880196f58480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                           ^
  ffff880196f58500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff880196f58580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
