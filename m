Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59963C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1367A20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1367A20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754553AbeGILzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:55:06 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:49445 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754456AbeGILzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:55:03 -0400
Received: by mail-io0-f197.google.com with SMTP id k9-v6so4052218iob.16
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LQngvhTVzP2WaAV55RP0VQgag61bl/JDJYagPuSfoK0=;
        b=dYNePlDo76KEwKSsl972OwFG75z8oVf9E6EwPhC1qNVVPWEx3ah3c8e+MJ8QVW8L9v
         Au+TgsOIfYk2D4bOIg1/6t2jxQRkKYDoytbgd1UVNjwrQWn4zWHBHtAgNsW3Ec6MMaKt
         B1nOLpFd6/ETcPtBmjuz8+z6XU76vrxArchI4g7uNUAg94n072zA3Z6vSaeudsgDE9jW
         ZeVw/iJQANyXVbncirbyE8TivvDmtSSS6SMayArfcCWBnPQfqatczgow78QDSAwOFdkv
         UyBaXMpRhue9i9iG7TqYJoZd4rFtSmW1QGjU+lqQIbxRKqsVkYqRehzfn7rT7vbiMvuw
         +XSQ==
X-Gm-Message-State: APt69E0X4pzFhCjV8eaU5lPJ5VXGo+eJdRPr3ASBqJ7Fgn+3J70TUnhA
        erHycwiy8RQQL5zS5rZNrGWl+e3JpI4zedq9IJrapyGTn5ax
X-Google-Smtp-Source: AAOMgpfdpkdOX2ckEUDjlyW2LX/llmZt53uqieutff/sgvA2orHDDoRKpPKeHL5PcYPoP6+FpU9PaPcQaFft5YwgjKECqU19F7g6
MIME-Version: 1.0
X-Received: by 2002:a02:a386:: with SMTP id y6-v6mr9076715jak.25.1531137302851;
 Mon, 09 Jul 2018 04:55:02 -0700 (PDT)
Date:   Mon, 09 Jul 2018 04:55:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009f9a305708faf46@google.com>
Subject: WARNING in cgroup_apply_control_enable
From:   syzbot <syzbot+5493b2a54d31d6aea629@syzkaller.appspotmail.com>
To:     davem@davemloft.net, guro@fb.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7f93d1295131 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=11bc56d0400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
dashboard link: https://syzkaller.appspot.com/bug?extid=5493b2a54d31d6aea629
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5493b2a54d31d6aea629@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 22094 at kernel/cgroup/cgroup.c:2928  
cgroup_apply_control_enable+0x22c/0xe90 kernel/cgroup/cgroup.c:2928
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 22094 Comm: syz-executor7 Not tainted 4.18.0-rc3+ #3
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
RIP: 0010:cgroup_apply_control_enable+0x22c/0xe90  
kernel/cgroup/cgroup.c:2928
Code: 48 c1 e8 03 42 80 3c 20 00 0f 85 15 0a 00 00 49 8b 5f 18 31 ff 83 e3  
02 48 89 de e8 3e 56 07 00 48 85 db 74 07 e8 04 55 07 00 <0f> 0b e8 fd 54  
07 00 48 8b 85 a0 fe ff ff 48 c1 e8 03 42 80 3c 20
RSP: 0018:ffff8801b22ff808 EFLAGS: 00010216
RAX: 0000000000040000 RBX: 0000000000000002 RCX: ffffc90003c5b000
RDX: 00000000000001cd RSI: ffffffff8174b6cc RDI: 0000000000000007
RBP: ffff8801b22ff9b8 R08: ffff88019bd26340 R09: ffffed003b5c46d6
R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: dffffc0000000000
R13: ffffffff88fb9720 R14: 000000000000000b R15: ffff8801bd42e7c0
  cgroup_apply_control+0x1f/0x50 kernel/cgroup/cgroup.c:3014
  cgroup_enable_threaded kernel/cgroup/cgroup.c:3226 [inline]
  cgroup_type_write+0x3bb/0x580 kernel/cgroup/cgroup.c:3267
  cgroup_file_write+0x31f/0x840 kernel/cgroup/cgroup.c:3447
  kernfs_fop_write+0x2ba/0x480 fs/kernfs/file.c:316
  __vfs_write+0x117/0x9f0 fs/read_write.c:485
  vfs_write+0x1f8/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455e29
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f39d14d7c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f39d14d86d4 RCX: 0000000000455e29
RDX: 0000000000000009 RSI: 0000000020000180 RDI: 0000000000000016
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c2eae R14: 00000000004d4ca8 R15: 0000000000000000
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
