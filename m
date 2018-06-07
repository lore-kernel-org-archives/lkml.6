Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1RV+L5FsGVuYTAAAmS7hNA
	; Thu, 07 Jun 2018 17:34:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8D8996074D; Thu,  7 Jun 2018 17:34:37 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4gPZYUg"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B2A0C601C3;
	Thu,  7 Jun 2018 17:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B2A0C601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934190AbeFGRee (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:34:34 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45109 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933667AbeFGRec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:34:32 -0400
Received: by mail-pg0-f68.google.com with SMTP id z1-v6so5076419pgv.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 10:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lHVxpV2EVdoYKc/fwrqIwN6GkUal5OunsOkx8ZOJZrU=;
        b=I4gPZYUgcpTv0HReIKY9z5TY6KbvTi9sWGMadBhdVx4fW6CZYdnXo6lO9TM62M4gIx
         CTuWTioIMbJwbD/W7ZynYr3Fl3bFNpRbelP1zp7qFV9K3wRVyh7H4Xi+P70J6p9Nq3fD
         qbVmG/++NbBPvo8JKiVi/SJLQKAWHtmF+tiVsHGrAfCWz1zOAyg2C2UEcD1fZDXyJEDK
         VKXBDe8D+Nc9PpCk9UE9PODnWfHMgZA6IvnAZc6lt87vCXY8zklTboj9CNuAB07ttQ0Z
         VR6IXExlJ0nVQq1fMf8iWqHbD9c4zFL7OY1aQ61j1JnroQnuobClokbXHgSErpzUId5N
         Rngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lHVxpV2EVdoYKc/fwrqIwN6GkUal5OunsOkx8ZOJZrU=;
        b=qZg6Z5M8xCwuNWa86BcxC3hQVSVgCMzHg/QasMzZz47SP0kmpFpOzGacxEfUoeTvyw
         tn4mlqrhsr0rAuN/lWi6PEcWTzWknubg2hxpqI33wZn8ugIOrqjBzOnj621nWEvgkagp
         BymirjOgmkBOtINBcSKTs4jDeBGO9V9NdHu0ocbXHmxbZdQXPTUuEifM+Z70v+Q5uMPZ
         GUQRq2xsR2eOqdKX/gQU7JEG3BxYdpJGHExOA6vYeCYq06Zq4nIQMhBaE1AyK31xlISH
         gckivP3m1eUv3jRk+R+OAAgK5aUkWNybjC6BeJ/Nc0OWIHGbX7nBWtwOcAjqxE8+hGNv
         gSeg==
X-Gm-Message-State: APt69E3tx8axQGfbEiLCZrK4vrMDv5gnSbL3nUgv1DN3kuU0jfVrq1Nt
        E9zcKLQHyoHjge3ROewFDMR56Jj+JIn9Mlyf2IjFFQ==
X-Google-Smtp-Source: ADUXVKID0DfbANQtbOcL2UOrqCgJzgEolzdSM+oZhDyNS0HOAtsqtS9kriTfZYnF56vDLm9SuVs9Jdtb7wePeI3GYKU=
X-Received: by 2002:a65:4bcd:: with SMTP id p13-v6mr2362034pgr.114.1528392871441;
 Thu, 07 Jun 2018 10:34:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Thu, 7 Jun 2018 10:34:10
 -0700 (PDT)
In-Reply-To: <0000000000009a3b5b056e109e42@google.com>
References: <0000000000009a3b5b056e109e42@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 7 Jun 2018 19:34:10 +0200
Message-ID: <CACT4Y+Ym9AV7rRi+EBPst_CeiA1CZy3RkgiQOvAm6zJ-Y4XA=A@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in ebt_stp_mt_check (2)
To: syzbot <syzbot+da4494182233c23a5fcf@syzkaller.appspotmail.com>
Cc: bridge@lists.linux-foundation.org, coreteam@netfilter.org,
        David Miller <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        stephen hemminger <stephen@networkplumber.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 7:29 PM, syzbot
<syzbot+da4494182233c23a5fcf@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    c6a6aed994b6 kmsan: remove dead code to trigger syzbot build
> git tree:       https://github.com/google/kmsan.git/master
> console output: https://syzkaller.appspot.com/x/log.txt?x=17bde74f800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=848e40757852af3e
> dashboard link: https://syzkaller.appspot.com/bug?extid=da4494182233c23a5fcf
> compiler:       clang version 7.0.0 (trunk 334104)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+da4494182233c23a5fcf@syzkaller.appspotmail.com

Hi Stephen,

This strikes again.

The first part of the check is par->nft_compat. I don't see where
ebt_check_entry initializes it. Should it? Or matches should not look at it?



> ==================================================================
> BUG: KMSAN: uninit-value in ebt_stp_mt_check+0x24b/0x450
> net/bridge/netfilter/ebt_stp.c:162
> CPU: 0 PID: 12006 Comm: syz-executor7 Not tainted 4.17.0+ #3
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x185/0x1d0 lib/dump_stack.c:113
>  kmsan_report+0x149/0x260 mm/kmsan/kmsan.c:1084
>  __msan_warning_32+0x6e/0xc0 mm/kmsan/kmsan_instr.c:620
>  ebt_stp_mt_check+0x24b/0x450 net/bridge/netfilter/ebt_stp.c:162
>  xt_check_match+0x1438/0x1650 net/netfilter/x_tables.c:506
>  ebt_check_match net/bridge/netfilter/ebtables.c:372 [inline]
>  ebt_check_entry net/bridge/netfilter/ebtables.c:702 [inline]
>  translate_table+0x4e88/0x6120 net/bridge/netfilter/ebtables.c:943
>  do_replace_finish+0x1258/0x2ea0 net/bridge/netfilter/ebtables.c:999
>  do_replace+0x719/0x780 net/bridge/netfilter/ebtables.c:1138
>  do_ebt_set_ctl+0x2ab/0x3c0 net/bridge/netfilter/ebtables.c:1517
>  nf_sockopt net/netfilter/nf_sockopt.c:106 [inline]
>  nf_setsockopt+0x47c/0x4e0 net/netfilter/nf_sockopt.c:115
>  ip_setsockopt+0x24b/0x2b0 net/ipv4/ip_sockglue.c:1251
>  udp_setsockopt+0x108/0x1b0 net/ipv4/udp.c:2416
>  sock_common_setsockopt+0x13b/0x170 net/core/sock.c:3039
>  __sys_setsockopt+0x496/0x540 net/socket.c:1903
>  __do_sys_setsockopt net/socket.c:1914 [inline]
>  __se_sys_setsockopt net/socket.c:1911 [inline]
>  __x64_sys_setsockopt+0x15c/0x1c0 net/socket.c:1911
>  do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x4559f9
> RSP: 002b:00007f45b9246c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 00007f45b92476d4 RCX: 00000000004559f9
> RDX: 0000000000000080 RSI: 0000000000000000 RDI: 0000000000000014
> RBP: 000000000072bea0 R08: 0000000000000300 R09: 0000000000000000
> R10: 0000000020000480 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000004c0d6d R14: 00000000004d07c8 R15: 0000000000000000
>
> Local variable description: ----mtpar.i@translate_table
> Variable was created at:
>  translate_table+0xbb/0x6120 net/bridge/netfilter/ebtables.c:831
>  do_replace_finish+0x1258/0x2ea0 net/bridge/netfilter/ebtables.c:999
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
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000009a3b5b056e109e42%40google.com.
> For more options, visit https://groups.google.com/d/optout.
