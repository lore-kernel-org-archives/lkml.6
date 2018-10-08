Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6D5C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7F7213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7F7213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeJHXac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:30:32 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:43740 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeJHXac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:30:32 -0400
Received: by mail-io1-f71.google.com with SMTP id y6-v6so9220972ioc.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 09:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oDWU14pljHynB+bZj2gtkf6pI6oZdNRGExeBJu2E0T0=;
        b=PR01Hnk7kEcBYyWojD1tqDskhIi8ubbUjVrHdYcGUAeR3DV1OwzspulsAWI8JDJzXp
         f+KmClEgTpGYYrzsi3r+wKpDjuuYWnklHvQQxzAAV3S+wU5ZETds2MNa2nKTfRj1t5T/
         LfG8QylfWwNp8r2jhI8WHQ/KPOWo5ON0d11I2YBqwFmmTPWqf+uEXFZtBP9rfLbdosU7
         Gv3y4dxOMVFdlm5r7AZDOOjJdteCyte2j7zVXUJtx16vS0j8YFcwxrusx+cJi8bogsoA
         mW9I1/a74ttoLUUjtQ31Q7cu9P496FAnpdiTJdOmvPJobbUc9iccU6JtzOluTKn5Wc9j
         Ingw==
X-Gm-Message-State: ABuFfohA6oJnpmb9awHSpmcVJBWxljMBp53qAP1lM6Q/yZYV+lZc2n3u
        tPZ2Q9YIx2nYgi2nMR+GIT+So/xADQ3Xs8I49F5gt6757uNj
X-Google-Smtp-Source: ACcGV63QWX4GTRZ6PX7oiSDMryn6aW2/RSm/VchfPyVgedkE2qSnFuzqPzJkHMKfrs7UqYl+wcOB58LmtvGrQWyqira8STzGvCyq
MIME-Version: 1.0
X-Received: by 2002:a24:7:: with SMTP id 7-v6mr17360779ita.33.1539015482755;
 Mon, 08 Oct 2018 09:18:02 -0700 (PDT)
Date:   Mon, 08 Oct 2018 09:18:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002753c60577b9f707@google.com>
Subject: WARNING in ext4_invalidatepage
From:   syzbot <syzbot+85da7ac734f7ba432ee4@syzkaller.appspotmail.com>
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

HEAD commit:    c1d84a1b42ef Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=161588d6400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0af03fe452b65fb
dashboard link: https://syzkaller.appspot.com/bug?extid=85da7ac734f7ba432ee4
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+85da7ac734f7ba432ee4@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 17203 at fs/ext4/inode.c:3353  
ext4_invalidatepage+0x1c7/0x5b0 fs/ext4/inode.c:3353
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 17203 Comm: syz-executor5 Not tainted 4.19.0-rc6+ #48
kobject: 'loop3' (000000002393f9b0): kobject_uevent_env
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
kobject: 'loop3' (000000002393f9b0): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:ext4_invalidatepage+0x1c7/0x5b0 fs/ext4/inode.c:3353
Code: 80 3c 02 00 0f 85 a7 03 00 00 4d 8b 6d 00 31 ff 49 c1 ed 11 41 83 e5  
01 4c 89 ee e8 43 ea 67 ff 4d 85 ed 74 07 e8 09 e9 67 ff <0f> 0b e8 02 e9  
67 ff 8b b5 34 ff ff ff 44 89 fa 4c 89 e7 e8 91 3a
RSP: 0018:ffff88018590ec78 EFLAGS: 00010212
RAX: 0000000000040000 RBX: 1ffff10030b21d91 RCX: ffffc9000dae4000
RDX: 0000000000000ece RSI: ffffffff8216ec87 RDI: 0000000000000007
RBP: ffff88018590ed50 R08: ffff880183018300 R09: fffff94000ceffc6
R10: fffff94000ceffc6 R11: ffffea000677fe33 R12: ffffea000677fe00
R13: 0000000000000001 R14: ffffea000677fe08 R15: 0000000000001000
  do_invalidatepage mm/truncate.c:165 [inline]
  truncate_cleanup_page+0x5ac/0xa90 mm/truncate.c:187
  truncate_inode_page+0x107/0x1a0 mm/truncate.c:229
  truncate_inode_pages_range+0x1382/0x2d50 mm/truncate.c:451
  truncate_inode_pages+0x24/0x30 mm/truncate.c:478
  swap_inode_boot_loader fs/ext4/ioctl.c:123 [inline]
  ext4_ioctl+0x1e3b/0x4210 fs/ext4/ioctl.c:865
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457579
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa151655c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457579
RDX: 0000000020000000 RSI: 0000000000006611 RDI: 0000000000000006
RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa1516566d4
R13: 00000000004bf60e R14: 00000000004cf4a8 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
