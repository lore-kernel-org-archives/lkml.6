Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF8CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343B4217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfBZNyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:54:07 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:52418 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfBZNyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:54:06 -0500
Received: by mail-io1-f71.google.com with SMTP id s18so10638083ioe.19
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 05:54:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7oltl3iDugsP1W/ondkc3VmzZCmYB3gu5tWuMCJTzJU=;
        b=HM4uGuxvzhnGUlUvJ8O1191pkiEc1Dv1F865e8T8c3DVyDAHvljjMBWU9Ly2OEDdex
         xB0DrWxBgcy3GCMHJsHKLnOdS4fDev6PDBqRjU3lcH4UF+Ts/luOHKiy+jo+CLWJau4O
         N5hZ7auRAiELVeT8Y8CnOdm2G3oIwv0oTzPjrc4Rgx6Ibyn5R3bx9G9fZoVoXoRCXYIQ
         bcr0BUw5NQU/qXvO0/SV9zTOE1IMX+hHAK29BKpm6Y8FQcV3Js/v6fsuo9lMVP9UCpn6
         0QtTkz0/pb5Gn5sGsRbAvrGANuxOpG68JhKX75XyTHKJUrKMDb9y3HHWowH8lzmQMeSs
         aSZw==
X-Gm-Message-State: AHQUAuZd5LcrpifFbJkLISqdY0FzypV4lCVJAfcduBex51Qc8KYQACS3
        rUd8L1niIxVkieYRyRyktp0bn9DghSICCRfxX+frGuN/wcHM
X-Google-Smtp-Source: AHgI3IYrgg+eH6msiLPlnjVO/7nzzVmE5LC6MTPyhAtn98jB6LQQfPyF3Na+52eQB3rJhI/CC9TRngKIbqnyjr2x6CQ/X/ImzAem
MIME-Version: 1.0
X-Received: by 2002:a24:5947:: with SMTP id p68mr2510749itb.27.1551189245430;
 Tue, 26 Feb 2019 05:54:05 -0800 (PST)
Date:   Tue, 26 Feb 2019 05:54:05 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f41ad40582cc632d@google.com>
Subject: general protection fault in __xfrm_policy_check
From:   syzbot <syzbot+4ea28a8b817ee28bf324@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ff7b11aa481f net: socket: set sock->sk to NULL after calli..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=12222e5cc00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7132344728e7ec3f
dashboard link: https://syzkaller.appspot.com/bug?extid=4ea28a8b817ee28bf324
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4ea28a8b817ee28bf324@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
  __sys_recvmmsg+0xe5/0x270 net/socket.c:2471
kasan: GPF could be caused by NULL-ptr deref or user memory access
  __do_sys_recvmmsg net/socket.c:2492 [inline]
  __se_sys_recvmmsg net/socket.c:2485 [inline]
  __x64_sys_recvmmsg+0xe6/0x140 net/socket.c:2485
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
general protection fault: 0000 [#1] PREEMPT SMP KASAN
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
CPU: 1 PID: 16691 Comm: syz-executor.0 Not tainted 5.0.0-rc7+ #96
RIP: 0033:0x457e29
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RIP: 0010:xs_net include/net/xfrm.h:253 [inline]
RIP: 0010:xfrmi_decode_session net/xfrm/xfrm_interface.c:82 [inline]
RIP: 0010:xfrmi_decode_session+0x15c/0x6c0 net/xfrm/xfrm_interface.c:73
RSP: 002b:00007f715c86bc78 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
Code: 7c fc 08 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 2e 05 00 00 48 b8 00  
00 00 00 00 fc ff df 4f 8b 64 fc 08 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f  
85 01 05 00 00 4d 8b 3c 24 e8 71 34 5b fb e8 9c 70
RAX: ffffffffffffffda RBX: 00007f715c86bc90 RCX: 0000000000457e29
RSP: 0018:ffff88804594f120 EFLAGS: 00010246
RDX: 04000000000001de RSI: 00000000200037c0 RDI: 0000000000000004
RAX: dffffc0000000000 RBX: ffff88809fbd1d00 RCX: ffffc90005df3000
RBP: 000000000073bf00 R08: 0000000020003700 R09: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff86027000 RDI: ffff8880a0766b48
R10: 0000000000000006 R11: 0000000000000246 R12: 00007f715c86c6d4
RBP: ffff88804594f148 R08: ffff88805caa44c0 R09: ffffed1015d25bd0
R13: 00000000004c4b3e R14: 00000000004d8648 R15: 0000000000000005
R10: ffffed1015d25bcf R11: ffff8880ae92de7b R12: 0000000000000000
kobject: 'loop3' (0000000085c2aeb9): kobject_uevent_env
R13: 0000000000000037 R14: ffff88809fbd1d10 R15: ffffffffffffffff
kobject: 'loop3' (0000000085c2aeb9): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
FS:  00007f88e71e4700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004db9c0 CR3: 00000000908bb000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
kobject: 'loop3' (0000000085c2aeb9): kobject_uevent_env
  __xfrm_policy_check+0x1f8/0x2730 net/xfrm/xfrm_policy.c:3316
kobject: 'loop3' (0000000085c2aeb9): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000007df39881): kobject_uevent_env
  __xfrm_policy_check2 include/net/xfrm.h:1176 [inline]
  xfrm_policy_check include/net/xfrm.h:1181 [inline]
  xfrm4_policy_check include/net/xfrm.h:1186 [inline]
  vti_input+0x4e3/0x7b0 net/ipv4/ip_vti.c:63
  vti_rcv+0x10b/0x140 net/ipv4/ip_vti.c:109
  xfrm4_esp_rcv+0xd8/0x230 net/ipv4/xfrm4_protocol.c:100
  ip_protocol_deliver_rcu+0x60/0x8e0 net/ipv4/ip_input.c:208
kobject: 'loop2' (000000007df39881): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
  ip_local_deliver_finish+0x23b/0x390 net/ipv4/ip_input.c:234
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip_local_deliver+0x1e9/0x520 net/ipv4/ip_input.c:255
kobject: 'loop4' (00000000be00e036): kobject_uevent_env
  dst_input include/net/dst.h:450 [inline]
  ip_rcv_finish+0x1db/0x2f0 net/ipv4/ip_input.c:414
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip_rcv+0xe8/0x3f0 net/ipv4/ip_input.c:524
kobject: 'loop4' (00000000be00e036): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
  __netif_receive_skb_one_core+0x115/0x1a0 net/core/dev.c:4973
  __netif_receive_skb+0x2c/0x1c0 net/core/dev.c:5083
  netif_receive_skb_internal+0x117/0x660 net/core/dev.c:5186
kobject: 'loop5' (0000000040ba3921): kobject_uevent_env
kobject: 'loop5' (0000000040ba3921): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
  napi_frags_finish net/core/dev.c:5753 [inline]
  napi_gro_frags+0xade/0xd10 net/core/dev.c:5827
  tun_get_user+0x2c0e/0x3dd0 drivers/net/tun.c:1974
  tun_chr_write_iter+0xbd/0x160 drivers/net/tun.c:2019
  call_write_iter include/linux/fs.h:1863 [inline]
  do_iter_readv_writev+0x5e0/0x8e0 fs/read_write.c:680
  do_iter_write fs/read_write.c:956 [inline]
  do_iter_write+0x184/0x610 fs/read_write.c:937
  vfs_writev+0x1b3/0x2f0 fs/read_write.c:1001
  do_writev+0xf6/0x290 fs/read_write.c:1036
  __do_sys_writev fs/read_write.c:1109 [inline]
  __se_sys_writev fs/read_write.c:1106 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1106
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ce1
Code: 75 14 b8 14 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 e4 b9 fb ff c3 48  
83 ec 08 e8 1a 2d 00 00 48 89 04 24 b8 14 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 63 2d 00 00 48 89 d0 48 83 c4 08 48 3d 01
kobject: 'loop1' (000000005642785e): kobject_uevent_env
RSP: 002b:00007f88e71e3ba0 EFLAGS: 00000293 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 000000000000003e RCX: 0000000000457ce1
RDX: 0000000000000001 RSI: 00007f88e71e3bf0 RDI: 00000000000000f0
RBP: 0000000020000040 R08: 00000000000000f0 R09: 0000000000000000
R10: 00007f88e71e49d0 R11: 0000000000000293 R12: 00007f88e71e46d4
R13: 00000000004c64e1 R14: 00000000004db9c0 R15: 00000000ffffffff
Modules linked in:
---[ end trace 2fbdf2db5ff7df79 ]---
kobject: 'loop1' (000000005642785e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
RIP: 0010:xs_net include/net/xfrm.h:253 [inline]
RIP: 0010:xfrmi_decode_session net/xfrm/xfrm_interface.c:82 [inline]
RIP: 0010:xfrmi_decode_session+0x15c/0x6c0 net/xfrm/xfrm_interface.c:73
Code: 7c fc 08 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 2e 05 00 00 48 b8 00  
00 00 00 00 fc ff df 4f 8b 64 fc 08 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f  
85 01 05 00 00 4d 8b 3c 24 e8 71 34 5b fb e8 9c 70
kobject: 'loop3' (0000000085c2aeb9): kobject_uevent_env
RSP: 0018:ffff88804594f120 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88809fbd1d00 RCX: ffffc90005df3000
RDX: 0000000000000000 RSI: ffffffff86027000 RDI: ffff8880a0766b48
kobject: 'loop3' (0000000085c2aeb9): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
RBP: ffff88804594f148 R08: ffff88805caa44c0 R09: ffffed1015d25bd0
R10: ffffed1015d25bcf R11: ffff8880ae92de7b R12: 0000000000000000
R13: 0000000000000037 R14: ffff88809fbd1d10 R15: ffffffffffffffff
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
FS:  00007f88e71e4700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CPU: 0 PID: 16722 Comm: syz-executor.2 Tainted: G      D            
5.0.0-rc7+ #96
CR2: 00000000004db9c0 CR3: 00000000908bb000 CR4: 00000000001406e0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold+0xa/0x1b lib/fault-inject.c:149
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  __should_failslab+0x121/0x190 mm/failslab.c:32
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  should_failslab+0x9/0x14 mm/slab_common.c:1604
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc_node mm/slab.c:3295 [inline]
  kmem_cache_alloc_node+0x56/0x710 mm/slab.c:3637


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
