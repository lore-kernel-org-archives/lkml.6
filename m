Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6DCC3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F289022562
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F289022562
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754156AbeGGBTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 21:19:05 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:32960 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753905AbeGGBTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 21:19:03 -0400
Received: by mail-it0-f72.google.com with SMTP id p82-v6so1763675itc.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 18:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mpWPIf51sScGzQ6wJXkRg/FnnkMAKBZXzhzNaOZVXsM=;
        b=DBQD/cgL1SqqGpsVDB78aPyBZch5dvWVQE7fHXV60mhFOuIVU8IXvdOawStDj4DtHY
         RANcb+fNqe99gLsOA+PHy81+ArwhT0a2rZ19+6qIuZbqwTsizeUAKBtWAsC5Nwh2mhgT
         ict4mwdHFr1KeaYuMTLdbW6l8o+XJL9rBXvcYrgOn6h9tw60KGzjYPZX2ocX0oPKY7Nw
         CBATmuZ9sjIY17SOQWV53hc61A0hsUeKVyJS+WJfNPg5tYe5PwTkpmkmoHkcJCQJglZJ
         qj6ddMs53b8y2QrzVqezy43CKwPoEMbZb6jlaL4kIc3jFjfIRl+rELdWjKJVOpVvzL/a
         HHgQ==
X-Gm-Message-State: AOUpUlEokIFagJ+4xvB2kPwbfHkGELQVK2UKgSbTLZu2wTGauSqb/wha
        YMj0KL4NwT/vPNgyq6KjvsvLn8La3IwMgJAGyb7f6969ZYCH
X-Google-Smtp-Source: AAOMgpfPLR+ibLQXZToErCKs6wD2AGobdCEcPSCqefxiZ7SGVNgw9WsZWLEY/Yiek6/Ein7J4CDrKhclyNbUhq74lAkjWT3k3MpP
MIME-Version: 1.0
X-Received: by 2002:a6b:4e0b:: with SMTP id c11-v6mr5080437iob.22.1530926342740;
 Fri, 06 Jul 2018 18:19:02 -0700 (PDT)
Date:   Fri, 06 Jul 2018 18:19:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d624c605705e9010@google.com>
Subject: kernel BUG at mm/shmem.c:LINE!
From:   syzbot <syzbot+b8e0dfee3fd8c9012771@syzkaller.appspotmail.com>
To:     hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    526674536360 Add linux-next specific files for 20180706
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=116d16fc400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d1cfc0cb798e48
dashboard link: https://syzkaller.appspot.com/bug?extid=b8e0dfee3fd8c9012771
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=170e462c400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f1ba2c400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b8e0dfee3fd8c9012771@syzkaller.appspotmail.com

raw: 02fffc0000001028 ffffea0007011dc8 ffffea0007058b48 ffff8801a7576ab8
raw: 000000000000016e ffff8801a7588930 00000003ffffffff ffff8801d9a44c80
page dumped because: VM_BUG_ON_PAGE(page_to_pgoff(page) != index)
page->mem_cgroup:ffff8801d9a44c80
------------[ cut here ]------------
kernel BUG at mm/shmem.c:815!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 0 PID: 4429 Comm: syz-executor697 Not tainted  
4.18.0-rc3-next-20180706+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:shmem_undo_range+0xdaa/0x29a0 mm/shmem.c:815
Code: 00 0f 85 bd 19 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8  
a5 f0 d6 ff 48 c7 c6 e0 32 f1 87 4c 89 e7 e8 16 10 05 00 <0f> 0b e8 8f f0  
d6 ff 49 8d 7c 24 20 48 89 f8 48 c1 e8 03 80 3c 18
RSP: 0018:ffff8801ab88e158 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81aaab95 RDI: ffffed0035711c18
RBP: ffff8801ab88e8d0 R08: ffff8801a7af04c0 R09: ffffed003b5c4fc0
R10: ffffed003b5c4fc0 R11: ffff8801dae27e07 R12: ffffea0007058b00
R13: ffff8801ab88e8a8 R14: 0000000000000001 R15: 000000000000016e
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004b625c CR3: 0000000008e6a000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  shmem_truncate_range+0x27/0xa0 mm/shmem.c:971
  shmem_evict_inode+0x3b2/0xcb0 mm/shmem.c:1071
  evict+0x4ae/0x990 fs/inode.c:558
  iput_final fs/inode.c:1508 [inline]
  iput+0x635/0xaa0 fs/inode.c:1534
  dentry_unlink_inode+0x4ae/0x640 fs/dcache.c:377
  __dentry_kill+0x44c/0x7a0 fs/dcache.c:569
  dentry_kill+0xc9/0x5a0 fs/dcache.c:688
  dput.part.26+0x66b/0x7a0 fs/dcache.c:849
  dput+0x15/0x20 fs/dcache.c:831
  __fput+0x558/0x930 fs/file_table.c:235
  ____fput+0x15/0x20 fs/file_table.c:251
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1b08/0x2750 kernel/exit.c:869
  do_group_exit+0x177/0x440 kernel/exit.c:972
  get_signal+0x88e/0x1970 kernel/signal.c:2467
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e0/0x370 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441c29
Code: Bad RIP value.
RSP: 002b:00007fff6e973338 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffe0 RBX: 0000000000000000 RCX: 0000000000441c29
RDX: 0000000020000180 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 00007fff6e973350 R08: 0000000000000001 R09: 0000000000000000
R10: 0a00004000000002 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000005 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 68c2f261fd3bbf54 ]---
RIP: 0010:shmem_undo_range+0xdaa/0x29a0 mm/shmem.c:815
Code: 00 0f 85 bd 19 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8  
a5 f0 d6 ff 48 c7 c6 e0 32 f1 87 4c 89 e7 e8 16 10 05 00 <0f> 0b e8 8f f0  
d6 ff 49 8d 7c 24 20 48 89 f8 48 c1 e8 03 80 3c 18
RSP: 0018:ffff8801ab88e158 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81aaab95 RDI: ffffed0035711c18
RBP: ffff8801ab88e8d0 R08: ffff8801a7af04c0 R09: ffffed003b5c4fc0
R10: ffffed003b5c4fc0 R11: ffff8801dae27e07 R12: ffffea0007058b00
R13: ffff8801ab88e8a8 R14: 0000000000000001 R15: 000000000000016e
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000441bff CR3: 0000000008e6a000 CR4: 00000000001406f0
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
