Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B890C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A655D2064E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A655D2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbeJOON4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 10:13:56 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:34646 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeJOON4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 10:13:56 -0400
Received: by mail-it1-f198.google.com with SMTP id p20-v6so19264685itg.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 23:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=yhM0ItOqmIFZFMs0YDHpCLHn4QyzPK5rbyiMwrPTP2A=;
        b=cPXEli1T3eIaYmZ9VML6CMqJt/rOiTAYvBC9J5e8haudCdvaiMvtizlvdJwGF+DMvQ
         Y4sTh4/f7nnuYEqTUwPJs+24uoj83OXdfKR8KY2xUQ8j2HYJ64Oa0wui0QA14GOwVsJs
         ATHecDjaGT4DyQUQY2LnVCSV5WYv/MBIX9jn9Zo8jO3YWqicogZpNi53oXloJyij63EB
         JhqbOni4t/X0CN6Yf7ZSBtlfZIvfEKAMCHH4oXX1+ztAuni+p+ep/v6Pg65RpnWkMr/3
         PQyFjeI5Xq5LjKWa8Z1GSdseNtwMp3CBACAGDInmEmiV5v8MTLwjla1Slpph7fT8gQZu
         c9bg==
X-Gm-Message-State: ABuFfohh1c6+E3lqI4iOkChR6GgnJXTwxEGcmcbRwh1HDkatCwXQdfOv
        mkhSZFPyQHPUP4XvhgJsC+8rOgYFYYx0brTzlF4Cbo/nwrTH
X-Google-Smtp-Source: ACcGV6369kQmZrdqm4VlJRFxnuWLmfzAJUI5vNrh88K13W61ssNt67m2vwy5YHfGJsJcAQqZxGLO9EB4qJAY2aWjurckosGj+gPH
MIME-Version: 1.0
X-Received: by 2002:a5e:d710:: with SMTP id v16-v6mr12247741iom.26.1539585003462;
 Sun, 14 Oct 2018 23:30:03 -0700 (PDT)
Date:   Sun, 14 Oct 2018 23:30:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ba80905783e9189@google.com>
Subject: KASAN: use-after-free Write in skb_release_data (2)
From:   syzbot <syzbot+580be3953ed99133804f@syzkaller.appspotmail.com>
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

HEAD commit:    e40a826a6cbc qed: Add support for virtual link.
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=168954a5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e7e2279c0020d5f
dashboard link: https://syzkaller.appspot.com/bug?extid=580be3953ed99133804f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+580be3953ed99133804f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic_sub_return  
include/asm-generic/atomic-instrumented.h:305 [inline]
BUG: KASAN: use-after-free in skb_release_data+0x1a3/0x880  
net/core/skbuff.c:559
Write of size 4 at addr ffff8801d8cb4120 by task syz-executor0/8395

CPU: 0 PID: 8395 Comm: syz-executor0 Not tainted 4.19.0-rc6+ #254
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  kasan_check_write+0x14/0x20 mm/kasan/kasan.c:278
  atomic_sub_return include/asm-generic/atomic-instrumented.h:305 [inline]
  skb_release_data+0x1a3/0x880 net/core/skbuff.c:559
  skb_release_all+0x4a/0x60 net/core/skbuff.c:627
  __kfree_skb net/core/skbuff.c:641 [inline]
  kfree_skb+0x1bb/0x580 net/core/skbuff.c:659
  sit_tunnel_xmit+0x173/0x30d0 net/ipv6/sit.c:1044
  __netdev_start_xmit include/linux/netdevice.h:4328 [inline]
  netdev_start_xmit include/linux/netdevice.h:4337 [inline]
  xmit_one net/core/dev.c:3219 [inline]
  dev_hard_start_xmit+0x295/0xc90 net/core/dev.c:3235
  __dev_queue_xmit+0x2f0d/0x3950 net/core/dev.c:3805
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3838
  packet_sendmsg_spkt+0xf44/0x16f0 net/packet/af_packet.c:1975
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457519
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2a52d30c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457519
RDX: 0000000000000000 RSI: 00000000200003c0 RDI: 0000000000000003
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2a52d316d4
R13: 00000000004c34d5 R14: 00000000004d52c8 R15: 00000000ffffffff

Allocated by task 8395:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc_node mm/slab.c:3682 [inline]
  __kmalloc_node_track_caller+0x47/0x70 mm/slab.c:3696
  __kmalloc_reserve.isra.39+0x41/0xe0 net/core/skbuff.c:137
  __alloc_skb+0x155/0x770 net/core/skbuff.c:205
  alloc_skb include/linux/skbuff.h:997 [inline]
  sock_wmalloc+0x16d/0x1f0 net/core/sock.c:1934
  packet_sendmsg_spkt+0x48a/0x16f0 net/packet/af_packet.c:1922
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8395:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3813
  skb_free_head+0x99/0xc0 net/core/skbuff.c:550
  skb_release_data+0x6a4/0x880 net/core/skbuff.c:570
  skb_release_all+0x4a/0x60 net/core/skbuff.c:627
  __kfree_skb net/core/skbuff.c:641 [inline]
  consume_skb+0x1ae/0x570 net/core/skbuff.c:701
  packet_rcv+0x172/0x1820 net/packet/af_packet.c:2139
  dev_queue_xmit_nit+0x8ae/0xb30 net/core/dev.c:2020
  xmit_one net/core/dev.c:3215 [inline]
  dev_hard_start_xmit+0x186/0xc90 net/core/dev.c:3235
  __dev_queue_xmit+0x2f0d/0x3950 net/core/dev.c:3805
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3838
  packet_sendmsg_spkt+0xf44/0x16f0 net/packet/af_packet.c:1975
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801d8cb4040
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 224 bytes inside of
  512-byte region [ffff8801d8cb4040, ffff8801d8cb4240)
The buggy address belongs to the page:
page:ffffea0007632d00 count:1 mapcount:0 mapping:ffff8801da800940  
index:0xffff8801d8cb42c0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea00070baf08 ffffea000736a788 ffff8801da800940
raw: ffff8801d8cb42c0 ffff8801d8cb4040 0000000100000005 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d8cb4000: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
  ffff8801d8cb4080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801d8cb4100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                ^
  ffff8801d8cb4180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d8cb4200: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
