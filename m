Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68246C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203D4206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203D4206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732715AbeHWSFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:05:02 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:43381 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732492AbeHWSFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:05:02 -0400
Received: by mail-io0-f197.google.com with SMTP id w19-v6so4437012ioa.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 07:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=harTXVx+y1iqT8yv/J9vPVFQU1o8SYK3wQEhbVS6UEc=;
        b=qj0Bs7uUwLvfTFw6pF4tAEhcDPSorUHewy9lMXtozN/QGjhIJHlSglza1e+QiCZLL4
         qWZM8bkR19RD/d6cLJxHts5VAgDoxC+GHpwXOlI5UVzflmhvIc91Zd3cH5ClJnhadmBT
         Vn/2gOlBwN/siUUPx3YUN1k4pVivW/erxTS/WTa4bvDIuKK3NuJWFjExMu8X+Iot5GBY
         OrUNIHIAj/82KsTdpicej6yfm/3KM/H7L/sPSRPOw/R1LuLzRnivz26os+kEKRsy0vu1
         grhrhyxsm8X9Bg5fBUiuYe6T5nGmVknILk2pLzpu5MMPU2/xg72x90/n7GogsottlA5l
         1wdg==
X-Gm-Message-State: AOUpUlG7CntDrEcdDI1lxv/TAHq5Ajgur139BIeIoFkdUvnTLqj/AxLU
        ojVAZvMAIJnTswzqQU25jmgOc26Rmfw4iLloTJP8eP9bXEJJ
X-Google-Smtp-Source: AA+uWPzz1oqwgC2B/JVJ+teiiWpognWrmdXEjyntiN20TKdAC82LMal6rh1lfpSNlBTt6I7Gkodo5FY9B93KSv++N+W6rLeNNFKU
MIME-Version: 1.0
X-Received: by 2002:a6b:99d3:: with SMTP id b202-v6mr23947600ioe.54.1535034903898;
 Thu, 23 Aug 2018 07:35:03 -0700 (PDT)
Date:   Thu, 23 Aug 2018 07:35:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a37a205741b2ae1@google.com>
Subject: KASAN: use-after-free Read in ceph_destroy_options
From:   syzbot <syzbot+8ab6f1042021b4eed062@syzkaller.appspotmail.com>
To:     ceph-devel@vger.kernel.org, davem@davemloft.net,
        idryomov@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, sage@redhat.com,
        syzkaller-bugs@googlegroups.com, zyan@redhat.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    cc3d190b12b3 Add linux-next specific files for 20180822
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=107d322e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce7f661707bc9904
dashboard link: https://syzkaller.appspot.com/bug?extid=8ab6f1042021b4eed062
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8ab6f1042021b4eed062@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ceph_destroy_options+0xe0/0x110  
net/ceph/ceph_common.c:289
Read of size 8 at addr ffff8801d8f4dd50 by task syz-executor2/7977

CPU: 0 PID: 7977 Comm: syz-executor2 Not tainted 4.18.0-next-20180822+ #45
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  ceph_destroy_options+0xe0/0x110 net/ceph/ceph_common.c:289
  ceph_mount+0xeab/0x1cc0 fs/ceph/super.c:1047
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
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fae7dd45c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fae7dd466d4 RCX: 0000000000457089
RDX: 0000000020000080 RSI: 0000000020000040 RDI: 0000000020000000
RBP: 00000000009300a0 R08: 00000000200000c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d2750 R14: 00000000004c7bdf R15: 0000000000000000

Allocated by task 7977:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x730 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  ceph_parse_options+0xfe/0x1230 net/ceph/ceph_common.c:355
  parse_mount_options fs/ceph/super.c:491 [inline]
  ceph_mount+0x4b9/0x1cc0 fs/ceph/super.c:1036
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

Freed by task 7977:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x210 mm/slab.c:3813
  ceph_destroy_options+0xd4/0x110 net/ceph/ceph_common.c:295
  ceph_destroy_client+0x139/0x1a0 net/ceph/ceph_common.c:680
  create_fs_client fs/ceph/super.c:677 [inline]
  ceph_mount+0xf6e/0x1cc0 fs/ceph/super.c:1043
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

The buggy address belongs to the object at ffff8801d8f4dc80
  which belongs to the cache kmalloc-256 of size 256
The buggy address is located 208 bytes inside of
  256-byte region [ffff8801d8f4dc80, ffff8801d8f4dd80)
The buggy address belongs to the page:
page:ffffea000763d340 count:1 mapcount:0 mapping:ffff8801dac007c0 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0006c0e448 ffffea00072ca688 ffff8801dac007c0
raw: 0000000000000000 ffff8801d8f4d000 000000010000000c 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d8f4dc00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8801d8f4dc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801d8f4dd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                  ^
  ffff8801d8f4dd80: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
  ffff8801d8f4de00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
