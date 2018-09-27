Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294F5C004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54F3216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UC8vHvy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54F3216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeI0UC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:02:56 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36223 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbeI0UCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:02:55 -0400
Received: by mail-it1-f193.google.com with SMTP id c85-v6so7715197itd.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 06:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3jb2dhamBEySQq3tlMPPwXytp5Yy7pFNJZUAGdgr9iU=;
        b=UC8vHvy/9Y+I+NV+M+IRDebAWl7k0Lb7JvBchMJwfo1AseXZVtOujLIfpHzgQk1tl2
         dr5XQlg5xPfL4lHMkhyjKFo60S3qnLpA1AKh2IDkQTXnIbbzw8wrBUAq30i/TYEI16zN
         Kow2WHPYft9DkgM1VPHbtEtaDtjW+CYcf8JXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jb2dhamBEySQq3tlMPPwXytp5Yy7pFNJZUAGdgr9iU=;
        b=s/0uUg9tq0nR9hafn1lGdbgP5yqrOJGSle9VwPd833Bi/tmBTQxUWwTnCI0vA25WOu
         2EIpWkjyg5YZt3Aib4U+kawIJJv1JRn/X+o7GzW4O26UqIf76RZ+J5lJLVR4sfRCSO/M
         Mt1VArQcHw1E3WWvdWJMBm+GuuW3IOA3Iu5EcLtZQ+mIy61oIQPESUoMupGGgN7SEZC5
         cBqxRoLOdNpEqwl1TlIPlofxTVqy7X7hxLo8qEtwc/NfxxvthMSSF7aH6qOSFVbLW2On
         R8FV7vmcBVwtAdzGYQjLZVuxk279gjqLu8Y9v2yFKv9MpuZ9bbEZH3TNVnnw4/o2y0aa
         XO7w==
X-Gm-Message-State: ABuFfog7RToDGCVR/pEeCCRelCJyT5VNYsI7vzvFJHr5ALhKu2xjFHOz
        u2qDKgpNQUPJ6k03EgFg/yuBhvPkiEaudYSd9SJSbg==
X-Google-Smtp-Source: ACcGV61qzbpHFHATfSAeY6ymznsP74MF/OHV7iyRAxm7/CbuYHVoF8pbnEKCbMXmwvb30Yki99agsf2b/Uv1Ewc6Orc=
X-Received: by 2002:a24:809:: with SMTP id 9-v6mr8633158itc.31.1538055875071;
 Thu, 27 Sep 2018 06:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-5-jagan@amarulasolutions.com> <CAGb2v66No3-AODYCCGifBrm9uvPjaNdR2W5MDQdazRAPomT9CQ@mail.gmail.com>
In-Reply-To: <CAGb2v66No3-AODYCCGifBrm9uvPjaNdR2W5MDQdazRAPomT9CQ@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 27 Sep 2018 19:14:23 +0530
Message-ID: <CAMty3ZBUQKVLJsmkU=hjaO_O5bhetDfAh9-7iLkUqOznVc0KyA@mail.gmail.com>
Subject: Re: [PATCH 04/12] drm/sun4i: sun6i_mipi_dsi: Enable missing DSI bus clock
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Icenowy Zheng <icenowy@aosc.io>,
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
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 6:13 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> Hi,
>
> On Thu, Sep 27, 2018 at 7:49 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > DSI bus_clk is already available in sun6i_dsi but missed to
> > get the clk and process for enable/disable.
> >
> > This patch add support for it.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index 8e9c76febca2..156b371243c6 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -1004,6 +1004,12 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> >                 return PTR_ERR(dsi->reset);
> >         }
> >
> > +       dsi->bus_clk = devm_clk_get(dev, "bus");
> > +       if (IS_ERR(dsi->bus_clk)) {
> > +               dev_err(dev, "Couldn't get the DSI bus clock\n");
> > +               return PTR_ERR(dsi->bus_clk);
> > +       }
> > +
>
> The DSI driver uses devm_regmap_init_mmio_clk, which enables the
> clock behind the scenes when regmap access needs it enabled.
>
> Did you have any issues without this patch?

I'm unable to read register values via devmem, I see all 0's for all
dsi reg space.
