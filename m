Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F148C10F02
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388372184E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfBRHRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 02:17:05 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:40644 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbfBRHRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 02:17:04 -0500
Received: by mail-it1-f200.google.com with SMTP id 135so29186961itk.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 23:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pjVdzn8mcY5vkqvdsoC+3XO57CmmTC8XYihrl2pPYuE=;
        b=JAw1mMkAUleC3DwsUP6pRYigXNhZe8rGJr/m4yf/1Z3YS4ItRpFlJYmU9DFbtO6Ug4
         O5GQi4lef3DYuzoJUTdX27bw7qQgcYvuitK6ru3FYCbVbrjWd5/tO6i34XfW6M8jHwka
         6lppWKRrFB0mOsdiQHpryEV30oavFGPMWveYEV7C5GGT3dQ4cQgsvnUzjRxz58Qcac/C
         9pszRNeqp9Q7n8BAD9gzMGuCPXBzfvG/tKcSy3TOULfC+Rv7oOTuA1Yk3rzPA53WEBPi
         fwVKrk42iipJCZDJJtr03TUK9J3JmTrU3ZiLBWvL9X0L/jZntjzrmgusxgzw7Hiyb20A
         rIYw==
X-Gm-Message-State: AHQUAub18QD7F/V870jBvGUgav+UpjEbkG3Onc6w27GRKKl7MTdVHCDw
        yqWekvCNk0LnB5KDzkg32gSsAVR1MOUCKGTqOSQUMfV5U0+d
X-Google-Smtp-Source: AHgI3IbVmOlQ6WzZloA/yPu8vBbIw2XZWcH7ks3RYuOWt/aLKkZvbDzbFsox+nC3ynudMcgc8srM/WUyPdjV9oaSh3DsIb9gPo2A
MIME-Version: 1.0
X-Received: by 2002:a5d:8c97:: with SMTP id g23mr17027068ion.0.1550474223569;
 Sun, 17 Feb 2019 23:17:03 -0800 (PST)
Date:   Sun, 17 Feb 2019 23:17:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005455bf058225e9c0@google.com>
Subject: WARNING: ODEBUG bug in hci_uart_tty_close
From:   syzbot <syzbot+9fd324c8c2176a6022d3@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    64c0133eb88a Merge tag 'armsoc-fixes' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14af4182c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee434566c893c7b1
dashboard link: https://syzkaller.appspot.com/bug?extid=9fd324c8c2176a6022d3
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9fd324c8c2176a6022d3@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 00007f06c071c6d4
R13: 00000000004c06b9 R14: 00000000004d2350 R15: 0000000000000004
Bluetooth: Can't allocate HCI device
------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: work_struct hint:  
hci_uart_write_work+0x0/0x710 include/linux/percpu-rwsem.h:97
WARNING: CPU: 0 PID: 979 at lib/debugobjects.c:325  
debug_print_object+0x16a/0x250 lib/debugobjects.c:325
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 979 Comm: syz-executor.3 Not tainted 5.0.0-rc6+ #74
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x45 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:debug_print_object+0x16a/0x250 lib/debugobjects.c:325
Code: dd 80 50 a2 87 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b5 00 00 00 48  
8b 14 dd 80 50 a2 87 48 c7 c7 20 46 a2 87 e8 24 1e 18 fe <0f> 0b 83 05 a1  
99 31 06 01 48 83 c4 20 5b 41 5c 41 5d 41 5e 5d c3
RSP: 0018:ffff888084d97ba0 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815a9256 RDI: ffffed10109b2f66
RBP: ffff888084d97be0 R08: ffff8880a8444100 R09: ffffed1015d03ef9
R10: ffffed1015d03ef8 R11: ffff8880ae81f7c7 R12: 0000000000000001
R13: ffffffff88972ec0 R14: ffffffff8149a680 R15: ffff888082180ce8
  __debug_check_no_obj_freed lib/debugobjects.c:785 [inline]
  debug_check_no_obj_freed+0x29f/0x464 lib/debugobjects.c:817
  kfree+0xbd/0x230 mm/slab.c:3805
  hci_uart_tty_close+0x11d/0x260 drivers/bluetooth/hci_ldisc.c:548
  tty_ldisc_close.isra.0+0x100/0x180 drivers/tty/tty_ldisc.c:485
  tty_ldisc_kill+0x9c/0x160 drivers/tty/tty_ldisc.c:633
  tty_ldisc_release+0xc6/0x280 drivers/tty/tty_ldisc.c:805
  tty_release_struct+0x1b/0x50 drivers/tty/tty_io.c:1610
  tty_release+0xbce/0xe90 drivers/tty/tty_io.c:1783
  __fput+0x2df/0x8d0 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x273/0x2c0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x411d31
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 94 19 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:0000000000a4fd90 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000411d31
RDX: 0000001b30e20000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 000000005257be5b R09: 000000005257be5f
R10: 0000000000a4fcc0 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000004 R15: 0000000000000003

======================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
