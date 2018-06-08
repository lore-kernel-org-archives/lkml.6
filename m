Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /J05DfKFGlsFfQAAmS7hNA
	; Fri, 08 Jun 2018 13:34:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 16511607A4; Fri,  8 Jun 2018 13:34:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZiCqzeN"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 49969607DC;
	Fri,  8 Jun 2018 13:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49969607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeFHNej (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:34:39 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40236 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbeFHNeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:34:37 -0400
Received: by mail-pg0-f67.google.com with SMTP id l2-v6so6405725pgc.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 06:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lmKOxpSp+i046D+BW0ji3ZPshUmkSSXneeZh65ztyBk=;
        b=cZiCqzeNTFkRvO5dSn4E0xQpp+4/hB9pfiFkp5I++myq7euR2Bu7qibmv4Q37BlmOQ
         iKR2IoRR0Aq+fgMMEOjJWM0kE9oBG3msPFV6qwYLYK74NbS/w4yabey0Mq1P3WwlX458
         Ak1Jnvgy3I6CzHgbTu8sW2W+VAUmMYOWG3Cqa+zzRKNLVBkTC0VWGiG+mXGzO0BSqlAG
         LFo+vA7SOhRzlqXkhbKxdgcx2GnzImMXDSEeeLAucsXYJNLdh9wgr8dvG5iikZ1RHkp2
         O27WDeL1HNrDdT6TMRg0TqgFetpoz2oNxbf3Xyornh4hJa9OMe4C44w8Q7Maq9jT0y6z
         EvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lmKOxpSp+i046D+BW0ji3ZPshUmkSSXneeZh65ztyBk=;
        b=f+TuB90DdQ78W5FEuP44wbpT7t2qiqxrsjeYuADU3tnp7IrRHjivL/XoOHOYRGwchp
         O/IU3LXhBEGPxkkr1ZvtluttFaX//m6+mORfzncmH4nH28R75oJQiBpXht9qONUbaAdZ
         4RPtVh/qchpbWfAZcNOv6qumUIdXxlddzcDdIUMDWBuUe92XXJt2xSYKqZ01K1YG8duG
         cDaRGnF+kiF8HYXbTGZFaQ5wfPtmPLOJ9X2LEiQHvmJRZ8Mk2WpzrDvkllllbyBkbKIa
         H9eQihW8s0OoOytJ51SxHg1zOqo34a471K7vMWNUfNmwkaQMpZfTPLPnOG8yXT2tp/Bk
         01Fg==
X-Gm-Message-State: APt69E2cC3sJsx3KhmT4zy1pkRC3wMgKtzf3lh1XFI2PMYk8u5BNWyhU
        ZDAn0KFpDvyd4tPCW/3Oj+r0uD5OYWN2jYxHRJ74fA==
X-Google-Smtp-Source: ADUXVKJEjURz+A83zKMMbMXxISxbH7YTURjz+Gw7MS+/rZBbXf+xcdTYloNZU0YT7sxFfhLiKXxr8xTIJptHAOU0PrY=
X-Received: by 2002:a63:70a:: with SMTP id 10-v6mr5498083pgh.216.1528464876259;
 Fri, 08 Jun 2018 06:34:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Fri, 8 Jun 2018 06:34:15
 -0700 (PDT)
In-Reply-To: <000000000000bd54dd056e212189@google.com>
References: <000000000000bd54dd056e212189@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 8 Jun 2018 15:34:15 +0200
Message-ID: <CACT4Y+b+6XrNfHmZSBitOKqVHYaq-aOgMDnHhp3vKEVs117iJA@mail.gmail.com>
Subject: Re: WARNING in do_dentry_open
To: syzbot <syzbot+2e7fcab0f56fdbb330b8@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 3:11 PM, syzbot
<syzbot+2e7fcab0f56fdbb330b8@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    68abbe729567 Merge branch 'akpm' (patches from Andrew)
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=130146af800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e5a4673d4582131c
> dashboard link: https://syzkaller.appspot.com/bug?extid=2e7fcab0f56fdbb330b8
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1591756f800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152236af800000

Looking at the reproducer this seems to be related to bpf.
+bpf maintainers

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2e7fcab0f56fdbb330b8@syzkaller.appspotmail.com
>
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> WARNING: CPU: 1 PID: 4508 at fs/open.c:778 do_dentry_open+0x4ad/0xe40
> fs/open.c:778
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 1 PID: 4508 Comm: syz-executor867 Not tainted 4.17.0+ #90
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  panic+0x22f/0x4de kernel/panic.c:184
>  __warn.cold.8+0x163/0x1b3 kernel/panic.c:536
>  report_bug+0x252/0x2d0 lib/bug.c:186
>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
> RIP: 0010:do_dentry_open+0x4ad/0xe40 fs/open.c:778
> Code: 7b 28 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00
> 0f 85 15 08 00 00 48 c7 43 28 00 00 00 00 e8 f3 6d ba ff <0f> 0b e8 ec 6d ba
> ff 48 8d 43 18 41 be ed ff ff ff 48 89 45 c0 e9
> RSP: 0018:ffff8801afcaf7c8 EFLAGS: 00010293
> RAX: ffff8801afe08400 RBX: ffff8801b099e0c0 RCX: ffffffff81bfccf6
> RDX: 0000000000000000 RSI: ffffffff81bfcf6d RDI: ffff8801b099e0e8
> RBP: ffff8801afcaf840 R08: ffff8801afe08400 R09: ffffed0036aa2afc
> R10: ffffed0036aa2afc R11: ffff8801b55157e3 R12: ffff8801ab28d4b0
> R13: ffff8801ab28d6a8 R14: 0000000000000000 R15: ffff8801b099e13c
>  vfs_open+0x139/0x230 fs/open.c:908
>  do_last fs/namei.c:3370 [inline]
>  path_openat+0x1717/0x4dc0 fs/namei.c:3511
>  do_filp_open+0x249/0x350 fs/namei.c:3545
>  do_sys_open+0x56f/0x740 fs/open.c:1101
>  __do_sys_openat fs/open.c:1128 [inline]
>  __se_sys_openat fs/open.c:1122 [inline]
>  __x64_sys_openat+0x9d/0x100 fs/open.c:1122
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x43ff09
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 6b 45 00 00 c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffe4eafe4f8 EFLAGS: 00000217 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 2f30656c69662f2e RCX: 000000000043ff09
> RDX: 0000000000000040 RSI: 0000000020000100 RDI: ffffffffffffff9c
> RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
> R10: 0000000000000004 R11: 0000000000000217 R12: 0000000000401830
> R13: 00000000004018c0 R14: 0000000000000000 R15: 0000000000000000
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
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000bd54dd056e212189%40google.com.
> For more options, visit https://groups.google.com/d/optout.
