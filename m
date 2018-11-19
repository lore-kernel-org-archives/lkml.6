Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02D4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B584B20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="i/e4OILQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B584B20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbeKSVYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:24:05 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53644 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbeKSVYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:24:05 -0500
Received: by mail-it1-f195.google.com with SMTP id g85so5944468ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 03:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ffVp6aPCoFOCKnlQvd1ck2b5JzzMBvcPHM4F0YeD6yI=;
        b=i/e4OILQcQvOzWn1wEZsgFRdPqJb8lLNpdrh+XATvyWNg85WJlvzrv0ay3MJ/jzmyR
         eQw+oAo3YrcYJt6CBmknFuZDHkMXwtmcK3ey4xLOqw7CSZ3gm7qLdIkLoUOArE6hMUGW
         I8rJtXQPic39d7okSqrsypbS+B+AtzUulxcYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ffVp6aPCoFOCKnlQvd1ck2b5JzzMBvcPHM4F0YeD6yI=;
        b=Cc+CrCkNsnOvJMWAAb5Kf/kc1Io7bL17csjWSd1GdRedvEc1swVkikAidV7BnTrhF0
         VwjAJTOzVlWZZ/b5IR0Swm8TO8HgrIovtfp749wetLv/L/qomhRCedqeIJLED/XFWynL
         b0rkxSAF5b19IbhBMgh1bzQW9aD7XCqV7SdLTpHEidGkyLDdU9WHslmgxbexkIVlOxLz
         uIlueUTTau9gm1QmFOvlEzVl/DKJXw+QceFbA2HbMxnZJwRPY1JBaZiAbVt24jl9m2g1
         hOb/8mWgEY4GpBzp1rqbcrkIVROvu/5VpwqoX335nJSKqtim8HpVfmhfdPnlPEnVzPQm
         ZOFQ==
X-Gm-Message-State: AGRZ1gIcbt7QlKsxmlCoDGZ72tTc6Hw9zCxaqT79INzbcyaxuNgkXQtH
        p2jsTBxSqrIuRKfzpbWiAlYh4ABaVq2dnwQPyoSrcQ==
X-Google-Smtp-Source: AJdET5fyxCtWFvOeF4hNEcQIBHhg0YCOuRn5v0OnjMSr4TRwABScRnuCkYPYJMAh+cuUpHUWoPQ7JQERUjETlYF317I=
X-Received: by 2002:a02:94d:: with SMTP id f74-v6mr19883746jad.85.1542625248832;
 Mon, 19 Nov 2018 03:00:48 -0800 (PST)
MIME-Version: 1.0
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-4-jagan@amarulasolutions.com> <20181119083036.riydru5xefao3xte@flea>
In-Reply-To: <20181119083036.riydru5xefao3xte@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 19 Nov 2018 16:30:37 +0530
Message-ID: <CAMty3ZBDBDqtH5_m4g-kkKKx+JqcC-r9mc-H+_WWgkLubMWPew@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
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

On Mon, Nov 19, 2018 at 2:00 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Nov 16, 2018 at 10:09:07PM +0530, Jagan Teki wrote:
> > Burst mode display timings are different from convectional
> > video mode so update the horizontal and vertical timings.
> >
> > Reference code taken from BSP (from linux-sunxi/
> > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> >
> > dsi_hsa  = 0;
> > dsi_hbp  = 0;
> > dsi_hact = x*dsi_pixel_bits[format]/8;
> > dsi_hblk = dsi_hact;
> > dsi_hfp  = 0;
> > dsi_vblk = 0;
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> How is that matching the code you have in the rest of your patch?

+       if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+               timings.hblk = (mode->hdisplay * Bpp);
+       else
+               sun6i_dsi_get_timings(dsi, mode, &timings);

It's again your request to "keep the couple of function to make more readable"
