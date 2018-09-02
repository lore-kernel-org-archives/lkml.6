Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A434C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 05:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8C120843
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 05:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8C120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbeIBJZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 05:25:33 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:41899 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeIBJZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 05:25:33 -0400
Received: by mail-io0-f200.google.com with SMTP id q24-v6so14566594iog.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 22:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9s2GRo7azzuMd+5z0TlDn3vpuQ4Bi4YG1zpCTKcWkXQ=;
        b=myljVdpnYJSw+z8z0DC45/I0QDZCk9NlgyxqtvydvTcAVJ21qQdkYZI1Hzl161tnPO
         C8iM05xzRbpjyoWIFxUgT2r61mH5xx7uuEMsrysi8t9wIgjW9ulXH/YgbK7tnVHltSCq
         DbtTy23f5wiXUm26QWHoFPOvvBv2Tqv2ND0ZNapHKjjValRHbWqRlcnkuv9WnhrbFBPC
         Zn7KqujVqT/FjL4ghgWzAp2dea2LfimuWbYPrdw/Pz0tAywmJgvF7Tfte6+Eu8APY6R6
         rPVdzfFTfYv86cjSpGkSyyG/d1a3tAgcpe/ocTQNngqNHFwmg20m/UQdUuTrsb5Ob+RS
         724g==
X-Gm-Message-State: APzg51BVFcMpwuQXu/7+4Q48bU7z0nuTqyDYtGAw52i5pjML4rbQDN23
        h6NzHO+azTf7Pl7OFEkkjEyLpz+V1woFZm8uofifJ29ag/Q0
X-Google-Smtp-Source: ANB0VdZHcu0xIEAj4ayL4SmDd2ShbDOEjMXUWwcD6+daSg6TZhmNyypCjs2L+1aOUMhxEgHOrrVXmOBL/phOAwUQ+8rHjUno8+Iw
MIME-Version: 1.0
X-Received: by 2002:a24:9181:: with SMTP id i123-v6mr1624827ite.27.1535865063685;
 Sat, 01 Sep 2018 22:11:03 -0700 (PDT)
Date:   Sat, 01 Sep 2018 22:11:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b479f0574dc7328@google.com>
Subject: general protection fault in rhashtable_walk_start_check
From:   syzbot <syzbot+e93a2c41f91b8e2c7d9b@syzkaller.appspotmail.com>
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

HEAD commit:    f611a5b4a51f ibmvnic: Include missing return code checks i..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=15ecaa46400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
dashboard link: https://syzkaller.appspot.com/bug?extid=e93a2c41f91b8e2c7d9b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cb3cb2400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d56e3e400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e93a2c41f91b8e2c7d9b@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 4663 Comm: syz-executor272 Not tainted 4.19.0-rc1+ #78
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:rhashtable_walk_start_check+0xd3/0x1400 lib/rhashtable.c:717
Code: f2 c7 40 30 f2 f2 f2 f2 c7 40 34 00 f2 f2 f2 65 48 8b 04 25 28 00 00  
00 48 89 45 d0 31 c0 e8 94 9e 0b fe 4c 89 e8 48 c1 e8 03 <80> 3c 18 00 0f  
85 a4 0f 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b
RSP: 0018:ffff8801ba726ee8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff852abf68
RDX: 0000000000000000 RSI: ffffffff837121ec RDI: 0000000000000000
RBP: ffff8801ba727130 R08: ffff8801ba750780 R09: ffffed00374fcf3c
R10: ffffed00374fcf3c R11: ffff8801ba7e79e3 R12: 0000000000000000
R13: 0000000000000000 R14: ffff8801ba727270 R15: fffffffffffff000
FS:  0000000001b0b880(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000100 CR3: 00000001bbf40000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  rhashtable_walk_start include/linux/rhashtable.h:244 [inline]
  tipc_nl_sk_walk+0x52/0x1d0 net/tipc/socket.c:3236
  tipc_nl_sk_dump+0x24/0x30 net/tipc/socket.c:3366
  __tipc_nl_compat_dumpit.isra.11+0x20b/0xad0 net/tipc/netlink_compat.c:192
  tipc_nl_compat_dumpit+0x1f4/0x440 net/tipc/netlink_compat.c:265
  tipc_nl_compat_handle net/tipc/netlink_compat.c:1142 [inline]
  tipc_nl_compat_recv+0x12b3/0x19a0 net/tipc/netlink_compat.c:1205
  genl_family_rcv_msg+0x8a3/0x1140 net/netlink/genetlink.c:601
  genl_rcv_msg+0xc6/0x168 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2454
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
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
RIP: 0033:0x4400e9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe84ec3538 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004400e9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000213 R12: 0000000000401970
R13: 0000000000401a00 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace c8a9aaea5d0de646 ]---
RIP: 0010:rhashtable_walk_start_check+0xd3/0x1400 lib/rhashtable.c:717
Code: f2 c7 40 30 f2 f2 f2 f2 c7 40 34 00 f2 f2 f2 65 48 8b 04 25 28 00 00  
00 48 89 45 d0 31 c0 e8 94 9e 0b fe 4c 89 e8 48 c1 e8 03 <80> 3c 18 00 0f  
85 a4 0f 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b
RSP: 0018:ffff8801ba726ee8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff852abf68
RDX: 0000000000000000 RSI: ffffffff837121ec RDI: 0000000000000000
RBP: ffff8801ba727130 R08: ffff8801ba750780 R09: ffffed00374fcf3c
R10: ffffed00374fcf3c R11: ffff8801ba7e79e3 R12: 0000000000000000
R13: 0000000000000000 R14: ffff8801ba727270 R15: fffffffffffff000
FS:  0000000001b0b880(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000100 CR3: 00000001bbf40000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
