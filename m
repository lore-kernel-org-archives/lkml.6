Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54B7C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E9520823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfBFFBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 00:01:06 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:34843 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfBFFBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 00:01:05 -0500
Received: by mail-it1-f200.google.com with SMTP id v188so2583391ita.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 21:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RQyiJnLv6/luNmT088fJjs9ciD6KHLAhEmRJkaaKntU=;
        b=uDiCmJPDvR0vLHzxgzwZDE1+CmHb9ODUnWanRPWj2GT/mXyuTYHMmq0xC1n0TT0YIe
         C4HXswubM64Lb/kgZZBimrY/5JftNFzzt7SfcMtnH3+a8m0a832wbCTC1YzVQ0YFiLGu
         ycH8YShPultRKnnO37qlAXC0j5Ix/i6dXK2s06IDSCbmJpv9/D8DQCdvttTIjo+PdOfJ
         AL6l3tR2HlVpQXmGqAZ6iMRv6WJiS1GV9wzfnlVP2ShUmE+9PnY/hG5MZtDMWbA/8INA
         iBQSpd7KfT44/ECJMxKmQtt1Bb1DsmTGBD7L70GgkImy5uFYxVma+TWUYZ4cQXTPhwmu
         6tlg==
X-Gm-Message-State: AHQUAuYoJ5BTWbRns89TL5fE0hOZzKhRkxhqOt0aJ+W8iUF7Xo/94V9G
        Ss8roxFovRJ8hhyA4AHpPc5AVnFHz8ussA2qjXIsfacoFwQA
X-Google-Smtp-Source: AHgI3Ibh/alEfThMDC9Z2iCguyx+sEqP9uFxxfNYrVE4FK2U7IBg0veiyIxjKfVXbo80iQKudKzeB9XMiUsMB2ypN5cH8OZ25iBv
MIME-Version: 1.0
X-Received: by 2002:a6b:a10:: with SMTP id z16mr5849422ioi.13.1549429263850;
 Tue, 05 Feb 2019 21:01:03 -0800 (PST)
Date:   Tue, 05 Feb 2019 21:01:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e063bb0581329cc0@google.com>
Subject: BUG: spinlock bad magic in __queue_work
From:   syzbot <syzbot+636bcaf4b481f6b7343c@syzkaller.appspotmail.com>
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

HEAD commit:    962c382d482a Merge tag 'mac80211-next-for-davem-2019-02-01..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=169299f8c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=33ad02b9305759c3
dashboard link: https://syzkaller.appspot.com/bug?extid=636bcaf4b481f6b7343c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+636bcaf4b481f6b7343c@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor5'.
BUG: spinlock bad magic on CPU#0, syz-executor0/1737
  lock: 0xffff8880ae82c7e0, .magic: ffffffff, .owner: %us  
workers=%d/1902867055, .owner_cpu: 0
CPU: 0 PID: 1737 Comm: syz-executor0 Not tainted 5.0.0-rc4+ #40
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  spin_dump.cold+0x81/0xe6 kernel/locking/spinlock_debug.c:67
  spin_bug kernel/locking/spinlock_debug.c:75 [inline]
  debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
  do_raw_spin_lock+0x231/0x2e0 kernel/locking/spinlock_debug.c:112
  __raw_spin_lock include/linux/spinlock_api_smp.h:143 [inline]
  _raw_spin_lock+0x37/0x40 kernel/locking/spinlock.c:144
  spin_lock include/linux/spinlock.h:329 [inline]
  __queue_work+0x23d/0x1180 kernel/workqueue.c:1417
  __queue_delayed_work+0x1d6/0x270 kernel/workqueue.c:1522
  mod_delayed_work_on+0xd8/0x200 kernel/workqueue.c:1596
  mod_delayed_work include/linux/workqueue.h:542 [inline]
  addrconf_mod_dad_work+0x3f/0xa0 net/ipv6/addrconf.c:328
  addrconf_dad_start+0x76/0xb0 net/ipv6/addrconf.c:4011
  addrconf_add_linklocal+0x28c/0x3c0 net/ipv6/addrconf.c:3190
  addrconf_addr_gen+0x34d/0x3a0 net/ipv6/addrconf.c:3313
  addrconf_dev_config+0x1ea/0x2c0 net/ipv6/addrconf.c:3356
  addrconf_notify+0x3c5/0x2280 net/ipv6/addrconf.c:3591
kobject: 'loop4' (00000000f520b29a): kobject_uevent_env
kobject: 'loop4' (00000000f520b29a): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
  notifier_call_chain+0xc7/0x240 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2e/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1739
  call_netdevice_notifiers_extack net/core/dev.c:1751 [inline]
  call_netdevice_notifiers net/core/dev.c:1765 [inline]
  dev_open net/core/dev.c:1436 [inline]
  dev_open+0x143/0x160 net/core/dev.c:1424
  ipmr_new_tunnel+0x3d3/0x4d0 net/ipv4/ipmr.c:511
  vif_add+0x1bd/0xed0 net/ipv4/ipmr.c:873
  ip_mroute_setsockopt+0xd05/0xe10 net/ipv4/ipmr.c:1453
  do_ip_setsockopt.isra.0+0x3036/0x3e00 net/ipv4/ip_sockglue.c:638
  ip_setsockopt+0x49/0x100 net/ipv4/ip_sockglue.c:1246
  raw_setsockopt+0xe0/0x100 net/ipv4/raw.c:860
  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3016
  __sys_setsockopt+0x180/0x280 net/socket.c:1902
  __do_sys_setsockopt net/socket.c:1913 [inline]
  __se_sys_setsockopt net/socket.c:1910 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1910
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457e39
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fbac2bcec78 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000457e39
RDX: 00000000000000ca RSI: 0000000000000000 RDI: 0000000000000004
RBP: 000000000073bfa0 R08: 0000000000000010 R09: 0000000000000000
R10: 0000000020000000 R11: 0000000000000246 R12: 00007fbac2bcf6d4
R13: 00000000004c5c09 R14: 00000000004da070 R15: 00000000ffffffff
netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor5'.


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
