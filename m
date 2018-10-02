Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE2EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8141205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8141205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeJBRho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:37:44 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:37384 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbeJBRho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:37:44 -0400
Received: by mail-it1-f200.google.com with SMTP id y73-v6so2797889ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 03:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IPGp99qEUQOg6eZCj0QK3zTkciqEaUZJOApJcpYABT8=;
        b=FvquBzyAStkB5Z8jXlATZL3sX/PdmZFu18q7IxqgW5/uwk6zdDPQun1EKhWeuu/cAw
         cGfTDMKBfdtgZlEUcV2XVZL8qacqaptbLwWV2qSXkZyrcSB84HEgFIu6bcDCgpWA+vhf
         2LmhmKvCGc06efqb/PeEPLONG2mFsNjtTVqnCjRe6IsycB3ZG6dmr9GPCUahw4svSue5
         ebZSQUERvxzbxzsYrl5DREBJMbt952aAlr9Fvwwf96ptElLoVkItN4ls1LqwvMfFqwCc
         bDzgVse+tC2tEGGRkWUaL3gNFMeXPbAZkc+eQ1M5DLOIBj2/XzeP3hynt8eJav4ENVZu
         WFcg==
X-Gm-Message-State: ABuFfoh6ENbeGZDpGkAKNubNOdJga5ayIp41TgM1VAwpeN5ajsRnz22V
        mqUQVSMKaN17t3BSHmvP2tf3CdfygSq7Fg2quan08qiFI+V9
X-Google-Smtp-Source: ACcGV63j7pPU4oQyIzHyGGb1kiUfLb8K5b8D5al12jkSqMCgUSk9a8Zh6BGKvHffo0TyMvdC/RKb6p+U4nwf4/RMcJNYzvpZJYLn
MIME-Version: 1.0
X-Received: by 2002:a24:fd04:: with SMTP id m4-v6mr1339480ith.18.1538477702752;
 Tue, 02 Oct 2018 03:55:02 -0700 (PDT)
Date:   Tue, 02 Oct 2018 03:55:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7af8605773cc09f@google.com>
Subject: general protection fault in fuse_dev_do_write
From:   syzbot <syzbot+c1e36d30ee3416289cc0@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    62f3d25900c9 Add linux-next specific files for 20181002
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=147d5eb9400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77a6dfae97d4b496
dashboard link: https://syzkaller.appspot.com/bug?extid=c1e36d30ee3416289cc0
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c1e36d30ee3416289cc0@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 20304 Comm: syz-executor1 Not tainted 4.19.0-rc6-next-20181002+  
#85
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:fuse_retrieve fs/fuse/dev.c:1741 [inline]
RIP: 0010:fuse_notify_retrieve fs/fuse/dev.c:1801 [inline]
RIP: 0010:fuse_notify fs/fuse/dev.c:1834 [inline]
RIP: 0010:fuse_dev_do_write+0x1dc2/0x3810 fs/fuse/dev.c:1913
Code: 00 48 c1 e0 2a 80 3c 02 00 0f 85 dc 17 00 00 49 8b 9d 58 01 00 00 b8  
ff ff 37 00 48 c1 e0 2a 48 8d 7b 04 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 82
RSP: 0018:ffff88019bd474b8 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90003e76000
RDX: 0000000000000000 RSI: ffffffff8287fbd3 RDI: 0000000000000004
RBP: ffff88019bd47a50 R08: ffff8801c0552500 R09: ffffed0039ae937e
R10: ffffed0039ae937e R11: ffff8801cd749bf3 R12: 0000000000000000
R13: ffff8801cd749bd0 R14: 0000000000000000 R15: 0000000000000030
FS:  00007f5740db7700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000625208 CR3: 00000001c4109000 CR4: 00000000001406e0
Call Trace:
  fuse_dev_write+0x19a/0x240 fs/fuse/dev.c:1997
  call_write_iter include/linux/fs.h:1844 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457579
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f5740db6c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457579
RDX: 0000000000000030 RSI: 0000000020000080 RDI: 0000000000000004
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5740db76d4
R13: 00000000004c50c5 R14: 00000000004d8718 R15: 00000000ffffffff
Modules linked in:
---[ end trace 8b37456f1c1100bc ]---
RIP: 0010:fuse_retrieve fs/fuse/dev.c:1741 [inline]
RIP: 0010:fuse_notify_retrieve fs/fuse/dev.c:1801 [inline]
RIP: 0010:fuse_notify fs/fuse/dev.c:1834 [inline]
RIP: 0010:fuse_dev_do_write+0x1dc2/0x3810 fs/fuse/dev.c:1913
Code: 00 48 c1 e0 2a 80 3c 02 00 0f 85 dc 17 00 00 49 8b 9d 58 01 00 00 b8  
ff ff 37 00 48 c1 e0 2a 48 8d 7b 04 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 82
RSP: 0018:ffff88019bd474b8 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90003e76000
RDX: 0000000000000000 RSI: ffffffff8287fbd3 RDI: 0000000000000004
RBP: ffff88019bd47a50 R08: ffff8801c0552500 R09: ffffed0039ae937e
kobject: 'loop5' (0000000025425302): kobject_uevent_env
R10: ffffed0039ae937e R11: ffff8801cd749bf3 R12: 0000000000000000
kobject: 'loop5' (0000000025425302): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
R13: ffff8801cd749bd0 R14: 0000000000000000 R15: 0000000000000030
FS:  00007f5740db7700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
kobject: 'loop3' (000000006439d2fe): kobject_uevent_env
kobject: 'loop3' (000000006439d2fe): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kobject: 'loop5' (0000000025425302): kobject_uevent_env
kobject: 'loop5' (0000000025425302): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
CR2: 0000001b2f541000 CR3: 00000001c4109000 CR4: 00000000001406e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
