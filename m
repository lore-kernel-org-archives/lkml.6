Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61DCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B041223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bfHJo6ID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B041223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388474AbeKPB3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:29:34 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51032 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388226AbeKPB3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:29:34 -0500
Received: by mail-it1-f193.google.com with SMTP id k206-v6so29870550ite.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 07:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pE11ItvWla61LlLEoseGZsG5FAoPnWFt98hSwfzdvOw=;
        b=bfHJo6IDTUv8lk713t6YWzyd+fyjAd8C2vWLd2cEpy/r802dZli+Z/5aRIzZ2fYJEu
         tK7i9HlrbDZ7wc7/HXqkByoqomJNPR/Dnu+o4dbtq5QMj5FcZE7gcrabtQGuQL/IFBx7
         YfbEq854L596BY+ocfbkgOhC1jIw2YfWAUnM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pE11ItvWla61LlLEoseGZsG5FAoPnWFt98hSwfzdvOw=;
        b=GjTpUAKwFMsD2msn2+jC+tE7gQCMd1GmeRbuVFQgkCw+2pis/vJPBOTTl9NMfdhR+E
         rJnnLRSQktGeadmcSzCQLrS/RdVGSZxQxxP/g4oLWsb/lDZ74mKs2tCc2QersiGD9A3Z
         1OooWRDCDKV6JxLqv3v7QkK385fC3kI09qI20I2VwbR+mFvf3zuTk8IXhVB1sgxF3RmA
         6CCw37ZEsHQjNBJcEkFZO0ZsGWkC4Tfg7ulWNbYg6qYp+tWhxEFvbaDtf4C4bgxQtaTm
         aar8fZJclwlzSgkE6AMAIyyCJXJR6kZe7Pz5kO0ElRkxmf26u68S0/hZPTl1uJlI7D/K
         uIPw==
X-Gm-Message-State: AGRZ1gKX18YC8u5tmjX+Av9mElFPpmF2+FUpnXOpKQscr4b9OkgndGSy
        kmInyWn1cNxWn347unNCcUhjGO+HNjmeFP0eb9uRow==
X-Google-Smtp-Source: AJdET5cy8lL9cnKuw1fnNu2KICFiv7z7uHODf5XoV4h1liaV7d3VVDS1khqF7hmD/VuxhJlqbkkzor60FS6sbR1dh+s=
X-Received: by 2002:a02:94d:: with SMTP id f74-v6mr6282123jad.85.1542295276455;
 Thu, 15 Nov 2018 07:21:16 -0800 (PST)
MIME-Version: 1.0
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-4-jagan@amarulasolutions.com> <20181113132658.niwy6bqdqzaeqpv2@flea>
In-Reply-To: <20181113132658.niwy6bqdqzaeqpv2@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 15 Nov 2018 20:51:04 +0530
Message-ID: <CAMty3ZBTaeMBFYwyJ+8HqHBDAfEOPEYBt01jho1H4c3SBKbvEw@mail.gmail.com>
Subject: Re: [PATCH v4 03/26] clk: sunxi-ng: Add check for maximum rate to NKM PLLs
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
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 6:57 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Nov 13, 2018 at 04:46:10PM +0530, Jagan Teki wrote:
> > Some NKM PLLs, frequency can be set above PLL working range.
> >
> > Add a constraint for maximum supported rate. This way, drivers can
> > specify which is maximum allowed rate for PLL.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > Acked-by: Stephen Boyd <sboyd@kernel.org>
>
> As Vasily reported on a previous version, this should be squashed with
> the patch 2.

Sorry, I missed it.

>
> > ---
> >  drivers/clk/sunxi-ng/ccu_nkm.c | 3 +++
> >  drivers/clk/sunxi-ng/ccu_nkm.h | 1 +
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> > index 6b5ad990f802..b8b66cdd30bf 100644
> > --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> > +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> > @@ -128,6 +128,9 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
> >       if (rate < nkm->min_rate)
> >               return nkm->min_rate;
> >
> > +     if (nkm->max_rate && rate > nkm->max_rate)
> > +             return nkm->max_rate;
> > +
>
> I would expect the test to be the same for the minimum and maximum cases.

I don't have proper use-case for max rate test, I do verify by using
higher the rate on dclock, but nor sure.  May be I can skip the
max_rate patch?

Apart from this, any idea about this issue where SUN4I_TCON0_DCLK_REG
will only work with div upto 6 on A64 DSI panels[1], did you find the
same issue on A33?

With parent rate 330MHz, the resulting tcon divider for 30MHz [2]
clock is 11 and for the same for 55MHz [3] clock is 6.

[3] https://paste.ubuntu.com/p/drvzfHFMtY/
[2] https://paste.ubuntu.com/p/hz29CTJY2J/
[1] https://elixir.bootlin.com/linux/v4.20-rc2/source/drivers/gpu/drm/sun4i/sun4i_dotclock.c#L125
