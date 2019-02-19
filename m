Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFD9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F6421736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfBSV4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:56:06 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:59861 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbfBSV4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:56:04 -0500
Received: by mail-it1-f198.google.com with SMTP id m136so6898172ita.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 13:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=viAcLXHSBmLq4xQzXFo1epsYCvHpormamdxnUWdMPy4=;
        b=MnowypEN0dTpnZRaWlm57uX/U59NbWJh1qN8nSSOjPDtJx77znbJncflIEFDEL0M5B
         KODLwdkv3SMsI6/QFhyMHrvCDGLvvuhIWCUDZGQ0YmMaXc5f0w4KwLJdHZfp+InxC1LD
         uXhMIkUwgOPjBaxIoGf5Z6ceX2HggC+oEZFzVtcP+Oz/L4h1smPBIATWWA2TSdIgztLm
         vgUbtv9iBeBjTM94FFOpvffYyD4mYsC+tGgPQBbOJXy1lmMyRPB2BVOWCZPP83AFEMnh
         hh2jbBowDsGy2un2s5Cfdbu/kChkj9i1xMkBH5TRhC3RlibQZgAbuBZwhCE9WhaYEqIu
         mXFw==
X-Gm-Message-State: AHQUAubTcX0334Dj6Qi0AIUHbN6T1ZhPz9NAQZwKVSZ4WAEDaSHSj7Tb
        sUSX+KbScZP7COdWMLKpx0JuSaek+o7BRljHA+f8wPW4iJzk
X-Google-Smtp-Source: AHgI3IYoNc8uYDDPlqmAa7dXYK2En0ZU9ORnDRNJHCISYpNdA5/Q26VfpJGpR6ZQcDfyTYZAseI/T/SMNX2H2aSjU7YDTQAlPGhH
MIME-Version: 1.0
X-Received: by 2002:a6b:f105:: with SMTP id e5mr5617014iog.7.1550613363598;
 Tue, 19 Feb 2019 13:56:03 -0800 (PST)
Date:   Tue, 19 Feb 2019 13:56:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8b0d70582464e52@google.com>
Subject: general protection fault in ip6erspan_set_version
From:   syzbot <syzbot+30191cf1057abd3064af@syzkaller.appspotmail.com>
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

HEAD commit:    cb916fc5eabf Add linux-next specific files for 20190218
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15111104c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ef0fb4978ed6ac0
dashboard link: https://syzkaller.appspot.com/bug?extid=30191cf1057abd3064af
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1198a582c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142f37bcc00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+30191cf1057abd3064af@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7549 Comm: syz-executor432 Not tainted 5.0.0-rc6-next-20190218  
#37
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:ip6erspan_set_version+0x5c/0x350 net/ipv6/ip6_gre.c:1726
Code: 07 38 d0 7f 08 84 c0 0f 85 9f 02 00 00 49 8d bc 24 b0 00 00 00 c6 43  
54 01 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 9a 02 00 00 4d 8b ac 24 b0 00 00 00 4d 85 ed 0f
RSP: 0018:ffff888089ed7168 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8880869d6e58 RCX: 0000000000000000
RDX: 0000000000000016 RSI: ffffffff862736b4 RDI: 00000000000000b0
RBP: ffff888089ed7180 R08: 1ffff11010d3adcb R09: ffff8880869d6e58
R10: ffffed1010d3add5 R11: ffff8880869d6eaf R12: 0000000000000000
R13: ffffffff8931f8c0 R14: ffffffff862825d0 R15: ffff8880869d6e58
FS:  0000000000b3d880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000184 CR3: 0000000092cc5000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ip6erspan_newlink+0x66/0x7b0 net/ipv6/ip6_gre.c:2210
  __rtnl_newlink+0x107b/0x16c0 net/core/rtnetlink.c:3176
  rtnl_newlink+0x69/0xa0 net/core/rtnetlink.c:3234
  rtnetlink_rcv_msg+0x465/0xb00 net/core/rtnetlink.c:5192
  netlink_rcv_skb+0x17a/0x460 net/netlink/af_netlink.c:2485
  rtnetlink_rcv+0x1d/0x30 net/core/rtnetlink.c:5210
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x536/0x720 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0x8ae/0xd70 net/netlink/af_netlink.c:1925
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:631
  ___sys_sendmsg+0x806/0x930 net/socket.c:2136
  __sys_sendmsg+0x105/0x1d0 net/socket.c:2174
  __do_sys_sendmsg net/socket.c:2183 [inline]
  __se_sys_sendmsg net/socket.c:2181 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2181
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440159
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffa69156e8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440159
RDX: 0000000000000000 RSI: 0000000020001340 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000001 R09: 00000000004002c8
R10: 0000000000000011 R11: 0000000000000246 R12: 00000000004019e0
R13: 0000000000401a70 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 09f8a7d13b4faaa1 ]---
RIP: 0010:ip6erspan_set_version+0x5c/0x350 net/ipv6/ip6_gre.c:1726
Code: 07 38 d0 7f 08 84 c0 0f 85 9f 02 00 00 49 8d bc 24 b0 00 00 00 c6 43  
54 01 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 9a 02 00 00 4d 8b ac 24 b0 00 00 00 4d 85 ed 0f
RSP: 0018:ffff888089ed7168 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8880869d6e58 RCX: 0000000000000000
RDX: 0000000000000016 RSI: ffffffff862736b4 RDI: 00000000000000b0
RBP: ffff888089ed7180 R08: 1ffff11010d3adcb R09: ffff8880869d6e58
R10: ffffed1010d3add5 R11: ffff8880869d6eaf R12: 0000000000000000
R13: ffffffff8931f8c0 R14: ffffffff862825d0 R15: ffff8880869d6e58
FS:  0000000000b3d880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000184 CR3: 0000000092cc5000 CR4: 00000000001406e0
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
