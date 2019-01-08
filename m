Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60290C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AA12087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfAHF7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:59:04 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:51220 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfAHF7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 00:59:03 -0500
Received: by mail-io1-f71.google.com with SMTP id q207so2317686iod.18
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 21:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vv2MPlhr0KHzrDbJ/bh9lRGHpNbMDU6k451TUcwtYMw=;
        b=XDVg6uaW+Ij+sAT0/gO9imTlah4OLUEPei7x8+6Ns1EdkV7Kk6FpvhLgvmCzGptkDf
         +uFOZ/WtgRGA6WsyCvegsilSqzqeA+sibuk0xlxUVaznske50BL2PHej9LMA5sdu8L3Y
         cKwaqzNQe/m/ScNLUEUym01zIFa6Cq7SnJJci0war9Q+3A2MItAz15rbfvTP9/xDuTQk
         4q9O7ktqOd+zAEDl9gAP5ugYxoGyhsXQiayUHH/HbiNgnFJbLbQykBm3msGCGv0ETPl0
         p16oUmebEZgIwd/jdDV9vi1EMEqRgNuuiV3NdRA0o8n6rpPO64yy2P2Rb675SjIrSDao
         1IDA==
X-Gm-Message-State: AJcUukdhdEPqWamaJOShDi7fPptlHw1IeB3OlbtqAypfpcDCXd6UoWju
        CYFxeWAJ5M5pYAl9ipHrTrieQl9z2GRNpL8lkO6dlS2uoDqN
X-Google-Smtp-Source: ALg8bN45WTpWTcI5Mhq+37Kq+nXk/9SMngb+OsKGom7lDhJ1r9IL8j7BUX7kWVkF3MhB1kXeFLl2eczpghNPljX7ltCcOkWKdtCo
MIME-Version: 1.0
X-Received: by 2002:a24:2852:: with SMTP id h79mr517749ith.23.1546927142908;
 Mon, 07 Jan 2019 21:59:02 -0800 (PST)
Date:   Mon, 07 Jan 2019 21:59:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8bec0057eec0a92@google.com>
Subject: WARNING in ep_poll_callback
From:   syzbot <syzbot+aea82bf9ee6ffd9a79d9@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    139287cc2cc0 Add linux-next specific files for 20190108
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16f563d7400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1521b074ff5a5bdf
dashboard link: https://syzkaller.appspot.com/bug?extid=aea82bf9ee6ffd9a79d9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+aea82bf9ee6ffd9a79d9@syzkaller.appspotmail.com

------------[ cut here ]------------
IRQs not disabled as expected
WARNING: CPU: 1 PID: 27199 at fs/eventpoll.c:1224  
ep_poll_callback+0x77e/0x1450 fs/eventpoll.c:1224
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 27199 Comm: syz-executor4 Not tainted 5.0.0-rc1-next-20190108 #7
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x48 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:ep_poll_callback+0x77e/0x1450 fs/eventpoll.c:1224
Code: ff 44 89 ee e8 63 84 98 ff 45 84 ed 0f 85 4a fa ff ff e8 15 83 98 ff  
48 c7 c7 00 69 56 88 c6 05 a1 b2 6e 08 01 e8 52 c8 61 ff <0f> 0b e9 2b fa  
ff ff e8 f6 82 98 ff 48 8d 7b 30 48 b8 00 00 00 00
RSP: 0018:ffff8880533776a0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88804df7ee40 RCX: ffffc9000de3b000
RDX: 0000000000012c8d RSI: ffffffff816869f6 RDI: 0000000000000005
RBP: ffff888053377880 R08: ffff8880a078a700 R09: ffff8880a078aff0
R10: ffff8880a078a700 R11: 0000000000000000 R12: ffff888053377858
R13: 0000000000000000 R14: ffff88804df7ee90 R15: 0000000000000000
  __wake_up_common+0x1d3/0x7d0 kernel/sched/wait.c:92
  __wake_up_locked+0x11/0x20 kernel/sched/wait.c:154
  fuse_abort_conn+0xd01/0x1200 fs/fuse/dev.c:2212
  fuse_sb_destroy+0xd3/0x1d0 fs/fuse/inode.c:1245
  fuse_kill_sb_anon+0x16/0x30 fs/fuse/inode.c:1256
  deactivate_locked_super+0x9a/0x100 fs/super.c:331
  deactivate_super fs/super.c:362 [inline]
  deactivate_super+0x2ab/0x320 fs/super.c:358
  cleanup_mnt+0xbf/0x160 fs/namespace.c:1140
  __cleanup_mnt+0x16/0x20 fs/namespace.c:1147
  task_work_run+0x1f4/0x2b0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x32a/0x3b0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x696/0x800 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f19fdcaec78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000457ec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000040
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f19fdcaf6d4
R13: 00000000004c6ab2 R14: 00000000004dbdb8 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
