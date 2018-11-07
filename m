Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B23C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 05:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0262086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 05:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0262086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388814AbeKGObt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 09:31:49 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:50539 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbeKGObs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 09:31:48 -0500
Received: by mail-io1-f71.google.com with SMTP id q127-v6so17574613iod.17
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 21:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YyOgCcz+7mpAgCpvC4Igqi2H6VZNxak0CCdZykthrN8=;
        b=EGHuqZAA8nFvlBEVO2EcGVjRcEKF92VJVepMtBsJJd6Gmxteatjw5RR2rU475Su7L0
         lfTf5fycHgHaLvmOBvMATOFnHPBTNCqUOLRokNjBr1fLNFh/5C9SdjsqgP/n7/6fi/G4
         E97WPMTsQ8EyKFR73SHA991OwON3zLEfPKB+W5wG+mniGxxIkCJwqoD9Iv/wQYd9TXL9
         hOKzA4pObm4UHnUsGuDwQlxFnoUyiVGfTn/fmH7okEoAViWZLzTSlnLJDPA1gy9Ll572
         UJo7RQxWBQX+BQWJfvpTT0Wb7vx+5hh0jnksheq8Wypnx37gMix8b6t2bC98JH86E7Zm
         ldpQ==
X-Gm-Message-State: AGRZ1gLf6qIqf5bJDzFitZwt+SgFJdyME9As98QsMak4CLzohfA2N+2+
        5IYXoVrof9VLOWBDvVMN7q2YsLcXTTOpXMefXDwquIU1ugXZ
X-Google-Smtp-Source: AJdET5dLtkqBWp/BG3+qogez/ioSBEL2NO/pyvC/ebazy70D4e0QdqDEpMBp44d7BDmi17xTVFdwNA5r/5V5PkGCRusFvB6XWkYM
MIME-Version: 1.0
X-Received: by 2002:a5e:d715:: with SMTP id v21-v6mr216607iom.17.1541566984537;
 Tue, 06 Nov 2018 21:03:04 -0800 (PST)
Date:   Tue, 06 Nov 2018 21:03:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082cc8d057a0c0877@google.com>
Subject: KASAN: stack-out-of-bounds Read in locks_remove_flock
From:   syzbot <syzbot+1818cd833edc063452c6@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d881de30d29e Add linux-next specific files for 20181107
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14aa485d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caa433e1c8778437
dashboard link: https://syzkaller.appspot.com/bug?extid=1818cd833edc063452c6
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1818cd833edc063452c6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in locks_remove_flock+0x33c/0x350  
fs/locks.c:2567
Read of size 8 at addr ffff8801c71c7a08 by task syz-executor5/20562

CPU: 0 PID: 20562 Comm: syz-executor5 Not tainted 4.20.0-rc1-next-20181107+  
#107
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  locks_remove_flock+0x33c/0x350 fs/locks.c:2567
  locks_remove_file+0x148/0x5c0 fs/locks.c:2607
  __fput+0x2f0/0xa70 fs/file_table.c:271
  ____fput+0x15/0x20 fs/file_table.c:312
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x411021
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffdb42509a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000411021
RDX: 0000000000000000 RSI: 0000000000732ea0 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffdb42508c0 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000201 R15: 0000000000000005

The buggy address belongs to the page:
page:ffffea00071c71c0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 0000000000000000 ffffffff071c0101 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801c71c7900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801c71c7980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8801c71c7a00: f2 f2 f2 00 00 00 00 00 00 00 00 00 00 00 00 00
                       ^
  ffff8801c71c7a80: 00 f1 f1 f1 f1 00 00 f2 f2 f2 f2 f2 f2 f8 f2 f2
  ffff8801c71c7b00: f2 f2 f2 f2 f2 00 f2 f2 f2 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
