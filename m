Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2619C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 01:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A88208B4
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 01:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A88208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932688AbeGHB3G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 21:29:06 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:44446 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754408AbeGHB3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 21:29:03 -0400
Received: by mail-it0-f70.google.com with SMTP id z8-v6so12510183itc.9
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 18:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8nsSLodMZ3Em0FIwLxXnR6+m212tIDb4kZ+P9AXFakc=;
        b=jwx3YhAMu03aRZd1At6xOMJs6NugZf6yQ7Eqfw45gn4gNmBha6Q1nvKGDX2aGruFLH
         08LKV6sNdRwduYHUiy4lrnbpwbfT9hO1tvtaVNzXYQOsepLaZf4FSowpTWPaWXOBZvXp
         l3eharng320+HxixrAALi6uUEvq8wxB4GJmOiQZdzHA4fUR42HVDlElLeq20NXBq6FbR
         OZtKQwpcTWZYUZ1OH5FM8rdMF2Xi/FTuCxXOC3YRlnOP2cezh7hNRxqvsWtlOCRF7COB
         VKzEkxq/+/Rs6JTlSP4WPbFQarp7ABYfeqMA5V1yoqi6g5HZh3PXx03lX/9dnuCvVxsV
         InOg==
X-Gm-Message-State: AOUpUlHEHPkdgnj7iJGktDq8om65mwD2FXAdQFRcD2lrkLPYOdjuqsfU
        gibKLLL/aaPxINkbRFpzjAw4olojEuj+zrzK9HaHT5hkbAb1
X-Google-Smtp-Source: AAOMgpfsjVJPYZnBx5r0vb2KG40mTdh2NcPrRmqUg4dHOsQB5P8indezZ52W+SNMrPDuuqZ2fV6xsjxHwkhSyWliUrI9YWv3Hv+q
MIME-Version: 1.0
X-Received: by 2002:a6b:ea15:: with SMTP id m21-v6mr6715000ioc.123.1531013343043;
 Sat, 07 Jul 2018 18:29:03 -0700 (PDT)
Date:   Sat, 07 Jul 2018 18:29:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007567f0057072d2e7@google.com>
Subject: KASAN: out-of-bounds Write in tls_push_record
From:   syzbot <syzbot+43358359519ad16cf05e@syzkaller.appspotmail.com>
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

HEAD commit:    526674536360 Add linux-next specific files for 20180706
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17e63968400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d1cfc0cb798e48
dashboard link: https://syzkaller.appspot.com/bug?extid=43358359519ad16cf05e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=15790594400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b53f48400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+43358359519ad16cf05e@syzkaller.appspotmail.com

RDX: 00000000fffffdef RSI: 00000000200005c0 RDI: 0000000000000004
RBP: 00000000006cb018 R08: 0000000020000000 R09: 000000000000001c
R10: 0000000000000040 R11: 0000000000000216 R12: 0000000000000005
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
==================================================================
BUG: KASAN: out-of-bounds in tls_fill_prepend include/net/tls.h:339 [inline]
BUG: KASAN: out-of-bounds in tls_push_record+0x1091/0x1400  
net/tls/tls_sw.c:239
Write of size 1 at addr ffff8801c07b8000 by task syz-executor985/4467

CPU: 0 PID: 4467 Comm: syz-executor985 Not tainted  
4.18.0-rc3-next-20180706+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
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
  __fput+0x35d/0x930 fs/file_table.c:215
  ____fput+0x15/0x20 fs/file_table.c:251
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1b08/0x2750 kernel/exit.c:869
  do_group_exit+0x177/0x440 kernel/exit.c:972
  __do_sys_exit_group kernel/exit.c:983 [inline]
  __se_sys_exit_group kernel/exit.c:981 [inline]
  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:981
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43f358
Code: Bad RIP value.
RSP: 002b:00007ffd4c2414b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043f358
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004bf448 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000040 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d1180 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the page:
page:ffffea000701ee00 count:0 mapcount:-128 mapping:0000000000000000  
index:0x0
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 ffffea0006b7be08 ffff88021fffac18 0000000000000000
raw: 0000000000000000 0000000000000003 00000000ffffff7f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801c07b7f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8801c07b7f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff8801c07b8000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                       ^
  ffff8801c07b8080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8801c07b8100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
