Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5B7C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86972084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86972084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbeJANbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:31:18 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:51470 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeJANbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:31:18 -0400
Received: by mail-io1-f69.google.com with SMTP id w23-v6so12300181iob.18
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 23:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0naIcRTKx2ozMuvf9/wbWt15Zp2sM7XW3tX/BzH5cVI=;
        b=rzrD0r8NjgMasF8kAEazT1kCMp7zFpWpnkOR0KM1PSjFNliq6aEmnMgJ5D9omTY/zw
         2S7t+9YR8ikNow2G6BMkpYMSPuLiDWejtwoazd7vGgLTTUWQDAL6vkA5E1PvUyzoihUc
         17cOx/MHG5QYJ5W7CKZvmb+pHfvCeb7WLuDXDB/KX9FaI4xDoU7hJeY6cRsJyYDk/5Pn
         bUllso3FJNmlKNP5/GMNtJKTqlE4skOsB3EAbnCMXGvEv8vcnJyDCKDSbEt+B768JwuN
         feckcDUCPND0pSICdUCj/nhPUEGyX9iYyp5xve/OYWIIFxUvJn1MceHaka2BHHdFgRZ2
         Z+yg==
X-Gm-Message-State: ABuFfoj+73FHGunGsuh6X2LMxAqAefPInRVv1rqSDFY7Un+iJ2Mg7/Vq
        OCsi2kYMT3xr8RUnXyUNVyiG4Uc1BMWiUVPDiC/qGOV7eZOa
X-Google-Smtp-Source: ACcGV60TCkw4tj//KBR5vUe1je3qGAA1BdBJgPISDrjPMnEiI48MczmHOKHZHVxhQ52G7eGX1F3GxZffjcquzh5gIpmSMiM3zlkV
MIME-Version: 1.0
X-Received: by 2002:a6b:3709:: with SMTP id e9-v6mr6807626ioa.8.1538376903417;
 Sun, 30 Sep 2018 23:55:03 -0700 (PDT)
Date:   Sun, 30 Sep 2018 23:55:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbeaea0577254824@google.com>
Subject: KASAN: use-after-free Read in xfrm_sk_policy_lookup
From:   syzbot <syzbot+fa158127e8a7f651dbbf@syzkaller.appspotmail.com>
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

HEAD commit:    291d0e5d81e1 Merge tag 'for-linus-20180929' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173b614e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a8212f992609a887
dashboard link: https://syzkaller.appspot.com/bug?extid=fa158127e8a7f651dbbf
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fa158127e8a7f651dbbf@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in xfrm_sk_policy_lookup+0x61c/0x640  
net/xfrm/xfrm_policy.c:1191
Read of size 2 at addr ffff8801995e5d1c by task syz-executor1/9885

CPU: 0 PID: 9885 Comm: syz-executor1 Not tainted 4.19.0-rc5+ #38
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load2_noabort+0x14/0x20 mm/kasan/report.c:431
  xfrm_sk_policy_lookup+0x61c/0x640 net/xfrm/xfrm_policy.c:1191
  xfrm_lookup_with_ifid+0x2a1/0x2b80 net/xfrm/xfrm_policy.c:2063
  xfrm_lookup net/xfrm/xfrm_policy.c:2200 [inline]
  xfrm_lookup_route+0x3c/0x1f0 net/xfrm/xfrm_policy.c:2211
  ip6_dst_lookup_flow+0x1c6/0x270 net/ipv6/ip6_output.c:1083
  inet6_csk_route_socket+0x8bd/0x1020 net/ipv6/inet6_connection_sock.c:110
  inet6_csk_xmit+0x118/0x630 net/ipv6/inet6_connection_sock.c:125
  l2tp_xmit_core net/l2tp/l2tp_core.c:1030 [inline]
  l2tp_xmit_skb+0x134c/0x1670 net/l2tp/l2tp_core.c:1132
  pppol2tp_sendmsg+0x4b1/0x6c0 net/l2tp/l2tp_ppp.c:329
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x51d/0x930 net/socket.c:2116
  __sys_sendmmsg+0x246/0x6d0 net/socket.c:2211
  __do_sys_sendmmsg net/socket.c:2240 [inline]
  __se_sys_sendmmsg net/socket.c:2237 [inline]
  __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2237
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457579
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f36fada1c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000457579
RDX: 0800000000000059 RSI: 0000000020005fc0 RDI: 0000000000000007
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 00007f36fada26d4
R13: 00000000004c34ed R14: 00000000004d52b0 R15: 00000000ffffffff

Allocated by task 9885:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  xfrm_policy_alloc+0xd9/0x480 net/xfrm/xfrm_policy.c:267
  xfrm_compile_policy+0x257/0x430 net/xfrm/xfrm_user.c:2994
  xfrm_user_policy+0x3ef/0xb10 net/xfrm/xfrm_state.c:2102
  do_ipv6_setsockopt.isra.9+0xfd6/0x45d0 net/ipv6/ipv6_sockglue.c:821
  ipv6_setsockopt+0xbd/0x170 net/ipv6/ipv6_sockglue.c:933
  udpv6_setsockopt+0x62/0xa0 net/ipv6/udp.c:1482
  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3038
  __sys_setsockopt+0x1ba/0x3c0 net/socket.c:1902
  __do_sys_setsockopt net/socket.c:1913 [inline]
  __se_sys_setsockopt net/socket.c:1910 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1910
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 32034:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3813
  xfrm_policy_destroy_rcu+0x4a/0x60 net/xfrm/xfrm_policy.c:290
  __rcu_reclaim kernel/rcu/rcu.h:236 [inline]
  rcu_do_batch kernel/rcu/tree.c:2576 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2880 [inline]
  __rcu_process_callbacks kernel/rcu/tree.c:2847 [inline]
  rcu_process_callbacks+0xf23/0x2670 kernel/rcu/tree.c:2864
  __do_softirq+0x30b/0xad8 kernel/softirq.c:292

The buggy address belongs to the object at ffff8801995e5b00
  which belongs to the cache kmalloc-1024 of size 1024
The buggy address is located 540 bytes inside of
  1024-byte region [ffff8801995e5b00, ffff8801995e5f00)
The buggy address belongs to the page:
page:ffffea0006657900 count:1 mapcount:0 mapping:ffff8801da800ac0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea000730b108 ffffea00075ef008 ffff8801da800ac0
raw: 0000000000000000 ffff8801995e4000 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801995e5c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801995e5c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801995e5d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                             ^
  ffff8801995e5d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801995e5e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
