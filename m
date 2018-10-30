Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607F5C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8652080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8652080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbeJaEWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:22:52 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:44601 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeJaEWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:22:51 -0400
Received: by mail-it1-f200.google.com with SMTP id r188-v6so14061516itb.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 12:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Wz4XpiFGNP9Kg01Ks7YSi1d2XiL6stRYIyvDUvgc50M=;
        b=XbUs3riz+B/BY6paz97e6zQdgSU6tX5s2CeABOoRk6yCwLITgrzGFPqplPnd6FDql7
         uegomEnHW/nRw5gg2OTmmkx3DV+nxflub0hUaBeil2sljEt8JOrf72KZt2tE3gBhSMTH
         w68o7MWI56M5RVovs4QxD63nVxzjBhi/wVcZH+M9gbh6q+ZfUiJLNrnnv8+XYx6P1mKu
         NNptdwbaZpNAyrBbHniP3ZGOm8Amc9vpT+gq/qtRKB8Cxx0wWygqfPBI0n3cu2aYGPXL
         fA5G/GIF7dzugAoo2DuQ2JwAqBkx1S4eMWUi1odXzVjQaxczp1QSvnPgrFHIY1a6gIK3
         3dVA==
X-Gm-Message-State: AGRZ1gIsbOwNOlijpZlmphp8RIjpRI3RaEikoUc6CP0XafGgN14+pcU/
        o2kPOaRyDZs4dsaVaWaRFAkUwpQVlkM/YZWYDj5YP4BoQi0H
X-Google-Smtp-Source: AJdET5frWL305cPC3BrQT4Rwkp7U5LGHeH8Pgrorhkv561VFaWXIxRG7UyuM512YVh2Bzq6JcPzs+TpY1hUWiYLHoceg3fB3stYa
MIME-Version: 1.0
X-Received: by 2002:a5e:9805:: with SMTP id s5-v6mr1621ioj.19.1540927684098;
 Tue, 30 Oct 2018 12:28:04 -0700 (PDT)
Date:   Tue, 30 Oct 2018 12:28:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c6b7b0579772ff3@google.com>
Subject: WARNING in rds_message_alloc_sgs
From:   syzbot <syzbot+26de17458aeda9d305d8@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, santosh.shilimkar@oracle.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6201f31a39f8 Add linux-next specific files for 20181030
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1397d06d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a22859d870756c1
dashboard link: https://syzkaller.appspot.com/bug?extid=26de17458aeda9d305d8
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bb52eb400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118bdfc5400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+26de17458aeda9d305d8@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 19789 at net/rds/message.c:316  
rds_message_alloc_sgs+0x10c/0x160 net/rds/message.c:316
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 19789 Comm: syz-executor827 Not tainted 4.19.0-next-20181030+  
#101
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  panic+0x2ad/0x55c kernel/panic.c:188
  __warn.cold.8+0x20/0x45 kernel/panic.c:540
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
RIP: 0010:rds_message_alloc_sgs+0x10c/0x160 net/rds/message.c:316
Code: c0 74 04 3c 03 7e 6c 44 01 ab 78 01 00 00 e8 2b 9e 35 fa 4c 89 e0 48  
83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 14 9e 35 fa <0f> 0b 31 ff 44  
89 ee e8 18 9f 35 fa 45 85 ed 75 1b e8 fe 9d 35 fa
RSP: 0018:ffff8801c51b7460 EFLAGS: 00010293
RAX: ffff8801bc412080 RBX: ffff8801d7bf4040 RCX: ffffffff8749c9e6
RDX: 0000000000000000 RSI: ffffffff8749ca5c RDI: 0000000000000004
RBP: ffff8801c51b7490 R08: ffff8801bc412080 R09: ffffed003b5c5b67
R10: ffffed003b5c5b67 R11: ffff8801dae2db3b R12: 0000000000000000
R13: 000000000007165c R14: 000000000007165c R15: 0000000000000005
  rds_cmsg_rdma_args+0x82d/0x1510 net/rds/rdma.c:623
  rds_cmsg_send net/rds/send.c:971 [inline]
  rds_sendmsg+0x19a2/0x3180 net/rds/send.c:1273
  sock_sendmsg_nosec net/socket.c:622 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:632
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2117
  __sys_sendmsg+0x11d/0x280 net/socket.c:2155
  __do_sys_sendmsg net/socket.c:2164 [inline]
  __se_sys_sendmsg net/socket.c:2162 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2162
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44a859
Code: e8 dc e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 6b cb fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1d4710ada8 EFLAGS: 00000297 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000006dcc28 RCX: 000000000044a859
RDX: 0000000000000000 RSI: 0000000020001600 RDI: 0000000000000003
RBP: 00000000006dcc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000297 R12: 00000000006dcc2c
R13: 646e732f7665642f R14: 00007f1d4710b9c0 R15: 00000000006dcd2c
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
