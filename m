Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54E5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7380620859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfAGJxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:53:09 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:46147 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfAGJxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:53:05 -0500
Received: by mail-io1-f70.google.com with SMTP id o22so48917515iob.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 01:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8jXAiCovYH+RMKtzoCCq7iDBPVKBkP0pEeDTbUP1ET0=;
        b=GAyBhn3hF+Ai875ym3ocEAXM43MRUfTJaoX4+RT7n7JjGfHZcA18+IFTkFRgfDBERx
         V435M5a8eOZVfSxPMgbtTmswfomSyasf8T3sF5/2C8BWO+NTAlXMoXVCSAtxPIl66Yyd
         cPAMC14pbNLOgS1P/Gx5oyQXWPD3xmn5CWbRlyB/Zs1V0EEJmpCWod9qoCp2UFDmN10q
         FC43gfIqXlxygKTKQAgDd3p6/VqJWQlbvcITVioaP9axjebwEyFFdOQP7sYVZnup7V/F
         wxUgN94rTa+lscnU80UFya7qCWqMj0281ZHZXl9WFTaQNxqmeHuJS/7vFsoAsxwqGdbv
         uSug==
X-Gm-Message-State: AJcUukeYny3I4pff1PWoe+i3GwNeUlKfyE5HTiTTDy1bAEHK7OP/AG+x
        I1E6VjvqrTeStG4opi/3K6jskUxnaEQ0EKpOO+RP+3pmHr8f
X-Google-Smtp-Source: ALg8bN66d8FmUeHYamNimSyOR93nrgWiPOZDYJafc5bxoRStHX+5HfsTmxJfkauVdgt2pWJsSEeG2iRhAr8WwqF4e/aTu9Fct/kx
MIME-Version: 1.0
X-Received: by 2002:a5e:a913:: with SMTP id c19mr13609576iod.32.1546854784150;
 Mon, 07 Jan 2019 01:53:04 -0800 (PST)
Date:   Mon, 07 Jan 2019 01:53:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000edb77b057edb31d9@google.com>
Subject: KASAN: use-after-free Read in xfrm_migrate
From:   syzbot <syzbot+efd77299e1e802fe8f8f@syzkaller.appspotmail.com>
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

HEAD commit:    b71acb0e3721 Merge branch 'linus' of git://git.kernel.org/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1755f9bb400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b03c5892bb940c76
dashboard link: https://syzkaller.appspot.com/bug?extid=efd77299e1e802fe8f8f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+efd77299e1e802fe8f8f@syzkaller.appspotmail.com

netlink: 'syz-executor0': attribute type 1 has an invalid length.
==================================================================
BUG: KASAN: use-after-free in xfrm_migrate_policy_find  
net/xfrm/xfrm_policy.c:4055 [inline]
BUG: KASAN: use-after-free in xfrm_migrate+0x178f/0x1a30  
net/xfrm/xfrm_policy.c:4193
Read of size 4 at addr ffff888063d41bf4 by task syz-executor5/17251

CPU: 1 PID: 17251 Comm: syz-executor5 Not tainted 4.20.0+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
netlink: 4 bytes leftover after parsing attributes in process  
`syz-executor1'.
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report mm/kasan/report.c:412 [inline]
  kasan_report.cold+0x8c/0x2ba mm/kasan/report.c:396
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  xfrm_migrate_policy_find net/xfrm/xfrm_policy.c:4055 [inline]
  xfrm_migrate+0x178f/0x1a30 net/xfrm/xfrm_policy.c:4193
  xfrm_do_migrate+0x9e5/0xd90 net/xfrm/xfrm_user.c:2380
  xfrm_user_rcv_msg+0x458/0x8d0 net/xfrm/xfrm_user.c:2663
  netlink_rcv_skb+0x17d/0x410 net/netlink/af_netlink.c:2477
  xfrm_netlink_rcv+0x70/0x90 net/xfrm/xfrm_user.c:2671
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x574/0x770 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa05/0xf90 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:631
  ___sys_sendmsg+0x7ec/0x910 net/socket.c:2116
kobject: 'phy44' (000000002305d5de): kobject_uevent_env
kobject: 'phy44' (000000002305d5de): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim43/ieee80211/phy44'
  __sys_sendmsg+0x112/0x270 net/socket.c:2154
kobject: 'rfkill45' (00000000c83ac774): kobject_add_internal:  
parent: 'phy44', set: 'devices'
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
kobject: 'rfkill45' (00000000c83ac774): kobject_uevent_env
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe250302c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe2503036d4
R13: 00000000004c5394 R14: 00000000004d8e30 R15: 00000000ffffffff

Allocated by task 17077:
  save_stack+0x45/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc mm/kasan/kasan.c:553 [inline]
  kasan_kmalloc+0xce/0xf0 mm/kasan/kasan.c:531
  __do_kmalloc_node mm/slab.c:3684 [inline]
  __kmalloc_node_track_caller+0x51/0x80 mm/slab.c:3698
  __kmalloc_reserve.isra.0+0x40/0xe0 net/core/skbuff.c:140
  __alloc_skb+0x12d/0x730 net/core/skbuff.c:208
  alloc_skb include/linux/skbuff.h:1011 [inline]
  new_skb+0x28/0x1d0 drivers/block/aoe/aoecmd.c:67
kobject: 'rfkill45' (00000000c83ac774): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim43/ieee80211/phy44/rfkill45'
  aoecmd_cfg_pkts drivers/block/aoe/aoecmd.c:426 [inline]
  aoecmd_cfg+0x299/0x810 drivers/block/aoe/aoecmd.c:1381
  discover_timer+0x4e/0x60 drivers/block/aoe/aoemain.c:24
  call_timer_fn+0x254/0x900 kernel/time/timer.c:1325
  expire_timers kernel/time/timer.c:1362 [inline]
  __run_timers+0x6fc/0xd50 kernel/time/timer.c:1681
  run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1694
  __do_softirq+0x30b/0xb11 kernel/softirq.c:292

Freed by task 2690:
  save_stack+0x45/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  skb_free_head+0x93/0xb0 net/core/skbuff.c:553
  skb_release_data+0x6ea/0x970 net/core/skbuff.c:573
  skb_release_all+0x4d/0x60 net/core/skbuff.c:627
  __kfree_skb net/core/skbuff.c:641 [inline]
  consume_skb net/core/skbuff.c:701 [inline]
  consume_skb+0x18c/0x550 net/core/skbuff.c:695
  aoenet_rcv+0xa3/0x560 drivers/block/aoe/aoenet.c:190
  __netif_receive_skb_one_core+0x160/0x210 net/core/dev.c:4973
  __netif_receive_skb+0x2c/0x1c0 net/core/dev.c:5083
ieee80211 phy44: Selected rate control algorithm 'minstrel_ht'
  process_backlog+0x206/0x750 net/core/dev.c:5923
  napi_poll net/core/dev.c:6346 [inline]
  net_rx_action+0x76d/0x1930 net/core/dev.c:6412
  __do_softirq+0x30b/0xb11 kernel/softirq.c:292

The buggy address belongs to the object at ffff888063d41b40
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 180 bytes inside of
  1024-byte region [ffff888063d41b40, ffff888063d41f40)
The buggy address belongs to the page:
kobject: 'net' (000000009ee70099): kobject_add_internal: parent: 'hwsim43',  
set: '(null)'
page:ffffea00018f5000 count:1 mapcount:0 mapping:ffff88812c3f0ac0 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea0002418f88 ffffea0002536a08 ffff88812c3f0ac0
raw: 0000000000000000 ffff888063d40040 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

kobject: 'wlan13' (000000005b6395aa): kobject_add_internal: parent: 'net',  
set: 'devices'
Memory state around the buggy address:
  ffff888063d41a80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff888063d41b00: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> ffff888063d41b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                              ^
  ffff888063d41c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888063d41c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
