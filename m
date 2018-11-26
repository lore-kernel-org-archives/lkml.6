Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81404C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F61820855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F61820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeK0Hee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:34:34 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:56217 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeK0HeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:34:25 -0500
Received: by mail-io1-f72.google.com with SMTP id m5so4540634iok.22
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 12:39:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fsm4eW7Wt7boWCMjTmNWqfWjzu17qAYqrIyeC4L/rT8=;
        b=puZnElSqIckY3vwG0+efoKDBkPcv817duAiW70qS+6aqUGLWG3MEamdF60VBo38g51
         kYfQltp1wkYePBaTh5XioxcCJgwZu+yhrawmpFpAJtR60mAFhRp1jwsMHrAmsbImj/4h
         bIk8gArBe8ZflkuOVRHYcmGbk9WKJ9dLTlImht51pYiKg+CLfoABmlGiBGd5hJXBZ/Cg
         7sMGHz7ykeaaX70NEuv1F7M62QyezxES840tSMklwMGRcOQ2ykkVJ4N6P+sA2lfRh6j3
         cyCvCiDD9DBqG8UC5iBH9WZMjr2u5eHPyLH1yCZQOl6i2b/EBq5CyZA4Coed6pXCUN0o
         lSxw==
X-Gm-Message-State: AGRZ1gInNQTkLKVD4satLT+jgc/PNy+G33xv9hsOuCwRfRR+IZqhov5I
        uZl8fL02/PjF9gNMm9xdvft2pqi8TTYZja/OJGXXR4vzi/VX
X-Google-Smtp-Source: AFSGD/WESIVqk65/IEe0D/LTMr8V4hUcmPC5gtNndFb7oaCOvWm4Xt9k7ycv8s4nxpI4M6cbrajmeigSx+pHByylBLoQimDX6sBw
MIME-Version: 1.0
X-Received: by 2002:a24:5f84:: with SMTP id r126-v6mr18524997itb.39.1543264745414;
 Mon, 26 Nov 2018 12:39:05 -0800 (PST)
Date:   Mon, 26 Nov 2018 12:39:05 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1e837057b97522a@google.com>
Subject: WARNING in ext4_dio_get_block_overwrite
From:   syzbot <syzbot+9b095ee32c8a10c367dc@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    442b8cea2477 Add linux-next specific files for 20181109
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15d84a47400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f72bdb11df9fbe8
dashboard link: https://syzkaller.appspot.com/bug?extid=9b095ee32c8a10c367dc
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9b095ee32c8a10c367dc@syzkaller.appspotmail.com

audit: type=1804 audit(1543213093.902:156): pid=10653 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=ToMToU  
comm="syz-executor3"  
name="/root/syzkaller-testdir952476403/syzkaller.2X9ByG/94/bus" dev="sda1"  
ino=16843 res=1
WARNING: CPU: 0 PID: 10648 at fs/ext4/inode.c:945  
ext4_dio_get_block_overwrite+0xbf/0x100 fs/ext4/inode.c:945
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 10648 Comm: syz-executor3 Not tainted 4.20.0-rc1-next-20181109+  
#110
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  panic+0x2ad/0x55c kernel/panic.c:188
  __warn.cold.8+0x20/0x45 kernel/panic.c:540
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
RIP: 0010:ext4_dio_get_block_overwrite+0xbf/0x100 fs/ext4/inode.c:945
Code: ff 48 85 db 74 1f e8 80 b0 64 ff 49 8b 1c 24 31 ff 48 c1 eb 0c 83 e3  
01 48 89 de e8 9b b1 64 ff 48 85 db 74 07 e8 61 b0 64 ff <0f> 0b e8 5a b0  
64 ff 44 89 e8 5b 41 5c 41 5d 41 5e 5d c3 e8 49 b0
RSP: 0018:ffff880179a0dc98 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 0000000000000000 RCX: ffffc9000c02a000
RDX: 0000000000040000 RSI: ffffffff821af84f RDI: 0000000000000007
RBP: ffff880179a0dcb8 R08: ffff8801d203e3c0 R09: ffffed002e9db6a9
R10: ffffed002e9db6a9 R11: ffff880174edb54f R12: ffff880179a0e980
R13: 0000000000000000 R14: 000000000000006b R15: ffff880179a0ea20
  get_more_blocks fs/direct-io.c:716 [inline]
  do_direct_IO+0x1941/0xc110 fs/direct-io.c:1001
  do_blockdev_direct_IO+0x131e/0xa340 fs/direct-io.c:1333
  __blockdev_direct_IO+0x9d/0xc6 fs/direct-io.c:1419
  ext4_direct_IO_write fs/ext4/inode.c:3774 [inline]
  ext4_direct_IO+0x15ab/0x2220 fs/ext4/inode.c:3901
  generic_file_direct_write+0x275/0x4b0 mm/filemap.c:3043
  __generic_file_write_iter+0x2ff/0x630 mm/filemap.c:3222
  ext4_file_write_iter+0x390/0x1420 fs/ext4/file.c:266
  call_write_iter include/linux/fs.h:1867 [inline]
  do_iter_readv_writev+0x8b0/0xa80 fs/read_write.c:680
  do_iter_write+0x185/0x5f0 fs/read_write.c:959
  vfs_iter_write+0x77/0xb0 fs/read_write.c:972
  iter_file_splice_write+0x90d/0x1050 fs/splice.c:749
  do_splice_from fs/splice.c:851 [inline]
  direct_splice_actor+0x128/0x190 fs/splice.c:1018
  splice_direct_to_actor+0x318/0x8f0 fs/splice.c:973
  do_splice_direct+0x2d4/0x420 fs/splice.c:1061
  do_sendfile+0x62a/0xe20 fs/read_write.c:1439
  __do_sys_sendfile64 fs/read_write.c:1500 [inline]
  __se_sys_sendfile64 fs/read_write.c:1486 [inline]
  __x64_sys_sendfile64+0x1fd/0x250 fs/read_write.c:1486
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2cc2bb1c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000005
RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000a5cc54d R11: 0000000000000246 R12: 00007f2cc2bb26d4
R13: 00000000004c3c2a R14: 00000000004d63d0 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
