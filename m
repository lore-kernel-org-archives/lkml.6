Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB3AC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E97208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3dgq6ZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E97208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754210AbeGIGAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:00:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42242 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753948AbeGIGAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:00:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so975012pgp.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 23:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=00EdSO4adavxxBrtStGP6OOsvCMCoqkjaf4+OC7FJrg=;
        b=q3dgq6ZP+mZou+i/BhkXQvqqRbtnXVfPPAZdnfXDs3sgSasit60oCoA+Rh9gQcEMyB
         98He7RuZ5FtEqA9eJTO2T/XFgVVRlLSIpTBM95b3mmaTXd6WOsfNtgnoRBbRBJ3rmo/c
         bmLKFC6kTOeT/lRhqvtpmW4depV/nMHnfqANgorfp6hmBVwbmLAWtDgBa/u0Qfv+j7iH
         5NDZlycEvG1KUAx2EVTWwjNt/LimkqZt0oe10U13VjORKOYZTBU+TH/jMEpnF5DWwItx
         OALAj3+J4ceDPbFSnVPSPv9TCYjlIng77gTkJppeHGkptZ98ny6ao35pib+Y0uMBRvMC
         +FUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=00EdSO4adavxxBrtStGP6OOsvCMCoqkjaf4+OC7FJrg=;
        b=bz5wJnUln2phKWQ7uHxI/xkCSIpApbFyJ+mi5kBJkTjvdZZwTiH7fEq8ssFiENO6RK
         33QGDjdKTK+nwXI+woDNOrDyH80FQC9dN5wPgp7F2b/U2tXlBif7pVTVHcf828pmOpBH
         W18cUHXppfzwY9dg5GUSgZBycigxZJe6z8jASr40Xft9vDgzwG9kKB2neZSfpKihFV9H
         yoWN67awGDzVhbsY0Zk6+1GilsvpQZWN4XCUqSWoomLXzWJt3NIJ5XbZvrcl6q3piD4w
         278smzH11diDaobNhHnweiQ/Karkh7BrmvdycSC4rmshxxaDifo3FgD8MYrFbDhQjxh9
         zpWA==
X-Gm-Message-State: APt69E0appfVw2sf97eGjWzapoXT+KqCVa78n1zJY76yfepf9HL6JHrk
        ckIWuQPx9WklzJkHX3bKsNkDdYDGek8AW/VkZoogUw==
X-Google-Smtp-Source: AAOMgpfwaVktK+3Pv+eJ2e4Lu4BCHSBe8Fy+n1weTTYGix1Hymw/Qa+z4x7GxkkfqzPkJ0N3OuwYbCQgXd4lFNAy3JM=
X-Received: by 2002:a63:e742:: with SMTP id j2-v6mr4072886pgk.114.1531116014826;
 Sun, 08 Jul 2018 23:00:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:950a:0:0:0:0 with HTTP; Sun, 8 Jul 2018 22:59:54
 -0700 (PDT)
In-Reply-To: <0000000000004a927105708ab2d9@google.com>
References: <0000000000004a927105708ab2d9@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 9 Jul 2018 07:59:54 +0200
Message-ID: <CACT4Y+YfEQwEKt7s1dYUPiA1qpiOh2wp6Kcsy_GOSiPkOQGnWA@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in unix_find_other
To:     syzbot <syzbot+75d51fe5bf4ebe988518@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        David Herrmann <dh.herrmann@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Dawson <matthew@mjdsystems.ca>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        v9fs-developer@lists.sourceforge.net,
        Ron Minnich <rminnich@sandia.gov>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 7:58 AM, syzbot
<syzbot+75d51fe5bf4ebe988518@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    a00de5aa4da3 kmsan: delete some dead code
> git tree:       https://github.com/google/kmsan.git/master
> console output: https://syzkaller.appspot.com/x/log.txt?x=165aa6d0400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b3fd30f86ca205e8
> dashboard link: https://syzkaller.appspot.com/bug?extid=75d51fe5bf4ebe988518
> compiler:       clang version 7.0.0 (trunk 334104)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=128012c2400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1221462c400000

+9p maintainers, the bug seems to be in 9p

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+75d51fe5bf4ebe988518@syzkaller.appspotmail.com
>
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> ==================================================================
> BUG: KMSAN: uninit-value in __unix_find_socket_byname net/unix/af_unix.c:280
> [inline]
> BUG: KMSAN: uninit-value in unix_find_socket_byname net/unix/af_unix.c:303
> [inline]
> BUG: KMSAN: uninit-value in unix_find_other+0x315/0xc60
> net/unix/af_unix.c:932
> CPU: 1 PID: 4574 Comm: syz-executor354 Not tainted 4.17.0+ #22
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x185/0x1d0 lib/dump_stack.c:113
>  kmsan_report+0x188/0x2a0 mm/kmsan/kmsan.c:990
>  __msan_warning_32+0x70/0xc0 mm/kmsan/kmsan_instr.c:640
>  __unix_find_socket_byname net/unix/af_unix.c:280 [inline]
>  unix_find_socket_byname net/unix/af_unix.c:303 [inline]
>  unix_find_other+0x315/0xc60 net/unix/af_unix.c:932
>  unix_stream_connect+0x84e/0x26b0 net/unix/af_unix.c:1241
>  p9_fd_create_unix+0x36b/0x5f0 net/9p/trans_fd.c:1019
>  p9_client_create+0x1333/0x20e0 net/9p/client.c:1065
>  v9fs_session_init+0x313/0x2830 fs/9p/v9fs.c:405
>  v9fs_mount+0x107/0x11b0 fs/9p/vfs_super.c:135
>  mount_fs+0x29b/0x780 fs/super.c:1277
>  vfs_kern_mount+0x222/0x990 fs/namespace.c:1037
>  do_new_mount fs/namespace.c:2518 [inline]
>  do_mount+0xca5/0x4ed0 fs/namespace.c:2848
>  ksys_mount+0x32e/0x3d0 fs/namespace.c:3064
>  __do_sys_mount fs/namespace.c:3078 [inline]
>  __se_sys_mount fs/namespace.c:3075 [inline]
>  __x64_sys_mount+0x157/0x1c0 fs/namespace.c:3075
>  do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x63/0xe7
> RIP: 0033:0x4400d9
> RSP: 002b:00007fff30dec578 EFLAGS: 00000217 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00000000004400d9
> RDX: 00000000200000c0 RSI: 0000000020000040 RDI: 0000000020000000
> RBP: 00000000006ca018 R08: 0000000020000100 R09: 00000000004002c8
> R10: 0000000000000000 R11: 0000000000000217 R12: 0000000000401960
> R13: 00000000004019f0 R14: 0000000000000000 R15: 0000000000000000
>
> Local variable description: ----sun_server@p9_fd_create_unix
> Variable was created at:
>  p9_fd_create_unix+0x7a/0x5f0 net/9p/trans_fd.c:996
>  p9_client_create+0x1333/0x20e0 net/9p/client.c:1065
> ==================================================================
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
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000004a927105708ab2d9%40google.com.
> For more options, visit https://groups.google.com/d/optout.
