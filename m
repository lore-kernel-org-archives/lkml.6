Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB73BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAED42080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbeLNV6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:58:06 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:50908 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731381AbeLNV6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:58:05 -0500
Received: by mail-it1-f200.google.com with SMTP id p66so7140239itc.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 13:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ozKzKYDUKryHyGpOD7wf8akGmQDmQkP7h/Z5T+xO9o4=;
        b=Pn7NMfIT6pnsc+3p64zXneMti9sGf+ncV6p30TqnK5e08GbqrrSFKmnGEkAEK6Ucc3
         gRzJa109zwTqwgtUc1rbH08EOrT0rJ4SzTapsWCn8zQylQsY1Iwe8CU6i6lp6A3haZoY
         b0YU4Wkc8+yokPAoNtz8GzhkqeYssyOEp2CxXzDMJxy2o9Jch7AG1qmrdniIwn15y2xO
         qClWrtXsoyH4Jk//ALpjK52KdTtFOV8mxPY5Cn/DcnrkX6yI8PpoboOL707tf8fjc7JW
         VCXgFnHq5mqFRkp5TouXKdukc612JY2nnnxuracQqoBHR1bdCXcuERFqXVlQK30IjGj9
         tDGg==
X-Gm-Message-State: AA+aEWZUbcXT+JkFheVdqG2udiry3PHztl7E6gvo+GtMS1sUh3G79IAA
        ubsP7NRzLgjBapQMX6GqMF9JrvjswuONp4RR4fVpokE+DCGJ
X-Google-Smtp-Source: AFSGD/V1sJ2eGVHUjonfUc/vPaYZP2JLU7+RQsrm/wAitqA0l/O5yYNjS8ZaMrKPNSdodl6q3eVkzz8mVNNIljZELcpd0aTFAw3/
MIME-Version: 1.0
X-Received: by 2002:a24:4d82:: with SMTP id l124mr4322144itb.9.1544824683666;
 Fri, 14 Dec 2018 13:58:03 -0800 (PST)
Date:   Fri, 14 Dec 2018 13:58:03 -0800
In-Reply-To: <000000000000de3c7705746dcbb7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082aab3057d028616@google.com>
Subject: Re: KASAN: use-after-free Read in ccid_hc_tx_delete
From:   syzbot <syzbot+3967c1caf256f4d5aefe@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dccp@vger.kernel.org, gerrit@erg.abdn.ac.uk,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    eb6cf9f8cb9d Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a09b6d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=3967c1caf256f4d5aefe
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a4895d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1271cf05400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3967c1caf256f4d5aefe@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ccid_hc_tx_delete+0xe0/0x100  
net/dccp/ccid.c:188
Read of size 8 at addr ffff8881bdce7980 by task syz-executor384/6286

CPU: 1 PID: 6286 Comm: syz-executor384 Not tainted 4.20.0-rc6+ #276
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  ccid_hc_tx_delete+0xe0/0x100 net/dccp/ccid.c:188
  dccp_hdlr_ccid+0x7d/0x150 net/dccp/feat.c:53
  __dccp_feat_activate+0x188/0x280 net/dccp/feat.c:344
  dccp_feat_activate_values+0x3c1/0x80a net/dccp/feat.c:1538
  dccp_create_openreq_child+0x47a/0x630 net/dccp/minisocks.c:127
  dccp_v6_request_recv_sock+0x278/0x2020 net/dccp/ipv6.c:466
  dccp_check_req+0x47d/0x6d0 net/dccp/minisocks.c:196
  dccp_v6_rcv+0x874/0x1ce9 net/dccp/ipv6.c:744
  ip6_input_finish+0x3fc/0x1aa0 net/ipv6/ip6_input.c:384
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip6_input+0xe9/0x600 net/ipv6/ip6_input.c:427
  dst_input include/net/dst.h:450 [inline]
  ip6_rcv_finish+0x17a/0x330 net/ipv6/ip6_input.c:76
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ipv6_rcv+0x115/0x640 net/ipv6/ip6_input.c:272
  __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4946
  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:5056
  process_backlog+0x24e/0x7a0 net/core/dev.c:5864
  napi_poll net/core/dev.c:6287 [inline]
  net_rx_action+0x7fa/0x19b0 net/core/dev.c:6353
  __do_softirq+0x308/0xb7e kernel/softirq.c:292
  do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1027
  </IRQ>
  do_softirq.part.14+0x126/0x160 kernel/softirq.c:337
  do_softirq kernel/softirq.c:329 [inline]
  __local_bh_enable_ip+0x21d/0x260 kernel/softirq.c:189
  local_bh_enable include/linux/bottom_half.h:32 [inline]
  rcu_read_unlock_bh include/linux/rcupdate.h:696 [inline]
  ip6_finish_output2+0xcef/0x2940 net/ipv6/ip6_output.c:121
  ip6_finish_output+0x58c/0xc60 net/ipv6/ip6_output.c:154
  NF_HOOK_COND include/linux/netfilter.h:278 [inline]
  ip6_output+0x232/0x9d0 net/ipv6/ip6_output.c:171
  dst_output include/net/dst.h:444 [inline]
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip6_xmit+0xf1c/0x2510 net/ipv6/ip6_output.c:275
  inet6_csk_xmit+0x375/0x630 net/ipv6/inet6_connection_sock.c:139
  dccp_transmit_skb+0x98c/0x12e0 net/dccp/output.c:142
  dccp_send_ack+0x1d9/0x360 net/dccp/output.c:595
  dccp_rcv_request_sent_state_process net/dccp/input.c:501 [inline]
  dccp_rcv_state_process+0x152e/0x1b7e net/dccp/input.c:680
  dccp_v6_do_rcv+0x271/0xbf0 net/dccp/ipv6.c:638
  sk_backlog_rcv include/net/sock.h:932 [inline]
  __release_sock+0x12f/0x3a0 net/core/sock.c:2276
  release_sock+0xad/0x2c0 net/core/sock.c:2789
  inet_wait_for_connect net/ipv4/af_inet.c:588 [inline]
  __inet_stream_connect+0x641/0x1150 net/ipv4/af_inet.c:680
  inet_stream_connect+0x58/0xa0 net/ipv4/af_inet.c:719
  __sys_connect+0x37d/0x4c0 net/socket.c:1664
  __do_sys_connect net/socket.c:1675 [inline]
  __se_sys_connect net/socket.c:1672 [inline]
  __ia32_sys_connect+0x72/0xb0 net/socket.c:1672
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f22a29
Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 90 90  
90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f7edc1fc EFLAGS: 00000293 ORIG_RAX: 000000000000016a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000020419000
RDX: 000000000000001c RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000003d0f00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 6269:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
  ccid_new+0x25b/0x3e0 net/dccp/ccid.c:151
  dccp_hdlr_ccid+0x27/0x150 net/dccp/feat.c:44
  __dccp_feat_activate+0x188/0x280 net/dccp/feat.c:344
  dccp_feat_activate_values+0x3c1/0x80a net/dccp/feat.c:1538
  dccp_rcv_request_sent_state_process net/dccp/input.c:472 [inline]
  dccp_rcv_state_process+0x1320/0x1b7e net/dccp/input.c:680
  dccp_v6_do_rcv+0x271/0xbf0 net/dccp/ipv6.c:638
  sk_backlog_rcv include/net/sock.h:932 [inline]
  __release_sock+0x12f/0x3a0 net/core/sock.c:2276
  release_sock+0xad/0x2c0 net/core/sock.c:2789
  inet_wait_for_connect net/ipv4/af_inet.c:588 [inline]
  __inet_stream_connect+0x641/0x1150 net/ipv4/af_inet.c:680
  inet_stream_connect+0x58/0xa0 net/ipv4/af_inet.c:719
  __sys_connect+0x37d/0x4c0 net/socket.c:1664
  __do_sys_connect net/socket.c:1675 [inline]
  __se_sys_connect net/socket.c:1672 [inline]
  __ia32_sys_connect+0x72/0xb0 net/socket.c:1672
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

Freed by task 6283:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3760
  ccid_hc_tx_delete+0xc3/0x100 net/dccp/ccid.c:190
  dccp_hdlr_ccid+0x7d/0x150 net/dccp/feat.c:53
  __dccp_feat_activate+0x188/0x280 net/dccp/feat.c:344
  dccp_feat_activate_values+0x3c1/0x80a net/dccp/feat.c:1538
  dccp_create_openreq_child+0x47a/0x630 net/dccp/minisocks.c:127
  dccp_v6_request_recv_sock+0x278/0x2020 net/dccp/ipv6.c:466
  dccp_check_req+0x47d/0x6d0 net/dccp/minisocks.c:196
  dccp_v6_rcv+0x874/0x1ce9 net/dccp/ipv6.c:744
  ip6_input_finish+0x3fc/0x1aa0 net/ipv6/ip6_input.c:384
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip6_input+0xe9/0x600 net/ipv6/ip6_input.c:427
  dst_input include/net/dst.h:450 [inline]
  ip6_rcv_finish+0x17a/0x330 net/ipv6/ip6_input.c:76
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ipv6_rcv+0x115/0x640 net/ipv6/ip6_input.c:272
  __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4946
  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:5056
  process_backlog+0x24e/0x7a0 net/core/dev.c:5864
  napi_poll net/core/dev.c:6287 [inline]
  net_rx_action+0x7fa/0x19b0 net/core/dev.c:6353
  __do_softirq+0x308/0xb7e kernel/softirq.c:292

The buggy address belongs to the object at ffff8881bdce7980
  which belongs to the cache ccid2_hc_tx_sock of size 1240
The buggy address is located 0 bytes inside of
  1240-byte region [ffff8881bdce7980, ffff8881bdce7e58)
The buggy address belongs to the page:
page:ffffea0006f73980 count:1 mapcount:0 mapping:ffff8881c5c76680 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea0006f71108 ffffea0006f73908 ffff8881c5c76680
raw: 0000000000000000 ffff8881bdce6380 0000000100000005 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881bdce7880: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
  ffff8881bdce7900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8881bdce7980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                    ^
  ffff8881bdce7a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881bdce7a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

