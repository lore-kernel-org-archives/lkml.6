Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9889BC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 08:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FAA521654
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 08:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAA521654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbeHOLBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 07:01:14 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:36456 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeHOLBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 07:01:13 -0400
Received: by mail-it0-f69.google.com with SMTP id m185-v6so636225itm.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 01:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zeMNE/nnHJiNao2mlZgbL98PXXTSclQAKtdGhFtxins=;
        b=WSjEnaT5V26rqjJ0hNVOKDDRlGE6xWVp9a+/u7kEl0eyL76HCz6eEib7O7giW1OVhQ
         rJvv/704tkKvIQ6g5zQN5Mk9VXRCBXtU6JkN7MHkk9HzVfKO0P/U2a71AZK0wMai4xJb
         XtVpGCCDwM/5yZ+UVqR0U7bkNopxLiYlWafPhizh9odrYsVl/LomDu003hV/SvJm3Krd
         y938l6QCfkuX1uOrXnp2Kr635qFWY1fqP6ClfVywtc4VvRT/hodKEz5ruMI6SAjttX9K
         ANlp3unH18LIrAfIUa8T0D7JM1UkFA4+kyN7SuUlQx0m2tz4wLOvz9PVbj100W5zhx6G
         yzUw==
X-Gm-Message-State: AOUpUlFT3u5kJTo2t/l8rI/hKkTfOgnztRqxTpLW1BlxBS+oQSFPGqRi
        HOkFWrkdyQULDFfTepGf2uKtWKBBkvSt9UwEGlQSpjDdV04U
X-Google-Smtp-Source: AA+uWPySRNfrAWG9RSpfn79mqcQ3auwS2vMxUKltjxtcOa63yZ0GG7Zj2l0mnFraaXrnCfAX7tzLuwnywxLqpksHWo7R+K0EuhRa
MIME-Version: 1.0
X-Received: by 2002:a6b:8bd2:: with SMTP id n201-v6mr11901559iod.138.1534320604022;
 Wed, 15 Aug 2018 01:10:04 -0700 (PDT)
Date:   Wed, 15 Aug 2018 01:10:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009311aa057374da90@google.com>
Subject: KASAN: slab-out-of-bounds Read in _autofs_dev_ioctl
From:   syzbot <syzbot+87c3c541582e56943277@syzkaller.appspotmail.com>
To:     autofs@vger.kernel.org, linux-kernel@vger.kernel.org,
        raven@themaw.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f313b43be461 Merge branch 'i2c/for-current' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c1da3c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=152cb8ccd35b1f70
dashboard link: https://syzkaller.appspot.com/bug?extid=87c3c541582e56943277
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=11f38e22400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165d5c02400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+87c3c541582e56943277@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KASAN: slab-out-of-bounds in _autofs_dev_ioctl+0x8f5/0x990  
fs/autofs/dev-ioctl.c:670
Read of size 4 at addr ffff8801d98bc340 by task syz-executor124/4446

CPU: 1 PID: 4446 Comm: syz-executor124 Not tainted 4.18.0-rc8+ #183
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  _autofs_dev_ioctl+0x8f5/0x990 fs/autofs/dev-ioctl.c:670
  autofs_dev_ioctl+0x1b/0x30 fs/autofs/dev-ioctl.c:704
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440139
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff94b42b78 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 0000000000440139
RDX: 0000000020000180 RSI: 800000000000937e RDI: 0000000000000005
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000217 R12: 00000000004019c0
R13: 0000000000401a50 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 4446:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  ramfs_fill_super+0xc4/0x580 fs/ramfs/inode.c:226
  mount_nodev+0x6b/0x110 fs/super.c:1220
  ramfs_mount+0x2c/0x40 fs/ramfs/inode.c:253
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x581/0x30e0 fs/namespace.c:2848
  ksys_mount+0x12d/0x140 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 2730:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  single_release+0x8f/0xb0 fs/seq_file.c:609
  __fput+0x355/0x8b0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:192 [inline]
  exit_to_usermode_loop+0x313/0x370 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801d98bc340
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
  32-byte region [ffff8801d98bc340, ffff8801d98bc360)
The buggy address belongs to the page:
page:ffffea0007662f00 count:1 mapcount:0 mapping:ffff8801dac001c0  
index:0xffff8801d98bcfc1
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea00072a0088 ffffea00072fccc8 ffff8801dac001c0
raw: ffff8801d98bcfc1 ffff8801d98bc000 0000000100000022 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d98bc200: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801d98bc280: fb fb fb fb fc fc fc fc 00 00 fc fc fc fc fc fc
> ffff8801d98bc300: fb fb fb fb fc fc fc fc 02 fc fc fc fc fc fc fc
                                            ^
  ffff8801d98bc380: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801d98bc400: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
