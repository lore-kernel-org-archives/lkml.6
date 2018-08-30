Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E174C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92DB20644
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eijm6x9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92DB20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeH3GVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 02:21:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42092 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeH3GVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 02:21:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id g23-v6so3135118plq.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 19:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5bYhzIi/8KUn/epAFSOSlOWqE6SGccloGxYOvKpyO6A=;
        b=eijm6x9Mf7bEnGXtfNOwag/LlNZQokYIWmBL2CjrV6uYnRzSnaZU2iMqVVzJAp2Q6m
         rYuiTEZMShAXs5btqS34A+i6+7cF8LoCLFak7jC524BGaXeU2SZ5FG8UIJRXtn9eWods
         +A06oidNv/hY3zzdSQI5qMxElidrbX/RePEXEpwKlNQSjrx6lNmd1En9iTN2dNKZhTbB
         ZS1DkRIB6xPQNs8ToDIFl19N0wdNrPLE44cfBWY9qaoot5ejXrV4HoxRxyAkz5ixZSvM
         6SqU6qSonyV6cGOXyOXIw4zhFXzo7O9z8OqS4TwsttC49jp4DEuMnBEXO1s9tDCvFVB/
         /lHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5bYhzIi/8KUn/epAFSOSlOWqE6SGccloGxYOvKpyO6A=;
        b=lo89uJ2Ve9v8Ei8BSu19SNSivCCn2boXnbhpmmyts59/kHmbNStpwvpbEUfjTCp0hD
         CdEvh2tckzsQ8ZlexSbEnfyGnkBIxm8rpTJNwxFIlSpSSwNGkakyYNKdlNYeP9Njc8os
         k1c5gbAA+a2EKEaoDwwL7a2wfzHdU/ukt/wUEvQT4StTeuIOaWtNgoeRfMhcuLGAycxR
         gfcaMgg5S8hE4Za4lwcEsxGhCLzcrcjlfiA4xdAhB9e06O9EHhuL2wnfbTDRThxKW5Sn
         Cx99xtq4rY7yImNGggGiPIVkQRWFI7c50n0e675TqxOojx4pjNX6kEuvrL2yHKbtVLDm
         brkw==
X-Gm-Message-State: APzg51DHMAMrg+HXqPrwB9iBLLQ4NmNaRcFOZHu8B0sPam9b0Wfo9utC
        cDOls7x8H1vZyhu2ED0rBk3Dn+NQweJkT/6nZtTqSop22fWR/Q==
X-Google-Smtp-Source: ANB0VdZZLtc6nRxq2RJiAKxDyea2jxbQ5cOARmplGFtW3jqSauWNOaueApofYu0CEI0jzaCRs3gn9kUfjmWKhrPF8f0=
X-Received: by 2002:a17:902:bf46:: with SMTP id u6-v6mr8274450pls.85.1535595696533;
 Wed, 29 Aug 2018 19:21:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 29 Aug 2018 19:21:16
 -0700 (PDT)
In-Reply-To: <000000000000c178e305749daba4@google.com>
References: <000000000000c178e305749daba4@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 29 Aug 2018 19:21:16 -0700
Message-ID: <CACT4Y+Z9wmuq=Pb-gxAJauQNi0uZGDUimWEL66UzWGSp_x2uQA@mail.gmail.com>
Subject: Re: WARNING in apparmor_secid_to_secctx
To:     syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
        tyhicks@canonical.com, john.johansen@canonical.com
Cc:     James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 7:17 PM, syzbot
<syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    817e60a7a2bb Merge branch 'nfp-add-NFP5000-support'
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1536d296400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
> dashboard link: https://syzkaller.appspot.com/bug?extid=21016130b0580a9de3b5
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com

Hi John, Tyler,

I've switched syzbot from selinux to apparmor as we discussed on lss:
https://github.com/google/syzkaller/commit/2c6cb254ae6c06f61e3aba21bb89ffb05b5db946

As expedited fix for this as possible would be nice to get, because we
are currently getting 1 machine crash/minute on this bug:
https://syzkaller.appspot.com/bug?extid=ab1882df6ecbb06d59be


> ------------[ cut here ]------------
> AppArmor WARN apparmor_secid_to_secctx: ((!secdata)):
> WARNING: CPU: 0 PID: 14826 at security/apparmor/secid.c:82
> apparmor_secid_to_secctx+0x2b5/0x2f0 security/apparmor/secid.c:82
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 0 PID: 14826 Comm: syz-executor1 Not tainted 4.19.0-rc1+ #193
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
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
> RIP: 0010:apparmor_secid_to_secctx+0x2b5/0x2f0 security/apparmor/secid.c:82
> Code: c7 c7 40 66 58 87 e8 6a 6d 0f fe 0f 0b e9 6c fe ff ff e8 3e aa 44 fe
> 48 c7 c6 80 67 58 87 48 c7 c7 a0 65 58 87 e8 4b 6d 0f fe <0f> 0b e9 3f fe ff
> ff 48 89 df e8 fc a7 83 fe e9 ed fe ff ff bb f4
> RSP: 0018:ffff8801ba1bed10 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff8801ba1beed0 RCX: ffffc9000227e000
> RDX: 0000000000018482 RSI: ffffffff8163ac01 RDI: 0000000000000001
> RBP: ffff8801ba1bed30 R08: ffff8801b80ec080 R09: ffffed003b603eca
> R10: ffffed003b603eca R11: ffff8801db01f657 R12: 0000000000000001
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff8801ba1beed0
>  security_secid_to_secctx+0x63/0xc0 security/security.c:1314
>  ctnetlink_secctx_size net/netfilter/nf_conntrack_netlink.c:621 [inline]
>  ctnetlink_nlmsg_size net/netfilter/nf_conntrack_netlink.c:659 [inline]
>  ctnetlink_conntrack_event+0x303/0x1470
> net/netfilter/nf_conntrack_netlink.c:706
>  nf_conntrack_eventmask_report+0x55f/0x930
> net/netfilter/nf_conntrack_ecache.c:151
>  nf_conntrack_event_report include/net/netfilter/nf_conntrack_ecache.h:112
> [inline]
>  nf_ct_delete+0x33c/0x5d0 net/netfilter/nf_conntrack_core.c:601
>  nf_ct_iterate_cleanup+0x48c/0x5e0 net/netfilter/nf_conntrack_core.c:1892
>  nf_ct_iterate_cleanup_net+0x23c/0x2d0
> net/netfilter/nf_conntrack_core.c:1974
>  ctnetlink_flush_conntrack net/netfilter/nf_conntrack_netlink.c:1226
> [inline]
>  ctnetlink_del_conntrack+0x66c/0x850
> net/netfilter/nf_conntrack_netlink.c:1258
>  nfnetlink_rcv_msg+0xd88/0x1070 net/netfilter/nfnetlink.c:228
>  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2454
>  nfnetlink_rcv+0x1c0/0x4d0 net/netfilter/nfnetlink.c:560
>  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
>  netlink_unicast+0x5a0/0x760 net/netlink/af_netlink.c:1343
>  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1908
>  sock_sendmsg_nosec net/socket.c:621 [inline]
>  sock_sendmsg+0xd5/0x120 net/socket.c:631
>  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2114
>  __sys_sendmsg+0x11d/0x290 net/socket.c:2152
>  __do_sys_sendmsg net/socket.c:2161 [inline]
>  __se_sys_sendmsg net/socket.c:2159 [inline]
>  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2159
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457089
> Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f7bc6e03c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f7bc6e046d4 RCX: 0000000000457089
> RDX: 0000000000000000 RSI: 0000000020d65000 RDI: 0000000000000003
> RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000004d4588 R14: 00000000004c8d5c R15: 0000000000000000
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
