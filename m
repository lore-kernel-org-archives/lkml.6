Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9333EECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2E32082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BwzsR2sV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2E32082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeJ2XhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:37:15 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37455 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeJ2XhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:37:15 -0400
Received: by mail-io1-f65.google.com with SMTP id k17-v6so5112582ioc.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 07:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MnfB3NBe0zr1IXXWgqSFxtO5BvGhLc8TBKxaaj9cCek=;
        b=BwzsR2sVkdQHP5JgKSnEzD2CevxoIsomasmUYuhh1KOILyuYbFqPa6lEwLM9u9ZnN6
         GnXQocNPvty0xv9gtYBb58l9zIXbR8/9hYS0s2rergrsb+QM8pxv9mboMdVABCHILRfI
         7FFyiPw3aIIfCXH4nim+IJVs6cOMao3hqbKVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MnfB3NBe0zr1IXXWgqSFxtO5BvGhLc8TBKxaaj9cCek=;
        b=eWQfDYLsH69iCUAgPkDX67YnsGiVk3k+ubXFMxSm+tiwK/tSbfa7GGkcUz6TRGIL2P
         IS4EpHAlvO62/XlhYTHghBdcB+GVsjER+nqajplU66vUjJPCFX8CQKAWmLS2gnYmPz6t
         ZSrc123RzvELWy21u49qyEtYk/ElXo0dacjIkx6HfyK6m48KoRmgYhsuW7PtDreFDO/3
         HJLrNnGZm2MgJFginp0+0WBsGhZe46Do93E85rE60N3nrQgXjP0u+Mbrcv2RKbgF4kpH
         y+0QYdns0wKO8xsFOP628d+5pHVRIPm+GzLdzvT57vybUOwOG1m/QM8UrNzhWFqA51+C
         hlxg==
X-Gm-Message-State: AGRZ1gJ2KSxKTwq8U17vZ7UxZuKJu63dBVGwo9Jy/E5nZZe1MaxBPfXH
        jxz+nj6O1Lq0a3hSL9CecJHRe7H9VYWZKEhQ2IFhww==
X-Google-Smtp-Source: AJdET5dBNFcx+T0XtSKsE12EO9npZjqqlsU9APzl/9F0+4onp8dO5yJlAcwiLNmA+uouQ3g3B3ZU1PD7iVmm5xlrOgY=
X-Received: by 2002:a6b:3e57:: with SMTP id l84-v6mr8662688ioa.252.1540824497221;
 Mon, 29 Oct 2018 07:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-17-jagan@amarulasolutions.com> <20181029093142.hgn4q6o7q32voutf@flea>
In-Reply-To: <20181029093142.hgn4q6o7q32voutf@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 29 Oct 2018 20:18:05 +0530
Message-ID: <CAMty3ZBky1kP-1Q+ja2BpcbTxdHgQOFn=T4bcnZwMz6zP+AcOQ@mail.gmail.com>
Subject: Re: [PATCH v3 16/25] drm/sun4i: sun6i_mipi_dsi: Add support for
 VCC-DSI voltage regulator
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 3:01 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Oct 26, 2018 at 08:13:35PM +0530, Jagan Teki wrote:
> > Some boards have VCC-DSI pin connected to voltage regulator which may
> > not be turned on by default.
> >
> > Add support for such boards by adding voltage regulator handling code to
> > MIPI DSI driver.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > Tested-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v3:
> > - new patch
> > Changes for v2:
> > - none
> >
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 14 ++++++++++++++
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  3 +++
> >  2 files changed, 17 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index 42bd7506abaf..bc57343592e0 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -949,6 +949,12 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
> >
> >       dsi->drv = drv;
> >
> > +     ret = regulator_enable(dsi->regulator);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to enable regulator\n");
> > +             return ret;
> > +     }
> > +
>
> The regulator should be enabled only when the device is in use.

True, but there is no device specific quirk needed because who ever
not needed simply use dummy regulator
[    0.245821] sun6i-mipi-dsi 1ca0000.dsi: 1ca0000.dsi supply vcc-dsi
not found, using dummy regulato
r

even like HVCC in hdmi driver [1]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c?id=633ba1e086e1abbeef1ffd899911de8cf3987d9f
