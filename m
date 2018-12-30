Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FF6C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 04:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A00320866
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 04:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeL3EBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 23:01:05 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:47943 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeL3EBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 23:01:04 -0500
Received: by mail-io1-f72.google.com with SMTP id s25so29044605ioc.14
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 20:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4s/WsS1QRZIpT84D8cLQOnlbHBMN10VvcrX5O0a3wcs=;
        b=aY+/TQ1mCVv3/RiEXK8NvKv9oovtNU9cBkEl+WikumOkJOIXYF/hvt757vO9cbwROV
         Djj44LeS+3ei+xSmmy9XkbX+UUayCz8V8oiQhTpRLt71cepzAfz/eZQpLYfy29W4zBC8
         LW/YWTRcdAQ4x4dyfDrVrwyhLjxWnT8vLVTG5gluYIcQ5L0Z7qNJhn9OJLvPVDIAdtKR
         p7/GQMFEFbPBVxnkNGtjbEBTNIrFuL5EC4BUUr1OjX2fsaCgRLsoKhsWdqFIYsfSrhSr
         AalM4EkKw28AAb7Vj7/RoV0PQcB2q8+Vt8oJXvj7C5XecnYZ+aXtJXUkhvogDePLBcHy
         vx2Q==
X-Gm-Message-State: AA+aEWYDJqZnshyH2MM3hTvdLsfGSvhXPWQEUkaGYXqWjYJ2si7GDiki
        ELPA3JT/YxmvNSoqdvWhARMrtN6kHHOG/iKvaf6G1r7AxrAO
X-Google-Smtp-Source: ALg8bN7Ida8OsYutxPKk0k58KtO+WApeuFz3aSLsjH83gsvS69u5DUDx9bx7Z4IoLHb6rJz/5OZTwAvjLZEsOptXGRmdTXHcxWbs
MIME-Version: 1.0
X-Received: by 2002:a24:248d:: with SMTP id f135mr25513965ita.36.1546142463458;
 Sat, 29 Dec 2018 20:01:03 -0800 (PST)
Date:   Sat, 29 Dec 2018 20:01:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e8a91057e355803@google.com>
Subject: general protection fault in fdb_find_rcu
From:   syzbot <syzbot+017b1f61c82a1c3e7efd@syzkaller.appspotmail.com>
To:     bridge@lists.linux-foundation.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    90cadbbf341d Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1745c69b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d41c8529d7e7362
dashboard link: https://syzkaller.appspot.com/bug?extid=017b1f61c82a1c3e7efd
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15babaab400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c6142d400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+017b1f61c82a1c3e7efd@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7824 Comm: syz-executor809 Not tainted 4.20.0-rc7+ #360
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:fdb_find_rcu+0x194/0xc90 include/linux/string.h:352
Code: 40 84 c6 0f 85 23 09 00 00 84 c9 0f 95 c2 0f 9e c0 84 c2 0f 85 13 09  
00 00 48 b9 00 00 00 00 00 fc ff df 4c 89 e0 48 c1 e8 03 <0f> b6 14 08 49  
8d 44 24 05 48 89 c6 48 c1 ee 03 0f b6 0c 0e 4c 89
RSP: 0018:ffff8881b932f0b8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 1ffff11037265e01 RDI: ffff8881b932f1a8
RBP: ffff8881b932f310 R08: ffff8881bcc84400 R09: ffffed103b5a5b77
R10: ffffed103b5a5b77 R11: ffff8881dad2dbbb R12: 0000000000000000
R13: 0000000000000001 R14: ffff8881b9e68f40 R15: ffff8881b932f2e8
FS:  0000000001e8e880(0000) GS:ffff8881dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000180 CR3: 00000001bec05000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  br_fdb_find_rcu net/bridge/br_fdb.c:152 [inline]
  br_fdb_get+0xac/0x230 net/bridge/br_fdb.c:788
  rtnl_fdb_get+0x8a0/0x13b0 net/core/rtnetlink.c:4166
  rtnetlink_rcv_msg+0x46a/0xc20 net/core/rtnetlink.c:5125
  netlink_rcv_skb+0x16c/0x430 net/netlink/af_netlink.c:2477
  rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:5143
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x59f/0x750 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441679
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff99382768 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000441679
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 00000000006cd018 R08: 0000000000000100 R09: 0000000000000100
R10: 0000000000000020 R11: 0000000000000213 R12: 0000000000402430
R13: 00000000004024c0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace d6d5286333ca98b5 ]---
RIP: 0010:fdb_find_rcu+0x194/0xc90 include/linux/string.h:352
Code: 40 84 c6 0f 85 23 09 00 00 84 c9 0f 95 c2 0f 9e c0 84 c2 0f 85 13 09  
00 00 48 b9 00 00 00 00 00 fc ff df 4c 89 e0 48 c1 e8 03 <0f> b6 14 08 49  
8d 44 24 05 48 89 c6 48 c1 ee 03 0f b6 0c 0e 4c 89
RSP: 0018:ffff8881b932f0b8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 1ffff11037265e01 RDI: ffff8881b932f1a8
RBP: ffff8881b932f310 R08: ffff8881bcc84400 R09: ffffed103b5a5b77
R10: ffffed103b5a5b77 R11: ffff8881dad2dbbb R12: 0000000000000000
R13: 0000000000000001 R14: ffff8881b9e68f40 R15: ffff8881b932f2e8
FS:  0000000001e8e880(0000) GS:ffff8881dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000180 CR3: 00000001bec05000 CR4: 00000000001406e0
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
