Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FACC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CEB2170F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CEB2170F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeHHJz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 05:55:29 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:45058 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbeHHJz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 05:55:28 -0400
Received: by mail-io0-f200.google.com with SMTP id l24-v6so974707ioj.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 00:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=yRSExwfwHwgeE/1/Qz3aGRUBfOn0XVQ30g8Z+h8/HMk=;
        b=Z3arbeRtA2W/7u/vM9rNQ2hBKCReyhXY5rVO43kw5y/YWqalxb7zztv8chnhhNxHN3
         yo5aQ/yTlhQE3Ap3pXOB3O2BUxZN8r9sZo6PcrV7/ecez392jK3d2YAAqRJN4C4I/RHQ
         UOeTk9WejpBEXDaQPmJuW6jouzY1aQaXTMW91DwhwDsXgRZzut3NdEF6srurpCJ9v7+2
         tMeVOBonoYU3OGv0PHCLJe9YU1sCImyMahomCdSKOg8XK8IwPvWZRMVfN3Mw4fAMQ79+
         wGU0wmjaNIwX8udrSg30q2VuScMQYm4f7didN9PpTqjubBW63hGkyRnZTAE+Q9XosUzX
         iWGw==
X-Gm-Message-State: AOUpUlFXIsLg8QhEIHtle2N+MOpOul8HYtt/5vNGnCn/+vrj6OgG6/Hm
        lOhcth7tRfW7rXGRPF5y3v1gIPsQZqo6NMzVjgkSvVo1XciI
X-Google-Smtp-Source: AA+uWPzDzPHe4/LtcvlIHxofv1Yn6bNz76qaA8ntTnZCW6rf+QTuJ5yivAe3NLwKd+lekO+bpb5qu2jlAFoqYF/DXzOEXlpqdrcR
MIME-Version: 1.0
X-Received: by 2002:a24:76c9:: with SMTP id z192-v6mr648762itb.29.1533713822764;
 Wed, 08 Aug 2018 00:37:02 -0700 (PDT)
Date:   Wed, 08 Aug 2018 00:37:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097dba80572e7931d@google.com>
Subject: KASAN: use-after-free Read in __rhashtable_lookup
From:   syzbot <syzbot+c6369755db236fb370e7@syzkaller.appspotmail.com>
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

HEAD commit:    a394b3af206c ppp: mppe: Remove VLA usage
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1335d6f0400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb640e89c1953f27
dashboard link: https://syzkaller.appspot.com/bug?extid=c6369755db236fb370e7
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c6369755db236fb370e7@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in memcmp+0xe8/0x150 lib/string.c:861
Read of size 1 at addr ffff8801d811ec30 by task syz-executor6/10904

CPU: 1 PID: 10904 Comm: syz-executor6 Not tainted 4.18.0-rc7+ #169
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  memcmp+0xe8/0x150 lib/string.c:861
  memcmp include/linux/string.h:386 [inline]
  rhashtable_compare include/linux/rhashtable.h:462 [inline]
  __rhashtable_lookup.isra.8.constprop.19+0x70f/0xd50  
include/linux/rhashtable.h:484
  rhashtable_lookup include/linux/rhashtable.h:516 [inline]
  rhashtable_lookup_fast include/linux/rhashtable.h:542 [inline]
  rds_add_bound net/rds/bind.c:117 [inline]
  rds_bind+0x7c9/0x1510 net/rds/bind.c:238
  __sys_bind+0x331/0x440 net/socket.c:1500
  __do_sys_bind net/socket.c:1511 [inline]
  __se_sys_bind net/socket.c:1509 [inline]
  __x64_sys_bind+0x73/0xb0 net/socket.c:1509
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x456b29
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6ae7f39c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 00007f6ae7f3a6d4 RCX: 0000000000456b29
RDX: 0000000000000010 RSI: 0000000020000840 RDI: 0000000000000014
RBP: 0000000000930140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004ca698 R14: 00000000004c26f1 R15: 0000000000000001

Allocated by task 10898:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
  sk_prot_alloc+0x69/0x2e0 net/core/sock.c:1462
  sk_alloc+0x106/0x17b0 net/core/sock.c:1522
  rds_create+0x14f/0x770 net/rds/af_rds.c:666
  __sock_create+0x53c/0x940 net/socket.c:1294
  sock_create net/socket.c:1334 [inline]
  __sys_socket+0x106/0x260 net/socket.c:1364
  __do_sys_socket net/socket.c:1373 [inline]
  __se_sys_socket net/socket.c:1371 [inline]
  __x64_sys_socket+0x73/0xb0 net/socket.c:1371
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 10895:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
  sk_prot_free net/core/sock.c:1503 [inline]
  __sk_destruct+0x70a/0xa60 net/core/sock.c:1587
  sk_destruct+0x78/0x90 net/core/sock.c:1595
  __sk_free+0xcf/0x300 net/core/sock.c:1606
  sk_free+0x42/0x50 net/core/sock.c:1617
  sock_put include/net/sock.h:1691 [inline]
  rds_release+0x3e9/0x570 net/rds/af_rds.c:91
  __sock_release+0xd7/0x250 net/socket.c:598
  sock_close+0x19/0x20 net/socket.c:1158
  __fput+0x355/0x8b0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:192 [inline]
  exit_to_usermode_loop+0x313/0x370 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801d811e7c0
  which belongs to the cache RDS of size 1608
The buggy address is located 1136 bytes inside of
  1608-byte region [ffff8801d811e7c0, ffff8801d811ee08)
The buggy address belongs to the page:
page:ffffea0007604780 count:1 mapcount:0 mapping:ffff8801cd8a0300 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801cd89f348 ffffea000716f8c8 ffff8801cd8a0300
raw: 0000000000000000 ffff8801d811e0c0 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d811eb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d811eb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801d811ec00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                      ^
  ffff8801d811ec80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d811ed00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
