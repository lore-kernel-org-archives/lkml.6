Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB18C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9C821470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9C821470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeJDCl2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:41:28 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35912 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbeJDCl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:41:27 -0400
Received: by mail-qt1-f193.google.com with SMTP id u34-v6so7348070qth.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 12:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HrRbcF+CD76B+IKUIRQAqOlgFzvPqq7Jd9UaVjoIhKg=;
        b=pV74IXdxgBoIfgMa56vawe2KxC6VParPuq8AqoUhiU25Wb9QdE3uLz2/QHFBeU4LGa
         YBRxkKG3HDlFYrTmdbycH2VMd5DPkisuXnoquY8YU5PBinwtLxGJncO4wKbkhQ5KU4za
         aUMZdQSqJqPnw2U9JmoSsR/B5FkFk/KOEF/NTKpaOuj6WKIU+WoZ9ozWPCdDnGcKHWh+
         GLsA4HTd4NL2LXIH2ntselD+foDGIpmd9xOP1rMwOPVlfhuJYdqZCMRzV7fMOhK6sWjY
         rLVoG1lBI8t2i0jjFem1gdlj0ikwk7FQwt7TnSotcW2M3EdQGVTvldE9MZH6jtRWTaNU
         6DrQ==
X-Gm-Message-State: ABuFfoi21a4nDOEpCPLDd8i0U86Tb7wLHrQsGSIk33mqeRKDX+3kz7bM
        wtYELCOWSzeb0dd056hVVjhEYQqMRHNci7o0fbc=
X-Google-Smtp-Source: ACcGV61RngkgL5+20k7D8uMOJEYrVyVi2yzis0tobdk/zgbP+DjAY+ZnEgrmFPoB39CdpAQr8mv70YR4IM+V+7CqQxg=
X-Received: by 2002:a0c:9e59:: with SMTP id z25-v6mr2532409qve.180.1538596298158;
 Wed, 03 Oct 2018 12:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20181002205836.2323084-1-arnd@arndb.de> <123f7e1c-8f2b-5797-de16-650ec01d0b24@tronnes.org>
 <20181003161326.GD31561@phenom.ffwll.local>
In-Reply-To: <20181003161326.GD31561@phenom.ffwll.local>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 3 Oct 2018 21:51:21 +0200
Message-ID: <CAK8P3a1gKxXEthLvUxSxOrt6+1qzZE9Jba+vH_qFepv3KXba9g@mail.gmail.com>
Subject: Re: [PATCH] drm/imx: move 'legacyfb_depth' definition out of #ifdef
To:     noralf@tronnes.org, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>, tzimmermann@suse.de,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 6:13 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Oct 03, 2018 at 05:49:32PM +0200, Noralf Trønnes wrote:
> >
> >
> > Den 02.10.2018 22.58, skrev Arnd Bergmann:
> > > The variable is now referenced unconditionally, but still
> > > declared in an #ifdef:
> > >
> > > drivers/gpu/drm/imx/imx-drm-core.c: In function 'imx_drm_bind':
> > > drivers/gpu/drm/imx/imx-drm-core.c:264:6: error: 'legacyfb_depth' undeclared (first use in this function); did you mean 'lockdep_depth'?
> > >
> > > Remove the #ifdef so it can always be accessed.
> > >
> > > Fixes: f53705fd9803 ("drm/imx: Use drm_fbdev_generic_setup()")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> >
> > I've already applied the previous one you sent:
> > https://cgit.freedesktop.org/drm/drm-misc/commit/?id=064b06bbf117f8b5e64a5143e970d5a1cf602fd6
> >
> > Not sure when it reaches linux-next now that we are past rc6.
>
> Only once we're past -rc1.

Can we revert f53705fd9803 in linux-next then to prevent the regression from
making it into 4.20?

       Arnd
