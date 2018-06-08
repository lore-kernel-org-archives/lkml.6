Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vBH2CJGAGlujPAAAmS7hNA
	; Fri, 08 Jun 2018 13:11:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 100AF6089E; Fri,  8 Jun 2018 13:11:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,FROM_LOCAL_HEX,
	MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 669AE601D2;
	Fri,  8 Jun 2018 13:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 669AE601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752942AbeFHNLm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:11:42 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:58001 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbeFHNLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:11:03 -0400
Received: by mail-it0-f70.google.com with SMTP id p12-v6so1697742itc.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 06:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RUfNkKV6AHMXcT/TjATKUT3sKSWd0EtYR/O5c60e44Q=;
        b=BfWY4NnsK74n/ofcAz47C4jS2gn6doaFUzoOw3dD/BzBKJUP6fW9iQpimgbGUpaE99
         jyiWJ6VOzjrjx0uAXWMdN0J4Wy5deqU686V2iDqomfDCQ/EIlkLWH4Yy1Y3/5OjN+zL5
         oz9qKCRV4JUNgUZZI87zPoJzQkiBTzJ7KnU2y2Dn3AREogz3KmDwC3CO9xHIWz4e5rxf
         UZLGBSg4pQdDvqvycvntWz5cmcEFrXf/L8ITlbHcSdDYXmjTfB9iqcfcMdAO7Jy962UE
         9fY7m4hkYuqODJpd7ap/rxhbgI6bcCHSYZv0C6iL+Db+/ygDtGjvIPPQ320pwjX/Vt7K
         qijw==
X-Gm-Message-State: APt69E1R+JBvNrleAqaWSErwt8oaWeQwyHH0wINooSX1tR3eXgIPiwq9
        V7/W7WNkag5d6sUHPm/FnOvQOvnbC7jKZLYZ6UwiFOxmyqW+
X-Google-Smtp-Source: ADUXVKLUYwBa+pX6mMdGt0LPi7jJL4Psj3X7QGTfHg9v+rkj7xEq1b/qtRuJHFaA5PxAp/yGCy9Pn2RIH2Eappg/R8eMUv5nWuG6
MIME-Version: 1.0
X-Received: by 2002:a6b:dd07:: with SMTP id f7-v6mr2726603ioc.113.1528463462582;
 Fri, 08 Jun 2018 06:11:02 -0700 (PDT)
Date: Fri, 08 Jun 2018 06:11:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd54dd056e212189@google.com>
Subject: WARNING in do_dentry_open
From: syzbot <syzbot+2e7fcab0f56fdbb330b8@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    68abbe729567 Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130146af800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5a4673d4582131c
dashboard link: https://syzkaller.appspot.com/bug?extid=2e7fcab0f56fdbb330b8
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1591756f800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152236af800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2e7fcab0f56fdbb330b8@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
WARNING: CPU: 1 PID: 4508 at fs/open.c:778 do_dentry_open+0x4ad/0xe40  
fs/open.c:778
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 4508 Comm: syz-executor867 Not tainted 4.17.0+ #90
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  panic+0x22f/0x4de kernel/panic.c:184
  __warn.cold.8+0x163/0x1b3 kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:do_dentry_open+0x4ad/0xe40 fs/open.c:778
Code: 7b 28 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00  
0f 85 15 08 00 00 48 c7 43 28 00 00 00 00 e8 f3 6d ba ff <0f> 0b e8 ec 6d  
ba ff 48 8d 43 18 41 be ed ff ff ff 48 89 45 c0 e9
RSP: 0018:ffff8801afcaf7c8 EFLAGS: 00010293
RAX: ffff8801afe08400 RBX: ffff8801b099e0c0 RCX: ffffffff81bfccf6
RDX: 0000000000000000 RSI: ffffffff81bfcf6d RDI: ffff8801b099e0e8
RBP: ffff8801afcaf840 R08: ffff8801afe08400 R09: ffffed0036aa2afc
R10: ffffed0036aa2afc R11: ffff8801b55157e3 R12: ffff8801ab28d4b0
R13: ffff8801ab28d6a8 R14: 0000000000000000 R15: ffff8801b099e13c
  vfs_open+0x139/0x230 fs/open.c:908
  do_last fs/namei.c:3370 [inline]
  path_openat+0x1717/0x4dc0 fs/namei.c:3511
  do_filp_open+0x249/0x350 fs/namei.c:3545
  do_sys_open+0x56f/0x740 fs/open.c:1101
  __do_sys_openat fs/open.c:1128 [inline]
  __se_sys_openat fs/open.c:1122 [inline]
  __x64_sys_openat+0x9d/0x100 fs/open.c:1122
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43ff09
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 6b 45 00 00 c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe4eafe4f8 EFLAGS: 00000217 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 2f30656c69662f2e RCX: 000000000043ff09
RDX: 0000000000000040 RSI: 0000000020000100 RDI: ffffffffffffff9c
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000000000004 R11: 0000000000000217 R12: 0000000000401830
R13: 00000000004018c0 R14: 0000000000000000 R15: 0000000000000000
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
