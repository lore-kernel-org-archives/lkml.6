Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EBEC64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 07:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9A420875
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 07:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9A420875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeJFOjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 10:39:21 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:34460 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbeJFOjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 10:39:21 -0400
Received: by mail-io1-f71.google.com with SMTP id y3-v6so14249336iob.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 00:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=q/un/j6KCmqUjx5alDexbhntQd5OdYpTxDCIoOHWpUQ=;
        b=Odih9Xuf9c7o/uvcj5U73KCyvU2k7RMahV6GYjKmoN5O1ypKQriFhSvh2gx7nCS+Ct
         iVvuBjE/3tgaJw+EBBT650cWEbabmzE0nedFfU5cBEFr9L1CbMg84DrPT/YE7Z38bHwq
         fF83lOq7KZ9fvm1guvwYUvRXqi9Ld/OKKqzj+ib+GJ59e2MSbClDBXp0iOPqPdVC80kE
         HWVJfZN07QKOaXg59Cc/kmNEWqpwhah4NkOoKdNVtRg5BRApMAqlTl7/ufaw4x32x9V7
         i6W/O7OwH1dfMgd4/GFjyVUYbIJaZSDvqF5w4/5bnXGgaRVjLEJQ128Vl5AxMOoDCnSC
         snlA==
X-Gm-Message-State: ABuFfogkdVAxHewHBVVp9skkL+vSIapeg2vJMk1yGBzfR0/Wja6UZ1kN
        jub/VdrbD+Q2tyUtzY2UQeKAUfn39ZE7NQqXCFFmxMjK1d2H
X-Google-Smtp-Source: ACcGV61AytknWI/qYEuAdEAdI16VPCxzLG0/cdFQpT3T3xLqHlRtEOiwyjSHaS3lYJFZ1n5TpINFJeOI7jyYWBh23CAAQ3qdy6bK
MIME-Version: 1.0
X-Received: by 2002:a6b:c786:: with SMTP id x128-v6mr10238764iof.1.1538811423738;
 Sat, 06 Oct 2018 00:37:03 -0700 (PDT)
Date:   Sat, 06 Oct 2018 00:37:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000049d7e605778a7402@google.com>
Subject: KASAN: use-after-free Read in af_alg_wmem_wakeup
From:   syzbot <syzbot+087a5bddc4565427739e@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    befad944e231 Merge tag 'drm-fixes-2018-10-05' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=159f6bc6400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0af03fe452b65fb
dashboard link: https://syzkaller.appspot.com/bug?extid=087a5bddc4565427739e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+087a5bddc4565427739e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in af_alg_sndbuf include/crypto/if_alg.h:190  
[inline]
BUG: KASAN: use-after-free in af_alg_writable include/crypto/if_alg.h:204  
[inline]
BUG: KASAN: use-after-free in af_alg_wmem_wakeup+0x711/0x7d0  
crypto/af_alg.c:731
Read of size 8 at addr ffff880186c705f0 by task syz-executor1/21582

CPU: 0 PID: 21582 Comm: syz-executor1 Not tainted 4.19.0-rc6+ #268
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  af_alg_sndbuf include/crypto/if_alg.h:190 [inline]
  af_alg_writable include/crypto/if_alg.h:204 [inline]
  af_alg_wmem_wakeup+0x711/0x7d0 crypto/af_alg.c:731
  aead_recvmsg+0x53e/0x1ba0 crypto/algif_aead.c:354
  sock_recvmsg_nosec net/socket.c:794 [inline]
  sock_recvmsg+0xd0/0x110 net/socket.c:801
  sock_read_iter+0x39b/0x570 net/socket.c:878
  call_read_iter include/linux/fs.h:1802 [inline]
  aio_read+0x297/0x490 fs/aio.c:1516
  io_submit_one+0xac2/0xf80 fs/aio.c:1832
  __do_sys_io_submit fs/aio.c:1916 [inline]
  __se_sys_io_submit fs/aio.c:1887 [inline]
  __x64_sys_io_submit+0x1b7/0x580 fs/aio.c:1887
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457579
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2c2b30bc78 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457579
RDX: 0000000020001440 RSI: 0000000000000002 RDI: 00007f2c2b2eb000
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2c2b30c6d4
R13: 00000000004be741 R14: 00000000004ce380 R15: 00000000ffffffff

Allocated by task 21585:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3718 [inline]
  __kmalloc+0x14e/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:518 [inline]
  sk_prot_alloc+0x1b0/0x2e0 net/core/sock.c:1468
  sk_alloc+0x10d/0x1690 net/core/sock.c:1522
  af_alg_accept+0x9d/0x7d0 crypto/af_alg.c:287
  alg_accept+0x46/0x60 crypto/af_alg.c:332
  __sys_accept4+0x3b2/0x8a0 net/socket.c:1590
  __do_sys_accept4 net/socket.c:1625 [inline]
  __se_sys_accept4 net/socket.c:1622 [inline]
  __x64_sys_accept4+0x97/0xf0 net/socket.c:1622
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 21580:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3813
  sk_prot_free net/core/sock.c:1505 [inline]
  __sk_destruct+0x797/0xa80 net/core/sock.c:1587
  sk_destruct+0x78/0x90 net/core/sock.c:1595
  __sk_free+0xcf/0x300 net/core/sock.c:1606
  sk_free+0x42/0x50 net/core/sock.c:1617
  sock_put include/net/sock.h:1691 [inline]
  af_alg_release+0x6e/0x90 crypto/af_alg.c:126
  __sock_release+0xd7/0x250 net/socket.c:579
  sock_close+0x19/0x20 net/socket.c:1141
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff880186c70180
  which belongs to the cache kmalloc-2048 of size 2048
The buggy address is located 1136 bytes inside of
  2048-byte region [ffff880186c70180, ffff880186c70980)
The buggy address belongs to the page:
page:ffffea00061b1c00 count:1 mapcount:0 mapping:ffff8801da800c40 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea0007266508 ffffea0006129088 ffff8801da800c40
raw: 0000000000000000 ffff880186c70180 0000000100000003 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff880186c70480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff880186c70500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff880186c70580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                              ^
  ffff880186c70600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff880186c70680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
