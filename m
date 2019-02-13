Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B9FC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835EB21904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dUebzb4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392188AbfBMQFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:05:12 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37765 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbfBMQFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:05:12 -0500
Received: by mail-ot1-f67.google.com with SMTP id b3so4933555otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 08:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E4rm+dPHumJI+cccvdii/izqIGaiBjQQRkm0cHKUQDY=;
        b=dUebzb4wU+pFts3jNYFWY4A1QQhxcVMpFOiCN+IbYPntirYrg1YCJ30gppOxPH4Ifq
         YxMkVE1Gjp0UNQoSEawUNLmbM10aRaxCI0zbRLIVGTzlj35T3nMpnk/4UOL+/qy0xV+z
         7NROVLdY7E/28MecAMHbfOQFf0Wv6vQlNV6Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E4rm+dPHumJI+cccvdii/izqIGaiBjQQRkm0cHKUQDY=;
        b=DUxi675L4xDKSi+F5aEs6jtTzwNYwF+qt9Tdmmp/r6TN/XLznY5/358N2CWuIbzooq
         nSXz/oDKCTvhzTKIuZPcya4MLp7S8HTeqF/zu0zeiYwfBt5j7evW2rAEYVoRaqtpfpiz
         faq9Uhex74xQl+dyS77/cu3+pdtgi7zdac0XtuQOBF/z8qkrg8Z0nDeJhRCDf0s+4m2E
         xLWfU4Q3Za7Z49SW1hbbsRuqy6JBpEtfprHAOPNViu58jgatsYn1Fasiqk7tOhx78MmX
         LPDOMhiozQsZuH1iINtICV4WEf9n1LDfefYTvc8YxHTrQPD/7DYY1ug4eBl9UQpirs34
         zPBA==
X-Gm-Message-State: AHQUAubWs30aB9ZfCGPypioJfs+jIDyBODBWsjj6XlwvmnIv/7ZnPbiK
        p6qSp9MW1eKF41iEFOnBXgrRoSeXmpwnpy0+rUlTMg==
X-Google-Smtp-Source: AHgI3IZG4jAaFOsu9mddpdRnT37Vlmb6q/rvctvHVCC5bO86814rTufc+BTgln/QujMmSVwMDLbY3BgbRTWgUxSey8c=
X-Received: by 2002:a24:94cb:: with SMTP id j194mr624095ite.117.1550073910624;
 Wed, 13 Feb 2019 08:05:10 -0800 (PST)
MIME-Version: 1.0
References: <20190213151107.14833-1-robdclark@gmail.com> <20190213152802.GK23159@phenom.ffwll.local>
 <CAF6AEGvMTQD3Yusp+qSLkSAM7=T+4q6kvJJtEAOd+9UsvrxMnA@mail.gmail.com>
In-Reply-To: <CAF6AEGvMTQD3Yusp+qSLkSAM7=T+4q6kvJJtEAOd+9UsvrxMnA@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 13 Feb 2019 17:04:59 +0100
Message-ID: <CAKMK7uHxS8XhpuRe-s7vFxBWc7WH8wiPZskDrW0QmXSg-dKDhA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update entry for drm/msm
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 4:43 PM Rob Clark via dri-devel
<dri-devel@lists.freedesktop.org> wrote:
>
> On Wed, Feb 13, 2019 at 10:28 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Wed, Feb 13, 2019 at 10:10:44AM -0500, Rob Clark via dri-devel wrote:
> > > We've moved the tree to a shared gitlab tree, so that Sean can help out
> > > with maintainer duties.
> > >
> > > Cc: Sean Paul <seanpaul@chromium.org>
> > > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > > ---
> > > I can include this patch in msm-next for v5.1, but wanted to get it
> > > ack'd on list
> >
> > Is the plan to also add this to dim, for full group maintainership fun?
> > It's more or less adding a few lines to nightly.conf and done (plus
> > everyone being ok with using the dim tooling).
>
> I think drm/msm is big enough, that it wouldn't make sense to move to
> drm-misc..  but possibly using the dim tooling could make sense.

This was about using the dim tooling, not about moving msm to
drm-misc. That indeed doesn't make much sense. And Sean already knows
that tooling. Plus you pretty much need a big script if you want to
add more committers (which imo you guys totally should), since
otherwise you spend up endless amounts of time training people on
trivial hiccups.
-Daniel

> BR,
> -R
>
> > -Daniel
> >
> > >
> > >  MAINTAINERS | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 9919840d54cd..2141a1b6653d 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -4838,10 +4838,11 @@ F:    Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt
> > >
> > >  DRM DRIVER FOR MSM ADRENO GPU
> > >  M:   Rob Clark <robdclark@gmail.com>
> > > +M:   Sean Paul <sean@poorly.run>
> > >  L:   linux-arm-msm@vger.kernel.org
> > >  L:   dri-devel@lists.freedesktop.org
> > >  L:   freedreno@lists.freedesktop.org
> > > -T:   git git://people.freedesktop.org/~robclark/linux
> > > +T:   git https://gitlab.freedesktop.org/drm/msm.git
> > >  S:   Maintained
> > >  F:   drivers/gpu/drm/msm/
> > >  F:   include/uapi/drm/msm_drm.h
> > > --
> > > A
> > > 2.20.1
> > >
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
