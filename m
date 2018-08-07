Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D28C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B07F2198F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nv4RnAzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B07F2198F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeHHAQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 20:16:20 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33604 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeHHAQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 20:16:19 -0400
Received: by mail-qt0-f194.google.com with SMTP id c15-v6so279859qtp.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OoTCdKEdWrU7XIVyJzUIBgd2zZ0XICuak2p4l59WHqw=;
        b=nv4RnAzCjxlHbAxmyiJLOms+dYry+eMIXFLFDOSgsEmNu4Dr3t7T32E+pVVWpZGp15
         51+pcXd5V/fTWxtBVSWyVxiPFYvYNcLB6gdEi2yOvPiMexyudAdXq8uVZSseR9vtcz1I
         ptS1nrxZs9+cMvrRJ3qhunes6mhYpBQd5pkpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OoTCdKEdWrU7XIVyJzUIBgd2zZ0XICuak2p4l59WHqw=;
        b=LmI7CRPrFpJog13mRdXEYFUM/OHXma9f+01w4tX8EIhg/WQmtAp2Z6QaCr3tZPq2yd
         t14GoqsAxl56AvSPqr3+Cxwode9xqU9MWhS2+ngpbpSAC4/l3meIarwpOZxuSFIZCNC2
         dUvNICQsB9btx3X5YHeCGFCCm4XyD3UQ68gvoQMnyL+0K+6tJkmnHcAezYXv6pwLnmtA
         yp0rWP+UthwFcSc87ZnOAKKgS1uOpMVo02ZNt7KtOk3lzEv4tKMF4O7AP2B8W/Uqhr5/
         w4fiMsAVXYWkIL0yFraK8JWrV3pdHGp0WRkpZjZ7GhDuMLa23ozj+AdetMR+c6S7OLFk
         8k1g==
X-Gm-Message-State: AOUpUlEDlSeu/yZ9oqCD6/eRzFVXSwoQbn4N2bDia3VnR+lMqakavnse
        rSJpOqYMYurJjfNrFGxmsn/I8yVtTtH6OI3mY7588A==
X-Google-Smtp-Source: AA+uWPzujTshWHGbVI5syTZGG79+vaceGd7Dop0FxuTZzrhMTaoM/+C0a8RKP0tzzmc6EKVystKPTCXHqSU0ffS8thk=
X-Received: by 2002:a0c:b792:: with SMTP id l18-v6mr219270qve.110.1533679192366;
 Tue, 07 Aug 2018 14:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20180803072628eucas1p26abe0cb121b974401759502f8807bb96@eucas1p2.samsung.com>
 <20180605224458.62692-1-ravisadineni@chromium.org> <20180803072628eucas1p26abe0cb121b974401759502f8807bb96~HTx4BGQjl1119311193eucas1p2U@eucas1p2.samsung.com>
 <CAEZbON7qLheHFuU6zwArCz=CG03JvnFjcehBGjE4RqROYrMLhQ@mail.gmail.com>
 <CAKdAkRQG08d_duPiKFi_=xUNO93c0Rcw9kpaYFFJahjJM-NdGw@mail.gmail.com>
 <CAEZbON4O0X8Fo6eAbmPOSiB1_Tw7x+Ox3ROoGfZQn72uQGQLkg@mail.gmail.com>
 <20180806052949eucas1p2483800c02730febd03d4a661a25fa405~INH40XvCx2719627196eucas1p2X@eucas1p2.samsung.com>
 <CAKdAkRSvLq-L3FrODUqxXqDs2FymM9k5dZRxnOpc44rFiHaWAQ@mail.gmail.com>
 <20180806071543eucas1p233ac5016e1a586594cf8ecd1fe3214b0~IOkV1Zt7j2129321293eucas1p20@eucas1p2.samsung.com>
 <CAEZbON72eVUCNT3ePEZKrB5B6+6YYgO7=X0TY0eBqUb3ws0sLA@mail.gmail.com>
In-Reply-To: <CAEZbON72eVUCNT3ePEZKrB5B6+6YYgO7=X0TY0eBqUb3ws0sLA@mail.gmail.com>
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
Date:   Tue, 7 Aug 2018 14:59:41 -0700
Message-ID: <CAEZbON5vMOiYRsnN1MyuSov3URByeAp-z3EEsEH6tqY23U32wQ@mail.gmail.com>
Subject: Re: [PATCH] Input: cros_ec_keyb: Remove check before calling pm_wakeup_event.
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ravi Chandra Sadineni <ravisadineni@google.com>,
        Todd Broch <tbroch@google.com>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Merek,

I tried booting a snow device and could not get it to boot it to the
console. I assume i don't have right kernel config. Can you share your
config if possible.

Thanks,
RaviOn Mon, Aug 6, 2018 at 4:05 PM Ravi Chandra Sadineni
<ravisadineni@chromium.org> wrote:
>
> Hi Merek,
>
> Thanks for the info. Lemme understand what's going on. Will update the
> thread once I have more info.
>
> Thanks,
> Ravi
> On Mon, Aug 6, 2018 at 12:15 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> >
> > Hi Dmitry
> >
> > On 2018-08-06 08:16, Dmitry Torokhov wrote:
> > > On Sun, Aug 5, 2018 at 10:29 PM Marek Szyprowski
> > > <m.szyprowski@samsung.com> wrote:
> > >> Hi Ravi,
> > >>
> > >> On 2018-08-03 18:53, Ravi Chandra Sadineni wrote:
> > >>> Understood. I am trying to reproduce this issue locally. Wanted to
> > >>> know the version of the kernel so I can give a try. Marek, can you
> > >>> please confirm the kernel version.
> > >>>
> > >> Yes, sorry for the missing context, I was in hurry writing the report and
> > >> I wanted to send it before leaving the office. I'm testing mainline on Snow
> > >> with exynos_defconfig.
> > >>
> > >> Suspend/resume is partially broken already with mainline, but if you disable
> > >> CPUfreq support, it works fine on Linux v4.17.
> > >>
> > >> I've posted CPUfreq related fixes here if you are interested:
> > >> https://patchwork.kernel.org/patch/10554607/
> > >> https://patchwork.kernel.org/patch/10554603/
> > >>
> > >> The issue with cros_ec_keyb patch appears first on Linux v4.18-rc1, which is
> > >> the first release with that patch.
> > > Marek, this patch should only be in -next, I do not believe I sent it
> > > to Linus just yet. If mainline is broken for you it can't be caused by
> > > this patch.
> >
> > Aaahh. My fault then. The suspend/resume issue is cause by commit
> > 38ba34a43dbc ("Input: cros_ec_keyb - mark cros_ec_keyb driver as wake
> > enabled device."), which has been merged to v4.18-rc1.
> >
> > It looks that I've downloaded wrong patch from the patchwork to reply it
> > with a a bug report. :( I'm really sorry for the noise in the wrong thread.
> >
> > Ravi: please let me know how can I help you to debug this issue.
> >
> > >
> > >> Linux -next from 20180803, which has a few
> > >> more patches for cros_ec_keyb suffers from the same issue.
> > > Just to confirm, if you revert only this patch from -next you get
> > > suspend/resume back?
> > >
> > > Thanks.
> >
> > Best regards
> > --
> > Marek Szyprowski, PhD
> > Samsung R&D Institute Poland
> >
