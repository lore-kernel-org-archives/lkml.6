Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E28C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3315A208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3315A208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754427AbeGIFvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:51:05 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:58592 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeGIFvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 01:51:03 -0400
Received: by mail-it0-f70.google.com with SMTP id j80-v6so14838464itj.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 22:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sV/Q0yKQsbKxlgX+yaSfjedk6RGTOR0KAoMf2Z6+GS4=;
        b=JEe1u6m9dGbGNPEhPD20i1uQTfEg1Kn29wnyLbUiLMPNb/nd/hAHJP9tmEDzxcAWhX
         GUeiU1upE+MLtClw74LXAVt0g6Ynw8D7HgU6bhn3WhLdYRiLj37JK/21thQhnXvBX3vh
         JHUHJAs04Rfh2GGY0n9N4Q8XNZ/7mPEteP+dSoXCqesXKqVGzeqJ3nF0HSmvsgi7wGcx
         JHKJPRO8+pJZFq+U2L3Ion11Op0NsjjQJ08exdP9IP02kFp2Fs8YYCg6vDf0tyKATJ2G
         Wv7AAkzeshLqq9ybda36mO7xVqKMNlwNloVOFpWqefTD6MNG7KkbDyrJIR4BSpEYuQX1
         6yzw==
X-Gm-Message-State: APt69E1hlw18ngW4CnaxzCKHNqjfwd/7TFUPQfvApntEBJB/Z4vEBwSa
        hbhfnKw/ggRU8MpeVBxlFZdlXKr/ZCyK9To0a3Ru+L1E0FF1
X-Google-Smtp-Source: AAOMgpfHNVcxvnAIq+riyudx+Yry43FW9KgXooC0zDPwpu+FeUlTj/RExJXYhy278byWHBfBvCBaPwJwT06jqV0EMliwCv0lSfH/
MIME-Version: 1.0
X-Received: by 2002:a6b:3042:: with SMTP id w63-v6mr8522258iow.5.1531115462996;
 Sun, 08 Jul 2018 22:51:02 -0700 (PDT)
Date:   Sun, 08 Jul 2018 22:51:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000483ec605708a998d@google.com>
Subject: general protection fault in kfree (2)
From:   syzbot <syzbot+1ff9d2e170913c4ef264@syzkaller.appspotmail.com>
To:     davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    526674536360 Add linux-next specific files for 20180706
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1673a452400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d1cfc0cb798e48
dashboard link: https://syzkaller.appspot.com/bug?extid=1ff9d2e170913c4ef264
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1ff9d2e170913c4ef264@syzkaller.appspotmail.com

binder: 9948:9953 ioctl 40046207 0 returned -16
binder_alloc: 9948: binder_alloc_buf, no vma
binder: 9948:9977 transaction failed 29189/-3, size 64-8 line 2967
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 9980 Comm: syz-executor3 Not tainted 4.18.0-rc3-next-20180706+  
#1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:virt_to_head_page include/linux/mm.h:638 [inline]
RIP: 0010:virt_to_cache mm/slab.c:399 [inline]
RIP: 0010:kfree+0xa0/0x260 mm/slab.c:3809
Code: 82 cb 01 00 00 48 ba 00 00 00 80 ff 77 00 00 48 01 c2 48 89 df 48 b8  
00 00 00 00 00 ea ff ff 48 c1 ea 0c 48 c1 e2 06 48 01 c2 <48> 8b 42 08 a8  
01 48 8d 48 ff 48 0f 45 d1 4c 8b 6a 18 49 63 75 74
RSP: 0018:ffff88017e6b75d0 EFLAGS: 00010003
RAX: ffffea0000000000 RBX: 80f741c3d79d9d00 RCX: 1ffff1002fcd6ed8
RDX: 0203c8e70f5e7640 RSI: ffffffff876f3b49 RDI: 80f741c3d79d9d00
RBP: ffff88017e6b75f0 R08: ffff8801bad50640 R09: ffffed002fcd6e8a
R10: ffffed003b5c5930 R11: 0000000000000003 R12: 0000000000000286
R13: ffffffff876f3b83 R14: ffff88017e6b7740 R15: ffff880183b696c0
FS:  00007f08a8f7d700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
binder: undelivered TRANSACTION_ERROR: 29189
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000702076 CR3: 00000001ca1ff000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  p9_client_version net/9p/client.c:1009 [inline]
  p9_client_create+0xf43/0x16c9 net/9p/client.c:1069
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  legacy_get_tree+0x118/0x440 fs/fs_context.c:659
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1751
  do_new_mount fs/namespace.c:2567 [inline]
  do_mount+0x6c1/0x1fb0 fs/namespace.c:2889
  ksys_mount+0x12d/0x140 fs/namespace.c:3105
  __do_sys_mount fs/namespace.c:3119 [inline]
  __se_sys_mount fs/namespace.c:3116 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3116
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455e29
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f08a8f7cc68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f08a8f7d6d4 RCX: 0000000000455e29
RDX: 0000000020000080 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 000000000072bea0 R08: 0000000020000380 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c05ca R14: 00000000004d0070 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 358e803a851a10fe ]---
RIP: 0010:virt_to_head_page include/linux/mm.h:638 [inline]
RIP: 0010:virt_to_cache mm/slab.c:399 [inline]
RIP: 0010:kfree+0xa0/0x260 mm/slab.c:3809
Code: 82 cb 01 00 00 48 ba 00 00 00 80 ff 77 00 00 48 01 c2 48 89 df 48 b8  
00 00 00 00 00 ea ff ff 48 c1 ea 0c 48 c1 e2 06 48 01 c2 <48> 8b 42 08 a8  
01 48 8d 48 ff 48 0f 45 d1 4c 8b 6a 18 49 63 75 74
RSP: 0018:ffff88017e6b75d0 EFLAGS: 00010003
RAX: ffffea0000000000 RBX: 80f741c3d79d9d00 RCX: 1ffff1002fcd6ed8
RDX: 0203c8e70f5e7640 RSI: ffffffff876f3b49 RDI: 80f741c3d79d9d00
RBP: ffff88017e6b75f0 R08: ffff8801bad50640 R09: ffffed002fcd6e8a
R10: ffffed003b5c5930 R11: 0000000000000003 R12: 0000000000000286
R13: ffffffff876f3b83 R14: ffff88017e6b7740 R15: ffff880183b696c0
FS:  00007f08a8f7d700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000702076 CR3: 00000001ca1ff000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
