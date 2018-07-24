Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EDCC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6F020856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6F020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388505AbeGXIcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:32:07 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:38887 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388402AbeGXIcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:32:07 -0400
Received: by mail-io0-f200.google.com with SMTP id g12-v6so2127727ioh.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 00:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=q07VWQ24OaaCNUXOKWT9gEsc8XOZExD8NIuDDANTZrg=;
        b=mEnxfCA4Tou3cC9uW0F+mhov/yErgJpidP0L1mI6oBbkpAwDEHj5PZKE9+8AqBgWjg
         U7d/EPfKiUnUBMPv2S03yxWHAE0828k2YTLKOutjo8tmKoEg2nfgywJ49qvK2wzqYQWC
         zJERvA8wW7LThQ2UZo7aFelW6O8R2QNrkGC07dLKL2YJJDnmDsgOT+gL8hxbVslqokgW
         zRsWeotQI3OraBeQkVztPbIAsyt6F3dkD2xi7yT8tUTtrKE6omXSIpOdmGz5mSpsR0xZ
         L4U7nykQRQS6LRNryiO9yeH8agMcfmWm7QDP4xHx6JETiYETCLcDFu+CHj2H0EFi1afM
         8oFw==
X-Gm-Message-State: AOUpUlER3i+6ur5FTx22eC4iiXdiuhBD0GvSX6aw89TgjOh/HVzOwZR6
        PAdCbs2viBGSayYGiFG6ofLED14uwPVZDhM46/p+RTtG4qmC
X-Google-Smtp-Source: AAOMgpcsIpzYr5w3hEVcwvv/6XBmiCj8sBZYKZwyESSQu54dJwhW+i5mep/9p1+pu424mNCw0LWe8HsnXs1yvlam8Ryv1B4mOPm0
MIME-Version: 1.0
X-Received: by 2002:a24:7acf:: with SMTP id a198-v6mr929651itc.14.1532417221767;
 Tue, 24 Jul 2018 00:27:01 -0700 (PDT)
Date:   Tue, 24 Jul 2018 00:27:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026c18a0571b9b0de@google.com>
Subject: KASAN: use-after-free Read in rfcomm_dlc_exists
From:   syzbot <syzbot+728bead095cef3335bb6@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com,
        keescook@chromium.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    89cf55353308 Add linux-next specific files for 20180720
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1721408c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9641a83a066bb43
dashboard link: https://syzkaller.appspot.com/bug?extid=728bead095cef3335bb6
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+728bead095cef3335bb6@syzkaller.appspotmail.com

EXT4-fs (loop7): VFS: Can't find ext4 filesystem
FAT-fs (loop4): Directory bread(block 2) failed
FAT-fs (loop4): Directory bread(block 3) failed
==================================================================
BUG: KASAN: use-after-free in rfcomm_dlc_get  
net/bluetooth/rfcomm/core.c:360 [inline]
BUG: KASAN: use-after-free in rfcomm_dlc_exists+0x1be/0x1f0  
net/bluetooth/rfcomm/core.c:549
Read of size 1 at addr ffff8801d2c1b484 by task syz-executor7/26132

FAT-fs (loop4): Directory bread(block 4) failed
CPU: 0 PID: 26132 Comm: syz-executor7 Not tainted 4.18.0-rc5-next-20180720+  
#12
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
FAT-fs (loop4): Directory bread(block 5) failed
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
FAT-fs (loop4): Directory bread(block 6) failed
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  rfcomm_dlc_get net/bluetooth/rfcomm/core.c:360 [inline]
  rfcomm_dlc_exists+0x1be/0x1f0 net/bluetooth/rfcomm/core.c:549
  __rfcomm_create_dev net/bluetooth/rfcomm/tty.c:413 [inline]
  rfcomm_create_dev net/bluetooth/rfcomm/tty.c:486 [inline]
  rfcomm_dev_ioctl+0x105e/0x2240 net/bluetooth/rfcomm/tty.c:588
FAT-fs (loop4): Directory bread(block 7) failed
FAT-fs (loop4): Directory bread(block 8) failed
  rfcomm_sock_ioctl+0x89/0xb0 net/bluetooth/rfcomm/sock.c:902
  sock_do_ioctl+0xe4/0x3e0 net/socket.c:951
FAT-fs (loop4): Directory bread(block 9) failed
FAT-fs (loop4): Directory bread(block 10) failed
  sock_ioctl+0x30d/0x680 net/socket.c:1075
FAT-fs (loop4): Directory bread(block 11) failed
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
attempt to access beyond end of device
loop4: rw=1, want=73, limit=2
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455ab9
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f46b0b73c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f46b0b746d4 RCX: 0000000000455ab9
RDX: 0000000020000140 RSI: 00000000400452c8 RDI: 0000000000000014
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004bdaad R14: 00000000004cc4c0 R15: 0000000000000000

Allocated by task 23864:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  rfcomm_dlc_alloc+0xb8/0x490 net/bluetooth/rfcomm/core.c:305
  rfcomm_sock_alloc.constprop.6+0x13a/0x420 net/bluetooth/rfcomm/sock.c:286
  rfcomm_sock_create+0xf0/0x2b0 net/bluetooth/rfcomm/sock.c:329
  bt_sock_create+0x16b/0x2d0 net/bluetooth/af_bluetooth.c:130
  __sock_create+0x53c/0x940 net/socket.c:1268
  sock_create net/socket.c:1308 [inline]
  __sys_socket+0x106/0x260 net/socket.c:1338
  __do_sys_socket net/socket.c:1347 [inline]
  __se_sys_socket net/socket.c:1345 [inline]
  __x64_sys_socket+0x73/0xb0 net/socket.c:1345
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 26096:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  rfcomm_dlc_free+0x1e/0x30 net/bluetooth/rfcomm/core.c:328
  rfcomm_dlc_put include/net/bluetooth/rfcomm.h:258 [inline]
  __rfcomm_create_dev net/bluetooth/rfcomm/tty.c:417 [inline]
  rfcomm_create_dev net/bluetooth/rfcomm/tty.c:486 [inline]
  rfcomm_dev_ioctl+0x1dfe/0x2240 net/bluetooth/rfcomm/tty.c:588
  rfcomm_sock_ioctl+0x89/0xb0 net/bluetooth/rfcomm/sock.c:902
  sock_do_ioctl+0xe4/0x3e0 net/socket.c:951
  sock_ioctl+0x30d/0x680 net/socket.c:1075
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801d2c1b340
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 324 bytes inside of
  512-byte region [ffff8801d2c1b340, ffff8801d2c1b540)
The buggy address belongs to the page:
page:ffffea00074b06c0 count:1 mapcount:0 mapping:ffff8801da800940 index:0x0
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea00073f55c8 ffffea0007245f88 ffff8801da800940
raw: 0000000000000000 ffff8801d2c1b0c0 0000000100000006 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d2c1b380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d2c1b400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801d2c1b480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                    ^
  ffff8801d2c1b500: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8801d2c1b580: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
