Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3D9ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3B92150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3B92150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbeIVTlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 15:41:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32921 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeIVTk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 15:40:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id n8-v6so4030011edo.0;
        Sat, 22 Sep 2018 06:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=58t/9lliNZIDeCC/i5LitgKuW/fZmhFr9TD54s61vkI=;
        b=fxogEqXj3FBCzyEthR/d6oZr3mTJIdY8oeqWvFJpNyzAq32AmhZsfij9gpeDeE4dkr
         z0LpWJ5RewdLWIxR9jwsU9R/HBN47b4aivk8XowMxAxhSjuuAt8mhE4ACV+NAfgk5UDc
         r7LkEBVa9LUhxlCtsxT+cjliAb0sgEKAmkrKtUF7LJ2mz5QOQfI2W5sUtd+bswE7YR6v
         jVhIE6Cg0rARvv4f0iDgPhnqWdrWnPOYl+Y1Vrs6Rk8iJyexmMlKgP+YtcetMDTr899Z
         zmofJE2rGJN+sQx0gLmc7phiokLYkxBmLxSw9QpK/OEEPWysB9XTGRqqydA78xrQKUIX
         y4Zw==
X-Gm-Message-State: ABuFfohS9v8ZGfWvu35uY+2bqfwI0cAczWaj2wHJTnxTwJZXUdtKU3Ln
        kaWvP0rcPJb7CODRCEGmL9pLgR0y++E=
X-Google-Smtp-Source: ACcGV61izH/RGVix58tYOE7mBEU1a2PM6szIqkhUKX24GFo4nu+e4tr4izsuDqedo9Rf2Y4p8BgXwA==
X-Received: by 2002:a50:8843:: with SMTP id c3-v6mr3974444edc.146.1537624038212;
        Sat, 22 Sep 2018 06:47:18 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id n44-v6sm3233995edd.15.2018.09.22.06.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 06:47:17 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id t15so7509781wrx.1;
        Sat, 22 Sep 2018 06:47:16 -0700 (PDT)
X-Received: by 2002:adf:9522:: with SMTP id 31-v6mr2027284wrs.91.1537624036640;
 Sat, 22 Sep 2018 06:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-14-jernej.skrabec@siol.net> <CAGb2v66kp4B5VZfmTc8L6qt=OPHjbYBtXRbC=L6jGTzvEKvb=w@mail.gmail.com>
In-Reply-To: <CAGb2v66kp4B5VZfmTc8L6qt=OPHjbYBtXRbC=L6jGTzvEKvb=w@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 22 Sep 2018 21:47:03 +0800
X-Gmail-Original-Message-ID: <CAGb2v65LzGgXORTx7PR+udZsrgGgmnXeaOW-jb=KMjHjTg7bRg@mail.gmail.com>
Message-ID: <CAGb2v65LzGgXORTx7PR+udZsrgGgmnXeaOW-jb=KMjHjTg7bRg@mail.gmail.com>
Subject: Re: [PATCH 13/27] drm/sun4i: Add support for H6 DE3 mixer 0
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 9:23 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> >
> > Mixer 0 has 1 VI and 3 UI planes, scaler on all planes and can output
> > 4K image @60Hz. It also support 10 bit colors.
>
> AFAICT 10 bit color support is not implemented? Please mention this.
>
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> >  drivers/gpu/drm/sun4i/sun8i_mixer.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > index a9218abf0935..54eca2dd4b33 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > @@ -540,6 +540,15 @@ static int sun8i_mixer_remove(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > +static const struct sun8i_mixer_cfg sun50i_h6_mixer0_cfg = {
>
> Please sort the per-compatible structures according to "version sort" rules.
>
> > +       .ccsc           = 0,
> > +       .is_de3         = true,
> > +       .mod_rate       = 600000000,
> > +       .scaler_mask    = 0xf,
> > +       .ui_num         = 3,
> > +       .vi_num         = 1,
> > +};
> > +
> >  static const struct sun8i_mixer_cfg sun8i_a83t_mixer0_cfg = {
> >         .ccsc           = 0,
> >         .scaler_mask    = 0xf,
> > @@ -587,6 +596,10 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
> >  };
> >
> >  static const struct of_device_id sun8i_mixer_of_table[] = {
> > +       {
> > +               .compatible = "allwinner,sun50i-h6-de3-mixer-0",
> > +               .data = &sun50i_h6_mixer0_cfg,
> > +       },
>
> Same here.
>
> ChenYu

BTW, DE 3.0 includes a register in DE TOP called "DE IP configure register",
which gives the number of IP blocks per class, per mixer. If we retrieve the
configuration from this register, then we shouldn't need to differentiate
between mixer-0 and mixer-1 with compatible strings.

What do you think?

ChenYu
