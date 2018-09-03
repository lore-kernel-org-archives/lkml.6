Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89302C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B9C20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B9C20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeICXwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:52:41 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:57079 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbeICXwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:52:41 -0400
Received: by mail-it0-f70.google.com with SMTP id i188-v6so1510756itf.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 12:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hX26kx94On/Nigb+bJvaofikzGb3yla9GRnV2bG291Y=;
        b=ECyl6N4gB/gUR0B80VdzCuSYkZCKLTvaNFDgjYwuGMOuQhmNIG3s1eNJO9TjbskdSd
         mZlllFUJ1YMksY6dsPO4zVW74SJ5KKu3hb+4pFzJCwv7pzhoj0Klua/CW6dOi4NFXXEi
         PbPXT8KK+2fPHzbXrYGLXt7eyjpMF0BW2aOri6dgG+ohAoom3eKub73N8aqUnKTbQAW+
         OwW4jp8UY4oT5f8sl0D8nC8R2FeVinimNjGO4nQ+CJH2YqPmYP0g+qoLOzxJc0+Yy0Cn
         fG9ElYmfnTB+EMuIV56KM3IOSCuXl+wH0fYWWMHF55cTe3r6bNCbF715V4O8qdz2NGM+
         U2Dw==
X-Gm-Message-State: APzg51DGnF+mRIR0tYCVpYk1zr2zUPlyxQ/iXNvg32HOlrH4wneI+gGv
        xXlcEwteXJE7hpRx9fT+HxSAh/9MasTrN6fSiioPfN577pxG
X-Google-Smtp-Source: ANB0VdYBfeRrHanSUp82N95LPUh+og1eGYRFlYrzKhiW87Z163YevN03OcNDouX7V61dIM5EkkzYGZkAkMbFDCM+LpO5oLq2X1Mx
MIME-Version: 1.0
X-Received: by 2002:a02:9f01:: with SMTP id z1-v6mr12414769jal.5.1536003062808;
 Mon, 03 Sep 2018 12:31:02 -0700 (PDT)
Date:   Mon, 03 Sep 2018 12:31:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eec8990574fc94e2@google.com>
Subject: KASAN: use-after-free Read in sock_i_ino
From:   syzbot <syzbot+48804b87c16588ad491d@syzkaller.appspotmail.com>
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

HEAD commit:    dc6417949297 Merge branch 'net_sched-reject-unknown-tcfa_a..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=13e9e70e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
dashboard link: https://syzkaller.appspot.com/bug?extid=48804b87c16588ad491d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1324fda6400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+48804b87c16588ad491d@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: use-after-free in sock_i_ino+0x94/0xa0 net/core/sock.c:1921
Read of size 8 at addr ffff8801ba5e40b0 by task syz-executor0/5008

CPU: 0 PID: 5008 Comm: syz-executor0 Not tainted 4.19.0-rc1+ #77
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  sock_i_ino+0x94/0xa0 net/core/sock.c:1921
  tipc_sk_fill_sock_diag+0x3be/0xdb0 net/tipc/socket.c:3316
  __tipc_add_sock_diag+0x22f/0x360 net/tipc/diag.c:62
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
  netlink_unicast+0x5a0/0x760 net/netlink/af_netlink.c:1343
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2114
  __sys_sendmsg+0x11d/0x290 net/socket.c:2152
  __do_sys_sendmsg net/socket.c:2161 [inline]
  __se_sys_sendmsg net/socket.c:2159 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2159
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa11f7e0c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fa11f7e16d4 RCX: 0000000000457089
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000006
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d4570 R14: 00000000004c8d49 R15: 0000000000000000

Allocated by task 5008:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x710 mm/slab.c:3554
  sock_alloc_inode+0x1d/0x260 net/socket.c:244
  alloc_inode+0x63/0x190 fs/inode.c:210
  new_inode_pseudo+0x71/0x1a0 fs/inode.c:903
  sock_alloc+0x41/0x270 net/socket.c:547
  __sock_create+0x175/0x940 net/socket.c:1239
  sock_create net/socket.c:1315 [inline]
  __sys_socket+0x106/0x260 net/socket.c:1345
  __do_sys_socket net/socket.c:1354 [inline]
  __se_sys_socket net/socket.c:1352 [inline]
  __x64_sys_socket+0x73/0xb0 net/socket.c:1352
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 5007:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x280 mm/slab.c:3756
  sock_destroy_inode+0x51/0x60 net/socket.c:272
  destroy_inode+0x159/0x200 fs/inode.c:267
  evict+0x5d5/0x990 fs/inode.c:575
  iput_final fs/inode.c:1547 [inline]
  iput+0x5fa/0xa00 fs/inode.c:1573
  dentry_unlink_inode+0x461/0x5e0 fs/dcache.c:374
  __dentry_kill+0x44c/0x7a0 fs/dcache.c:566
  dentry_kill+0xc9/0x5a0 fs/dcache.c:685
  dput.part.26+0x66b/0x7a0 fs/dcache.c:846
  dput+0x15/0x20 fs/dcache.c:828
  __fput+0x4d4/0xa40 fs/file_table.c:291
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801ba5e4040
  which belongs to the cache sock_inode_cache(17:syz0) of size 984
The buggy address is located 112 bytes inside of
  984-byte region [ffff8801ba5e4040, ffff8801ba5e4418)
The buggy address belongs to the page:
page:ffffea0006e97900 count:1 mapcount:0 mapping:ffff8801d09a3780  
index:0xffff8801ba5e4ffd
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0006e93e08 ffffea0006e97988 ffff8801d09a3780
raw: ffff8801ba5e4ffd ffff8801ba5e4040 0000000100000003 ffff8801b1d94a40
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff8801b1d94a40

Memory state around the buggy address:
  ffff8801ba5e3f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8801ba5e4000: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> ffff8801ba5e4080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                      ^
  ffff8801ba5e4100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801ba5e4180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
