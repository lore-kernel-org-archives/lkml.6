Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B40C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCD420849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AU9V30w2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCD420849
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeLKJDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:03:32 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50745 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbeLKJDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:03:32 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so2473546iti.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8fefrVOlwdoBYgqxjxqoXp/f9m8Ww/Iu6CIN6/QmpuA=;
        b=AU9V30w2a3foDqtuGSKyCW/J4iiWCOF0xk9yyQ2JMzdVRVOq/6a+hLcmt0LEpZOmxw
         J0+LMmDoaI1BfTOSCGSBTugHwhA3iP1QNAN2fitbL+/1j2qMPWdNenK+vKze5tYaRTkn
         BWc5SU+v75xqyC4FS84R5dROSYncKSPXbrc6koErRCfZM2pvQaXxXs1lj1zzgXiYmU2T
         wsbA00qlghiYhKDdLPvRagzT5W2gbpU9yroBOniT60lR3202y81U6/blyU8yf2s+aMHL
         DtWZiwLc3CQSw9quk0yDyl5l/WoJbQTChTG6tYu5iN34rsKMZ4D/KAfBY2S15e2RbdPf
         GiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8fefrVOlwdoBYgqxjxqoXp/f9m8Ww/Iu6CIN6/QmpuA=;
        b=ZqW59WHswNMwiPUFMIPL0RnFNZ62JzfpEvyLAjGJpaxtoaczXnrm0SZKgy9einunk7
         q7q+VIQCC+KDf5tWjlcYaOcMaEkM/DPSaYvybZP18p7whwP+kPP8F5qwUGFIHkAa7OUR
         JrkdAUfCDoc5pg+9fNU8FOOROe8Nf3hUw9SW7SAb5gm8E16kJrK7sMssa+oClm4FMgc8
         B6oEaCApKlENcwmuJtoA/Zrduk7axqjoLzxPcdMLSKjgsL1BixC4S4z2Y0ItDGob7sEL
         5IDsIrDUG71qp3kfeXVyPTpCcF8UQ7obGgbwPuhr2yulGMSyOabH3SEpi+n/FA3jGhEv
         mE2g==
X-Gm-Message-State: AA+aEWZA9597mSNzGLUuPFKJ+YE7mxNmUJInnXT9FArRzYLVxDAtAr4W
        lwVpEZgIVxtCebwSUN9S2d2d/pppeFK+Q7EZhv00ng==
X-Google-Smtp-Source: AFSGD/V6TtCYouhodPrOAKVbL7golxY6CuxVXujfXk1m/Jc3EAHE5HNsrloN7WMDkC8mNVI9DR/WT3oiXFY9MEkb9V0=
X-Received: by 2002:a02:b19b:: with SMTP id t27mr13575142jah.72.1544519010958;
 Tue, 11 Dec 2018 01:03:30 -0800 (PST)
MIME-Version: 1.0
References: <0000000000001568af057cb456a8@google.com>
In-Reply-To: <0000000000001568af057cb456a8@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 11 Dec 2018 10:03:18 +0100
Message-ID: <CACT4Y+ZtAP4AVX9nARw+3PEdFL_WX3r37TAPuy=zBdZkg-0pRg@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in __inet6_bind
To:     syzbot+c56449ed3652e6720f30@syzkaller.appspotmail.com,
        Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        tipc-discussion@lists.sourceforge.net
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 1:41 AM syzbot
<syzbot+c56449ed3652e6720f30@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    3f06bda61398 kmsan: remove excessive KMSAN wrappers from a..
> git tree:       https://github.com/google/kmsan.git/master
> console output: https://syzkaller.appspot.com/x/log.txt?x=13ca6b05400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9b071100dcf8e641
> dashboard link: https://syzkaller.appspot.com/bug?extid=c56449ed3652e6720f30
> compiler:       clang version 8.0.0 (trunk 348261)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c56449ed3652e6720f30@syzkaller.appspotmail.com

This looks like a bug in TIPC, +TIPC maintainers.

> Started in network mode
> Own node identity fe8000000000000000000000000000bb, cluster identity 4711
> ==================================================================
> BUG: KMSAN: uninit-value in __inet6_bind+0xb72/0x1ad0
> net/ipv6/af_inet6.c:340
> CPU: 0 PID: 8376 Comm: syz-executor3 Not tainted 4.20.0-rc5+ #111
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x284/0x3b0 lib/dump_stack.c:113
>   kmsan_report+0x12d/0x290 mm/kmsan/kmsan.c:684
>   __msan_warning+0x76/0xc0 mm/kmsan/kmsan_instr.c:316
>   __inet6_bind+0xb72/0x1ad0 net/ipv6/af_inet6.c:340
>   inet6_bind+0x27f/0x390 net/ipv6/af_inet6.c:441
>   kernel_bind+0xc6/0xf0 net/socket.c:3230
>   udp_sock_create6+0x2ee/0x890 net/ipv6/ip6_udp_tunnel.c:39
>   udp_sock_create include/net/udp_tunnel.h:61 [inline]
>   tipc_udp_enable+0x166f/0x1d70 net/tipc/udp_media.c:742
>   tipc_enable_bearer net/tipc/bearer.c:302 [inline]
>   __tipc_nl_bearer_enable+0x1213/0x1da0 net/tipc/bearer.c:897
>   tipc_nl_bearer_enable+0x6c/0xb0 net/tipc/bearer.c:905
>   genl_family_rcv_msg net/netlink/genetlink.c:601 [inline]
>   genl_rcv_msg+0x185f/0x1a60 net/netlink/genetlink.c:626
>   netlink_rcv_skb+0x444/0x640 net/netlink/af_netlink.c:2477
>   genl_rcv+0x63/0x80 net/netlink/genetlink.c:637
>   netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
>   netlink_unicast+0xfc5/0x10a0 net/netlink/af_netlink.c:1336
>   netlink_sendmsg+0x1298/0x13e0 net/netlink/af_netlink.c:1917
>   sock_sendmsg_nosec net/socket.c:621 [inline]
>   sock_sendmsg net/socket.c:631 [inline]
>   ___sys_sendmsg+0xdbc/0x11d0 net/socket.c:2116
>   __sys_sendmsg net/socket.c:2154 [inline]
>   __do_sys_sendmsg net/socket.c:2163 [inline]
>   __se_sys_sendmsg+0x305/0x460 net/socket.c:2161
>   __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2161
>   do_syscall_64+0xcd/0x110 arch/x86/entry/common.c:291
>   entry_SYSCALL_64_after_hwframe+0x63/0xe7
> RIP: 0033:0x457659
> Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f82ebc52c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457659
> RDX: 0000000000000000 RSI: 00000000200008c0 RDI: 0000000000000003
> RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f82ebc536d4
> R13: 00000000004c421b R14: 00000000004d7160 R15: 00000000ffffffff
>
> Local variable description: ----udp6_addr@udp_sock_create6
> Variable was created at:
>   udp_sock_create6+0x80/0x890 net/ipv6/ip6_udp_tunnel.c:17
>   udp_sock_create include/net/udp_tunnel.h:61 [inline]
>   tipc_udp_enable+0x166f/0x1d70 net/tipc/udp_media.c:742
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
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000001568af057cb456a8%40google.com.
> For more options, visit https://groups.google.com/d/optout.
