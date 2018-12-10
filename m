Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1388C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922612082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922612082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbeLJTNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:13:05 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:41656 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbeLJTNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:13:05 -0500
Received: by mail-it1-f199.google.com with SMTP id 123so15566851itv.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 11:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LG8m6wYobrm+9UyQQdTNUgNYcVP2XzPhY8tsFChrOng=;
        b=YJN0fUHYB1HtwZzkil5s2K7XHjcVbqAs2bpgMHu1l2XhbLCdgv5ycLbSE7P9LJ0Tm1
         F0OnbwEjtEzik5TpkxIP7DU9S/xpJhop0jKJSp0TARSMPGgJkriuhSS0rSu3V2YJOW5W
         upX9D4Vg3zFzskZN6rs5RxGxc1F72Iy8sJsOkB8BVAnhEeXAmUz7o5GLU4Oc8vyy5V4e
         zETlnK/PTprbw7pz4Ub/VH/LMINFOZi2stzCeWdenlTeBPDgWRYZLA6tfmiMpFXDVPhq
         HidX+GU4xsnJA62CWwVJipujTBDlHgbDoiV1kprWDD+214L9cIj08GU987gPJ6lD7tJw
         u6HQ==
X-Gm-Message-State: AA+aEWbGVWzY3/ZmAc3sWW0VAmfNecKeQaI88j8HjZKQ5c+VU2O4+r2Y
        lbx3yO0cwEZTErmHlx4GHdaSlNCtwE7UmoAtTm6H20V34rVP
X-Google-Smtp-Source: AFSGD/Vegy6KDdwU6PBMuX9+e+Gt//wuyLbwzfSm88lVv6RTO13Io09cJXyWlyrZDMq7uJfoguoCc6hQgvn/Ol3gmNfMtMARODqF
MIME-Version: 1.0
X-Received: by 2002:a6b:6f09:: with SMTP id k9mr10262024ioc.35.1544469183875;
 Mon, 10 Dec 2018 11:13:03 -0800 (PST)
Date:   Mon, 10 Dec 2018 11:13:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001253f4057cafc18f@google.com>
Subject: general protection fault in __ipv6_sock_mc_join
From:   syzbot <syzbot+eb4da3a20fad2e52555d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    4cc1feeb6ffc Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16d99125400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9655b05acfc97ff
dashboard link: https://syzkaller.appspot.com/bug?extid=eb4da3a20fad2e52555d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+eb4da3a20fad2e52555d@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 11884 Comm: syz-executor4 Not tainted 4.20.0-rc6+ #336
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:182 [inline]
RIP: 0010:__ipv6_sock_mc_join+0x24a/0xc10 net/ipv6/mcast.c:152
Code: 00 00 e8 59 05 99 fa 48 8b 85 d0 fe ff ff 48 83 c0 60 48 89 c2 48 89  
85 c0 fe ff ff 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 32 09 00 00 48 8b 85 d0 fe ff ff 4c 8d ad 10 ff
RSP: 0018:ffff88818221ebc8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffc9000de56000
RDX: 000000000000000c RSI: ffffffff86e67f07 RDI: 0000000000000001
RBP: ffff88818221ed18 R08: ffff8881837b8440 R09: ffffed103b5e5b5f
R10: ffffed103b5e5b5f R11: ffff8881daf2dafb R12: 0000000000000001
R13: ffff88818221efb4 R14: ffff88818221efb4 R15: ffff8881972c73c0
------------[ cut here ]------------
FS:  00007f1d3069b700(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
downgrading a read lock
WARNING: CPU: 0 PID: 11893 at kernel/locking/lockdep.c:3556  
__lock_downgrade kernel/locking/lockdep.c:3556 [inline]
WARNING: CPU: 0 PID: 11893 at kernel/locking/lockdep.c:3556  
lock_downgrade+0x4d7/0x900 kernel/locking/lockdep.c:3819
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Kernel panic - not syncing: panic_on_warn set ...
CR2: 00007fe9a81c4d88 CR3: 00000001b5974000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ipv6_sock_mc_join+0x27/0x30 net/ipv6/mcast.c:208
  enable_mcast net/tipc/udp_media.c:395 [inline]
  tipc_udp_enable+0x147b/0x1ee0 net/tipc/udp_media.c:757
  tipc_enable_bearer+0x9a6/0xf10 net/tipc/bearer.c:302
  __tipc_nl_bearer_enable+0x37c/0x4a0 net/tipc/bearer.c:897
  tipc_nl_bearer_enable+0x22/0x30 net/tipc/bearer.c:905
  genl_family_rcv_msg+0x8a7/0x11a0 net/netlink/genetlink.c:601
  genl_rcv_msg+0xc6/0x168 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2477
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1336
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
RIP: 0033:0x457659
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1d3069ac78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457659
RDX: 0000000000004000 RSI: 0000000020000240 RDI: 0000000000000003
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1d3069b6d4
R13: 00000000004c421b R14: 00000000004d7160 R15: 00000000ffffffff
Modules linked in:
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
