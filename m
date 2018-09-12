Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC4FC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504F0206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504F0206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeILNGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:06:24 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:51654 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeILNGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:06:24 -0400
Received: by mail-it0-f72.google.com with SMTP id q5-v6so2274623ith.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 01:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=e8JepDvHJpdrRStQ7sMgL5zwSzwLzi1p2dAxm+f/bNs=;
        b=RbL8E61Ltee8ruvvtDWgfft5Iztmnvf2M6orbmch1+pFUuAps88adTAcckhCkO+reF
         EW4FMYygenqSc05BaaBSwnUTpOpPJQVaWemzQjGr88muw/dQVGhx8EfMjcJeJVLjfxl0
         yjgwuyNLMMqGOeNyb86cnhqRaO7hmSVSx3IlMq9EXMsjUIi1ZWqgJ7/RGO38xhelq4z9
         gn6cpOWVkS81BKCCSu7NYUBhJx6WHBzxUxJbHfw1tApLluan74dGJZShQq840pZq20m+
         Pyf5IbLWcirthwUpDpT+pXijMzFmV66kwvBAjh4sl+EXEWGj5GQEdVGSZvoJzkO8mUsO
         JwqA==
X-Gm-Message-State: APzg51ACdeSHqvdGGldKqENufinsHIBslZL0JNxYWB/ewDnVICcep3cq
        7eOpe2tJqSLIrBPopvrJQRoCRISB27kHrKR/9jVBO0fdeMdd
X-Google-Smtp-Source: ANB0VdYN+TUlGYI/wV8+upUrbohu7Pu4Tj6ZfFtjMWPKO2dB83Nizm7UuS31s6eee1dg4P2Gyhk9C8dgnRaS9XOWnrEoLQs3v8Qy
MIME-Version: 1.0
X-Received: by 2002:a24:76c9:: with SMTP id z192-v6mr660688itb.29.1536739382328;
 Wed, 12 Sep 2018 01:03:02 -0700 (PDT)
Date:   Wed, 12 Sep 2018 01:03:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff07eb0575a80466@google.com>
Subject: KASAN: use-after-free Read in gfs2_log_flush
From:   syzbot <syzbot+dcb8b3587445007f5808@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f2b6e66e9885 Add linux-next specific files for 20180904
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1784acd1400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15ad48400e39c1b3
dashboard link: https://syzkaller.appspot.com/bug?extid=dcb8b3587445007f5808
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+dcb8b3587445007f5808@syzkaller.appspotmail.com

gfs2: not a GFS2 filesystem
gfs2: not a GFS2 filesystem
gfs2: not a GFS2 filesystem
gfs2: can't alloc struct gfs2_sbd
==================================================================
BUG: KASAN: use-after-free in atomic_read  
include/asm-generic/atomic-instrumented.h:21 [inline]
BUG: KASAN: use-after-free in gfs2_log_flush+0x1ec/0x28b0 fs/gfs2/log.c:779
Read of size 4 at addr ffff88018bd262e8 by task syz-executor6/22268

CPU: 0 PID: 22268 Comm: syz-executor6 Not tainted 4.19.0-rc2-next-20180904+  
#55
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  kasan_check_read+0x11/0x20 mm/kasan/kasan.c:272
  atomic_read include/asm-generic/atomic-instrumented.h:21 [inline]
  gfs2_log_flush+0x1ec/0x28b0 fs/gfs2/log.c:779
  gfs2_kill_sb+0x5b/0x1a0 fs/gfs2/ops_fstype.c:1368
  deactivate_locked_super+0x97/0x100 fs/super.c:328
  gfs2_mount+0x568/0x712 fs/gfs2/ops_fstype.c:1317
  legacy_get_tree+0x131/0x460 fs/fs_context.c:732
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1746
  do_new_mount fs/namespace.c:2627 [inline]
  do_mount+0x6f9/0x1e30 fs/namespace.c:2951
  ksys_mount+0x12d/0x140 fs/namespace.c:3167
  __do_sys_mount fs/namespace.c:3181 [inline]
  __se_sys_mount fs/namespace.c:3178 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3178
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459aca
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 bd 8a fb ff c3 66 2e 0f  
1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 9a 8a fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007fc96a5a3a88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fc96a5a3b30 RCX: 0000000000459aca
RDX: 00007fc96a5a3ad0 RSI: 0000000020000300 RDI: 00007fc96a5a3af0
RBP: 0000000020000300 R08: 00007fc96a5a3b30 R09: 00007fc96a5a3ad0
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000003
R13: 0000000000000000 R14: 00000000004ca2a2 R15: 0000000000000000

Allocated by task 22268:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x730 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  init_sbd+0x141/0xfa0 fs/gfs2/ops_fstype.c:71
  fill_super+0xab/0x1a40 fs/gfs2/ops_fstype.c:1041
  gfs2_mount+0x5e6/0x712 fs/gfs2/ops_fstype.c:1303
  legacy_get_tree+0x131/0x460 fs/fs_context.c:732
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1746
  do_new_mount fs/namespace.c:2627 [inline]
  do_mount+0x6f9/0x1e30 fs/namespace.c:2951
  ksys_mount+0x12d/0x140 fs/namespace.c:3167
  __do_sys_mount fs/namespace.c:3181 [inline]
  __se_sys_mount fs/namespace.c:3178 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3178
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 22268:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x210 mm/slab.c:3813
  init_sbd+0xd82/0xfa0 fs/gfs2/ops_fstype.c:79
  fill_super+0xab/0x1a40 fs/gfs2/ops_fstype.c:1041
  gfs2_mount+0x5e6/0x712 fs/gfs2/ops_fstype.c:1303
  legacy_get_tree+0x131/0x460 fs/fs_context.c:732
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1746
  do_new_mount fs/namespace.c:2627 [inline]
  do_mount+0x6f9/0x1e30 fs/namespace.c:2951
  ksys_mount+0x12d/0x140 fs/namespace.c:3167
  __do_sys_mount fs/namespace.c:3181 [inline]
  __se_sys_mount fs/namespace.c:3178 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3178
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88018bd25340
  which belongs to the cache kmalloc-8192 of size 8192
The buggy address is located 4008 bytes inside of
  8192-byte region [ffff88018bd25340, ffff88018bd27340)
The buggy address belongs to the page:
page:ffffea00062f4900 count:1 mapcount:0 mapping:ffff8801dac02080 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea0006260d08 ffffea0006457608 ffff8801dac02080
raw: 0000000000000000 ffff88018bd25340 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88018bd26180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88018bd26200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88018bd26280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                           ^
  ffff88018bd26300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88018bd26380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
