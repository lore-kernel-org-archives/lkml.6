Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF6EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0304C20881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfA2JWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:22:04 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:55424 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfA2JWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:22:03 -0500
Received: by mail-it1-f197.google.com with SMTP id j3so15047761itf.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 01:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=e6rbA9iHv6MLF+Ki0fFZFQoqLDpuF4dsdvX2YjynVW0=;
        b=rmi9F9STYnj0nU0xIoRZbnTzWZObSCJCIHwq6MC7n6VPHYcCeNsNJ+TYTMK4rGcfzj
         +21SEZpQryzTjYoVgqhYnVhmQl18oEG5Q7J6U7RKOI8j83IGzbOIvUuus4oZstRg4UDd
         lf0BA+eftMOk5HRwGHjcnxdV2SF5WCHiAkeOkSDxhY8k/y1BhCDLfVtKm7fJZtTn8+Lw
         Adm6gEDUvS5UUcFdowuzbo4Co6hjItgmZao3ozBziCkPMpe/Gj30e1EeyiGwNJGCVRsh
         KK46NrBzprCo6talVHUaZotF2lHrcAKZOf3blnEdznjzHS3wJ/6OIFj1uVMzj9AG/xCv
         4f0Q==
X-Gm-Message-State: AHQUAuaFJefNVcxWvwiZ96w4ql4RlNJGecy5ji74f2N8SXrGyrS5nCbu
        toV8wvnhFxoPjEGT1L/gW6PzeHpRU+2ge3VcjQTxbA76mW9k
X-Google-Smtp-Source: AHgI3IbU5PiHLB9waoCeCEVLyLbS3E2+gOz8gNqLsQqKec0GoqKd2BxNyNVbLJJya29fje4g7hrAs8uhscGobjRZaUO2Wf1/hURl
MIME-Version: 1.0
X-Received: by 2002:a24:7d55:: with SMTP id b82mr2320328itc.0.1548753722604;
 Tue, 29 Jan 2019 01:22:02 -0800 (PST)
Date:   Tue, 29 Jan 2019 01:22:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b129305809553da@google.com>
Subject: general protection fault in __xfrm_policy_bysel_ctx
From:   syzbot <syzbot+e6e1fe9148cffa18cf97@syzkaller.appspotmail.com>
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

HEAD commit:    085c4c7dd2b6 net: lmc: remove -I. header search path
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12347128c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=505743eba4e4f68
dashboard link: https://syzkaller.appspot.com/bug?extid=e6e1fe9148cffa18cf97
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e6e1fe9148cffa18cf97@syzkaller.appspotmail.com

netlink: 104 bytes leftover after parsing attributes in process  
`syz-executor0'.
device sit0 left promiscuous mode
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
netlink: 'syz-executor1': attribute type 2 has an invalid length.
CPU: 1 PID: 6717 Comm: syz-executor0 Not tainted 5.0.0-rc3+ #24
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__xfrm_policy_bysel_ctx.constprop.0+0xe4/0x470  
net/xfrm/xfrm_policy.c:1618
Code: 00 e8 50 40 c3 fa 49 83 ec 08 0f 84 df 02 00 00 e8 41 40 c3 fa 49 8d  
bc 24 19 02 00 00 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <42> 0f b6 04 38  
38 d0 7f 08 84 c0 0f 85 eb 02 00 00 45 0f b6 ac 24
kobject: 'loop4' (00000000b3bda7f3): kobject_uevent_env
RSP: 0018:ffff888065bff0e8 EFLAGS: 00010206
RAX: 0000005800000042 RBX: 0000000000000000 RCX: ffffc90005deb000
RDX: 0000000000000003 RSI: ffffffff86bebeaf RDI: 000002c000000213
RBP: ffff888065bff148 R08: ffff8880568ce080 R09: 0000000000000000
R10: ffff8880568ce080 R11: 0000000000000000 R12: 000002bffffffffa
R13: 00000000000000ff R14: ffff88806bae3290 R15: dffffc0000000000
kobject: 'loop4' (00000000b3bda7f3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
FS:  00007f39763ec700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000073c000 CR3: 0000000089628000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  xfrm_policy_bysel_ctx+0x944/0x1020 net/xfrm/xfrm_policy.c:1664
  xfrm_get_policy+0x67b/0x1160 net/xfrm/xfrm_user.c:1887
  xfrm_user_rcv_msg+0x458/0x8d0 net/xfrm/xfrm_user.c:2663
  netlink_rcv_skb+0x17d/0x410 net/netlink/af_netlink.c:2485
  xfrm_netlink_rcv+0x70/0x90 net/xfrm/xfrm_user.c:2671
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x574/0x770 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa05/0xf90 net/netlink/af_netlink.c:1925
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:631
  ___sys_sendmsg+0x7ec/0x910 net/socket.c:2116
  __sys_sendmsg+0x112/0x270 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458099
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f39763ebc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458099
RDX: 0000000000000000 RSI: 000000002014f000 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f39763ec6d4
R13: 00000000004c56af R14: 00000000004d9420 R15: 00000000ffffffff
Modules linked in:
---[ end trace 6bda763f27a7462f ]---
RIP: 0010:__xfrm_policy_bysel_ctx.constprop.0+0xe4/0x470  
net/xfrm/xfrm_policy.c:1618
Code: 00 e8 50 40 c3 fa 49 83 ec 08 0f 84 df 02 00 00 e8 41 40 c3 fa 49 8d  
bc 24 19 02 00 00 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <42> 0f b6 04 38  
38 d0 7f 08 84 c0 0f 85 eb 02 00 00 45 0f b6 ac 24
RSP: 0018:ffff888065bff0e8 EFLAGS: 00010206
RAX: 0000005800000042 RBX: 0000000000000000 RCX: ffffc90005deb000
RDX: 0000000000000003 RSI: ffffffff86bebeaf RDI: 000002c000000213
RBP: ffff888065bff148 R08: ffff8880568ce080 R09: 0000000000000000
R10: ffff8880568ce080 R11: 0000000000000000 R12: 000002bffffffffa
R13: 00000000000000ff R14: ffff88806bae3290 R15: dffffc0000000000
FS:  00007f39763ec700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000073c000 CR3: 0000000089628000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
