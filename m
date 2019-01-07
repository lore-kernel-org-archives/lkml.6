Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F67C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FA720854
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfAGKCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:02:05 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:42365 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfAGKCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:02:04 -0500
Received: by mail-io1-f72.google.com with SMTP id a2so17324136ioq.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 02:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nh3VmB0an00DUoYr6fCqkbKmQqFEotyIDbZgJLccbZo=;
        b=sF21J+IJTer7iS6jli1Ux9zBjGXyx0qzf6+fF/JyznfqR7SB8fo+3FZhVjb2FGCjZy
         Przmcw77dGtPMKoMVHN+SZnxntB4vkYTGSkrYy2TJGJDOGOR2V6SfULUovjiXNPmXsVa
         cF0xY7ionw3Qn8MuaTwdj5gAvDeDIMzdahJrXkNR2MOiD9Sk801EovciJEjroeXLTKxa
         Uj1W61LH1ONNw008FAVJyv68uidOONFTKSHATklWz/0eH9QqAyIZdVU8T84wC4FMFqGw
         TYz8LkUSLXCKzHmz6rOz08+uoFzI6IyeKkVVCwTJS95JNTZcYePfmGRD3d0Pm/nPOOko
         fhTA==
X-Gm-Message-State: AJcUukfXzi1U/QyqApmsgvHGWeQkDecTjfjlHyS+OwB8+i8wSaqFW6zy
        kVJxxyM+c5BO9htNHCnHpQSbul2YTycDPr7Dss0HSW1D2SOF
X-Google-Smtp-Source: ALg8bN4QMfvP+Wrp6fK84IyDnScD9WUIvU94uKxbLhwJ3XLAQJrXMCjAEIgGdOEefkMwqBK3UAb8PgNeKxz1esA+IYQNDa2DY0qk
MIME-Version: 1.0
X-Received: by 2002:a24:a94:: with SMTP id 142mr8019347itw.15.1546855323352;
 Mon, 07 Jan 2019 02:02:03 -0800 (PST)
Date:   Mon, 07 Jan 2019 02:02:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000114562057edb528d@google.com>
Subject: kernel BUG at net/ipv6/route.c:LINE! (2)
From:   syzbot <syzbot+be0943c590bb47aefb9e@syzkaller.appspotmail.com>
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

HEAD commit:    b71acb0e3721 Merge branch 'linus' of git://git.kernel.org/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11d5f9bb400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b03c5892bb940c76
dashboard link: https://syzkaller.appspot.com/bug?extid=be0943c590bb47aefb9e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+be0943c590bb47aefb9e@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at net/ipv6/route.c:1260!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
kobject: 'loop3' (000000002b424f37): kobject_uevent_env
CPU: 0 PID: 11990 Comm: syz-executor0 Not tainted 4.20.0+ #3
kobject: 'loop3' (000000002b424f37): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:rt6_make_pcpu_route net/ipv6/route.c:1260 [inline]
RIP: 0010:ip6_pol_route+0x82f/0x1490 net/ipv6/route.c:1893
Code: 48 03 1c c5 60 70 55 89 be 08 00 00 00 48 89 df e8 66 de f1 fa 31 c0  
f0 4c 0f b1 3b 48 85 c0 0f 84 b3 fb ff ff e8 d1 c0 ae fa <0f> 0b e8 ca c0  
ae fa e8 c5 8b 99 fa 31 ff 89 c6 88 85 c8 fe ff ff
RSP: 0018:ffff888092cb6dd0 EFLAGS: 00010212
netlink: 188 bytes leftover after parsing attributes in process  
`syz-executor3'.
RAX: 0000000000040000 RBX: ffffe8ffffc2e0b0 RCX: ffffc900061fb000
RDX: 0000000000000a5c RSI: ffffffff86d2e53f RDI: ffffe8ffffc2e0b0
RBP: ffff888092cb6f18 R08: 1ffffd1ffff85c16 R09: fffff91ffff85c17
R10: fffff91ffff85c16 R11: ffffe8ffffc2e0b7 R12: ffff88809b57e1c0
R13: 0000000000000001 R14: ffff888092cb6ef0 R15: ffff888088b0c640
FS:  00007fb67723e700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f817add4518 CR3: 0000000097a79000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
netlink: 188 bytes leftover after parsing attributes in process  
`syz-executor3'.
Call Trace:
kobject: 'loop3' (000000002b424f37): kobject_uevent_env
  ip6_pol_route_input+0x65/0x80 net/ipv6/route.c:1909
kobject: 'loop3' (000000002b424f37): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
  fib6_rule_lookup+0x12f/0x870 net/ipv6/fib6_rules.c:118
netlink: 188 bytes leftover after parsing attributes in process  
`syz-executor3'.
  ip6_route_input_lookup+0xb7/0xd0 net/ipv6/route.c:1921
  ip6_route_input+0x79b/0xe00 net/ipv6/route.c:2056
  ip6_rcv_finish_core.isra.0+0x204/0x720 net/ipv6/ip6_input.c:63
kobject: 'loop3' (000000002b424f37): kobject_uevent_env
  ip6_rcv_finish+0x109/0x330 net/ipv6/ip6_input.c:74
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ipv6_rcv+0x113/0x650 net/ipv6/ip6_input.c:272
kobject: 'loop3' (000000002b424f37): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
  __netif_receive_skb_one_core+0x160/0x210 net/core/dev.c:4973
  __netif_receive_skb+0x2c/0x1c0 net/core/dev.c:5083
  netif_receive_skb_internal+0x11e/0x690 net/core/dev.c:5186
  napi_frags_finish net/core/dev.c:5753 [inline]
  napi_gro_frags+0xd07/0xfe0 net/core/dev.c:5827
kobject: 'loop2' (00000000e55d2cdb): kobject_uevent_env
kobject: 'loop2' (00000000e55d2cdb): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
  tun_get_user+0x2ec2/0x4150 drivers/net/tun.c:1972
  tun_chr_write_iter+0xbd/0x160 drivers/net/tun.c:2017
  call_write_iter include/linux/fs.h:1857 [inline]
  do_iter_readv_writev+0x856/0xae0 fs/read_write.c:680
caif:caif_disconnect_client(): nothing to disconnect
  do_iter_write fs/read_write.c:959 [inline]
  do_iter_write+0x184/0x600 fs/read_write.c:940
  vfs_writev+0x1ee/0x370 fs/read_write.c:1004
  do_writev+0x11a/0x300 fs/read_write.c:1039
kobject: 'loop1' (00000000c17c68c7): kobject_uevent_env
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
kobject: 'loop1' (00000000c17c68c7): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457d81
Code: 75 14 b8 14 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 a4 b8 fb ff c3 48  
83 ec 08 e8 1a 2d 00 00 48 89 04 24 b8 14 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 63 2d 00 00 48 89 d0 48 83 c4 08 48 3d 01
kobject: 'loop1' (00000000c17c68c7): kobject_uevent_env
RSP: 002b:00007fb67723dba0 EFLAGS: 00000293 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 000000000000003e RCX: 0000000000457d81
RDX: 0000000000000001 RSI: 00007fb67723dbf0 RDI: 00000000000000f0
RBP: 00000000200001c0 R08: 00000000000000f0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007fb67723e6d4
R13: 00000000004c636f R14: 00000000004db3f8 R15: 00000000ffffffff
Modules linked in:
---[ end trace b72be28f2a6c77c6 ]---
kobject: 'loop1' (00000000c17c68c7): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
RIP: 0010:rt6_make_pcpu_route net/ipv6/route.c:1260 [inline]
RIP: 0010:ip6_pol_route+0x82f/0x1490 net/ipv6/route.c:1893
Code: 48 03 1c c5 60 70 55 89 be 08 00 00 00 48 89 df e8 66 de f1 fa 31 c0  
f0 4c 0f b1 3b 48 85 c0 0f 84 b3 fb ff ff e8 d1 c0 ae fa <0f> 0b e8 ca c0  
ae fa e8 c5 8b 99 fa 31 ff 89 c6 88 85 c8 fe ff ff
RSP: 0018:ffff888092cb6dd0 EFLAGS: 00010212
RAX: 0000000000040000 RBX: ffffe8ffffc2e0b0 RCX: ffffc900061fb000
RDX: 0000000000000a5c RSI: ffffffff86d2e53f RDI: ffffe8ffffc2e0b0
RBP: ffff888092cb6f18 R08: 1ffffd1ffff85c16 R09: fffff91ffff85c17
R10: fffff91ffff85c16 R11: ffffe8ffffc2e0b7 R12: ffff88809b57e1c0
R13: 0000000000000001 R14: ffff888092cb6ef0 R15: ffff888088b0c640
FS:  00007fb67723e700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f817add4518 CR3: 0000000097a79000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
