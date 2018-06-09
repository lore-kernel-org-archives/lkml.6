Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SbvCJPlYHFsjXQAAmS7hNA
	; Sat, 09 Jun 2018 22:47:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9A96A608B8; Sat,  9 Jun 2018 22:47:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,FROM_LOCAL_HEX,
	MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F1CE46074D;
	Sat,  9 Jun 2018 22:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F1CE46074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753518AbeFIWrX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 18:47:23 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:42167 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753469AbeFIWrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 18:47:04 -0400
Received: by mail-it0-f71.google.com with SMTP id c7-v6so5618794itd.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 15:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kkE202dLhbqL4s/fyvznOw4wczslpgD/QAqeiel40dA=;
        b=hmJPm5ws1DuRH/LkNa2P9MXqD2vMf8YC1vy4MCkLaqp1XSCjI61X4WJJpTR6UdMvLA
         zlGgEbwLww+MdEIptroh6PSNONwBSnohnv4l74SWvKaIWUzQgwY92RS5C2LgPsbZkFeP
         9aNZ+70zPm6TiuYUlYRzFcBvPgcuRmLKtdGuLfr43l1+rhPcS452ayAfYLAupscBF0In
         WJ/VL9SXYmZQrWX4TTWSOppE3N3G596ILqkXCCdPyJl+2WkPFrc7QEWOAEPaODyuqPmF
         PoTgkTMfhuVOVDZHOlkOE9CD2jZcMbY3ha9w3y6q4SnqsMPh2qGSAm7me/Ydr1u5MGNW
         JL+Q==
X-Gm-Message-State: APt69E0+wV1EwSBffaSDG39hIiYBiUr5kz5CPVxxznuYT5a13HZQWktF
        OEYebLSxlY1Q7Z7ha39ainDBxkpb+vca4FccpV3Fg4MNdasY
X-Google-Smtp-Source: ADUXVKKnUxcsrU5AF+n5E6FjbIF6TA/54pnSgDHmFZm8VuE2nL/ltLnZIY8o3lME67ToU0vN2tSGp9H0wN+42d8MwchThwS4ueUv
MIME-Version: 1.0
X-Received: by 2002:a24:c002:: with SMTP id u2-v6mr5677551itf.22.1528584423528;
 Sat, 09 Jun 2018 15:47:03 -0700 (PDT)
Date: Sat, 09 Jun 2018 15:47:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000092de58056e3d4b96@google.com>
Subject: WARNING: kmalloc bug in xdp_umem_create
From: syzbot <syzbot+4abadc5d69117b346506@syzkaller.appspotmail.com>
To: bjorn.topel@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, magnus.karlsson@intel.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7d3bf613e99a Merge tag 'libnvdimm-for-4.18' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1073f68f800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f04d8d0a2afb789a
dashboard link: https://syzkaller.appspot.com/bug?extid=4abadc5d69117b346506
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=13c9756f800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16366f9f800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4abadc5d69117b346506@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
WARNING: CPU: 1 PID: 4537 at mm/slab_common.c:996 kmalloc_slab+0x56/0x70  
mm/slab_common.c:996
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 4537 Comm: syz-executor849 Not tainted 4.17.0+ #92
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  panic+0x22f/0x4de kernel/panic.c:184
  __warn.cold.8+0x163/0x1b3 kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:kmalloc_slab+0x56/0x70 mm/slab_common.c:996
Code: c5 c0 ca d0 88 5d c3 b8 10 00 00 00 48 85 ff 74 f4 83 ef 01 c1 ef 03  
0f b6 87 e0 c9 d0 88 eb d8 31 c0 81 e6 00 02 00 00 75 db <0f> 0b 5d c3 48  
8b 04 c5 00 ca d0 88 5d c3 66 90 66 2e 0f 1f 84 00
RSP: 0018:ffff8801acc67998 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff877abea2
RDX: 1ffff10035e17ce3 RSI: 0000000000000000 RDI: 0000000001000010
RBP: ffff8801acc67998 R08: ffff8801d91d82c0 R09: ffffed0035e17cd9
R10: ffffed0035e17cd9 R11: ffff8801af0be6cb R12: dffffc0000000000
R13: 0000000020000000 R14: ffff8801af0be6b0 R15: 00000000006080c0
  __do_kmalloc mm/slab.c:3713 [inline]
  __kmalloc+0x25/0x760 mm/slab.c:3727
  kmalloc_array include/linux/slab.h:634 [inline]
  kcalloc include/linux/slab.h:645 [inline]
  xdp_umem_pin_pages net/xdp/xdp_umem.c:205 [inline]
  xdp_umem_reg net/xdp/xdp_umem.c:318 [inline]
  xdp_umem_create+0x5c9/0x10f0 net/xdp/xdp_umem.c:349
  xsk_setsockopt+0x443/0x550 net/xdp/xsk.c:531
  __sys_setsockopt+0x1bd/0x390 net/socket.c:1935
  __do_sys_setsockopt net/socket.c:1946 [inline]
  __se_sys_setsockopt net/socket.c:1943 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1943
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43fce9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 6b 45 00 00 c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffedcafaac8 EFLAGS: 00000213 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fce9
RDX: 0000000000000004 RSI: 000000000000011b RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000018 R09: 00000000004002c8
R10: 0000000020000040 R11: 0000000000000213 R12: 0000000000401610
R13: 00000000004016a0 R14: 0000000000000000 R15: 0000000000000000
Dumping ftrace buffer:
    (ftrace buffer empty)
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
