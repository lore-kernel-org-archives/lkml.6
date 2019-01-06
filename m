Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15B3C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 16:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A105320830
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 16:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CaMzSRiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfAFQ0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 11:26:19 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52126 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfAFQ0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 11:26:19 -0500
Received: by mail-it1-f195.google.com with SMTP id w18so7684955ite.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 08:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Owyjnl5/gDuKSXCQwy9gUf1aaKWN07785QKhcQrOOYw=;
        b=CaMzSRiMopDaHsrr60RfdypmPqWHmtPBD/wjaNsm97FBZkPm3cbHoRVCxQFfpV89JY
         g1amfBH1PAthIl3UdjP3P5GNlYxwDxsIMeh6/oJLIJ06mUqxmAd3w79PDCKdRgCS7Cte
         i1ccbl7ajSR4sP26XvBXdnYS3W7Ypn8ibeuO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Owyjnl5/gDuKSXCQwy9gUf1aaKWN07785QKhcQrOOYw=;
        b=A9e5L5agmJ7+F2rgaRGqenFBaYAe88ik78aEyzhexZnq6k+upNz5Xe2lIlRbOt+wdo
         Bsm+X9dDmqjdRAVUSj5ktoSv5oKYtApEUaaSomE/sGzSnIkPaoVP59Jv9wsrdQZPeaWG
         yROO9tW2mzFVz5OfbXkWaA3Ljb43SCojFj+vZFUOOqoSFBGiyVojgj/LCxYlFCCBfbPo
         zfvuV1BPvzsj1IGmsy30UwsgkrLpxAg59fgraFyQJ1496z99cJX4ywkzsSt9rI20EC/Z
         9aLcN0uPvUAvqKXAL5ZxGAx4ATayIE3bYtadPP2gwlgyl5kaXrwJ0VC7UgB9V5bAvOwm
         7iIA==
X-Gm-Message-State: AA+aEWZ7f7brL3m6qqUvnX9ABQJ12V0fXmfRqqeA7/gtTDqRrZtdbBSv
        0iuUyzoyCJHqu/XswdSvo8DBUUHGgeWQriyD4B534w==
X-Google-Smtp-Source: AFSGD/W8PDSI+UEmB/C9081gSCtXenwgL9xwrpsLh5L5JcSiNGhfvOCeTJeghjz14v4//V2f4u3jpG5msEAtyaZDYA0=
X-Received: by 2002:a02:104a:: with SMTP id 71mr36363851jay.103.1546791977448;
 Sun, 06 Jan 2019 08:26:17 -0800 (PST)
MIME-Version: 1.0
References: <20181214204101.9681-1-jagan@amarulasolutions.com>
 <20181214204101.9681-2-jagan@amarulasolutions.com> <20181214220231.GT154160@art_vandelay>
 <CAMty3ZBJGgwKCZSeWQmRRjnx3i5z_rV0GASdKLfjq+dSTGSkdw@mail.gmail.com> <20181220170430.GU154160@art_vandelay>
In-Reply-To: <20181220170430.GU154160@art_vandelay>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sun, 6 Jan 2019 21:56:04 +0530
Message-ID: <CAMty3ZDUj-6=D3phiWyabhsw=SBQA0VghbbV99rfp0LPBsxS+g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI
 LCD panel
To:     Sean Paul <sean@poorly.run>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 10:34 PM Sean Paul <sean@poorly.run> wrote:
>
> On Tue, Dec 18, 2018 at 05:06:38PM +0530, Jagan Teki wrote:
> > On Sat, Dec 15, 2018 at 3:32 AM Sean Paul <sean@poorly.run> wrote:
> > >
> > > On Sat, Dec 15, 2018 at 02:11:01AM +0530, Jagan Teki wrote:
> > > > Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.
> > > >
> > > > Add panel driver for it.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > > Changes for v2:
> > > > - use simple structure for command init
> > > > - update proper comments on power, reset delay sequnce
> > > > - fix to use set_display_off in disable function
> > > > - move mode type to structure
> > > > - drop refres rate value, let drm compute
> > > >
> > > >  MAINTAINERS                                   |   6 +
> > > >  drivers/gpu/drm/panel/Kconfig                 |   9 +
> > > >  drivers/gpu/drm/panel/Makefile                |   1 +
> > > >  .../drm/panel/panel-feiyang-fy07024di26a30d.c | 296 ++++++++++++++++++
> > > >  4 files changed, 312 insertions(+)
> > > >  create mode 100644 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index d2928a4d2847..e643238855ea 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -4732,6 +4732,12 @@ T:     git git://anongit.freedesktop.org/drm/drm-misc
> > > >  S:   Maintained
> > > >  F:   drivers/gpu/drm/tve200/
> > > >
> > > > +DRM DRIVER FOR FEIYANG FY07024DI26A30-D MIPI-DSI LCD PANELS
> > > > +M:   Jagan Teki <jagan@amarulasolutions.com>
> > > > +S:   Maintained
> > > > +F:   drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > > > +F:   Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
> > > > +
> > > >  DRM DRIVER FOR ILITEK ILI9225 PANELS
> > > >  M:   David Lechner <david@lechnology.com>
> > > >  S:   Maintained
> > >
> > > As I mentioned on IRC, this will be drm-misc maintained with the other panels,
> > > no need to have a dedicated MAINTAINERS entry. You'll get pulled from
> > > get_maintainers.pl as a majority commit signer
> >
> > This I missed it on IRC, sorry will drop.
> >
> > >
> > > > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> > > > index d93b2ba709bc..cb8ca93550cf 100644
> > > > --- a/drivers/gpu/drm/panel/Kconfig
> > > > +++ b/drivers/gpu/drm/panel/Kconfig
> > > > @@ -38,6 +38,15 @@ config DRM_PANEL_SIMPLE
> > > >         that it can be automatically turned off when the panel goes into a
> > > >         low power state.
> > > >
> > > > +config DRM_PANEL_FEIYANG_FY07024DI26A30D
> > > > +     tristate "Feiyang FY07024DI26A30-D MIPI-DSI LCD panel"
> > > > +     depends on OF
> > > > +     depends on DRM_MIPI_DSI
> > > > +     depends on BACKLIGHT_CLASS_DEVICE
> > > > +     help
> > > > +       Say Y if you want to enable support for panels based on the
> > > > +       Feiyang FY07024DI26A30-D MIPI-DSI interface.
> > > > +
> > > >  config DRM_PANEL_ILITEK_IL9322
> > > >       tristate "Ilitek ILI9322 320x240 QVGA panels"
> > > >       depends on OF && SPI
> > > > diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> > > > index 6a9b4cec1891..0fa0ef69e109 100644
> > > > --- a/drivers/gpu/drm/panel/Makefile
> > > > +++ b/drivers/gpu/drm/panel/Makefile
> > > > @@ -2,6 +2,7 @@
> > > >  obj-$(CONFIG_DRM_PANEL_ARM_VERSATILE) += panel-arm-versatile.o
> > > >  obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
> > > >  obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
> > > > +obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) += panel-feiyang-fy07024di26a30d.o
> > > >  obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
> > > >  obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) += panel-ilitek-ili9881c.o
> > > >  obj-$(CONFIG_DRM_PANEL_INNOLUX_P079ZCA) += panel-innolux-p079zca.o
> > > > diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > > > new file mode 100644
> > > > index 000000000000..4abccbf62c3c
> > > > --- /dev/null
> > > > +++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > > > @@ -0,0 +1,296 @@
>
> /snip
>
> > > > +static const struct drm_display_mode feiyang_default_mode = {
> > > > +     .clock = 55000,
> > > > +
> > > > +     .hdisplay = 1024,
> > > > +     .hsync_start = 1024 + 396,
> > > > +     .hsync_end = 1024 + 396 + 20,
> > > > +     .htotal = 1024 + 396 + 20 + 100,
> > > > +
> > > > +     .vdisplay = 600,
> > > > +     .vsync_start = 600 + 12,
> > > > +     .vsync_end = 600 + 12 + 2,
> > > > +     .vtotal = 600 + 12 + 2 + 21,
> > >
> > > These timings are still incorrect, they'll give a 56.2Hz refresh rate. Is that
> > > really what you want?
> >
> > I would like to go with same rate as of now since BSP is using the
> > same, since I don't have any information from chip vendor(even I wrote
> > it and waiting for response). I will update accordingly once I get the
> > information from vendor.
> >
> > Let me know your inputs.
>
> Not totally on board with this, tbh. It seems wrong, so I'm not sure why we'd
> apply code that seems wrong. We're not in a rush, we've already cut 4.21, so I
> think we should just wait for vendor confirmation on these values.

No, I'm not asking to apply just to know how it works and more over I
can see some panels still use refresh rate 60 but with wrong panel
timings.

Anyway, I've managed to satisfy the refresh rate 60 with changed porch
values. Here are new timings.

        .clock = 55000,
        .hdisplay = 1024,
        .hsync_start = 1024 + 310,
        .hsync_end = 1024 + 310 + 20,
        .htotal = 1024 + 310 + 20 + 90,
        .vdisplay = 600,
        .vsync_start = 600 + 12,
        .vsync_end = 600 + 12 + 2,
        .vtotal = 600 + 12 + 2 + 21

I can see the display as same as before, but not clear is there anyway
to update porch values for desired refresh rate computation.
