Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2CD13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A0320873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A0320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbeG3QDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:03:20 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:55126 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbeG3QDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:03:19 -0400
Received: by mail-it0-f69.google.com with SMTP id l8-v6so12686257ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 07:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JBaaMaaz6HGlOwsGRfZlaHBHc4T3KPGB+KRUNYsZxNU=;
        b=WSkfIDxcCyvua8S/fc1O+eVy66g6AAf5yH/kgkz0H4UJRt7Kl4ZvyxwrgUUYGRVanI
         kHylWf7DR4aTKxhDD9yHXZ+EFcdQ/tjGPLjW1Bz94kmFychzbyPmB8RYyUFkxYtigVVG
         q6OGcMxEZG+W635+C86leKnHPh0XuvcV6N27F8N2EfxFCJhfV55dltBDZyfUgg5M4or5
         VHBgufQe7Cwsific8VVxRoQgi2BY0b1aR0G3/hkwmmY17hFZtcgOjtMIXB6OhI2FhdTo
         a71wsnuvnzx4NB4aWuURWDsjNP0P4w4A5xjTK+fRn3zS2WAwlXF/fme8uIPiEmRwkweH
         T/Aw==
X-Gm-Message-State: AOUpUlHUYpHz5zcR8wxSql8qoQ1z3JmpxtvCSrtu5LjB4xk041gzcBjx
        IisSmWKRm0civWH7k450prOnTgpsmgU97UQbTVkL6hA4m81+
X-Google-Smtp-Source: AAOMgpcAgugcqnNzv7prgmo5zKM9IOZGxpDEGkO6AQ+ZcYMS2EHWz8LiAzUm0Raw2jRBqo8u/cuQRqB6n1du2eIPmacogAv2CkF6
MIME-Version: 1.0
X-Received: by 2002:a24:6e8e:: with SMTP id w136-v6mr2528500itc.10.1532960883731;
 Mon, 30 Jul 2018 07:28:03 -0700 (PDT)
Date:   Mon, 30 Jul 2018 07:28:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000edfb4b057238448c@google.com>
Subject: KASAN: use-after-free Read in finish_wait (2)
From:   syzbot <syzbot+0bace015a67c7862c2cb@syzkaller.appspotmail.com>
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

HEAD commit:    19725496da56 Merge ra.kernel.org:/pub/scm/linux/kernel/git..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16ac69a4400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee7720ff122639ee
dashboard link: https://syzkaller.appspot.com/bug?extid=0bace015a67c7862c2cb
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0bace015a67c7862c2cb@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __list_del_entry_valid+0xf1/0xf3  
lib/list_debug.c:51
Read of size 8 at addr ffff8801d025f278 by task kworker/0:1/25

CPU: 0 PID: 25 Comm: kworker/0:1 Not tainted 4.18.0-rc6+ #140
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events smc_tcp_listen_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __list_del_entry_valid+0xf1/0xf3 lib/list_debug.c:51
  __list_del_entry include/linux/list.h:117 [inline]
  list_del_init include/linux/list.h:159 [inline]
  finish_wait+0x128/0x430 kernel/sched/wait.c:365
  inet_csk_wait_for_connect net/ipv4/inet_connection_sock.c:418 [inline]
  inet_csk_accept+0x6d0/0xe70 net/ipv4/inet_connection_sock.c:451
  inet_accept+0x138/0xa00 net/ipv4/af_inet.c:735
  kernel_accept+0x136/0x310 net/socket.c:3251
  smc_clcsock_accept net/smc/af_smc.c:832 [inline]
  smc_tcp_listen_work+0x222/0xef0 net/smc/af_smc.c:1296
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

Allocated by task 19352:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  sock_alloc_inode+0xbc/0x320 net/socket.c:246
  alloc_inode+0x63/0x190 fs/inode.c:210
  new_inode_pseudo+0x71/0x1a0 fs/inode.c:895
  sock_alloc+0x41/0x270 net/socket.c:567
  __sock_create+0x175/0x940 net/socket.c:1250
  sock_create_kern+0x3b/0x50 net/socket.c:1332
  smc_create+0x141/0x360 net/smc/af_smc.c:1892
  __sock_create+0x53c/0x940 net/socket.c:1286
  sock_create net/socket.c:1326 [inline]
  __sys_socket+0x106/0x260 net/socket.c:1356
  __do_sys_socket net/socket.c:1365 [inline]
  __se_sys_socket net/socket.c:1363 [inline]
  __x64_sys_socket+0x73/0xb0 net/socket.c:1363
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 19352:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  __rcu_reclaim kernel/rcu/rcu.h:173 [inline]
  rcu_do_batch kernel/rcu/tree.c:2558 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2818 [inline]
  __rcu_process_callbacks kernel/rcu/tree.c:2785 [inline]
  rcu_process_callbacks+0x1004/0x1850 kernel/rcu/tree.c:2802
  __do_softirq+0x2e8/0xb17 kernel/softirq.c:292

The buggy address belongs to the object at ffff8801d025f240
  which belongs to the cache kmalloc-128 of size 128
The buggy address is located 56 bytes inside of
  128-byte region [ffff8801d025f240, ffff8801d025f2c0)
The buggy address belongs to the page:
page:ffffea00074097c0 count:1 mapcount:0 mapping:ffff8801dac00640 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0006c2a188 ffffea00072ca2c8 ffff8801dac00640
raw: 0000000000000000 ffff8801d025f000 0000000100000015 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d025f100: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8801d025f180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801d025f200: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                                 ^
  ffff8801d025f280: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8801d025f300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
