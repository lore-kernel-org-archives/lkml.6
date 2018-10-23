Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AB2C7112C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFF420652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFF420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbeJWXBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 19:01:47 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:46128 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbeJWXBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 19:01:47 -0400
Received: by mail-io1-f71.google.com with SMTP id l12-v6so1205643iom.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 07:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hvCQnr+M9vh/m4ymWZre2pVMvZqK/Scd1ZDX+2+CePY=;
        b=eeqgZ+cHyC6hjrKDa4mbTepsA6yo1USnT+UuR+4ddRSCn5JKN5MxLbBwsvAKpaxegr
         nqDqGC1d1aHintU6aRWydFtzV8bfvyk0gWtgPuMNESGeyVRTyZovzn2S7SwN+blWQQH1
         iHEPb+m9xsXvWGS8nSM8o54tVGOqmwFqInMHrqxUO9IbIRFUGhKc1c1o8Nh9QnTcSFxS
         tCXUDbB7WjtKYWAb/IptdeAOErnyJYSIB7Fn9XsEBfye7SEBFC2q3UxEwEYeSJBuGjSg
         yd7RY1pzzvmtZXXucn4LTXyRU/LtlR+OfTzZLD3jH40Bc0YZtpyUhf9ynOvgR9YQN3Ap
         WpBw==
X-Gm-Message-State: ABuFfoiwols4HykZu1SzjhWDHAbSNpQ+D+TyUJ89rY9NCW8/7Lna65hn
        uVdK6V3WaYgva0LPHmS1uBNf1WAsRUUKcqL8c6Y0FLjEWy9b
X-Google-Smtp-Source: ACcGV62CennMjcE8V0gumciyW2zOIVLRK7mqMhlaXGH+TyDn8Csf9Shcd/KxngO5iJuikpAt/LnQKmAW/5/S5f7RjfxgQ8YjyFkE
MIME-Version: 1.0
X-Received: by 2002:a02:3b58:: with SMTP id i24-v6mr42067624jaf.25.1540305483891;
 Tue, 23 Oct 2018 07:38:03 -0700 (PDT)
Date:   Tue, 23 Oct 2018 07:38:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003692760578e651dd@google.com>
Subject: KASAN: use-after-free Write in hci_sock_release
From:   syzbot <syzbot+b364ed862aa07c74bc62@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8c60c36d0b8c Add linux-next specific files for 20181019
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=163a6499400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b6d7c4c81535e89
dashboard link: https://syzkaller.appspot.com/bug?extid=b364ed862aa07c74bc62
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b364ed862aa07c74bc62@syzkaller.appspotmail.com

F2FS-fs (loop5): Can't find valid F2FS filesystem in 1th superblock
F2FS-fs (loop5): Magic Mismatch, valid(0xf2f52010) - read(0x0)
F2FS-fs (loop5): Can't find valid F2FS filesystem in 2th superblock
==================================================================
BUG: KASAN: use-after-free in atomic_dec  
include/asm-generic/atomic-instrumented.h:127 [inline]
BUG: KASAN: use-after-free in hci_sock_release+0x14f/0x3b0  
net/bluetooth/hci_sock.c:873
Write of size 4 at addr ffff880182f492a0 by task syz-executor0/7470

CPU: 1 PID: 7470 Comm: syz-executor0 Not tainted 4.19.0-rc8-next-20181019+  
#98
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  kasan_check_write+0x14/0x20 mm/kasan/kasan.c:278
  atomic_dec include/asm-generic/atomic-instrumented.h:127 [inline]
  hci_sock_release+0x14f/0x3b0 net/bluetooth/hci_sock.c:873
  __sock_release+0xd7/0x250 net/socket.c:580
  sock_close+0x19/0x20 net/socket.c:1142
  __fput+0x3bc/0xa70 fs/file_table.c:279
  ____fput+0x15/0x20 fs/file_table.c:312
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb9b189cc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000457569
RDX: 000000000000000c RSI: 0000000020000240 RDI: 0000000000000006
RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb9b189d6d4
R13: 00000000004bd6a4 R14: 00000000004cbf20 R15: 00000000ffffffff

Allocated by task 7468:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:546 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  hci_alloc_dev+0x228/0x21a0 net/bluetooth/hci_core.c:3116
  __vhci_create_device+0x102/0x580 drivers/bluetooth/hci_vhci.c:114
  vhci_create_device drivers/bluetooth/hci_vhci.c:163 [inline]
  vhci_get_user drivers/bluetooth/hci_vhci.c:219 [inline]
  vhci_write+0x2de/0x470 drivers/bluetooth/hci_vhci.c:299
  call_write_iter include/linux/fs.h:1844 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 7467:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  bt_host_release+0x19/0x30 net/bluetooth/hci_sysfs.c:86
  device_release+0x7e/0x210 drivers/base/core.c:891
  kobject_cleanup lib/kobject.c:662 [inline]
  kobject_release lib/kobject.c:691 [inline]
  kref_put include/linux/kref.h:70 [inline]
  kobject_put.cold.9+0x287/0x2e4 lib/kobject.c:708
  put_device+0x20/0x30 drivers/base/core.c:2024
  hci_free_dev+0x19/0x20 net/bluetooth/hci_core.c:3208
  vhci_release+0x7e/0xf0 drivers/bluetooth/hci_vhci.c:355
  __fput+0x3bc/0xa70 fs/file_table.c:279
  ____fput+0x15/0x20 fs/file_table.c:312
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff880182f48240
  which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 4192 bytes inside of
  8192-byte region [ffff880182f48240, ffff880182f4a240)
The buggy address belongs to the page:
page:ffffea00060bd200 count:1 mapcount:0 mapping:ffff8801da802080 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea000610f708 ffff8801da801b48 ffff8801da802080
raw: 0000000000000000 ffff880182f48240 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff880182f49180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff880182f49200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff880182f49280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                ^
  ffff880182f49300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff880182f49380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
audit: type=1800 audit(1540276897.489:32): pid=7430 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=collect_data cause=failed(directio)  
comm="syz-executor5" name="file0" dev="sda1" ino=16559 res=0
syz-executor5 (7430) used greatest stack depth: 14640 bytes left


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
