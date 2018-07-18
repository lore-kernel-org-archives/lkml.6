Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64236ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126422075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NVO/icGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126422075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbeGRJ1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 05:27:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45882 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbeGRJ1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 05:27:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id f1-v6so1697624pgq.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 01:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+N7AYpRjwjS5Jbc4rDoOdBoZLLbO4pES2tcHvOX+vAw=;
        b=NVO/icGBJ2ggMLGwmnAuUIRObFhWc8ZnnJuMZooe1X3oE97tbcslog/b9jSYq6wa1T
         YQuCgVuvqqcCWF9ZD9vAagbmF5xjPbt1xnYSQ421HnR8Xz0+VN6dZW+s5OhRJAYk2CeP
         7o869pKQvfF5OUkPc2FFvo7rQsEty3N9zOHPLz82r3bXg15N2RJBlvjXNzc6psctZZtH
         WV8uqbg6l/QZhENEjnbSEjmIXmRZzONRf3Ch589bgyJC/DmZFEfHPYuyPViVHvkzxYOA
         03S9bW/TTmRwh1pKfp3LqPA5dQuK0LwWidZMkabW2F0FtFn/bQZDc8Jbsm36Hs080Mz5
         fV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+N7AYpRjwjS5Jbc4rDoOdBoZLLbO4pES2tcHvOX+vAw=;
        b=MKDfGXgRAJk6yTy5tflFDxVncvUAwG9PhlgcdtA1YUSpLULReez6rCTaVSDXY5SawZ
         MDk+zpz0U0bXV5ZHRkfYvB9mrCfOXOpJaEwohwIE/Gz7uazIjStAohxBekTEtmHmbHKt
         uVWSdAbieedqWH10yQ6W04IezbkiXhRL2w8CqX6Sfua4+6aw64JRybCXzpzQYO9lh4Ww
         XxynDlHuFPAry9w+0hqxh/FFtJmGy/x29cJHbo81mAVd8Cuf2LtHr2Ld2HNVxybyY0sW
         u38YSlmiJWFxmZo13tWhK3Cn32CYYFDRcw8co47BQP5ZipCPom6WnPq4w48PPexO66eZ
         bfnw==
X-Gm-Message-State: AOUpUlGirHBtFxThSS/+27+gF/vxRrl5LMH/m7Mvi6M5Qes1EzYXio6G
        D8z7T6GH45avuKzPD2JqhjqaKgrPaXj3at4JF8g2jA==
X-Google-Smtp-Source: AAOMgpcgZdg+3EIvyBlogp7JZrZQfLB3VfrpOC4zCN94dJw7GIoq3d5knHpjnJG6fz7JTg/b18ND00b35ltTiiEctxo=
X-Received: by 2002:a62:3184:: with SMTP id x126-v6mr4345201pfx.49.1531903861060;
 Wed, 18 Jul 2018 01:51:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 18 Jul 2018 01:50:40
 -0700 (PDT)
In-Reply-To: <00000000000083a940057140518a@google.com>
References: <00000000000083a940057140518a@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 18 Jul 2018 10:50:40 +0200
Message-ID: <CACT4Y+ZCEQKkK3PBTGhAewN36G-GV0Ccx+Bg9xnRi2wuSz-MVg@mail.gmail.com>
Subject: Re: WARNING: kmalloc bug in vfs_getxattr_alloc
To:     syzbot <syzbot+af1504df0807a083dbd9@syzkaller.appspotmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 8:39 AM, syzbot
<syzbot+af1504df0807a083dbd9@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    1dcbe5f2c615 Add linux-next specific files for 20180717
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12158f70400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ea5926dddb0db97a
> dashboard link: https://syzkaller.appspot.com/bug?extid=af1504df0807a083dbd9
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=177631c2400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13722bb2400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+af1504df0807a083dbd9@syzkaller.appspotmail.com

Looks like 9p is not checking some data received from network. +9p maintainers.


> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> WARNING: CPU: 0 PID: 4458 at mm/slab_common.c:1031 kmalloc_slab+0x56/0x70
> mm/slab_common.c:1031
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 0 PID: 4458 Comm: syz-executor537 Not tainted 4.18.0-rc5-next-20180717+
> #9
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  panic+0x238/0x4e7 kernel/panic.c:184
>  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
>  report_bug+0x252/0x2d0 lib/bug.c:186
>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:996
> RIP: 0010:kmalloc_slab+0x56/0x70 mm/slab_common.c:1031
> Code: c5 c0 0a d1 88 5d c3 b8 10 00 00 00 48 85 ff 74 f4 83 ef 01 c1 ef 03
> 0f b6 87 e0 09 d1 88 eb d8 31 c0 81 e6 00 02 00 00 75 db <0f> 0b 5d c3 48 8b
> 04 c5 00 0a d1 88 5d c3 66 90 66 2e 0f 1f 84 00
> RSP: 0018:ffff8801ace9f830 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81d0c52d
> RDX: ffffffff81d0c5c4 RSI: 0000000000000000 RDI: 000000002f2e0008
> RBP: ffff8801ace9f830 R08: ffff8801ac920700 R09: fffffbfff125691c
> R10: fffffbfff125691c R11: ffffffff892b48e3 R12: 000000002f2e0008
> R13: 0000000000600040 R14: ffff8801ace9f998 R15: 0000000000600040
>  __do_kmalloc mm/slab.c:3713 [inline]
>  __kmalloc_track_caller+0x21/0x760 mm/slab.c:3733
>  __do_krealloc mm/slab_common.c:1468 [inline]
>  krealloc+0x65/0xb0 mm/slab_common.c:1515
>  vfs_getxattr_alloc+0x274/0x3c0 fs/xattr.c:288
>  cap_inode_getsecurity+0x104/0x820 security/commoncap.c:396
>  security_inode_getsecurity+0xe1/0x130 security/security.c:866
>  xattr_getsecurity fs/xattr.c:243 [inline]
>  vfs_getxattr+0x1db/0x390 fs/xattr.c:331
>  getxattr+0x139/0x2c0 fs/xattr.c:537
>  path_getxattr+0x103/0x1b0 fs/xattr.c:565
>  __do_sys_getxattr fs/xattr.c:577 [inline]
>  __se_sys_getxattr fs/xattr.c:574 [inline]
>  __x64_sys_getxattr+0x9d/0x100 fs/xattr.c:574
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x440559
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fff684abf58 EFLAGS: 00000217 ORIG_RAX: 00000000000000bf
> RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 0000000000440559
> RDX: 00000000200002c0 RSI: 0000000020000500 RDI: 00000000200004c0
> RBP: 64663d736e617274 R08: 00007fff684ac0d8 R09: 00007fff684ac0d8
> R10: 0000000000000143 R11: 0000000000000217 R12: 0000000000401de0
> R13: 0000000000401e70 R14: 0000000000000000 R15: 0000000000000000
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/00000000000083a940057140518a%40google.com.
> For more options, visit https://groups.google.com/d/optout.
