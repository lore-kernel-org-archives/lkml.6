Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F84C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB30218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbfBOFiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 00:38:04 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:35397 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfBOFiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 00:38:03 -0500
Received: by mail-it1-f200.google.com with SMTP id m84so14162758ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 21:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=PH9nyTMYBQZNOir4xGhq58o9+KJcTHpKoCsxZy/OQrg=;
        b=jGfiyEfQPRxSNbh6whJjwIm1pTo2uCb0JseQMDu/GFQx/bVbLhk9lfZlkqqs3XK6/B
         ylUZnuLkZvWxJagZrBFYdQ9BgJAdGs7wxL7lZp97N0Zd3KrjqpvNqVnO9hXUgoQ3qsvW
         rgcpPcLFX2rxg6DphlufKEE88IGzES9CJiJYroYMnOynw11zeFjJ8RMjqAMpAfBwrqaP
         GqNJTKcevoEkamr+Fu/5YsEVgQNsEYcb2qpXdtylIw3mqXdq/hmJxnCxRU+l2XuopCmc
         E2sBtYuObfNUrWyDRx82EX13FTtEPByqVqQo/pB95hYr52qM2/TSOgf3h8mdjwTbqtDt
         9J8A==
X-Gm-Message-State: AHQUAuY7JuAGGKY24k0FH+gS5WkEjl/9SUuEONvBDPVChdM51v5vDfe/
        sydo4p9Gwi/23bmc6TRUpDC8kcm2ZlCmF9LyWDYF0Z94r8Vz
X-Google-Smtp-Source: AHgI3IYd2oC/c0caiXGdeXaOox7w3b5IRJ9npkqjCoMNq4d0LfydsOdzVQ8JQFicdDBMAhei49VSO/9Akd931lGbFlE05ZnLalL2
MIME-Version: 1.0
X-Received: by 2002:a6b:ce18:: with SMTP id p24mr5579695iob.33.1550209082760;
 Thu, 14 Feb 2019 21:38:02 -0800 (PST)
Date:   Thu, 14 Feb 2019 21:38:02 -0800
In-Reply-To: <00000000000048c0060581d8fe23@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4a7670581e82de5@google.com>
Subject: Re: kernel BUG at drivers/android/binder_alloc.c:LINE! (2)
From:   syzbot <syzbot+55de1eb4975dec156d8f@syzkaller.appspotmail.com>
To:     arve@android.com, christian@brauner.io, devel@driverdev.osuosl.org,
        dvyukov@google.com, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, maco@android.com, maco@google.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com,
        tkjos@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    b3418f8bddf4 Add linux-next specific files for 20190214
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12ccad60c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a3a37525a677c71
dashboard link: https://syzkaller.appspot.com/bug?extid=55de1eb4975dec156d8f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f63047400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a2ed58c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+55de1eb4975dec156d8f@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at drivers/android/binder_alloc.c:1141!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7540 Comm: syz-executor013 Not tainted 5.0.0-rc6-next-20190214  
#35
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:binder_alloc_do_buffer_copy+0xd6/0x510  
drivers/android/binder_alloc.c:1141
Code: 02 00 0f 85 20 04 00 00 4d 8b 64 24 58 49 29 dc e8 9f e1 26 fc 4c 89  
e6 4c 89 ef e8 b4 e2 26 fc 4d 39 e5 76 07 e8 8a e1 26 fc <0f> 0b e8 83 e1  
26 fc 4c 8b 75 d0 4d 29 ec 4c 89 e6 4c 89 f7 e8 91
RSP: 0018:ffff88804a6cf558 EFLAGS: 00010293
RAX: ffff888033dc61c0 RBX: 0000000020001000 RCX: ffffffff8549806c
RDX: 0000000000000000 RSI: ffffffff85498076 RDI: 0000000000000006
RBP: ffff88804a6cf5d8 R08: ffff888033dc61c0 R09: 0000000000000028
R10: ffffed10094d9f01 R11: ffff88804a6cf80f R12: 0000000000000008
R13: 0000000000000028 R14: ffff888069c1c210 R15: 0000000000000000
FS:  00000000017d9940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000007b49a000 CR4: 00000000001406f0
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
RIP: 0033:0x444579
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff3621c708 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fff3621c710 RCX: 0000000000444579
RDX: 0000000020000440 RSI: 00000000c0306201 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000401000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402280
R13: 0000000000402310 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace e53003f51f970669 ]---
RIP: 0010:binder_alloc_do_buffer_copy+0xd6/0x510  
drivers/android/binder_alloc.c:1141
Code: 02 00 0f 85 20 04 00 00 4d 8b 64 24 58 49 29 dc e8 9f e1 26 fc 4c 89  
e6 4c 89 ef e8 b4 e2 26 fc 4d 39 e5 76 07 e8 8a e1 26 fc <0f> 0b e8 83 e1  
26 fc 4c 8b 75 d0 4d 29 ec 4c 89 e6 4c 89 f7 e8 91
RSP: 0018:ffff88804a6cf558 EFLAGS: 00010293
RAX: ffff888033dc61c0 RBX: 0000000020001000 RCX: ffffffff8549806c
RDX: 0000000000000000 RSI: ffffffff85498076 RDI: 0000000000000006
RBP: ffff88804a6cf5d8 R08: ffff888033dc61c0 R09: 0000000000000028
R10: ffffed10094d9f01 R11: ffff88804a6cf80f R12: 0000000000000008
R13: 0000000000000028 R14: ffff888069c1c210 R15: 0000000000000000
FS:  00000000017d9940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000007b49a000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

