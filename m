Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D05C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354F820827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354F820827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbeKHAjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:39:48 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:39476 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeKHAjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:39:48 -0500
Received: by mail-it1-f197.google.com with SMTP id r127-v6so22196516itr.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 07:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fNVyof1T1dkYeZmrzhhMrbWhULudIOEKP2ho/Kz5bZo=;
        b=dw8POFjBIT3RmdbiqMdJ7KFvTSKTxxnENsf7zfmJaVgTVPDtKtByDXYPNq3GYn7AVH
         uL9UcOEbDFENMnnZEbxcIoKmYtGkcVkw8rfDjlXTLRHVIR/N7H5lipHL6tvaZ7OP8QpU
         F4CwRFrBQLKjuAQNLjS2Ka4HhQl13sGbmmiLTJSj3lngTv1F1rqjbmWc8H9SP7Vc5Hs4
         gyPZkXPGQcoUToSsqy2NkDQG/4B8dyTA8NDhPmEh/4DJxgNec/MpgCqBumvAAZFdxJSz
         n+Dc2VB/9d8/gl92IgGFwUDDqwdjY6VVqevN3mD8htQzexBZ+j7bDkcZ86zPDmWiUgLa
         l1hQ==
X-Gm-Message-State: AGRZ1gLVKz06mCAmybduqhhnCt96apb2McXWO7DUQAj29S7tmmv35lCh
        1Mgsc/+ohDH4mCNUbKKBe5a7agupKdNc+4ZHQ61tYwTYZhjo
X-Google-Smtp-Source: AJdET5eWj+/FjaaPRjg8eNWbBVQQ9dGwYdbHf7tDPjnbvr7UWVoFuWajWBQTg6Hi4X5KLAi1kyPJ0V1pwKn19KN96TA6XXUJ/Zda
MIME-Version: 1.0
X-Received: by 2002:a24:6182:: with SMTP id s124-v6mr376099itc.16.1541603342504;
 Wed, 07 Nov 2018 07:09:02 -0800 (PST)
Date:   Wed, 07 Nov 2018 07:09:02 -0800
In-Reply-To: <000000000000da5443057a0c047e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d6000057a147f19@google.com>
Subject: Re: general protection fault in locks_remove_flock
From:   syzbot <syzbot+2400c924363a9a43d116@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=10a0102b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caa433e1c8778437
dashboard link: https://syzkaller.appspot.com/bug?extid=2400c924363a9a43d116
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b42f5b400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151777e5400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2400c924363a9a43d116@syzkaller.appspotmail.com

audit: type=1800 audit(1541602996.121:30): pid=5502 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=collect_data cause=failed(directio)  
comm="startpar" name="rmnologin" dev="sda1" ino=2423 res=0
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5657 Comm: syz-executor710 Not tainted  
4.20.0-rc1-next-20181107+ #107
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:locks_remove_flock+0x216/0x350 fs/locks.c:2567
Code: 00 0f 85 3a 01 00 00 48 8b 5b 98 48 85 db 74 3a e8 1f 41 92 ff 48 8d  
7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 17 01 00 00 48 8b 5b 08 48 85 db 74 0d e8 f2 40
RSP: 0018:ffff8801b9dc72c0 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 1ffff100373b8e89 RCX: ffffffff81ed555d
RDX: 03fffe2006e771d2 RSI: ffffffff81ed5c71 RDI: 1ffff100373b8e91
RBP: ffff8801b9dc74a0 R08: ffff8801b9dbc480 R09: ffffed003b5e5b67
R10: ffffed003b5e5b67 R11: ffff8801daf2db3b R12: ffff8801d88f9c80
R13: ffff8801b9dc7338 R14: 1ffff100373b8e5b R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002001d000 CR3: 000000000946a000 CR4: 00000000001406e0
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
RIP: 0033:0x43ede8
Code: Bad RIP value.
RSP: 002b:00007ffe7a46fe78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043ede8
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004beea8 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d1180 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace a84b3ae501385451 ]---
RIP: 0010:locks_remove_flock+0x216/0x350 fs/locks.c:2567
Code: 00 0f 85 3a 01 00 00 48 8b 5b 98 48 85 db 74 3a e8 1f 41 92 ff 48 8d  
7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 17 01 00 00 48 8b 5b 08 48 85 db 74 0d e8 f2 40
RSP: 0018:ffff8801b9dc72c0 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 1ffff100373b8e89 RCX: ffffffff81ed555d
RDX: 03fffe2006e771d2 RSI: ffffffff81ed5c71 RDI: 1ffff100373b8e91
RBP: ffff8801b9dc74a0 R08: ffff8801b9dbc480 R09: ffffed003b5e5b67
R10: ffffed003b5e5b67 R11: ffff8801daf2db3b R12: ffff8801d88f9c80
R13: ffff8801b9dc7338 R14: 1ffff100373b8e5b R15: dffffc0000000000
FS:  000000000229b880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043edbe CR3: 000000000946a000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

