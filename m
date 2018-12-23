Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3ECC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 10:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8B0218FD
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 10:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGzGMcrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeLWKDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 05:03:32 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50527 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeLWKDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 05:03:32 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so12878333iti.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 02:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OLz5intVrocJqGyeZHuv8h1cfGs+X+Ax5vvNU9Gmsc0=;
        b=nGzGMcrdj71A68y9wOZXAgtNUQD185OMEx3+dxGNot2zi0DZVaopN8wo4FftchWpzx
         1cPaSUNL0mwff73dfXUfHTJHk+WJuRF2Y6WCZmIFapY2iqLCdtNr8dZtsRT1ttchQiIp
         ySY9d+PaXkgbc3nU8F594JEp2u0O/fPtvAAU8Goh/PaTx2FzLzwvgwKRfGt8Cp3d5e1B
         gTGo9KT5gNtcMr7LMWlXmrSE5sN47bk3ZwsDEYC/Ncsw5xnf94XF8zDwOHDtxxy4WRP2
         a8REILy9hBq3LZOoO4BSPO3YaiBx4Yzbxa6E24+0duXovkYvpfhnFVnE1QlBZGBAzl/u
         /MIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OLz5intVrocJqGyeZHuv8h1cfGs+X+Ax5vvNU9Gmsc0=;
        b=Cj8cgZTg8CYwnEtQ+wlYY7bFB3Oqui9Djzuqno+d9YZEZ7Mbh9L14sf2VxzrAEhlpH
         UU14pl58CorESkw1sPIeDjVrmOhEHd4M7ENvETmgsG3/BbyjcdMPpr2zsL22D3NcTiwY
         j8NKrv+LWnmwZVdLW6AemIJf4Gt422daDi5nwtOISStoYFP9nJcLqzLaiKunUxt4TXNz
         LIg/LtFzX7vmmDqupJmt+SToKSkMEl7D9auSPRFEMZ2G66zJs/FHJHcnDd97/VugCzpP
         K9nmVt7cnm8Z7200khn9Y7bzGvqO0RzrFbGhs1Ai8DzCOubLjzVdcnXzVPZhsB1t/GQb
         cVEg==
X-Gm-Message-State: AJcUukeB7ft7uRuVBhawiwnTrEX51fPrmjiYhoQfbvb/el0BadLEp41M
        tjQHeyeZLITvZ3cFYTzgkXlp1IcgERVcT3wnk3IOkw==
X-Google-Smtp-Source: ALg8bN6EMupK4CdsK35rdZYkkbJXg21vPvf6tdRkICmiw0j27oWBNhvq7g6gdo8OeI5ZG2L59TxCWT35i/sS8JA/yLg=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr5826448iti.166.1545559033003;
 Sun, 23 Dec 2018 01:57:13 -0800 (PST)
MIME-Version: 1.0
References: <00000000000051ee78057cc4d98f@google.com> <CACT4Y+YX3=OLqfmWwhHVCQz+HwE=53VH9c1E2M+rgbF=UVTV5A@mail.gmail.com>
 <ab2fb696-8d3b-9720-a8a0-99c66a080605@colorfullife.com> <CACT4Y+Y-c7FgSTKyHqpRZu3eKLo5QfXy10axTSwWkU4MUgjFgw@mail.gmail.com>
 <87614226-e895-c3a3-3626-b0fbe7e191be@colorfullife.com> <CACT4Y+bU4mLF1tEhw6mKf1m1W63OGvaFhAsTrpTW0M5MFXekRQ@mail.gmail.com>
In-Reply-To: <CACT4Y+bU4mLF1tEhw6mKf1m1W63OGvaFhAsTrpTW0M5MFXekRQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 23 Dec 2018 10:57:01 +0100
Message-ID: <CACT4Y+Zynq-URqgJNyCZyTPM80GU8DndtKv=BFDU9_U=f0KceA@mail.gmail.com>
Subject: Re: general protection fault in put_pid
To:     manfred <manfred@colorfullife.com>
Cc:     syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        ktsanaktsidis@zendesk.com, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 8:37 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Sat, Dec 22, 2018 at 8:07 PM Manfred Spraul <manfred@colorfullife.com> wrote:
> >
> > Hi Dmitry,
> >
> > On 12/20/18 4:36 PM, Dmitry Vyukov wrote:
> > > On Wed, Dec 19, 2018 at 10:04 AM Manfred Spraul
> > > <manfred@colorfullife.com> wrote:
> > >> Hello Dmitry,
> > >>
> > >> On 12/12/18 11:55 AM, Dmitry Vyukov wrote:
> > >>> On Tue, Dec 11, 2018 at 9:23 PM syzbot
> > >>> <syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com> wrote:
> > >>>> Hello,
> > >>>>
> > >>>> syzbot found the following crash on:
> > >>>>
> > >>>> HEAD commit:    f5d582777bcb Merge branch 'for-linus' of git://git.kernel...
> > >>>> git tree:       upstream
> > >>>> console output: https://syzkaller.appspot.com/x/log.txt?x=135bc547400000
> > >>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
> > >>>> dashboard link: https://syzkaller.appspot.com/bug?extid=1145ec2e23165570c3ac
> > >>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > >>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16803afb400000
> > >>> +Manfred, this looks similar to the other few crashes related to
> > >>> semget$private(0x0, 0x4000, 0x3f) that you looked at.
> > >> I found one unexpected (incorrect?) locking, see the attached patch.
> > >>
> > >> But I doubt that this is the root cause of the crashes.
> > >
> > > But why? These one-off sporadic crashes reported by syzbot looks
> > > exactly like a subtle race and your patch touches sem_exit_ns involved
> > > in all reports.
> > > So if you don't spot anything else, I would say close these 3 reports
> > > with this patch (I see you already included Reported-by tags which is
> > > great!) and then wait for syzbot reaction. Since we got 3 of them, if
> > > it's still not fixed I would expect that syzbot will be able to
> > > retrigger this later again.
> >
> > As I wrote, unless semop() is used, sma->use_global_lock is always 9 and
> > nothing can happen.
> >
> > Every single-operation semop() reduces use_global_lock by one, i.e a
> > single semop call as done here cannot trigger the bug:
> >
> > https://syzkaller.appspot.com/text?tag=ReproSyz&x=16803afb400000
>
> It contains "repeat":true,"procs":6, which means that it run 6
> processes running this test in infinite loop. The last mark about
> number of tests executed was:
> 2018/12/11 18:38:02 executed programs: 2955
>
> > But, one more finding:
> >
> > https://syzkaller.appspot.com/bug?extid=1145ec2e23165570c3ac
> >
> > https://syzkaller.appspot.com/text?tag=CrashLog&x=109ecf6e400000
> >
> > The log file contain 1080 lines like these:
> >
> > > semget$private(..., 0x4003, ...)
> > >
> > > semget$private(..., 0x4006, ...)
> > >
> > > semget$private(..., 0x4007, ...)
> >
> > It ends up as kmalloc(128*0x400x), i.e. slightly more than 2 MB, an
> > allocation in the 4 MB kmalloc buffer:
> >
> > > [ 1201.210245] kmalloc-4194304      4698112KB    4698112KB
> > >
> > i.e.: 1147 4 MB kmalloc blocks --> are we leaking nearly 100% of the
> > semaphore arrays??
>
> /\/\/\/\/\/\
>
> Ha, this is definitely not healthy.

I can reproduce this infinite memory consumption with the C program:
https://gist.githubusercontent.com/dvyukov/03ec54b3429ade16fa07bf8b2379aff3/raw/ae4f654e279810de2505e8fa41b73dc1d77778e6/gistfile1.txt

But this is working as intended, right? It just creates infinite
number of large semaphore sets, which reasonably consumes infinite
amount of memory.
Except that it also violates the memcg bound and a process can have
effectively unlimited amount of such "drum memory" in semaphores.




> > This one looks similar:
> >
> > https://syzkaller.appspot.com/bug?extid=c92d3646e35bc5d1a909
> >
> > except that the array sizes are mixed, and thus there are kmalloc-1M and
> > kmalloc-2M as well.
> >
> > (and I did not count the number of semget calls)
> >
> >
> > The test apps use unshare(CLONE_NEWNS) and unshare(CLONE_NEWIPC), correct?
> >
> > I.e. no CLONE_NEWUSER.
> >
> > https://github.com/google/syzkaller/blob/master/executor/common_linux.h#L1523
>
> CLONE_NEWUSER is used on some instances as well:
> https://github.com/google/syzkaller/blob/master/executor/common_linux.h#L1765
> This crash happened on 2 different instances and 1 of them uses
> CLONE_NEWUSER and another does not.
> If it's important because of CAP_ADMIN in IPC namespace, then all
> instances should have it (instances that don't use NEWUSER are just
> root).
