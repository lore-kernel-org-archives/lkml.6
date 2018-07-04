Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B3CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E29F24042
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcbh/QGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E29F24042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbeGDVTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:19:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35706 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752667AbeGDVTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:19:43 -0400
Received: by mail-pf0-f196.google.com with SMTP id q7-v6so2394459pff.2;
        Wed, 04 Jul 2018 14:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C67nTF70LUIG2sB23wxRswJAKPQAtjgzN95+YZ3mv48=;
        b=lcbh/QGUsa5E8HSsvKuthaaCiq9dNd0fW9lSf/UtATe7gh+uc6x+9fkfQwStbFxvBI
         KUFdg1PScxJMfnynWVsivxJm96XNtVlGtinMbSHLM22kcwM9w3V8IIVTic/lpNr+u9v+
         BmMwWuDgSiCSVGmEwGBEAx9+9g2jEyjBk/WmOKt1QZmvAmL58xxYjdYSzQmcP2AmDHwH
         kkf7+OdmXRCOZFjHKCgH+oXD2l4V5LdbNDnMIK25YCdNlNMlMD6OHIFsgBYjF/Zr570H
         +mTz/BjRrtMFacHPmNgtJC+PiC8HK0thIrTQX/mII9hjBjxihiAffbU6xaNLGxeoBnqi
         bU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C67nTF70LUIG2sB23wxRswJAKPQAtjgzN95+YZ3mv48=;
        b=BG/00aIAYEdMxWCfdHLdv8choTkuGGh7knICMvWTYFfzACnlzAE6sGkftgMdR48y8v
         UmY+oMeod1hGviPWO5VzMGxZsK4z1RZneWkYJHjp3fNYchOYleg4B5zjHdbrbQet/gnL
         GPWZfJ8nMnvcDn0gPjaoy4H6fpalGR7L1wp2htMEedgxT+EbdIv3GOREjqLfCnlWIuML
         hZ50Ld3XAbvoFFiOgXB3XvOY9Ox8/S3e1Kf98zrTFjhIk6H0euS6XOf0AeyqEbzsWTse
         9sM3PhyhvOqRyXMESGIPb9j3BTHbwDJzyTcP4hKtjl8eBryB0VyuUYW+X7myCU/8xqCs
         H8jA==
X-Gm-Message-State: APt69E2CH4iig+C6OTutIJwBW7JqKJJtDF2B4z1FWmdYgf8TEHAFrpFC
        0XsaoexsD505OXXdjGeXaD4=
X-Google-Smtp-Source: AAOMgpe/UAdL1SIw5klyO1DJNCe041rrj+O89i3ydQSOU6sFmnpgkknx9wRjvTEOoVeBBL+VZQUJJg==
X-Received: by 2002:a63:b605:: with SMTP id j5-v6mr3250454pgf.437.1530739182904;
        Wed, 04 Jul 2018 14:19:42 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id d23-v6sm11811694pfe.2.2018.07.04.14.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 14:19:42 -0700 (PDT)
Date:   Wed, 4 Jul 2018 14:19:40 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     syzbot <syzbot+d7deafa2c73b7a2b74ef@syzkaller.appspotmail.com>
Cc:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        kadlec@blackhole.kfki.hu, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Subject: Re: WARNING: ODEBUG bug in do_ipt_get_ctl
Message-ID: <20180704211940.GF725@sol.localdomain>
References: <94eb2c1fc4787542480565bf32b1@google.com>
 <001a1144a42015356b05660bcb98@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a1144a42015356b05660bcb98@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2018 at 08:22:01AM -0800, syzbot wrote:
> syzbot has found reproducer for the following crash on net-next commit
> f74290fdb363665538743d14c4f00aeacdb68d87 (Sat Feb 24 05:04:20 2018 +0000)
> Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
> 
> So far this crash happened 3 times on net-next, upstream.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+d7deafa2c73b7a2b74ef@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed.
> 
> ------------[ cut here ]------------
> ODEBUG: free active (active state 0) object type: timer_list hint:
> delayed_work_timer_fn+0x0/0x90 kernel/workqueue.c:1355
> WARNING: CPU: 1 PID: 4244 at lib/debugobjects.c:291
> debug_print_object+0x166/0x220 lib/debugobjects.c:288
> Kernel panic - not syncing: panic_on_warn set ...
> 
> CPU: 1 PID: 4244 Comm: syzkaller150583 Not tainted 4.16.0-rc2+ #241
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x24d lib/dump_stack.c:53
>  panic+0x1e4/0x41c kernel/panic.c:183
>  __warn+0x1dc/0x200 kernel/panic.c:547
>  report_bug+0x211/0x2d0 lib/bug.c:184
>  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x58/0x80 arch/x86/entry/entry_64.S:957
> RIP: 0010:debug_print_object+0x166/0x220 lib/debugobjects.c:288
> RSP: 0018:ffff8801cc2c7778 EFLAGS: 00010082
> RAX: dffffc0000000008 RBX: 0000000000000003 RCX: ffffffff815abe7e
> RDX: 0000000000000000 RSI: 1ffff10039858e9f RDI: 1ffff10039858e74
> RBP: ffff8801cc2c77b8 R08: 0000000000000000 R09: 1ffff10039858e46
> R10: ffffed0039858f1e R11: ffffffff86f395b8 R12: 0000000000000001
> R13: ffffffff86f4ae20 R14: ffffffff86407fa0 R15: ffffffff815fe8e0
>  __debug_check_no_obj_freed lib/debugobjects.c:745 [inline]
>  debug_check_no_obj_freed+0x662/0xf1f lib/debugobjects.c:774
>  __vunmap+0x112/0x380 mm/vmalloc.c:1530
>  vfree+0x50/0xe0 mm/vmalloc.c:1606
>  copy_entries_to_user net/ipv4/netfilter/ip_tables.c:880 [inline]
>  get_entries net/ipv4/netfilter/ip_tables.c:1035 [inline]
>  do_ipt_get_ctl+0x7f5/0xac0 net/ipv4/netfilter/ip_tables.c:1708
>  nf_sockopt net/netfilter/nf_sockopt.c:104 [inline]
>  nf_getsockopt+0x6a/0xc0 net/netfilter/nf_sockopt.c:122
>  ip_getsockopt+0x152/0x200 net/ipv4/ip_sockglue.c:1572
>  tcp_getsockopt+0x82/0xd0 net/ipv4/tcp.c:3332
>  sock_common_getsockopt+0x95/0xd0 net/core/sock.c:2938
>  SYSC_getsockopt net/socket.c:1881 [inline]
>  SyS_getsockopt+0x178/0x340 net/socket.c:1863
>  do_syscall_64+0x280/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x455faa
> RSP: 002b:000000000080e8c8 EFLAGS: 00000216 ORIG_RAX: 0000000000000037
> RAX: ffffffffffffffda RBX: 00000000006ea840 RCX: 0000000000455faa
> RDX: 0000000000000041 RSI: 0000000000000000 RDI: 0000000000000004
> RBP: 00000000006ea840 R08: 000000000080e8ec R09: 0000000000004000
> R10: 000000000080e9f0 R11: 0000000000000216 R12: 0000000000000004
> R13: 000000000080e9f0 R14: 000000000080e8f0 R15: 0000000000000000

This last occurred 4 months ago, the report doesn't make sense, and I can't
reproduce it even with the same kernel commit, kernel config, and C repro syzbot
gave.  The "debug objects" infrastructure is complaining that there was an
active timer freed by the 'vfree(counters);' in copy_entries_to_user(), via
IPT_SO_GET_ENTRIES.  But, 'counters' is simply an array of

	struct xt_counters {
		__u64 pcnt, bcnt;                       /* Packet and byte counters */
	};

There's no timer it can be freeing.

So I'm invalidating this report, as it probably was a weird bug elsewhere in the
kernel that has been fixed by now.

#syz invalid

- Eric
