Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D65EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8A1218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nd4Gcexl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbeLSRdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:33:35 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34435 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbeLSRdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:33:35 -0500
Received: by mail-qk1-f193.google.com with SMTP id q8so9944607qke.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 09:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dEx1580/VpoGZtMIQuEh9aAAqJ09uM5otSUP0ifdHPg=;
        b=Nd4GcexlWvUpq+mPif1d5rKM+SqtKJpuvXbpbw3alcrIMEZaKw2CDyua3xvdFlkGzR
         LhLiqu7yw91vQlrche7qcbK78N2z1lB/6bqZWyCGyX7Pcd1b8SwFKieWk74fNKcGRBbv
         G3vNX1H/KkJuZUZyuOu0K4/Pq2yJmxO2z3EbvHVF4flNrxXmKq/6LnJ7TjcGrtludygX
         Xl63Tch06YVKSo3oSb9BlFjPJ4lUsGNqOdCkiIBfTBthcdzfswkhBV778MNb9Vze8PL8
         5CKKoAhc7MKhB7SK6pDE+auXwQoBIEPZM9c0CZDfWt8AZSqp7AzFpthvHGkrw+RZTQLQ
         ZnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dEx1580/VpoGZtMIQuEh9aAAqJ09uM5otSUP0ifdHPg=;
        b=P3VP56CovdVzRqru6yUe84MfrXfDwLCoM7/Eas3XkvC1Z+lL8IUvbPKPIsai60mEh7
         1cHR6CKIGgG8wiyJqe9EPsjjY0KqC+mILDwebFJaiuf9Cug0lUOLD0Qp0N+wz4bmpcbm
         fcAfU3ubQUKFdZzLUZuy7Xu88OaehWicRQNXmIODifmTSATEYefUe/50erlMYdnDbkjO
         8RR8/IF0E+9U0QQLEot6bXvvosbn3mT8P64wJBON5bHUDX19rXTvOITUFxlflTdKC4tS
         0GeUvdK87qaalVXem5cjoMK6ANavDaPxE6Y1hVbR4uQXK4BM73y7LqQl2CvC+40lU7bS
         RZqA==
X-Gm-Message-State: AA+aEWYZe/WRlzB8mI7oOriS9+i8hMYhb6fYqfgYZiWnk47rOMWkKGuG
        jP/oowhcjELs/Ih4ijAup88=
X-Google-Smtp-Source: AFSGD/W4oejejcwbNleWytJNPHy8JqK3aZbh6DUb+ByqJBvh3trQk90QjeWEB8JmHth3z7PsIDGGyA==
X-Received: by 2002:a37:18e5:: with SMTP id 98mr21850610qky.333.1545240813973;
        Wed, 19 Dec 2018 09:33:33 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id z8sm2598996qth.34.2018.12.19.09.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 09:33:33 -0800 (PST)
Date:   Wed, 19 Dec 2018 15:33:29 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 7/7] drm: Complete remove drm_mode_object dependency
Message-ID: <20181219173329.t6g33monwuum2ahg@smtp.gmail.com>
References: <20181218133836.pahcbhb5tlr4fwvf@smtp.gmail.com>
 <20181219131508.GU21184@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219131508.GU21184@phenom.ffwll.local>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19, Daniel Vetter wrote:
> On Tue, Dec 18, 2018 at 11:38:36AM -0200, Shayenne Moura wrote:
> > This patch finalizes the KMS cleanup task dependency from drm_display_mode
> > It removes the use of drm_mode_object from drm_display_mode struct
> > and it removes the use of base.id and base.type.
> > 
> > Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
> 
> I didn't yet compile-test all the drivers, but aside from that this looks
> all good.
> 
Thank you for your reviews! :)

Shayenne

> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > ---
> >  include/drm/drm_modes.h | 21 +++------------------
> >  1 file changed, 3 insertions(+), 18 deletions(-)
> > 
> > diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
> > index baded6514456..9ecc1e835565 100644
> > --- a/include/drm/drm_modes.h
> > +++ b/include/drm/drm_modes.h
> > @@ -136,8 +136,7 @@ enum drm_mode_status {
> >         .hdisplay = (hd), .hsync_start = (hss), .hsync_end = (hse), \
> >         .htotal = (ht), .hskew = (hsk), .vdisplay = (vd), \
> >         .vsync_start = (vss), .vsync_end = (vse), .vtotal = (vt), \
> > -       .vscan = (vs), .flags = (f), \
> > -       .base.type = DRM_MODE_OBJECT_MODE
> > +       .vscan = (vs), .flags = (f)
> >  
> >  #define CRTC_INTERLACE_HALVE_V (1 << 0) /* halve V values for interlacing */
> >  #define CRTC_STEREO_DOUBLE     (1 << 1) /* adjust timings for stereo modes */
> > @@ -213,20 +212,6 @@ struct drm_display_mode {
> >          */
> >         struct list_head head;
> >  
> > -       /**
> > -        * @base:
> > -        *
> > -        * A display mode is a normal modeset object, possibly including public
> > -        * userspace id.
> > -        *
> > -        * FIXME:
> > -        *
> > -        * This can probably be removed since the entire concept of userspace
> > -        * managing modes explicitly has never landed in upstream kernel mode
> > -        * setting support.
> > -        */
> > -       struct drm_mode_object base;
> > -
> >         /**
> >          * @name:
> >          *
> > @@ -429,14 +414,14 @@ struct drm_display_mode {
> >  /**
> >   * DRM_MODE_FMT - printf string for &struct drm_display_mode
> >   */
> > -#define DRM_MODE_FMT    "%d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x"
> > +#define DRM_MODE_FMT    "\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x"
> >  
> >  /**
> >   * DRM_MODE_ARG - printf arguments for &struct drm_display_mode
> >   * @m: display mode
> >   */
> >  #define DRM_MODE_ARG(m) \
> > -       (m)->base.id, (m)->name, (m)->vrefresh, (m)->clock, \
> > +       (m)->name, (m)->vrefresh, (m)->clock, \
> >         (m)->hdisplay, (m)->hsync_start, (m)->hsync_end, (m)->htotal, \
> >         (m)->vdisplay, (m)->vsync_start, (m)->vsync_end, (m)->vtotal, \
> >         (m)->type, (m)->flags
> > -- 
> > 2.17.1
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
