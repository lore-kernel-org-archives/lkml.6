Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74058ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 13:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F56208E0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 13:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F56208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeGOOMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 10:12:06 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:33060 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeGOOMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 10:12:05 -0400
Received: by mail-io0-f197.google.com with SMTP id s14-v6so15042633ioc.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 06:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0czfpOZXCDAKUkuqvl9skZEsWnbHg4ltZsl3g+hhSQU=;
        b=rqtAd0gyJbWbS5nDKEFo6GgqkS3OITQm56qUkOjQego/h2lGXJ7PtqyWMQhzfMaZ7p
         8vTC0JSvwUgPdtKqPX8uDK4EXxasuDqFfjOCl6dZ6DreGwhDROYVlQtTLzOCVi+YAa44
         +ML9nKkwv/qFsqM5nyYX6ghjoh2V1xjWkvql8zqU6moetWuAzWHDjBdpt0gzt2Ccj2UV
         5q93nhlAfCAYmMh1EjiIButjlzdIAVvqgtXnLwaKl/riUP4xBRNtEgTpghW1/QULQIQv
         5yQQ5jlrsl+sNqBXFnICfwE33eRQYnHwDnUTRVQwaxQVBvE922w21FaA+J7hNg6GfLTX
         E1PA==
X-Gm-Message-State: AOUpUlFpJuuYsDmYSpcWYSyr0AsdUmJdSqDEo3jJ5fwtY6HWzFx6tSBZ
        Bw51PdQuw8UXFRczX9igKe++ZESXPNE2g8g1AQpfjZH2eQcE
X-Google-Smtp-Source: AAOMgpc/vTqtXNcXlmYKvVmtJobb/3JKyVWzgNaRoGt0u8u7D13akNScGGXL3SLUF6MBqZUxFMMjxg/tktv67Hyy7iSiNbqAn68x
MIME-Version: 1.0
X-Received: by 2002:a24:ca:: with SMTP id 193-v6mr5452034ita.45.1531662543754;
 Sun, 15 Jul 2018 06:49:03 -0700 (PDT)
Date:   Sun, 15 Jul 2018 06:49:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d62689057109f9b4@google.com>
Subject: general protection fault in smc_ioctl (2)
From:   syzbot <syzbot+35b2c5aa76fd398b9fd4@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, ubraun@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9cee8c437543 net: mvpp2: mvpp2_cls_flow_get() can be static
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12807b70400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89129667b46496c3
dashboard link: https://syzkaller.appspot.com/bug?extid=35b2c5aa76fd398b9fd4
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=14e9cf0c400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136325d0400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+35b2c5aa76fd398b9fd4@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 4516 Comm: syz-executor129 Not tainted 4.18.0-rc3+ #121
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:smc_ioctl+0x846/0xd00 net/smc/af_smc.c:1748
Code: 48 c1 e9 03 80 3c 11 00 0f 85 29 04 00 00 4d 8b b6 a0 04 00 00 48 ba  
00 00 00 00 00 fc ff df 49 8d 7e 20 48 89 f9 48 c1 e9 03 <0f> b6 14 11 84  
d2 74 09 80 fa 03 0f 8e 65 03 00 00 48 8d 7b 02 41
RSP: 0018:ffff8801b258f750 EFLAGS: 00010202
RAX: ffff8801b258f7c8 RBX: ffff8801b258f788 RCX: 0000000000000004
RDX: dffffc0000000000 RSI: 1ffff100364b1ef9 RDI: 0000000000000020
RBP: ffff8801b258f9b0 R08: ffffed00364b1efa R09: ffffed00364b1ef9
R10: ffffed00364b1ef9 R11: ffff8801b258f7cf R12: 1ffff100364b1eed
R13: 0000000020000040 R14: 0000000000000000 R15: 1ffff100364b1f11
FS:  00007fdddb23c700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdddb21ae78 CR3: 00000001b6c9a000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  sock_do_ioctl+0xe4/0x3e0 net/socket.c:969
  sock_ioctl+0x30d/0x680 net/socket.c:1093
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445e89
Code: e8 7c e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb 0c fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fdddb23bdb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dbc3c RCX: 0000000000445e89
RDX: 0000000020000040 RSI: 0000000000008905 RDI: 000000000000006d
RBP: 00000000006dbc38 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe54550fbf R14: 00007fdddb23c9c0 R15: 0000000000000004
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 924422afa249de86 ]---
RIP: 0010:smc_ioctl+0x846/0xd00 net/smc/af_smc.c:1748
Code: 48 c1 e9 03 80 3c 11 00 0f 85 29 04 00 00 4d 8b b6 a0 04 00 00 48 ba  
00 00 00 00 00 fc ff df 49 8d 7e 20 48 89 f9 48 c1 e9 03 <0f> b6 14 11 84  
d2 74 09 80 fa 03 0f 8e 65 03 00 00 48 8d 7b 02 41
RSP: 0018:ffff8801b258f750 EFLAGS: 00010202
RAX: ffff8801b258f7c8 RBX: ffff8801b258f788 RCX: 0000000000000004
RDX: dffffc0000000000 RSI: 1ffff100364b1ef9 RDI: 0000000000000020
RBP: ffff8801b258f9b0 R08: ffffed00364b1efa R09: ffffed00364b1ef9
R10: ffffed00364b1ef9 R11: ffff8801b258f7cf R12: 1ffff100364b1eed
R13: 0000000020000040 R14: 0000000000000000 R15: 1ffff100364b1f11
FS:  00007fdddb23c700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdddb21ae78 CR3: 00000001b6c9a000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
