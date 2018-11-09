Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66056C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCA020818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CmGkAfZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCA020818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbeKJCVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:21:31 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:23884 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbeKJCVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:21:30 -0500
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wA9Gdvqw026986
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 01:39:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wA9Gdvqw026986
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541781597;
        bh=B1BJ/jXx67K4CCHSRAr/bWFbr+Z2VaERB2EjYTv9+NQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CmGkAfZDvpTZzgUtiRqd1AyhumWt3abIaYH8bI2ue5gftvCCwhPRoFl7AxSz5Vmmq
         9ED81fm49NNvUIdNgLU7p8070WBUuhEp+aJiFJhjnnMcGqNwL7Thdw0DDafWuwAl2g
         3POLolH/Lo4dHeta6iaI5LeyfOLAaSr/E80NgAnnLnc8wfxd4IyGgc2kF0FqocsNxw
         VQqUXz3S8KUCr9V5GRTuuHP2wap0ALzydIbPw/ZyRNzIIbtR6Mzco08QcoeOuIVsQb
         bj+Kvula/nLeqJ89xA4eRbr8x2M0Xtyi3E8PonLfcsTqVbL12uSjOKWnkzAa5TSJth
         EuymTw9lQz7XA==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id h18so1387257vsj.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 08:39:57 -0800 (PST)
X-Gm-Message-State: AGRZ1gJrHUhqZ2U+StTvXSKEJecNQbn6jrTa6liT/x6+3mSSIRqIzGoM
        GRedlTzDSKX1j5E4wiyAru9X6STYeNL6o9IoZWk=
X-Google-Smtp-Source: AJdET5c9pOCwQwV6/zGtDQWpcIc6aTXMU/Stn7S8OG5YYzNMSy7pgNkIOLrEroAEdRwiElRrESQO2ux0lBZ6bweOeEo=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr4154624vsb.155.1541781596119;
 Fri, 09 Nov 2018 08:39:56 -0800 (PST)
MIME-Version: 1.0
References: <1541527838-4585-1-git-send-email-linux@roeck-us.net>
 <20181106.192305.406697677@genki.is> <20181107022156.GA254567@google.com> <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org>
In-Reply-To: <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 10 Nov 2018 01:39:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNATPuMXeMkoih0GuF7uq3WbS+t95iZF53=Nj46do0UVYWg@mail.gmail.com>
Message-ID: <CAK7LNATPuMXeMkoih0GuF7uq3WbS+t95iZF53=Nj46do0UVYWg@mail.gmail.com>
Subject: Re: [PATCH] Revert "scripts/setlocalversion: git: Make -dirty check
 more robust"
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     Brian Norris <briannorris@chromium.org>, Genki Sky <sky@genki.is>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 12:05 PM Christian Kujau <lists@nerdbynature.de> wrote:
>
> On Tue, 6 Nov 2018, Brian Norris wrote:
> > > Perhaps both scenarios could be satisfied by having
> > > scripts/setlocalversion first check if .git has write permissions, and
> > > acting accordingly. Looking into history, this actually used to be
> > > done, but cdf2bc632ebc ("scripts/setlocalversion on write-protected
> > > source tree", 2013-06-14) removed the updating of the index.
> >
> > A "writeable" check (e.g., [ -w . ]) would be sufficient for our case.
> > But I'm not so sure about that older NFS report, and I'm also not sure
> > that we should be writing to the source tree at all in this case. Maybe
> > we can also check whether there's a build output directory specified?
>
> FWIW, the issue I reported back in 2013[0] was not an ill-configured NFS
> export, but a read-only NFS export (and then a read-write exported NFS
> export, but the user compiling the kernel did not have write permission)
> and so "test -w .git" did not help in determining if the source tree can
> actually written to. And depending on the user's shell[1], this may or may
> not still be the case.


Hmm, interesting.

The result of "test -w ." depends on the implementation of "test" command.


Bash's build-in 'test' did a good job for me;
"test -w ." returns 1 for read-only mounted NFS.


For Busybox's 'test',
"test -w ." returns 0 for read-only
(or writable, but without no-root-squash) NFS.





> So I'm all for the $(touch .git/some-file-here) test to decide if the
> kernel has to be modified during build.
>
> Christian.
>
> [0] https://lkml.org/lkml/2013/6/14/574
> [1] https://manpages.debian.org/unstable/dash/dash.1.en.html
>
> > > However, I admit I don't understand the justification in that commit
> > > from 2013. I'm no NFS expert, but perhaps the real problem there is an
> > > incorrectly configured NFS setup (uid/gid mismatch between NFS
> > > client/server, or permissions mismatch between mount options and NFS
> > > server?). Christian Kujau: can you speak to that?
> > >
> > > Well, we could also make our check $(touch .git/some-file-here
> > > 2>/dev/null && ...) instead of $(test -w .git) to handle misconfigured
> > > NFS setups. But not sure if that has its own problems.
> >
> > Trying to 'touch' the source tree will also break us. No matter whether
> > you redirect stderr, our sandbox will still notice the build is doing
> > something fishy and complain.
>
> --
> BOFH excuse #192:
>
> runaway cat on system.



-- 
Best Regards
Masahiro Yamada
