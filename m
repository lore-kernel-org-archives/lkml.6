Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523458691; cv=none;
        d=google.com; s=arc-20160816;
        b=lb6wXidAfVw7w6nQFHmbYgLsJmUXgmtV4Ys9ivxyLp4wQAgcxFINwALl6BeGSHTW4Y
         zbK8eS1UKIZ4XnrXkfxfXRgyHn/IIR2iYCOCDODNfL02HcRNUhGadZ4s7XoDOEZQYp6t
         YR3qsrVEiPS41rEUUGiEfs5qmw5rMG9Xu8dfGSANbXxvQQGexq1oIL/rp9NUDnKoVTW0
         GaS6CMkviNdniEn5zTl+0hGlshy7iXNEJsfE+p6Om+XF5Nn8L8IO6QTIfuIREf54Utx2
         1wPBtfm0rAfea7bh7vLaFxm0z37D85Uays8Lu/xuTEzt8JXlSRoNyIBdcQ0smgIghQgq
         dVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=a7VDZZZXEiqpUMxR2epBNxlztcO5LubfSvEWeAapll0=;
        b=q5ieOyZ9OCN//QNOduTEa/GPn7JhU2UePoE5UJE26WqQyLBC303WMgEI6WpwjQIvpO
         sAKsyoyh/mdCvcx8+wFbL1IqCtdCLrfsD+S1cRwrLokFfPQ7Vhk6GYlak27yVoIqIFUA
         pYCsWRRi0cV7sbhN3EyApHb2+Kn9HRVKVTfZbQvc5AYt7ko6iAkZvlqmiPSgq6rLGtPU
         miFIjFVNGZMxvZ8QV1LBwDX30pZzCClAKS4hyk9MBdYvdhaRF3pJZsXpTIXdv3hWlHrt
         t1YULARUCWsNTLED59VbOzg1DA2yAlU+GuwWfs9OC1nFm0GLsTXXH01GoE+I74PlmJPQ
         QITw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Vz0C3WZY;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Vz0C3WZY;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4+jm6eKoX6oynqq57Qzf5ZdoI4LNuVhR8C2aHe5s5l2iD+vRFJMKZ8NBkGWP3rGGLDRyzxm/RUrMY1R3of7VZs=
MIME-Version: 1.0
In-Reply-To: <001a113f8036fab00405620e4d72@google.com>
References: <001a1148d244c6f6f7055cd73fcd@google.com> <001a113f8036fab00405620e4d72@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 11 Apr 2018 16:57:50 +0200
Message-ID: <CACT4Y+bO2HN9Tuw2iMND9tD8578DNSOwUs7_W6Rvg-8oX5Qipw@mail.gmail.com>
Subject: Re: WARNING in kobject_add_internal
To: syzbot <syzbot+e204ced820ef739d71ef5438f5e1976a874abc8d@syzkaller.appspotmail.com>
Cc: bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>, stephen hemminger <stephen@networkplumber.org>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1582779158902801058?=
X-GMAIL-MSGID: =?utf-8?q?1597462220893606566?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Jan 5, 2018 at 10:41 PM, syzbot
<syzbot+e204ced820ef739d71ef5438f5e1976a874abc8d@syzkaller.appspotmail.com>
wrote:
> syzkaller has found reproducer for the following crash on
> 89876f275e8d562912d9c238cd888b52065cf25c
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
>
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by:
> syzbot+e204ced820ef739d71ef5438f5e1976a874abc8d@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed.

#syz dup: WARNING: kobject bug in device_add

> ------------[ cut here ]------------
> kobject_add_internal failed for   (error: -12 parent: net)
> WARNING: CPU: 1 PID: 3494 at lib/kobject.c:244
> kobject_add_internal+0x3f6/0xbc0 lib/kobject.c:242
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 1 PID: 3494 Comm: syzkaller425998 Not tainted 4.15.0-rc6+ #249
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  panic+0x1e4/0x41c kernel/panic.c:183
>  __warn+0x1dc/0x200 kernel/panic.c:547
>  report_bug+0x211/0x2d0 lib/bug.c:184
>  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x22/0x40 arch/x86/entry/entry_64.S:1079
> RIP: 0010:kobject_add_internal+0x3f6/0xbc0 lib/kobject.c:242
> RSP: 0018:ffff8801c53c76f0 EFLAGS: 00010286
> RAX: dffffc0000000008 RBX: ffff8801bf5a88d8 RCX: ffffffff8159da9e
> RDX: 0000000000000000 RSI: 1ffff10038a78e99 RDI: ffff8801c53c73f8
> RBP: ffff8801c53c77e8 R08: 1ffff10038a78e5b R09: 0000000000000000
> R10: ffff8801c53c74b0 R11: 0000000000000000 R12: 1ffff10038a78ee4
> R13: 00000000fffffff4 R14: ffff8801d8359a80 R15: ffffffff86201980
>  kobject_add_varg lib/kobject.c:366 [inline]
>  kobject_add+0x132/0x1f0 lib/kobject.c:411
>  device_add+0x35d/0x1650 drivers/base/core.c:1787
>  netdev_register_kobject+0x183/0x360 net/core/net-sysfs.c:1604
>  register_netdevice+0xb2b/0x1010 net/core/dev.c:7698
>  tun_set_iff drivers/net/tun.c:2319 [inline]
>  __tun_chr_ioctl+0x1d89/0x3dd0 drivers/net/tun.c:2524
>  tun_chr_ioctl+0x2a/0x40 drivers/net/tun.c:2773
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
>  SYSC_ioctl fs/ioctl.c:701 [inline]
>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>  entry_SYSCALL_64_fastpath+0x23/0x9a
> RIP: 0033:0x444fc9
> RSP: 002b:00007fff53389dc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000444fc9
> RDX: 0000000020533000 RSI: 00000000400454ca RDI: 0000000000000004
> RBP: 0000000000000005 R08: 0000000000000002 R09: 0000006f00003131
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402500
> R13: 0000000000402590 R14: 0000000000000000 R15: 0000000000000000
>
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
