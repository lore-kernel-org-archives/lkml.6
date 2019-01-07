Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9B2C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB5520859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfAGJwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:52:06 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:33560 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfAGJwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:52:05 -0500
Received: by mail-io1-f69.google.com with SMTP id p21so19048516iog.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 01:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0H8FKUzy8TQndKiuNV30BH/W4JGfdWRkj7Jc6gqhUj0=;
        b=sxbf585RIMHy8IYT0DvRIW0EUtsvVBlqNPtK8BaRdQBJd2qyB2rtfdv+fkcimgdx8F
         9VEG7D+cRyNGYNZjS32FrXRcoY0Y8y32H6S18V2/DybA5DYU2uf3Cs3BTjWAYpUebQS5
         +cN1E6Zgnfikx/pqSw4O3wiw4hk15dPzoL5rO2emIij+MFF7A2X4zt/Fj4mtdLd/HtzF
         ah+ot2ncY2y38lc5ZpMohF9z4FQYUQWfHfrW7AG7yA2+3ZatupjO4GrFPQjn5abJbUw+
         HylwOT5HMUH0+LVe3O9pPG8PGDXfZHcceXkbzAh9UVbjwOPxZo8T1Y1CN41Wr928cYnq
         qsnA==
X-Gm-Message-State: AJcUukfT8bkVzml8pe2uxRvSj4E69eUzNF15SLzRAu4nj0JSuk0KZse3
        xAnSGIVWOMQ/FXDoiZVMhEizGx8ltqpM8gMAZ88l+Kg0ku3j
X-Google-Smtp-Source: ALg8bN7EXUylPSCp0qZB9/lJuNiRQTQ+bOhrfftXaQCmDw65OCE0Nz3LVJu/UtbkOZZjAJE5Ko7z6oKOt71yrgBa2L5qXEKr1ctG
MIME-Version: 1.0
X-Received: by 2002:a6b:d315:: with SMTP id s21mr11382786iob.23.1546854724607;
 Mon, 07 Jan 2019 01:52:04 -0800 (PST)
Date:   Mon, 07 Jan 2019 01:52:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000612b51057edb2e2d@google.com>
Subject: WARNING: locking bug in nr_release
From:   syzbot <syzbot+23f5ac6e7c0b6cc63734@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    574823bfab82 Change mincore() to count "mapped" pages rath..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121dc980c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d55557b516c45456
dashboard link: https://syzkaller.appspot.com/bug?extid=23f5ac6e7c0b6cc63734
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+23f5ac6e7c0b6cc63734@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(class_idx > MAX_LOCKDEP_KEYS)
WARNING: CPU: 1 PID: 30980 at kernel/locking/lockdep.c:3315  
__lock_acquire+0x14cd/0x4a30 kernel/locking/lockdep.c:3315
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 30980 Comm: syz-executor5 Not tainted 4.20.0+ #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x48 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:__lock_acquire+0x14cd/0x4a30 kernel/locking/lockdep.c:3315
Code: 8b 1d 3b eb f7 08 45 85 db 0f 85 f0 f3 ff ff 48 c7 c6 60 a1 4b 88 48  
c7 c7 80 76 4b 88 44 89 9c 24 98 00 00 00 e8 f3 5f e7 ff <0f> 0b 44 8b 9c  
24 98 00 00 00 e9 c9 f3 ff ff 8b 0d 2e 9c f2 09 85
RSP: 0018:ffff8880710cf0c0 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 00000000fffe4386 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81684ce6 RDI: 0000000000000006
RBP: ffff8880710cf350 R08: ffff888081d582c0 R09: fffffbfff1333299
R10: fffffbfff1333298 R11: ffffffff899994c3 R12: ffff888081d582c0
R13: ffff888081d58b8a R14: 0000000000000001 R15: 00000000fffe4386
kobject: 'kvm' (00000000d564ee4d): kobject_uevent_env
  lock_acquire+0x1db/0x570 kernel/locking/lockdep.c:3841
kobject: 'kvm' (00000000d564ee4d): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
  __raw_write_lock_bh include/linux/rwlock_api_smp.h:203 [inline]
  _raw_write_lock_bh+0x33/0x50 kernel/locking/spinlock.c:312
  sock_orphan include/net/sock.h:1796 [inline]
  nr_release+0x6a/0x3c0 net/netrom/af_netrom.c:524
  __sock_release+0xd3/0x250 net/socket.c:579
  sock_close+0x1b/0x30 net/socket.c:1141
  __fput+0x3c5/0xb10 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x1f4/0x2b0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x19d6/0x2650 kernel/exit.c:867
  do_group_exit+0x177/0x430 kernel/exit.c:970
  get_signal+0x8b4/0x19b0 kernel/signal.c:2517
  do_signal+0x91/0x1ea0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2f7/0x3b0 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x696/0x800 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f52aee87cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000073c048 RCX: 0000000000457ec9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000073c048
RBP: 000000000073c040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000073c04c
R13: 00007ffe776ee8af R14: 00007f52aee889c0 R15: 000000000073c04c
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
