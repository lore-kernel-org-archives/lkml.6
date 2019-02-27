Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B453CC00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0A8218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfB0GCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 01:02:06 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:52850 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfB0GCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 01:02:05 -0500
Received: by mail-io1-f71.google.com with SMTP id s18so12442695ioe.19
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 22:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6e8wJlRwCbyvK47y80urMq3ADhD7l0TE6h+A61jXyn0=;
        b=Wdhv5jCYatYA39me33IvA3hAGClDUy2hoNBF13XLEYhzfjzB7DebNWE1IbFlzU9Ena
         L/3dGc45qDvkoMqO7ArCfATdJOfziSQZtS88DqF68KZT8xU3uW+Jw/b4jnnnHyzoxhq5
         RnrcmY7TVD1CeZfqlLRrYdD8O30vcDEKc71B472BdFrdKQ9gQgYSUoUpjDJe5JEF6ZbB
         o9P4Kti27Yj6hOv5jTtFjsx4o2bn6oBKrR7p4qqQeNIXXGgh6QID92X/l03eCm3q09k8
         DwghBYOU8QEOJkFh3Dl1yBeOU/V+8ikC0nEIqVYkKX8Tc/3zkQ6k9KuMK8lv2rpdkfH2
         lYfw==
X-Gm-Message-State: AHQUAube2avByC10+7FL4KxtEdNsQVDj4D6EPp/1dWQjphcHKUfGW1gb
        TU2/7HJ9r8fSvpeY5anei/h8+EJ9iQkmaJKYSK0Cqd1K7Z6z
X-Google-Smtp-Source: AHgI3IZE1pufIc4N/yq84EzoN/HYKNjG9Bjx7AcH0iwz9nIk2d6Jb1yEq62qRFpe/6b3DGtQv7UEjzKbLohoSPXZvQDGNPt/rUxB
MIME-Version: 1.0
X-Received: by 2002:a02:6018:: with SMTP id i24mr395044jac.6.1551247324263;
 Tue, 26 Feb 2019 22:02:04 -0800 (PST)
Date:   Tue, 26 Feb 2019 22:02:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8bcea0582d9e992@google.com>
Subject: kernel BUG at include/linux/mm.h:LINE! (3)
From:   syzbot <syzbot+a5b71df98b247d973f8c@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8e7f81e2ebc4 Add linux-next specific files for 20190226
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10381714c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2fa10211b8a4a56e
dashboard link: https://syzkaller.appspot.com/bug?extid=a5b71df98b247d973f8c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14eda192c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164831e0c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a5b71df98b247d973f8c@syzkaller.appspotmail.com

page:ffffea00025c3ac0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x1fffc0000000000()
raw: 01fffc0000000000 ffffea00024bf988 ffffea00021dd448 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
------------[ cut here ]------------
kernel BUG at include/linux/mm.h:579!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7779 Comm: syz-executor379 Not tainted 5.0.0-rc8-next-20190226  
#43
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:put_page_testzero include/linux/mm.h:579 [inline]
RIP: 0010:put_page include/linux/mm.h:1025 [inline]
RIP: 0010:generic_pipe_buf_release+0x120/0x160 fs/pipe.c:224
Code: bd ff 4c 89 e7 e8 90 43 db ff e8 bb 29 bd ff 5b 41 5c 41 5d 5d c3 e8  
af 29 bd ff 48 c7 c6 20 98 75 87 4c 89 e7 e8 c0 db e4 ff <0f> 0b e8 99 29  
bd ff 4d 8d 65 ff e9 3d ff ff ff 48 89 df e8 e8 f8
RSP: 0018:ffff8880a503f920 EFLAGS: 00010293
RAX: ffff88808d2ec6c0 RBX: ffffea00025c3af4 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81982852 RDI: ffffea00025c3af8
RBP: ffff8880a503f938 R08: 000000000000003e R09: ffffed1015d05011
R10: ffffed1015d05010 R11: ffff8880ae828087 R12: ffffea00025c3ac0
R13: 0000000000000000 R14: ffff88809b6e8a40 R15: ffff8880952c4000
FS:  00000000016a0880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020f50f90 CR3: 0000000097b89000 CR4: 00000000001406f0
Call Trace:
  pipe_buf_release include/linux/pipe_fs_i.h:129 [inline]
  iter_file_splice_write+0x7d1/0xbe0 fs/splice.c:759
  do_splice_from fs/splice.c:847 [inline]
  direct_splice_actor+0x126/0x1a0 fs/splice.c:1019
  splice_direct_to_actor+0x369/0x970 fs/splice.c:974
  do_splice_direct+0x1da/0x2a0 fs/splice.c:1062
  do_sendfile+0x597/0xd00 fs/read_write.c:1442
  __do_sys_sendfile64 fs/read_write.c:1503 [inline]
  __se_sys_sendfile64 fs/read_write.c:1489 [inline]
  __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1489
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x443d29
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffc1e47c88 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000443d29
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 00000000006ce018 R08: 00000000004002e0 R09: 00000000004002e0
R10: 0000000102000300 R11: 0000000000000246 R12: 0000000000401a30
R13: 0000000000401ac0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 9daff95e0e1a45ff ]---
RIP: 0010:put_page_testzero include/linux/mm.h:579 [inline]
RIP: 0010:put_page include/linux/mm.h:1025 [inline]
RIP: 0010:generic_pipe_buf_release+0x120/0x160 fs/pipe.c:224
Code: bd ff 4c 89 e7 e8 90 43 db ff e8 bb 29 bd ff 5b 41 5c 41 5d 5d c3 e8  
af 29 bd ff 48 c7 c6 20 98 75 87 4c 89 e7 e8 c0 db e4 ff <0f> 0b e8 99 29  
bd ff 4d 8d 65 ff e9 3d ff ff ff 48 89 df e8 e8 f8
RSP: 0018:ffff8880a503f920 EFLAGS: 00010293
RAX: ffff88808d2ec6c0 RBX: ffffea00025c3af4 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81982852 RDI: ffffea00025c3af8
RBP: ffff8880a503f938 R08: 000000000000003e R09: ffffed1015d05011
R10: ffffed1015d05010 R11: ffff8880ae828087 R12: ffffea00025c3ac0
R13: 0000000000000000 R14: ffff88809b6e8a40 R15: ffff8880952c4000
FS:  00000000016a0880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020f50f90 CR3: 0000000097b89000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
