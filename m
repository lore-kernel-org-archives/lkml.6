Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED177C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58492080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58492080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeJ3XyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:54:07 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:48801 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbeJ3Xxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:53:53 -0400
Received: by mail-io1-f69.google.com with SMTP id c17-v6so11157145ioi.15
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 08:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=C8SvS/Tp04h0eyT1S7F5SZ/rO5IgLUVn2mbbqxcJ6gM=;
        b=cTQCLbWvF6X8gQt4ztIrss4oOuIBZfhPQq+NJmCqpiYYtExg9adgSUT0HD0GUO18KN
         h3XYwzI6D/tJs+gTkDk4598rGY5Ono0YS0VAF6tHj7LFaWcjEAo5KiMSx8bdQxecE2/e
         PVAVIgDNnjyf2XZn/P3yxsrUYDz3ZKWRNWpA8VWabi5QJijLHXubUfEHaxQ3/f88bk3t
         9+rhWJCyDf6KKRqUQZMi/NtupaLIW6NVYRCNv1o3m9z4jCSNq+P0FmKphiFhAeqmPvnU
         MGWyAVDb2rrYzbYbv3R58qjgkEVqlz2mVd8pWuJEhVrVvX3XjrCZVNiWGVSsou+uJTNG
         5d7g==
X-Gm-Message-State: AGRZ1gJAvexjNkbFkIuHsZQN0i8AdKW3TBquO3TQlww7wA+8UGnOEfDz
        Hak34+I4cWt12BfEaWzSHvRNbue4ue/yxFneQXUAdQmdErQ7
X-Google-Smtp-Source: AJdET5dn1+K+e8cmsRZ/1TUgE0qS53ZGc7sXJ2bECY3YiRNjxhTa8o3NTMrWzREnvY2GQjb9Oj/bZaSerp48kdoSO+6xDUEqW5z0
MIME-Version: 1.0
X-Received: by 2002:a02:7107:: with SMTP id n7-v6mr6210525jac.20.1540911603967;
 Tue, 30 Oct 2018 08:00:03 -0700 (PDT)
Date:   Tue, 30 Oct 2018 08:00:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c9000f05797370e4@google.com>
Subject: WARNING in get_unlocked_entry
From:   syzbot <syzbot+4fd0c066d82852499145@syzkaller.appspotmail.com>
To:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, willy@infradead.org, zwisler@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    4b42745211af Merge tag 'armsoc-soc' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1187d06d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=93932074d01b4a5
dashboard link: https://syzkaller.appspot.com/bug?extid=4fd0c066d82852499145
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4fd0c066d82852499145@syzkaller.appspotmail.com

EXT4-fs (sda1): Cannot specify journal on remount
EXT4-fs (sda1): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
EXT4-fs (sda1): warning: refusing change of dax flag with busy inodes while  
remounting
WARNING: CPU: 0 PID: 12870 at fs/dax.c:227 get_unlocked_entry+0x3ac/0x4d0  
fs/dax.c:227
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 12870 Comm: syz-executor3 Not tainted 4.19.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x20/0x4a kernel/panic.c:536
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:966
RIP: 0010:get_unlocked_entry+0x3ac/0x4d0 fs/dax.c:227
Code: e8 31 ff 83 e0 01 48 89 c6 48 89 85 10 ff ff ff e8 09 18 96 ff 48 8b  
85 10 ff ff ff 48 85 c0 0f 85 34 fe ff ff e8 c4 16 96 ff <0f> 0b e8 bd 16  
96 ff 48 b8 00 00 00 00 00 fc ff df 48 03 85 f8 fe
RSP: 0018:ffff88018025e7b8 EFLAGS: 00010012
RAX: 0000000000040000 RBX: ffff88018025ead8 RCX: ffffc90008983000
RDX: 0000000000000341 RSI: ffffffff81e94d3c RDI: 0000000000000007
RBP: ffff88018025e8c8 R08: ffff88017f862280 R09: ffffed003004bd08
R10: ffffed003004bd08 R11: 0000000000000003 R12: dffffc0000000000
R13: ffffea0005e01040 R14: ffff88018025e800 R15: ffff88018025e8a0
  grab_mapping_entry fs/dax.c:447 [inline]
  dax_iomap_pte_fault.isra.35+0x8a5/0x37c0 fs/dax.c:1239
  dax_iomap_fault+0x51/0x70 fs/dax.c:1600
  ext4_dax_huge_fault+0x565/0x730 fs/ext4/file.c:320
  ext4_dax_fault+0x17/0x20 fs/ext4/file.c:341
  __do_fault+0x100/0x6b0 mm/memory.c:2991
  do_cow_fault mm/memory.c:3432 [inline]
  do_fault mm/memory.c:3531 [inline]
  handle_pte_fault mm/memory.c:3760 [inline]
  __handle_mm_fault+0x141b/0x5be0 mm/memory.c:3884
  handle_mm_fault+0x54f/0xc70 mm/memory.c:3921
  do_user_addr_fault arch/x86/mm/fault.c:1423 [inline]
  __do_page_fault+0x5e8/0xe60 arch/x86/mm/fault.c:1489
  do_page_fault+0xf2/0x7e0 arch/x86/mm/fault.c:1520
  page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1136
RIP: 0010:copy_user_generic_unrolled+0x89/0xc0  
arch/x86/lib/copy_user_64.S:66
Code: 38 4c 89 47 20 4c 89 4f 28 4c 89 57 30 4c 89 5f 38 48 8d 76 40 48 8d  
7f 40 ff c9 75 b6 89 d1 83 e2 07 c1 e9 03 74 12 4c 8b 06 <4c> 89 07 48 8d  
76 08 48 8d 7f 08 ff c9 75 ee 21 d2 74 10 89 d1 8a
RSP: 0018:ffff88018025f7d0 EFLAGS: 00010207
RAX: 0000000000000004 RBX: 000000000000001c RCX: 0000000000000003
RDX: 0000000000000004 RSI: ffff88018025fb40 RDI: 0000000020000000
RBP: ffff88018025f808 R08: 00000000000000b8 R09: ffffed003004bf68
R10: ffffed003004bf6b R11: 0000000000000003 R12: 000000002000001c
R13: 0000000020000000 R14: ffff88018025fb40 R15: 00007ffffffff000
  copy_to_user include/linux/uaccess.h:155 [inline]
  ext4_ioctl+0x3ed/0x44c0 fs/ext4/ioctl.c:1035
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0efb87dc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000020000000 RSI: 00000000801c581f RDI: 0000000000000003
RBP: 000000000072c040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0efb87e6d4
R13: 00000000004bf929 R14: 00000000004cfa80 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
