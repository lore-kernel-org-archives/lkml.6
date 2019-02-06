Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA69C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88086218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfBFVDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:03:05 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:51552 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfBFVDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:03:05 -0500
Received: by mail-it1-f199.google.com with SMTP id 2so7030209itf.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 13:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YN9nijCwmIJVqmmxQRIU4F87Jix5RHTuSniqHUtT7rQ=;
        b=Kjmm5RvfxJVWtYfmEF9enF6+xl5MWGF/WlurC/S4n5gDOy3dGC7NioKCcQvx0jFqPU
         v9+ZV5uMsy+dHbYeDcoV5DYC9ktZHHNOFh2zZXeQ3D+CkR1DW+zdhg6ez3csBq3tQSyQ
         uwrHi16cNZsPHEpWV8hCv+90yzbzNjuuMHY4l/DKDkG/IR0p7QctcH7/jeWZj2YU1fGz
         2Wz5PzdWgra2ee3QZq0fJs2D+0AQP2C2ppZPt9+44QM42zamseELZuFBlVSWViB47sNA
         RzikvD9DnfgrMrEaaCL+RFM3IhV7PmfbB6wZHJxnqOa2eqYwoOS3CDasCM88ohH/Xc0+
         lYdQ==
X-Gm-Message-State: AHQUAuaKjiSClV7tf5Atl92Np0mjRW60przBNKcq+f369TvsP46MDSQm
        04e8bcsGmdBFzH+7XPrjCmj8rBsHgGC1T93WF6UlEiHFf45r
X-Google-Smtp-Source: AHgI3IZd1CRAnfGM9cbAjhCAOFbtUoPoAMqoj5kyvKDb2fmNacPOPIvP7mfFirq9X3VM8V2bi8njJbNrSNphhxMM+q8TL9EnvaW6
MIME-Version: 1.0
X-Received: by 2002:a24:fe42:: with SMTP id w63mr3934559ith.13.1549486983883;
 Wed, 06 Feb 2019 13:03:03 -0800 (PST)
Date:   Wed, 06 Feb 2019 13:03:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004234f60581400dac@google.com>
Subject: general protection fault in team_nl_cmd_options_set
From:   syzbot <syzbot+68ee510075cf64260cc4@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jiri@resnulli.us,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9097a058d49e Merge branch 'i2c/for-current' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11995667400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=861a3573f4e78ba1
dashboard link: https://syzkaller.appspot.com/bug?extid=68ee510075cf64260cc4
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1263c10d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130855b7400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+68ee510075cf64260cc4@syzkaller.appspotmail.com

netlink: 'syz-executor043': attribute type 3 has an invalid length.
netlink: 'syz-executor043': attribute type 3 has an invalid length.
team0: Mode changed to "activebackup"
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6431 Comm: syz-executor043 Not tainted 4.20.0-rc7+ #161
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__team_option_inst_tmp_find drivers/net/team/team.c:264 [inline]
RIP: 0010:team_nl_cmd_options_set+0xa2d/0x1370 drivers/net/team/team.c:2591
Code: 8b 74 24 38 75 13 e9 eb 05 00 00 e8 4d 27 e0 fc 49 39 dc 0f 84 dd 05  
00 00 e8 3f 27 e0 fc 49 8d 7c 24 10 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00  
0f 85 af 06 00 00 49 8b 44 24 10 4c 8d 60 f0 49 39
RSP: 0018:ffff8881af967270 EFLAGS: 00010203
RAX: 000000060dac2cae RBX: ffff8881d189dc00 RCX: ffffffff849f5cb7
RDX: 0000000000000000 RSI: ffffffff849f5d31 RDI: 000000306d616574
RBP: ffff8881af9674d0 R08: ffff8881cc646080 R09: ffffed103b5e5020
R10: ffffed103b5e5020 R11: ffff8881daf28107 R12: 000000306d616564
R13: ffff8881d189de10 R14: ffff8881af967360 R15: dffffc0000000000
FS:  00007fad37cf4700(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004d1810 CR3: 00000001b96af000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
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
RIP: 0033:0x44de49
Code: e8 1c ba 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb c5 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fad37cf3d88 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000006e0c5c RCX: 000000000044de49
RDX: 0000000000000000 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 00000000006e0c50 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000006c61767265
R13: 746e695f6e696f6a R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace da19b5a20e6fec24 ]---
RIP: 0010:__team_option_inst_tmp_find drivers/net/team/team.c:264 [inline]
RIP: 0010:team_nl_cmd_options_set+0xa2d/0x1370 drivers/net/team/team.c:2591
Code: 8b 74 24 38 75 13 e9 eb 05 00 00 e8 4d 27 e0 fc 49 39 dc 0f 84 dd 05  
00 00 e8 3f 27 e0 fc 49 8d 7c 24 10 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00  
0f 85 af 06 00 00 49 8b 44 24 10 4c 8d 60 f0 49 39
RSP: 0018:ffff8881af967270 EFLAGS: 00010203
RAX: 000000060dac2cae RBX: ffff8881d189dc00 RCX: ffffffff849f5cb7
RDX: 0000000000000000 RSI: ffffffff849f5d31 RDI: 000000306d616574
RBP: ffff8881af9674d0 R08: ffff8881cc646080 R09: ffffed103b5e5020
R10: ffffed103b5e5020 R11: ffff8881daf28107 R12: 000000306d616564
R13: ffff8881d189de10 R14: ffff8881af967360 R15: dffffc0000000000
FS:  00007fad37cf4700(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004d1810 CR3: 00000001b96af000 CR4: 00000000001406e0
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
