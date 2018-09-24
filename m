Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E969C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D408920666
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D408920666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387659AbeIXSa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:30:58 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:41201 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731929AbeIXSa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:30:57 -0400
Received: by mail-it1-f200.google.com with SMTP id w132-v6so3750896ita.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 05:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=O0SF9MvLgjcyQa5KSqs/Mp8Eg2JG95KK3TYqErXOTJE=;
        b=ZTY0a2lsQ3fJquZ3pR+7zGQ9JH504RAOTi9VwglP7712wHG9nlAdGCuxICL5CuFsHh
         kjjI7CIXDSiDa2SPehKHVpjt/g4GJBAHCuqCuNq61oVRq8nFoYzvw7DDHGVDdOTHvbG7
         9O2p0Bn0UlsxHQi5UMyNfUfTbqB+/hPoUsMALsU8N2QnIB2zVwnyJwovLxXvtVeFSjs0
         sZCFym2VFfc4rqTokSlKzjXEM+UAycUEqc4pvwAfgChhDfBXKQknZfBTEmCwliE/JRy9
         NQeGIZSiMXwiPvI+jUPlxJJrkmDoknh3dAYDt4//y+6HDoFkxpbJzgyr2i5Br11w2aii
         V8aw==
X-Gm-Message-State: APzg51A2HRVgln2szPmi55LeSadda+PSolFYNH5g/YSV/638mqpLXEtQ
        V4WwlnhbMzVSWkz7m0N2a+C5qY8jm8lxSfofPTovWOqumnXK
X-Google-Smtp-Source: ANB0VdZOjCbodaYFN2C4yerd5ODz2tBx61lwegO6DEddLl3Vt2QiAHL4ekI0YNkXMN0UkJ7Sghk2M127uTJUtKDiLWpPa+2fiqr9
MIME-Version: 1.0
X-Received: by 2002:a02:a41a:: with SMTP id c26-v6mr8605149jal.36.1537792142830;
 Mon, 24 Sep 2018 05:29:02 -0700 (PDT)
Date:   Mon, 24 Sep 2018 05:29:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006971fa05769d22f6@google.com>
Subject: WARNING in request_end
From:   syzbot <syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6bf4ca7fbc85 Linux 4.19-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=159149c6400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=22a62640793a83c9
dashboard link: https://syzkaller.appspot.com/bug?extid=ef054c4d3f64cd7f7cec
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 9445 at fs/fuse/dev.c:390 request_end+0x82e/0xaa0  
fs/fuse/dev.c:390
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 9445 Comm: syz-executor2 Not tainted 4.19.0-rc5+ #251
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
kobject: '0:56' (00000000d57a9914): kobject_add_internal: parent: 'bdi',  
set: 'devices'
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
kobject: '0:56' (00000000d57a9914): kobject_uevent_env
  panic+0x238/0x4e7 kernel/panic.c:184
kobject: '0:56' (00000000d57a9914): fill_kobj_path: path  
= '/devices/virtual/bdi/0:56'
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:request_end+0x82e/0xaa0 fs/fuse/dev.c:390
Code: 3c 03 0f 8f 6f fe ff ff 48 8b bd f0 fe ff ff e8 68 e7 39 ff e9 5e fe  
ff ff e8 8e 86 f6 fe 0f 0b e9 b0 fa ff ff e8 82 86 f6 fe <0f> 0b e9 f0 fa  
ff ff e8 36 71 c0 fe e8 61 e7 39 ff e9 5b fb ff ff
RSP: 0018:ffff88019df0f378 EFLAGS: 00010212
RAX: 0000000000040000 RBX: ffff8801d2ca6000 RCX: ffffc90006d53000
RDX: 0000000000000138 RSI: ffffffff82885d9e RDI: 0000000000000007
RBP: ffff88019df0f4a8 R08: ffff8801d1a6c200 R09: ffffed0034b53937
R10: ffffed0034b53937 R11: ffff8801a5a9c9bb R12: 1ffff10033be1e74
R13: ffff8801a5a9c940 R14: ffff8801d2ca6030 R15: ffff88019df0f480
  fuse_dev_do_write+0x192e/0x36e0 fs/fuse/dev.c:1915
  fuse_dev_write+0x19a/0x240 fs/fuse/dev.c:1939
  call_write_iter include/linux/fs.h:1808 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457679
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007efd81affc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007efd81b006d4 RCX: 0000000000457679
RDX: 0000000000000090 RSI: 0000000020000500 RDI: 0000000000000003
RBP: 000000000072c040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d8710 R14: 00000000004c50a2 R15: 0000000000000002
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
