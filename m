Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF7DECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B100620852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B100620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388192AbeGWScR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:32:17 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:55067 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388002AbeGWScR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:32:17 -0400
Received: by mail-it0-f71.google.com with SMTP id l8-v6so1385527ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 10:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5xgtIgkFFkgLjt0Td1si6NWhJWd+RuJC9QX6Xw8TZx0=;
        b=NVcWmBStOhB3XHF4EhmC59RlerkvyxnBdf6CQxGJmIIYAwwS0FT4mxnLsUmnJ+9ZBp
         uaab3T9JN10CByJONMjMisG3xo1ZE6IXb8sztYougSUObN+ic/yFFbB71yFIKQv5xjT+
         7QhyfT4iihAB7i5uts7RgHjNVbfVipSNwG+oV0pPpBmc4U+dCDX0oF2RjP/rw8i8TbT9
         79Qrakne7ClLllG9lFByS+JZn9Y87WbdguV312g6bXK549oMgvmBAokwE3xexbgxvSvj
         N/XY84hh5pszHLt7mjYXplm6vPtrf0iZN5/LaJ8YhbTcYyPmtCp0LPewaMfQGDt9pRxS
         gRpQ==
X-Gm-Message-State: AOUpUlGw4lzRdlgWZQZ+PI3t0NxH+qt11NOQnPv6kwaC0kGVyeYWEFbV
        9uiIpCf7ujBtRXMRIIWGEj4TI3+L8BEjbJU33ml7uvfSC4p2
X-Google-Smtp-Source: AAOMgpfbkrNe8+3sQN6LFRxGKev4xSHX2oVkMrW9/M/PaJErtwmlwAIwBM0ovqgVm9Cer8/Nb+j8PXPSVGaJpEsd13P2UeIuc7ZS
MIME-Version: 1.0
X-Received: by 2002:a24:b14a:: with SMTP id c10-v6mr6412910itj.4.1532367001724;
 Mon, 23 Jul 2018 10:30:01 -0700 (PDT)
Date:   Mon, 23 Jul 2018 10:30:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cdb5450571adfe40@google.com>
Subject: KASAN: use-after-free Read in rds_cong_queue_updates (2)
From:   syzbot <syzbot+470ae97a39f16146af45@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, santosh.shilimkar@oracle.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fcf4793e278e tls: check RCV_SHUTDOWN in tls_wait_data
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1738cb2c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0bdc4175608181c
dashboard link: https://syzkaller.appspot.com/bug?extid=470ae97a39f16146af45
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+470ae97a39f16146af45@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic_read  
include/asm-generic/atomic-instrumented.h:21 [inline]
BUG: KASAN: use-after-free in refcount_read include/linux/refcount.h:42  
[inline]
BUG: KASAN: use-after-free in check_net include/net/net_namespace.h:237  
[inline]
BUG: KASAN: use-after-free in rds_destroy_pending net/rds/rds.h:902 [inline]
BUG: KASAN: use-after-free in rds_cong_queue_updates+0x25d/0x5b0  
net/rds/cong.c:226
Read of size 4 at addr ffff88019f180144 by task kworker/u4:1/23

CPU: 1 PID: 23 Comm: kworker/u4:1 Not tainted 4.18.0-rc5+ #18
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: krdsd rds_send_worker
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  kasan_check_read+0x11/0x20 mm/kasan/kasan.c:272
  atomic_read include/asm-generic/atomic-instrumented.h:21 [inline]
  refcount_read include/linux/refcount.h:42 [inline]
  check_net include/net/net_namespace.h:237 [inline]
  rds_destroy_pending net/rds/rds.h:902 [inline]
  rds_cong_queue_updates+0x25d/0x5b0 net/rds/cong.c:226
  rds_recv_rcvbuf_delta.part.3+0x332/0x3e0 net/rds/recv.c:123
  rds_recv_rcvbuf_delta net/rds/recv.c:382 [inline]
  rds_recv_incoming+0x85a/0x1320 net/rds/recv.c:382
  rds_loop_xmit+0x16a/0x340 net/rds/loop.c:95
  rds_send_xmit+0x1343/0x29c0 net/rds/send.c:355
  rds_send_worker+0x153/0x300 net/rds/threads.c:199
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

Allocated by task 4564:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
  kmem_cache_zalloc include/linux/slab.h:697 [inline]
  net_alloc net/core/net_namespace.c:383 [inline]
  copy_net_ns+0x15b/0x4d0 net/core/net_namespace.c:423
  create_new_namespaces+0x6ad/0x900 kernel/nsproxy.c:107
  unshare_nsproxy_namespaces+0xc3/0x1f0 kernel/nsproxy.c:206
  ksys_unshare+0x723/0xfb0 kernel/fork.c:2419
  __do_sys_unshare kernel/fork.c:2487 [inline]
  __se_sys_unshare kernel/fork.c:2485 [inline]
  __x64_sys_unshare+0x31/0x40 kernel/fork.c:2485
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 23:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
  net_free net/core/net_namespace.c:399 [inline]
  net_drop_ns.part.14+0x129/0x150 net/core/net_namespace.c:406
  net_drop_ns net/core/net_namespace.c:405 [inline]
  cleanup_net+0x6bb/0xb50 net/core/net_namespace.c:541
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

The buggy address belongs to the object at ffff88019f180140
  which belongs to the cache net_namespace of size 8704
The buggy address is located 4 bytes inside of
  8704-byte region [ffff88019f180140, ffff88019f182340)
The buggy address belongs to the page:
page:ffffea00067c6000 count:1 mapcount:0 mapping:ffff8801d9be9e40 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea00067d5a08 ffffea00067b3a08 ffff8801d9be9e40
raw: 0000000000000000 ffff88019f180140 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88019f180000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88019f180080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff88019f180100: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                            ^
  ffff88019f180180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88019f180200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
