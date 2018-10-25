Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4249C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871352082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iZQxSlEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871352082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeJYT20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:28:26 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35084 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeJYT20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:28:26 -0400
Received: by mail-it1-f196.google.com with SMTP id p64-v6so1169482itp.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 03:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ZSHoP/QNHkrQ1G3/y91mk+ensvzovTW1aj0lbtU5h0=;
        b=iZQxSlEbX48llLjY8w6aqJKaVBoq8luj55v28K8hBk77XOkkrJ/Yu9d21tzIPA67mN
         7Lau6mAgaCEBZjACmS1ZJXCZUgRfYtfPf3kkwqBEuFVzX4B5Q7cJr1dQT7tIoRRgeswb
         QWqd6DYjGBs+jKtHpDIezSQ3PBU8fzXPoRicI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ZSHoP/QNHkrQ1G3/y91mk+ensvzovTW1aj0lbtU5h0=;
        b=hpuIRRlKp6cgBa3JVpNftqbZriqI9l2RdLLH0XEgA91KB9tosik70fwUyJKb3/5u7E
         b15bDPUzj/Z3Ka5wIpwYHSXMEusHa4tjfyDhWH1Pc5SYyF5bxHj0tTDwgb5Lum54WUYy
         Xb7yeYYz13yFEJ/Pg2xROVdp1dko2IUro4fIlHbLTHzCpoTSfjSxG3d7qh0KG8tgYTKl
         Nyvy0e9vYlmamUyBcNpXAsNDRg1+wXzznc6ve7dcumfqeMAL36p6qDHQGTQ22nIR5o7H
         6/bE8k7u4SBhU7Lk9ltAFq3fdhbOegItauySjUUYPRbiTuqm5F0btabjvU067BaNA6V1
         v0aw==
X-Gm-Message-State: AGRZ1gKVUQz+6vG1st1PrqwFdXn250iPcjBTbLACtwkMx2yGJLSUdIFK
        edtOQ7YM8PvejxPLy7QNvAinN/YoqWfdY5PbrCaxeA==
X-Google-Smtp-Source: AJdET5dik+r+/EXqyu5FNxPXUe1z3vpDHrTtD0FRMOnBszZ803nRraubkSA6snFnrK5HAl6CkQlYpETAXO5pY0/4vXQ=
X-Received: by 2002:a24:9f82:: with SMTP id c124-v6mr599069ite.32.1540464971232;
 Thu, 25 Oct 2018 03:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-3-jagan@amarulasolutions.com> <20181024180436.5n3i3z6h2yezc4cv@flea>
In-Reply-To: <20181024180436.5n3i3z6h2yezc4cv@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 25 Oct 2018 16:25:59 +0530
Message-ID: <CAMty3ZC2wn-DjR+93yc-n-bAmVCHaEqR_=4XPddoo+7LjebTEg@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] clk: sunxi-ng: Add check for minimal rate to NKM PLLs
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

On Wed, Oct 24, 2018 at 11:34 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Tue, Oct 23, 2018 at 09:20:22PM +0530, Jagan Teki wrote:
> > Some NKM PLLs doesn't work well when their output clock rate is set below
> > certain rate.
> >
> > So, add support for minimal rate for relevant PLLs.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v2:
> > - new patch
> >
> >  drivers/clk/sunxi-ng/ccu_nkm.c | 7 +++++++
> >  drivers/clk/sunxi-ng/ccu_nkm.h | 1 +
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> > index 841840e35e61..d17539dc88dd 100644
> > --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> > +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> > @@ -125,6 +125,13 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
> >       if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
> >               rate *= nkm->fixed_post_div;
> >
> > +     if (rate < nkm->min_rate) {
> > +             rate = nkm->min_rate;
> > +             if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
> > +                     rate /= nkm->fixed_post_div;
>
> I'm not sure this is right. Is the post divider taken into account to
> calculate the minimum, or is the minimum on the rate before the fixed
> post divider.

Since we are returning from here, we need to take care post div which
is actually doing at the end of round_rate.

>
> How did you test this?

I've not used this on PLL_MIPI atleast, so I didn't test this.
