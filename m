Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF14C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C88120846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U2snuQSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C88120846
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753386AbeFTFpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:45:20 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34014 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752807AbeFTFpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:45:14 -0400
Received: by mail-pf0-f195.google.com with SMTP id a63-v6so1029834pfl.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 22:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aSnC8XbHFbZpATKcEoNVoqhqvxnDoLSdjFDG2LoN4dM=;
        b=U2snuQSdajFd8J666NDHnl3mll88rFNM0pBMn0ST/2ANK+01Hmjf7Ci01siytxoLQL
         MP8yyJ45arfWcYlK+IA8kmFU1DwpspBj96WPnZ6+oXZtv1U7IYd32ecgFCtXJhxHJj90
         steKVuUuVn5gOGFmI3UpcR4TvWVOC1MAU/Xhvqsv0C5E23I24nba7GJCmDhcnGxjtziN
         Uw0S5PdcA0suOSrPyGUPRRqxvrhWW/DBxgmHmysve+Ra8NuslU2ZHQ3KcMf2+CAD1D7J
         HhpY1knot/x4gECVIC7zWzzl4nI8monQIeUr7nWf6ZGWb1CO76rFQHIypNr1cqJAH/g2
         YOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aSnC8XbHFbZpATKcEoNVoqhqvxnDoLSdjFDG2LoN4dM=;
        b=ajS2FWyIu6g27xaDlHkkSQ0y4WT8fzUBvEXWFKQuN+ApIjTNwdbgA1ypL/fgP296Nc
         v0GY05tCDk4dmFcTKvr7ydjQV/WnPYIIK93WCbGdeET6AQ01+MQZ8M+n5hUyi2k1R7/r
         PHTr2ulDM090I+TFkITifnwcVz9zRuDgaun4F3tZL79r9BV1dHFkumZbWHalzTjkkFwi
         /gZaFfNn8CW/jwZ8bB5XtMVeo3qFnIFTOMXazrdNT1/k8Q5fS330Rh3rt9ZEmpkxCSUW
         6Q4Vr5jWBogUAuee8j0Ep30tfaNaLJCswAP0QcCanLgnEz4a4+RhNnhxZazXgYzoXclh
         Oi9w==
X-Gm-Message-State: APt69E1RLTRTA0brs92NNcdo2wPeNrmLq0o/Vl9G70vM6Z7U/h8cOfv9
        Bm+uy5LP8tEkY6xzDLNGrFBlq8cAosE3KsUuxNJkpw==
X-Google-Smtp-Source: ADUXVKL/4ii+k6oKdMEfeWdE5InDQMz516W4h/P54VDNqw1mCFtz74wstE0mhXnjNodql64OyO7nyHx2+seH8VRKbzA=
X-Received: by 2002:a65:490d:: with SMTP id p13-v6mr16851014pgs.84.1529473512765;
 Tue, 19 Jun 2018 22:45:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Tue, 19 Jun 2018 22:44:52
 -0700 (PDT)
In-Reply-To: <CACT4Y+brbqfBWntjVaj-Ri2WhBdXpkA_PYs59qgLZ0vtepZEtw@mail.gmail.com>
References: <20180511014515.GA895@jagdpanzerIV> <201805110238.w4B2cIGH079602@www262.sakura.ne.jp>
 <20180511062151.GA18160@jagdpanzerIV> <CACT4Y+ahAHZa7WGW41rY5TtApU7F9x2jo=iPv8GvjaGZbzMOCQ@mail.gmail.com>
 <20180511095004.GA6575@jagdpanzerIV> <201805112058.AAB05258.HJQFFOMFOVtOSL@I-love.SAKURA.ne.jp>
 <20180517112135.GB20796@jagdpanzerIV> <20180518121506.wilixxkznbtskw34@pathway.suse.cz>
 <20180524021451.GA23443@jagdpanzerIV> <CACT4Y+brbqfBWntjVaj-Ri2WhBdXpkA_PYs59qgLZ0vtepZEtw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Jun 2018 07:44:52 +0200
Message-ID: <CACT4Y+ZGSefrYL9xtQs=yPMRNFsOUumuJXsShJPhCOBSLySxuw@mail.gmail.com>
Subject: Re: [PATCH] printk: inject caller information into the body of message
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 8:36 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Thu, May 24, 2018 at 4:14 AM, Sergey Senozhatsky
> <sergey.senozhatsky.work@gmail.com> wrote:
>>> First, we should ask what we expect from this feature.
>>
>> Yeah. Can't really comment on this, it's up to Tetsuo and Dmitry to
>> decide. So far I've seen slightly different requirements/expectations.
>
> The root problem is that it's not possible to make sense out of kernel
> output if message takes more than 1 line (or output non-atomically
> with several printk's) because of intermixed output from several
> tasks/interrupts/etc. For example, it's not generally possible to
> recover crash stack trace, because one gets random mix of frames.
> Humans usually, but not always, can restore most of the sense. So the
> goal is to make this ought-to-be-simple task actually simple and not
> requiring human intelligence and time each time.
>
> Prefixing each line with task/cpu/interrupt context should do the
> trick as it will be possible to split kernel output into multiple
> independent streams and analyze them independently.
>
> In our context (syzbot testing) we can enable an additional config,
> and adopt parser to understand additional line prefix. But I don't
> know how prefixing lines fits into a larger picture. Does it make
> sense to thought out a potential extension story for this format? E.g.
> user specifies set of extension records that are dumped before each
> line, and then can unambiguously parse them? I guess some
> consoles/interfaces will never be extended to provide access to the
> extension records, so it can make sense to make them accessible in
> text format too (optionally).


up

We continue to get mess like this, each instance of which needs to be
checked by human.


BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
sysfs: cannot create duplicate filename '/class/ieee80211/!'
PGD 1cae7e067 P4D 1cae7e067 PUD 1b4da6067 PMD 0
Oops: 0010 [#1] SMP KASAN
CPU: 1 PID: 1728 Comm: syz-executor4 Not tainted 4.17.0+ #84
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/01/2011
CPU: 0 PID: 1738 Comm: syz-executor7 Not tainted 4.17.0+ #84
RIP: 0010:          (null)
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/01/2011
Code:
Call Trace:
Bad RIP value.
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1b9/0x294 lib/dump_stack.c:113
RSP: 0018:ffff88018cd3f590 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff880192f05800 RCX: 1ffffffff10eeea9
 sysfs_warn_dup.cold.3+0x1c/0x2b fs/sysfs/dir.c:30
RDX: ffff88018cd3fab0 RSI: ffff8801c927a480 RDI: ffff88018c77c040
 sysfs_do_create_link_sd.isra.2+0x116/0x130 fs/sysfs/symlink.c:50
RBP: ffff88018cd3f700 R08: 0000000000000001 R09: 0000000000000000
 sysfs_do_create_link fs/sysfs/symlink.c:79 [inline]
 sysfs_create_link+0x65/0xc0 fs/sysfs/symlink.c:91
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff100319a7eb7
R13: ffff88018cd3fab0 R14: ffff880192f05812 R15: ffff880192f05c58
 device_add_class_symlinks drivers/base/core.c:1632 [inline]
 device_add+0x5c9/0x16f0 drivers/base/core.c:1834
FS:  00007f4a8e71f700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000191e1b000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 wiphy_register+0x182e/0x24e0 net/wireless/core.c:813
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ieee80211_register_hw+0x13cd/0x35d0 net/mac80211/main.c:1050
 sock_poll+0x1d1/0x710 net/socket.c:1168
 mac80211_hwsim_new_radio+0x1da2/0x33b0
drivers/net/wireless/mac80211_hwsim.c:2772
 vfs_poll+0x77/0x2a0 fs/select.c:40
 do_pollfd fs/select.c:848 [inline]
 do_poll fs/select.c:896 [inline]
 do_sys_poll+0x6fd/0x1100 fs/select.c:990
 hwsim_new_radio_nl+0x7b8/0xa60 drivers/net/wireless/mac80211_hwsim.c:3247
 genl_family_rcv_msg+0x889/0x1120 net/netlink/genetlink.c:599
 genl_rcv_msg+0xc6/0x170 net/netlink/genetlink.c:624
 netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2448
 __do_sys_poll fs/select.c:1048 [inline]
 __se_sys_poll fs/select.c:1036 [inline]
 __x64_sys_poll+0x189/0x510 fs/select.c:1036
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:635
 netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
 netlink_unicast+0x58b/0x740 net/netlink/af_netlink.c:1336
 do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
 netlink_sendmsg+0x9f0/0xfa0 net/netlink/af_netlink.c:1901
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455b29
 sock_sendmsg_nosec net/socket.c:645 [inline]
 sock_sendmsg+0xd5/0x120 net/socket.c:655
Code:
 ___sys_sendmsg+0x805/0x940 net/socket.c:2161
1d
ba
fb
ff
c3
66
2e
0f
1f
 __sys_sendmsg+0x115/0x270 net/socket.c:2199
84
00
00
00
 __do_sys_sendmsg net/socket.c:2208 [inline]
 __se_sys_sendmsg net/socket.c:2206 [inline]
 __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2206
00
 do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
00 66
90
48
89
f8 48
89
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
f7
RIP: 0033:0x455b29
48
Code:
89
1d
d6
ba fb
48
ff
89
c3
ca
66
4d
2e
89
0f
c2
1f
4d
84
89
00
c8
00
4c
00
8b
00
4c
00
24 08
66
0f
90
05 <48>
48
3d
89
01
f8
f0
48
ff ff
89
0f 83
f7
eb
48
b9 fb
89
ff
d6
c3
48 89
66
ca 4d
2e
89
0f
c2
1f
4d
84
89
00
c8
00
4c
00
8b
00
4c
RSP: 002b:00007f4a8e71ec68 EFLAGS: 00000246
24
 ORIG_RAX: 0000000000000007
08
RAX: ffffffffffffffda RBX: 00007f4a8e71f6d4 RCX: 0000000000455b29
0f
RDX: 0000000000000004 RSI: 0000000000000005 RDI: 0000000020000000
05
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
<48> 3d
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
01
R13: 00000000004c06c7 R14: 00000000004d0030 R15: 0000000000000000
f0
Modules linked in:
ff
Dumping ftrace buffer:
ff
   (ftrace buffer empty)
0f
CR2: 0000000000000000
83
---[ end trace 69744e61e26ed6a4 ]---
eb b9 fb ff c3 66 2e
RIP: 0010:          (null)
0f 1f 84 00 00 00
Code:
00
RSP: 002b:00007f4e4fdedc68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
Bad RIP value.
RAX: ffffffffffffffda RBX: 00007f4e4fdee6d4 RCX: 0000000000455b29
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000014
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
RSP: 0018:ffff88018cd3f590 EFLAGS: 00010246
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c0ee7 R14: 00000000004d0d80 R15: 0000000000000000
RAX: 0000000000000000 RBX: ffff880192f05800 RCX: 1ffffffff10eeea9
RDX: ffff88018cd3fab0 RSI: ffff8801c927a480 RDI: ffff88018c77c040
RBP: ffff88018cd3f700 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff100319a7eb7
R13: ffff88018cd3fab0 R14: ffff880192f05812 R15: ffff880192f05c58
FS:  00007f4a8e71f700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
netlink: 8 bytes leftover after parsing attributes in process `syz-executor2'.
CR2: ffffffffffffffd6 CR3: 0000000191e1b000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
