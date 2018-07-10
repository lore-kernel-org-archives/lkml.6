Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE39C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2531208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2531208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754464AbeGJN3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:29:04 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:41379 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754201AbeGJN3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:29:02 -0400
Received: by mail-it0-f71.google.com with SMTP id h26-v6so17839328itj.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 06:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hsYoLxBqyMMfT43RyKKNynbJ/hEbBtXmwk0Ufj8N6pQ=;
        b=AA27hm/UvHUGo3vAunhUB0jOm9+31v0OegCJJ7VQZZMYUf7+up0pgdNuow6wxA+huw
         sxyo/7V9egvbt7J374MytxGkcWRN3sp6Ph24NHB7nxoqTGgTtAx6eQ0+IUEjh3HoTIM3
         2W2smFo84hwcywm6uwvUFeILQ+SfjmQHxHNsHrEDzoJlwkvXpezIo8mDmejAk/oqKLmq
         6UU6C0T0/hG+H+KC2hk4/v+drxxqqiV54pkO8T5PghN2tAqPiFnBsEnO3gDkKlpjBtBH
         xqQLqlz1fczMXMm01PJKDT03/8R9pC8rttHhSy1L+MIrT9rNTZkPLq8mQ4GwyH959Lih
         J2fg==
X-Gm-Message-State: AOUpUlG8nS8l6IU9ubZtP4Kwu0ZldjlMCbA6YruXak5yrHVxQj+GdRnO
        +fdkTdbJEHEd/OR+smJR3jmPzh8oEXqaXmzwe0w8Ns4HZHgU
X-Google-Smtp-Source: AAOMgpdqUtP3jOtMMQWobhjpwSiKjUJb6908X0NeqmMqk2W8wusFvFCM2Xps4uJuCN8cjcPlKdjDLFpuR50I4VWaRXlOmXXkCE0d
MIME-Version: 1.0
X-Received: by 2002:a6b:1408:: with SMTP id 8-v6mr10132220iou.81.1531229342044;
 Tue, 10 Jul 2018 06:29:02 -0700 (PDT)
Date:   Tue, 10 Jul 2018 06:29:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000099630570a51d1a@google.com>
Subject: WARNING: kmalloc bug in __v9fs_get_acl
From:   syzbot <syzbot+6e438f4036df52cbb863@syzkaller.appspotmail.com>
To:     ericvh@gmail.com, linux-kernel@vger.kernel.org, lucho@ionkov.net,
        rminnich@sandia.gov, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3951bd9fe3e2 Add linux-next specific files for 20180710
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11a281b2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b6e8479ba596271a
dashboard link: https://syzkaller.appspot.com/bug?extid=6e438f4036df52cbb863
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=10f7ca2c400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104b1a2c400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6e438f4036df52cbb863@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
WARNING: CPU: 0 PID: 4463 at mm/slab_common.c:1031 kmalloc_slab+0x56/0x70  
mm/slab_common.c:1031
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 4463 Comm: syz-executor437 Not tainted  
4.18.0-rc4-next-20180710+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:996
RIP: 0010:kmalloc_slab+0x56/0x70 mm/slab_common.c:1031
Code: c5 c0 0a d2 88 5d c3 b8 10 00 00 00 48 85 ff 74 f4 83 ef 01 c1 ef 03  
0f b6 87 e0 09 d2 88 eb d8 31 c0 81 e6 00 02 00 00 75 db <0f> 0b 5d c3 48  
8b 04 c5 00 0a d2 88 5d c3 66 90 66 2e 0f 1f 84 00
RSP: 0018:ffff8801ac9bfa30 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000700000000 RCX: ffffffff82b10c44
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000700000000
RBP: ffff8801ac9bfa30 R08: ffff8801ace58100 R09: fffffbfff12569a8
R10: fffffbfff12569a8 R11: ffffffff892b4d43 R12: fffffffffffffff4
R13: ffff8801b30e5b80 R14: ffff8801b30e5b80 R15: 0000000000608040
  __do_kmalloc mm/slab.c:3713 [inline]
  __kmalloc+0x25/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:518 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  __v9fs_get_acl+0xc5/0x170 fs/9p/acl.c:36
  v9fs_get_acl+0xe5/0x2a0 fs/9p/acl.c:70
  v9fs_mount+0x64b/0x900 fs/9p/vfs_super.c:191
  legacy_get_tree+0x118/0x440 fs/fs_context.c:659
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1743
  do_new_mount fs/namespace.c:2567 [inline]
  do_mount+0x6c1/0x1fb0 fs/namespace.c:2889
  ksys_mount+0x12d/0x140 fs/namespace.c:3105
  __do_sys_mount fs/namespace.c:3119 [inline]
  __se_sys_mount fs/namespace.c:3116 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3116
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4404a9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffabc5f1b8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00000000004404a9
RDX: 0000000020000900 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 64663d736e617274 R08: 0000000020000540 R09: 00007fffabc5f338
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000401d30
R13: 0000000000401dc0 R14: 0000000000000000 R15: 0000000000000000
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
