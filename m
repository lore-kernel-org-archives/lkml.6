Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70321C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E3026D0D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E3026D0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbeFZPTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:19:05 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:54611 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbeFZPTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:19:04 -0400
Received: by mail-it0-f69.google.com with SMTP id w16-v6so1432384itb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 08:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nOU5dAv8xMzbRXNOmpi+Sc3RLXFjAPq/vlHZWPU3bjo=;
        b=Zmv9wKYF9coJ5Oxbg6Tdyp4mI2Hu7BmoTOLvjfJOiavJConQDEuCLYXThJypDsdYbK
         o3yu1MD9mXdpPiB7yKihjA3JKEzMWrciihIUPMFkso7hsxgr6RF6nPhjiQ/jZ7OnJQov
         6HbhevdoymLdzwceldxgadKRMfndGF7RvM2VBC6qOEJWF9grjsC0+SimeDOaYycdVIRR
         2dMJOe4VnEzNYwQJNzvzyjE+bnO6pb7yhimTcSu7sxyGy8lRti5HEDhldfS0gxa3/FXy
         nmMWrsBGiZtsc8hh8rMYp0hll0wCt9iNnTHLQ9GS7wgM2kShkkppMdCz7I7yCicdJ66R
         RoPQ==
X-Gm-Message-State: APt69E3xrEyBiw74c4rK7NbG+IxZQdulFuqpvXREhdD2FPpFmfc2UOYN
        a+3rrtZzqCQBTVku0r30C1DpoVNQiPUKFakQrdRQGbNsC3H4
X-Google-Smtp-Source: AAOMgpdGqhJrcvpzJWMFnmOjEbgYkLKsDJLqrpnAZdA0tkyUSLrbH7lrPS8i59Nip3jD7M8O5je7RiXW4i+cFp8/2+B/HIFENpc/
MIME-Version: 1.0
X-Received: by 2002:a6b:9f0d:: with SMTP id i13-v6mr709969ioe.28.1530026343561;
 Tue, 26 Jun 2018 08:19:03 -0700 (PDT)
Date:   Tue, 26 Jun 2018 08:19:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b48454056f8d047a@google.com>
Subject: WARNING in __mark_inode_dirty (2)
From:   syzbot <syzbot+10c9ec572880993f2edd@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6f0d349d922b Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1395d190400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a63be0c83e84d370
dashboard link: https://syzkaller.appspot.com/bug?extid=10c9ec572880993f2edd
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+10c9ec572880993f2edd@syzkaller.appspotmail.com

  loop4: p1 p2 p3 p4 < >
  loop2: p1 p2 p3 p4 < >
------------[ cut here ]------------
bdi-block not registered
WARNING: CPU: 1 PID: 27489 at fs/fs-writeback.c:2194  
__mark_inode_dirty+0xf0d/0x1550 fs/fs-writeback.c:2192
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 27489 Comm: syz-executor4 Not tainted 4.18.0-rc2+ #117
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
RIP: 0010:__mark_inode_dirty+0xf0d/0x1550 fs/fs-writeback.c:2192
Code: b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 bf  
05 00 00 49 8b 75 30 48 c7 c7 a0 d7 f3 87 e8 c3 b7 75 ff <0f> 0b e8 dc 94  
aa ff 48 c7 c7 00 90 e0 88 48 b8 00 00 00 00 00 fc
RSP: 0018:ffff88018c81f118 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8801c90e2418 RCX: ffffc90005841000
RDX: 000000000000324c RSI: ffffffff816318f1 RDI: ffff88018c81edf0
RBP: ffff88018c81f380 R08: ffff8801be2e05c0 R09: 0000000000000006
R10: ffff8801be2e05c0 R11: 0000000000000000 R12: ffff8801c84f6e00
R13: ffff8801d24c4a00 R14: ffff8801c90e24a0 R15: ffff8801c90e24f0
  mark_buffer_dirty+0x567/0x6d0 fs/buffer.c:1107
  __block_commit_write.isra.36+0x1a2/0x3b0 fs/buffer.c:2031
  block_write_end+0xab/0x270 fs/buffer.c:2109
  blkdev_write_end+0xd6/0x2f0 fs/block_dev.c:593
  generic_perform_write+0x4e0/0x6c0 mm/filemap.c:3150
  __generic_file_write_iter+0x26e/0x630 mm/filemap.c:3264
  blkdev_write_iter+0x23f/0x450 fs/block_dev.c:1913
  call_write_iter include/linux/fs.h:1795 [inline]
  do_iter_readv_writev+0x897/0xa90 fs/read_write.c:680
  do_iter_write+0x185/0x5f0 fs/read_write.c:959
  vfs_writev+0x1f1/0x360 fs/read_write.c:1004
  do_writev+0x11a/0x310 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455a99
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4605b56c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f4605b576d4 RCX: 0000000000455a99
RDX: 0000000000000003 RSI: 0000000020000680 RDI: 0000000000000013
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c0701 R14: 00000000004d3e48 R15: 0000000000000000
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
