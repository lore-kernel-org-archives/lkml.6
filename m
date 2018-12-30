Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BB0C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 06:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2904213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 06:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbeL3GKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 01:10:05 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:57063 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbeL3GKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 01:10:05 -0500
Received: by mail-io1-f72.google.com with SMTP id x2so28658635ioa.23
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 22:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+W3hb3OL6rwAqMwE+mpC6M8g9ozYCK5CP6x7gKp//00=;
        b=Jh++70OizMe6DPqpjiCGMzg1Hy9zdNikKn71InLJDpuC0VSeiubTOK9b5tuARhyK1O
         WweHLBLuCeOBsj4K8W3SOhTh0UmMHGORTdnVB1ygcRvhFUBUBhLh8z9JCf/Qgd1Ei8aS
         iAlBm7yv5G7VFS7tc2MVD4lxodb0oRevCRpQxoYASDKX0DulcLcD/GxHMzAe9LUJJFG0
         0vYvVUKx2CNaGPG8TndelwO0GLofMRAJyhNRei9NszWbEBkn2FA5GiQNJCtEWa+1XA+m
         XDKaQiqlBeJkmHMYcFYkjHadv+HT4jlpI67myl4wyyG9ZDR2unin9snfJ+jopc3NtGtI
         BNcA==
X-Gm-Message-State: AA+aEWb9+G1TQm9pm6TapGByE9GPRPbIewY0foFwyAoLj805kcVtySum
        Kh38zfcd9YEbqeRigWrZKWtPHeHhN4bGeKJWOUXfggFcOCkm
X-Google-Smtp-Source: AFSGD/VtuUomOMV7+OXxGKcrXYxqoJ9wuee65vph/Lsc/NC/f0/CYfRxsEXncT9egDPmde+/x9MWg6B0lwSC2j2U/F6zUmu5nrFT
MIME-Version: 1.0
X-Received: by 2002:a02:5c8:: with SMTP id 69mr25943502jal.20.1546150203786;
 Sat, 29 Dec 2018 22:10:03 -0800 (PST)
Date:   Sat, 29 Dec 2018 22:10:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa968f057e372583@google.com>
Subject: BUG: unable to handle kernel paging request in sctp_v6_get_dst
From:   syzbot <syzbot+ae70faffd84f05295f27@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    90cadbbf341d Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1081829b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d41c8529d7e7362
dashboard link: https://syzkaller.appspot.com/bug?extid=ae70faffd84f05295f27
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ae70faffd84f05295f27@syzkaller.appspotmail.com

dst_release: dst:000000006e60b654 refcnt:-1
dst_release: dst:000000006e60b654 refcnt:-1
BUG: unable to handle kernel paging request at ffffffffffff88f1
PGD 966d067 P4D 966d067 PUD 966f067 PMD 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 26041 Comm: syz-executor2 Not tainted 4.20.0-rc7+ #360
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:191 [inline]
RIP: 0010:rt6_get_cookie include/net/ip6_fib.h:260 [inline]
RIP: 0010:sctp_v6_get_dst+0x9d1/0x22d0 net/sctp/ipv6.c:379
Code: c1 ea 03 c6 04 02 00 48 8d 79 70 48 89 fa 48 c1 ea 03 80 3c 02 00 0f  
85 7e 18 00 00 48 8b 85 a8 fc ff ff 48 89 da 48 c1 ea 03 <4c> 8b 60 70 48  
b8 00 00 00 00 00 fc ff df 80 3c 02 00 0f 85 6f 18
RSP: 0018:ffff8881dac062b0 EFLAGS: 00010a02
RAX: ffffffffffff8881 RBX: ffff8881dac06510 RCX: ffffffffffff8881
RDX: 1ffff1103b580ca2 RSI: ffffffff874b895b RDI: ffffffffffff88f1
RBP: ffff8881dac06660 R08: ffff888194e86600 R09: ffffed103b585b77
R10: ffffed103b585b77 R11: ffff8881dac2dbbb R12: ffff8881b12a1d80
R13: dffffc0000000000 R14: ffffed103b580c7a R15: ffff8881dac065d0
FS:  00007f2d362c2700(0000) GS:ffff8881dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffff88f1 CR3: 00000001d1f76000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  sctp_transport_route+0x132/0x360 net/sctp/transport.c:311
  sctp_assoc_add_peer+0x5fd/0x10d0 net/sctp/associola.c:678
  sctp_process_param net/sctp/sm_make_chunk.c:2543 [inline]
  sctp_process_init+0xfba/0x29c0 net/sctp/sm_make_chunk.c:2356
  sctp_sf_do_5_1B_init+0x8e3/0xf70 net/sctp/sm_statefuns.c:416
sctp: [Deprecated]: syz-executor4 (pid 26043) Use of int in max_burst  
socket option deprecated.
Use struct sctp_assoc_value instead
  sctp_do_sm+0x1c1/0x7190 net/sctp/sm_sideeffect.c:1188
kobject: 'loop4' (000000007c488f81): kobject_uevent_env
kobject: 'loop4' (000000007c488f81): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
  sctp_endpoint_bh_rcv+0x465/0x960 net/sctp/endpointola.c:456
  sctp_inq_push+0x280/0x370 net/sctp/inqueue.c:95
kobject: 'loop4' (000000007c488f81): kobject_uevent_env
  sctp_rcv+0x2e48/0x4150 net/sctp/input.c:271
kobject: 'loop4' (000000007c488f81): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
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
  do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1027
  </IRQ>
  do_softirq.part.13+0x126/0x160 kernel/softirq.c:337
  do_softirq kernel/softirq.c:329 [inline]
  __local_bh_enable_ip+0x21d/0x260 kernel/softirq.c:189
  local_bh_enable include/linux/bottom_half.h:32 [inline]
  rcu_read_unlock_bh include/linux/rcupdate.h:696 [inline]
  ip6_finish_output2+0xcef/0x2930 net/ipv6/ip6_output.c:121
  ip6_finish_output+0x583/0xc50 net/ipv6/ip6_output.c:154
  NF_HOOK_COND include/linux/netfilter.h:278 [inline]
  ip6_output+0x232/0x9d0 net/ipv6/ip6_output.c:171
  dst_output include/net/dst.h:444 [inline]
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip6_xmit+0xf0d/0x24c0 net/ipv6/ip6_output.c:275
  sctp_v6_xmit+0x385/0x760 net/sctp/ipv6.c:234
  sctp_packet_transmit+0x1f05/0x3cd0 net/sctp/output.c:641
  sctp_packet_singleton net/sctp/outqueue.c:787 [inline]
  sctp_outq_flush_ctrl.constprop.11+0x7a9/0xe50 net/sctp/outqueue.c:918
  sctp_outq_flush+0x310/0x34f0 net/sctp/outqueue.c:1200
  sctp_outq_uncork+0x6a/0x80 net/sctp/outqueue.c:772
  sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1820 [inline]
  sctp_side_effects net/sctp/sm_sideeffect.c:1220 [inline]
  sctp_do_sm+0x5ff/0x7190 net/sctp/sm_sideeffect.c:1191
  sctp_primitive_ASSOCIATE+0x9d/0xd0 net/sctp/primitive.c:88
  sctp_sendmsg_to_asoc+0x52a/0x1a10 net/sctp/socket.c:1923
  sctp_sendmsg+0x13c2/0x1da0 net/sctp/socket.c:2113
  inet_sendmsg+0x1a1/0x690 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  __sys_sendto+0x3d7/0x670 net/socket.c:1788
  __do_sys_sendto net/socket.c:1800 [inline]
  __se_sys_sendto net/socket.c:1796 [inline]
  __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1796
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457759
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2d362c1c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 0000000000457759
RDX: 0000000000000001 RSI: 000000002087dffe RDI: 0000000000000005
RBP: 000000000073bf00 R08: 000000002005ffe4 R09: 000000000000001c
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2d362c26d4
R13: 00000000004c4a7a R14: 00000000004d81c0 R15: 00000000ffffffff
Modules linked in:
CR2: ffffffffffff88f1
---[ end trace a9e62d2e21808088 ]---
RIP: 0010:__read_once_size include/linux/compiler.h:191 [inline]
RIP: 0010:rt6_get_cookie include/net/ip6_fib.h:260 [inline]
RIP: 0010:sctp_v6_get_dst+0x9d1/0x22d0 net/sctp/ipv6.c:379
Code: c1 ea 03 c6 04 02 00 48 8d 79 70 48 89 fa 48 c1 ea 03 80 3c 02 00 0f  
85 7e 18 00 00 48 8b 85 a8 fc ff ff 48 89 da 48 c1 ea 03 <4c> 8b 60 70 48  
b8 00 00 00 00 00 fc ff df 80 3c 02 00 0f 85 6f 18
RSP: 0018:ffff8881dac062b0 EFLAGS: 00010a02
RAX: ffffffffffff8881 RBX: ffff8881dac06510 RCX: ffffffffffff8881
RDX: 1ffff1103b580ca2 RSI: ffffffff874b895b RDI: ffffffffffff88f1
RBP: ffff8881dac06660 R08: ffff888194e86600 R09: ffffed103b585b77
R10: ffffed103b585b77 R11: ffff8881dac2dbbb R12: ffff8881b12a1d80
R13: dffffc0000000000 R14: ffffed103b580c7a R15: ffff8881dac065d0
FS:  00007f2d362c2700(0000) GS:ffff8881dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffff88f1 CR3: 00000001d1f76000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
