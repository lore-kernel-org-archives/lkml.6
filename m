Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE869C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B47B21902
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7KtclLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392523AbfBMPnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:43:49 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33885 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBMPns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:43:48 -0500
Received: by mail-it1-f194.google.com with SMTP id j17so2130155ita.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 07:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=yQOI34Gcr7elKfW3xtezVTbRFDKvXgyKa7i4Sisibsc=;
        b=C7KtclLsNPDMsNvy5XEb84R1o7dKQ9+jJ98UKuFP6RI1ZHUeTd/uKf0Ejn/a1BgDG3
         0XXCXGO1p0MZ4jRHsGCYK4YZEmW5jcJV6TgmUpcDuxGalDgdgnLdVkqAqHYg8pqOP+Rh
         WKd3N13eTqBf/i0M7nS/L4FI27J6asR3nu5cOou717RBgHUWSKZoRQujsGypcAXd/tl6
         hbS983gwEPNJrbX43BYFwu1VLCebioyjLA/iylcp+GSXZXuti7LMNuFv/l5DLo4DrNnw
         4VaDNBdi7Lm2jAQYHi2vPxL4hEiOwrkXJH2ilQ6iUugGAOo1tJjkFGNfKY0Yn7PohBL+
         PmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=yQOI34Gcr7elKfW3xtezVTbRFDKvXgyKa7i4Sisibsc=;
        b=Fcp8qzuFsIdU54ekZtpPL9fgzUiE9McUMfbqnhleZgWcOsEZFsaxhAvVIhz+toPD3d
         5w3bPY4xf5BkKfNt7Aiobe+IJQWRZw7uyh6YYh7APdwkS+hvWypkaLNDmqyVwIUZLye1
         vU1B4l69DqaqRGuZaoLqbWOtk2xC4DA57+vbkSFxbya+6jVO/yLrAFtR7Dbko/418mUU
         0d1l0Lr/qV+nVlgBAsr4ltS8VZBEcxv7GA8u1E87N22GMmO9srNTxDWLPe/5RK7HNhrj
         5+Nk7ImabmtQ4SaQfihpBwolIadLh2Zy2E5n+LR46m+6sb5+VfPzAIAz/vnHoJX4kJfa
         bEZg==
X-Gm-Message-State: AHQUAua/wSWp1iur9MOkQFB872/swyCqLR5FjJNGonP776LBv/BFPWd7
        05F8SlXCerNqEW1Aeg5Sbb2IZONdG1wcYQoVbRA=
X-Google-Smtp-Source: AHgI3IY2VxuLwtAjnXtAoAXjkWyvifNrrDMaB8VYCCgPEtFR/jwUBSSOJGM5raB6zyxkxWtNaKM3fbMifpJ2WOdcvUA=
X-Received: by 2002:a6b:7108:: with SMTP id q8mr687439iog.7.1550072627477;
 Wed, 13 Feb 2019 07:43:47 -0800 (PST)
MIME-Version: 1.0
References: <20190213151107.14833-1-robdclark@gmail.com> <20190213152802.GK23159@phenom.ffwll.local>
In-Reply-To: <20190213152802.GK23159@phenom.ffwll.local>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 13 Feb 2019 10:43:34 -0500
Message-ID: <CAF6AEGvMTQD3Yusp+qSLkSAM7=T+4q6kvJJtEAOd+9UsvrxMnA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update entry for drm/msm
To:     Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
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

On Wed, Feb 13, 2019 at 10:28 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Feb 13, 2019 at 10:10:44AM -0500, Rob Clark via dri-devel wrote:
> > We've moved the tree to a shared gitlab tree, so that Sean can help out
> > with maintainer duties.
> >
> > Cc: Sean Paul <seanpaul@chromium.org>
> > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > ---
> > I can include this patch in msm-next for v5.1, but wanted to get it
> > ack'd on list
>
> Is the plan to also add this to dim, for full group maintainership fun?
> It's more or less adding a few lines to nightly.conf and done (plus
> everyone being ok with using the dim tooling).

I think drm/msm is big enough, that it wouldn't make sense to move to
drm-misc..  but possibly using the dim tooling could make sense.

BR,
-R

> -Daniel
>
> >
> >  MAINTAINERS | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9919840d54cd..2141a1b6653d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4838,10 +4838,11 @@ F:    Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt
> >
> >  DRM DRIVER FOR MSM ADRENO GPU
> >  M:   Rob Clark <robdclark@gmail.com>
> > +M:   Sean Paul <sean@poorly.run>
> >  L:   linux-arm-msm@vger.kernel.org
> >  L:   dri-devel@lists.freedesktop.org
> >  L:   freedreno@lists.freedesktop.org
> > -T:   git git://people.freedesktop.org/~robclark/linux
> > +T:   git https://gitlab.freedesktop.org/drm/msm.git
> >  S:   Maintained
> >  F:   drivers/gpu/drm/msm/
> >  F:   include/uapi/drm/msm_drm.h
> > --
> > A
> > 2.20.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
