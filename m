Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D001DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8644F20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CsUMLxnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8644F20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbeKAAX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:23:27 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54600 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbeKAAX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:23:27 -0400
Received: by mail-it1-f195.google.com with SMTP id d6so13211051itl.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 08:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vgenT2Soa9mmY/bdvrCtxQ22Z3aySwfrg8haduGAxrI=;
        b=CsUMLxnwaHo9al1T74rMXus65CC78c9qynLPUwpF/6uas4QGxgsjiAajl7MzH5NalL
         XmEv7zSq1Mxu+tHUHlS8lQikE9A21KOMwwJ3u6MFWt4/Wdck9vCWme5MwBbXQYnvaSau
         p5E+RG+pkX+90TbBEZVmn/mqHJhlDVApR6nYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vgenT2Soa9mmY/bdvrCtxQ22Z3aySwfrg8haduGAxrI=;
        b=fosbbQ6dTB1dMxLdmzCngPzvzfmKWmh0kYqc+nu+id0EnWOYEth5BYIfx50dTEGzbu
         GSuhgLSXcQONJgVwy5T96MierVbroksVKTQMOSyqPUJXcOosjhQqG5G+aLWGP2da8zcf
         BVLO/71ufDT0ivG83XnNXC5TF/KaKrZ5EYczC3MwnYo38bDoIY0+j9UslRjnpy000lbL
         d6yaJ3a9/E2kSw3VOc6+867H4s+tJWTj+ICXtqa2cmcYfPGX3KxR1J7dlM2vOWCTDFtp
         mhJrhVbcEwKXBVv2aqu09k8romqrecLhCTvgz20trv9/naV6BIP8+sN4lCkje3wMaSTN
         A5Ew==
X-Gm-Message-State: AGRZ1gIyQpyGB7vDfAY0lYSkRoPwNdp+wVLN3gH+FFhsAMB3FGMPxdJ1
        qfyxUTSb9GYbEHyQDbcwCF8VX7HsnqOa5aujUNGvf6ks
X-Google-Smtp-Source: AJdET5d+y7JLPGS6qqU/WHXjm/jAoe8dj26QzoVly1d1R4wyuECdPpPmhjLtdwwHq38PL5UyTJb0aCy+sCT50uSQeYQ=
X-Received: by 2002:a02:590:: with SMTP id 16-v6mr2739698jal.70.1540999498762;
 Wed, 31 Oct 2018 08:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181031144445.vrdngzj3jclforta@smtp.gmail.com> <87a7mudu8t.fsf@intel.com>
In-Reply-To: <87a7mudu8t.fsf@intel.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 31 Oct 2018 16:24:45 +0100
Message-ID: <CAKMK7uEuoNRT7g+iRVTmcjt6zS5dotATrFgV4QTLxs2Fg33OYQ@mail.gmail.com>
Subject: Re: [Outreachy kernel] Re: [PATCH] drm: Remove 80-column line in drm_mode_object.c
To:     "Nikula, Jani" <jani.nikula@linux.intel.com>
Cc:     Shayenne da Luz Moura <shayenneluzmoura@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Dave Airlie <airlied@linux.ie>,
        outreachy-kernel@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 4:13 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Wed, 31 Oct 2018, Shayenne da Luz Moura <shayenneluzmoura@gmail.com> wrote:
> > Add a new variable to make the drm_mode_object comparison before
> > idr_alloc and decrease line size.
> >
> > Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_mode_object.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
> > index be8b754eaf60..4b9eafddb409 100644
> > --- a/drivers/gpu/drm/drm_mode_object.c
> > +++ b/drivers/gpu/drm/drm_mode_object.c
> > @@ -36,9 +36,10 @@ int __drm_mode_object_add(struct drm_device *dev, struct drm_mode_object *obj,
> >                         void (*obj_free_cb)(struct kref *kref))
> >  {
> >       int ret;
> > +     struct drm_mode_object *obj_tmp = register_obj ? obj : NULL;
> >
> >       mutex_lock(&dev->mode_config.idr_mutex);
> > -     ret = idr_alloc(&dev->mode_config.crtc_idr, register_obj ? obj : NULL, 1, 0, GFP_KERNEL);
> > +     ret = idr_alloc(&dev->mode_config.crtc_idr, obj_tmp, 1, 0, GFP_KERNEL);
>
> Please don't send checkpatch "fixes" to adhere to the 80-column rule. Or
> at least use --max-line-length=100 or something to look for worse
> offenders than this.
>
> And if you insist, please just add a newline and proper indentation
> after "NULL," instead of adding a temporary variable.

Breaking the line after NULL, seems reasonable, I'd be happy to merge that.
-Daniel

>
>
> BR,
> Jani.
>
> >       if (ret >= 0) {
> >               /*
> >                * Set up the object linking under the protection of the idr
>
> --
> Jani Nikula, Intel Open Source Graphics Center
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/87a7mudu8t.fsf%40intel.com.
> For more options, visit https://groups.google.com/d/optout.



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
