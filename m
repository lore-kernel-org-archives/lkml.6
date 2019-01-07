Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6FCC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A9720989
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LGWLUn1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfAGJFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:05:12 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40286 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfAGJFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:05:11 -0500
Received: by mail-it1-f196.google.com with SMTP id h193so90049ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 01:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UT5xsSD7JKUcO/cE3VuA8FmFLS1qFWWqK5zyFRF8KY4=;
        b=LGWLUn1K6/8uhyIWlBvQCPA1nLgMIOi0Vhl4aCU1f5IdeWE8LfVrB+YO6AoRkW5/Hx
         ZzRQxhl2AYnquPeqLHiLgtDziTlJ7/xZr6qn1eoMrt6KT0Je4lHBAKvV36HMYR6WcWQh
         ZqdVFlfELQK78FvBRnLphsD4ADReqYlOva9q/5T+xUDbWAud/GQgygOX9bA1eLo5jAGZ
         ZzK4QKTazVx6trqlt4nEZEjn1CfCMQFjHhZkwefvNCPo/Muwigzp+0YKUv8+oI1d/Ta1
         jY8JKcHNBx+Sximndi8hpirVhm6O3Vyh8x9XrLNt05obhW2BYXfhmzTzxlsCXBfV99EV
         e3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UT5xsSD7JKUcO/cE3VuA8FmFLS1qFWWqK5zyFRF8KY4=;
        b=W4egNpQv4rm7+IxIpfHTLPES0NE1/c6s7zqhcr10wtCs5srbLRZm1NkNrQz1B7QC69
         RKAcNK2lkMhSERBGbOCkWLbrBfmPMoEQGv1T7HAaPtR7ZGrAWtmAkaFeSNKVaTgZi9yz
         0/4K+8yAw/nTmtsT9xu8U3083KXQ8KG3wHKs+st/GX2mVj+VsUM8UJ/1ioYu0iIUjkzd
         QxQIEnxdqL+GcB254U89bnKo6R0VK6i76uk0wSd6nwUWiLXadHT/r4UceZNxGBYu7ddo
         9GIB+XFa4mv5xH6j6zsQUPkcasMmMiWCgHr77OwsX3ou6pWp5pg0xgdftzrOpgQRw6/S
         nBtQ==
X-Gm-Message-State: AA+aEWZUUqnuDHTsf0cFEIScyyQBSEbQOVW07maKQP55GsFNF/erYB3G
        ccLWMDROfcz3FvedmUvoQP2slLND9W4To2f0F3vyoJnSLkO2Cw==
X-Google-Smtp-Source: AFSGD/Vcu9W81uNpClqiXBUrKlYbOPKIlXnzBQIVSAkFJUsa7MwktF+2Af9gn/ue5fPfOSHkaCAygNxjqwzINpe2J2s=
X-Received: by 2002:a02:8904:: with SMTP id o4mr39614065jaj.35.1546851910324;
 Mon, 07 Jan 2019 01:05:10 -0800 (PST)
MIME-Version: 1.0
References: <000000000000513fb7057e8d7013@google.com> <f2e566ac-5c4c-11ae-d436-ebb3522a2195@gmail.com>
 <20190103210743.6518841e@redhat.com> <CA+FuTScFwA3F44MvbaWrOYJ2EYgdKAmoMzEGjOLcz3ZPVQLLDA@mail.gmail.com>
 <20190103225404.66b0ec9f@redhat.com> <CACT4Y+aAofhchOpKTjLGGkQb5PAa74Uyp7kowdSoAwt130ZpAg@mail.gmail.com>
 <20190104115435.478b4b4a@redhat.com> <CACT4Y+bRLOVCx9Z=vCMspjzGrcnNFqNGWxDwiwYZbw2LTh__FA@mail.gmail.com>
 <20190104181424.5ad4b1de@redhat.com> <CACT4Y+bq+X6UFTWmbGz1V0GAjPXizxfk_pLqcq8KkDkp3K-ERg@mail.gmail.com>
 <20190104190544.4b0bfaee@redhat.com>
In-Reply-To: <20190104190544.4b0bfaee@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 7 Jan 2019 10:04:58 +0100
Message-ID: <CACT4Y+bbRvGbLXEQzqUoDJhxNT4HOLj329-EFCTW4NeMA8q76w@mail.gmail.com>
Subject: Re: kernel panic: stack is corrupted in udp4_lib_lookup2
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 7:05 PM Stefano Brivio <sbrivio@redhat.com> wrote:
>
> On Fri, 4 Jan 2019 18:26:16 +0100
> Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > On Fri, Jan 4, 2019 at 6:14 PM Stefano Brivio <sbrivio@redhat.com> wrote:
> > >
> > > On Fri, 4 Jan 2019 12:05:04 +0100
> > > Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > > I've added these as tests:
> > > >
> > > > https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/341
> > > > https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/342
> > > > https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/343
> > > > https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/344
> > > >
> > > > Will try to figure out how to distinguish them from true corrupted
> > > > reports. Usually when Call Trace does not have any frames, it's a sign
> > > > of a corrupted report, and in other crashes we see the same report but
> > > > with a stack trace. But some stack-corruption-related reliably don't
> > > > have stack traces (not corrupted). But then some other
> > > > stack-corruption-related crashes do have stack traces, and for these
> > > > no stack trace again means a corrupted kernel output. Amusingly this
> > > > is one of the most complex parts of syzkaller.
> > >
> > > I'm not sure how complicated that would be, but what about some metric
> > > based on valid symbol names being reported?
> >
> > Please elaborate. What do you mean by "valid symbol names"?
>
> I mean a symbol name listed in /proc/kallsyms on the running system.
>
> This is usually my minimum threshold for "I can do something with this
> report" -- which doesn't mean it's necessarily valid, but well, if you
> have that, it means that at least something worked in the reporting,
> and you can at least start having a look at a specific function.
>
> > Note that corrupted output detection solves 2 problems:
> > 1. Do we think the output is truncated to the point of being not useful?
> > E.g. sometimes kernel produces just 1 line:
> >
> > general protection fault: 0000 [#1] PREEMPT SMP KASAN
> >
> > This is sure a crash, but it's not too useful to report.
>
> Sure. In those tests above you have:
> - 341: udp6_lib_lookup2+0x622, handle_irq+0x2cb
> - 342: __sanitizer_cov_trace_pc+0x8, handle_irq+0x2cb
> - 343: __udp6_lib_err, etc.
> - 344: __udp6_lib_lookup+0x1d, etc.
>
> and this makes all those reports at least minimally useful.
>
> > 2. Do we have any reasons to think we extracted bogus crash identity?
> > E.g. crash intermixed with output from another thread so that we say
> > "something-bad in function foo", when in fact function foo come from
> > output of the second non-crashing thread.
>
> Okay, this looks way more complicated :)

Yeah, unfortunately, it's quite complicated.
Just today this gen popped up. You won't find any ODEBUG checks at
that stack, it's completely unrelated and come from another task.

------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: timer_list hint:
delayed_work_timer_fn+0x0/0x90 kernel/workqueue.c:4916
WARNING: CPU: 1 PID: 45 at lib/debugobjects.c:325
debug_print_object+0x16a/0x250 lib/debugobjects.c:325
CPU: 0 PID: 13619 Comm: syz-executor1 Not tainted 4.20.0+ #13
Kernel panic - not syncing: panic_on_warn set ...
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
 warn_alloc.cold+0xc2/0x1c8 mm/page_alloc.c:3570
 __vmalloc_node_range+0x57a/0x910 mm/vmalloc.c:1766
 __vmalloc_node mm/vmalloc.c:1795 [inline]
 __vmalloc_node_flags mm/vmalloc.c:1809 [inline]
 vmalloc+0x6b/0x90 mm/vmalloc.c:1831
 sel_write_load+0x1de/0x470 security/selinux/selinuxfs.c:557
 __vfs_write+0x116/0xb40 fs/read_write.c:485
 vfs_write+0x20c/0x580 fs/read_write.c:549
 ksys_write+0x105/0x260 fs/read_write.c:598
 __do_sys_write fs/read_write.c:610 [inline]
 __se_sys_write fs/read_write.c:607 [inline]
 __x64_sys_write+0x73/0xb0 fs/read_write.c:607
 do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
