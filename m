Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523459924; cv=none;
        d=google.com; s=arc-20160816;
        b=LK4JNiALnvFEttGUb2ALIhsmKTJuk953Di4NgXVVHj39gGwi6W8AQfRnYS+JKyi6c/
         QFvCmrY5GUc8pAa20t+fbtd6oi8eSFLkPOZ/c+xXn5JaD7h7B7tTXZ+XQ3cNeCue8IZj
         E4VXcQNtPOfghXx/8C0j/Giu4jvSZ68POwTfKplZjC9IJulaJQq11lv0Z9W0JkBzr9nl
         wsGaWtsg3uLljslgxzGjuBTFSNNyHXqCtaZ4NkOBjhj/2K+HkCfJ0+wKzGovp9ePHesC
         j9FnZi+LtyfRDWVkiDyEEalsp9ioqNG7DffQXrGh/PxDmM73Y4eAWpy1qicZzI7fGIIZ
         sFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=2+LJQE7X3DU0/LoY1mRWPRCPMrsaj3G0IqZUg2O0zTE=;
        b=kYsu3c8hMlbx/NOYDgghAxKZPDeNfPPYWCnHb6gEWf0Q5jk65SgafOViXF3m93PPCH
         gTJiPYN4xoQDmvPMVNA02j3y296D6a7EJn6k6EN0C3lNwNTrPE5VPkZ+3vzF/KIiQHV9
         7cR8bIS6FnpjjliO50Gp+BzslsxPX2bEgqf5eczQvoi2nRaWKcxEFe6aBJMLQaugRDSi
         MqpJNuow11cO421QBur/jMggZ3b2eJd4cuhX8qqunWMDnepDK6ZxVa3kNBRTGCj8rQ9M
         1o8ZWLy+5Zn1Yhg3o3wu85kdMkP7KQdyU3vOGRTcGX0PP9A9zlHBkAydjNyaswNHtssr
         tl9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=NhRlXfWN;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=NhRlXfWN;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx497is/vizZlFkbJIyYtciGFskX5TZAt623MQuPGB/8oRU5CmkN/RKpRym3yynkPqR46omR/14JBpGojvRvURmY=
MIME-Version: 1.0
In-Reply-To: <001a113de2d878ade40569941a21@google.com>
References: <001a113de2d878ade40569941a21@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 11 Apr 2018 17:18:23 +0200
Message-ID: <CACT4Y+afuYwoWEp1PJ-Noo-YBXmKKRErntBWy2fR6iz=_xFByQ@mail.gmail.com>
Subject: Re: WARNING: kobject bug in br_add_if
To: syzbot <syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com>
Cc: bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>,
	LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
	stephen hemminger <stephen@networkplumber.org>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1597463513858460385?=
X-GMAIL-MSGID: =?utf-8?q?1597463513858460385?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 5:15 PM, syzbot
<syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> 10b84daddbec72c6b440216a69de9a9605127f7a (Sat Mar 31 17:59:00 2018 +0000)
> Merge branch 'perf-urgent-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=de73361ee4971b6e6f75
>
> So far this crash happened 4 times on net-next, upstream.
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=5007286875455488
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=-2760467897697295172
> compiler: gcc (GCC) 7.1.1 20170620
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.

+Greg

The plan is to remove this WARNING from kobject_add, if there are no objections.

> ------------[ cut here ]------------
> binder: 23650:23651 unknown command 1078223622
> kobject_add_internal failed for brport (error: -12 parent: bond0)
> binder: 23650:23651 ioctl c0306201 2000dfd0 returned -22
> WARNING: CPU: 1 PID: 23647 at lib/kobject.c:242
> kobject_add_internal+0x3f6/0xbc0 lib/kobject.c:240
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 1 PID: 23647 Comm: syz-executor7 Not tainted 4.16.0-rc7+ #374
> binder: BINDER_SET_CONTEXT_MGR already set
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x24d lib/dump_stack.c:53
>  panic+0x1e4/0x41c kernel/panic.c:183
>  __warn+0x1dc/0x200 kernel/panic.c:547
>  report_bug+0x1f4/0x2b0 lib/bug.c:186
>  fixup_bug.part.10+0x37/0x80 arch/x86/kernel/traps.c:178
>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:986
> RIP: 0010:kobject_add_internal+0x3f6/0xbc0 lib/kobject.c:240
> RSP: 0018:ffff8801d089f560 EFLAGS: 00010286
> RAX: dffffc0000000008 RBX: ffff8801adbee178 RCX: ffffffff815b193e
> RDX: 0000000000040000 RSI: ffffc900022aa000 RDI: 1ffff1003a113e31
> RBP: ffff8801d089f658 R08: 1ffff1003a113df3 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff1003a113eb2
> R13: 00000000fffffff4 R14: ffff8801abd88828 R15: ffff8801d75a1e00
>  kobject_add_varg lib/kobject.c:364 [inline]
>  kobject_init_and_add+0xf9/0x150 lib/kobject.c:436
>  br_add_if+0x79a/0x1a70 net/bridge/br_if.c:533
>  add_del_if+0xf4/0x140 net/bridge/br_ioctl.c:101
>  br_dev_ioctl+0xa2/0xc0 net/bridge/br_ioctl.c:396
>  dev_ifsioc+0x333/0x9b0 net/core/dev_ioctl.c:334
>  dev_ioctl+0x176/0xbe0 net/core/dev_ioctl.c:500
>  sock_do_ioctl+0x1ba/0x390 net/socket.c:981
>  sock_ioctl+0x367/0x670 net/socket.c:1081
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
>  SYSC_ioctl fs/ioctl.c:701 [inline]
>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x454e79
> RSP: 002b:00007eff7dab7c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007eff7dab86d4 RCX: 0000000000454e79
> RDX: 0000000020000000 RSI: 00000000000089a2 RDI: 0000000000000014
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000015
> R13: 0000000000000369 R14: 00000000006f7278 R15: 0000000000000006
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/001a113de2d878ade40569941a21%40google.com.
> For more options, visit https://groups.google.com/d/optout.
