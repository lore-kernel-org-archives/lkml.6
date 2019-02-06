Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2C2C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC03A20844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfBFFCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 00:02:04 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:36820 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfBFFCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 00:02:03 -0500
Received: by mail-it1-f199.google.com with SMTP id w15so2575787ita.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 21:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DAq3okB7f8FesgriHet8a4NKJ69wcx2YkAisGtz5VL4=;
        b=rxUiXgNEd886ZLeuC5JaOYt9Ttd7B03zCPKyHUxYfOMYHKkC4lFHjvORKcbBS5fJxq
         pRMJzDc9BujZ4X7xAYZOGXosFELzSOJqgjLkTLZAaIu8449z5tX885bh3UZotaRm/SIX
         pQeM4Jf7SmOs9hQcv5/58kyambgKo6OfxOS0DT6w9VZVWWlMMN+hH2dvRCE9XCx4Juo0
         DrzpZrriHBd3lCAwR8GgaifKY09WYV1Cb3IdEmY4E3UM4f20WAnQOpZbBQAdLglmNTID
         v9oiVS9q87BfR6fIoP6wL2F9kYknNWEtGAvXy0yZyFzs6AA9jG2szAmZd/EBpeNRk+Qx
         Khig==
X-Gm-Message-State: AHQUAuZ5xq9/nLR1Lio9ADIM1dTEoXmxi8m4qA4NhFJvjU07ZIAQBVsl
        71SIrz65cGIT1DnSeApxER4cGXxVR+3HBxA84FjcwIVnwbiP
X-Google-Smtp-Source: AHgI3IZ5kIqcU/81nJ9C+QNGReE2JVAMEQ+XPNpuuwgMPbEmp4wTk31M+YdZZ+WUEZ0I5yl7Lx/lKmysgok7vUL5ke9c4tNdS955
MIME-Version: 1.0
X-Received: by 2002:a6b:f215:: with SMTP id q21mr3019306ioh.25.1549429322438;
 Tue, 05 Feb 2019 21:02:02 -0800 (PST)
Date:   Tue, 05 Feb 2019 21:02:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e6094058132a09a@google.com>
Subject: KASAN: slab-out-of-bounds Read in ip_send_unicast_reply
From:   syzbot <syzbot+f1741fbf71635c029556@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=11a6994b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b03c5892bb940c76
dashboard link: https://syzkaller.appspot.com/bug?extid=f1741fbf71635c029556
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f1741fbf71635c029556@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in sock_net include/net/sock.h:2403 [inline]
BUG: KASAN: slab-out-of-bounds in ip_send_unicast_reply+0x14a6/0x1800  
net/ipv4/ip_output.c:1569
Read of size 8 at addr ffff888097d4c5ac by task syz-executor4/19801

CPU: 0 PID: 19801 Comm: syz-executor4 Not tainted 4.20.0+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report mm/kasan/report.c:412 [inline]
  kasan_report.cold+0x8c/0x2ba mm/kasan/report.c:396
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  sock_net include/net/sock.h:2403 [inline]
  ip_send_unicast_reply+0x14a6/0x1800 net/ipv4/ip_output.c:1569
  tcp_v4_send_reset+0x1496/0x2ad0 net/ipv4/tcp_ipv4.c:775
  tcp_v4_rcv+0x1e17/0x3c40 net/ipv4/tcp_ipv4.c:1936
  ip_protocol_deliver_rcu+0xb6/0xa20 net/ipv4/ip_input.c:208
  ip_local_deliver_finish+0x23b/0x390 net/ipv4/ip_input.c:234
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip_local_deliver+0x1f0/0x740 net/ipv4/ip_input.c:255
  dst_input include/net/dst.h:450 [inline]
  ip_rcv_finish+0x1f4/0x2f0 net/ipv4/ip_input.c:414
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip_rcv+0xed/0x620 net/ipv4/ip_input.c:523
  __netif_receive_skb_one_core+0x160/0x210 net/core/dev.c:4973
  __netif_receive_skb+0x2c/0x1c0 net/core/dev.c:5083
  process_backlog+0x206/0x750 net/core/dev.c:5923
  napi_poll net/core/dev.c:6346 [inline]
  net_rx_action+0x76d/0x1930 net/core/dev.c:6412
  __do_softirq+0x30b/0xb11 kernel/softirq.c:292
  do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1027
  </IRQ>
  do_softirq.part.0+0x11a/0x170 kernel/softirq.c:337
  do_softirq kernel/softirq.c:329 [inline]
  __local_bh_enable_ip+0x211/0x270 kernel/softirq.c:189
  local_bh_enable include/linux/bottom_half.h:32 [inline]
  rcu_read_unlock_bh include/linux/rcupdate.h:696 [inline]
  ip_finish_output2+0xa88/0x1a00 net/ipv4/ip_output.c:231
  ip_finish_output+0x7e4/0xf60 net/ipv4/ip_output.c:317
  NF_HOOK_COND include/linux/netfilter.h:278 [inline]
  ip_output+0x226/0x880 net/ipv4/ip_output.c:405
  dst_output include/net/dst.h:444 [inline]
  ip_local_out+0xc4/0x1b0 net/ipv4/ip_output.c:124
  __ip_queue_xmit+0x99a/0x1ee0 net/ipv4/ip_output.c:505
  ip_queue_xmit+0x5a/0x70 include/net/ip.h:198
  __tcp_transmit_skb+0x1add/0x3af0 net/ipv4/tcp_output.c:1160
  tcp_transmit_skb net/ipv4/tcp_output.c:1176 [inline]
  tcp_connect+0x33ca/0x4770 net/ipv4/tcp_output.c:3535
kobject: 'rx-0' (0000000070ecd47e): kobject_uevent_env
  tcp_v4_connect+0x1598/0x1da0 net/ipv4/tcp_ipv4.c:315
  __inet_stream_connect+0x9a3/0x11b0 net/ipv4/af_inet.c:655
kobject: 'rx-0' (0000000070ecd47e): fill_kobj_path: path  
= '/devices/virtual/net/gretap0/queues/rx-0'
kobject: 'tx-0' (00000000301d47dc): kobject_add_internal: parent: 'queues',  
set: 'queues'
  inet_stream_connect+0x58/0xa0 net/ipv4/af_inet.c:719
  __sys_connect+0x357/0x490 net/socket.c:1664
kobject: 'tx-0' (00000000301d47dc): kobject_uevent_env
  __do_sys_connect net/socket.c:1675 [inline]
  __se_sys_connect net/socket.c:1672 [inline]
  __x64_sys_connect+0x73/0xb0 net/socket.c:1672
kobject: 'tx-0' (00000000301d47dc): fill_kobj_path: path  
= '/devices/virtual/net/gretap0/queues/tx-0'
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
kobject: 'batman_adv' (00000000ab8b79c4): kobject_add_internal:  
parent: 'gretap0', set: '<NULL>'
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f116f5d1c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
kobject: 'erspan0' (000000001f020f96): kobject_add_internal: parent: 'net',  
set: 'devices'
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 0000000000000010 RSI: 0000000020ccb000 RDI: 0000000000000007
RBP: 000000000073bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f116f5d26d4
R13: 00000000004be30a R14: 00000000004ce6d8 R15: 00000000ffffffff

Allocated by task 3862:
  save_stack+0x45/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc mm/kasan/kasan.c:553 [inline]
  kasan_kmalloc+0xce/0xf0 mm/kasan/kasan.c:531
  kasan_slab_alloc+0xf/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x700 mm/slab.c:3554
  getname_flags fs/namei.c:140 [inline]
  getname_flags+0xd6/0x5b0 fs/namei.c:129
  getname+0x1a/0x20 fs/namei.c:211
kobject: 'erspan0' (000000001f020f96): kobject_uevent_env
  do_sys_open+0x3a5/0x740 fs/open.c:1057
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 3862:
  save_stack+0x45/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
kobject: 'erspan0' (000000001f020f96): fill_kobj_path: path  
= '/devices/virtual/net/erspan0'
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x260 mm/slab.c:3760
  putname+0xef/0x130 fs/namei.c:261
  do_sys_open+0x3f4/0x740 fs/open.c:1072
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888097d4cb00
  which belongs to the cache names_cache of size 4096
The buggy address is located 1364 bytes to the left of
  4096-byte region [ffff888097d4cb00, ffff888097d4db00)
The buggy address belongs to the page:
kobject: 'queues' (000000003e95a060): kobject_add_internal:  
parent: 'erspan0', set: '<NULL>'
page:ffffea00025f5300 count:1 mapcount:0 mapping:ffff88812c2bec40 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea0002498108 ffffea0000cfdc88 ffff88812c2bec40
raw: 0000000000000000 ffff888097d4cb00 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888097d4c480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff888097d4c500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
kobject: 'queues' (000000003e95a060): kobject_uevent_env
> ffff888097d4c580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                   ^
  ffff888097d4c600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff888097d4c680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
