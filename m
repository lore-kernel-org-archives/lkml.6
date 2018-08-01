Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9303C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6352820862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6352820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389670AbeHAQnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:43:09 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:54944 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389547AbeHAQnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:43:09 -0400
Received: by mail-io0-f197.google.com with SMTP id d11-v6so13853645iok.21
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 07:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Hmd6VnwNznNAGOXuFldRmDn0iDfuX0h0AQ1rZD+vGpM=;
        b=WI5CUjOFUbg24LJH/DGdTYMdT3CE9Bt3Jss/wPdKLEz3tCErSTzSbFw0nnh24ZtRix
         rHWzDWsxquxNA49YBj5EVu6vGzg4gzaopBzrOo4nj2NMd8LgzTw8Xf7LPn1pJO8KnWwS
         lJIZIr7MPSP09e/PCOeXgwDG0zn9kMr3uhY2fr6pF41KGqZTCJWjmWlrX9roKeZ6tqOs
         iTUJjLsOoBAGsk1v1h5NS9e2XfmU49heTz4h7F/IdvibnvL+9fym1Pecaxfd3P4wIKLW
         ZMQltNwi6afYEYL21nEglI3hpof62cxjNf+r7uKYTZPeEu2yDdRDj+lf7mF+1ozbGRlc
         TM7w==
X-Gm-Message-State: AOUpUlGl2bG0oXyy5g3S0ZYn0gmRF4WrnNrNv+j4QFaVebSk6NLnRJL/
        Ek1jl14lHRP4PTLZBj2U3NSILm4iboR5hSUspj93oyiXZPbk
X-Google-Smtp-Source: AAOMgpdWhG10i2RWANMgIiPU1eQiGPHn1Lq3t/dOxPPu2GomTmoBLeJsKzO8rmJvdVmiycyUvXxAPY0HKiy9snajzsIi3Ja2mQGG
MIME-Version: 1.0
X-Received: by 2002:a6b:b641:: with SMTP id g62-v6mr10136759iof.103.1533135422223;
 Wed, 01 Aug 2018 07:57:02 -0700 (PDT)
Date:   Wed, 01 Aug 2018 07:57:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c0020057260e86e@google.com>
Subject: general protection fault in validate_checkpoint
From:   syzbot <syzbot+c966a82db0b14aa37e81@syzkaller.appspotmail.com>
To:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuchao0@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d9bd94c0bcaa Add linux-next specific files for 20180801
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1001189c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc8964ea4d04518c
dashboard link: https://syzkaller.appspot.com/bug?extid=c966a82db0b14aa37e81
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c966a82db0b14aa37e81@syzkaller.appspotmail.com

loop7: rw=12288, want=8200, limit=20
netlink: 65342 bytes leftover after parsing attributes in process  
`syz-executor4'.
openvswitch: netlink: Message has 8 unknown bytes.
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 7615 Comm: syz-executor7 Not tainted 4.18.0-rc7-next-20180801+  
#29
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
RIP: 0010:compound_head include/linux/page-flags.h:142 [inline]
RIP: 0010:PageLocked include/linux/page-flags.h:272 [inline]
RIP: 0010:f2fs_put_page fs/f2fs/f2fs.h:2011 [inline]
RIP: 0010:validate_checkpoint+0x66d/0xec0 fs/f2fs/checkpoint.c:835
Code: e8 58 05 7f fe 4c 8d 6b 80 4d 8d 74 24 08 48 b8 00 00 00 00 00 fc ff  
df 4c 89 ea 48 c1 ea 03 c6 04 02 00 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f  
85 f4 06 00 00 4c 89 ea 4d 8b 7c 24 08 48 b8 00 00
RSP: 0018:ffff8801937cebe8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff8801937cef30 RCX: ffffc90006035000
RDX: 0000000000000000 RSI: ffffffff82fd9658 RDI: 0000000000000005
RBP: ffff8801937cef58 R08: ffff8801ab254700 R09: fffff94000d9e026
R10: fffff94000d9e026 R11: ffffea0006cf0137 R12: fffffffffffffffb
R13: ffff8801937ceeb0 R14: 0000000000000003 R15: ffff880193419b40
FS:  00007f36a61d5700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc04ff93000 CR3: 00000001d0562000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  f2fs_get_valid_checkpoint+0x436/0x1ec0 fs/f2fs/checkpoint.c:860
  f2fs_fill_super+0x2d42/0x8110 fs/f2fs/super.c:2883
  mount_bdev+0x314/0x3e0 fs/super.c:1344
  f2fs_mount+0x3c/0x50 fs/f2fs/super.c:3133
  legacy_get_tree+0x131/0x460 fs/fs_context.c:729
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1743
  do_new_mount fs/namespace.c:2603 [inline]
  do_mount+0x6f2/0x1e20 fs/namespace.c:2927
  ksys_mount+0x12d/0x140 fs/namespace.c:3143
  __do_sys_mount fs/namespace.c:3157 [inline]
  __se_sys_mount fs/namespace.c:3154 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3154
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45943a
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 bd 8a fb ff c3 66 2e 0f  
1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 9a 8a fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007f36a61d4a88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f36a61d4b30 RCX: 000000000045943a
RDX: 00007f36a61d4ad0 RSI: 0000000020000100 RDI: 00007f36a61d4af0
RBP: 0000000020000100 R08: 00007f36a61d4b30 R09: 00007f36a61d4ad0
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000013
R13: 0000000000000000 R14: 00000000004c8ea0 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace bd8550c129352286 ]---
RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
RIP: 0010:compound_head include/linux/page-flags.h:142 [inline]
RIP: 0010:PageLocked include/linux/page-flags.h:272 [inline]
RIP: 0010:f2fs_put_page fs/f2fs/f2fs.h:2011 [inline]
RIP: 0010:validate_checkpoint+0x66d/0xec0 fs/f2fs/checkpoint.c:835
Code: e8 58 05 7f fe 4c 8d 6b 80 4d 8d 74 24 08 48 b8 00 00 00 00 00 fc ff  
df 4c 89 ea 48 c1 ea 03 c6 04 02 00 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f  
85 f4 06 00 00 4c 89 ea 4d 8b 7c 24 08 48 b8 00 00
RSP: 0018:ffff8801937cebe8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff8801937cef30 RCX: ffffc90006035000
RDX: 0000000000000000 RSI: ffffffff82fd9658 RDI: 0000000000000005
netlink: 65342 bytes leftover after parsing attributes in process  
`syz-executor4'.
RBP: ffff8801937cef58 R08: ffff8801ab254700 R09: fffff94000d9e026
openvswitch: netlink: Message has 8 unknown bytes.
R10: fffff94000d9e026 R11: ffffea0006cf0137 R12: fffffffffffffffb
R13: ffff8801937ceeb0 R14: 0000000000000003 R15: ffff880193419b40
FS:  00007f36a61d5700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc04ff93000 CR3: 00000001d0562000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
