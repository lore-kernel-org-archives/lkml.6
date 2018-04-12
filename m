Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523527479; cv=none;
        d=google.com; s=arc-20160816;
        b=pVXRPbA+5a90KI125Dq7QJTIXkXrc3GFAqU8t8gRHZhZOxYMDTo0Q2Vq2jW6rVw4e8
         yCXvex/B9/HkeD4IxzL2boIXKY5aNm0EivCLB/GLxRSXYarDwybU9knB9NVSkRtrb31O
         qlm3B57LpWNhmAWeeTfJsMWOw1UX7BwycVW7Mgg+J0kHeFUPEygmeNNvS30sSCb37U1K
         5nt4pQ4kuNG2q13RCU0kHY7aH8iQEEZCXWOmqbaTE3yIWCtLczpCCaQTHwdsTqTHW80a
         A28aAf4dewKZXF4y9gYEr1Mq4gHlP/JCRIGDkQcl4KuLMLuPXiqb2Xro+OdPsUBuCoJ6
         pCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=cXw2h+LhN9rSarHdY+R3lvp6jkFhUYSA6D2KH5KSrfU=;
        b=XCsdms1bqI0I1lc2bkIbvj6zMp77Omnh1O5NPBYk/i4uEDIBg4UHVAiLHGsicvJrYB
         3FSmYz2dViXgvCfR52Km9lxc0ffRUXpTbN0Qs91Huas0nn21DR48QCvT/x/fesEwOfh+
         A1wmw9E3IGtznVxiHYtpFQl8nNESDfneClkxryVlQSQwTXfFd7Y5FHFE2ojBLSbtxLbA
         W67ciSprXT40w9UOJVH03t1Sr2NSJdHZLQS0w7zQuFMHk7W1o5svSTxsQgR7vg2B3/PG
         hKlSUoVHHZQs4lzL+CXYKBnNWdN5QKEXFo1/l0J+3GumpLwCDFro3BLnPQkqwgAbllJG
         qxyw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=d0n1Vzm8;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=d0n1Vzm8;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx49sYs2Bl+uP/YaCD88zLlbDD5AZypOQBfNhDHkrUPyeBJ3KLAixcUVBRYkYnapY3CkDL6avbfhCKJH76Ujqj/8=
MIME-Version: 1.0
In-Reply-To: <aba0ade61a234e8cac26b137963c7cc3@nokia-sbell.com>
References: <001a1148d244c6f6f7055cd73fcd@google.com> <001a113f8036fab00405620e4d72@google.com>
 <CACT4Y+bO2HN9Tuw2iMND9tD8578DNSOwUs7_W6Rvg-8oX5Qipw@mail.gmail.com> <aba0ade61a234e8cac26b137963c7cc3@nokia-sbell.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 12 Apr 2018 12:04:18 +0200
Message-ID: <CACT4Y+bc0hsCdmakcOFpztkocimLgTtWwzGsgCrtf9RnSgkp5A@mail.gmail.com>
Subject: Re: WARNING in kobject_add_internal
To: "Yuan, Linyu (NSB - CN/Shanghai)" <linyu.yuan@nokia-sbell.com>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, David Miller <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>, stephen hemminger <stephen@networkplumber.org>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1582779158902801058?=
X-GMAIL-MSGID: =?utf-8?q?1597534351096646396?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 2:29 AM, Yuan, Linyu (NSB - CN/Shanghai)
<linyu.yuan@nokia-sbell.com> wrote:
> Hi,
>
> I have a question,
> "can syzbot auto test each tree with newest changeset" ?

Hi Yuan,

Please elaborate.
What trees? What newest changeset? Test against what criteria?

>> -----Original Message-----
>> From: netdev-owner@vger.kernel.org [mailto:netdev-owner@vger.kernel.org]
>> On Behalf Of Dmitry Vyukov
>> Sent: Wednesday, April 11, 2018 10:58 PM
>> To: syzbot
>> Cc: bridge@lists.linux-foundation.org; David Miller; Greg Kroah-Hartman;
>> LKML; netdev; stephen hemminger; syzkaller-bugs
>> Subject: Re: WARNING in kobject_add_internal
>>
>> On Fri, Jan 5, 2018 at 10:41 PM, syzbot
>> <syzbot+e204ced820ef739d71ef5438f5e1976a874abc8d@syzkaller.appspotma
>> il.com>
>> wrote:
>> > syzkaller has found reproducer for the following crash on
>> > 89876f275e8d562912d9c238cd888b52065cf25c
>> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
>> > compiler: gcc (GCC) 7.1.1 20170620
>> > .config is attached
>> > Raw console output is attached.
>> > C reproducer is attached
>> > syzkaller reproducer is attached. See https://goo.gl/kgGztJ
>> > for information about syzkaller reproducers
>> >
>> >
>> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> > Reported-by:
>> >
>> syzbot+e204ced820ef739d71ef5438f5e1976a874abc8d@syzkaller.appspotmail
>> .com
>> > It will help syzbot understand when the bug is fixed.
>>
>> #syz dup: WARNING: kobject bug in device_add
>>
>> > ------------[ cut here ]------------
>> > kobject_add_internal failed for   (error: -12 parent: net)
>> > WARNING: CPU: 1 PID: 3494 at lib/kobject.c:244
>> > kobject_add_internal+0x3f6/0xbc0 lib/kobject.c:242
>> > Kernel panic - not syncing: panic_on_warn set ...
>> >
>> > CPU: 1 PID: 3494 Comm: syzkaller425998 Not tainted 4.15.0-rc6+ #249
>> > Hardware name: Google Google Compute Engine/Google Compute Engine,
>> BIOS
>> > Google 01/01/2011
>> > Call Trace:
>> >  __dump_stack lib/dump_stack.c:17 [inline]
>> >  dump_stack+0x194/0x257 lib/dump_stack.c:53
>> >  panic+0x1e4/0x41c kernel/panic.c:183
>> >  __warn+0x1dc/0x200 kernel/panic.c:547
>> >  report_bug+0x211/0x2d0 lib/bug.c:184
>> >  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>> >  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>> >  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>> >  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>> >  invalid_op+0x22/0x40 arch/x86/entry/entry_64.S:1079
>> > RIP: 0010:kobject_add_internal+0x3f6/0xbc0 lib/kobject.c:242
>> > RSP: 0018:ffff8801c53c76f0 EFLAGS: 00010286
>> > RAX: dffffc0000000008 RBX: ffff8801bf5a88d8 RCX: ffffffff8159da9e
>> > RDX: 0000000000000000 RSI: 1ffff10038a78e99 RDI: ffff8801c53c73f8
>> > RBP: ffff8801c53c77e8 R08: 1ffff10038a78e5b R09: 0000000000000000
>> > R10: ffff8801c53c74b0 R11: 0000000000000000 R12: 1ffff10038a78ee4
>> > R13: 00000000fffffff4 R14: ffff8801d8359a80 R15: ffffffff86201980
>> >  kobject_add_varg lib/kobject.c:366 [inline]
>> >  kobject_add+0x132/0x1f0 lib/kobject.c:411
>> >  device_add+0x35d/0x1650 drivers/base/core.c:1787
>> >  netdev_register_kobject+0x183/0x360 net/core/net-sysfs.c:1604
>> >  register_netdevice+0xb2b/0x1010 net/core/dev.c:7698
>> >  tun_set_iff drivers/net/tun.c:2319 [inline]
>> >  __tun_chr_ioctl+0x1d89/0x3dd0 drivers/net/tun.c:2524
>> >  tun_chr_ioctl+0x2a/0x40 drivers/net/tun.c:2773
>> >  vfs_ioctl fs/ioctl.c:46 [inline]
>> >  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
>> >  SYSC_ioctl fs/ioctl.c:701 [inline]
>> >  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>> >  entry_SYSCALL_64_fastpath+0x23/0x9a
>> > RIP: 0033:0x444fc9
>> > RSP: 002b:00007fff53389dc8 EFLAGS: 00000246 ORIG_RAX:
>> 0000000000000010
>> > RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000444fc9
>> > RDX: 0000000020533000 RSI: 00000000400454ca RDI: 0000000000000004
>> > RBP: 0000000000000005 R08: 0000000000000002 R09: 0000006f00003131
>> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402500
>> > R13: 0000000000402590 R14: 0000000000000000 R15: 0000000000000000
>> >
>> > Dumping ftrace buffer:
>> >    (ftrace buffer empty)
>> > Kernel Offset: disabled
>> > Rebooting in 86400 seconds..
>> >
