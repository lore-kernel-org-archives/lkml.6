Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B0839C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5860720896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YDf9PwCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5860720896
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755946AbeFOHcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 03:32:06 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45167 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755926AbeFOHcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 03:32:04 -0400
Received: by mail-pg0-f67.google.com with SMTP id z1-v6so4048301pgv.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 00:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5h1iG4VMr/oPe/3JS4hs0NRVQy0RxyptKmSJXzYCzm8=;
        b=YDf9PwCli0MGwxYXdyqjdyf4x6W7Meg0Pyb5IwDJfLatB/bUf+JWHE7M1VgpKghDAt
         vXgIiQyv0bKNVz2AyUfkGxRIAG9zArVvLnV1Rk1JuurEspRERvigD9marmbihkGWs1BQ
         cqAC/oWtPZnjr2Kf+I2nofeVVjzdGzJagjHrda47yt5r2YuuotrI4DEfpl9ltgKpL0b1
         0Sd5KhPq/JM7xi3K4jb5NzUC2nvbs8+Z8SDZVrcEaBaF/ucu3Eut8/a7vRyUrKnvdrce
         kdAdFZO7o3/90N6HoIHuwPKIvMbJqsOfsBo3ju63ykkn7xg9OCeqDPXzSiMMkvFWBlGC
         q3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5h1iG4VMr/oPe/3JS4hs0NRVQy0RxyptKmSJXzYCzm8=;
        b=DBIQc6n+XdfnqBjlS916aVbMk/RhoJO6o5jRH1G8oawNIcm8jOsRwUk+/ZM+NH1Rng
         vwx7SGty3MVVij+FemWOysyLHwznAM6vqu7C2X+xZAVr9Uzaj9+j6OPvhh8cOPPNclLH
         9g52S231HouEIZ71LpRLXPsJcxr2dRFfgI7tPCEgtccj+wJOdSpeJ5UQA/p7J1Vo64FR
         uJzejT3kazXkSmaZ1gpszL0n+qN0eT+x7zegYr5ITLMaajnhbBq5l2u8NVb6qEPaIQP8
         N8JNAloDyDRsi8IC00Dneli/sGIzFS+CSf7JVVp6txhgPV69dqhqmY+kCHVBH6ydk6xr
         /0bA==
X-Gm-Message-State: APt69E0JTcotzHfukgINDkv3s2zU5dDtb4rU7CnUTSlDq/G6X5zmcMCK
        N6D6tCLvYBI9eO71/nYAiWIVu2drhPqR0deDw+A68Q==
X-Google-Smtp-Source: ADUXVKKI3nXGXeCs/izz9L5mZv/PrtJ8IpHM6FVq0wBJvUtp8bfbvd05MuOIgYWAYpYTpe4PlbBVeb71HzRhnTLSyLM=
X-Received: by 2002:a63:721c:: with SMTP id n28-v6mr539135pgc.96.1529047924046;
 Fri, 15 Jun 2018 00:32:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Fri, 15 Jun 2018 00:31:43
 -0700 (PDT)
In-Reply-To: <0000000000001f31eb056ea92fcb@google.com>
References: <0000000000001f31eb056ea92fcb@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 15 Jun 2018 09:31:43 +0200
Message-ID: <CACT4Y+aq3pDM4=fXwpAMNLiZWRC6H_050t4dgoK94kWxvV3pjg@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in xfrm_state_find
To:     syzbot <syzbot+131cd4c6d21724b99a26@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        icytxw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 9:30 AM, syzbot
<syzbot+131cd4c6d21724b99a26@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    1df165c8d2d6 kmsan: introduce kmsan_clear_user_page()
> git tree:       https://github.com/google/kmsan.git/master
> console output: https://syzkaller.appspot.com/x/log.txt?x=15336e97800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4ca1e57bafa8ab1f
> dashboard link: https://syzkaller.appspot.com/bug?extid=131cd4c6d21724b99a26
> compiler:       clang version 7.0.0 (trunk 329391)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12c7a417800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13710197800000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+131cd4c6d21724b99a26@syzkaller.appspotmail.com

This may be related to "BUG: KASAN: stack-out-of-bounds in
ipv6_addr_equal include/net/ipv6.h":
https://groups.google.com/d/msg/syzkaller/va_9cjZsHQE/Htc7sYY2BwAJ


> IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> 8021q: adding VLAN 0 to HW filter on device team0
> ==================================================================
> BUG: KMSAN: uninit-value in __arch_swab32
> arch/x86/include/uapi/asm/swab.h:10 [inline]
> BUG: KMSAN: uninit-value in __fswab32 include/uapi/linux/swab.h:59 [inline]
> BUG: KMSAN: uninit-value in __xfrm6_daddr_saddr_hash net/xfrm/xfrm_hash.h:29
> [inline]
> BUG: KMSAN: uninit-value in __xfrm_dst_hash net/xfrm/xfrm_hash.h:96 [inline]
> BUG: KMSAN: uninit-value in xfrm_dst_hash net/xfrm/xfrm_state.c:60 [inline]
> BUG: KMSAN: uninit-value in xfrm_state_find+0x2b15/0x4f40
> net/xfrm/xfrm_state.c:952
> CPU: 0 PID: 4464 Comm: syz-executor988 Not tainted 4.17.0-rc3+ #93
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x185/0x1d0 lib/dump_stack.c:113
>  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1084
>  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
>  __arch_swab32 arch/x86/include/uapi/asm/swab.h:10 [inline]
>  __fswab32 include/uapi/linux/swab.h:59 [inline]
>  __xfrm6_daddr_saddr_hash net/xfrm/xfrm_hash.h:29 [inline]
>  __xfrm_dst_hash net/xfrm/xfrm_hash.h:96 [inline]
>  xfrm_dst_hash net/xfrm/xfrm_state.c:60 [inline]
>  xfrm_state_find+0x2b15/0x4f40 net/xfrm/xfrm_state.c:952
>  xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:1393 [inline]
>  xfrm_tmpl_resolve net/xfrm/xfrm_policy.c:1437 [inline]
>  xfrm_resolve_and_create_bundle+0xc31/0x5270 net/xfrm/xfrm_policy.c:1833
>  xfrm_lookup+0x606/0x39d0 net/xfrm/xfrm_policy.c:2163
>  xfrm_lookup_route+0xfa/0x360 net/xfrm/xfrm_policy.c:2283
>  ip_route_output_flow+0x35b/0x3b0 net/ipv4/route.c:2574
>  udp_sendmsg+0x2289/0x33f0 net/ipv4/udp.c:1006
>  udpv6_sendmsg+0x1291/0x3f40 net/ipv6/udp.c:1175
>  inet_sendmsg+0x48d/0x740 net/ipv4/af_inet.c:798
>  sock_sendmsg_nosec net/socket.c:629 [inline]
>  sock_sendmsg net/socket.c:639 [inline]
>  ___sys_sendmsg+0xec0/0x1310 net/socket.c:2117
>  __sys_sendmmsg+0x490/0x850 net/socket.c:2212
>  __do_sys_sendmmsg net/socket.c:2241 [inline]
>  __se_sys_sendmmsg net/socket.c:2238 [inline]
>  __x64_sys_sendmmsg+0x11c/0x170 net/socket.c:2238
>  do_syscall_64+0x154/0x220 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x4419c9
> RSP: 002b:00007ffdb3fa4608 EFLAGS: 00000217 ORIG_RAX: 0000000000000133
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004419c9
> RDX: 0000000000000001 RSI: 0000000020002000 RDI: 0000000000000003
> RBP: 00000000006cd018 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000217 R12: 00000000004026c0
> R13: 0000000000402750 R14: 0000000000000000 R15: 0000000000000000
>
> Local variable description: ----fl4_stack@udp_sendmsg
> Variable was created at:
>  udp_sendmsg+0xe5/0x33f0 net/ipv4/udp.c:841
>  udpv6_sendmsg+0x1291/0x3f40 net/ipv6/udp.c:1175
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
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
