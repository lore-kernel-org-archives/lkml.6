Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40689C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB42520866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="AHvKGUc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfAVVxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:53:02 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45450 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfAVVxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:53:01 -0500
Received: by mail-yb1-f194.google.com with SMTP id n78so17902yba.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 13:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AGImLWKSXyqcZe7nveg/7vkgivfZ2ayznn3rwDCE8FY=;
        b=AHvKGUc1yOVBQIXBFh5sY1o9v6Vm3IX0sfgcGrTG34kaFzlxf1Jm8AVan2dh507cGI
         ygYgYsNvIhwq7FlmpQGjt7HdKurdL57SPlrCPaGP81/nFKDVEqWEvcR2G9pUVj41TaEI
         f+EYZsEK5+fylSuCVIyAD5L4I8fbl0DWoyLf99bBl1JbckxrmMUBMBelq0KeNXxUQ2Qe
         zfcnnCOGt6DmByNpeJFXR3bEmCMWomuGSAZ7WmfpVGkcfMnHyZ36k0Ebpy2RDVV37zwN
         oRNf3Fcwl9Ecw1FMoc7Cgpxn5Hztk7gRaf6LyV3wGPZ+djf6oCq1CWw0JtuJV+lD7dNz
         8iCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AGImLWKSXyqcZe7nveg/7vkgivfZ2ayznn3rwDCE8FY=;
        b=O1lYtZF6f0dZ863jrPfliL7m8/rBajAmvRSGzwuM0paMMQH2srpQduW9g4JJTvrMx3
         ULTEcrevNJaNh+vj3aZo0qjSZ6ioGNA0rCEzvRKc5qOWA9YeqXLYWbUaA7uhGaWg0qHR
         91N4/4KmnT9Ad1InMsvFzeBFHKVAjyaZZEAXwvSx+KpjfqPKTCCAEqtYeT7RZR1CSTsx
         FVcy2wDNPaCY1mBIrBjTPpWOzVp+QG4rhHERsdpKBqxai7z1jOqVkKM3zjzuxTfbPADT
         q7OVeZWgqwHjiecoSAUm7zucBiWNBsX9kMFbXJ3EhylH+3txR30nRzyY5/x2SwNWZXN4
         B1sg==
X-Gm-Message-State: AJcUukc4kL9bSzD7InaR+hpG1woEaBdEeXx/sYxQ+h9doqQ2TzIZAmZE
        cuQ99YZ4GhxVNwZCgtCNDg4cwQ==
X-Google-Smtp-Source: ALg8bN5UNJJkma6ODmjgOp5ajWZ643xJYjRhSPm0CyAqEy+6i7UzkoQS05f2gvmSgQitqKvDujro4A==
X-Received: by 2002:a25:3455:: with SMTP id b82mr22727920yba.402.1548193980378;
        Tue, 22 Jan 2019 13:53:00 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id w2sm6327173ywe.62.2019.01.22.13.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 13:52:59 -0800 (PST)
Date:   Tue, 22 Jan 2019 16:52:59 -0500
From:   Sean Paul <sean@poorly.run>
To:     Sean Paul <seanpaul@chromium.org>
Cc:     "Hsin-Yi, Wang" <hsinyi@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH resend] drm/panel: panel-innolux: set display off in
 innolux_panel_unprepare
Message-ID: <20190122215259.GN114153@art_vandelay>
References: <20190109065922.231753-1-hsinyi@chromium.org>
 <CAOw6vb+a2SAq+=xfL9RZyA6R7zn-HYFQbDnDaK28TD8yrh+wLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOw6vb+a2SAq+=xfL9RZyA6R7zn-HYFQbDnDaK28TD8yrh+wLg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 12:58:10PM -0500, Sean Paul wrote:
> On Wed, Jan 9, 2019 at 1:59 AM Hsin-Yi, Wang <hsinyi@chromium.org> wrote:
> >
> > Move mipi_dsi_dcs_set_display_off() from innolux_panel_disable()
> > to innolux_panel_unprepare(), so they are consistent with
> > innolux_panel_enable() and innolux_panel_prepare().
> >
> > This also fixes some mode check and irq timeout issue in MTK dsi code.
> >
> > Since some dsi code (e.g. mtk_dsi) have following call trace:
> > 1. drm_panel_disable(), which calls innolux_panel_disable()
> > 2. switch to cmd mode
> > 3. drm_panel_unprepare(), which calls innolux_panel_unprepare()
> >
> > However, mtk_dsi needs to be in cmd mode to be able to send commands
> > (e.g. mipi_dsi_dcs_set_display_off() and mipi_dsi_dcs_enter_sleep_mode()),
> > so we need these functions to be called after the switch to cmd mode happens,
> > i.e. in innolux_panel_unprepare.
> >
> >
> > Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>
> 
> Reviewed-by: Sean Paul <seanpaul@chromium.org>

Applied to drm-misc-next, thanks for your patch.

Sean

> 
> > ---
> > Resend for review.
> > ---
> >  drivers/gpu/drm/panel/panel-innolux-p079zca.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> > index ca4ae45dd307..8e5724b63f1f 100644
> > --- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> > +++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> > @@ -70,18 +70,12 @@ static inline struct innolux_panel *to_innolux_panel(struct drm_panel *panel)
> >  static int innolux_panel_disable(struct drm_panel *panel)
> >  {
> >         struct innolux_panel *innolux = to_innolux_panel(panel);
> > -       int err;
> >
> >         if (!innolux->enabled)
> >                 return 0;
> >
> >         backlight_disable(innolux->backlight);
> >
> > -       err = mipi_dsi_dcs_set_display_off(innolux->link);
> > -       if (err < 0)
> > -               DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
> > -                             err);
> > -
> >         innolux->enabled = false;
> >
> >         return 0;
> > @@ -95,6 +89,11 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
> >         if (!innolux->prepared)
> >                 return 0;
> >
> > +       err = mipi_dsi_dcs_set_display_off(innolux->link);
> > +       if (err < 0)
> > +               DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
> > +                             err);
> > +
> >         err = mipi_dsi_dcs_enter_sleep_mode(innolux->link);
> >         if (err < 0) {
> >                 DRM_DEV_ERROR(panel->dev, "failed to enter sleep mode: %d\n",
> > --
> > 2.18.1
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
