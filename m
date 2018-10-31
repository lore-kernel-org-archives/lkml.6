Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54EDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEB02084A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ4YQP5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEB02084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbeKACfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:35:47 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45284 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729737AbeKACfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:35:47 -0400
Received: by mail-qk1-f193.google.com with SMTP id d135so9575652qkc.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 10:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eBBHziVyVC2qdRw0j3ufam70h3Yk3Hm0Gkooyp0f5Lo=;
        b=kZ4YQP5uh8lsuQkBLudYlzDV61s1/pBLa0gx9XUhi2JZLLGu9YePTZqOEeX3JOqudn
         N1oVAtNaM1GI5nsxodtEuOYHB5wHfh9QgY98eOmp4CscXSBm/OlpDcd2SpwPRjFX85pc
         oD+aqsXtMh8/mYSZkB32VZYNUiGLH7mDrXGrX7ux8Ccd6uNGZWdFkgMJhtVsaVT+jJNY
         krkOyIRXWH2UR0gn+nwsbfWAdXuos9KiNDEtBJdDDbHAaGzzuA1HtTk/At8kUXrG6noL
         TMWAG+vKvytcAjhhMgJmlCJTE1N+ao7sqF2dV60FN2DUYjGNbg9VpeF4wYe3c3OPuXeo
         hqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eBBHziVyVC2qdRw0j3ufam70h3Yk3Hm0Gkooyp0f5Lo=;
        b=moMY5JYcWkWUiWVz9Q5qZgg/SsK3gqQYhk8b+9DnDmZw7Hm8XBcBfyXlB/j2YwvjoB
         Ur65rDhHvkWwSuTtrOmmJNSNjcA62WSZmxmBySi7Zq9QJ9diD9zQs5b0cv2p+Z/aMwDW
         KmhX6dj1oD4irbsuc8NriOxjFI6eF5jT0vEtTfML1KRatMP9qHRtTSJOAmWjnVx6dxtJ
         xGpEnUpZNg64AV9+t2yzUaw8p5l0SPqJDzvpEqrgeosaNLlIIkMMkLa1PI8jrVG+UEG4
         rijcQ/ZXpoKVal5CuDKPguKw+kKheWMb0oaI0xYwhiu3HeL6mhy2i9Q2RJEaYUZSRonJ
         bWwQ==
X-Gm-Message-State: AGRZ1gKb42UHJPlEiiPbNe41okzgSGLtCl0D5LRc3qnwHiwRg3sh4wFm
        yeOipFfRNwck3+BQJrzdrr8=
X-Google-Smtp-Source: AJdET5c8jGj2wr/5ci5MUTlriA2exL+j5ebzTmp+HZkYBRLLejNfc1G5A17lPR78MhBn/yrk5d6yqw==
X-Received: by 2002:a37:9b82:: with SMTP id d124mr3337892qke.172.1541007407982;
        Wed, 31 Oct 2018 10:36:47 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id l36-v6sm12076301qtc.80.2018.10.31.10.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 10:36:47 -0700 (PDT)
Date:   Wed, 31 Oct 2018 14:36:42 -0300
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     "Nikula, Jani" <jani.nikula@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Dave Airlie <airlied@linux.ie>,
        outreachy-kernel@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [Outreachy kernel] Re: [PATCH] drm: Remove 80-column line in
 drm_mode_object.c
Message-ID: <20181031173642.csdlaq2ajyqhum6p@smtp.gmail.com>
References: <20181031144445.vrdngzj3jclforta@smtp.gmail.com>
 <87a7mudu8t.fsf@intel.com>
 <CAKMK7uEuoNRT7g+iRVTmcjt6zS5dotATrFgV4QTLxs2Fg33OYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uEuoNRT7g+iRVTmcjt6zS5dotATrFgV4QTLxs2Fg33OYQ@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31, Daniel Vetter wrote:
> On Wed, Oct 31, 2018 at 4:13 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> >
> > On Wed, 31 Oct 2018, Shayenne da Luz Moura <shayenneluzmoura@gmail.com> wrote:
> > > Add a new variable to make the drm_mode_object comparison before
> > > idr_alloc and decrease line size.
> > >
> > > Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
> > > ---
> > >  drivers/gpu/drm/drm_mode_object.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
> > > index be8b754eaf60..4b9eafddb409 100644
> > > --- a/drivers/gpu/drm/drm_mode_object.c
> > > +++ b/drivers/gpu/drm/drm_mode_object.c
> > > @@ -36,9 +36,10 @@ int __drm_mode_object_add(struct drm_device *dev, struct drm_mode_object *obj,
> > >                         void (*obj_free_cb)(struct kref *kref))
> > >  {
> > >       int ret;
> > > +     struct drm_mode_object *obj_tmp = register_obj ? obj : NULL;
> > >
> > >       mutex_lock(&dev->mode_config.idr_mutex);
> > > -     ret = idr_alloc(&dev->mode_config.crtc_idr, register_obj ? obj : NULL, 1, 0, GFP_KERNEL);
> > > +     ret = idr_alloc(&dev->mode_config.crtc_idr, obj_tmp, 1, 0, GFP_KERNEL);
> >
> > Please don't send checkpatch "fixes" to adhere to the 80-column rule. Or
> > at least use --max-line-length=100 or something to look for worse
> > offenders than this.
> >
> > And if you insist, please just add a newline and proper indentation
> > after "NULL," instead of adding a temporary variable.
> 
> Breaking the line after NULL, seems reasonable, I'd be happy to merge that.
> -Daniel

Okay, I will send a new version.

Thank you!
