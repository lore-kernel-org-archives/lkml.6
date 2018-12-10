Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6473CC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B979205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B979205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeLJHvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:51:05 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:42524 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeLJHvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:51:04 -0500
Received: by mail-io1-f71.google.com with SMTP id r13so10719362ioj.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 23:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rmHxERxWEOAobSE6+08pzHo2LNxY8/QOlvOC+GaluHA=;
        b=Q8T16C0BzJSnyu7Ig84d41Ne0AtVzlHWNW8oRb5KZses2fNw7TAOtJw0IPg/3x30zm
         35mYUiqO58SRGj8vrT6jjGvmLOYbybVJ1aiG5M4c3bPZgRC80JALWALGtp6ynCDBaXKE
         /PMGSi8qUGrArfgZuXPIvG4oDe5xoC09CvgtjYjbab3+anEEIRNjKbLuY7BDtu/ctdXM
         KYFiea/0NeoTYsGlTi7+pggw2rSdAvbqexfY+JI4hnLylpzUnTCNgPSw98V2w78JDTsD
         /T4RBqOvoh6daHNAnb2MoQgCCpnl6I+1LyIFqOTa/t/VoL1pwMVIw3MCswV7+b5zgwZq
         8tww==
X-Gm-Message-State: AA+aEWbO9dQsCsPTrXzzRkBZH/WFuFzY65Mgjv5cRYy6aYdmVVTQd4hh
        FXhSaObgVIA/5J72wegfyj3KXdaRrbCL0MoEZauDgXabtAjK
X-Google-Smtp-Source: AFSGD/Vei3Bcj0M8VJ+J6Qhxe5B2Rf/C67Fx5hbiBR4gdvZgbR+hPCFb7mtNmP3KocIz7g7pAgtfxpTebQ3eaQ+CrG4G3z3tA2AZ
MIME-Version: 1.0
X-Received: by 2002:a5e:c80b:: with SMTP id y11mr8771784iol.20.1544428263418;
 Sun, 09 Dec 2018 23:51:03 -0800 (PST)
Date:   Sun, 09 Dec 2018 23:51:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005b92c057ca63aa7@google.com>
Subject: KASAN: slab-out-of-bounds Read in neigh_mark_dead
From:   syzbot <syzbot+424d47d5c456ce8b2bbe@syzkaller.appspotmail.com>
To:     christian@brauner.io, davem@davemloft.net, dsahern@gmail.com,
        edumazet@google.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, roopa@cumulusnetworks.com,
        syzkaller-bugs@googlegroups.com, w.bumiller@proxmox.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    83af01ba1c2d Merge branch 'tc-testing-next'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=119cd8b3400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ecefa8a6e10719
dashboard link: https://syzkaller.appspot.com/bug?extid=424d47d5c456ce8b2bbe
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+424d47d5c456ce8b2bbe@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in __list_del_entry_valid+0xf1/0x100  
lib/list_debug.c:51
Read of size 8 at addr ffff8881cede7db0 by task kworker/0:3/6132

CPU: 0 PID: 6132 Comm: kworker/0:3 Not tainted 4.20.0-rc4+ #333
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_power_efficient neigh_periodic_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __list_del_entry_valid+0xf1/0x100 lib/list_debug.c:51
  __list_del_entry include/linux/list.h:117 [inline]
  list_del_init include/linux/list.h:159 [inline]
  neigh_mark_dead+0x13b/0x410 net/core/neighbour.c:125
  neigh_periodic_work+0x89a/0xc30 net/core/neighbour.c:905
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
kobject: 'queues' (00000000e56310e9): kobject_add_internal:  
parent: 'wlan340', set: '<NULL>'
kobject: 'queues' (00000000e56310e9): kobject_uevent_env
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
kobject: 'queues' (00000000e56310e9): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000ad997d75): kobject_add_internal: parent: 'queues',  
set: 'queues'
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
kobject: 'rx-0' (00000000ad997d75): kobject_uevent_env

Allocated by task 9759:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3722 [inline]
  __kmalloc+0x15b/0x760 mm/slab.c:3731
  kmalloc include/linux/slab.h:551 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  __register_sysctl_table+0xc7/0xfb0 fs/proc/proc_sysctl.c:1307
  register_net_sysctl+0x29/0x30 net/sysctl_net.c:120
kobject: 'rx-0' (00000000ad997d75): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim1910/net/wlan340/queues/rx-0'
  neigh_sysctl_register+0x399/0x730 net/core/neighbour.c:3430
  devinet_sysctl_register+0xb4/0x220 net/ipv4/devinet.c:2520
  inetdev_init+0x2df/0x590 net/ipv4/devinet.c:274
  inetdev_event+0xf19/0x1340 net/ipv4/devinet.c:1479
  notifier_call_chain+0x17e/0x380 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1737
kobject: 'tx-0' (0000000014d217b7): kobject_add_internal: parent: 'queues',  
set: 'queues'
  call_netdevice_notifiers_extack net/core/dev.c:1749 [inline]
  call_netdevice_notifiers net/core/dev.c:1763 [inline]
  register_netdevice+0xb7d/0x11a0 net/core/dev.c:8615
  ieee80211_if_add+0x1103/0x1ab0 net/mac80211/iface.c:1885
  ieee80211_register_hw+0x351b/0x3f10 net/mac80211/main.c:1224
  mac80211_hwsim_new_radio+0x1e48/0x3460  
drivers/net/wireless/mac80211_hwsim.c:2887
  hwsim_new_radio_nl+0x7dc/0xb20 drivers/net/wireless/mac80211_hwsim.c:3369
  genl_family_rcv_msg+0x8a7/0x11a0 net/netlink/genetlink.c:601
  genl_rcv_msg+0xc6/0x168 net/netlink/genetlink.c:626
kobject: 'tx-0' (0000000014d217b7): kobject_uevent_env
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2477
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
kobject: 'tx-0' (0000000014d217b7): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim1910/net/wlan340/queues/tx-0'
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  __rcu_reclaim kernel/rcu/rcu.h:233 [inline]
  rcu_do_batch kernel/rcu/tree.c:2437 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2716 [inline]
  rcu_process_callbacks+0x1140/0x1ac0 kernel/rcu/tree.c:2697
kobject: 'tx-1' (00000000cb7aa8b1): kobject_add_internal: parent: 'queues',  
set: 'queues'
  __do_softirq+0x308/0xb7e kernel/softirq.c:292

The buggy address belongs to the object at ffff8881cede7b40
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 624 bytes inside of
  1024-byte region [ffff8881cede7b40, ffff8881cede7f40)
The buggy address belongs to the page:
page:ffffea00073b7980 count:1 mapcount:0 mapping:ffff8881da800ac0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea0006e35e88 ffffea0006ecdf08 ffff8881da800ac0
raw: 0000000000000000 ffff8881cede6040 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected
kobject: 'tx-1' (00000000cb7aa8b1): kobject_uevent_env

Memory state around the buggy address:
  ffff8881cede7c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8881cede7d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8881cede7d80: 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                      ^
  ffff8881cede7e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881cede7e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
