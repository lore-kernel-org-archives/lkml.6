Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4019CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A6320843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A6320843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbeIZVR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:17:26 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:50655 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbeIZVR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:17:26 -0400
Received: by mail-io1-f69.google.com with SMTP id z25-v6so51903128iog.17
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 08:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Zu/6cB6Rs+w5iK/aRPMyMnnu3jLQRoRJTmYNOUYoHDE=;
        b=fF1t5RGDN2nneKwpgvKbhJIG4vvcDHjP0ugGEkTVXIxq0tw7X34Z2j3pdbUMlnYVp3
         arVREsy4am/W3aKx6Gqkw1mh8z3QhtC9qf5lXt+2rTSD2lcjyA3a137Fz/2ejCwcgGGV
         Bj5EIuw04cXmvZbVxtYmB+lOZO8uMn0B86jQviRoeBsDR7065RqMgCqyHXOOTJop3EK2
         x7eXZeMu1Q5IUdJv5IAE+WoOpww/tR1VhSe3LCslOo9d/8XVMf0rcbZdhk0drdFNQ13/
         XLAoTwjK1s73HgibXGzGHLDGjhczihHlH6SEp4CCeHQUrKzt1SMmViJdWIEzEF82/XeS
         6KPA==
X-Gm-Message-State: ABuFfojWFUjiqMgZ5dlIjUyHLD8X/dXjt5V8LPU2hx8cWIANsHJbiNwh
        ziAApcVF7GRNBSY1/HmBleVAii6OFQnKJwbBz7KLZiVSnegG
X-Google-Smtp-Source: ACcGV62hj3AN8azlakrfnPHklhATu/Vypi5O5997HHawbRy4ExEefvg4n5OkdL1FdaaXJpGRA9MStt44hi0dI66gN8lb4T2e+Kr+
MIME-Version: 1.0
X-Received: by 2002:a24:7543:: with SMTP id y64-v6mr4291289itc.20.1537974244005;
 Wed, 26 Sep 2018 08:04:04 -0700 (PDT)
Date:   Wed, 26 Sep 2018 08:04:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ce3ae0576c788e5@google.com>
Subject: KMSAN: uninit-value in gre_rcv (2)
From:   syzbot <syzbot+841c053d026900055032@syzkaller.appspotmail.com>
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

HEAD commit:    eb2e67596de2 kmsan: minor code cleanup
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=12b763fa400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94a9ed72288f7fef
dashboard link: https://syzkaller.appspot.com/bug?extid=841c053d026900055032
compiler:       clang version 8.0.0 (trunk 339414)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12aac356400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16346711400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+841c053d026900055032@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KMSAN: uninit-value in __arch_swab32  
arch/x86/include/uapi/asm/swab.h:10 [inline]
BUG: KMSAN: uninit-value in __fswab32 include/uapi/linux/swab.h:59 [inline]
BUG: KMSAN: uninit-value in erspan_rcv net/ipv4/ip_gre.c:285 [inline]
BUG: KMSAN: uninit-value in gre_rcv+0x11d0/0x1920 net/ipv4/ip_gre.c:425
CPU: 0 PID: 4713 Comm: syz-executor382 Not tainted 4.19.0-rc4+ #58
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x2f6/0x430 lib/dump_stack.c:113
  kmsan_report+0x183/0x2b0 mm/kmsan/kmsan.c:917
  __msan_warning+0x70/0xc0 mm/kmsan/kmsan_instr.c:500
  __arch_swab32 arch/x86/include/uapi/asm/swab.h:10 [inline]
  __fswab32 include/uapi/linux/swab.h:59 [inline]
  erspan_rcv net/ipv4/ip_gre.c:285 [inline]
  gre_rcv+0x11d0/0x1920 net/ipv4/ip_gre.c:425
  gre_rcv+0x2d5/0x3b0 net/ipv4/gre_demux.c:142
  ip_local_deliver_finish+0x90e/0xfa0 net/ipv4/ip_input.c:215
  NF_HOOK include/linux/netfilter.h:287 [inline]
  ip_local_deliver+0x438/0x4d0 net/ipv4/ip_input.c:256
  dst_input include/net/dst.h:450 [inline]
  ip_rcv_finish net/ipv4/ip_input.c:415 [inline]
  NF_HOOK include/linux/netfilter.h:287 [inline]
  ip_rcv+0x65f/0x6d0 net/ipv4/ip_input.c:524
  __netif_receive_skb_one_core net/core/dev.c:4891 [inline]
  __netif_receive_skb net/core/dev.c:5001 [inline]
  process_backlog+0xd89/0x11a0 net/core/dev.c:5807
  napi_poll net/core/dev.c:6227 [inline]
  net_rx_action+0x935/0x1c00 net/core/dev.c:6293
  __do_softirq+0x614/0xa72 kernel/softirq.c:292
  do_softirq_own_stack+0x49/0x80 arch/x86/entry/entry_64.S:1055
  </IRQ>
  do_softirq kernel/softirq.c:336 [inline]
  __local_bh_enable_ip+0x119/0x150 kernel/softirq.c:189
  local_bh_enable+0x36/0x40 include/linux/bottom_half.h:32
  rcu_read_unlock_bh include/linux/rcupdate.h:723 [inline]
  ip_finish_output2+0x13cd/0x14f0 net/ipv4/ip_output.c:231
  ip_do_fragment+0x37b8/0x3fd0 net/ipv4/ip_output.c:678
  ip_fragment+0x249/0x3f0 net/ipv4/ip_output.c:561
  ip_finish_output+0xfbb/0x10a0 net/ipv4/ip_output.c:315
  NF_HOOK_COND include/linux/netfilter.h:276 [inline]
  ip_output+0x50f/0x5d0 net/ipv4/ip_output.c:405
  dst_output include/net/dst.h:444 [inline]
  ip_local_out net/ipv4/ip_output.c:124 [inline]
  ip_send_skb+0x178/0x350 net/ipv4/ip_output.c:1441
  udp_send_skb+0x10b9/0x18d0 net/ipv4/udp.c:829
  udp_push_pending_frames net/ipv4/udp.c:857 [inline]
  udp_sendmsg+0xac6/0x3cd0 net/ipv4/udp.c:1148
  udpv6_sendmsg+0x12e2/0x4cf0 net/ipv6/udp.c:1196
  inet_sendmsg+0x4c5/0x7d0 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  __sys_sendto+0x868/0xa30 net/socket.c:1786
  __do_sys_sendto net/socket.c:1798 [inline]
  __se_sys_sendto+0x107/0x130 net/socket.c:1794
  __x64_sys_sendto+0x6e/0x90 net/socket.c:1794
  do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x441319
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 db 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff698f4638 EFLAGS: 00000286 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000441319
RDX: 000000000000000e RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00000000006cc018 R08: 0000000020000180 R09: 000000000000001c
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000402280
R13: 0000000000402310 R14: 0000000000000000 R15: 0000000000000000

Uninit was stored to memory at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:255 [inline]
  kmsan_save_stack mm/kmsan/kmsan.c:270 [inline]
  kmsan_internal_chain_origin+0x128/0x210 mm/kmsan/kmsan.c:572
  kmsan_memcpy_origins+0x13d/0x1b0 mm/kmsan/kmsan.c:396
  __msan_memcpy+0xc3/0x130 mm/kmsan/kmsan_instr.c:286
  pskb_expand_head+0x49f/0x1e10 net/core/skbuff.c:1470
  __skb_cow include/linux/skbuff.h:2911 [inline]
  skb_cow_head include/linux/skbuff.h:2945 [inline]
  ip_tunnel_xmit+0x3217/0x3870 net/ipv4/ip_tunnel.c:771
  __gre_xmit net/ipv4/ip_gre.c:454 [inline]
  erspan_xmit+0x1af6/0x3380 net/ipv4/ip_gre.c:752
  __netdev_start_xmit include/linux/netdevice.h:4287 [inline]
  netdev_start_xmit include/linux/netdevice.h:4296 [inline]
  xmit_one net/core/dev.c:3216 [inline]
  dev_hard_start_xmit+0x68b/0xd50 net/core/dev.c:3232
  sch_direct_xmit+0x52b/0x860 net/sched/sch_generic.c:327
  qdisc_restart net/sched/sch_generic.c:390 [inline]
  __qdisc_run+0x1ab7/0x3490 net/sched/sch_generic.c:398
  qdisc_run include/net/pkt_sched.h:120 [inline]
  __dev_xmit_skb net/core/dev.c:3411 [inline]
  __dev_queue_xmit+0x1bc3/0x3c60 net/core/dev.c:3770
  dev_queue_xmit+0x4b/0x60 net/core/dev.c:3835
  neigh_resolve_output+0xaa2/0xb40 net/core/neighbour.c:1364
  neigh_output include/net/neighbour.h:483 [inline]
  ip_finish_output2+0x13b7/0x14f0 net/ipv4/ip_output.c:229
  ip_do_fragment+0x37b8/0x3fd0 net/ipv4/ip_output.c:678
  ip_fragment+0x249/0x3f0 net/ipv4/ip_output.c:561
  ip_finish_output+0xfbb/0x10a0 net/ipv4/ip_output.c:315
  NF_HOOK_COND include/linux/netfilter.h:276 [inline]
  ip_output+0x50f/0x5d0 net/ipv4/ip_output.c:405
  dst_output include/net/dst.h:444 [inline]
  ip_local_out net/ipv4/ip_output.c:124 [inline]
  ip_send_skb+0x178/0x350 net/ipv4/ip_output.c:1441
  udp_send_skb+0x10b9/0x18d0 net/ipv4/udp.c:829
  udp_push_pending_frames net/ipv4/udp.c:857 [inline]
  udp_sendmsg+0xac6/0x3cd0 net/ipv4/udp.c:1148
  udpv6_sendmsg+0x12e2/0x4cf0 net/ipv6/udp.c:1196
  inet_sendmsg+0x4c5/0x7d0 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  __sys_sendto+0x868/0xa30 net/socket.c:1786
  __do_sys_sendto net/socket.c:1798 [inline]
  __se_sys_sendto+0x107/0x130 net/socket.c:1794
  __x64_sys_sendto+0x6e/0x90 net/socket.c:1794
  do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:255 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:180
  kmsan_kmalloc+0x98/0x100 mm/kmsan/kmsan_hooks.c:91
  kmsan_slab_alloc+0x10/0x20 mm/kmsan/kmsan_hooks.c:100
  slab_post_alloc_hook mm/slab.h:446 [inline]
  slab_alloc_node mm/slub.c:2718 [inline]
  __kmalloc_node_track_caller+0xb55/0x1380 mm/slub.c:4351
  __kmalloc_reserve net/core/skbuff.c:138 [inline]
  __alloc_skb+0x40d/0xe50 net/core/skbuff.c:206
  alloc_skb include/linux/skbuff.h:996 [inline]
  alloc_skb_with_frags+0x1d0/0xac0 net/core/skbuff.c:5273
  sock_alloc_send_pskb+0xe28/0x1420 net/core/sock.c:2082
  sock_alloc_send_skb+0xca/0xe0 net/core/sock.c:2099
  __ip_append_data+0x2d54/0x4460 net/ipv4/ip_output.c:981
  ip_append_data+0x2fb/0x440 net/ipv4/ip_output.c:1196
  udp_sendmsg+0x6f9/0x3cd0 net/ipv4/udp.c:1142
  udpv6_sendmsg+0x12e2/0x4cf0 net/ipv6/udp.c:1196
  inet_sendmsg+0x4c5/0x7d0 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  __sys_sendto+0x868/0xa30 net/socket.c:1786
  __do_sys_sendto net/socket.c:1798 [inline]
  __se_sys_sendto+0x107/0x130 net/socket.c:1794
  __x64_sys_sendto+0x6e/0x90 net/socket.c:1794
  do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
