Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EBFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D954220659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfANHTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 02:19:04 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:36577 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfANHTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 02:19:04 -0500
Received: by mail-io1-f71.google.com with SMTP id t13so19703718ioi.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 23:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=E3i1OHlh3FuBRHu6dQqrti8s7A52SihF2IEzLYbtH9g=;
        b=Sjhy5vhhAezWHtp59dGn17TTPTMRoKqj9C1fJpCkbmHDAx38yupN7kjNw7XbvKWsZN
         sgGVyMke7Ie9CaXRv2u4ADEYmdmBZfkrMpNVCYy+BXlm522yGv3Euby4yX2xq6x7oyuG
         kBOHNh1yPZxYVZbIPBJL3MqwWEl7KViKJi7gWChZ09uCmqPgAoH6yxSXnHX97dv14GV9
         /MLSBUDjXtO+hIFBdgBq/yQhMsxhJIj6hNHcpWC7Z7YQNV6R97yIyROhqdy0H0ECyAms
         0eaUucoxj+00txKhDaE8oitNEk6KcJ3layAzjsF1kYR9oCL/4goVg7pvmAt2u+V8YYXY
         hf4Q==
X-Gm-Message-State: AJcUukeRiDd/V08qKeshGeOWCjAOHerB57B6bPHZgByRc9O3MKujlE9A
        6MqQzLL5VEeOk3YZWKvjlyV65cejSgnm+U95sVfUyxrjthNa
X-Google-Smtp-Source: ALg8bN5PwvjRvx5GiBH6BS8aUT8z4dM/mBn9sNYW8oaabKYz4Wz37vFF3ozkERxgJOBVzAI9ZCfIHTFYwzJc4HsZNGpweEiTTleb
MIME-Version: 1.0
X-Received: by 2002:a05:660c:4e:: with SMTP id p14mr8038284itk.31.1547450343342;
 Sun, 13 Jan 2019 23:19:03 -0800 (PST)
Date:   Sun, 13 Jan 2019 23:19:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005cc6a057f65dcea@google.com>
Subject: general protection fault in crypto_remove_spawns (2)
From:   syzbot <syzbot+ee4f315443a4ea97512e@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    4b3c31c8d4dd Merge branch 'i2c/for-current' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144cb817400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b05cfdb4ee8ab9b2
dashboard link: https://syzkaller.appspot.com/bug?extid=ee4f315443a4ea97512e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ee4f315443a4ea97512e@syzkaller.appspotmail.com

binder: 18706:18709 ioctl 40046207 0 returned -16
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 18713 Comm: cryptomgr_test Not tainted 5.0.0-rc1+ #21
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:crypto_remove_spawns+0x7ac/0x1340 crypto/algapi.c:194
Code: 49 8d 7c 24 10 48 89 f8 48 c1 e8 03 80 3c 18 00 0f 85 f2 06 00 00 49  
c7 44 24 10 00 00 00 00 4d 8d 66 10 4c 89 e0 48 c1 e8 03 <80> 3c 18 00 0f  
85 ef 06 00 00 49 83 7e 10 00 74 0a e8 4e 9e 24 fe
RSP: 0000:ffff888054737b88 EFLAGS: 00010202
RAX: 0000000000000002 RBX: dffffc0000000000 RCX: 1ffff1100a8e6f86
RDX: 0000000000000000 RSI: ffffffff835d58d2 RDI: ffff888085c226b8
RBP: ffff888054737df8 R08: ffff88804fb4e4c0 R09: ffff88804fb4ed60
R10: ffff88804fb4ed40 R11: 0000000000000001 R12: 0000000000000010
R13: ffffed100a8e6f8e R14: 0000000000000000 R15: ffff888054737dd0
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6091a29000 CR3: 00000000876f9000 CR4: 00000000001406e0
kobject: 'loop2' (00000000d1d42c09): kobject_uevent_env
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
kobject: 'loop2' (00000000d1d42c09): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
  crypto_alg_tested+0x52d/0x790 crypto/algapi.c:339
  cryptomgr_test+0x18/0x30 crypto/algboss.c:226
  kthread+0x357/0x430 kernel/kthread.c:246
binder: BINDER_SET_CONTEXT_MGR already set
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
kobject: 'loop3' (0000000091226001): kobject_uevent_env
binder: 18723:18724 ioctl 40046207 0 returned -16
kobject: 'loop3' (0000000091226001): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (0000000038d1e891): kobject_uevent_env
kobject: 'loop5' (0000000038d1e891): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (0000000047f20675): kobject_uevent_env
kobject: 'loop1' (0000000047f20675): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (00000000f3ca3d42): kobject_uevent_env
kobject: 'loop0' (00000000f3ca3d42): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (0000000038d1e891): kobject_uevent_env
kobject: 'loop5' (0000000038d1e891): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (0000000047f20675): kobject_uevent_env
kobject: 'loop1' (0000000047f20675): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000d1d42c09): kobject_uevent_env
kobject: 'loop2' (00000000d1d42c09): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
---[ end trace d2934b3fdb1c156e ]---
RIP: 0010:crypto_remove_spawns+0x7ac/0x1340 crypto/algapi.c:194
Code: 49 8d 7c 24 10 48 89 f8 48 c1 e8 03 80 3c 18 00 0f 85 f2 06 00 00 49  
c7 44 24 10 00 00 00 00 4d 8d 66 10 4c 89 e0 48 c1 e8 03 <80> 3c 18 00 0f  
85 ef 06 00 00 49 83 7e 10 00 74 0a e8 4e 9e 24 fe
RSP: 0000:ffff888054737b88 EFLAGS: 00010202
RAX: 0000000000000002 RBX: dffffc0000000000 RCX: 1ffff1100a8e6f86
RDX: 0000000000000000 RSI: ffffffff835d58d2 RDI: ffff888085c226b8
RBP: ffff888054737df8 R08: ffff88804fb4e4c0 R09: ffff88804fb4ed60
R10: ffff88804fb4ed40 R11: 0000000000000001 R12: 0000000000000010
R13: ffffed100a8e6f8e R14: 0000000000000000 R15: ffff888054737dd0
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000110cfd0 CR3: 0000000094f35000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
