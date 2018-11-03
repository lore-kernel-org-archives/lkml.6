Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C9FC6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 15:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEFB2082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 15:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEFB2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbeKDA7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 20:59:44 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:57646 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbeKDA7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 20:59:44 -0400
Received: by mail-it1-f198.google.com with SMTP id q7so6097724itj.7
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 08:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=baVhf6jWaxhwUZUGJ/5iqnEYWigi9vHPwOCWpgXT5lU=;
        b=gSDpbMB8AKshKQJQ7MJOV1wxaCSjbz/otILIZwkogXeBGTsyhjYKuGKSOT66vhA+tB
         0f3WLKgonWnRDHrZdkpyypKcDBmojM9L3Sb1UMlh2KdM9Nv4AXrHJ1q4sxtSGaKxI+kA
         80ncBNn/Bz1s5jgFekY3AgrFZ1Z0K+OUx8Br4Nb+xnz5dFKSnXSN65YD8dz4RWJxv7cP
         Jb4FptaRWJTgbM2eUWq7BdZnzszFelE3h8PNyvACl8n8htn9WwzaZexvbzTcKG9oNzye
         0WRfJibh/fzZZPUXc5Z43sQCvI0HJG8KzbbH2e/x6ojkIOraycbqITOICfmwtCBFmpv3
         59uw==
X-Gm-Message-State: AGRZ1gIt6/K8s28oWOmE78+zewyR9qbnHFzrjYvMAMmnCNeaMx3NjBoe
        wVjARS+8CErGdRwm6G85lKppJaKlh1NOwAb/6IG2L1LyyIe4
X-Google-Smtp-Source: AJdET5dXTeDN5zZnIi2Vd4jiPsH5oJ5bXRO9o66u5loZmmWt/Ejr08b5OfI2PzbivAizw7yMN/wry8RWzjwsskdBhwcDy5bppT9K
MIME-Version: 1.0
X-Received: by 2002:a24:e181:: with SMTP id n123-v6mr1115547ith.23.1541260083074;
 Sat, 03 Nov 2018 08:48:03 -0700 (PDT)
Date:   Sat, 03 Nov 2018 08:48:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c220960579c4936d@google.com>
Subject: general protection fault in keyctl_pkey_params_get
From:   syzbot <syzbot+a22e0dc07567662c50bc@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, jmorris@namei.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5f21585384a4 Merge tag 'for-linus-20181102' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ba246d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9384ecb1c973baed
dashboard link: https://syzkaller.appspot.com/bug?extid=a22e0dc07567662c50bc
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1026dcd5400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167e882b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a22e0dc07567662c50bc@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7247 Comm: syz-executor236 Not tainted 4.19.0+ #317
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:keyctl_pkey_params_parse security/keys/keyctl_pkey.c:56 [inline]
RIP: 0010:keyctl_pkey_params_get+0x2e7/0x550 security/keys/keyctl_pkey.c:96
Code: fe 48 8b 44 24 38 48 c1 e8 03 42 80 3c 28 00 0f 85 f7 01 00 00 4c 8b  
a4 24 e0 00 00 00 4c 89 e0 4c 89 e2 48 c1 e8 03 83 e2 07 <42> 0f b6 04 28  
38 d0 7f 08 84 c0 0f 85 e0 01 00 00 41 0f b6 04 24
RSP: 0018:ffff8801ce84faa0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8801ce84fd60 RCX: ffffffff83429990
RDX: 0000000000000000 RSI: ffffffff8342999e RDI: 0000000000000001
RBP: ffff8801ce84fc08 R08: ffff8801ce928480 R09: ffffed0039e73310
R10: ffffed0039e73310 R11: 0000000000000001 R12: 0000000000000000
R13: dffffc0000000000 R14: ffffffffffffffff R15: ffffffffffffffff
FS:  0000000001e1c880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000414cd0 CR3: 00000001ce5e6000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  keyctl_pkey_params_get_2+0x12f/0x580 security/keys/keyctl_pkey.c:130
kasan: CONFIG_KASAN_INLINE enabled
  keyctl_pkey_verify+0xaa/0x400 security/keys/keyctl_pkey.c:293
kasan: GPF could be caused by NULL-ptr deref or user memory access
  __do_sys_keyctl security/keys/keyctl.c:1768 [inline]
  __se_sys_keyctl security/keys/keyctl.c:1637 [inline]
  __x64_sys_keyctl+0x101/0x430 security/keys/keyctl.c:1637
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x444c39
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b ce fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffefdd59f88 EFLAGS: 00000286 ORIG_RAX: 00000000000000fa
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000444c39
RDX: 00000000200002c0 RSI: 00000000200000c0 RDI: 000000000000001c
RBP: 0000000000000000 R08: 0000000020000380 R09: 00000000004002e0
R10: 00000000fffffd2a R11: 0000000000000286 R12: 0000000000011956
R13: 0000000000401f80 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace e5c46bb5200c69dc ]---
general protection fault: 0000 [#2] PREEMPT SMP KASAN
RIP: 0010:keyctl_pkey_params_parse security/keys/keyctl_pkey.c:56 [inline]
RIP: 0010:keyctl_pkey_params_get+0x2e7/0x550 security/keys/keyctl_pkey.c:96
CPU: 0 PID: 7401 Comm: syz-executor236 Tainted: G      D           4.19.0+  
#317
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:keyctl_pkey_params_parse security/keys/keyctl_pkey.c:56 [inline]
RIP: 0010:keyctl_pkey_params_get+0x2e7/0x550 security/keys/keyctl_pkey.c:96
Code: fe 48 8b 44 24 38 48 c1 e8 03 42 80 3c 28 00 0f 85 f7 01 00 00 4c 8b  
a4 24 e0 00 00 00 4c 89 e0 4c 89 e2 48 c1 e8 03 83 e2 07 <42> 0f b6 04 28  
38 d0 7f 08 84 c0 0f 85 e0 01 00 00 41 0f b6 04 24
Code: fe 48 8b 44 24 38 48 c1 e8 03 42 80 3c 28 00 0f 85 f7 01 00 00 4c 8b  
a4 24 e0 00 00 00 4c 89 e0 4c 89 e2 48 c1 e8 03 83 e2 07 <42> 0f b6 04 28  
38 d0 7f 08 84 c0 0f 85 e0 01 00 00 41 0f b6 04 24
RSP: 0018:ffff8801c52cfaa0 EFLAGS: 00010246
RAX: 0000000000000002 RBX: ffff8801c52cfd60 RCX: ffffffff83429990
RDX: 0000000000000000 RSI: ffffffff8342999e RDI: 0000000000000001
RBP: ffff8801c52cfc08 R08: ffff8801b8a86000 R09: ffffed0039bb1378
R10: ffffed0039bb1378 R11: 0000000000000001 R12: 0000000000000010
R13: dffffc0000000000 R14: ffffffffffffffff R15: ffffffffffffffff
FS:  0000000001e1c880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
RSP: 0018:ffff8801ce84faa0 EFLAGS: 00010246
CR2: 0000000000414cd0 CR3: 00000001ce654000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
RAX: 0000000000000000 RBX: ffff8801ce84fd60 RCX: ffffffff83429990
  keyctl_pkey_params_get_2+0x12f/0x580 security/keys/keyctl_pkey.c:130
RDX: 0000000000000000 RSI: ffffffff8342999e RDI: 0000000000000001
  keyctl_pkey_verify+0xaa/0x400 security/keys/keyctl_pkey.c:293
RBP: ffff8801ce84fc08 R08: ffff8801ce928480 R09: ffffed0039e73310
R10: ffffed0039e73310 R11: 0000000000000001 R12: 0000000000000000
  __do_sys_keyctl security/keys/keyctl.c:1768 [inline]
  __se_sys_keyctl security/keys/keyctl.c:1637 [inline]
  __x64_sys_keyctl+0x101/0x430 security/keys/keyctl.c:1637
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
R13: dffffc0000000000 R14: ffffffffffffffff R15: ffffffffffffffff
FS:  0000000001e1c880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
RIP: 0033:0x444c39
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b ce fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffefdd59f88 EFLAGS: 00000286 ORIG_RAX: 00000000000000fa
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000444c39
RDX: 00000000200002c0 RSI: 00000000200000c0 RDI: 000000000000001c
RBP: 0000000000000000 R08: 0000000020000380 R09: 00000000004002e0
R10: 00000000fffffd2a R11: 0000000000000286 R12: 0000000000011a27
CR2: 0000000000414cd0 CR3: 00000001ce5e6000 CR4: 00000000001406e0
R13: 0000000000401f80 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace e5c46bb5200c69dd ]---
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
RIP: 0010:keyctl_pkey_params_parse security/keys/keyctl_pkey.c:56 [inline]
RIP: 0010:keyctl_pkey_params_get+0x2e7/0x550 security/keys/keyctl_pkey.c:96
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Code: fe 48 8b 44 24 38 48 c1 e8 03 42 80 3c 28 00 0f 85 f7 01 00 00 4c 8b  
a4 24 e0 00 00 00 4c 89 e0 4c 89 e2 48 c1 e8 03 83 e2 07 <42> 0f b6 04 28  
38 d0 7f 08 84 c0 0f 85 e0 01 00 00 41 0f b6 04 24


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
