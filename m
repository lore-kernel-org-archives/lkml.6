Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38FAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF5F2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="F3JgDHTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeLRE5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 23:57:51 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:23485 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRE5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 23:57:50 -0500
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id wBI4vXVU019335;
        Tue, 18 Dec 2018 13:57:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wBI4vXVU019335
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545109054;
        bh=mrACadVJh0wczd0rC2PscMxP+TZbM654Wxl8mmC2z0Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F3JgDHTS2d2Rhv25RoTPEoLUJMnL1vTKzoHF1thVIadGiPstA95JKl6nYuf2+R7yo
         PrvUP14j1ottL1mWNXfghkogfqUYhzXNabWejz8ror/vtznzjW5oOWDgeGpLnNHzls
         Su+SeqGbbcSxfnscBXHbQ8o/sVMbd6r21R/msQceDFxFpZUCMf29YOej+gVW/OpMjE
         bzgLrYIDKdCplOkgeRsFW/kOSNUaWb8VTBjmmryPvViibpBslA/cFZR7MvpNRtb/VM
         Kyxu3cjtTOD8ykB4ljKPuOdIso3ZkHEkb9e4KBOf3a3GVkdDBHXyRubi1y+IxLu2tu
         UDzEO+1aClcUg==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id p74so9237171vsc.0;
        Mon, 17 Dec 2018 20:57:33 -0800 (PST)
X-Gm-Message-State: AA+aEWZJIAJt8HYR+5Kh8rWiGG4np7fGxLVGsS9K9YG4TfJW89vl6LSE
        5Fp8Jket+rW5Wqf7PoTvLypR0KBXnlvNLZHp6iM=
X-Google-Smtp-Source: AFSGD/XrMMW80X0/egSJ8zTZVC+n9dJz8ZepM2y0y+sJR8ZhiFMSGwE7Mdt5ONcE0w679QVotaCdtOztrmVxSP+mBx8=
X-Received: by 2002:a67:a858:: with SMTP id r85mr7407662vse.215.1545109052681;
 Mon, 17 Dec 2018 20:57:32 -0800 (PST)
MIME-Version: 1.0
References: <20171226043003.GB10431@windriver.com> <d053e6df-ed00-2a02-eb27-4287b7549276@infradead.org>
 <20171229021323.GF10431@windriver.com> <20171229164739.rgcqmam6wtno6hge@treble>
 <20171229181830.GH10431@windriver.com> <20181216214202.GQ11670@windriver.com>
In-Reply-To: <20181216214202.GQ11670@windriver.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 18 Dec 2018 13:56:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNARfr6dKw=SM1_NyqRPAZ08-HvouzJFJmSox-h9m2RFecA@mail.gmail.com>
Message-ID: <CAK7LNARfr6dKw=SM1_NyqRPAZ08-HvouzJFJmSox-h9m2RFecA@mail.gmail.com>
Subject: Re: [Regression 4.15] Can't kill CONFIG_UNWINDER_ORC with fire or plague.
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 6:45 AM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
>
> [Re: [Regression 4.15] Can't kill CONFIG_UNWINDER_ORC with fire or plague.] On 29/12/2017 (Fri 13:18) Paul Gortmaker wrote:
>
> > [Re: [Regression 4.15] Can't kill CONFIG_UNWINDER_ORC with fire or plague.] On 29/12/2017 (Fri 10:47) Josh Poimboeuf wrote:
> >
> > > This seems to be related to a kconfig quirk where only silentoldconfig
> > > updates the include/config/auto.conf file.  The other config targets
> > > (oldconfig, defconfig, etc) don't touch it.  It seems intentional, but I
> > > have no idea why.
> > >
> > > That causes the Makefile to get stale data for 'CONFIG_*' variables when
> > > it includes auto.conf.  So I don't think this is specific to the ORC
> > > check.  It seems like it could also cause bugs elsewhere.
> >
> > OK, good - you agree with my initial diagnosis of stale auto.conf then.
> > Not sure what Randy was testing when he said he couldn't reproduce it.
> >
> > > The below (ugly) patch fixes it, though I'm not sure this is the best
> > > way to do it.  We probably need Masahiro or Michal to chime in here.
> >
> > Yep, that is why I intentionally put the kbuild folks on the To/Cc of
> > the original report (and ran away screaming at the prospect of debugging
> > Makefiles on xmas day).  But with holidays and all, it might not be
> > until early January before they have a chance to reply.
>
> It is nearly a year later and we still have this false positive.
>
> paul@sm:~/git/linux-head$ make -j12 > /dev/null
> Makefile:966: *** "Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y,
>  please install libelf-dev, libelf-devel or elfutils-libelf-devel".  Stop.
> paul@sm:~/git/linux-head$ grep UNWINDER_ORC .config
> # CONFIG_UNWINDER_ORC is not set
>
> We do know a bit more now -- the auto.conf issue has been independently
> confirmed and "fixed" for other subsystems/issues since, like RETPOLINE:
>
>  ---------------------
>   commit 25896d073d8a0403b07e6dec56f58e6c33678207
>   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
>   Date:   Wed Dec 5 15:27:19 2018 +0900
>
>     x86/build: Fix compiler support check for CONFIG_RETPOLINE
>
>     It is troublesome to add a diagnostic like this to the Makefile
>     parse stage because the top-level Makefile could be parsed with
>     a stale include/config/auto.conf.
>
>     Once you are hit by the error about non-retpoline compiler, the
>     compilation still breaks even after disabling CONFIG_RETPOLINE.
>  ---------------------
>
> I'm not sure if we want to treat this on a per config option each time
> again and again, or undertake a more global kbuild approach, but it does
> warrant a mention and a re-examination before we "solve" this again.


I did not notice this thread
(perhaps, it fell into my crack during the holidays)
but I actually tried to fix this twice in a sophisticated way
in the past.


The first attempt (https://patchwork.kernel.org/patch/10516049/)
was rejected by Josh Poimboeuf.

The second one (https://patchwork.kernel.org/patch/10643245/)
turned out not working as expected.


Now, I am preparing for the third attempt,
but it will take time for review.

What I can do now is the similar fix-up as commit 25896d073d8.

I will post a cheesy fix-up patch.


--
Best Regards
Masahiro Yamada
