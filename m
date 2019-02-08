Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AE1C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC82A20823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfBHQjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:39:32 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:52910 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfBHQjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:39:04 -0500
Received: by mail-it1-f198.google.com with SMTP id o205so7230358itc.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 08:39:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rdfd27Mkl6trWsMuQNHLC46wviuh2JA6SwxdQFFJ6x0=;
        b=saNa+PZGNgk+UJ1bDx+p6FoDELwWn8/paGOBrD9u75NPcyw6IwjXVqaL2L50psGCPU
         SAM9BwVkTHnj3RUwaXZ1lLFseiG7oPZ8Fj19Wq8Zf/lsNZskun3h9tteuYgaTzTXmObx
         KXnCjjvbXMjUNu2lzZqSF+wJAgZVGOwSAEo+GNvZbOlHqdDLUfbYyf011LcLud8S84aS
         JG00dbo3V+jK4kZBcGfxGwZ/y1dIe+KgYGZfGp4xsh1tYh0AKRWTNESRFIYINvxg0DMP
         7Jm0v0x+F6kqBW1Lv97qfev88xlTqALgrOxf3RXbpwO5KSI4TGvayy1lYf7gdMe41Ro+
         eiCQ==
X-Gm-Message-State: AHQUAub7L3s2kuSO+VjuLrSNpEnpSzl5KS9GvNhyWA2eJBp0aV3RGN4v
        4tK7o1m4N3AozMXqiVUZLOWfa9KIOTQawzAPQBlyXa55fTb9
X-Google-Smtp-Source: AHgI3IaoXjJoPo2/uGcph6yIU1D1zgEUA7Vfr+npSCvq7Kb8+0rt/R21iHyvcWjCkBjTFiH+1EeTQBWOJ4Zi1IJZp23ZJOJP7lUe
MIME-Version: 1.0
X-Received: by 2002:a02:5c8:: with SMTP id 69mr13369712jal.20.1549643943640;
 Fri, 08 Feb 2019 08:39:03 -0800 (PST)
Date:   Fri, 08 Feb 2019 08:39:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca08dd0581649889@google.com>
Subject: KASAN: wild-memory-access Write in fib6_purge_rt
From:   syzbot <syzbot+3dbea54db3674c0d57d6@syzkaller.appspotmail.com>
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

HEAD commit:    cc7335786f72 socket: fix for Add SO_TIMESTAMP[NS]_NEW
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16539260c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=33ad02b9305759c3
dashboard link: https://syzkaller.appspot.com/bug?extid=3dbea54db3674c0d57d6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3dbea54db3674c0d57d6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: wild-memory-access in atomic_dec_and_test  
include/asm-generic/atomic-instrumented.h:259 [inline]
BUG: KASAN: wild-memory-access in fib6_info_release  
include/net/ip6_fib.h:294 [inline]
BUG: KASAN: wild-memory-access in fib6_info_release  
include/net/ip6_fib.h:292 [inline]
BUG: KASAN: wild-memory-access in fib6_drop_pcpu_from  
net/ipv6/ip6_fib.c:927 [inline]
BUG: KASAN: wild-memory-access in fib6_purge_rt+0x4f6/0x670  
net/ipv6/ip6_fib.c:960
Write of size 4 at addr ff88809b5430992b by task syz-executor5/21222

CPU: 1 PID: 21222 Comm: syz-executor5 Not tainted 5.0.0-rc4+ #45
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  kasan_report.cold+0x5/0x40 mm/kasan/report.c:321
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x123/0x190 mm/kasan/generic.c:191
  kasan_check_write+0x14/0x20 mm/kasan/common.c:106
  atomic_dec_and_test include/asm-generic/atomic-instrumented.h:259 [inline]
  fib6_info_release include/net/ip6_fib.h:294 [inline]
  fib6_info_release include/net/ip6_fib.h:292 [inline]
  fib6_drop_pcpu_from net/ipv6/ip6_fib.c:927 [inline]
  fib6_purge_rt+0x4f6/0x670 net/ipv6/ip6_fib.c:960
  fib6_del_route net/ipv6/ip6_fib.c:1813 [inline]
  fib6_del+0xac2/0x10a0 net/ipv6/ip6_fib.c:1844
  fib6_clean_node+0x3a8/0x590 net/ipv6/ip6_fib.c:2006
  fib6_walk_continue+0x4b3/0x8e0 net/ipv6/ip6_fib.c:1928
  fib6_walk+0x9d/0x100 net/ipv6/ip6_fib.c:1976
  fib6_clean_tree+0xe0/0x120 net/ipv6/ip6_fib.c:2055
  __fib6_clean_all+0x118/0x2a0 net/ipv6/ip6_fib.c:2071
  fib6_clean_all+0x2b/0x40 net/ipv6/ip6_fib.c:2082
  rt6_sync_down_dev+0x134/0x150 net/ipv6/route.c:4041
  rt6_disable_ip+0x27/0x5f0 net/ipv6/route.c:4046
  addrconf_ifdown+0xa2/0x1220 net/ipv6/addrconf.c:3704
  addrconf_notify+0x5e1/0x2280 net/ipv6/addrconf.c:3629
  notifier_call_chain+0xc7/0x240 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2e/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1739
  call_netdevice_notifiers_extack net/core/dev.c:1751 [inline]
  call_netdevice_notifiers net/core/dev.c:1765 [inline]
  __dev_notify_flags+0x1e9/0x2c0 net/core/dev.c:7607
  dev_change_flags+0x10d/0x170 net/core/dev.c:7643
  devinet_ioctl+0x1396/0x1c60 net/ipv4/devinet.c:1104
  inet_ioctl+0x1fc/0x370 net/ipv4/af_inet.c:954
  sock_do_ioctl+0xe2/0x320 net/socket.c:972
  sock_ioctl+0x331/0x620 net/socket.c:1096
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457e39
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa4949bfc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457e39
RDX: 0000000020000040 RSI: 0000000000008914 RDI: 0000000000000004
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa4949c06d4
R13: 00000000004c34ff R14: 00000000004d61e8 R15: 00000000ffffffff
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
