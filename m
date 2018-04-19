Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753423AbeDSOx7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:53:59 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:42776 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752325AbeDSOx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:53:57 -0400
X-Google-Smtp-Source: AIpwx497GS6SiCfo6SwQmmx9w5n1TKhAPrdb1DYQOYJmAC5aapitTp3F9Hzb8FuBLJBJxdtvzRPm489TkKMVOH6twA4=
MIME-Version: 1.0
In-Reply-To: <000000000000d71bf6056a34b628@google.com>
References: <000000000000d71bf6056a34b628@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 19 Apr 2018 16:53:35 +0200
Message-ID: <CACT4Y+Z5hfkcbz5TP4tfwvi1Hop7M5B56FK=oF3N0vd1U0UsgA@mail.gmail.com>
Subject: Re: unregister_netdevice: waiting for DEV to become free
To: syzbot <syzbot+2dfb68e639f0621b19fb@syzkaller.appspotmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        netdev <netdev@vger.kernel.org>, Dan Streetman <ddstreet@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 4:52 PM, syzbot
<syzbot+2dfb68e639f0621b19fb@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> 87ef12027b9b1dd0e0b12cf311fbcb19f9d92539 (Wed Apr 18 19:48:17 2018 +0000)
> Merge tag 'ceph-for-4.17-rc2' of git://github.com/ceph/ceph-client
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=2dfb68e639f0621b19fb
>
> So far this crash happened 5 times on upstream.
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=5531107864870912
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=1808800213120130118
> compiler: gcc (GCC) 8.0.1 20180413 (experimental)

There are 2 reproducers for these hangs (presumably for different bugs):

https://groups.google.com/d/msg/syzkaller/-06_laheMF0/4wfWs6ATBwAJ
https://groups.google.com/d/msg/syzkaller/-06_laheMF0/MxCjIiHkBwAJ

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2dfb68e639f0621b19fb@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> connbytes_mt_check: 1 callbacks suppressed
> xt_connbytes: cannot load conntrack support for proto=7
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> unregister_netdevice: waiting for lo to become free. Usage count = 3
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> xt_connbytes: cannot load conntrack support for proto=7
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> xt_connbytes: cannot load conntrack support for proto=7
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> xt_connbytes: cannot load conntrack support for proto=7
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> xt_connbytes: cannot load conntrack support for proto=7
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> kernel msg: ebtables bug: please report to author: Entries_size never zero
> xt_connbytes: cannot load conntrack support for proto=7
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> xt_connbytes: cannot load conntrack support for proto=7
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> xt_connbytes: cannot load conntrack support for proto=7
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> xt_connbytes: cannot load conntrack support for proto=7
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> xt_connbytes: cannot load conntrack support for proto=7
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> xt_connbytes: cannot load conntrack support for proto=7
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> xt_connbytes: cannot load conntrack support for proto=7
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> xt_connbytes: cannot load conntrack support for proto=7
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> xt_connbytes: cannot load conntrack support for proto=7
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> xt_connbytes: cannot load conntrack support for proto=7
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> xt_connbytes: cannot load conntrack support for proto=7
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> xt_connbytes: cannot load conntrack support for proto=7
> nla_parse: 1 callbacks suppressed
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> xt_connbytes: cannot load conntrack support for proto=7
> netlink: 17 bytes leftover after parsing attributes in process
> `syz-executor6'.
> xt_connbytes: cannot load conntrack support for proto=7
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
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000d71bf6056a34b628%40google.com.
> For more options, visit https://groups.google.com/d/optout.
