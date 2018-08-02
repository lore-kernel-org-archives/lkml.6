Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D4AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4A321501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4A321501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732532AbeHBO4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:56:10 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:58572 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732518AbeHBO4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:56:09 -0400
Received: by mail-it0-f71.google.com with SMTP id y13-v6so2054101ita.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 06:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bMP95q4QMGCiExrL7Vbxs89heiCIWAvl9nYCQA8m6Kk=;
        b=szO8SAUMXxDGZV87xSloj/+pV8v9N5LXt9CB+ocPeP/mxUQ2kIdQqrbogYovgIP2vE
         5KALXwioom1IwQk+2R15WgUayVX2veD5aMoxlXqkUJlWrhNEqj4FdBQpcafgVGt0760a
         lK3/KoH0kD9gE9jxojjj8x8f2xSdX+AedsCPE2AibOlMvlHzGskofRJnbZ+OUoq6yIbV
         lTmruLl0Qj3RzlV0sdrp3OWTvvAv1u1OmK4PrWXSSYzb73djLIcaJqFqly7HjNN7Czs5
         7S7CxrfS+UkO1gi+RxJj6lz/LBgaP5h/ooszEKwnivquT7jjAW4WdZIyrN36Bzo+Z0G8
         EIMw==
X-Gm-Message-State: AOUpUlEcB6wZnOoGlk5PXzo3gqPfGzuAB0DjjeYDV9JxA/y9pR17qEWz
        FL9slzu+wiq9t7x418AKOHrS5zahuneDGQi4gACN9vzHROvF
X-Google-Smtp-Source: AAOMgpecaJLJyWXaxEDD+kwI7otyk9ydzsqcdIOeUB2dnrKd9dclFX99edS/kNd1riCkFI+gT1lr//F7Dr8hq5pHEDzSDRket7C+
MIME-Version: 1.0
X-Received: by 2002:a6b:2712:: with SMTP id n18-v6mr1098728ion.90.1533215102186;
 Thu, 02 Aug 2018 06:05:02 -0700 (PDT)
Date:   Thu, 02 Aug 2018 06:05:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087c36f05727375d2@google.com>
Subject: KASAN: slab-out-of-bounds Write in tls_push_record (2)
From:   syzbot <syzbot+3d650eba9d63b8de7478@syzkaller.appspotmail.com>
To:     aviadye@mellanox.com, borisp@mellanox.com, davejwatson@fb.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    44960f2a7b63 staging: ashmem: Fix SIGBUS crash when traver..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f7ea72400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2dc0cd7c2eefb46f
dashboard link: https://syzkaller.appspot.com/bug?extid=3d650eba9d63b8de7478
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3d650eba9d63b8de7478@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in tls_fill_prepend include/net/tls.h:339  
[inline]
BUG: KASAN: slab-out-of-bounds in tls_push_record+0x1091/0x1400  
net/tls/tls_sw.c:239
Write of size 1 at addr ffff88019c5d8000 by task syz-executor2/11760

CPU: 0 PID: 11760 Comm: syz-executor2 Not tainted 4.18.0-rc7+ #172
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_store1_noabort+0x17/0x20 mm/kasan/report.c:435
  tls_fill_prepend include/net/tls.h:339 [inline]
  tls_push_record+0x1091/0x1400 net/tls/tls_sw.c:239
  tls_sw_push_pending_record+0x22/0x30 net/tls/tls_sw.c:276
  tls_handle_open_record net/tls/tls_main.c:164 [inline]
  tls_sk_proto_close+0x74c/0xae0 net/tls/tls_main.c:264
  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:427
  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:459
  __sock_release+0xd7/0x260 net/socket.c:600
  sock_close+0x19/0x20 net/socket.c:1151
  __fput+0x355/0x8b0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:192 [inline]
  exit_to_usermode_loop+0x313/0x370 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4105c1
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:0000000000a3feb0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000014 RCX: 00000000004105c1
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000013
RBP: 0000000000000010 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000a3fde0 R11: 0000000000000293 R12: 0000000000000000
R13: 000000000002fd87 R14: 0000000000000094 R15: badc0ffeebadface

Allocated by task 2597:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
  getname_flags+0xd0/0x5a0 fs/namei.c:140
  user_path_at_empty+0x2d/0x50 fs/namei.c:2584
  user_path_at include/linux/namei.h:57 [inline]
  vfs_statx+0x129/0x210 fs/stat.c:185
  vfs_stat include/linux/fs.h:3102 [inline]
  __do_sys_newstat+0x8f/0x110 fs/stat.c:337
  __se_sys_newstat fs/stat.c:333 [inline]
  __x64_sys_newstat+0x54/0x80 fs/stat.c:333
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 2597:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
  putname+0xf2/0x130 fs/namei.c:261
  filename_lookup+0x397/0x510 fs/namei.c:2330
  user_path_at_empty+0x40/0x50 fs/namei.c:2584
  user_path_at include/linux/namei.h:57 [inline]
  vfs_statx+0x129/0x210 fs/stat.c:185
  vfs_stat include/linux/fs.h:3102 [inline]
  __do_sys_newstat+0x8f/0x110 fs/stat.c:337
  __se_sys_newstat fs/stat.c:333 [inline]
  __x64_sys_newstat+0x54/0x80 fs/stat.c:333
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88019c5d8980
  which belongs to the cache names_cache of size 4096
The buggy address is located 2432 bytes to the left of
  4096-byte region [ffff88019c5d8980, ffff88019c5d9980)
The buggy address belongs to the page:
page:ffffea0006717600 count:1 mapcount:0 mapping:ffff8801dad85dc0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea0006470d88 ffffea0006717688 ffff8801dad85dc0
raw: 0000000000000000 ffff88019c5d8980 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88019c5d7f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff88019c5d7f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff88019c5d8000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                    ^
  ffff88019c5d8080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88019c5d8100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
