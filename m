Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70849C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE5C20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE5C20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeJ3Xvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:51:54 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:44431 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeJ3Xvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:51:53 -0400
Received: by mail-it1-f199.google.com with SMTP id r188-v6so13239433itb.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 07:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=B9fDBQruuHLiNmqCfEVJ9l7sgaBlxmPsj+VYCKb/wSE=;
        b=rU81bfvX72UxC98GjWDY/chGNgXha91VmiccvJLO1jpTq2ymklwMFDIKV6/ii042G6
         YKo30z+/3KEX2TsWFbofH8Ma6LhHHJlic9q5HqtsgfSXQYKjBJcVFFuHZSQwYn90pxDY
         LcDsESXpgX4K9aLRZJKNenrhXR9n4YaspVHktWXRFJ8WdQ3Lz03ncbILSpwUI4+04k6b
         W4XEdlMgHyGVTMzpfut9vm+VhD5ZFW+mSocCjJXaOSMLS21lw0crKdG1+4/8r8KdZqiM
         7kGgNhGDRlm1+rFi3WRGsENUlrmaHQhTf/f+LSTvnE7kQM2BCnGD6juSNgPJktd2oXdy
         dZug==
X-Gm-Message-State: AGRZ1gIpOqU3N3E620Coy0GdweffI56b+PFeJgcL4IFXJPt7LSjBEhT4
        CO/AKONRlDFsbFLjgL3BnCZytx9LZ2Ufd8tS/VcWSEdp09xN
X-Google-Smtp-Source: AJdET5ey7GTJrrxmGuW6BL0jMFT2JWuE4pIrPzkAhKzBKZWknCyeF4hxCVe18xjG/MwmVisGhr5uq5clpwQVBQEU+IrmveUOWvem
MIME-Version: 1.0
X-Received: by 2002:a24:7546:: with SMTP id y67-v6mr6842849itc.26.1540911484873;
 Tue, 30 Oct 2018 07:58:04 -0700 (PDT)
Date:   Tue, 30 Oct 2018 07:58:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b031cb05797369be@google.com>
Subject: general protection fault in put_fs_context
From:   syzbot <syzbot+cefb6ac96fc431886ec2@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b179f0826c6a Add linux-next specific files for 20181029
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1243d1c5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b2b22387bad67fc
dashboard link: https://syzkaller.appspot.com/bug?extid=cefb6ac96fc431886ec2
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14394183400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14624fc5400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cefb6ac96fc431886ec2@syzkaller.appspotmail.com

RBP: 00000000006cb018 R08: 0000000000000000 R09: 0000000000000035
R10: 0000000000000020 R11: 0000000000000246 R12: 0000000000000003
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5687 Comm: syz-executor385 Not tainted 4.19.0-next-20181029+  
#100
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:put_fs_context+0x31/0x5a0 fs/fs_context.c:487
Code: 56 41 55 41 54 53 48 89 fb 4c 8d ab 98 00 00 00 48 83 ec 18 e8 10 25  
9f ff 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 03 05 00 00 4c 8b a3 98 00 00 00 4d 85 e4 74 66
RSP: 0018:ffff8801ba447bd8 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: fffffffffffffff4 RCX: ffffffff81d99d2e
RDX: 0000000000000011 RSI: ffffffff81e04360 RDI: fffffffffffffff4
RBP: ffff8801ba447c18 R08: ffff8801d59e0680 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8801c938ac30
R13: 000000000000008c R14: ffff8801c92784c0 R15: 0000000000000000
FS:  0000000000a61880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000455210 CR3: 00000001d7169000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  do_remount fs/namespace.c:2428 [inline]
  do_mount+0xda4/0x1ff0 fs/namespace.c:3020
  ksys_mount+0x12d/0x140 fs/namespace.c:3245
  __do_sys_mount fs/namespace.c:3259 [inline]
  __se_sys_mount fs/namespace.c:3256 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3256
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440339
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe2209f3b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440339
RDX: 0000000020000180 RSI: 0000000020000080 RDI: 0000000020000040
RBP: 00000000006cb018 R08: 0000000000000000 R09: 0000000000000035
R10: 0000000000000020 R11: 0000000000000246 R12: 0000000000000003
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 9653fb4ba53c3c1b ]---
RIP: 0010:put_fs_context+0x31/0x5a0 fs/fs_context.c:487
Code: 56 41 55 41 54 53 48 89 fb 4c 8d ab 98 00 00 00 48 83 ec 18 e8 10 25  
9f ff 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 03 05 00 00 4c 8b a3 98 00 00 00 4d 85 e4 74 66
RSP: 0018:ffff8801ba447bd8 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: fffffffffffffff4 RCX: ffffffff81d99d2e
RDX: 0000000000000011 RSI: ffffffff81e04360 RDI: fffffffffffffff4
RBP: ffff8801ba447c18 R08: ffff8801d59e0680 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8801c938ac30
R13: 000000000000008c R14: ffff8801c92784c0 R15: 0000000000000000
FS:  0000000000a61880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000455210 CR3: 00000001d7169000 CR4: 00000000001406f0
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
