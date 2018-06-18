Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B7AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B0F20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B0F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934281AbeFRNbF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:31:05 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:46399 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933738AbeFRNbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:31:03 -0400
Received: by mail-io0-f198.google.com with SMTP id m15-v6so13496685ioj.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 06:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xariJre3Cin4FrWvXySvz0NXSD4U8U5OENMsMPN+0GY=;
        b=ZCOGG886e9iPrQ9StKNNZyWbSve9rJ4VQUQzzV26HOVyGpI2LpQnK1pFu7YcrRXvlT
         o/gFyrzqjyU9+00cO4G0tSRF1/xZNaglDQRSPqQPu2pKGxIRixldWev/8rqbEIa7KmoO
         v0/6g97voxU6kRqRTjgiDBxVDvLX7tZYSAXaggZmLa3Jz3L/WJ+fD1nzJYmgvp5osjdi
         fmxs5TUsMwI45K50bK66KyxB/ObVSjHHNG0wK0ZRt3lYuyaOJgQoEGzqMhsYSllh8jYU
         wHDdqm3LBP5erSttNaH7NeM90TjtcM4K4LytKB+nlhzBRv211oTzQbwJybLUtmYiLeDi
         +BoA==
X-Gm-Message-State: APt69E0i3iCXQTK+3cux/cFjpVnw+5hZAkCsuFE70hrVaFWmJoM1qpha
        sWQco4YfZ+cRbAcXdz8riszxKzaJ6QHuMPT3C9E90Pbu2ai+
X-Google-Smtp-Source: ADUXVKL5GNX/A6f21/6wcINUxUUBiLKEwTwiwCSpV4R4S11mXwmE/dX8tNhpJWlfBJFnOkwPnYxOf2dHvZ/zF5oaDPcQWxtd38TJ
MIME-Version: 1.0
X-Received: by 2002:a24:4a54:: with SMTP id k81-v6mr4909681itb.54.1529328662799;
 Mon, 18 Jun 2018 06:31:02 -0700 (PDT)
Date:   Mon, 18 Jun 2018 06:31:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0ee7a056eea93a7@google.com>
Subject: KASAN: use-after-free Read in ipv6_gso_pull_exthdrs
From:   syzbot <syzbot+7b9ed9872dab8c32305d@syzkaller.appspotmail.com>
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

HEAD commit:    f0dc7f9c6dd9 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1463121f800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9c20c48788d1c1
dashboard link: https://syzkaller.appspot.com/bug?extid=7b9ed9872dab8c32305d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7b9ed9872dab8c32305d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ipv6_gso_pull_exthdrs+0x53e/0x5d0  
net/ipv6/ip6_offload.c:45
Read of size 1 at addr ffff8801cf0d7769 by task syz-executor0/21808

CPU: 1 PID: 21808 Comm: syz-executor0 Not tainted 4.17.0+ #84
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  ipv6_gso_pull_exthdrs+0x53e/0x5d0 net/ipv6/ip6_offload.c:45
netlink: 48 bytes leftover after parsing attributes in process  
`syz-executor6'.
  ipv6_gso_segment+0x372/0x11c0 net/ipv6/ip6_offload.c:87
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  __skb_gso_segment+0x3bb/0x870 net/core/dev.c:2865
  skb_gso_segment include/linux/netdevice.h:4079 [inline]
  validate_xmit_skb+0x638/0xf20 net/core/dev.c:3104
  __dev_queue_xmit+0xc0c/0x3900 net/core/dev.c:3561
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3602
  packet_snd net/packet/af_packet.c:2921 [inline]
  packet_sendmsg+0x4275/0x6100 net/packet/af_packet.c:2946
  sock_sendmsg_nosec net/socket.c:645 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:655
  __sys_sendto+0x3d7/0x670 net/socket.c:1833
  __do_sys_sendto net/socket.c:1845 [inline]
  __se_sys_sendto net/socket.c:1841 [inline]
  __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1841
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455b29
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1665cd0c68 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f1665cd16d4 RCX: 0000000000455b29
RDX: 000000000000020b RSI: 00000000200016c0 RDI: 0000000000000013
RBP: 000000000072bea0 R08: 00000000200000c0 R09: 000000000000001c
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c0eb8 R14: 00000000004d0960 R15: 0000000000000000

Allocated by task 21219:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
  getname_flags+0xd0/0x5a0 fs/namei.c:140
  user_path_at_empty+0x2d/0x50 fs/namei.c:2555
  user_path_at include/linux/namei.h:57 [inline]
  do_faccessat+0x24a/0x7c0 fs/open.c:389
  __do_sys_access fs/open.c:441 [inline]
  __se_sys_access fs/open.c:439 [inline]
  __x64_sys_access+0x59/0x80 fs/open.c:439
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 21219:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
  putname+0xf2/0x130 fs/namei.c:261
  filename_lookup+0x38b/0x4f0 fs/namei.c:2330
  user_path_at_empty+0x40/0x50 fs/namei.c:2555
  user_path_at include/linux/namei.h:57 [inline]
  do_faccessat+0x24a/0x7c0 fs/open.c:389
  __do_sys_access fs/open.c:441 [inline]
  __se_sys_access fs/open.c:439 [inline]
  __x64_sys_access+0x59/0x80 fs/open.c:439
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801cf0d6d00
  which belongs to the cache names_cache of size 4096
The buggy address is located 2665 bytes inside of
  4096-byte region [ffff8801cf0d6d00, ffff8801cf0d7d00)
The buggy address belongs to the page:
page:ffffea00073c3580 count:1 mapcount:0 mapping:ffff8801da986dc0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea00073c3508 ffffea0006a10008 ffff8801da986dc0
raw: 0000000000000000 ffff8801cf0d6d00 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801cf0d7600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801cf0d7680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801cf0d7700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                           ^
  ffff8801cf0d7780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801cf0d7800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
