Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B48C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E2E20700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbfBUOrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:47:11 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:40698 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbfBUOrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:47:05 -0500
Received: by mail-io1-f72.google.com with SMTP id 68so1293443iov.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 06:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nxLCM6LwSwVkSFiKd43Ee+M7gsUO7RI/24t3WqG9UDc=;
        b=BGPM1k42KLLF8bBYenhPIrg+L7nGYFK4W9mKx1N1Pjq6/41Ja+WWU0QEmLy1/MKIch
         KPSItFsFvPz/8awvr2Ry67EBqr62U3gQb6DKSHjQQpBQEjA+m6HVkTBgGS3UvEVa0jIW
         KKNQt8tkMhS16if6C06kGCVXiophiKJaK0yK5BF4lbIF8mj600KZHKeIVGgrurPYXN/7
         Z3DtT4o+K+/zh1vb4DJyS8YmrKOsfXOsSeKSWeqVot0apZbkHYcK5fBx+Te9citkOgUP
         EELaDbRo+sODqIKvgccrrQaxaAZHq0tmcPDq1lf+judSfSBodkaJY1665FfevvE3O4gc
         8mxQ==
X-Gm-Message-State: AHQUAubdtbHbW+RUHDJh705nZ5RuXbWFEz32fqBuLzC+2jVk4KbdDvDu
        9J1K2HINaunx7FgVLQEKkJ2/64hGDHF5FeT7Ox6F9Gaq596E
X-Google-Smtp-Source: AHgI3IavJmGOQKwpAxbY/ZQFzw0hdhU4h8V17mQcm/9nVoBBGBDMlNLUq6S34kF3aRPu3x7h/XaSgqFFRyYBc+iAjb0uPobf7oEI
MIME-Version: 1.0
X-Received: by 2002:a24:655:: with SMTP id 82mr9310554itv.24.1550760423850;
 Thu, 21 Feb 2019 06:47:03 -0800 (PST)
Date:   Thu, 21 Feb 2019 06:47:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003209980582688c5b@google.com>
Subject: KASAN: slab-out-of-bounds Read in ip6_hold_safe
From:   syzbot <syzbot+ec03ae3a032901d10434@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b71acb0e3721 Merge branch 'linus' of git://git.kernel.org/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1672a39b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b03c5892bb940c76
dashboard link: https://syzkaller.appspot.com/bug?extid=ec03ae3a032901d10434
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ec03ae3a032901d10434@syzkaller.appspotmail.com

kernel msg: ebtables bug: please report to author: EBT_ENTRY_OR_ENTRIES  
shouldn't be set in distinguisher
==================================================================
BUG: KASAN: slab-out-of-bounds in atomic_read  
include/asm-generic/atomic-instrumented.h:21 [inline]
BUG: KASAN: slab-out-of-bounds in atomic_fetch_add_unless  
include/linux/atomic.h:575 [inline]
BUG: KASAN: slab-out-of-bounds in atomic_add_unless  
include/linux/atomic.h:597 [inline]
BUG: KASAN: slab-out-of-bounds in dst_hold_safe include/net/dst.h:308  
[inline]
BUG: KASAN: slab-out-of-bounds in ip6_hold_safe+0xca/0x620  
net/ipv6/route.c:1021
Read of size 4 at addr ffff88806b399ccc by task ksoftirqd/1/16

CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 4.20.0+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report mm/kasan/report.c:412 [inline]
  kasan_report.cold+0x8c/0x2ba mm/kasan/report.c:396
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x123/0x190 mm/kasan/kasan.c:267
  kasan_check_read+0x11/0x20 mm/kasan/kasan.c:272
  atomic_read include/asm-generic/atomic-instrumented.h:21 [inline]
  atomic_fetch_add_unless include/linux/atomic.h:575 [inline]
  atomic_add_unless include/linux/atomic.h:597 [inline]
  dst_hold_safe include/net/dst.h:308 [inline]
  ip6_hold_safe+0xca/0x620 net/ipv6/route.c:1021
  rt6_get_pcpu_route net/ipv6/route.c:1241 [inline]
  ip6_pol_route+0x3a3/0x1490 net/ipv6/route.c:1890
  ip6_pol_route_input+0x65/0x80 net/ipv6/route.c:1909
  fib6_rule_lookup+0x12f/0x870 net/ipv6/fib6_rules.c:118
  ip6_route_input_lookup+0xb7/0xd0 net/ipv6/route.c:1921
  ip6_route_input+0x79b/0xe00 net/ipv6/route.c:2056
  ip6_rcv_finish_core.isra.0+0x204/0x720 net/ipv6/ip6_input.c:63
  ip6_rcv_finish+0x109/0x330 net/ipv6/ip6_input.c:74
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ipv6_rcv+0x113/0x650 net/ipv6/ip6_input.c:272
  __netif_receive_skb_one_core+0x160/0x210 net/core/dev.c:4973
  __netif_receive_skb+0x2c/0x1c0 net/core/dev.c:5083
  process_backlog+0x206/0x750 net/core/dev.c:5923
  napi_poll net/core/dev.c:6346 [inline]
  net_rx_action+0x76d/0x1930 net/core/dev.c:6412
  __do_softirq+0x30b/0xb11 kernel/softirq.c:292
  run_ksoftirqd kernel/softirq.c:654 [inline]
  run_ksoftirqd+0x8e/0x110 kernel/softirq.c:646
  smpboot_thread_fn+0x6ab/0xa10 kernel/smpboot.c:164
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Allocated by task 3862:
  save_stack+0x45/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc mm/kasan/kasan.c:553 [inline]
  kasan_kmalloc+0xce/0xf0 mm/kasan/kasan.c:531
  kasan_slab_alloc+0xf/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x700 mm/slab.c:3554
  getname_flags fs/namei.c:140 [inline]
  getname_flags+0xd6/0x5b0 fs/namei.c:129
  user_path_at_empty+0x2f/0x50 fs/namei.c:2608
  do_readlinkat+0x141/0x400 fs/stat.c:397
  __do_sys_readlink fs/stat.c:430 [inline]
  __se_sys_readlink fs/stat.c:427 [inline]
  __x64_sys_readlink+0x78/0xb0 fs/stat.c:427
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 3862:
  save_stack+0x45/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x260 mm/slab.c:3760
  putname+0xef/0x130 fs/namei.c:261
  filename_lookup+0x359/0x530 fs/namei.c:2357
  user_path_at_empty+0x43/0x50 fs/namei.c:2608
  do_readlinkat+0x141/0x400 fs/stat.c:397
  __do_sys_readlink fs/stat.c:430 [inline]
  __se_sys_readlink fs/stat.c:427 [inline]
  __x64_sys_readlink+0x78/0xb0 fs/stat.c:427
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88806b398440
  which belongs to the cache names_cache of size 4096
The buggy address is located 2188 bytes to the right of
  4096-byte region [ffff88806b398440, ffff88806b399440)
The buggy address belongs to the page:
page:ffffea0001ace600 count:1 mapcount:0 mapping:ffff88812c2bec40 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea0002310008 ffffea0002a06988 ffff88812c2bec40
raw: 0000000000000000 ffff88806b398440 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88806b399b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88806b399c00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff88806b399c80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                               ^
  ffff88806b399d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88806b399d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
