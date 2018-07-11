Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F308EC1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B82D20C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B82D20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbeGKUE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:04:57 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:38964 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbeGKUE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:04:56 -0400
Received: by mail-io0-f200.google.com with SMTP id x14-v6so23036742ioa.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=R1xbTbhkrPrEoAhZ1Mrou7gqG/7JyZaj681OCWZjjrs=;
        b=K5x4RbFVg7Np7i20cJ79IZ9/RGcSG0DuYfsIWFfh1IrN/+vRfenNOapQkw/yU5So9A
         GcvgCog0OEcddDgRl4Z3qxkg0WUiVSgX1I4A4isy62u8Ui9F0Ap0ugG7PZarlJpkVfI3
         1P/8YcXuZpMTDpqAny20ZtcZFzXdsxZiuFWEeYET3byJC6aWXvbC66I4eVM2Zg3Dmzzl
         i0MDSLxGFXDhW6jfrAhq2w1f4M51K+TpWXiIRaSctQ/KuAdIFeTAvhnkC60eZV/KxVxe
         LKMa+n5gyrp3gIMjLlIr4qkKR0b+qGtQ8zD3L9RBbTKHzjN+dfO61nwGaRuuNTDkNi5Y
         ftTg==
X-Gm-Message-State: AOUpUlGK/u5Xh+O08pzr42d4ljLb9v+WOHautbAbPSNd0+qmy64ldGA4
        fuXh0jg+xJldaqpc0Ou+UUVbwX55z+ePz83eaAvdDwg9OJSy
X-Google-Smtp-Source: AAOMgpeORp1gUAAbql92aeWafGhrzzXpPYHVRrFQm2A0GCMIAW8AVPdFO4WNgQnjILZByGRlRDB7hgSPZ1+cXlJH03Pbsy3W5wdg
MIME-Version: 1.0
X-Received: by 2002:a6b:3dd:: with SMTP id e90-v6mr10092ioi.85.1531339142050;
 Wed, 11 Jul 2018 12:59:02 -0700 (PDT)
Date:   Wed, 11 Jul 2018 12:59:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097c8ab0570bead4a@google.com>
Subject: KASAN: invalid-free in fat_fill_super
From:   syzbot <syzbot+90b8e10515ae88228a92@syzkaller.appspotmail.com>
To:     hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    98be45067040 Add linux-next specific files for 20180711
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=120b1ed0400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f3b3673fec35d01
dashboard link: https://syzkaller.appspot.com/bug?extid=90b8e10515ae88228a92
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+90b8e10515ae88228a92@syzkaller.appspotmail.com

RDX: 00007fd0b961ead0 RSI: 0000000020000080 RDI: 00007fd0b961eaf0
RBP: 0000000020000080 R08: 00007fd0b961eb30 R09: 00007fd0b961ead0
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000015
R13: 0000000000000000 R14: 00000000004d3fd0 R15: 000000000000004a
==================================================================
BUG: KASAN: double-free or invalid-free in fat_fill_super+0xc84/0x4400  
fs/fat/inode.c:1882

CPU: 1 PID: 31888 Comm: syz-executor6 Not tainted 4.18.0-rc4-next-20180711+  
#4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_invalid_free+0x64/0xa0 mm/kasan/report.c:336
  __kasan_slab_free+0x150/0x170 mm/kasan/kasan.c:501
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  fat_fill_super+0xc84/0x4400 fs/fat/inode.c:1882
  vfat_fill_super+0x31/0x40 fs/fat/namei_vfat.c:1049
  mount_bdev+0x314/0x3e0 fs/super.c:1344
  vfat_mount+0x3c/0x50 fs/fat/namei_vfat.c:1056
  legacy_get_tree+0x118/0x440 fs/fs_context.c:659
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1743
  do_new_mount fs/namespace.c:2567 [inline]
  do_mount+0x6c1/0x1fb0 fs/namespace.c:2889
  ksys_mount+0x12d/0x140 fs/namespace.c:3105
  __do_sys_mount fs/namespace.c:3119 [inline]
  __se_sys_mount fs/namespace.c:3116 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3116
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45885a
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 dd 8f fb ff c3 66 2e 0f  
1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 ba 8f fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007fd0b961ea88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fd0b961eb30 RCX: 000000000045885a
RDX: 00007fd0b961ead0 RSI: 0000000020000080 RDI: 00007fd0b961eaf0
RBP: 0000000020000080 R08: 00007fd0b961eb30 R09: 00007fd0b961ead0
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000015
R13: 0000000000000000 R14: 00000000004d3fd0 R15: 000000000000004a

Allocated by task 31888:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3718 [inline]
  __kmalloc+0x14e/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:518 [inline]
  match_strdup+0x5e/0xa0 lib/parser.c:331
  parse_options+0xc7d/0x1a10 fs/fat/inode.c:1291
  fat_fill_super+0x2b3/0x4400 fs/fat/inode.c:1631
  vfat_fill_super+0x31/0x40 fs/fat/namei_vfat.c:1049
  mount_bdev+0x314/0x3e0 fs/super.c:1344
  vfat_mount+0x3c/0x50 fs/fat/namei_vfat.c:1056
  legacy_get_tree+0x118/0x440 fs/fs_context.c:659
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1743
  do_new_mount fs/namespace.c:2567 [inline]
  do_mount+0x6c1/0x1fb0 fs/namespace.c:2889
  ksys_mount+0x12d/0x140 fs/namespace.c:3105
  __do_sys_mount fs/namespace.c:3119 [inline]
  __se_sys_mount fs/namespace.c:3116 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3116
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 31888:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  parse_options+0xc70/0x1a10 fs/fat/inode.c:1290
  fat_fill_super+0x2b3/0x4400 fs/fat/inode.c:1631
  vfat_fill_super+0x31/0x40 fs/fat/namei_vfat.c:1049
  mount_bdev+0x314/0x3e0 fs/super.c:1344
  vfat_mount+0x3c/0x50 fs/fat/namei_vfat.c:1056
  legacy_get_tree+0x118/0x440 fs/fs_context.c:659
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1743
  do_new_mount fs/namespace.c:2567 [inline]
  do_mount+0x6c1/0x1fb0 fs/namespace.c:2889
  ksys_mount+0x12d/0x140 fs/namespace.c:3105
  __do_sys_mount fs/namespace.c:3119 [inline]
  __se_sys_mount fs/namespace.c:3116 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3116
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff880190d60c80
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
  32-byte region [ffff880190d60c80, ffff880190d60ca0)
The buggy address belongs to the page:
page:ffffea0006435800 count:1 mapcount:0 mapping:ffff8801da8001c0  
index:0xffff880190d60fc1
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea00073fe648 ffffea00060af588 ffff8801da8001c0
raw: ffff880190d60fc1 ffff880190d60000 000000010000000d 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff880190d60b80: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff880190d60c00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> ffff880190d60c80: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
                    ^
  ffff880190d60d00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff880190d60d80: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
