Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67037C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1688820881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1688820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754551AbeGINZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:25:04 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:51588 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754518AbeGINZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:25:02 -0400
Received: by mail-it0-f71.google.com with SMTP id b83-v6so9619080itg.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 06:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lkTkpRdjtdXYwx4IGy/tl96gL3xvnJLIhmegWYNXa7k=;
        b=X6T68w79PsiDfyiuME8xxJTDJ7jhLDCGagWWtTo1GYfBSBDq4qg1jDLxpYzo+gbcE5
         3jB75lAcF47DQet/6D1fdVtrBEnTgrP5qGfaFDR11OHn43R3oK7AsGM8EubFl0K0rIPI
         hiIUVPYuhZdaHsSbu0y1eovIhvfVDoypPVh6LzDU7H8nPncbaN9nHFQ+OuRj5UDIHcTN
         oH20fYCIMvFYvlOx0kcV+IMyTNDTRCwC6p2JqONY39Mu6RluqQw7ZDB1IRyOqjdjvi7/
         PQ9PWaPyges7K60AzcIAHqhOU1a3sGmqnmu3Ko7J8URcIVUKJ4rVKKSHQt4nZwuykzIM
         Qh8w==
X-Gm-Message-State: AOUpUlFgFmLQCAC1gncaPl5aQnsXiHDTgp3cDJ4MrlmSg/IFijkq/S4N
        BXmvMXD0UR2REZyukEU+NrQ9mkgpZ7JR6UgavyrbigPag0gV
X-Google-Smtp-Source: AAOMgpfnNnluGE+m2duF8X6azNlx0x6TQ/UbCYxa/mGrqp3rgFrTlSH38HwVTlfG8IUYw1gvBmNw850H1y5HYZz8O4FdHuQxepY9
MIME-Version: 1.0
X-Received: by 2002:a6b:5015:: with SMTP id e21-v6mr9235959iob.67.1531142702324;
 Mon, 09 Jul 2018 06:25:02 -0700 (PDT)
Date:   Mon, 09 Jul 2018 06:25:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df6781057090f03d@google.com>
Subject: INFO: task hung in vfs_setxattr
From:   syzbot <syzbot+6cd4d2845f652967921c@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d00d6d9a339d Add linux-next specific files for 20180709
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1414611c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94fe2b586beccacd
dashboard link: https://syzkaller.appspot.com/bug?extid=6cd4d2845f652967921c
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6cd4d2845f652967921c@syzkaller.appspotmail.com

FAT-fs (loop6): Unrecognized mount option "uid=" or missing value
INFO: task syz-executor3:28571 blocked for more than 140 seconds.
       Not tainted 4.18.0-rc3-next-20180709+ #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor3   D25408 28571   4477 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2853 [inline]
  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
  schedule+0xfb/0x450 kernel/sched/core.c:3545
  __rwsem_down_write_failed_common+0x95d/0x1630  
kernel/locking/rwsem-xadd.c:566
  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:595
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0xaa/0x130 kernel/locking/rwsem.c:72
  inode_lock include/linux/fs.h:748 [inline]
  vfs_setxattr+0x96/0x100 fs/xattr.c:218
  setxattr+0x2ea/0x450 fs/xattr.c:450
  path_setxattr+0x1e3/0x230 fs/xattr.c:469
  __do_sys_setxattr fs/xattr.c:484 [inline]
  __se_sys_setxattr fs/xattr.c:480 [inline]
  __x64_sys_setxattr+0xc4/0x150 fs/xattr.c:480
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455e29
Code: Bad RIP value.
RSP: 002b:00007f1c60d88c68 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007f1c60d896d4 RCX: 0000000000455e29
RDX: 0000000020000400 RSI: 0000000020000380 RDI: 0000000020000140
RBP: 000000000072bff0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004bbff8 R14: 00000000004d3370 R15: 0000000000000002
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 PID: 897 Comm: khungtaskd Not tainted 4.18.0-rc3-next-20180709+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.5+0x19/0xce lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:143 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:204 [inline]
  watchdog+0xb39/0x10b0 kernel/hung_task.c:265
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:415
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 2419 Comm: udevd Not tainted 4.18.0-rc3-next-20180709+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0033:0x4043d1
Code: d5 b0 00 00 bf a0 54 62 00 e8 9b fb 00 00 bf b0 54 62 00 e8 91 fb 00  
00 44 89 7c 24 64 4c 89 6c 24 50 49 89 df 44 89 74 24 58 <80> 3d b0 11 22  
00 00 0f 84 88 07 00 00 83 7c 24 58 00 78 1e 8b 54
RSP: 002b:00007ffee90bf370 EFLAGS: 00000246
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 00007ffee90bf46c
RDX: 0000000000000004 RSI: 0000000000000001 RDI: 00000000006254a0
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000008 R11: 0000000000000004 R12: 0000000000000003
R13: 0000000000000000 R14: 0000000000891520 R15: 0000000000883250
FS:  00007f96fedce7a0(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001ca6fa000 CR4: 00000000001406f0
DR0: 0000000020000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
