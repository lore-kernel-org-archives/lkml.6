Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE58C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830132086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393563AbfBMR4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:56:23 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:44734 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393536AbfBMR4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:56:06 -0500
Received: by mail-it1-f198.google.com with SMTP id h6so3811931itk.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 09:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/8dKhXsiQ2QkfYGqoxIii4R2uRHURx43YRUX02sWWZk=;
        b=WFEXE9IuYHPTiiHKn33Vz1WRwxAwIo/OBbkC2TOo+pmYmruPRNpON1X9CQW3YxaT1m
         EarkGJnivZMbNpUGRryCsn0LH66eadDTVM5bmilTHqcV5toLDwyeW7vrOc+8NA2Fzrxc
         FWlOCO8zYzmvgeHcAuR3p0WMG39mXdjO6n8Fc2NQ6TzdMT38ysWhjpzQ1Bp3obgg3gZp
         m9S9AUnZEJ04wuFV056b/FKCVbsx1h/iZfBzcK3O32CuMvCRCj5IqGgd/9e6bO68Hqy+
         eKh7s88ToKyWOfvkIvj9W0tXhw0L8xS+UCh4bPqy4G041P64ngcDfSmVsYIJ/Mh2Gox7
         Jo6w==
X-Gm-Message-State: AHQUAuZ6rLHfK6Om14d2EhQ+VGbPGX7/uESJ0sKbt06JA1aGW6RLAU06
        U1RBkKIQYnDGcuLGd6wOesaVeb0Zw+STHcGrGQJDjJQZzKyA
X-Google-Smtp-Source: AHgI3IZ58U73cYGoyRWtDlQp14fvqHk0IOmOOSUycwlw16eqtYk8jP+v5iEZj1KsxwiWKf+32AVJfCouWkbeNDUNAzUY1c8ybOx6
MIME-Version: 1.0
X-Received: by 2002:a02:89cc:: with SMTP id e12mr1107363jak.15.1550080564169;
 Wed, 13 Feb 2019 09:56:04 -0800 (PST)
Date:   Wed, 13 Feb 2019 09:56:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006694750581ca4139@google.com>
Subject: general protection fault in tc_ctl_chain
From:   syzbot <syzbot+eff9cae063e4b633c6c1@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bd3606c29fcc rocker: Remove port_attr_bridge_flags_get ass..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=121bbf87400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8572a6e4661225f4
dashboard link: https://syzkaller.appspot.com/bug?extid=eff9cae063e4b633c6c1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cbd404c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fc80d4c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+eff9cae063e4b633c6c1@syzkaller.appspotmail.com

audit: type=1800 audit(1550028783.638:30): pid=7517 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=collect_data cause=failed(directio)  
comm="startpar" name="rmnologin" dev="sda1" ino=2423 res=0
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7669 Comm: syz-executor789 Not tainted 5.0.0-rc5+ #60
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__lock_acquire+0x8df/0x4700 kernel/locking/lockdep.c:3215
Code: 28 00 00 00 0f 85 35 27 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f  
85 dc 27 00 00 49 81 3c 24 20 45 9a 89 0f 84 03 f8
RSP: 0018:ffff88808b44f180 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 000000000000000c RSI: 0000000000000000 RDI: 0000000000000060
RBP: ffff88808b44f350 R08: 0000000000000001 R09: 0000000000000001
R10: ffff88808b44f570 R11: 0000000000000001 R12: 0000000000000060
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880915d4680
FS:  0000000001ef6880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 0000000093549000 CR4: 00000000001406f0
Call Trace:
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3841
  __mutex_lock_common kernel/locking/mutex.c:925 [inline]
  __mutex_lock+0xf7/0x1310 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  tc_ctl_chain+0x42f/0x11a0 net/sched/cls_api.c:2812
  rtnetlink_rcv_msg+0x465/0xb00 net/core/rtnetlink.c:5192
  netlink_rcv_skb+0x17a/0x460 net/netlink/af_netlink.c:2485
  rtnetlink_rcv+0x1d/0x30 net/core/rtnetlink.c:5210
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x536/0x720 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0x8ae/0xd70 net/netlink/af_netlink.c:1925
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:631
  ___sys_sendmsg+0x806/0x930 net/socket.c:2136
  __sys_sendmsg+0x105/0x1d0 net/socket.c:2174
  __do_sys_sendmsg net/socket.c:2183 [inline]
  __se_sys_sendmsg net/socket.c:2181 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2181
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4400d9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd09281608 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004400d9
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401960
R13: 00000000004019f0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 25ab48d993ef9249 ]---
RIP: 0010:__lock_acquire+0x8df/0x4700 kernel/locking/lockdep.c:3215
Code: 28 00 00 00 0f 85 35 27 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f  
85 dc 27 00 00 49 81 3c 24 20 45 9a 89 0f 84 03 f8
RSP: 0018:ffff88808b44f180 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 000000000000000c RSI: 0000000000000000 RDI: 0000000000000060
RBP: ffff88808b44f350 R08: 0000000000000001 R09: 0000000000000001
R10: ffff88808b44f570 R11: 0000000000000001 R12: 0000000000000060
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880915d4680
FS:  0000000001ef6880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 0000000093549000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
