Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2754FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54122145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mzZXozZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbeLQPKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:10:30 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:46685 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeLQPKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:10:30 -0500
Received: by mail-io1-f41.google.com with SMTP id v10so10175885ios.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1wnnihTXSI7C1dISr8t2StBBRXqW8X+jGNH93zCQ2AQ=;
        b=mzZXozZrxngzshDSOpzjpyDYbm7BACbbNmKxKnA1RfuLzrj/d+SRIXB+AGEW1DWofV
         yX4TsV1caYa7TSJzkhk5UOdtT2RPANkREP4B3MxmIKjlIwL10EvSMlTxALUbvHKyTajF
         XWqB+0e56lZz0fIdaQwuzLWBY8gx3gz016s6LkwyumjzjTvhHJaOQBn87l6ZR28sVl7l
         9G6mdOKuExPDiGmFMwHqaJjQkI63upuRE04wyRlAU8zaQdu73ToJiUTcpSsbPpeVMhUM
         SO9HgSa7zPxKPjpG8jL24dcyAReIvcNstAvKUDfVfnqbT+fzc85ibIL+Z8MbHNyT5eNx
         PA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1wnnihTXSI7C1dISr8t2StBBRXqW8X+jGNH93zCQ2AQ=;
        b=jLjXyHw7zQyy4sUofJFMNhETC/XXx/DZWTGSi39M6XlDNHbpT5Pzv0C71qbGb5rwgU
         ezfYTM6aM29tjwqdu1TZITmXK9n4405DA0ZPdgzXkLHRsXPT7J5WoOmsNQCRmP2BYrEp
         Puzl6hb5Gzx9MNAyF/b3mDRldcZNFbis22ZKyv6zubpqMYlLPEULa3UPO1TzOlqkZksG
         bsus9VYNMacFOD2k3eEzd4FtGCS+QrZYu7HB5K7Kl+8+5YmSAe5ktqKkWBmgyLXwf67X
         UN8Rt2RJLkX9WEJCDpHnlsJa9z1+qGZzW0w9/SCt48jRmtVuE5yzNpFQO7XqHVwBps5T
         kaKg==
X-Gm-Message-State: AA+aEWZNLIP0Gz4mM4bLcLR+ZGpU0bN3rAhVaxvSrS9/j+EthDyFUahK
        S86POIyZ0l9vM1PM97cTk8JDD2tffGw7MLWuRiOfvw==
X-Google-Smtp-Source: AFSGD/Uuco3DtgeQny9gB3gFGKpe//fW1k5bWrL+F/hmql29YCXTeb6zXbS9SAzwM+Jhwz8P/q59xTslNXkOQoSbjS4=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr11306544iom.11.1545059428959;
 Mon, 17 Dec 2018 07:10:28 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrW4F33LWWA=cWYZ2N9=veCmVfjhCCLnSv2qh=32fOAf-w@mail.gmail.com>
 <CACT4Y+aP4QSGBiLWt0iNHVJ4nMc_phthK9P+gTMd4d=exaAKwA@mail.gmail.com>
 <20180723111813.vbnsmx2k45eqzdkc@lakrids.cambridge.arm.com>
 <CACT4Y+YMYogSo+Wq=29A7fKC9hufsc_DwLrneOKtsefZP-9h6g@mail.gmail.com>
 <20180723124026.3uqc6r3mgge62onh@lakrids.cambridge.arm.com> <CACT4Y+ZN98Ti=zU6eWAUgNFchxENbz2EeeUtCcbMS9Lek-D9EA@mail.gmail.com>
In-Reply-To: <CACT4Y+ZN98Ti=zU6eWAUgNFchxENbz2EeeUtCcbMS9Lek-D9EA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 17 Dec 2018 16:10:16 +0100
Message-ID: <CACT4Y+bTCaaqL_teSh-BQu--bKqNW58J82sWR2ybGcR3KtCMqQ@mail.gmail.com>
Subject: Re: Making KASAN compatible with VMAP_STACK
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 2:51 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Jul 23, 2018 at 2:42 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> >> >> > Hi all-
> >> >> >
> >> >> > It would be really nice to make KASAN compatible with VMAP_STACK.
> >> >> > Both are valuable memory debugging features, and the fact that you
> >> >> > can't use both is disappointing.
> >> >> >
> >> >> > As far as I know, there are only two problems:
> >> >> >
> >> >> > 1. The KASAN shadow population code is a mess, and adding *anything*
> >> >> > to the KASAN shadow requires magical, fragile incantations.  It should
> >> >> > be cleaned up so that ranges can be easily populated without needing
> >> >> > to very carefully align things, call helpers in the right order, etc.
> >> >> > The core KASAN code should figure it out by itself.
> >> >> >
> >> >> > 2. The vmalloc area is potentially extremely large.  It might be
> >> >> > necessary to have a way to *depopulate* shadow space when stacks get
> >> >> > freed or, more generally, when vmap areas are freed.  Ideally KASAN
> >> >> > would integrate with the core vmalloc/vmap code and it would Just Work
> >> >> > (tm).  And, as a bonus, we'd get proper KASAN protection of vmalloced
> >> >> > memory.
> >> >> >
> >> >> > Any volunteers to fix this?
> >> >>
> >> >> Hi Andy,
> >> >>
> >> >> I understand that having most configs as orthogonal settings that can
> >> >> be enabled independently is generally good in intself, but I would
> >> >> like to understand what does VMAP_STACK add on top of KASAN in terms
> >> >> of debugging capabilities?
> >> >
> >> > VMAP_STACK makes it possible to detect stack overflows reliably at the
> >> > point of overflow.
> >> >
> >> > KASAN can't handle this reliably, even if it detects that an access is
> >> > out of the stack bounds, since handling this requires stack space.
> >> > Depending on a number of factors, this may be reported, might result in
> >> > recursive exceptions, etc.
> >>
> >> Interesting. Does VMAP_STACK detect task_struct smashing today? As far
> >> as I remember, the first version didn't.
> >
> > I assume you mean thread_info? Both arm64 and x86 moved the thread_info
> > out of the stack region by moving it into task_struct, which has always
> > been allocated separately. So thread_info smashing by stack overflow is
> > not possible.
> >
> > Regardless of VMAP_STACK, the stack region is purely stack on arm64 and
> > x86.
> >
> >> As an orthogonal measure we could add KASAN redzone between stack and
> >> task_struct, and make KASAN instrumentation detect when the new frame
> >> hits this redzone. We bump stack order under KASAN significantly, so
> >> adding, say 128 byte redzone should not be a problem. Does it make any
> >> sense?
> >
> > I don't think this is necessary since the two are allocated separately.
>
>
> I see. Thanks.
>
> So current KASAN failure mode would be silently smashing whatever page
> happens to be after the stack. If so, I guess combining it with
> VMAP_STACK would be useful, in particular, to prevent random assorted
> crashes coming out of syzbot.
>
> But I think I am not well qualified to actually do this.

A stack overflow just fired in:
https://groups.google.com/forum/#!topic/syzkaller-bugs/HoRZMT92WKk
on incoming network packet parsing (!). Was detected as some "innocent
WARNING" in rcu subsystem.

I filed https://bugzilla.kernel.org/show_bug.cgi?id=202009 to track
KASAN+VMAP_STACK.
