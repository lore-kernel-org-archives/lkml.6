Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FB2C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD522082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD522082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbeLJVmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:42:04 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:51345 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbeLJVmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:42:04 -0500
Received: by mail-it1-f199.google.com with SMTP id c73so193509itd.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 13:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=CPf1AZ4yzI1bb49+y5nTM37BE+jzEVSvUHYMDb+W8i8=;
        b=jS9EveQJNbvHu00RGPdW8P+g4oL/S/WUrxhlvbioJt5zVWm1eaMtnzXDyK2bEMNoeg
         MQlG0B4o+MIQGd8PpZKBZwPYrmRkONPbJtaCHQIpgbnQTFwKuqWTCbGi9hLSWCCcAw/+
         9jcwCt7tE8q/RYczzj4sMB2fjdg5fYcRhPFSg0fZjNOnSUqHGjQKRQ6hD8ADi0KFnyWK
         gJ5A3KuhvsiV0g82Oz90EIn7kUngTTTbfh4pnf7Vlfq37gH8oRbKXrPwATpdYVuAhxPl
         ktxEVY46g5YiRy6zCdDSd3n+GVndm3IGc2lY2CPUZsunsB9U07nzkv0iUv4/BeVoTCun
         Yjjg==
X-Gm-Message-State: AA+aEWbfSc/2Sn+ToC2l2eCYgxDN2pur6dbioVhfhoX9X4g/hHqX/pFY
        lhNFief9HcWlOkmz28jwI94hea/6m0/Yj3y3KHj+BgeOk2pz
X-Google-Smtp-Source: AFSGD/V6SNSmT8aDqm+UV6spn7gXcUOoot4UEv3qKEZysfR8eB6EC4TxcE7OJkgWDnrS0HDpVoGow6LgKYSNfGiUNKqBW11g2Iiy
MIME-Version: 1.0
X-Received: by 2002:a24:5e92:: with SMTP id h140mr53442itb.17.1544478123149;
 Mon, 10 Dec 2018 13:42:03 -0800 (PST)
Date:   Mon, 10 Dec 2018 13:42:03 -0800
In-Reply-To: <0000000000001253f4057cafc18f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e4d43e057cb1d550@google.com>
Subject: Re: general protection fault in __ipv6_sock_mc_join
From:   syzbot <syzbot+eb4da3a20fad2e52555d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    40e020c129cf Linux 4.20-rc6
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1296c56d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=eb4da3a20fad2e52555d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15817125400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129447eb400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+eb4da3a20fad2e52555d@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
Started in network mode
Own node identity ac14141a, cluster identity 4711
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6008 Comm: syz-executor946 Not tainted 4.20.0-rc6+ #223
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:182 [inline]
RIP: 0010:__ipv6_sock_mc_join+0x24a/0xc10 net/ipv6/mcast.c:152
Code: 00 00 e8 a9 31 9b fa 48 8b 85 d0 fe ff ff 48 83 c0 60 48 89 c2 48 89  
85 c0 fe ff ff 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 32 09 00 00 48 8b 85 d0 fe ff ff 4c 8d ad 10 ff
RSP: 0018:ffff8881cd7b6bc8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff86e459ac
RDX: 000000000000000c RSI: ffffffff86e452c7 RDI: 0000000000000001
RBP: ffff8881cd7b6d18 R08: ffff8881ccad8300 R09: ffffed103b5c5b5f
R10: ffffed103b5c5b5f R11: ffff8881dae2dafb R12: 000000000000000f
R13: ffff8881cd7b6fb4 R14: ffff8881cd7b6fb4 R15: ffff8881bb9c9540
FS:  0000000001a6e880(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 00000001c21ac000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ipv6_sock_mc_join+0x27/0x30 net/ipv6/mcast.c:208
  enable_mcast net/tipc/udp_media.c:395 [inline]
  tipc_udp_enable+0x1476/0x1ed0 net/tipc/udp_media.c:757
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
RIP: 0033:0x445d49
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb ce fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe64b73768 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000445d49
RDX: 000000000000c000 RSI: 0000000020000c00 RDI: 0000000000000003
RBP: 00000000006d1018 R08: 0000000000000000 R09: 0000000000000100
R10: 0000000000000000 R11: 0000000000000213 R12: 00000000004030d0
R13: 0000000000403160 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace c6ae3b4cfb2b9359 ]---
RIP: 0010:__read_once_size include/linux/compiler.h:182 [inline]
RIP: 0010:__ipv6_sock_mc_join+0x24a/0xc10 net/ipv6/mcast.c:152
Code: 00 00 e8 a9 31 9b fa 48 8b 85 d0 fe ff ff 48 83 c0 60 48 89 c2 48 89  
85 c0 fe ff ff 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 32 09 00 00 48 8b 85 d0 fe ff ff 4c 8d ad 10 ff
RSP: 0018:ffff8881cd7b6bc8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff86e459ac
RDX: 000000000000000c RSI: ffffffff86e452c7 RDI: 0000000000000001
RBP: ffff8881cd7b6d18 R08: ffff8881ccad8300 R09: ffffed103b5c5b5f
R10: ffffed103b5c5b5f R11: ffff8881dae2dafb R12: 000000000000000f
R13: ffff8881cd7b6fb4 R14: ffff8881cd7b6fb4 R15: ffff8881bb9c9540
FS:  0000000001a6e880(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 00000001c21ac000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

