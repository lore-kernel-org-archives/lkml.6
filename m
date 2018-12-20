Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6408EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A02E20815
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="O96Eodyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387514AbeLTREe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:04:34 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35410 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732689AbeLTREd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:04:33 -0500
Received: by mail-yw1-f65.google.com with SMTP id h32so966433ywk.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XjtUiSPfIGVCtIqUPvdheUhqS7thYXGiZJO+gNkLbGc=;
        b=O96EodyiOz1UyXnlvrj57AHSS9adv7m6l9AVWmZsNtU4QnjgBe0fgAFjIBzGJl9rkt
         C6yHnx8PGtdIduiwIruTDU0g30StNVjXf+PX8cjxcsoGlSdAUrO2CNZ2ROKexMZAnVN8
         4xbvv29qu70rFaOJ5kVR6941tefUn2GdTISOPsC+gz9AaOzhV4qtPM4VIYN/iqMUrSgk
         MQwdS9or2IA5F4Omu3TqheK/YJs5RZaLlnuAd9wiEaRe9HtkMG7CClpSCpLA4tt9Y0h/
         5pCSsra0o7Rg6ABokBjFflSdaobIC91X4GiEpDG+LLp0NMziryI8Qmvj2pSLJWTFNjTP
         Deug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XjtUiSPfIGVCtIqUPvdheUhqS7thYXGiZJO+gNkLbGc=;
        b=kU+/QnyGujyPyRtgKhwPllDyMFK8888NTihY+8x/xlT82Z9aO8LeOsnOcLXSocnZUU
         rs1g97/w0G0KwwgPgVeBczKdUsdvWUZhyHFtQ2arNDAG3LnoLDu4xalCQTMDgSFTf9wL
         rk2dJLwqM9uHzq2EA/iiAwsevk+yUMTocZAiKmWvmIGgZ+0dzOtTMOFgcf3rG2f0TeBG
         le52+jwzzhctfapXoiCedbor8a+zbBA8yjfhtTOc7r1rY8U8iaZqETd+8jsULe3rB24D
         6lpyP6t1IpQBjyF8vwn1MLuQTkLWRykJYf3dRZagV0SOFQJb/Azst1mSELgzxuQkLqWy
         XH8A==
X-Gm-Message-State: AA+aEWZYyt0E4uYBu/uyxn/zzMXz0YVJBw9Ju7vGzBYEypNIrq8oqEX9
        9Ka1hCrwl4M+p5yLfVeLmrDWFg==
X-Google-Smtp-Source: AFSGD/VCtHM0bEmabgsoDJ5n3CckiU4snFRNw57RhyHajd2uj3k3Ff3mpSEhU4MJA2DtLQqEvbLpTA==
X-Received: by 2002:a81:a155:: with SMTP id y82mr25408566ywg.400.1545325472117;
        Thu, 20 Dec 2018 09:04:32 -0800 (PST)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id l140sm6692013ywe.77.2018.12.20.09.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:04:30 -0800 (PST)
Date:   Thu, 20 Dec 2018 12:04:30 -0500
From:   Sean Paul <sean@poorly.run>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Sean Paul <sean@poorly.run>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v3 2/2] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI
 LCD panel
Message-ID: <20181220170430.GU154160@art_vandelay>
References: <20181214204101.9681-1-jagan@amarulasolutions.com>
 <20181214204101.9681-2-jagan@amarulasolutions.com>
 <20181214220231.GT154160@art_vandelay>
 <CAMty3ZBJGgwKCZSeWQmRRjnx3i5z_rV0GASdKLfjq+dSTGSkdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMty3ZBJGgwKCZSeWQmRRjnx3i5z_rV0GASdKLfjq+dSTGSkdw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 05:06:38PM +0530, Jagan Teki wrote:
> On Sat, Dec 15, 2018 at 3:32 AM Sean Paul <sean@poorly.run> wrote:
> >
> > On Sat, Dec 15, 2018 at 02:11:01AM +0530, Jagan Teki wrote:
> > > Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.
> > >
> > > Add panel driver for it.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v2:
> > > - use simple structure for command init
> > > - update proper comments on power, reset delay sequnce
> > > - fix to use set_display_off in disable function
> > > - move mode type to structure
> > > - drop refres rate value, let drm compute
> > >
> > >  MAINTAINERS                                   |   6 +
> > >  drivers/gpu/drm/panel/Kconfig                 |   9 +
> > >  drivers/gpu/drm/panel/Makefile                |   1 +
> > >  .../drm/panel/panel-feiyang-fy07024di26a30d.c | 296 ++++++++++++++++++
> > >  4 files changed, 312 insertions(+)
> > >  create mode 100644 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index d2928a4d2847..e643238855ea 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -4732,6 +4732,12 @@ T:     git git://anongit.freedesktop.org/drm/drm-misc
> > >  S:   Maintained
> > >  F:   drivers/gpu/drm/tve200/
> > >
> > > +DRM DRIVER FOR FEIYANG FY07024DI26A30-D MIPI-DSI LCD PANELS
> > > +M:   Jagan Teki <jagan@amarulasolutions.com>
> > > +S:   Maintained
> > > +F:   drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > > +F:   Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
> > > +
> > >  DRM DRIVER FOR ILITEK ILI9225 PANELS
> > >  M:   David Lechner <david@lechnology.com>
> > >  S:   Maintained
> >
> > As I mentioned on IRC, this will be drm-misc maintained with the other panels,
> > no need to have a dedicated MAINTAINERS entry. You'll get pulled from
> > get_maintainers.pl as a majority commit signer
> 
> This I missed it on IRC, sorry will drop.
> 
> >
> > > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> > > index d93b2ba709bc..cb8ca93550cf 100644
> > > --- a/drivers/gpu/drm/panel/Kconfig
> > > +++ b/drivers/gpu/drm/panel/Kconfig
> > > @@ -38,6 +38,15 @@ config DRM_PANEL_SIMPLE
> > >         that it can be automatically turned off when the panel goes into a
> > >         low power state.
> > >
> > > +config DRM_PANEL_FEIYANG_FY07024DI26A30D
> > > +     tristate "Feiyang FY07024DI26A30-D MIPI-DSI LCD panel"
> > > +     depends on OF
> > > +     depends on DRM_MIPI_DSI
> > > +     depends on BACKLIGHT_CLASS_DEVICE
> > > +     help
> > > +       Say Y if you want to enable support for panels based on the
> > > +       Feiyang FY07024DI26A30-D MIPI-DSI interface.
> > > +
> > >  config DRM_PANEL_ILITEK_IL9322
> > >       tristate "Ilitek ILI9322 320x240 QVGA panels"
> > >       depends on OF && SPI
> > > diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> > > index 6a9b4cec1891..0fa0ef69e109 100644
> > > --- a/drivers/gpu/drm/panel/Makefile
> > > +++ b/drivers/gpu/drm/panel/Makefile
> > > @@ -2,6 +2,7 @@
> > >  obj-$(CONFIG_DRM_PANEL_ARM_VERSATILE) += panel-arm-versatile.o
> > >  obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
> > >  obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
> > > +obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) += panel-feiyang-fy07024di26a30d.o
> > >  obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
> > >  obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) += panel-ilitek-ili9881c.o
> > >  obj-$(CONFIG_DRM_PANEL_INNOLUX_P079ZCA) += panel-innolux-p079zca.o
> > > diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > > new file mode 100644
> > > index 000000000000..4abccbf62c3c
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > > @@ -0,0 +1,296 @@

/snip

> > > +static const struct drm_display_mode feiyang_default_mode = {
> > > +     .clock = 55000,
> > > +
> > > +     .hdisplay = 1024,
> > > +     .hsync_start = 1024 + 396,
> > > +     .hsync_end = 1024 + 396 + 20,
> > > +     .htotal = 1024 + 396 + 20 + 100,
> > > +
> > > +     .vdisplay = 600,
> > > +     .vsync_start = 600 + 12,
> > > +     .vsync_end = 600 + 12 + 2,
> > > +     .vtotal = 600 + 12 + 2 + 21,
> >
> > These timings are still incorrect, they'll give a 56.2Hz refresh rate. Is that
> > really what you want?
> 
> I would like to go with same rate as of now since BSP is using the
> same, since I don't have any information from chip vendor(even I wrote
> it and waiting for response). I will update accordingly once I get the
> information from vendor.
> 
> Let me know your inputs.

Not totally on board with this, tbh. It seems wrong, so I'm not sure why we'd
apply code that seems wrong. We're not in a rush, we've already cut 4.21, so I
think we should just wait for vendor confirmation on these values.

Sean

-- 
Sean Paul, Software Engineer, Google / Chromium OS
