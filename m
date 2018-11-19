Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0706DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12882086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hbbi4gyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12882086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeKSWAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:00:07 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54000 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbeKSWAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:00:07 -0500
Received: by mail-it1-f195.google.com with SMTP id g85so6094744ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 03:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bn9KmuOyTWybepwi8Hpbfda2Z2GJ6xKnDQUu+pDXM/E=;
        b=hbbi4gyMKre7EhRfEWXbDZHJlRfb+Wm0ZolL9RJscCCBegqyZ2Hml8PMin/n5GeRER
         j9jzzCaP2k9sVsWp9LxctHfhpmhqyOQnJD68Pem8O2Do6CUA1uqI2lAfzhXX55fjR0Hz
         iQ8gbe+ogZrHVxspKFYg7iHx0J6ErCjj1mBEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bn9KmuOyTWybepwi8Hpbfda2Z2GJ6xKnDQUu+pDXM/E=;
        b=OuSTj8933jC+5XU2W5dpKut0m5phEaEj4slhY7diPoDct8VlOyh06bOLGSMXR29uMO
         LBAORUOTn1CnynEK7EZfxYsH8Vp4FaWm3yq4YoI5dyyGnj/QnJTMvt+aYECvy7XXQIwi
         OsdECic97XOT6hfvrfbi5g1EiUpJEZoLv7HNEP7ceF+d+c5PnXw72W8bA2vBhxx5ZCGs
         eDbRLjw76/NfYKv9spnUTPOei7ijhVZKZy4foxIIi5fkLB18D6d9D0rClY23uKgo9C3t
         D/1RJvZ1rlidgWLGX5e3dTo3Gkgw48NOg4PluCtOZv7b7kdPWE0350wgUtSUNun8e49B
         xmig==
X-Gm-Message-State: AGRZ1gId0AGMqW7nPmIy1ifebR+5HJJgaDbSTAqrvbORK2A271VrczLD
        SgEbyhAfp3x82JYIMhjXfaAdVfMDi9hZZORr6FbKSQ==
X-Google-Smtp-Source: AJdET5c0lDDNmQvkctQPrUZl+4JKja5HmZgW8N8CNmz7YeUuXhqzSqaj7DlpTZX/EQz37zpN4urDzKradL4IT6Wg1Fg=
X-Received: by 2002:a24:c846:: with SMTP id w67-v6mr7492666itf.32.1542627404923;
 Mon, 19 Nov 2018 03:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-7-jagan@amarulasolutions.com> <20181119083833.d7ysiv3tenabtrdj@flea>
In-Reply-To: <20181119083833.d7ysiv3tenabtrdj@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 19 Nov 2018 17:06:32 +0530
Message-ID: <CAMty3ZCsEYFJOQAFTf3FspQWMzD-tiW_njuyCJ950RZ=Y6apEw@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] drm/sun4i: sun6i_mipi_dsi: Probe tcon0 during dsi_bind
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 2:08 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Nov 16, 2018 at 10:09:10PM +0530, Jagan Teki wrote:
> > Probe tcon0 during dsi_bind, so-that the tcon attributes like
> > divider value, clock rate can get whenever it need.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 +++++++
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h | 1 +
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index d60955880c43..66a01061e51d 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -25,6 +25,7 @@
> >  #include <drm/drm_panel.h>
> >
> >  #include "sun4i_drv.h"
> > +#include "sun4i_tcon.h"
> >  #include "sun6i_mipi_dsi.h"
> >
> >  #include <video/mipi_display.h>
> > @@ -1007,6 +1008,7 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
> >       struct drm_device *drm = data;
> >       struct sun4i_drv *drv = drm->dev_private;
> >       struct sun6i_dsi *dsi = dev_get_drvdata(dev);
> > +     struct sun4i_tcon *tcon0 = sun4i_get_tcon0(drm);
> >       int ret;
> >
> >       if (!dsi->panel)
> > @@ -1014,6 +1016,11 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
> >
> >       dsi->drv = drv;
> >
> > +     if (!tcon0)
> > +             return -EPROBE_DEFER;
>
> You can't fall in that condition. The component framework won't call
> bind unless every components have been probed.

Since tcon0 is already probed is it? if so I can return -EINVAL is it ok?
