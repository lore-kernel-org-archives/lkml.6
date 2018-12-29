Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E12C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B890720873
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbeL2SuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 13:50:05 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:60288 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbeL2SuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 13:50:05 -0500
Received: by mail-it1-f200.google.com with SMTP id t143so26412894itc.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 10:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/y7qjPG/upoFdh1KRZQkceHspMK9kx6VW5xwt4R6vBE=;
        b=WWXMby/SfEB6Yh9JIaw5iratx8PFhwvgsu3OeB9GdZrgvdJqqdSq8i8WEy4lcVO4NH
         auATVasMzh19YaE8SYPiDrcQZgcqX10ACKz5GjxkmKgB1jRgtMsAuQDRxD7ZICHV9Kd2
         3uBWhcQAZ0j/Clua1EfjHWBbM1F2EzLCxfrJeU0UzplbNa+/meBggng37qCTtyRdOsqq
         zPBadxjBUxuqwmZkxFRQk/m4q7hBsZUoyr2vBsQxDBIy2R+Iess7CSY2rxL18ZinML3Y
         oOEvmdG53scUmX+z5RnoqBc4vO1Ntiaon+ethQyKWmAEP4x1/Wdw6MB7LtK2KfwOWuuD
         N/Rw==
X-Gm-Message-State: AJcUukdHfiAjhQ1EKTyuZruUJLNmzimIxofgJVMe69DBiY3W43BmjTR5
        qRCM+JHo3HVIge0ENX7bxGGoRHR5gije7S0z/tKyWEGl1ysl
X-Google-Smtp-Source: ALg8bN7DQNJ6vVd2rhPkQnZyon2dTgUOmZnUxfZphNpX5v+a9bxyc/hJtWAOBgba496+XeGpvXKGjwbEezpfxIexsPJAiLosqAC9
MIME-Version: 1.0
X-Received: by 2002:a5d:8599:: with SMTP id f25mr5879978ioj.14.1546109403905;
 Sat, 29 Dec 2018 10:50:03 -0800 (PST)
Date:   Sat, 29 Dec 2018 10:50:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cdc755057e2da575@google.com>
Subject: KASAN: use-after-free Read in x25_device_event
From:   syzbot <syzbot+04babcefcd396fabec37@syzkaller.appspotmail.com>
To:     andrew.hendry@gmail.com, davem@davemloft.net, dvlasenk@redhat.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-x25@vger.kernel.org, ms@dev.tdt.de, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    38355a5f9a22 bnx2x: Fix NULL pointer dereference in bnx2x_..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=144e49ed400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7321a72d3309c029
dashboard link: https://syzkaller.appspot.com/bug?extid=04babcefcd396fabec37
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+04babcefcd396fabec37@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in x25_kill_by_device net/x25/af_x25.c:217  
[inline]
BUG: KASAN: use-after-free in x25_device_event+0x297/0x2b0  
net/x25/af_x25.c:252
Read of size 8 at addr ffff8881b5c85ad0 by task syz-executor2/22350

CPU: 1 PID: 22350 Comm: syz-executor2 Not tainted 4.20.0-rc7+ #248
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  x25_kill_by_device net/x25/af_x25.c:217 [inline]
  x25_device_event+0x297/0x2b0 net/x25/af_x25.c:252
  notifier_call_chain+0x17e/0x380 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1733
  call_netdevice_notifiers net/core/dev.c:1751 [inline]
  __dev_notify_flags+0x29b/0x480 net/core/dev.c:7547
  dev_change_flags+0xfd/0x150 net/core/dev.c:7581
  dev_ifsioc+0x7d6/0xa80 net/core/dev_ioctl.c:237
  dev_ioctl+0x1b5/0xcc0 net/core/dev_ioctl.c:488
  sock_do_ioctl+0x1f6/0x420 net/socket.c:973
  sock_ioctl+0x313/0x690 net/socket.c:1074
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457759
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4c06d4fc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457759
RDX: 00000000200005c0 RSI: 0000000000008914 RDI: 0000000000000005
RBP: 000000000073bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4c06d506d4
R13: 00000000004c2c32 R14: 00000000004d52f8 R15: 00000000ffffffff

Allocated by task 10606:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:546 [inline]
  x25_link_device_up+0xb2/0x500 net/x25/x25_link.c:249
  x25_device_event+0x116/0x2b0 net/x25/af_x25.c:242
  notifier_call_chain+0x17e/0x380 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1733
  call_netdevice_notifiers net/core/dev.c:1751 [inline]
  __dev_notify_flags+0x17a/0x480 net/core/dev.c:7545
  dev_change_flags+0xfd/0x150 net/core/dev.c:7581
  dev_ifsioc+0x7d6/0xa80 net/core/dev_ioctl.c:237
  dev_ioctl+0x1b5/0xcc0 net/core/dev_ioctl.c:488
  sock_do_ioctl+0x1f6/0x420 net/socket.c:973
  sock_ioctl+0x313/0x690 net/socket.c:1074
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 22299:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  x25_neigh_put include/net/x25.h:253 [inline]
  __x25_remove_neigh+0x233/0x310 net/x25/x25_link.c:290
  x25_link_device_down+0xc7/0x130 net/x25/x25_link.c:308
  x25_device_event+0x262/0x2b0 net/x25/af_x25.c:254
  notifier_call_chain+0x17e/0x380 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1733
  call_netdevice_notifiers net/core/dev.c:1751 [inline]
  __dev_notify_flags+0x29b/0x480 net/core/dev.c:7547
  dev_change_flags+0xfd/0x150 net/core/dev.c:7581
  dev_ifsioc+0x7d6/0xa80 net/core/dev_ioctl.c:237
  dev_ioctl+0x1b5/0xcc0 net/core/dev_ioctl.c:488
  sock_do_ioctl+0x1f6/0x420 net/socket.c:973
  sock_ioctl+0x313/0x690 net/socket.c:1074
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881b5c85ac0
  which belongs to the cache kmalloc-256 of size 256
The buggy address is located 16 bytes inside of
  256-byte region [ffff8881b5c85ac0, ffff8881b5c85bc0)
The buggy address belongs to the page:
page:ffffea0006d72140 count:1 mapcount:0 mapping:ffff8881da8007c0  
index:0xffff8881b5c85e80
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea00075f33c8 ffffea000731be48 ffff8881da8007c0
raw: ffff8881b5c85e80 ffff8881b5c850c0 0000000100000008 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881b5c85980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881b5c85a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881b5c85a80: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                  ^
  ffff8881b5c85b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881b5c85b80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
