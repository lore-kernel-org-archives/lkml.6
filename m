Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DA1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCA820700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfBUOqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:46:06 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:37540 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbfBUOqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:46:04 -0500
Received: by mail-io1-f70.google.com with SMTP id e9so1533913iob.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 06:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=F22SMaJMRktFDJHMPzJ0Z7M16i2I1d0UhPWvABaYDWo=;
        b=TWGHvnDSMpFDOVNFyVAaJAJitWeW9D5ZyKGHPfdku3xw8gNdD6VQkbRxUXgZduid/C
         axQ9r6K1x3/daJ6UL54B4hpyTTrskXDzLEK2et2eExotfLlK2/IgT21c8AychKviLAl0
         BLJ7cqkl5YM7UJjtEUefG5m9NJSsKAN1OFYTEhR+iH7mJT9CiTWB51+9uUIA138P4hkd
         syc+VlGTcnEhAzI5g6ooBZUFGv5SRNHFDkAviM9aPhb0wpiZHcsLNhoj9OVcZBIO5Sd9
         /2QRedakTrZCURsK9TEmKFX5kPZRk0v01vyu1NiVXjUB5gYCrWkIjyhCAWyqY+gcprUe
         e6Sg==
X-Gm-Message-State: AHQUAubtzHvYMVNR7By7PWvph+nINzy45dpBR0nOFUp48FOeQ+k98w9s
        Pg3ngEnTkyMHNQShwJ6OvWOahHLvqBqA1FA0OX1odHOQdhEU
X-Google-Smtp-Source: AHgI3IbkPE3klgB5a6ktBYeeYAOSsR8YbDeOEORF6dwDSBfAcOOuxIqLaeBN0sAUA/XdG9HY1Jtm1ZShPPsiTkZuc5SIBNGGl3xr
MIME-Version: 1.0
X-Received: by 2002:a24:d083:: with SMTP id m125mr9308760itg.5.1550760363278;
 Thu, 21 Feb 2019 06:46:03 -0800 (PST)
Date:   Thu, 21 Feb 2019 06:46:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095c8f005826888fd@google.com>
Subject: general protection fault in dev_get_by_index_rcu
From:   syzbot <syzbot+48127bec5a5cd81411e3@syzkaller.appspotmail.com>
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

HEAD commit:    c433570458e4 ax25: fix a use-after-free in ax25_fillin_cb()
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1352f84b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b137b8ba637eb77
dashboard link: https://syzkaller.appspot.com/bug?extid=48127bec5a5cd81411e3
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+48127bec5a5cd81411e3@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3229 Comm: syz-executor0 Not tainted 4.20.0+ #255
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:dev_get_by_index_rcu+0x9a/0x360 net/core/dev.c:840
Code: f2 c7 40 0c 00 f2 f2 f2 65 48 8b 04 25 28 00 00 00 48 89 45 d0 31 c0  
e8 64 82 5f fb 48 8d bb c0 01 00 00 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00  
0f 85 7e 02 00 00 0f b6 85 34 ff ff ff 48 8b 93 c0
RSP: 0018:ffff8880ae706c50 EFLAGS: 00010207
RAX: 001ffffffffbd5e1 RBX: 00ffffffffdead4e RCX: ffffffff8697b590
RDX: 0000000000000100 RSI: ffffffff8622238c RDI: 00ffffffffdeaf0e
RBP: ffff8880ae706d30 R08: ffff888060b26340 R09: ffffed1015ce5b8f
R10: ffffed1015ce5b8f R11: ffff8880ae72dc7b R12: dffffc0000000000
R13: 0000000000000000 R14: ffff88806556b6f0 R15: ffff88808e08b95d
FS:  00007eff2e401700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2fb2c000 CR3: 000000008a036000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  netif_index_is_l3_master include/net/l3mdev.h:138 [inline]
  ip_send_unicast_reply+0x10fd/0x1740 net/ipv4/ip_output.c:1588
  tcp_v4_send_reset+0x14be/0x2ae0 net/ipv4/tcp_ipv4.c:775
  tcp_v4_rcv+0x1dfa/0x3b10 net/ipv4/tcp_ipv4.c:1936
  ip_protocol_deliver_rcu+0xb6/0xa20 net/ipv4/ip_input.c:208
  ip_local_deliver_finish+0x234/0x380 net/ipv4/ip_input.c:234
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip_local_deliver+0x1e9/0x750 net/ipv4/ip_input.c:255
  dst_input include/net/dst.h:450 [inline]
  ip_rcv_finish+0x1f9/0x300 net/ipv4/ip_input.c:414
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip_rcv+0xed/0x600 net/ipv4/ip_input.c:523
  __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4973
  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:5083
  process_backlog+0x217/0x760 net/core/dev.c:5923
  napi_poll net/core/dev.c:6346 [inline]
  net_rx_action+0x7c5/0x1950 net/core/dev.c:6412
  __do_softirq+0x30c/0xb2e kernel/softirq.c:292
  do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1027
  </IRQ>
  do_softirq.part.13+0x126/0x160 kernel/softirq.c:337
  do_softirq kernel/softirq.c:329 [inline]
  __local_bh_enable_ip+0x21d/0x260 kernel/softirq.c:189
  local_bh_enable include/linux/bottom_half.h:32 [inline]
  rcu_read_unlock_bh include/linux/rcupdate.h:696 [inline]
  ip_finish_output2+0xabc/0x1a20 net/ipv4/ip_output.c:231
  ip_finish_output+0x7f7/0xf90 net/ipv4/ip_output.c:317
  NF_HOOK_COND include/linux/netfilter.h:278 [inline]
  ip_output+0x217/0x8d0 net/ipv4/ip_output.c:405
  dst_output include/net/dst.h:444 [inline]
  ip_local_out+0xc5/0x1b0 net/ipv4/ip_output.c:124
  __ip_queue_xmit+0x9af/0x1f40 net/ipv4/ip_output.c:505
  ip_queue_xmit+0x56/0x70 include/net/ip.h:198
  __tcp_transmit_skb+0x1b9f/0x3b90 net/ipv4/tcp_output.c:1160
  tcp_transmit_skb net/ipv4/tcp_output.c:1176 [inline]
  tcp_send_syn_data net/ipv4/tcp_output.c:3495 [inline]
  tcp_connect+0x2271/0x4690 net/ipv4/tcp_output.c:3534
  tcp_v4_connect+0x19bb/0x1df0 net/ipv4/tcp_ipv4.c:315
  __inet_stream_connect+0x992/0x1150 net/ipv4/af_inet.c:655
  tcp_sendmsg_fastopen net/ipv4/tcp.c:1161 [inline]
  tcp_sendmsg_locked+0x2890/0x3f30 net/ipv4/tcp.c:1208
  tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1443
  inet_sendmsg+0x1a1/0x690 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  __sys_sendto+0x3d7/0x670 net/socket.c:1788
  __do_sys_sendto net/socket.c:1800 [inline]
  __se_sys_sendto net/socket.c:1796 [inline]
  __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1796
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007eff2e400c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 0000000000457ec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 000000000073bf00 R08: 00000000200002c0 R09: 0000000000000010
R10: 00000400200007fe R11: 0000000000000246 R12: 00007eff2e4016d4
R13: 00000000004c5278 R14: 00000000004d8b90 R15: 00000000ffffffff
Modules linked in:
---[ end trace 67e073c62a96b1a3 ]---
RIP: 0010:dev_get_by_index_rcu+0x9a/0x360 net/core/dev.c:840
Code: f2 c7 40 0c 00 f2 f2 f2 65 48 8b 04 25 28 00 00 00 48 89 45 d0 31 c0  
e8 64 82 5f fb 48 8d bb c0 01 00 00 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00  
0f 85 7e 02 00 00 0f b6 85 34 ff ff ff 48 8b 93 c0
RSP: 0018:ffff8880ae706c50 EFLAGS: 00010207
RAX: 001ffffffffbd5e1 RBX: 00ffffffffdead4e RCX: ffffffff8697b590
RDX: 0000000000000100 RSI: ffffffff8622238c RDI: 00ffffffffdeaf0e
RBP: ffff8880ae706d30 R08: ffff888060b26340 R09: ffffed1015ce5b8f
R10: ffffed1015ce5b8f R11: ffff8880ae72dc7b R12: dffffc0000000000
R13: 0000000000000000 R14: ffff88806556b6f0 R15: ffff88808e08b95d
FS:  00007eff2e401700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2fb2c000 CR3: 000000008a036000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
