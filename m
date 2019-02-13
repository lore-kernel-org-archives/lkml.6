Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDC5C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8737D21904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="beigrxpd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392631AbfBMQXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:23:11 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37150 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbfBMQXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:23:10 -0500
Received: by mail-qt1-f193.google.com with SMTP id a48so3225135qtb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 08:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NjxEKeyCObRr2sjcSUeukxOsu5en/ljpvN0RjIO7Ejs=;
        b=beigrxpdNR+B/wztcbc4ZiGTIErUN1WbfjBqhk6yzHFHQDOKRkksCBhxAJ95d5+mG1
         blO3YrNugSEg3AlXlYq6XfF9g093N6ogEa0ZkZJYJJB09CQkeHumCQN9L5iYv4IKXPfq
         XSbdMokRxLfzdk2Wad/uONUp789H1Uz1R5qMY5Z5iGPqMTxJ4Up3cBIp4JXAt99AJxCq
         nikT72negFaQxoDwdmzqR8ZzntjJLYlmM2+Eub0F38POqp4rHrwbtiMzb2FAgs88iFew
         cyO6mHKtKruImTUgnch9/saEzKr/zQyhA/StRV2J/mcI5b7bVP8JTL5bkqPwbL4P2DDx
         JXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NjxEKeyCObRr2sjcSUeukxOsu5en/ljpvN0RjIO7Ejs=;
        b=fyU9ni4ZNvjAu148Q9Fh/PphSKaok4b4yvlPyYOuKEqDgo6OWEHXe4558xb2mv3fDn
         HLemDeC8r6IZX+fKo1rTGaZ4rzhvL6talCItlFuppp4xEpFYAkq5aWN4DNR7pFYvFyXi
         PPmPsD3iiAMPI2p0pMaDKGlOb8HjZ1k1J+XTCPbiCimi4PLBgs5UV0j1qLRja/JJb4Ma
         cZepK6oeIbBx3a9p8OSa+ceZM4F6sl3ge1zlHBcnVI2ZYVsQ8muP/RKXdVPqb5fSZbSH
         LObrWzLdPXzFZIFVQmnCs7hbBvWFcQ7npANNzq0NZLGuymlJ++g9YnSoUgp1Hf/ZjA08
         fCxQ==
X-Gm-Message-State: AHQUAuaFDN3uW54ubsfCGnd4MaVkrPh9IkPihH3Rcj09E9s3nmwOf8wR
        pBd5eN9/dcSuF4f+HS/qbTLARW6U2a0=
X-Google-Smtp-Source: AHgI3IbWKIXV3Qg1k0ZC67tBztNKKXXaJlE9eBFl1qavFpJ/jZcthPyMAVAI/EaoxcqwQ8efqII3Ag==
X-Received: by 2002:ac8:1ba9:: with SMTP id z38mr1082845qtj.3.1550074988815;
        Wed, 13 Feb 2019 08:23:08 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id 46sm14115766qty.59.2019.02.13.08.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 08:23:07 -0800 (PST)
Date:   Wed, 13 Feb 2019 11:23:07 -0500
From:   Sean Paul <sean@poorly.run>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Clark <robdclark@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] MAINTAINERS: update entry for drm/msm
Message-ID: <20190213162307.GL114153@art_vandelay>
References: <20190213151107.14833-1-robdclark@gmail.com>
 <20190213152802.GK23159@phenom.ffwll.local>
 <CAF6AEGvMTQD3Yusp+qSLkSAM7=T+4q6kvJJtEAOd+9UsvrxMnA@mail.gmail.com>
 <CAKMK7uHxS8XhpuRe-s7vFxBWc7WH8wiPZskDrW0QmXSg-dKDhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uHxS8XhpuRe-s7vFxBWc7WH8wiPZskDrW0QmXSg-dKDhA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 05:04:59PM +0100, Daniel Vetter wrote:
> On Wed, Feb 13, 2019 at 4:43 PM Rob Clark via dri-devel
> <dri-devel@lists.freedesktop.org> wrote:
> >
> > On Wed, Feb 13, 2019 at 10:28 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Wed, Feb 13, 2019 at 10:10:44AM -0500, Rob Clark via dri-devel wrote:
> > > > We've moved the tree to a shared gitlab tree, so that Sean can help out
> > > > with maintainer duties.
> > > >
> > > > Cc: Sean Paul <seanpaul@chromium.org>
> > > > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > > > ---
> > > > I can include this patch in msm-next for v5.1, but wanted to get it
> > > > ack'd on list
> > >
> > > Is the plan to also add this to dim, for full group maintainership fun?
> > > It's more or less adding a few lines to nightly.conf and done (plus
> > > everyone being ok with using the dim tooling).
> >
> > I think drm/msm is big enough, that it wouldn't make sense to move to
> > drm-misc..  but possibly using the dim tooling could make sense.
> 
> This was about using the dim tooling, not about moving msm to
> drm-misc. That indeed doesn't make much sense. And Sean already knows
> that tooling. Plus you pretty much need a big script if you want to
> add more committers (which imo you guys totally should), since
> otherwise you spend up endless amounts of time training people on
> trivial hiccups.

Yeah, we've talked about switching to dim a few times already. IMO, the big win
for msm would be inclusion in drm-tip to catch integration issues early, and
dim's sanity checks around tags. Selfishly, this would also reduce dim's
complaints when backmerging drm into drm-misc  :-).

That said, would the committers we'd want to add to msm (Qualcomm employees) be
receptive to (or even able to install/download) dim? I'm not sure on this one.

At any rate, last time we discussed dim, we agreed the first step was to get
msm on gitlab so we can easily add commit access and go from there. I think
we're probably just at the end of that transition period, so everything is on
track!

Sean


> -Daniel
> 
> > BR,
> > -R
> >
> > > -Daniel
> > >
> > > >
> > > >  MAINTAINERS | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 9919840d54cd..2141a1b6653d 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -4838,10 +4838,11 @@ F:    Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt
> > > >
> > > >  DRM DRIVER FOR MSM ADRENO GPU
> > > >  M:   Rob Clark <robdclark@gmail.com>
> > > > +M:   Sean Paul <sean@poorly.run>
> > > >  L:   linux-arm-msm@vger.kernel.org
> > > >  L:   dri-devel@lists.freedesktop.org
> > > >  L:   freedreno@lists.freedesktop.org
> > > > -T:   git git://people.freedesktop.org/~robclark/linux
> > > > +T:   git https://gitlab.freedesktop.org/drm/msm.git
> > > >  S:   Maintained
> > > >  F:   drivers/gpu/drm/msm/
> > > >  F:   include/uapi/drm/msm_drm.h
> > > > --
> > > > A
> > > > 2.20.1
> > > >
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
