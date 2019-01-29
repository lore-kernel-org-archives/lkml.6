Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB47FC282D1
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F20821848
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fyfu6Pnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfA2PGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:06:49 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:34507 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfA2PGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:06:48 -0500
Received: by mail-it1-f193.google.com with SMTP id x124so14042606itd.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 07:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UpdjCjz705uz/KNILiOGTwh/Un8wJ22YoGBvOTvB8u4=;
        b=fyfu6PnhFBnOyMzP50zD/CQ1qSlwLD+CxFC7n4bkSNsk6dLxi2iO8oIdIz10bGTwTi
         0kC0ChLDD93an5Uj6QYQVcm5sWF4dB2+XDnDhvQiisndO5sHpRE6xjDcR4Y2czZeXijc
         hT4XF+bECv0+501WrDjO0Qormt8Tedcye2Q5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UpdjCjz705uz/KNILiOGTwh/Un8wJ22YoGBvOTvB8u4=;
        b=N6vX2vv4yN5sFCuFY52QdBh/BO+OKkXgLlylpDhzVD2e4TqlrosK8Oq5tZBPtZq8UA
         LRjO+TuosOPkClTfkY7HOj9l/3Kr9rhTmutpUITEuY86d405Tup2E/45c5Kk0ZuQ0OPQ
         vX4zq15XXSAqaS3AInTzZ3UsgBy9r9n7ualT9l4zb7Ui4GCV5FsHnFQVlGqNZXZhG6uP
         0UbdWfNpqa/hxVcV1d/VbuBo/XIYrQOMUyhLibfq6wW17E8lLQ685PwWDZh0Gpfi/VYn
         q1P/PMIUW+i07FFZMkffoxVMFED4S2k8zpcWheI9jIJ2FTi+4fre49k1mF5O1LH5QU0Q
         hx7A==
X-Gm-Message-State: AJcUukcP2Tx50qV/uSDvRnWMCt3acqNnMKjTynqmx1O4n1VKZ6dXaJTt
        EhHlLmrKgKhOexaE3bHlUchAQm1y6ldgaFnj3aPROcON
X-Google-Smtp-Source: ALg8bN6G1VamLOeQJa2E/+nqlxoY7jJfCaQrHeLthPlEeM6WRuPh2XyXyR+kmaxPXDgXh8uiG5YKgA5m98DqGzSey3k=
X-Received: by 2002:a24:385:: with SMTP id e127mr12518841ite.32.1548774407131;
 Tue, 29 Jan 2019 07:06:47 -0800 (PST)
MIME-Version: 1.0
References: <20190125192233.10019-1-jagan@amarulasolutions.com>
 <20190125192233.10019-2-jagan@amarulasolutions.com> <20190125195205.GA31938@ravnborg.org>
 <CAMty3ZAB9vceDu0g-mRhBr2poZHZdNq3D1_-Fp7uYxhGg3GrCg@mail.gmail.com>
In-Reply-To: <CAMty3ZAB9vceDu0g-mRhBr2poZHZdNq3D1_-Fp7uYxhGg3GrCg@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 29 Jan 2019 20:36:34 +0530
Message-ID: <CAMty3ZCejdo+ztipg0F0SSpSRZwxKxTbhbXA93YqM2GFozxFqg@mail.gmail.com>
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

Hi Sam,

On Mon, Jan 28, 2019 at 12:41 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Sat, Jan 26, 2019 at 1:22 AM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Hi Jagan.
> >
> > Looks good, only very few nits left.
> >
> > On Sat, Jan 26, 2019 at 12:52:33AM +0530, Jagan Teki wrote:
> > > Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.
> > >
> > > Add panel driver for it.
> > >
> > > Tested-by: Bhushan Shah <bshah@kde.org>
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >
> > If you consider my inputs (I know you will) then you can add my:
> > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> >
> >
> > > +     msleep(20);
> > > +
> > > +     gpiod_set_value(ctx->reset, 0);
> > > +     /* T5 + T6 (avdd rise + video & logic signal rise)
> > > +      * T5 >= 10ms, 0 < T6 <= 10ms
> > > +      */
> > > +     msleep(20);
> >
> > Please use kernel coding style comment, and maybe an empty
> > line between gpiod...() and the comment:
> >
> >         gpiod_set_value(ctx->reset, 0);
> >         /*
> >          * T5 + T6 (avdd rise + video & logic signal rise)
> >          * T5 >= 10ms, 0 < T6 <= 10ms
> >          */
> >         msleep(20);
> >
> >
> > > +static int feiyang_get_modes(struct drm_panel *panel)
> > > +{
> > > +     struct drm_connector *connector = panel->connector;
> > > +     struct feiyang *ctx = panel_to_feiyang(panel);
> > > +     struct drm_display_mode *mode;
> > > +
> > > +     mode = drm_mode_duplicate(panel->drm, &feiyang_default_mode);
> > > +     if (!mode) {
> > > +             DRM_DEV_ERROR(&ctx->dsi->dev, "failed to add mode %ux%ux@%u\n",
> > > +                           feiyang_default_mode.hdisplay,
> > > +                           feiyang_default_mode.vdisplay,
> > > +                           feiyang_default_mode.vrefresh);
> > Please consider to use DRM_MODE_FMT and DRM_MODE_ARG for printing.
>
> I see DRM_MODE_ARG as mode argument, that print all mode timings but
> here we need only 3 timings out of it. do we really need? if yes
> please suggest an example.

fyi: sent v6 for this except this change. Let me know if you have any
comments on this.
