Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75818C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 19:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4942086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 19:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4942086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbeKYG3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 01:29:11 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:52738 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeKYG3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 01:29:11 -0500
Received: by mail-it1-f198.google.com with SMTP id o205so18008921itc.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 11:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YJjja1VzqjsYsXigB4B4UTqDq8dl3X4n3JrRDYM9MAk=;
        b=pjyRVJQbSJleysG0Se7gUClfqarpjH03HIx+EUrgpiYqoKW/Jfw0bYyX7JF74Koie3
         9EqCJCKDsLbaEPv3gmP3zhWKQqXHs/vu/LDIdomBEAN8QIgEvvW7KRUGw2YFzmDCKfEU
         O9MXqHV+owX2kdJcvlmMBpQhtFuXWsEp6aZ66baU55/1vnXbxMtPtH66WImRoZ3V3kvL
         +14rYyFUkfcjWNkh+blZmWaeAGv9/uLLOZdvbup+sn1GoJ6MvHjC3qa13Zm5UyqEFx4F
         kEBqOQOwjSaUhV46BEZFogn/0H0bOVdUg8G1MTtGcS/TGEuGNqMvt5tFqwM1LA+GR9nD
         HCBg==
X-Gm-Message-State: AGRZ1gJC7hmxSmwiN5Ej1lKCEVv51ji7LCq+mq2B39eYWjsnN7WrUWju
        9vXkVqS+Kwj4M/3RRmjZGyJEe3j2unwJilH9o44Ul2ZbhiaR
X-Google-Smtp-Source: AJdET5cy+NLE9nqRFPWPAB0xHLk1umIoWCb/hYpT77V8bq0wL02C9c1YrBRawk7T0h6qk20yD56B+DcerVNg1ObPvSg0hcNj0WSZ
MIME-Version: 1.0
X-Received: by 2002:a24:1d0b:: with SMTP id 11-v6mr13097054itj.11.1543088403038;
 Sat, 24 Nov 2018 11:40:03 -0800 (PST)
Date:   Sat, 24 Nov 2018 11:40:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ecaa1057b6e4489@google.com>
Subject: WARNING in csum_and_copy_to_iter
From:   syzbot <syzbot+ce18da013d76d837144d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org,
        kgraul@linux.ibm.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, stranche@codeaurora.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    edeca3a769ad Merge tag 'sound-4.20-rc4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12bee26d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
dashboard link: https://syzkaller.appspot.com/bug?extid=ce18da013d76d837144d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ccd1f5400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ce18da013d76d837144d@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
WARNING: CPU: 1 PID: 7440 at lib/iov_iter.c:1443  
csum_and_copy_to_iter+0x73a/0x14f0 lib/iov_iter.c:1443
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 7440 Comm: syz-executor2 Not tainted 4.20.0-rc3+ #345
kobject: 'loop0' (00000000da2348da): kobject_uevent_env
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  panic+0x2ad/0x55c kernel/panic.c:188
kobject: 'loop0' (00000000da2348da): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
  __warn.cold.8+0x20/0x45 kernel/panic.c:540
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
WARNING: CPU: 0 PID: 7446 at lib/iov_iter.c:1443  
csum_and_copy_to_iter+0x73a/0x14f0 lib/iov_iter.c:1443
Modules linked in:
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
CPU: 0 PID: 7446 Comm: syz-executor0 Not tainted 4.20.0-rc3+ #345
RIP: 0010:csum_and_copy_to_iter+0x73a/0x14f0 lib/iov_iter.c:1443
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Code: ee fd 48 83 bd b0 fe ff ff 00 0f 84 48 fc ff ff e9 91 fe ff ff e8 e6  
6d ee fd 49 83 c4 10 31 db e9 70 fc ff ff e8 d6 6d ee fd <0f> 0b 48 c7 85  
e8 fe ff ff 00 00 00 00 e9 70 fd ff ff 4c 89 f7 e8
RIP: 0010:csum_and_copy_to_iter+0x73a/0x14f0 lib/iov_iter.c:1443
RSP: 0018:ffff8881bc80f368 EFLAGS: 00010293
Code: ee fd 48 83 bd b0 fe ff ff 00 0f 84 48 fc ff ff e9 91 fe ff ff e8 e6  
6d ee fd 49 83 c4 10 31 db e9 70 fc ff ff e8 d6 6d ee fd <0f> 0b 48 c7 85  
e8 fe ff ff 00 00 00 00 e9 70 fd ff ff 4c 89 f7 e8
RAX: ffff8881c87ca080 RBX: 000000000000038a RCX: ffffffff839116c2
RSP: 0018:ffff8881bbabf368 EFLAGS: 00010293
RDX: 0000000000000000 RSI: ffffffff83911d1a RDI: 0000000000000005
RAX: ffff8881caf18080 RBX: 000000000000038a RCX: ffffffff839116c2
RBP: ffff8881bc80f4f8 R08: ffff8881c87ca080 R09: 0000000000000006
RDX: 0000000000000000 RSI: ffffffff83911d1a RDI: 0000000000000005
R10: 0000000000000000 R11: ffff8881c87ca080 R12: 0000000000000000
RBP: ffff8881bbabf4f8 R08: ffff8881caf18080 R09: 0000000000000006
R13: 0000000000000008 R14: ffff8881bc80fa50 R15: 000000000000038a
R10: 0000000000000000 R11: ffff8881caf18080 R12: 0000000000000000
R13: 0000000000000008 R14: ffff8881bbabfa50 R15: 000000000000038a
FS:  00007fed2599c700(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004cce48 CR3: 00000001cf367000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  skb_copy_and_csum_datagram+0x1ab/0xae0 net/core/datagram.c:662
  skb_copy_and_csum_datagram+0x1ab/0xae0 net/core/datagram.c:662
  skb_copy_and_csum_datagram_msg+0x246/0x420 net/core/datagram.c:802
  udpv6_recvmsg+0xd62/0x1d80 net/ipv6/udp.c:376
  skb_copy_and_csum_datagram_msg+0x246/0x420 net/core/datagram.c:802
  udpv6_recvmsg+0xd62/0x1d80 net/ipv6/udp.c:376
  inet_recvmsg+0x181/0x6d0 net/ipv4/af_inet.c:830
  inet_recvmsg+0x181/0x6d0 net/ipv4/af_inet.c:830
  sock_recvmsg_nosec net/socket.c:794 [inline]
  sock_recvmsg+0xd0/0x110 net/socket.c:801
  sock_read_iter+0x39b/0x570 net/socket.c:878
  call_read_iter include/linux/fs.h:1851 [inline]
  generic_file_splice_read+0x5a2/0x9a0 fs/splice.c:308
  sock_recvmsg_nosec net/socket.c:794 [inline]
  sock_recvmsg+0xd0/0x110 net/socket.c:801
  sock_read_iter+0x39b/0x570 net/socket.c:878
  sock_splice_read+0xef/0x110 net/socket.c:856
  do_splice_to+0x12e/0x190 fs/splice.c:880
  call_read_iter include/linux/fs.h:1851 [inline]
  generic_file_splice_read+0x5a2/0x9a0 fs/splice.c:308
  do_splice+0x1014/0x1430 fs/splice.c:1173
  sock_splice_read+0xef/0x110 net/socket.c:856
  __do_sys_splice fs/splice.c:1414 [inline]
  __se_sys_splice fs/splice.c:1394 [inline]
  __x64_sys_splice+0x2c1/0x330 fs/splice.c:1394
  do_splice_to+0x12e/0x190 fs/splice.c:880
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  do_splice+0x1014/0x1430 fs/splice.c:1173
  __do_sys_splice fs/splice.c:1414 [inline]
  __se_sys_splice fs/splice.c:1394 [inline]
  __x64_sys_splice+0x2c1/0x330 fs/splice.c:1394
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6517086c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 0000000000457569
RDX: 0000000000000004 RSI: 0000000000000000 RDI: 0000000000000003
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RBP: 000000000072bfa0 R08: 0000000010000200 R09: 0000000000000000
RIP: 0033:0x457569
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f65170876d4
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
R13: 00000000004c5719 R14: 00000000004d8c08 R15: 00000000ffffffff
RSP: 002b:00007fed2599bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 0000000000457569
RDX: 0000000000000004 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 000000000072bfa0 R08: 0000000010000200 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fed2599c6d4
R13: 00000000004c5719 R14: 00000000004d8c08 R15: 00000000ffffffff
irq event stamp: 352
hardirqs last  enabled at (351): [<ffffffff814ad030>]  
__local_bh_enable_ip+0x160/0x260 kernel/softirq.c:194
hardirqs last disabled at (352): [<ffffffff81007ced>]  
trace_hardirqs_off_thunk+0x1a/0x1c
softirqs last  enabled at (350): [<ffffffff86aef3ab>] spin_unlock_bh  
include/linux/spinlock.h:374 [inline]
softirqs last  enabled at (350): [<ffffffff86aef3ab>]  
__skb_recv_udp+0x4ab/0xaf0 net/ipv4/udp.c:1611
softirqs last disabled at (348): [<ffffffff86aef190>] spin_lock_bh  
include/linux/spinlock.h:334 [inline]
softirqs last disabled at (348): [<ffffffff86aef190>]  
__skb_recv_udp+0x290/0xaf0 net/ipv4/udp.c:1583
---[ end trace fcfb475d82d5a575 ]---
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
