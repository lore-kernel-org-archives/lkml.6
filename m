Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFB8C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D06204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D06204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeIJN26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:28:58 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:46487 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbeIJN26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:28:58 -0400
Received: by mail-io1-f71.google.com with SMTP id f4-v6so3294581ioh.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TsHdSqRgpA32QlcXmES3kpA5nwz6U8fbOojB3daXkF0=;
        b=DFdiGt1iNZ/9phoSmU+1b+SgYfh4p2k3dggi9NrIHNI1FDudx/2+JPpB+ecdRI1GtO
         kfLp8G+tAAEs9ppg+OvoBpxCtckZ9L7xTmgy16/CtGTgWp+T0r0vpiWn4RIhdha9UiPw
         6GAgU/bEHZm3Gt2oJuvMERMpstv3hAiJUG+W5wm4Vf93t3X9bxskQtdBkvxdVmxky2s8
         YPxz2v1cw1Nq60d26uKj1KKZjShg33NSPkAllIU9CL67MNLAMQeQ+16lGzyrJgt4fEaf
         ainh09DUnvz7wtUCItJ8nDOk8VcOpX7c63Tb7hu0OslT9GeCkwg/B8KIoN1dmSP6EBQS
         NEEA==
X-Gm-Message-State: APzg51Coi7QsjnRS9diV92u/HAHMjrkv7La2GvD+T8GOjiWM4ju0x9Qn
        jYBPXIs8HmmQvtM2+Si2HMS0gWX2sqdAwqjmV6QLWdS1yXoQ
X-Google-Smtp-Source: ANB0Vdb1WAHUjfpV+1t8qWvZ8seSwWb/PjlvlhPC1sJ7EBKJByeRb14aTNM2FEiJzTNsc1xePku6NoJJAKB+CQkcYSfRb4PX78Yj
MIME-Version: 1.0
X-Received: by 2002:a24:7555:: with SMTP id y82-v6mr18184421itc.9.1536568563031;
 Mon, 10 Sep 2018 01:36:03 -0700 (PDT)
Date:   Mon, 10 Sep 2018 01:36:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f685a0575803f5c@google.com>
Subject: KASAN: use-after-free Read in sock_i_uid
From:   syzbot <syzbot+b239ac9b3c007f9cef90@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3d0e7a9e00fd Merge tag 'md/4.19-rc2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1261e98e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=b239ac9b3c007f9cef90
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b239ac9b3c007f9cef90@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in sock_i_uid+0x9c/0xb0 net/core/sock.c:1910
Read of size 4 at addr ffff8801c4333a34 by task syz-executor2/10612

CPU: 1 PID: 10612 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  sock_i_uid+0x9c/0xb0 net/core/sock.c:1910
  tipc_sk_fill_sock_diag+0x3f7/0xd90 net/tipc/socket.c:3317
  __tipc_add_sock_diag+0x233/0x360 net/tipc/diag.c:62
  tipc_nl_sk_walk+0x122/0x1d0 net/tipc/socket.c:3250
  tipc_diag_dump+0x24/0x30 net/tipc/diag.c:73
  netlink_dump+0x519/0xd50 net/netlink/af_netlink.c:2233
  __netlink_dump_start+0x4f1/0x6f0 net/netlink/af_netlink.c:2329
  netlink_dump_start include/linux/netlink.h:213 [inline]
  tipc_sock_diag_handler_dump+0x28e/0x3d0 net/tipc/diag.c:91
  __sock_diag_cmd net/core/sock_diag.c:232 [inline]
  sock_diag_rcv_msg+0x31d/0x410 net/core/sock_diag.c:263
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2454
  sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:274
  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1343
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2114
  __sys_sendmsg+0x11d/0x280 net/socket.c:2152
  __do_sys_sendmsg net/socket.c:2161 [inline]
  __se_sys_sendmsg net/socket.c:2159 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2159
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457099
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f5a612d4c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f5a612d56d4 RCX: 0000000000457099
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000006
RBP: 0000000000930140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d4bc0 R14: 00000000004c910b R15: 0000000000000001

Allocated by task 10609:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
  sock_alloc_inode+0x1d/0x260 net/socket.c:244
  alloc_inode+0x63/0x190 fs/inode.c:210
  new_inode_pseudo+0x71/0x1a0 fs/inode.c:903
  sock_alloc+0x41/0x270 net/socket.c:547
  __sock_create+0x175/0x930 net/socket.c:1239
  sock_create net/socket.c:1315 [inline]
  __sys_socket+0x106/0x260 net/socket.c:1345
  __do_sys_socket net/socket.c:1354 [inline]
  __se_sys_socket net/socket.c:1352 [inline]
  __x64_sys_socket+0x73/0xb0 net/socket.c:1352
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 10609:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3756
  sock_destroy_inode+0x51/0x60 net/socket.c:272
  destroy_inode+0x159/0x200 fs/inode.c:267
  evict+0x5e0/0x980 fs/inode.c:575
  iput_final fs/inode.c:1547 [inline]
  iput+0x679/0xa90 fs/inode.c:1573
  dentry_unlink_inode+0x461/0x5e0 fs/dcache.c:374
  __dentry_kill+0x44c/0x7a0 fs/dcache.c:566
  dentry_kill+0xc9/0x5a0 fs/dcache.c:685
  dput.part.26+0x660/0x790 fs/dcache.c:846
  dput+0x15/0x20 fs/dcache.c:828
  __fput+0x4cf/0xa30 fs/file_table.c:291
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  get_signal+0x155e/0x1980 kernel/signal.c:2343
  do_signal+0x9c/0x21e0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801c4333a00
  which belongs to the cache sock_inode_cache of size 984
The buggy address is located 52 bytes inside of
  984-byte region [ffff8801c4333a00, ffff8801c4333dd8)
The buggy address belongs to the page:
page:ffffea000710ccc0 count:1 mapcount:0 mapping:ffff8801d9489b40  
index:0xffff8801c4333ffd
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea000726fac8 ffffea00074f1b88 ffff8801d9489b40
raw: ffff8801c4333ffd ffff8801c4333100 0000000100000003 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801c4333900: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
  ffff8801c4333980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801c4333a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                      ^
  ffff8801c4333a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801c4333b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
