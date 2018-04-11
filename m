Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523458857; cv=none;
        d=google.com; s=arc-20160816;
        b=GD/SzAH8hMPy2y7vLPBxFIZf4CAqc8lWWOIAEiE9gOROsllyLATk9UtMwYI/YRPFKb
         y7ObK96U5pe8IsMooc9XJg9qa4ZY17AYozihkL848TCFvtOELjVbUpFBi2hvhHpt0hEO
         niytkTJ1Cfz970VT8icDk4dVnATjS9Bde6BBT82J98rC6+WJ/05Fj2njcs/5goZI6N/o
         nNGhUKh/Im4BsYOFnY93k+fOvFtnv8T/vK58/96v4pVCtlGSFLni9UXfwhd6KCYEnnZC
         kYnuNYr7jqXF8oL34nAQD4KfhhGzOdjspQkvcWk3//EcBnN3msDETf5TW90Qpmma9Mne
         wieA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=WNGu3kSfu5FD3rsYRcJXGZT/SvCdmwPqfjgvhoMo13w=;
        b=Zk2TT5g6rtmxs49qvVlm6Fx8PnF9VpSPlpXyKf9eNHMqSoLRDbDf71pEKjzNvJ66XB
         uerwoR7Jc2m84/uAkTvGC3paxQ2E/pi99Zwm3V1Kj/M9LnDQbJGkyel0eiCW1CfVJnj7
         kmKjXsE3VHJNyjmL7NbhRseEHegngOkQ/u6wCtIIQuLpuqopjvg4NsvVB9lsbYfy/uaD
         oqBI3vq2usZ30senT9vAARVV35hHzVhwyYPyB9gTJ4xdhPOpKa037us6bEFKpUFganc0
         OhRVG4EiCg0URubT5eFJDoUKZrSlQ1xXjvmzADfxBOKWN5iRWhhHpTXcD/IUH2Yywfc/
         BGqw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=kPvpcb6m;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=kPvpcb6m;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx48IgBNq0rKECsLorLvlMkBxp5yr0O5GEIOQjzDxVHtbN4moLVZzOpozTTC8nPfnbuA6JYB22FrifSufUiZz0U4=
MIME-Version: 1.0
In-Reply-To: <f4f5e80803d0503e760569105376@google.com>
References: <f4f5e80803d0503e760569105376@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 11 Apr 2018 17:00:35 +0200
Message-ID: <CACT4Y+YpsVbudeSmADsW0E8_8Cm77QvP_BeEk+J55Hhnx6H4ww@mail.gmail.com>
Subject: Re: WARNING: kobject bug in sysfs_warn_dup
To: syzbot <syzbot+ff87a28e665c163aa7f5@syzkaller.appspotmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596869807528039825?=
X-GMAIL-MSGID: =?utf-8?q?1597462394652019796?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 4:02 AM, syzbot
<syzbot+ff87a28e665c163aa7f5@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> 3e968c9f1401088abc9a19ae6ff571644d37a355 (Wed Apr 4 21:19:24 2018 +0000)
> Merge tag 'ext4_for_linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=ff87a28e665c163aa7f5
>
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5104666266304512
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=5683447737614336
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=5104818200772608
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=9118669095563550941
> compiler: gcc (GCC) 7.1.1 20170620
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+ff87a28e665c163aa7f5@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.

#syz dup: WARNING: kobject bug in gfs2_sys_fs_add

> R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000003
> R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
> ------------[ cut here ]------------
> kobject_add_internal failed for nodev( with -EEXIST, don't try to register
> things with the same name in the same directory.
> sysfs: cannot create duplicate filename '/fs/gfs2/nodev('
> WARNING: CPU: 1 PID: 4473 at lib/kobject.c:238
> kobject_add_internal+0x8d4/0xbc0 lib/kobject.c:235
> CPU: 0 PID: 4474 Comm: syzkaller533472 Not tainted 4.16.0+ #15
> Kernel panic - not syncing: panic_on_warn set ...
>
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x1a7/0x27d lib/dump_stack.c:53
>  sysfs_warn_dup+0x83/0xa0 fs/sysfs/dir.c:30
>  sysfs_create_dir_ns+0x178/0x1d0 fs/sysfs/dir.c:58
>  create_dir lib/kobject.c:69 [inline]
>  kobject_add_internal+0x335/0xbc0 lib/kobject.c:227
>  kobject_add_varg lib/kobject.c:364 [inline]
>  kobject_init_and_add+0xf9/0x150 lib/kobject.c:436
>  gfs2_sys_fs_add+0x1ff/0x580 fs/gfs2/sys.c:652
>  fill_super+0x86f/0x1d70 fs/gfs2/ops_fstype.c:1118
>  gfs2_mount+0x587/0x6e0 fs/gfs2/ops_fstype.c:1321
>  mount_fs+0x66/0x2d0 fs/super.c:1222
>  vfs_kern_mount.part.26+0xc6/0x4a0 fs/namespace.c:1037
>  vfs_kern_mount fs/namespace.c:2514 [inline]
>  do_new_mount fs/namespace.c:2517 [inline]
>  do_mount+0xea4/0x2b90 fs/namespace.c:2847
>  ksys_mount+0xab/0x120 fs/namespace.c:3063
>  SYSC_mount fs/namespace.c:3077 [inline]
>  SyS_mount+0x39/0x50 fs/namespace.c:3074
>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x4432fa
> RSP: 002b:00007ffda3d84538 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000020001a40 RCX: 00000000004432fa
> RDX: 0000000020001a00 RSI: 0000000020001a40 RDI: 00007ffda3d84550
> RBP: 0000000000000000 R08: 0000000020001f00 R09: 000000000000000a
> R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000003
> R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
> CPU: 1 PID: 4473 Comm: syzkaller533472 Not tainted 4.16.0+ #15
> ------------[ cut here ]------------
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x1a7/0x27d lib/dump_stack.c:53
> kobject_add_internal failed for nodev( with -EEXIST, don't try to register
> things with the same name in the same directory.
>  panic+0x1f8/0x42c kernel/panic.c:183
> WARNING: CPU: 0 PID: 4474 at lib/kobject.c:238
> kobject_add_internal+0x8d4/0xbc0 lib/kobject.c:235
> Modules linked in:
>  __warn+0x1dc/0x200 kernel/panic.c:547
> CPU: 0 PID: 4474 Comm: syzkaller533472 Not tainted 4.16.0+ #15
>  report_bug+0x1f4/0x2b0 lib/bug.c:186
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
>  fixup_bug.part.10+0x37/0x80 arch/x86/kernel/traps.c:178
> RIP: 0010:kobject_add_internal+0x8d4/0xbc0 lib/kobject.c:235
>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
> RSP: 0000:ffff8801addaf470 EFLAGS: 00010282
> RAX: dffffc0000000008 RBX: ffff8801d9661110 RCX: ffffffff815b5d2e
> RDX: 0000000000000000 RSI: 1ffff10035bb5e3e RDI: 1ffff10035bb5e13
> RBP: ffff8801addaf568 R08: 1ffff10035bb5dd5 R09: 0000000000000001
> R10: 0000000000000001 R11: 0000000000000000 R12: 1ffff10035bb5e94
> R13: 00000000ffffffef R14: ffff8801d39ae348 R15: 1ffff10035bb5e98
> FS:  0000000001db2880(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:991
> RIP: 0010:kobject_add_internal+0x8d4/0xbc0 lib/kobject.c:235
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000019657b0 CR3: 00000001ae0ca000 CR4: 00000000001406f0
> RSP: 0018:ffff8801ade37470 EFLAGS: 00010282
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> RAX: dffffc0000000008 RBX: ffff8801d9459190 RCX: ffffffff815b5d2e
> Call Trace:
> RDX: 0000000000000000 RSI: 1ffff10035bc6e3e RDI: 1ffff10035bc6e13
> RBP: ffff8801ade37568 R08: 1ffff10035bc6dd5 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: 1ffff10035bc6e94
> R13: 00000000ffffffef R14: ffff8801d39ae348 R15: 1ffff10035bc6e98
>  kobject_add_varg lib/kobject.c:364 [inline]
>  kobject_init_and_add+0xf9/0x150 lib/kobject.c:436
>  gfs2_sys_fs_add+0x1ff/0x580 fs/gfs2/sys.c:652
>  kobject_add_varg lib/kobject.c:364 [inline]
>  kobject_init_and_add+0xf9/0x150 lib/kobject.c:436
>  gfs2_sys_fs_add+0x1ff/0x580 fs/gfs2/sys.c:652
>  fill_super+0x86f/0x1d70 fs/gfs2/ops_fstype.c:1118
>  fill_super+0x86f/0x1d70 fs/gfs2/ops_fstype.c:1118
>  gfs2_mount+0x587/0x6e0 fs/gfs2/ops_fstype.c:1321
>  mount_fs+0x66/0x2d0 fs/super.c:1222
>  vfs_kern_mount.part.26+0xc6/0x4a0 fs/namespace.c:1037
>  gfs2_mount+0x587/0x6e0 fs/gfs2/ops_fstype.c:1321
>  vfs_kern_mount fs/namespace.c:2514 [inline]
>  do_new_mount fs/namespace.c:2517 [inline]
>  do_mount+0xea4/0x2b90 fs/namespace.c:2847
>  mount_fs+0x66/0x2d0 fs/super.c:1222
>  vfs_kern_mount.part.26+0xc6/0x4a0 fs/namespace.c:1037
>  vfs_kern_mount fs/namespace.c:2514 [inline]
>  do_new_mount fs/namespace.c:2517 [inline]
>  do_mount+0xea4/0x2b90 fs/namespace.c:2847
>  ksys_mount+0xab/0x120 fs/namespace.c:3063
>  SYSC_mount fs/namespace.c:3077 [inline]
>  SyS_mount+0x39/0x50 fs/namespace.c:3074
>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>  ksys_mount+0xab/0x120 fs/namespace.c:3063
>  SYSC_mount fs/namespace.c:3077 [inline]
>  SyS_mount+0x39/0x50 fs/namespace.c:3074
>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x4432fa
> RSP: 002b:00007ffda3d84538 EFLAGS: 00000286
>  ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000020001a40 RCX: 00000000004432fa
> RDX: 0000000020001a00 RSI: 0000000020001a40 RDI: 00007ffda3d84550
> RBP: 0000000000000000 R08: 0000000020001f00 R09: 000000000000000a
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000003
> R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
> RIP: 0033:0x4432fa
> RSP: 002b:00007ffda3d84538 EFLAGS: 00000286
> Code:
>  ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000020001a40 RCX: 00000000004432fa
> 00
> RDX: 0000000020001a00 RSI: 0000000020001a40 RDI: 00007ffda3d84550
> 00
> RBP: 0000000000000000 R08: 0000000020001f00 R09: 000000000000000a
> 00
> R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000003
> R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
> 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 aa 00 00 00 48 8b 13 48 c7 c6 80
> 8b d6 87 48 c7 c7 e0 88 d6 87 e8 3c 33 58 fa <0f> 0b e9 1d fb ff ff e8 60 4c
> 88 fa 0f 0b e9 29 fe ff ff e8 54
> ---[ end trace 5eab46a9e10a0c8a ]---
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
> If you want to test a patch for this bug, please reply with:
> #syz test: git://repo/address.git branch
> and provide the patch inline or as an attachment.
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
> https://groups.google.com/d/msgid/syzkaller-bugs/f4f5e80803d0503e760569105376%40google.com.
> For more options, visit https://groups.google.com/d/optout.
