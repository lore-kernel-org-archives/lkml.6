Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAF8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36442206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbeLQHOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 02:14:04 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:43405 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbeLQHOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 02:14:04 -0500
Received: by mail-it1-f200.google.com with SMTP id 128so13779161itw.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 23:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=rXMAPPEeU4vORkKr7jTQCMnehDc5YYYw8nB06I4FNFg=;
        b=KbOhsr//IPDshSCFrBQ2A379Mvhv0VdYJxlFCKAwRTEc11TlLzOYaMz5st6gIpKhLZ
         j48UHUiKSocTZTtyPhb/cStEQpyvEUg5B/nEKs30t8XFuJSeS9iwLj5umiLn8eES2vj0
         o9CK07Ofr6Yo9ImN/vD7BaDx+2/YZ7Lj9s2onP6nSrWDHE4DoWhJX19MMKfJogAO8GnD
         2SlcSyFm34kliPmqp+CLJLaCDYzZDaCXMTo86UsWWD1nlMye2hG5hc0jxSlmAuEVvIFh
         GbvFGY3HoFd2U5OEpt4LG+P76+ViIZg50kt7sPg9QRqi+daEbFiILp+CP7NOCIXWhJTJ
         2ODA==
X-Gm-Message-State: AA+aEWZTmZEB2rBh0A7Krn9mY38ivFRoQn3kiQfPc3TUmLIM9u7h+Wvz
        TXoUYz/VrMcFAXhgSxJ7xWCCHimXcYmX4xW+95tvJ3gbC4gl
X-Google-Smtp-Source: AFSGD/W1zGiqb+prqDQ35F/iWiO8iZEWMB3ddCa5jGa/PKdYVK5dCEqaihzEXcDASLpyNqF5BHdogCQ3yaiSjeywDBFvayB28IO7
MIME-Version: 1.0
X-Received: by 2002:a5d:9b87:: with SMTP id r7mr6562218iom.31.1545030843313;
 Sun, 16 Dec 2018 23:14:03 -0800 (PST)
Date:   Sun, 16 Dec 2018 23:14:03 -0800
In-Reply-To: <0000000000001568af057cb456a8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009539c1057d328625@google.com>
Subject: Re: KMSAN: uninit-value in __inet6_bind
From:   syzbot <syzbot+c56449ed3652e6720f30@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dvyukov@google.com, eric.dumazet@gmail.com,
        jon.maloy@ericsson.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, xiyou.wangcong@gmail.com,
        ying.xue@windriver.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    0a602458c72c kmsan: random: another take at unpoisoning CR..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=129e1035400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9b071100dcf8e641
dashboard link: https://syzkaller.appspot.com/bug?extid=c56449ed3652e6720f30
compiler:       clang version 8.0.0 (trunk 348261)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a97b2b400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108ec72b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c56449ed3652e6720f30@syzkaller.appspotmail.com

audit: type=1800 audit(1545030606.944:30): pid=6407 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=collect_data cause=failed(directio)  
comm="startpar" name="rmnologin" dev="sda1" ino=2423 res=0
Started in network mode
Own node identity fe8000000000000000000000000000bb, cluster identity 4711
==================================================================
BUG: KMSAN: uninit-value in __inet6_bind+0xb35/0x1a30  
net/ipv6/af_inet6.c:340
CPU: 1 PID: 6557 Comm: syz-executor447 Not tainted 4.20.0-rc5+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x220 lib/dump_stack.c:113
  kmsan_report+0x12d/0x290 mm/kmsan/kmsan.c:682
  __msan_warning+0x76/0xc0 mm/kmsan/kmsan_instr.c:316
  __inet6_bind+0xb35/0x1a30 net/ipv6/af_inet6.c:340
  inet6_bind+0x206/0x300 net/ipv6/af_inet6.c:441
  kernel_bind+0xc6/0xf0 net/socket.c:3230
  udp_sock_create6+0x2ee/0x890 net/ipv6/ip6_udp_tunnel.c:39
  udp_sock_create include/net/udp_tunnel.h:61 [inline]
  tipc_udp_enable+0x166f/0x1d70 net/tipc/udp_media.c:742
  tipc_enable_bearer net/tipc/bearer.c:302 [inline]
  __tipc_nl_bearer_enable+0x1213/0x1da0 net/tipc/bearer.c:897
  tipc_nl_bearer_enable+0x6c/0xb0 net/tipc/bearer.c:905
  genl_family_rcv_msg net/netlink/genetlink.c:601 [inline]
  genl_rcv_msg+0x185f/0x1a60 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x444/0x640 net/netlink/af_netlink.c:2477
  genl_rcv+0x63/0x80 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0xf80/0x1060 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0x129d/0x1310 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  ___sys_sendmsg+0xdbc/0x11d0 net/socket.c:2116
  __sys_sendmsg net/socket.c:2154 [inline]
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg+0x305/0x460 net/socket.c:2161
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2161
  do_syscall_64+0xcd/0x110 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x444199
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 1b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe96b1eb28 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000444199
RDX: 0000000000000000 RSI: 00000000200008c0 RDI: 0000000000000003
RBP: 00000000006ce018 R08: 0000000000000000 R09: 00000000004002e0
R10: 0000000000000000 R11: 0000000000000213 R12: 0000000000401e40
R13: 0000000000401ed0 R14: 0000000000000000 R15: 0000000000000000

Local variable description: ----udp6_addr@udp_sock_create6
Variable was created at:
  udp_sock_create6+0x80/0x890 net/ipv6/ip6_udp_tunnel.c:17
  udp_sock_create include/net/udp_tunnel.h:61 [inline]
  tipc_udp_enable+0x166f/0x1d70 net/tipc/udp_media.c:742
==================================================================

