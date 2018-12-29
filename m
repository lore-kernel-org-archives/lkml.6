Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B954C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 19:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B622087F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 19:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbeL2TLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 14:11:06 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:39397 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbeL2TLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 14:11:05 -0500
Received: by mail-io1-f69.google.com with SMTP id q23so28140497ior.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 11:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=eIuJo9BfoIpN0lYbS1eOaJ1Dq/aD4IQp8GQFjHrpNbw=;
        b=NRgNNjCE+pw7nWrnNTB3mCuGx5iOAO4CaQc8FWFFAfxyL/xIxStlI9eFcvvO5v9FM1
         ZgeqdkQIAaNX3PTTKj6khfD/RLpvc+Ad718K2yMjh/rSonOO7dcGSxffgptE+zKJheUt
         Qx5+aCLrm1Brq1wUJooc6CRpIKJ2fALBbEYHDc1swCRl3RL77EheDZlmpAx7sBqA8gsk
         NOrhvK3IftzFwX1kbvJcbaBi/Mj56FvZQA+s5J6iVzqE5RWNl3EyTWiZ6VEqpo51+Em8
         99uL8/V5FP/J4SZLvKcyZ6fgqhDVB6iudyQ/uXp11cx4vgwUrWObTQNVu5Shk8Cl+scd
         qulw==
X-Gm-Message-State: AJcUukfTRNdU4Z3kYa4Qpdm6Q7Q1UGMB7QHK+00nSYet+lNPm9f/Zjdx
        byqmEUankOSx7QHLfEq2sGAkYly6zrEcgEFUGkb5k/yTVAlj
X-Google-Smtp-Source: ALg8bN77PIap9abbe7ku8lssRAwMDsjHJYMl67WfUSGei+mgp3hZq/Yhq4O1BGzS9rRrAxKBlMEE6q3b8vl5Gqa/szK++5mly4Tu
MIME-Version: 1.0
X-Received: by 2002:a5e:8217:: with SMTP id l23mr5250808iom.18.1546110664260;
 Sat, 29 Dec 2018 11:11:04 -0800 (PST)
Date:   Sat, 29 Dec 2018 11:11:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed4120057e2df0c6@google.com>
Subject: KASAN: stack-out-of-bounds Write in ax25_getname
From:   syzbot <syzbot+6a29097222b4d3b8617c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jreuter@yaina.de, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8fe28cb58bcb Linux 4.20
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1604d02d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d581260bae0899a
dashboard link: https://syzkaller.appspot.com/bug?extid=6a29097222b4d3b8617c
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114a9ec3400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6a29097222b4d3b8617c@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: stack-out-of-bounds in memset include/linux/string.h:337  
[inline]
BUG: KASAN: stack-out-of-bounds in ax25_getname+0x58/0x790  
net/ax25/af_ax25.c:1399
Write of size 72 at addr ffff8881d8547b80 by task syz-executor0/8181

CPU: 0 PID: 8181 Comm: syz-executor0 Not tainted 4.20.0 #166
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  memset+0x23/0x40 mm/kasan/kasan.c:285
  memset include/linux/string.h:337 [inline]
  ax25_getname+0x58/0x790 net/ax25/af_ax25.c:1399
  get_raw_socket drivers/vhost/net.c:1397 [inline]
  get_socket drivers/vhost/net.c:1453 [inline]
  vhost_net_set_backend drivers/vhost/net.c:1488 [inline]
  vhost_net_ioctl+0x139c/0x1bf0 drivers/vhost/net.c:1679
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457759
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f25cd3fbc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457759
RDX: 0000000020f1dff8 RSI: 000000004008af30 RDI: 0000000000000004
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f25cd3fc6d4
R13: 00000000004c1dd4 R14: 00000000004d40e0 R15: 00000000ffffffff

The buggy address belongs to the page:
page:ffffea00076151c0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 0000000000000000 ffffffff07610101 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d8547a80: 00 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2 f2 f2
  ffff8881d8547b00: 00 f2 f2 f2 f2 f2 f2 f2 04 f2 f2 f2 f2 f2 f2 f2
> ffff8881d8547b80: 00 00 00 00 00 00 04 f2 00 00 00 00 00 00 00 00
                                      ^
  ffff8881d8547c00: 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 f2
  ffff8881d8547c80: f2 f2 f2 f2 f2 f2 00 00 00 f2 f2 f2 f2 f2 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
