Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4837EC00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 05:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E541D20841
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 05:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E541D20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeJGMHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 08:07:04 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:54113 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeJGMHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 08:07:04 -0400
Received: by mail-it1-f198.google.com with SMTP id f79-v6so7490983ita.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 22:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zGLx32UQVIXM+G2R2ANyoOn37DobQY0Dv161/BqJxWk=;
        b=dszIZ9jW1nXl3kWIF8o3U9s8GZOyt0ygqnworK3aiBBcp4j+RLvKD8aLKmHMpr52GP
         nGYv+f805F0DZb6J2ENjMdEPnctHM/NsKEsiSbrI97Xf7+6QWMcK9gYfz5UdjgIN8kiQ
         NsFji9e3RxlghgmkkKaRXN4+CbmL3AQBBDzqAp7bYrhB2GXNY3cULgAtOwfqGd6XMHt0
         V6ZTzaIHqGLYHwSKr9SgNUXkgMI1WDujGI+p79NDGCYb3F/FKq2HJPQf0IJ8QeSSMKIl
         CF9BTsTTEy2DeIhV+hwhqmiJHMpboA1DTkUzMXUYBNyUMeTTa0KyGy/kVSYWMzCQ5HkN
         fqSQ==
X-Gm-Message-State: ABuFfoj0OHKNfSHGtPIvUaFiI1z2WzenO9f9Je6T73Hn6hUBi8Rz9Fch
        KnnhZdnybVMX2/7egr4mAhRjKfdXJDNF61yopSg8yCbt80V4
X-Google-Smtp-Source: ACcGV607b1+oEM16RBCUQ3LvGgFNWbKRlHsk4az53YnW6re7Y3OvqZ2nZfT6h89zGLh4SqkuRg7R2f5Iq4mWHbPI81Uda3ke54RJ
MIME-Version: 1.0
X-Received: by 2002:a02:3f2e:: with SMTP id d46-v6mr13994411jaa.21.1538888463091;
 Sat, 06 Oct 2018 22:01:03 -0700 (PDT)
Date:   Sat, 06 Oct 2018 22:01:03 -0700
In-Reply-To: <000000000000ff07eb0575a80466@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003114c405779c6474@google.com>
Subject: Re: KASAN: use-after-free Read in gfs2_log_flush
From:   syzbot <syzbot+dcb8b3587445007f5808@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    12ffaa1197f5 Add linux-next specific files for 20181005
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13b5c041400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b058a7232046f
dashboard link: https://syzkaller.appspot.com/bug?extid=dcb8b3587445007f5808
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b25e3a400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+dcb8b3587445007f5808@syzkaller.appspotmail.com

gfs2: not a GFS2 filesystem
gfs2: not a GFS2 filesystem
gfs2: not a GFS2 filesystem
gfs2: can't alloc struct gfs2_sbd
==================================================================
BUG: KASAN: use-after-free in atomic_read  
include/asm-generic/atomic-instrumented.h:21 [inline]
BUG: KASAN: use-after-free in gfs2_log_flush+0x1ec/0x29b0 fs/gfs2/log.c:779
Read of size 4 at addr ffff8801cda66860 by task syz-executor0/12715

CPU: 1 PID: 12715 Comm: syz-executor0 Not tainted 4.19.0-rc6-next-20181005+  
#88
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  kasan_check_read+0x11/0x20 mm/kasan/kasan.c:272
  atomic_read include/asm-generic/atomic-instrumented.h:21 [inline]
  gfs2_log_flush+0x1ec/0x29b0 fs/gfs2/log.c:779
  gfs2_kill_sb+0x5b/0x1a0 fs/gfs2/ops_fstype.c:1368
  deactivate_locked_super+0x97/0x100 fs/super.c:328
  gfs2_mount+0x568/0x712 fs/gfs2/ops_fstype.c:1317
  legacy_get_tree+0x131/0x460 fs/fs_context.c:718
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1795
  do_new_mount fs/namespace.c:2648 [inline]
  do_mount+0x70c/0x1d90 fs/namespace.c:2974
  ksys_mount+0x12d/0x140 fs/namespace.c:3190
  __do_sys_mount fs/namespace.c:3204 [inline]
  __se_sys_mount fs/namespace.c:3201 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3201
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457579
kobject: 'rx-0' (00000000376ddb4b): kobject_uevent_env
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe6c9feec78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000457579
RDX: 0000000020000300 RSI: 00000000200002c0 RDI: 0000000020000000
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
kobject: 'rx-0' (00000000376ddb4b): fill_kobj_path: path  
= '/devices/virtual/net/ip6tnl0/queues/rx-0'
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe6c9fef6d4
R13: 00000000004c28af R14: 00000000004d3c78 R15: 00000000ffffffff

kobject: 'tx-0' (00000000c6cb95cd): kobject_add_internal: parent: 'queues',  
set: 'queues'
Allocated by task 12715:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:546 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  init_sbd+0x13f/0xfa0 fs/gfs2/ops_fstype.c:71
kobject: 'tx-0' (00000000c6cb95cd): kobject_uevent_env
  fill_super+0xab/0x1a10 fs/gfs2/ops_fstype.c:1041
  gfs2_mount+0x5e6/0x712 fs/gfs2/ops_fstype.c:1303
  legacy_get_tree+0x131/0x460 fs/fs_context.c:718
kobject: 'tx-0' (00000000c6cb95cd): fill_kobj_path: path  
= '/devices/virtual/net/ip6tnl0/queues/tx-0'
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1795
  do_new_mount fs/namespace.c:2648 [inline]
  do_mount+0x70c/0x1d90 fs/namespace.c:2974
  ksys_mount+0x12d/0x140 fs/namespace.c:3190
kobject: 'ip6gre0' (0000000031e17a8a): kobject_add_internal: parent: 'net',  
set: 'devices'
  __do_sys_mount fs/namespace.c:3204 [inline]
  __se_sys_mount fs/namespace.c:3201 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3201
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
kobject: 'ip6gre0' (0000000031e17a8a): kobject_uevent_env

Freed by task 12715:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  init_sbd+0xe39/0xfa0 fs/gfs2/ops_fstype.c:79
  fill_super+0xab/0x1a10 fs/gfs2/ops_fstype.c:1041
kobject: 'ip6gre0' (0000000031e17a8a): fill_kobj_path: path  
= '/devices/virtual/net/ip6gre0'
  gfs2_mount+0x5e6/0x712 fs/gfs2/ops_fstype.c:1303
  legacy_get_tree+0x131/0x460 fs/fs_context.c:718
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1795
  do_new_mount fs/namespace.c:2648 [inline]
  do_mount+0x70c/0x1d90 fs/namespace.c:2974
  ksys_mount+0x12d/0x140 fs/namespace.c:3190
kobject: 'queues' (00000000ec0ee65d): kobject_add_internal:  
parent: 'ip6gre0', set: '<NULL>'
  __do_sys_mount fs/namespace.c:3204 [inline]
  __se_sys_mount fs/namespace.c:3201 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3201
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

kobject: 'queues' (00000000ec0ee65d): kobject_uevent_env
The buggy address belongs to the object at ffff8801cda658c0
  which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 4000 bytes inside of
  8192-byte region [ffff8801cda658c0, ffff8801cda678c0)
The buggy address belongs to the page:
page:ffffea0007369900 count:1 mapcount:0 mapping:ffff8801da802080 index:0x0  
compound_mapcount: 0
kobject: 'queues' (00000000ec0ee65d): kobject_uevent_env: filter function  
caused the event to drop!
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea0007307c08 ffff8801da801b48 ffff8801da802080
kobject: 'rx-0' (0000000087456c9b): kobject_add_internal: parent: 'queues',  
set: 'queues'
raw: 0000000000000000 ffff8801cda658c0 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801cda66700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801cda66780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801cda66800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
kobject: 'rx-0' (0000000087456c9b): kobject_uevent_env
                                                        ^
  ffff8801cda66880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801cda66900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

