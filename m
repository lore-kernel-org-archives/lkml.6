Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2148CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 05:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1273206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 05:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbeLXFmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 00:42:04 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:44996 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbeLXFmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 00:42:04 -0500
Received: by mail-it1-f198.google.com with SMTP id x82so12957329ita.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 21:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fRHhDPOFTpc5k0EEcRQaBnMgsKSIZOabS6U17bw39SU=;
        b=rgM2k5NX5XqUFtbcqNUJRYgL+3E6eUcJhVbHCgFEqTUlMmVp7LYcnvFvPTvDqcL6oP
         rTvrGsK6iX38GIz/959O4FwM5zKGLOAQxnluX3Fr/tPF99AqLB0rXt85RM6iZt2qvdw+
         rTF8OhUEXti3gWCRieesLjUjIcNBVSkHsN7cCpsGZUlpN11XxxtSNYXF2N/BvIV5g8cW
         jK+/Jik8xqbQy7QpZAjPK55C3v1Zn6XQL/3Rc/FosQpUVFx2V4uYJjs7gvQXwIzusQV4
         U93Ts/qFvVD6aZ7CuAqva42Gl6kq+vLWQrDJ8MPOFUCxAtD4MojKUb1CYO0mdb4t5u9H
         VeGA==
X-Gm-Message-State: AJcUukeHkdwj+NVvOGXdmiTNGQXZJG7PRVSZpCEbY8hrueiHmoAumkVa
        YVfT0itxjOJ8hBMrp/EEL0zJQU1yewV3/j7LCPbkoUDpgpmP
X-Google-Smtp-Source: ALg8bN7inV9xaEzzD71vDAUNuDAcZ1HPszIrZ8Cj3knCvk9Uedc/1QV8uNYVScBHParEZ7R5Yu1uA+0I1KhQweQS1p5z5JPQV1SQ
MIME-Version: 1.0
X-Received: by 2002:a6b:cd8d:: with SMTP id d135mr11171448iog.19.1545630122961;
 Sun, 23 Dec 2018 21:42:02 -0800 (PST)
Date:   Sun, 23 Dec 2018 21:42:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ef2f5057dbe0e7b@google.com>
Subject: KASAN: use-after-free Read in __xfrm_policy_bysel_ctx
From:   syzbot <syzbot+ae4bda7fbf4ae4fb57b6@syzkaller.appspotmail.com>
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

HEAD commit:    ce28bb445388 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=175b8d15400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67a2081147a23142
dashboard link: https://syzkaller.appspot.com/bug?extid=ae4bda7fbf4ae4fb57b6
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ae4bda7fbf4ae4fb57b6@syzkaller.appspotmail.com

netlink: 20 bytes leftover after parsing attributes in process  
`syz-executor1'.
netlink: 104 bytes leftover after parsing attributes in process  
`syz-executor0'.
netlink: 20 bytes leftover after parsing attributes in process  
`syz-executor1'.
==================================================================
BUG: KASAN: use-after-free in  
__xfrm_policy_bysel_ctx.constprop.63+0x3d4/0x460 net/xfrm/xfrm_policy.c:1618
Read of size 1 at addr ffff8881b697a699 by task syz-executor0/25289

CPU: 0 PID: 25289 Comm: syz-executor0 Not tainted 4.20.0-rc7+ #358
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  __xfrm_policy_bysel_ctx.constprop.63+0x3d4/0x460  
net/xfrm/xfrm_policy.c:1618
  xfrm_policy_bysel_ctx+0x883/0x1050 net/xfrm/xfrm_policy.c:1664
  xfrm_get_policy+0x6a3/0x1140 net/xfrm/xfrm_user.c:1887
  xfrm_user_rcv_msg+0x44c/0x8e0 net/xfrm/xfrm_user.c:2663
  netlink_rcv_skb+0x16c/0x430 net/netlink/af_netlink.c:2477
  xfrm_netlink_rcv+0x6f/0x90 net/xfrm/xfrm_user.c:2671
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
RIP: 0033:0x457669
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0704710c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457669
RDX: 0000000000000000 RSI: 000000002014f000 RDI: 0000000000000003
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f07047116d4
R13: 00000000004c44d8 R14: 00000000004d74e8 R15: 00000000ffffffff

Allocated by task 24751:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc_node mm/slab.c:3684 [inline]
  __kmalloc_node_track_caller+0x50/0x70 mm/slab.c:3698
  __kmalloc_reserve.isra.40+0x41/0xe0 net/core/skbuff.c:140
  __alloc_skb+0x155/0x760 net/core/skbuff.c:208
  alloc_skb include/linux/skbuff.h:1011 [inline]
  sctp_packet_transmit+0x36b/0x3cd0 net/sctp/output.c:584
  sctp_packet_transmit_chunk+0xa8/0x18b net/sctp/output.c:207
  sctp_outq_flush_data net/sctp/outqueue.c:1106 [inline]
  sctp_outq_flush+0x1546/0x34f0 net/sctp/outqueue.c:1205
  sctp_outq_uncork+0x6a/0x80 net/sctp/outqueue.c:772
  sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1820 [inline]
  sctp_side_effects net/sctp/sm_sideeffect.c:1220 [inline]
  sctp_do_sm+0x5ff/0x7190 net/sctp/sm_sideeffect.c:1191
  sctp_assoc_bh_rcv+0x346/0x670 net/sctp/associola.c:1074
  sctp_inq_push+0x280/0x370 net/sctp/inqueue.c:95
  sctp_rcv+0x2e48/0x4150 net/sctp/input.c:271
  sctp6_rcv+0x15/0x30 net/sctp/ipv6.c:1065
  ip6_protocol_deliver_rcu+0x372/0x1940 net/ipv6/ip6_input.c:394
  ip6_input_finish+0x84/0x170 net/ipv6/ip6_input.c:434
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip6_input+0xe9/0x600 net/ipv6/ip6_input.c:443
  dst_input include/net/dst.h:450 [inline]
  ip6_rcv_finish+0x17a/0x330 net/ipv6/ip6_input.c:76
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ipv6_rcv+0x115/0x640 net/ipv6/ip6_input.c:272
  __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4973
  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:5083
  process_backlog+0x217/0x760 net/core/dev.c:5923
  napi_poll net/core/dev.c:6346 [inline]
  net_rx_action+0x7c5/0x1950 net/core/dev.c:6412
  __do_softirq+0x30c/0xb2e kernel/softirq.c:292

Freed by task 24751:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  skb_free_head+0x93/0xb0 net/core/skbuff.c:553
  skb_release_data+0x706/0x990 net/core/skbuff.c:573
  skb_release_all+0x4a/0x60 net/core/skbuff.c:627
  __kfree_skb net/core/skbuff.c:641 [inline]
  consume_skb+0x1ae/0x570 net/core/skbuff.c:701
  sctp_chunk_destroy net/sctp/sm_make_chunk.c:1462 [inline]
  sctp_chunk_put+0x2d4/0x450 net/sctp/sm_make_chunk.c:1489
  sctp_chunk_free+0x53/0x60 net/sctp/sm_make_chunk.c:1476
  sctp_inq_pop+0x568/0x10a0 net/sctp/inqueue.c:150
  sctp_assoc_bh_rcv+0xdb/0x670 net/sctp/associola.c:1020
  sctp_inq_push+0x280/0x370 net/sctp/inqueue.c:95
  sctp_backlog_rcv+0x1a8/0xd50 net/sctp/input.c:354
  sk_backlog_rcv include/net/sock.h:932 [inline]
  __release_sock+0x12f/0x390 net/core/sock.c:2284
  release_sock+0xad/0x2c0 net/core/sock.c:2797
  sctp_sendmsg+0x13e6/0x1da0 net/sctp/socket.c:2118
  inet_sendmsg+0x1a1/0x690 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881b697a480
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 537 bytes inside of
  1024-byte region [ffff8881b697a480, ffff8881b697a880)
The buggy address belongs to the page:
page:ffffea0006da5e80 count:1 mapcount:0 mapping:ffff8881da800ac0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea0006d6f008 ffffea00065b6a88 ffff8881da800ac0
raw: 0000000000000000 ffff8881b697a000 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881b697a580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881b697a600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881b697a680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                             ^
  ffff8881b697a700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881b697a780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
