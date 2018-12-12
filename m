Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E80C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFF72084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EFF72084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeLLJpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:45:05 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:59985 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeLLJpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:45:04 -0500
Received: by mail-it1-f199.google.com with SMTP id t143so4981079itc.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 01:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=29PVvpvRGfuPaUNvEkx0GbfwB3a6PfJH6Z6KRXdpKJ4=;
        b=UhhmWbfG+tkfN4PbKfkyEl28uAPa5kHXxbswk9upCC7Zj6DeAvJSiJ2RbGSsg7R/L8
         MmkvMifTvqGlu7HaQZyVXMxx3gxsS3jVrTDJ2viKTVJG1n0pgi7x0jypkHMfDIkgZGGf
         NJmeo+XUQ2UNCEGV1h+ukM4mXlNmbDKbGu3b1trVIQjW/M4aHswIRYUgtBHiLzyZROoX
         t2PMXOFwuhSjoyS6BZt6lyLuDEnee7wadEG3pS9d0NrpNp6mh7bS4XavsMYmLofLCObE
         0n0RiSSYuUq2me3LHQn3KG8tq2BprYyWOjubjvytjR62cgJOQN62sUQBf0vleaMBqG5n
         GUYA==
X-Gm-Message-State: AA+aEWbsurxXm4SvzO7FCyE5MA2IFvsdPU98Nml63IHHMOduMRwpwJ6p
        NI1jmfgxHV3q+vcxkCEDNODTdm1lkTbELWOSejlKdDLTUP1Z
X-Google-Smtp-Source: AFSGD/VdCE85qa3uPCdMAKZOleBZ3WZ7TcKuId0ilOcx9YzBeMfV5LamLBTJsWqDyVwWUDS4ayV5gUsOmWCsBgbW2Ei5MsCntf0q
MIME-Version: 1.0
X-Received: by 2002:a24:760e:: with SMTP id z14mr4139813itb.5.1544607903391;
 Wed, 12 Dec 2018 01:45:03 -0800 (PST)
Date:   Wed, 12 Dec 2018 01:45:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000665f2e057cd00db6@google.com>
Subject: KASAN: use-after-free Read in handle_userfault (2)
From:   syzbot <syzbot+cbc64b24b2b2d54c07a9@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    14cf8c1d5b90 Add linux-next specific files for 20181210
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=133296db400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9133d0a4284c012
dashboard link: https://syzkaller.appspot.com/bug?extid=cbc64b24b2b2d54c07a9
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cbc64b24b2b2d54c07a9@syzkaller.appspotmail.com

RDX: 00000000000003ff RSI: 0000000020012fe0 RDI: 00007f5dbe489850
RBP: 000000000072bf00 R08: 00000000000003ff R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5dbe48a6d4
R13: 00000000004c578a R14: 00000000004d9d90 R15: 00000000ffffffff
==================================================================
BUG: KASAN: use-after-free in __list_del_entry_valid+0xf1/0x100  
lib/list_debug.c:51
CPU: 1 PID: 20306 Comm: syz-executor2 Not tainted 4.20.0-rc6-next-20181210+  
#164
Read of size 8 at addr ffff8881c5e72bb0 by task kworker/0:1/12
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011

Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  handle_userfault.cold.30+0x47/0x62 fs/userfaultfd.c:431
  do_anonymous_page mm/memory.c:2938 [inline]
  handle_pte_fault mm/memory.c:3780 [inline]
  __handle_mm_fault+0x4d26/0x5b70 mm/memory.c:3906
  handle_mm_fault+0x54f/0xc70 mm/memory.c:3943
  do_user_addr_fault arch/x86/mm/fault.c:1475 [inline]
  __do_page_fault+0x5f6/0xd70 arch/x86/mm/fault.c:1541
  do_page_fault+0xf2/0x7e0 arch/x86/mm/fault.c:1572
  page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1143
RIP: 0033:0x4510a0
Code: 0f 84 c4 0f 00 00 48 89 f1 48 89 f8 48 83 e1 3f 48 83 f9 20 0f 86 7b  
02 00 00 48 83 e6 f0 48 83 e1 0f 66 0f ef c0 66 0f ef c9 <66> 0f 74 0e 66  
0f d7 d1 48 d3 ea 49 c7 c2 11 00 00 00 49 29 ca 4d
RSP: 002b:00007fab1fbba7a8 EFLAGS: 00010202
RAX: 00007fab1fbba850 RBX: 0000000000000003 RCX: 000000000000000e
RDX: 00000000000003ff RSI: 0000000020012fe0 RDI: 00007fab1fbba850
RBP: 000000000072bf00 R08: 00000000000003ff R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fab1fbbb6d4
R13: 00000000004c578a R14: 00000000004d9d90 R15: 00000000ffffffff
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 4.20.0-rc6-next-20181210+ #164
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_power_efficient neigh_periodic_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.4+0x9/0x1ff mm/kasan/report.c:187
  kasan_report.cold.5+0x1b/0x39 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
  __list_del_entry_valid+0xf1/0x100 lib/list_debug.c:51
  __list_del_entry include/linux/list.h:117 [inline]
  list_del_init include/linux/list.h:159 [inline]
  neigh_mark_dead+0x13b/0x410 net/core/neighbour.c:125
  neigh_periodic_work+0x89a/0xc30 net/core/neighbour.c:905
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Allocated by task 8166:
  save_stack+0x43/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  kasan_kmalloc+0xcb/0xd0 mm/kasan/common.c:482
  __do_kmalloc_node mm/slab.c:3671 [inline]
  __kmalloc_node_track_caller+0x4d/0x70 mm/slab.c:3685
  __kmalloc_reserve.isra.38+0x41/0xe0 net/core/skbuff.c:137
  __alloc_skb+0x155/0x770 net/core/skbuff.c:205
  alloc_skb include/linux/skbuff.h:1008 [inline]
  netlink_alloc_large_skb net/netlink/af_netlink.c:1182 [inline]
  netlink_sendmsg+0xb29/0xfc0 net/netlink/af_netlink.c:1892
  sock_sendmsg_nosec net/socket.c:622 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:632
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2117
  __sys_sendmsg+0x11d/0x280 net/socket.c:2155
  __do_sys_sendmsg net/socket.c:2164 [inline]
  __se_sys_sendmsg net/socket.c:2162 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2162
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8166:
  save_stack+0x43/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:444
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:452
  __cache_free mm/slab.c:3485 [inline]
  kfree+0xcf/0x230 mm/slab.c:3804
  skb_free_head+0x99/0xc0 net/core/skbuff.c:550
  skb_release_data+0x70c/0x9a0 net/core/skbuff.c:570
  skb_release_all+0x4a/0x60 net/core/skbuff.c:627
  __kfree_skb net/core/skbuff.c:641 [inline]
  consume_skb+0x1ae/0x570 net/core/skbuff.c:701
  netlink_unicast_kernel net/netlink/af_netlink.c:1311 [inline]
  netlink_unicast+0x5ad/0x760 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:622 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:632
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2117
  __sys_sendmsg+0x11d/0x280 net/socket.c:2155
  __do_sys_sendmsg net/socket.c:2164 [inline]
  __se_sys_sendmsg net/socket.c:2162 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2162
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881c5e72940
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 624 bytes inside of
  1024-byte region [ffff8881c5e72940, ffff8881c5e72d40)
The buggy address belongs to the page:
page:ffffea0007179c80 count:1 mapcount:0 mapping:ffff8881da800ac0  
index:0xffff8881c5e72dc0 compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea00072cf188 ffffea00075d0c08 ffff8881da800ac0
raw: ffff8881c5e72dc0 ffff8881c5e72040 0000000100000005 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881c5e72a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881c5e72b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881c5e72b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                      ^
  ffff8881c5e72c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881c5e72c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
kobject: 'loop5' (00000000a3f9d928): kobject_uevent_env


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
