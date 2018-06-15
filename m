Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3EAC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4244620896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4244620896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936352AbeFORhF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:37:05 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:37397 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936136AbeFORhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:37:03 -0400
Received: by mail-it0-f71.google.com with SMTP id p130-v6so2426115itp.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 10:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ih7JZNvHMGkEAEiCjyOfKEtf31BE2dHVd/wMKJA83iU=;
        b=Q7r5JKolPp2R7uMye5l+dccwVy260cKS7VGUJNI93MRCgG8TXfYsg3twGqshsNfBgQ
         e9fEebI4Otde1gVMX5hnJgZG7hVgI5cFEWx1c/NRsLxDfwrKFnJBq5bPXNL9J9n2Ck+8
         x0W8RNaeCaNvV+1TtCDNg2OIPnl8+7t6cK/TbivKia8gKDDXVa2ltpe41i+5hn3gPmYh
         1JhFrjqPCbynFDVgApsCKz+7qv3p7Avg9KnFmathrWGMGcGQi71UiU2OTdGeYKgHqZ5A
         16MQ7Dpy9Oab+VD5ESYf5/qOYb7eRP26LtDSGNAABR9ohqU6ajlZzGPdLIO2FEJbH3l4
         bjdA==
X-Gm-Message-State: APt69E22vzxOnmc0e303Y7N8nbXhrM8tqsk7apO6H4LqTc0Y8LlMcQ8d
        gLb/h7XHXINB61ZxQZggcgExOuEvBEkzW0Bd2MJG76/XJ441
X-Google-Smtp-Source: ADUXVKKWxdkXaxMv+N5ta9Sdz3m/wpEu9aKVpAZfOA3ifhmDHvMut3z/TZcnoW6PrNvOvgFemgOVbTSi5CYInaROtn1vfbd2wN+U
MIME-Version: 1.0
X-Received: by 2002:a5e:9904:: with SMTP id t4-v6mr984707ioj.9.1529084223229;
 Fri, 15 Jun 2018 10:37:03 -0700 (PDT)
Date:   Fri, 15 Jun 2018 10:37:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f52489056eb1a911@google.com>
Subject: WARNING in blkdev_put
From:   syzbot <syzbot+139144b4a81f1a848264@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b5d903c2d656 Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ffb720400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caf58998a7a0564
dashboard link: https://syzkaller.appspot.com/bug?extid=139144b4a81f1a848264
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=17dc2720400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+139144b4a81f1a848264@syzkaller.appspotmail.com

loop3: p2 start 1279850000 is beyond EOD, truncated
loop2: p2 start 1279850000 is beyond EOD, truncated
  loop5: [CUMANA/ADFS] p1 [Linux] p2 [ADFS] p1 [Linux] p2
loop5: partition table partially beyond EOD, truncated
loop5: p1 size 135963288 extends beyond EOD, truncated
WARNING: CPU: 1 PID: 12785 at fs/block_dev.c:1826 blkdev_put+0x4bd/0x540  
fs/block_dev.c:1826
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 12785 Comm: syz-executor0 Not tainted 4.17.0+ #103
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:blkdev_put+0x4bd/0x540 fs/block_dev.c:1826
Code: 1f e4 ff 48 8b 55 d0 e9 bb fc ff ff 4c 89 ff e8 e9 1f e4 ff e9 fa fc  
ff ff e8 ff 54 a6 ff 0f 0b e9 4c fc ff ff e8 f3 54 a6 ff <0f> 0b e9 bc fc  
ff ff e8 e7 1f e4 ff e9 9c fb ff ff 4c 89 f7 e8 da
RSP: 0018:ffff8801d68875b0 EFLAGS: 00010293
RAX: ffff8801c73304c0 RBX: ffff8801a7cec040 RCX: ffffffff81d55115
RDX: 0000000000000000 RSI: ffffffff81d5545d RDI: 0000000000000005
RBP: ffff8801d68875e8 R08: ffff8801c73304c0 R09: fffffbfff11c24f0
R10: fffffbfff11c24f0 R11: ffffffff88e12783 R12: ffff8801a7cec058
R13: 000000000802009d R14: ffff8801a7cec100 R15: ffff8801a7cec0e8
  blkdev_close+0x8b/0xb0 fs/block_dev.c:1862
  __fput+0x35b/0x8b0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1b08/0x2750 kernel/exit.c:865
  do_group_exit+0x177/0x440 kernel/exit.c:968
  __do_sys_exit_group kernel/exit.c:979 [inline]
  __se_sys_exit_group kernel/exit.c:977 [inline]
  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:977
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455b29
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd05327218 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00000000000000dd RCX: 0000000000455b29
RDX: 0000000000000511 RSI: 0000000000731468 RDI: 0000000000000000
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000001380
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
