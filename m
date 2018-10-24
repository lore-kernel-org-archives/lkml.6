Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2C2C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AB52082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20AB52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeJXTCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:02:37 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:42107 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJXTCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:02:36 -0400
Received: by mail-io1-f70.google.com with SMTP id d4-v6so403897ioh.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 03:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WpV4Wmyhgoq5UXDyRFa6SGioA4noR4j8+XQ5TzTaJRU=;
        b=tSvOUOHB40oi2vzpQefVx8eq6k+4FScMPt/umbixhlnCJOl2TaiHJSo2DNf2UuGM4P
         jXNlaVkggNbDo+TBiAh+1zHYaGL2uRcHBShOmX3onqFH/6bPwxZ3MywlCsAUH2ek+nko
         pQ1EZQegHVesP9uTF/3NdbhjDz/sASd89as3NFAdnieUAtCarbwiscYRY6JzitQMRyiQ
         1pUQD6LJbAUGLfDnwjUwgHPST6YMOWc7WuBJgfNb5niKWzP76tGUwktbWPmY+L4IRBq8
         6Y6WlYWQBBydL5InWXslzImN1C3dmKdns+TLOrcCns8RgOXa4z6rbsIP0eCwbIxC7NGG
         P0yQ==
X-Gm-Message-State: AGRZ1gI1OinK9DRezTKrz243+Sy/+N4ngCG5bl+tOq8ve6nICk6cvJ69
        8M1XI43PrsXdZLmj6M9NeGN2dRJvToVgKFVX2qjtvFqAUjzI
X-Google-Smtp-Source: AJdET5fhFBWLIGwbM2lfKZ7uxdUH94vPsOfJfDAfxRnLLbwk1RNh99azrKrQ9w3fX554KXyTgO1+lhpapnsQIZKoHuyp0XYNVoVF
MIME-Version: 1.0
X-Received: by 2002:a02:6a07:: with SMTP id l7-v6mr1570010jac.0.1540377302942;
 Wed, 24 Oct 2018 03:35:02 -0700 (PDT)
Date:   Wed, 24 Oct 2018 03:35:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6512e0578f70944@google.com>
Subject: KASAN: use-after-free Read in do_exit
From:   syzbot <syzbot+71a06dcf7e167c30ab9d@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        mark.rutland@arm.com, paulmck@linux.vnet.ibm.com,
        sudipm.mukherjee@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    58a022870787 Merge tag 'acpi-4.20-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a0f939400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=414a8e66ba2c6789
dashboard link: https://syzkaller.appspot.com/bug?extid=71a06dcf7e167c30ab9d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+71a06dcf7e167c30ab9d@syzkaller.appspotmail.com

TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
input: syz1 as /devices/virtual/input/input1084
netlink: 20 bytes leftover after parsing attributes in process  
`syz-executor2'.
kasan: CONFIG_KASAN_INLINE enabled
==================================================================
BUG: KASAN: use-after-free in stack_not_used  
include/linux/sched/task_stack.h:101 [inline]
BUG: KASAN: use-after-free in check_stack_usage kernel/exit.c:748 [inline]
BUG: KASAN: use-after-free in do_exit+0x2196/0x26d0 kernel/exit.c:916
Read of size 8 at addr ffff8801c2b90008 by task blkid/5862

CPU: 1 PID: 5862 Comm: blkid Not tainted 4.19.0+ #299
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b6 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  stack_not_used include/linux/sched/task_stack.h:101 [inline]
  check_stack_usage kernel/exit.c:748 [inline]
  do_exit+0x2196/0x26d0 kernel/exit.c:916
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5797 Comm: syz-executor4 Not tainted 4.19.0+ #299
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
RIP: 0010:compound_head include/linux/page-flags.h:142 [inline]
RIP: 0010:put_page include/linux/mm.h:931 [inline]
RIP: 0010:tls_sk_proto_close+0x419/0xbb0 net/tls/tls_main.c:277
Code: 8d e8 fe ff ff 48 89 85 f0 fe ff ff e8 b0 55 db fa 48 8b 85 f0 fe ff  
ff 49 83 e5 fc 49 8d 7d 08 c6 00 00 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00  
0f 85 ad 06 00 00 48 8b 85 f0 fe ff ff 4d 8b 75 08
RSP: 0018:ffff88018c2e6f70 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff88018566ae40 RCX: ffffffff86a36050
RDX: 0000000000000000 RSI: ffffffff86a35e10 RDI: 0000000000000008
RBP: ffff88018c2e70d0 R08: ffff880182d0c580 R09: 0000000000000006
R10: 0000000000000000 R11: ffff880182d0c580 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88018ba82740
FS:  00007f2e39ea9700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32334000 CR3: 00000001ccbdb000 CR4: 00000000001426f0
Call Trace:
  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:428
  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:457
  __sock_release+0xd7/0x250 net/socket.c:579
  sock_close+0x19/0x20 net/socket.c:1141
  __fput+0x385/0xa30 fs/file_table.c:278
  do_group_exit+0x177/0x440 kernel/exit.c:970
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  __do_sys_exit_group kernel/exit.c:981 [inline]
  __se_sys_exit_group kernel/exit.c:979 [inline]
  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:979
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1ad6/0x26d0 kernel/exit.c:867
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f564809d1e8
Code: Bad RIP value.
RSP: 002b:00007ffd77478cc8 EFLAGS: 00000246
  ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f564809d1e8
RDX: 0000000000000002 RSI: 000000000000003c RDI: 0000000000000002
RBP: 00007f5648372840 R08: 00000000000000e7 R09: ffffffffffffffa8
R10: 00007f5648378740 R11: 0000000000000246 R12: 00007f5648372840
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 5279:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
  kmem_cache_zalloc include/linux/slab.h:697 [inline]
  locks_alloc_lock+0x8e/0x270 fs/locks.c:303
  fcntl_setlk+0xc8/0xfb0 fs/locks.c:2246
  do_fcntl+0xa6f/0x1500 fs/fcntl.c:370
  __do_sys_fcntl fs/fcntl.c:463 [inline]
  __se_sys_fcntl fs/fcntl.c:448 [inline]
  __x64_sys_fcntl+0x177/0x1f0 fs/fcntl.c:448
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 5279:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3756
  locks_free_lock+0x209/0x340 fs/locks.c:339
  fcntl_setlk+0x79f/0xfb0 fs/locks.c:2323
  do_fcntl+0xa6f/0x1500 fs/fcntl.c:370
  __do_sys_fcntl fs/fcntl.c:463 [inline]
  __se_sys_fcntl fs/fcntl.c:448 [inline]
  __x64_sys_fcntl+0x177/0x1f0 fs/fcntl.c:448
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801c2b90000
  which belongs to the cache file_lock_cache of size 248
The buggy address is located 8 bytes inside of
  248-byte region [ffff8801c2b90000, ffff8801c2b900f8)
The buggy address belongs to the page:
  do_group_exit+0x177/0x440 kernel/exit.c:970
page:ffffea00070ae400 count:1 mapcount:0 mapping:ffff8801d9bf5b00 index:0x0
  get_signal+0x8b0/0x1980 kernel/signal.c:2513
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea000709e388 ffffea0006039548 ffff8801d9bf5b00
raw: 0000000000000000 ffff8801c2b90000 000000010000000d 0000000000000000
page dumped because: kasan: bad access detected
  do_signal+0x9c/0x21e0 arch/x86/kernel/signal.c:816

Memory state around the buggy address:
  ffff8801c2b8ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801c2b8ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8801c2b90000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                       ^
  ffff8801c2b90080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc
  ffff8801c2b90100: fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
