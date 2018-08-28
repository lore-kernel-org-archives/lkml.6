Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D0FC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 04:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17656208E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 04:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lP01jo1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17656208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbeH1Hzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 03:55:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43446 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeH1Hzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 03:55:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id v66-v6so143075pgb.10;
        Mon, 27 Aug 2018 21:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h5FGzSeBSlg9pGpj7eXHgPwPgxIx+jQPXhktMiS3a+M=;
        b=lP01jo1jFYkq21nfaL7eKxeg5S3ZSQ/f1HbrES7YN9Q2Q9STmS6NpLQfB/zGb9lG8J
         vzvyqI8pX4kScSny/RinulIxTCPfgtc4B7G3ZnwtlGf9SqefV9BmDapaplgV2r8LOZIV
         pMObnSzag2a482IqsvYK/ePl03d8vP10dvfpuSv2s1zhXNnhPQDhx/IumPPxVSxCJrH0
         z9AFSL2EV7JQNQjsOBwm3+SWICcZvGnGQ6BNcQTOQc1DRhcMwLfscS++XIy29FZybIVz
         cuEyjiehxPBBExPnBzq+9afIpXMHVjGDQYovlZ0Q0nbDEmW+wCNSnc7Jris/K5QWky4q
         U3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h5FGzSeBSlg9pGpj7eXHgPwPgxIx+jQPXhktMiS3a+M=;
        b=lIHwdwKUQ+zFq6eacY9HgxU/WvoDqhMW8fhA4FOebJ9DHeRipcDaWcIv062n3RhDC3
         wb7+DkV6oLNC9iX2A7v2lih5CaU0DER3KxwNDskLi/3o6Uz+SmgiuBs+ZikMZoJUfX+M
         uaFZ+8El9duEhodmldBWEQnuFNeltFVK+YXThbzOgBx2YIkluC6hMbpTNRHSifEw7rM1
         mnfme6vTY7JY83ksApP6770RCqrPfmmWFBjfJmtYbKxZNGvozq1LZVtC71CfZUG7AUtB
         9pjjD5Oe+pxYMkg/laepvv6gv/iAswxoT4fxcFju9/ph/UHl2X4mFgvJrMjLSntxA9VA
         ZBIw==
X-Gm-Message-State: APzg51CCqXj/xSJ1WjXEnfgNmemKt5H3zxuESwGVYK2LnIkXd9P1ImMP
        8WjRBb6tFBm598UsJGrXm/s=
X-Google-Smtp-Source: ANB0Vdb/gAgLtkzVWzVvoirmTSFbg3C9oFRYs1wZITuwrrgkjun2lAkhXphau/hYrNCBuMd5NQKaqw==
X-Received: by 2002:a63:cf15:: with SMTP id j21-v6mr14430941pgg.195.1535429158514;
        Mon, 27 Aug 2018 21:05:58 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::1:695e])
        by smtp.gmail.com with ESMTPSA id l9-v6sm863209pgg.79.2018.08.27.21.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 21:05:57 -0700 (PDT)
Date:   Mon, 27 Aug 2018 21:05:56 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     syzbot <syzbot+1ec5c5ec949c4adaa0c4@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Subject: Re: WARNING in format_decode (2)
Message-ID: <20180828040554.u5xbypakkzcibziq@ast-mbp>
References: <000000000000e12d4105746dcb0d@google.com>
 <20180827134626.1b943593@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827134626.1b943593@gandalf.local.home>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 01:46:26PM -0400, Steven Rostedt wrote:
> On Mon, 27 Aug 2018 10:10:04 -0700
> syzbot <syzbot+1ec5c5ec949c4adaa0c4@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    2ad0d5269970 Merge git://git.kernel.org/pub/scm/linux/kern..
> > git tree:       net-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15b8efba400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=79e695838ce7a210
> > dashboard link: https://syzkaller.appspot.com/bug?extid=1ec5c5ec949c4adaa0c4
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1626f761400000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+1ec5c5ec949c4adaa0c4@syzkaller.appspotmail.com
> > 
> > **                                                      **
> > **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
> > **********************************************************
> > ------------[ cut here ]------------
> > Please remove unsupported %WARNING: CPU: 0 PID: 6453 at lib/vsprintf.c:2149 format_decode+0x8fc/0xaf0  
> > lib/vsprintf.c:2149
> > Kernel panic - not syncing: panic_on_warn set ...
> > 
> > CPU: 0 PID: 6453 Comm: syz-executor7 Not tainted 4.18.0+ #190
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> > Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
> >   panic+0x238/0x4e7 kernel/panic.c:184
> >   __warn.cold.8+0x163/0x1ba kernel/panic.c:536
> >   report_bug+0x252/0x2d0 lib/bug.c:186
> >   fixup_bug arch/x86/kernel/traps.c:178 [inline]
> >   do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
> >   do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
> >   invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
> > RIP: 0010:format_decode+0x8fc/0xaf0 lib/vsprintf.c:2149
> > Code: e8 59 59 c9 fa 41 c6 04 24 12 e9 94 fd ff ff e8 4a 59 c9 fa 0f be f3  
> > 48 c7 c7 60 bc 89 87 c6 05 28 aa d2 01 01 e8 e4 e9 93 fa <0f> 0b 4d 8b 7d  
> > c0 e9 56 fe ff ff 48 8b bd 68 ff ff ff e8 cd 4f 08
> > RSP: 0018:ffff8801b6b27688 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: ffffffff816422b1 RDI: ffff8801b6b27378
> > RBP: ffff8801b6b27730 R08: ffff8801b69a0040 R09: 0000000000000006
> > R10: 0000000000000000 R11: 0000000000000000 R12: ffff8801b6b277a8
> > R13: ffff8801b6b27708 R14: 0000000000000000 R15: ffff8801b6b27b04
> >   vsnprintf+0x185/0x1b60 lib/vsprintf.c:2245
> >   vscnprintf+0x2d/0x80 lib/vsprintf.c:2396
> >   __trace_array_vprintk.part.60+0xc7/0x330 kernel/trace/trace.c:2990
> >   __trace_array_vprintk kernel/trace/trace.c:3021 [inline]
> >   trace_array_vprintk kernel/trace/trace.c:3021 [inline]
> >   trace_vprintk+0x5f/0x90 kernel/trace/trace.c:3059
> >   __trace_printk+0xce/0x120 kernel/trace/trace_printk.c:237
> >   ____bpf_trace_printk kernel/trace/bpf_trace.c:274 [inline]
> 
> Looks like a bug in the bpf trace printk code.

yes. looks like %p% slipped past bpf_trace_printk() runtime checks.

