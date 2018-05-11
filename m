Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526060389; cv=none;
        d=google.com; s=arc-20160816;
        b=oEc3ylm6V1uFNo6bw67qCG6Vm2LwFrKKrjsdG8E8fzAcEbfVywy82ZL5UaW5FJsCol
         TTOiRNk0/LUxerK7MXrjaxtkwVVpF6FXx02jjdgN0OXpj6+VAdBExY/O53tDh/F+C+r9
         kH4Dfg96oJF/KfM784ql+UreZVJfdLuh7t2U5hmt7p9PQNxpSw7O1IBtjEPZ6FbrjtvI
         Vm7DyCoXWIhrl6ufoZqhJgKnQ8m6g8YXWQF2vm4arKExzjhAindptFBaz+UruW275ls+
         ZH+Ir9FZ4/xUCRsI+iE6yZ9YuPXFjxrd7dUXDauPUWTiJTwaqYpfPViQ4huj7/VMh3UD
         B2Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=OhNbNQBovzuK3h3F0ngijdzeGxZrV2ijAaokNdKb2aY=;
        b=qIBr22TnWPnwIE3NDvgxJC6CIZt/1MCrBxLbbSGrvAW9TybWwz3i6XrLeo8WPsWfD4
         eMkcSROoBzzwVdB8O1cau/1Hjt/AKJzfBWfMeHejuTFthOgVLG376OwB9zWhgCKaXDmw
         OCdA1osyznujra5EXVuFiwxcFkkf9rv3rChnn2TuC6av1WphjumtU3RggfiMiLeCA5wG
         lge4eSzv9EmphcvburLPujRYzZKvbBSiLg48vybVy1fRsQvom4z0zqS/BuSGivRx9lnu
         5qgGQSs7YoUoPyCgcTLSshZYe0zN/3t+1kDKIBS51XivWgKD7m2c5Bgf2qMgwclJjpPH
         yftA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=RT8n1bny;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=RT8n1bny;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZrNBNbPFk2pz2czrqO+/6DZa5DsZB9WiUq+9C722yl+jsHMQFIz7YBUs6dUr7PN3xVxOlLHlzsQxz0+/TwI8j4=
MIME-Version: 1.0
In-Reply-To: <94eb2c05b4ba7e98d2055dc57696@google.com>
References: <94eb2c05b4ba7e98d2055dc57696@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 11 May 2018 19:39:27 +0200
Message-ID: <CACT4Y+bs06eV-bG1hO7aMaM6CTVhXi+eLNurKfFoxV5ZxGumOg@mail.gmail.com>
Subject: Re: general protection fault in usb_find_alt_setting
To: syzbot <bot+c99ecc8a2c68eb7e06cf2f652e60d63d6fbe2f31@syzkaller.appspotmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	USB list <linux-usb@vger.kernel.org>, mathias.nyman@linux.intel.com,
	peter.chen@nxp.com, sriram.dash@nxp.com,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1583850520264684740?=
X-GMAIL-MSGID: =?utf-8?q?1600190298335609937?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Nov 12, 2017 at 10:06 AM, syzbot
<bot+c99ecc8a2c68eb7e06cf2f652e60d63d6fbe2f31@syzkaller.appspotmail.com>
wrote:
> Hello,
>
> syzkaller hit the following crash on
> d9e0e63d9a6f88440eb201e1491fcf730272c706
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
>
> Unfortunately, I don't have any reproducer for this bug yet.


This crash happened 779 times, but first 188d ago, and last 175d ago.
Let's consider this fixed by something.

#syz invalid

> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 3 PID: 23503 Comm: syz-executor5 Not tainted 4.14.0-rc8-next-20171110+
> #12
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> task: ffff88007c5e0580 task.stack: ffff88006c3b8000
> RIP: 0010:usb_find_alt_setting+0x38/0x310 drivers/usb/core/usb.c:231
> RSP: 0018:ffff88006c3bf610 EFLAGS: 00010247
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff83bf4473
> RDX: 0000000000000000 RSI: ffffc90002773000 RDI: 0000000000000004
> RBP: ffff88006c3bf650 R08: ffffed000d877ee2 R09: ffffed000d877ee2
> R10: 0000000000000003 R11: ffffed000d877ee1 R12: ffff88007c668000
> R13: 00000000000000fd R14: 00000000000007fd R15: 0000000000000000
> FS:  00007f10e9fc8700(0000) GS:ffff88007fd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020278000 CR3: 000000006e8fe000 CR4: 00000000000006e0
> DR0: 0000000020000008 DR1: 0000000020000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> Call Trace:
>  check_ctrlrecip+0xf3/0x290 drivers/usb/core/devio.c:831
>  proc_control+0x13f/0xe30 drivers/usb/core/devio.c:1078
>  usbdev_do_ioctl+0x2097/0x3670 drivers/usb/core/devio.c:2396
> SELinux: unrecognized netlink message: protocol=6 nlmsg_type=0
> sclass=netlink_xfrm_socket pig=23496 comm=syz-executor0
>  usbdev_ioctl+0x25/0x30 drivers/usb/core/devio.c:2553
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0x1b1/0x1530 fs/ioctl.c:686
>  SYSC_ioctl fs/ioctl.c:701 [inline]
>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> RIP: 0033:0x447c99
> RSP: 002b:00007f10e9fc7bd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f10e9fc86cc RCX: 0000000000447c99
> RDX: 000000002003dffa RSI: 00000000c0185500 RDI: 0000000000000014
> RBP: 0000000000000086 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000000048d8 R14: 00000000006e8978 R15: 00007f10e9fc8700
> Code: 89 d5 53 48 89 fb 48 83 ec 18 48 89 7d c8 89 75 d0 e8 2d 3c b0 fd 48
> 8d 7b 04 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48
> 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 a1 02 00
> SELinux: unrecognized netlink message: protocol=0 nlmsg_type=0
> sclass=netlink_route_socket pig=23514 comm=syz-executor7
> RIP: usb_find_alt_setting+0x38/0x310 drivers/usb/core/usb.c:231 RSP:
> ffff88006c3bf610
> ---[ end trace 53f2c0803d4e1797 ]---
> Kernel panic - not syncing: Fatal exception
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
> Please credit me with: Reported-by: syzbot <syzkaller@googlegroups.com>
>
> syzbot will keep track of this bug report.
> Once a fix for this bug is committed, please reply to this email with:
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
> https://groups.google.com/d/msgid/syzkaller-bugs/94eb2c05b4ba7e98d2055dc57696%40google.com.
> For more options, visit https://groups.google.com/d/optout.
