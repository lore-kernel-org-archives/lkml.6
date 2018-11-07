Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72E9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 05:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7C92081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 05:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7C92081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbeKGOas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 09:30:48 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:41633 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbeKGOar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 09:30:47 -0500
Received: by mail-io1-f71.google.com with SMTP id k3-v6so17538359ioq.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 21:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1psylz23pQerXoioZdNmRPhE+lfUmg1djWJXlenyhgA=;
        b=JdmbKV6B00AtNnmvMJb327q6tox1ye19DxLgLhEdB8dPeyIqv01/+VMmg1Yo9Pd0r9
         wvZ1cNvWvS+Uv+BvXWBLDGIlrl6xZuwl0eCgyxbsyzYVAVJfxcvzLSQXOL7sjvWmJfJl
         FGKcqdzSVnLb3XIk3tKmrUhukkf6+QHbq+YOkSbhlj9W31mp1XI1VLHqTrGZ6EU3e6Ou
         N6AefuWxNQI2scwEZXB18pBljW6GPLFkDVozm4TF1MeW/UOaJPWuO6Ih0i9PwCaMH8Gh
         EtIkMNt/NWTIm7Cp93Wl/yQRLWhr3IzvuG1JggmiBxdSVgs3we6iy6A9ngPsKTZkw5pw
         n2Zw==
X-Gm-Message-State: AGRZ1gJoJUS4Gg63dbgkMTjpbZn4rcbQlKMd80D/q2T1xtTZSPHpLlXA
        HKUt8774ikxh4xIUMPCL6KseMWMYfAPxj/L2mQZ/mjGS0xH6
X-Google-Smtp-Source: AJdET5e2FU4kt/kjBnQBKXyGG0uYF8BcoNqLhOVObirmNbZaDOaJFH6G/zMSXVR1JJM8l57HA0uoKkyoDkxp/0bCAAMYq1Eg0vMU
MIME-Version: 1.0
X-Received: by 2002:a24:2795:: with SMTP id g143-v6mr429999ita.38.1541566923164;
 Tue, 06 Nov 2018 21:02:03 -0800 (PST)
Date:   Tue, 06 Nov 2018 21:02:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da5443057a0c047e@google.com>
Subject: general protection fault in locks_remove_flock
From:   syzbot <syzbot+2400c924363a9a43d116@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d881de30d29e Add linux-next specific files for 20181107
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1594d983400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caa433e1c8778437
dashboard link: https://syzkaller.appspot.com/bug?extid=2400c924363a9a43d116
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2400c924363a9a43d116@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 13218 Comm: syz-executor3 Not tainted 4.20.0-rc1-next-20181107+  
#107
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:locks_remove_flock+0x216/0x350 fs/locks.c:2567
Code: 00 0f 85 3a 01 00 00 48 8b 5b 98 48 85 db 74 3a e8 1f 41 92 ff 48 8d  
7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 17 01 00 00 48 8b 5b 08 48 85 db 74 0d e8 f2 40
RSP: 0018:ffff8801895a7880 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000041b58ab3 RCX: ffffffff81ed555d
RDX: 000000000836b157 RSI: ffffffff81ed5c71 RDI: 0000000041b58abb
RBP: ffff8801895a7a60 R08: ffff880194096140 R09: ffffed003b5c5b67
R10: ffffed003b5c5b67 R11: ffff8801dae2db3b R12: ffff8801cb266ac0
R13: ffff8801895a78f8 R14: 1ffff100312b4f13 R15: dffffc0000000000
FS:  0000000002927940(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000400200 CR3: 00000001bd0d5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  locks_remove_file+0x148/0x5c0 fs/locks.c:2607
  __fput+0x2f0/0xa70 fs/file_table.c:271
  ____fput+0x15/0x20 fs/file_table.c:312
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x411021
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffe309feb50 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000411021
RDX: 0000000000000000 RSI: 0000000000730420 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffe309fea70 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 000000000000010d R15: 0000000000000003
Modules linked in:
---[ end trace 69f886046d36502a ]---
RIP: 0010:locks_remove_flock+0x216/0x350 fs/locks.c:2567
kasan: CONFIG_KASAN_INLINE enabled
Code: 00 0f 85 3a 01 00 00 48 8b 5b 98 48 85 db 74 3a e8 1f 41 92 ff 48 8d  
7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 17 01 00 00 48 8b 5b 08 48 85 db 74 0d e8 f2 40
kasan: GPF could be caused by NULL-ptr deref or user memory access
RSP: 0018:ffff8801895a7880 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000041b58ab3 RCX: ffffffff81ed555d
kasan: CONFIG_KASAN_INLINE enabled
RDX: 000000000836b157 RSI: ffffffff81ed5c71 RDI: 0000000041b58abb
RBP: ffff8801895a7a60 R08: ffff880194096140 R09: ffffed003b5c5b67
R10: ffffed003b5c5b67 R11: ffff8801dae2db3b R12: ffff8801cb266ac0
kasan: GPF could be caused by NULL-ptr deref or user memory access
R13: ffff8801895a78f8 R14: 1ffff100312b4f13 R15: dffffc0000000000
FS:  0000000002927940(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000072c000 CR3: 00000001bd0d5000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
