Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8404C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AA4218D0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfABKlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:41:14 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:36757 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729552AbfABKlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 05:41:07 -0500
Received: by mail-it1-f199.google.com with SMTP id w15so35715280ita.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 02:41:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JgkJDl8VgnFVEwtJi3/G7N57evA41C9STvYCWUK5A10=;
        b=Q0R4ruv1eOafDkULM/J38NFM1wwHyRqoCG3xlKtHHAu5HqCmi0d97YmaPFA3HDl5xH
         /X4ZGwbcDd4CI5ykFHuiFeUhRe8f+LHmd2k5kCEyxwV/3H9ljcvppjg6BGKynviHvR8f
         EjuPaQW16yEBfihWAsjNaL5zqcvwkMrKapvG8NKUzoPolwOYaV0Jk7bKGKNG9mI9/rEL
         XiD18kp2o/ad4Yawl/ocJK7lULx0EtiwUbCrxDq49n7TpgOWJZCi93KnufIRLHQ6+S0k
         9+69VeHU1HtqcuC4XkwNIZJuGoDMUUJoFZQyOyCHhUkCE10VbbJRfxl6Az0Uwni3DGRo
         nROQ==
X-Gm-Message-State: AA+aEWaYjD/qDRKDWQavNNQrmIew1AYqJ1VtxDkYgRTHza7oF5LTc6Mh
        r1sWRua3TiQb0ZpRVXywkfEFmhbCM/QGGp8fF9Oh2zTjFIPq
X-Google-Smtp-Source: AFSGD/WTHuBM5JxrWu3ky18pjuz0RwvwGTdXzCnOrMb+c3KrWaJh2UFOd07MQZ7JwrNlbNb7oEdZi4QlJPTdkCl9UH9QPNEp6TV3
MIME-Version: 1.0
X-Received: by 2002:a02:4dc9:: with SMTP id t70mr33875871jad.0.1546425665736;
 Wed, 02 Jan 2019 02:41:05 -0800 (PST)
Date:   Wed, 02 Jan 2019 02:41:05 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a5aad057e7748c9@google.com>
Subject: KASAN: use-after-free Read in lock_sock_nested
From:   syzbot <syzbot+500c69d1e21d970e461b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e1ef035d272e Merge tag 'armsoc-defconfig' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1674b0bb400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c6a26e22579190b
dashboard link: https://syzkaller.appspot.com/bug?extid=500c69d1e21d970e461b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+500c69d1e21d970e461b@syzkaller.appspotmail.com

IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
audit: type=1400 audit(1546374052.492:5134): avc:  denied  { map } for   
pid=30025 comm="blkid" path="/sbin/blkid" dev="sda1" ino=16128  
scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:file_t:s0  
tclass=file permissive=1
==================================================================
BUG: KASAN: use-after-free in perf_trace_lock_acquire+0x62d/0x7d0  
include/trace/events/lock.h:13
Read of size 8 at addr ffff88804fb90e78 by task syz-executor3/30043

CPU: 1 PID: 30043 Comm: syz-executor3 Not tainted 4.20.0+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
  perf_trace_lock_acquire+0x62d/0x7d0 include/trace/events/lock.h:13
  trace_lock_acquire include/trace/events/lock.h:13 [inline]
  lock_acquire+0x371/0x570 kernel/locking/lockdep.c:3840
audit: type=1400 audit(1546374052.492:5135): avc:  denied  { map } for   
pid=30025 comm="blkid" path="/lib/x86_64-linux-gnu/libblkid.so.1.1.0"  
dev="sda1" ino=2825 scontext=system_u:system_r:kernel_t:s0  
tcontext=system_u:object_r:file_t:s0 tclass=file permissive=1
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
  _raw_spin_lock_bh+0x33/0x50 kernel/locking/spinlock.c:168
audit: type=1400 audit(1546374052.502:5136): avc:  denied  { map } for   
pid=30024 comm="modprobe" path="/bin/kmod" dev="sda1" ino=1440  
scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:file_t:s0  
tclass=file permissive=1
  spin_lock_bh include/linux/spinlock.h:334 [inline]
  lock_sock_nested+0x41/0x120 net/core/sock.c:2780
  lock_sock include/net/sock.h:1502 [inline]
  nr_connect+0xc77/0x1380 net/netrom/af_netrom.c:743
  __sys_connect+0x357/0x490 net/socket.c:1664
  __do_sys_connect net/socket.c:1675 [inline]
  __se_sys_connect net/socket.c:1672 [inline]
  __x64_sys_connect+0x73/0xb0 net/socket.c:1672
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f3f0371fc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 0000000000000048 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 000000000073bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3f037206d4
R13: 00000000004be35a R14: 00000000004ce5e8 R15: 00000000ffffffff

Allocated by task 30040:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  kasan_kmalloc mm/kasan/common.c:482 [inline]
  kasan_kmalloc+0xcf/0xe0 mm/kasan/common.c:455
  __do_kmalloc mm/slab.c:3709 [inline]
  __kmalloc+0x15c/0x740 mm/slab.c:3718
  kmalloc include/linux/slab.h:550 [inline]
  sk_prot_alloc+0x19c/0x2e0 net/core/sock.c:1477
  sk_alloc+0xd7/0x1690 net/core/sock.c:1531
audit: type=1400 audit(1546374052.502:5137): avc:  denied  { map } for   
pid=30024 comm="modprobe" path="/bin/kmod" dev="sda1" ino=1440  
scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:file_t:s0  
tclass=file permissive=1
  nr_create+0xb9/0x5e0 net/netrom/af_netrom.c:436
  __sock_create+0x532/0x930 net/socket.c:1277
  sock_create net/socket.c:1317 [inline]
  __sys_socket+0x106/0x260 net/socket.c:1347
  __do_sys_socket net/socket.c:1356 [inline]
  __se_sys_socket net/socket.c:1354 [inline]
  __x64_sys_socket+0x73/0xb0 net/socket.c:1354
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 30035:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:444
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:452
  __cache_free mm/slab.c:3485 [inline]
  kfree+0xcf/0x230 mm/slab.c:3804
  sk_prot_free net/core/sock.c:1514 [inline]
  __sk_destruct+0x76d/0xa60 net/core/sock.c:1596
  sk_destruct+0x7b/0x90 net/core/sock.c:1604
  __sk_free+0xce/0x300 net/core/sock.c:1615
  sk_free+0x42/0x50 net/core/sock.c:1626
  sock_put include/net/sock.h:1703 [inline]
  nr_release+0x337/0x3c0 net/netrom/af_netrom.c:557
  __sock_release+0xd3/0x250 net/socket.c:579
  sock_close+0x1b/0x30 net/socket.c:1141
  __fput+0x3c5/0xb10 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x1f4/0x2b0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x32a/0x3b0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x696/0x800 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88804fb90dc0
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 184 bytes inside of
  2048-byte region [ffff88804fb90dc0, ffff88804fb915c0)
IPVS: ftp: loaded support on port[0] = 21
The buggy address belongs to the page:
page:ffffea00013ee400 count:1 mapcount:0 mapping:ffff88812c3f0c40 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea00015f8b88 ffffea00025b1908 ffff88812c3f0c40
raw: 0000000000000000 ffff88804fb90540 0000000100000003 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88804fb90d00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
  ffff88804fb90d80: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> ffff88804fb90e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                 ^
  ffff88804fb90e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88804fb90f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
kobject: 'lo' (0000000050df09a4): kobject_add_internal: parent: 'net',  
set: 'devices'


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
