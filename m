Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5CEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1742082F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405905AbfBNLfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:35:04 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:58771 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395349AbfBNLfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:35:04 -0500
Received: by mail-it1-f197.google.com with SMTP id p21so9638260itb.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 03:35:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=f6Q6UUeWLpGT98uNi+C1FkezHeHrDdnakOp7zUejmtg=;
        b=m03XtmLNEgxbvfP5zFYqpBuF7dUIj3dSKPUFaVrT7cmB3cZkQZlXm3z/fU/DBcuxIy
         UNYNIi+plj70o7ctC6uZ1h2WFOKkji1Nm6lgAOYna04lGtvkM1uKWBmLlf4RJGlrhe6g
         DG1hobLitl3jXxsfQ2Fmf4UQH2jYEVy67JiwCTntCYCR6tMh0NHXS/SIYJgSN2x+HdK0
         R2VCeleENF3j4Nbpxs4peAvhKQjKFvymB4s5FlToV89otcwOEX9wrj+78BPXCrirnKeS
         11IEa9B5/hMuFZ66C39JmKU5xCjxoGn/VeC6n1fAbK5AdWFabPZW/8TxV1qWCYvmHu3g
         dwOA==
X-Gm-Message-State: AHQUAuaU73sfqmdlhDzHnVJZxbap64OW7q7TD14dhvgNl8NhUfOYAHPo
        gLt516skUwt0UnZzYDxaszCri7Hc9W9FkLHoEzIYTtfKnDaC
X-Google-Smtp-Source: AHgI3IaJlp0+wDt0CsbR7x15CvTkO+6ziJUtHS81xfIxaxlfP2DAQ3H6qh89tPjzBFu1tMS5X2nhy9Oq8FRD+OLOxrRTQHrTjRW7
MIME-Version: 1.0
X-Received: by 2002:a24:5c8f:: with SMTP id q137mr1975991itb.20.1550144103130;
 Thu, 14 Feb 2019 03:35:03 -0800 (PST)
Date:   Thu, 14 Feb 2019 03:35:03 -0800
In-Reply-To: <00000000000048c0060581d8fe23@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e34680581d90c3f@google.com>
Subject: Re: kernel BUG at drivers/android/binder_alloc.c:LINE! (2)
From:   syzbot <syzbot+55de1eb4975dec156d8f@syzkaller.appspotmail.com>
To:     arve@android.com, christian@brauner.io, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, maco@android.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    b3418f8bddf4 Add linux-next specific files for 20190214
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=161d2048c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a3a37525a677c71
dashboard link: https://syzkaller.appspot.com/bug?extid=55de1eb4975dec156d8f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cd2f1f400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+55de1eb4975dec156d8f@syzkaller.appspotmail.com

binder: 7792:7794 transaction failed 29189/-22, size 24-8 line 2994
------------[ cut here ]------------
kernel BUG at drivers/android/binder_alloc.c:1141!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7794 Comm: syz-executor.5 Not tainted 5.0.0-rc6-next-20190214  
#35
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:binder_alloc_do_buffer_copy+0xd6/0x510  
drivers/android/binder_alloc.c:1141
Code: 02 00 0f 85 20 04 00 00 4d 8b 64 24 58 49 29 dc e8 9f e1 26 fc 4c 89  
e6 4c 89 ef e8 b4 e2 26 fc 4d 39 e5 76 07 e8 8a e1 26 fc <0f> 0b e8 83 e1  
26 fc 4c 8b 75 d0 4d 29 ec 4c 89 e6 4c 89 f7 e8 91
RSP: 0018:ffff888051747558 EFLAGS: 00010293
RAX: ffff8880a55d8040 RBX: 0000000020001000 RCX: ffffffff8549806c
RDX: 0000000000000000 RSI: ffffffff85498076 RDI: 0000000000000006
RBP: ffff8880517475d8 R08: ffff8880a55d8040 R09: 0000000000000028
R10: ffffed100a2e8f01 R11: ffff88805174780f R12: 0000000000000020
R13: 0000000000000028 R14: ffff888096952b50 R15: 0000000000000000
FS:  00007f526c1e3700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f526c1a0db8 CR3: 0000000032547000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  binder_alloc_copy_from_buffer+0x37/0x42 drivers/android/binder_alloc.c:1187
  binder_get_object+0xa2/0x1e0 drivers/android/binder.c:2062
  binder_transaction+0x2b4a/0x6690 drivers/android/binder.c:3231
  binder_thread_write+0x64a/0x2820 drivers/android/binder.c:3792
  binder_ioctl_write_read drivers/android/binder.c:4825 [inline]
  binder_ioctl+0x1033/0x183b drivers/android/binder.c:5002
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457e29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f526c1e2c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457e29
RDX: 0000000020000000 RSI: 00000000c0306201 RDI: 0000000000000006
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f526c1e36d4
R13: 00000000004bf15b R14: 00000000004d0a60 R15: 00000000ffffffff
Modules linked in:
---[ end trace f34ec74539dae8b5 ]---
RIP: 0010:binder_alloc_do_buffer_copy+0xd6/0x510  
drivers/android/binder_alloc.c:1141
Code: 02 00 0f 85 20 04 00 00 4d 8b 64 24 58 49 29 dc e8 9f e1 26 fc 4c 89  
e6 4c 89 ef e8 b4 e2 26 fc 4d 39 e5 76 07 e8 8a e1 26 fc <0f> 0b e8 83 e1  
26 fc 4c 8b 75 d0 4d 29 ec 4c 89 e6 4c 89 f7 e8 91
RSP: 0018:ffff888051747558 EFLAGS: 00010293
RAX: ffff8880a55d8040 RBX: 0000000020001000 RCX: ffffffff8549806c
RDX: 0000000000000000 RSI: ffffffff85498076 RDI: 0000000000000006
RBP: ffff8880517475d8 R08: ffff8880a55d8040 R09: 0000000000000028
R10: ffffed100a2e8f01 R11: ffff88805174780f R12: 0000000000000020
R13: 0000000000000028 R14: ffff888096952b50 R15: 0000000000000000
FS:  00007f526c1e3700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 0000000032547000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

