Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A15DECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376162084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376162084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeGRHPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:15:20 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:40683 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeGRHPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:15:20 -0400
Received: by mail-it0-f69.google.com with SMTP id 136-v6so1659725itw.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 23:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5P38et10lwjAUaIWJKq99/nyNdczctA6MNVQkX7QQX8=;
        b=q2Ir2hk/PJwSsjihNEDf3V8y0BMf1DkUllx9CxtPleYTrw3TftXkutPwjwhzqIaso8
         VzovZn/bssXyOiVzusnqAi12vWkHcRtLPBN/S3UGy+yEcnFYmDdRmikr8GFH43iIWl4D
         7A/0q4zQwtdr4JGuwEIRCPV9N7P7NFhHNgkC8xn6qs4Dy5EvssknOgLxDeF340wmYtlL
         26xPDEsD5OudknzqBAFoaUGK5E93zf4tlguWOxe2Yck5NWSCWC6QZ8NVpeqKQQi1Jp9I
         YrtPKLvFyUarqoZRipmslRIFvMqU7hYOjdjb9nZLrPXPsK0Xn47h5KtUMc+Ef1IIe2R5
         X1cQ==
X-Gm-Message-State: AOUpUlEgWjkRLWaSf18bOE3kJJiD4y1IhIF98jlRpl61WYvJMFeBWKoZ
        Jzwiu5/JUOXSx6R+AcgsstVVHs2wF0T/tFWuleNXAbS5AwcD
X-Google-Smtp-Source: AAOMgpcolXnCDYF7j8ljtJysEtHPMq1BabBi2depJeXeEY7xyou4tOVF1/bJSitPqpGZ4tV3kyIUh3UFFIsNNH2tZ4NdUBm43/bE
MIME-Version: 1.0
X-Received: by 2002:a24:5a14:: with SMTP id v20-v6mr438649ita.41.1531895942979;
 Tue, 17 Jul 2018 23:39:02 -0700 (PDT)
Date:   Tue, 17 Jul 2018 23:39:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083a940057140518a@google.com>
Subject: WARNING: kmalloc bug in vfs_getxattr_alloc
From:   syzbot <syzbot+af1504df0807a083dbd9@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1dcbe5f2c615 Add linux-next specific files for 20180717
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12158f70400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea5926dddb0db97a
dashboard link: https://syzkaller.appspot.com/bug?extid=af1504df0807a083dbd9
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=177631c2400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13722bb2400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+af1504df0807a083dbd9@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
WARNING: CPU: 0 PID: 4458 at mm/slab_common.c:1031 kmalloc_slab+0x56/0x70  
mm/slab_common.c:1031
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 4458 Comm: syz-executor537 Not tainted  
4.18.0-rc5-next-20180717+ #9
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
Code: c5 c0 0a d1 88 5d c3 b8 10 00 00 00 48 85 ff 74 f4 83 ef 01 c1 ef 03  
0f b6 87 e0 09 d1 88 eb d8 31 c0 81 e6 00 02 00 00 75 db <0f> 0b 5d c3 48  
8b 04 c5 00 0a d1 88 5d c3 66 90 66 2e 0f 1f 84 00
RSP: 0018:ffff8801ace9f830 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81d0c52d
RDX: ffffffff81d0c5c4 RSI: 0000000000000000 RDI: 000000002f2e0008
RBP: ffff8801ace9f830 R08: ffff8801ac920700 R09: fffffbfff125691c
R10: fffffbfff125691c R11: ffffffff892b48e3 R12: 000000002f2e0008
R13: 0000000000600040 R14: ffff8801ace9f998 R15: 0000000000600040
  __do_kmalloc mm/slab.c:3713 [inline]
  __kmalloc_track_caller+0x21/0x760 mm/slab.c:3733
  __do_krealloc mm/slab_common.c:1468 [inline]
  krealloc+0x65/0xb0 mm/slab_common.c:1515
  vfs_getxattr_alloc+0x274/0x3c0 fs/xattr.c:288
  cap_inode_getsecurity+0x104/0x820 security/commoncap.c:396
  security_inode_getsecurity+0xe1/0x130 security/security.c:866
  xattr_getsecurity fs/xattr.c:243 [inline]
  vfs_getxattr+0x1db/0x390 fs/xattr.c:331
  getxattr+0x139/0x2c0 fs/xattr.c:537
  path_getxattr+0x103/0x1b0 fs/xattr.c:565
  __do_sys_getxattr fs/xattr.c:577 [inline]
  __se_sys_getxattr fs/xattr.c:574 [inline]
  __x64_sys_getxattr+0x9d/0x100 fs/xattr.c:574
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440559
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff684abf58 EFLAGS: 00000217 ORIG_RAX: 00000000000000bf
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 0000000000440559
RDX: 00000000200002c0 RSI: 0000000020000500 RDI: 00000000200004c0
RBP: 64663d736e617274 R08: 00007fff684ac0d8 R09: 00007fff684ac0d8
R10: 0000000000000143 R11: 0000000000000217 R12: 0000000000401de0
R13: 0000000000401e70 R14: 0000000000000000 R15: 0000000000000000
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
