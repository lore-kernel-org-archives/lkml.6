Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92851C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3007624082
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3007624082
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753586AbeGFHgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:36:04 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:55932 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753225AbeGFHgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:36:03 -0400
Received: by mail-it0-f71.google.com with SMTP id k13-v6so7393776ite.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 00:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=aN5hr36nULMr+xj4z5PhonN9QmERjBvnPu1Bep2f+4M=;
        b=mc6NL9bPyGC+sUfkHVsdw8m3U+ZfflzWtwvvNA9k69NmXVipB9p8PZhU4ySX8WNZCT
         y8MMh3eERYcuohWER8o7E+IcuQ21hL1K0t2Qc86ROhIN3eqkAKzswCMwlowa7cb4Y9dR
         W56OxcO1SnmZ9hrEDAhx8AHZDqNSCuvVL/vZKiSjoETiJQ1fKUfgTCEZvO8vhcIp92yg
         Egmw6BzvXwU5zQdN2Zmm7Q6SzjhBYvf3qTNUC/hwr4XwCfLlvllwndNqdEKBVKcccWZ/
         suw/OaWaO6CWcz1Q6Cg5l9GeUD+7RVCdB3sny1PADRef0BiJ05mXN1yGQylE6RGd4qZ1
         0hsA==
X-Gm-Message-State: APt69E2FA/23WA13SJKhNMUMo84rMqC3LAZrcllL/KPIOBgZWyifnlqO
        g4DegxmvOZIQRXUxkwuNolsXrTHrFR8jbamhScezTlybqJrF
X-Google-Smtp-Source: AAOMgpf/dRNdiiI19Ku2OsNxAEXRMpmz/2jNcpJoLDPC/BT9PXSHhHQrICSofihtqu4oDN0Je6m1RM3cJsxHtB/B4uwSHhgqt1KK
MIME-Version: 1.0
X-Received: by 2002:a24:ca:: with SMTP id 193-v6mr3827354ita.45.1530862562544;
 Fri, 06 Jul 2018 00:36:02 -0700 (PDT)
Date:   Fri, 06 Jul 2018 00:36:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003dab1605704fb71d@google.com>
Subject: KASAN: use-after-free Read in tls_write_space
From:   syzbot <syzbot+2134b6b74dec9f8c760f@syzkaller.appspotmail.com>
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

HEAD commit:    1a84d7fdb5fc Merge branch 'mlxsw-Add-resource-scale-tests'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17dec75c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a63be0c83e84d370
dashboard link: https://syzkaller.appspot.com/bug?extid=2134b6b74dec9f8c760f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2134b6b74dec9f8c760f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in tls_write_space+0x2c2/0x360  
net/tls/tls_main.c:225
Read of size 1 at addr ffff8801d6eb35e0 by task syz-executor0/9404

CPU: 1 PID: 9404 Comm: syz-executor0 Not tainted 4.18.0-rc2+ #99
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  tls_write_space+0x2c2/0x360 net/tls/tls_main.c:225
  tcp_new_space net/ipv4/tcp_input.c:5071 [inline]
  tcp_check_space+0x551/0x930 net/ipv4/tcp_input.c:5082
  tcp_data_snd_check net/ipv4/tcp_input.c:5092 [inline]
  tcp_rcv_established+0x8db/0x2180 net/ipv4/tcp_input.c:5571
  tcp_v6_do_rcv+0x421/0x13a0 net/ipv6/tcp_ipv6.c:1325
  sk_backlog_rcv include/net/sock.h:914 [inline]
  __release_sock+0x12f/0x3a0 net/core/sock.c:2342
  release_sock+0xad/0x2c0 net/core/sock.c:2851
  tls_sk_proto_close+0x6e6/0xae0 net/tls/tls_main.c:302
  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:427
  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:459
  __sock_release+0xd7/0x260 net/socket.c:603
  sock_close+0x19/0x20 net/socket.c:1186
  __fput+0x35b/0x8b0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1b08/0x2750 kernel/exit.c:865
  do_group_exit+0x177/0x440 kernel/exit.c:968
  get_signal+0x88e/0x1970 kernel/signal.c:2468
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e0/0x370 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455a99
Code: Bad RIP value.
RSP: 002b:00007f4377320c68 EFLAGS: 00000246 ORIG_RAX: 000000000000002b
RAX: fffffffffffffe00 RBX: 00007f43773216d4 RCX: 0000000000455a99
RDX: 0000000020000040 RSI: 0000000020000200 RDI: 0000000000000017
RBP: 000000000072c098 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004bb3d4 R14: 00000000004c7e60 R15: 0000000000000003

Allocated by task 9402:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  create_ctx net/tls/tls_main.c:535 [inline]
  tls_init+0x1e7/0xb20 net/tls/tls_main.c:659
  tcp_set_ulp+0x1bc/0x520 net/ipv4/tcp_ulp.c:153
  do_tcp_setsockopt.isra.41+0x44a/0x2680 net/ipv4/tcp.c:2741
  tcp_setsockopt+0xc1/0xe0 net/ipv4/tcp.c:3052
  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3040
  __sys_setsockopt+0x1c5/0x3b0 net/socket.c:1947
  __do_sys_setsockopt net/socket.c:1958 [inline]
  __se_sys_setsockopt net/socket.c:1955 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1955
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9404:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  tls_sk_proto_close+0x712/0xae0 net/tls/tls_main.c:297
  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:427
  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:459
  __sock_release+0xd7/0x260 net/socket.c:603
  sock_close+0x19/0x20 net/socket.c:1186
  __fput+0x35b/0x8b0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1b08/0x2750 kernel/exit.c:865
  do_group_exit+0x177/0x440 kernel/exit.c:968
  get_signal+0x88e/0x1970 kernel/signal.c:2468
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e0/0x370 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801d6eb3500
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 224 bytes inside of
  512-byte region [ffff8801d6eb3500, ffff8801d6eb3700)
The buggy address belongs to the page:
page:ffffea00075bacc0 count:1 mapcount:0 mapping:ffff8801da800940 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea00075d1388 ffffea000750dcc8 ffff8801da800940
raw: 0000000000000000 ffff8801d6eb3000 0000000100000006 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d6eb3480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801d6eb3500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801d6eb3580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                        ^
  ffff8801d6eb3600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d6eb3680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
