Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA7AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D16E20989
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfAGJzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:55:23 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:51505 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfAGJzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:55:05 -0500
Received: by mail-it1-f200.google.com with SMTP id b14so153936itd.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 01:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/4NND+9e2DdwkU+1GUoc+oMN26O4LTh6Z3d6SFejUCk=;
        b=KyPvkpZRkgCHHZHHkN4Tnuqzy0r/HPiND2sNkkFV+sM30093WVu/rDC3hmByUa5jYj
         Fzyg3DYA+Otm+xj227o5x3MOZ3eSuA/SF/4i0ojZD85MtGs0kf09J7rCSMQ21LOClKb7
         cwCi75iIbU8FkjQ0HO8aDrm796nW3S+xUOKLVyULknPoIQdsmgucJ+wOt5gH1xedkrT7
         /ZXeMQz4EUx2v9Ln83DVXzb64yG17q4aLphP+75+KUymFuTImt6/+f5EGl37+J0ow+oH
         hzqs+a/mjAYY1DXhIwXaopzym5R+xJJarqHDH2J15R1ZVJD4VXTsk2XdMkF4TETHH8n8
         LkdA==
X-Gm-Message-State: AA+aEWYcW/zN85oyRF0LaHIetw8egEtydKmGFcf9cWMzjK6gS9U74gUI
        4g1zJXOZxAMwdxaJFi2CKUdAHYDgandEXkFPsd/ah5043O6v
X-Google-Smtp-Source: AFSGD/WP2obqCjfsIbcdDK0h4UuEBvKToHhSYFUGrRIWMNFd45EyeR2hddHuK+vp+xd5Si0amIrgp9dFK4TFJxgrarjy6PltfJNF
MIME-Version: 1.0
X-Received: by 2002:a02:4f03:: with SMTP id c3mr48035362jab.13.1546854904465;
 Mon, 07 Jan 2019 01:55:04 -0800 (PST)
Date:   Mon, 07 Jan 2019 01:55:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001990a6057edb3931@google.com>
Subject: BUG: unable to handle kernel paging request in dst_dev_put
From:   syzbot <syzbot+a43d8d4e7e8a7a9e149e@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b71acb0e3721 Merge branch 'linus' of git://git.kernel.org/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=132246e3400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b03c5892bb940c76
dashboard link: https://syzkaller.appspot.com/bug?extid=a43d8d4e7e8a7a9e149e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a43d8d4e7e8a7a9e149e@syzkaller.appspotmail.com

netlink: 'syz-executor2': attribute type 3 has an invalid length.
BUG: unable to handle kernel paging request at ffffed1bc3404006
#PF error: [normal kernel read fault]
PGD 21fff0067 P4D 21fff0067 PUD 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8160 Comm: syz-executor3 Not tainted 4.20.0+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:dst_dev_put+0xa0/0x290 net/core/dst.c:171
Code: fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 e4 01 00 00 48 b8 00 00 00 00  
00 fc ff df 4c 8b 6b 08 49 8d 7d 38 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 b7 01 00 00 4d 8b 75 38 4d 89 e5 4d 85 f6 74 33
RSP: 0018:ffff88808dc47520 EFLAGS: 00010a07
RAX: dffffc0000000000 RBX: ffff8880a4b36806 RCX: ffffc9000c042000
RDX: 1ffff11bc3404006 RSI: ffffffff8625e0d3 RDI: ffff88de1a020037
RBP: ffff88808dc47540 R08: 1ffffd1ffff8e344 R09: fffff91ffff8e345
R10: fffff91ffff8e344 R11: ffffe8ffffc71a27 R12: ffff8a391080ffff
R13: ffff88de1a01ffff R14: 1ffff11011b88eb5 R15: ffff88808dc475f8
FS:  00007f83b5508700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed1bc3404006 CR3: 0000000065801000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  rt_cache_route+0x377/0x460 net/ipv4/route.c:1438
  rt_set_nexthop.constprop.0+0x420/0x1400 net/ipv4/route.c:1538
  __mkroute_output net/ipv4/route.c:2293 [inline]
  ip_route_output_key_hash_rcu+0xb07/0x3470 net/ipv4/route.c:2492
  ip_route_output_key_hash+0x25d/0x400 net/ipv4/route.c:2321
  __ip_route_output_key include/net/route.h:124 [inline]
  ip_route_output_flow+0x28/0xc0 net/ipv4/route.c:2576
  ip_route_connect include/net/route.h:309 [inline]
  tcp_v4_connect+0x8a3/0x1da0 net/ipv4/tcp_ipv4.c:233
  __inet_stream_connect+0x9a3/0x11b0 net/ipv4/af_inet.c:655
  inet_stream_connect+0x58/0xa0 net/ipv4/af_inet.c:719
  __sys_connect+0x357/0x490 net/socket.c:1664
  __do_sys_connect net/socket.c:1675 [inline]
  __se_sys_connect net/socket.c:1672 [inline]
  __x64_sys_connect+0x73/0xb0 net/socket.c:1672
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f83b5507c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 0000000000000010 RSI: 0000000020ccb000 RDI: 0000000000000006
RBP: 000000000073bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f83b55086d4
R13: 00000000004be30a R14: 00000000004ce6d8 R15: 00000000ffffffff
Modules linked in:
CR2: ffffed1bc3404006
---[ end trace 88a037c783301af1 ]---
RIP: 0010:dst_dev_put+0xa0/0x290 net/core/dst.c:171
Code: fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 e4 01 00 00 48 b8 00 00 00 00  
00 fc ff df 4c 8b 6b 08 49 8d 7d 38 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 b7 01 00 00 4d 8b 75 38 4d 89 e5 4d 85 f6 74 33
RSP: 0018:ffff88808dc47520 EFLAGS: 00010a07
RAX: dffffc0000000000 RBX: ffff8880a4b36806 RCX: ffffc9000c042000
RDX: 1ffff11bc3404006 RSI: ffffffff8625e0d3 RDI: ffff88de1a020037
RBP: ffff88808dc47540 R08: 1ffffd1ffff8e344 R09: fffff91ffff8e345
R10: fffff91ffff8e344 R11: ffffe8ffffc71a27 R12: ffff8a391080ffff
R13: ffff88de1a01ffff R14: 1ffff11011b88eb5 R15: ffff88808dc475f8
FS:  00007f83b5508700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed1bc3404006 CR3: 0000000065801000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kobject: 'loop5' (000000006c9bdf3e): kobject_uevent_env
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
