Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46419C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1D420827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1D420827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeKGRQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 12:16:14 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:35764 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbeKGRQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 12:16:13 -0500
Received: by mail-it1-f198.google.com with SMTP id n135-v6so20645191ita.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 23:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=u+D0zw8BbzhEkjeJ6TO1ukSHyJdRE+Szb2Mhdug6DN8=;
        b=RwXjwdXGxrXrtvDb5GNmSuqOs++BC9XKl+1X44SpmnrC88MCSgYXk64MNn+iYoaKzV
         MFScnwRNOH8MmN6z9SzUZT+x8k7+re2x5TiSOSsN3YpYnqDe5+lVnmB4Tkm1vkioX9Hk
         EXQJ3iwdZxPakDxKOMLbZvx9bwsqXqj8PXxY0MSs44i2Qt3nW39hi6YZN7mypimlUNLA
         9r9gjRy/NqYbJPhwV2+6LyynIWg/HwHIlTl9CUkheqr+pvJ/3Y3F+XtP+gZHgBb3LyKi
         FFN++oXF0VPRJwlYnTjdIdGgCw2g/jH3W+7R5gZCpMcWa/IGm6UZMqxjcgmV/HLRo1t/
         R8lA==
X-Gm-Message-State: AGRZ1gIrl+uCNnlXaLcbAJH2PwMMspNS/zSIzRLzEaGyGBPuibVlJVgr
        xogGNgHaj9Zm5MpBCShv8W3o8Di+Pab6GdVHC0nIOd1QSjy8
X-Google-Smtp-Source: AJdET5c/nFDWeiKFsTdcNaANoyPyLrH6I2d4bSEiEmVhhgj7tIwGBXT9i3tW5wJ8FUYmkYKpW+ZHY6d75O/Iuu7XC+RGwWy7AobO
MIME-Version: 1.0
X-Received: by 2002:a6b:6f1a:: with SMTP id k26-v6mr438793ioc.10.1541576823106;
 Tue, 06 Nov 2018 23:47:03 -0800 (PST)
Date:   Tue, 06 Nov 2018 23:47:03 -0800
In-Reply-To: <00000000000089d2c9057a0c083a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef7751057a0e5236@google.com>
Subject: Re: general protection fault in __x86_indirect_thunk_rbx
From:   syzbot <syzbot+83e12cf81d2c14842146@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    d881de30d29e Add linux-next specific files for 20181107
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=169e9825400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caa433e1c8778437
dashboard link: https://syzkaller.appspot.com/bug?extid=83e12cf81d2c14842146
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bd9447400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1121d82b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+83e12cf81d2c14842146@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5670 Comm: syz-executor439 Not tainted  
4.20.0-rc1-next-20181107+ #107
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__x86_indirect_thunk_rbx+0x10/0x20 arch/x86/lib/retpoline.S:33
Code: 90 0f ae e8 eb f9 48 89 04 24 c3 0f 1f 44 00 00 66 2e 0f 1f 84 00 00  
00 00 00 e8 07 00 00 00 f3 90 0f ae e8 eb f9 48 89 1c 24 <c3> 0f 1f 44 00  
00 66 2e 0f 1f 84 00 00 00 00 00 e8 07 00 00 00 f3
RSP: 0018:ffff8801d89af2b0 EFLAGS: 00010293
RAX: ffff8801d49723c0 RBX: 894cdffffc000000 RCX: ffffffff81ed555d
RDX: 0000000000000000 RSI: ffffffff81ed5c9e RDI: ffff8801d89af338
RBP: ffff8801d89af4a0 R08: ffff8801d49723c0 R09: ffffed003b5e5b67
R10: ffffed003b5e5b67 R11: ffff8801daf2db3b R12: ffff8801d798da00
R13: ffff8801d89af338 R14: 1ffff1003b135e5b R15: dffffc0000000000
FS:  0000000001292880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020e2aff8 CR3: 000000000946a000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  locks_remove_file+0x148/0x5c0 fs/locks.c:2607
  __fput+0x2f0/0xa70 fs/file_table.c:271
  ____fput+0x15/0x20 fs/file_table.c:312
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1ad1/0x26d0 kernel/exit.c:867
  do_group_exit+0x177/0x440 kernel/exit.c:970
  __do_sys_exit_group kernel/exit.c:981 [inline]
  __se_sys_exit_group kernel/exit.c:979 [inline]
  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:979
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43ec48
Code: Bad RIP value.
RSP: 002b:00007fff104a8308 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043ec48
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004be508 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d0180 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace db9bef1a2174e463 ]---
RIP: 0010:__x86_indirect_thunk_rbx+0x10/0x20 arch/x86/lib/retpoline.S:33
Code: 90 0f ae e8 eb f9 48 89 04 24 c3 0f 1f 44 00 00 66 2e 0f 1f 84 00 00  
00 00 00 e8 07 00 00 00 f3 90 0f ae e8 eb f9 48 89 1c 24 <c3> 0f 1f 44 00  
00 66 2e 0f 1f 84 00 00 00 00 00 e8 07 00 00 00 f3
RSP: 0018:ffff8801d89af2b0 EFLAGS: 00010293
RAX: ffff8801d49723c0 RBX: 894cdffffc000000 RCX: ffffffff81ed555d
RDX: 0000000000000000 RSI: ffffffff81ed5c9e RDI: ffff8801d89af338
RBP: ffff8801d89af4a0 R08: ffff8801d49723c0 R09: ffffed003b5e5b67
R10: ffffed003b5e5b67 R11: ffff8801daf2db3b R12: ffff8801d798da00
R13: ffff8801d89af338 R14: 1ffff1003b135e5b R15: dffffc0000000000
FS:  0000000001292880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043ec1e CR3: 000000000946a000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

