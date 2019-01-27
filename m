Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55373C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 19:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEA92133D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 19:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Gdhve0sr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfA0TMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 14:12:09 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54681 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfA0TMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 14:12:09 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so17616438ita.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 11:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDpUAHHqnKGbSCbsDCUJPtYTurj2xbl6rKxPUJec+AU=;
        b=Gdhve0sruq/hcGG2VHmvBuFPlBGiyWeO9tfnA/8sFsU3d9KXwh3plLHUhiaysoPH+G
         qEUtu4FWk+2MtRhgjLcH9bBpAPLZp2CFND3ALPu82bBVKCGE/yXoeaVI+s4nQE/cKrnB
         2meRQrPc7X1UR+b6GKFKNpiOb1WOMFGnZPjQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDpUAHHqnKGbSCbsDCUJPtYTurj2xbl6rKxPUJec+AU=;
        b=rqvGqxKPmy6phyNdpkkEIIWFuUecuTI3iDi75n2DziLgLmMJ7Mr4I3JDt/qvTxKa3Y
         NpBaMkVvLGe7C9HHWfO7Wij63L4v/CicX1U8QFi31PrkR87Wi+QMQYl4n5G4+B0BTgSZ
         m2iTlAcx8os8NnlMiE0K8xmo3wGPSZRV61ROWZdzr4QioDA0tTZnY7WjuhBpjhI+V4k9
         t0KDeoTUK2N4W+GZ+KWtp9jFIZcnxwvAD4RPnhpazsZTMeMj8XDOSocn2Vw/Y8lXqNk4
         7LARNPbA85uMaCzMfvsdizkCdOwI8puVPWA14aiHQp9PVtpFudvhrvBiOz/hC85pFRo+
         lxdg==
X-Gm-Message-State: AJcUukdrn4UVfb3IIZt2nenD2HUJhhPWOS5Zhs52NMcKGduynkHjFP6d
        3QwJ0f7afV7VHn14PtgnZHqLtH4cQaPZr7n1m7aG9Q==
X-Google-Smtp-Source: ALg8bN7JIL2/gH2GNxlEe+BHExisVEnKYzAYfmVmTh9et+v4vkVJBu6T6hs91BexNxmkpVZz3BYbv/QsfWdEbKXk6QU=
X-Received: by 2002:a24:10cb:: with SMTP id 194mr7290380ity.173.1548616328285;
 Sun, 27 Jan 2019 11:12:08 -0800 (PST)
MIME-Version: 1.0
References: <20190125192233.10019-1-jagan@amarulasolutions.com>
 <20190125192233.10019-2-jagan@amarulasolutions.com> <20190125195205.GA31938@ravnborg.org>
In-Reply-To: <20190125195205.GA31938@ravnborg.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 28 Jan 2019 00:41:56 +0530
Message-ID: <CAMty3ZAB9vceDu0g-mRhBr2poZHZdNq3D1_-Fp7uYxhGg3GrCg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI
 LCD panel
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 1:22 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Jagan.
>
> Looks good, only very few nits left.
>
> On Sat, Jan 26, 2019 at 12:52:33AM +0530, Jagan Teki wrote:
> > Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.
> >
> > Add panel driver for it.
> >
> > Tested-by: Bhushan Shah <bshah@kde.org>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> If you consider my inputs (I know you will) then you can add my:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>
>
> > +     msleep(20);
> > +
> > +     gpiod_set_value(ctx->reset, 0);
> > +     /* T5 + T6 (avdd rise + video & logic signal rise)
> > +      * T5 >= 10ms, 0 < T6 <= 10ms
> > +      */
> > +     msleep(20);
>
> Please use kernel coding style comment, and maybe an empty
> line between gpiod...() and the comment:
>
>         gpiod_set_value(ctx->reset, 0);
>         /*
>          * T5 + T6 (avdd rise + video & logic signal rise)
>          * T5 >= 10ms, 0 < T6 <= 10ms
>          */
>         msleep(20);
>
>
> > +static int feiyang_get_modes(struct drm_panel *panel)
> > +{
> > +     struct drm_connector *connector = panel->connector;
> > +     struct feiyang *ctx = panel_to_feiyang(panel);
> > +     struct drm_display_mode *mode;
> > +
> > +     mode = drm_mode_duplicate(panel->drm, &feiyang_default_mode);
> > +     if (!mode) {
> > +             DRM_DEV_ERROR(&ctx->dsi->dev, "failed to add mode %ux%ux@%u\n",
> > +                           feiyang_default_mode.hdisplay,
> > +                           feiyang_default_mode.vdisplay,
> > +                           feiyang_default_mode.vrefresh);
> Please consider to use DRM_MODE_FMT and DRM_MODE_ARG for printing.

I see DRM_MODE_ARG as mode argument, that print all mode timings but
here we need only 3 timings out of it. do we really need? if yes
please suggest an example.
