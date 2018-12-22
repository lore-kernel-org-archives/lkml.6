Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DATE_IN_PAST_06_12,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AB5C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A13621A4E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392662AbeLVRj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:39:57 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:33394 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391557AbeLVRj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:39:57 -0500
Received: by mail-io1-f72.google.com with SMTP id d20so1724480iom.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 09:39:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=slXAuXGV8XP1areJNqxqnwUwvF17F36grlACQvf98sU=;
        b=MQcVCT0svlrPdNMRrdarG9g3vJNH6eYjonFgaqsd7JN/fuoMD9pwkLiT86aT/xnMXa
         FrUhOJEdPplNvKWyl+xvJ+eCScFd8QNHvYrjIwR1jrEveXQ+fPiu/N3QryWKH9k3Cw6R
         4okZKMLPM7Cpc+OcY874V8NgeWhrz9q+JO657s25/3ZB4b/GVEp1+Bhl8Ty3EfNP6bC7
         uH1qVzXpXNPrwfgrYMo0+LqF/Uma7pvhU9+9F9ek8wa9gy8iROuTg6I7W+7C+AlgxfVc
         42A5iQr6rH3NBvYqAtnqeL+FC8pJxDO0gCPoDJSbfDZ/GqZgp8xYBiEkSE9Hgcw3GUeR
         KDfQ==
X-Gm-Message-State: AA+aEWbmpn6lKfrYWprwm2mkyHT0YXyVed3d26AzDHHHYM4s7zQnHbR2
        7HRCBOHAqwSmsSJwp3NHJuN6/DMpnrtOp434QXPZgODZ/JB+
X-Google-Smtp-Source: ALg8bN7/5DYGYYPPoAwRDJcZglOlm+jhbmW0/siGnmNdcydjArWnN32M5DoaYCMZqMep7NmsJXnSoGlqcYNVZyZOUomDdcrpSr51
MIME-Version: 1.0
X-Received: by 2002:a24:1d01:: with SMTP id 1mr4078012itj.39.1545465904001;
 Sat, 22 Dec 2018 00:05:04 -0800 (PST)
Date:   Sat, 22 Dec 2018 00:05:03 -0800
In-Reply-To: <000000000000f16b5e05714225b8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003878ad057d97d241@google.com>
Subject: Re: KASAN: use-after-free Write in __xfrm_policy_unlink
From:   syzbot <syzbot+9d971dd21eb26567036b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    ce28bb445388 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1673fb1b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67a2081147a23142
dashboard link: https://syzkaller.appspot.com/bug?extid=9d971dd21eb26567036b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1134dcc7400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126986ed400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9d971dd21eb26567036b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __hlist_del include/linux/list.h:704 [inline]
BUG: KASAN: use-after-free in hlist_del_rcu include/linux/rculist.h:455  
[inline]
BUG: KASAN: use-after-free in __xfrm_policy_unlink+0xa09/0xa20  
net/xfrm/xfrm_policy.c:2212
Write of size 8 at addr ffff8881ce732010 by task syz-executor247/6934

CPU: 0 PID: 6934 Comm: syz-executor247 Not tainted 4.20.0-rc7+ #358
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_store8_noabort+0x17/0x20 mm/kasan/report.c:438
  __hlist_del include/linux/list.h:704 [inline]
  hlist_del_rcu include/linux/rculist.h:455 [inline]
  __xfrm_policy_unlink+0xa09/0xa20 net/xfrm/xfrm_policy.c:2212
  xfrm_policy_insert+0x20a/0x850 net/xfrm/xfrm_policy.c:1587
  xfrm_add_policy+0x2a0/0x6f0 net/xfrm/xfrm_user.c:1657
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
RIP: 0033:0x4448b9
Code: e8 dc b1 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 db 01 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd339e4118 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004448b9
RDX: 0000000000000000 RSI: 000000002014f000 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00000000000002af R09: 00000000000002af
R10: 00000000000002af R11: 0000000000000246 R12: 00000000000002af
R13: 000000000000ae56 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 6932:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:546 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  xfrm_policy_alloc+0xfa/0x4f0 net/xfrm/xfrm_policy.c:383
  xfrm_policy_construct+0x2f/0x650 net/xfrm/xfrm_user.c:1599
  xfrm_add_policy+0x203/0x6f0 net/xfrm/xfrm_user.c:1648
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

Freed by task 16:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  xfrm_policy_destroy_rcu+0x4a/0x60 net/xfrm/xfrm_policy.c:407
  __rcu_reclaim kernel/rcu/rcu.h:240 [inline]
  rcu_do_batch kernel/rcu/tree.c:2437 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2716 [inline]
  rcu_process_callbacks+0x100a/0x1ac0 kernel/rcu/tree.c:2697
  __do_softirq+0x30c/0xb2e kernel/softirq.c:292

The buggy address belongs to the object at ffff8881ce732000
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 16 bytes inside of
  1024-byte region [ffff8881ce732000, ffff8881ce732400)
The buggy address belongs to the page:
page:ffffea000739cc80 count:1 mapcount:0 mapping:ffff8881da800ac0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea000739d608 ffffea000739da88 ffff8881da800ac0
raw: 0000000000000000 ffff8881ce732000 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881ce731f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881ce731f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8881ce732000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                          ^
  ffff8881ce732080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881ce732100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

