Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5068FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 01:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0686E2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 01:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0686E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeIXH7Z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 03:59:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33773 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIXH7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 03:59:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id g26-v6so1820909edp.0;
        Sun, 23 Sep 2018 18:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wS4COzUK7bO0xJuD+Xb71DeJgxBC/MK+ia2FMMP0DUU=;
        b=dYI7iT8VLKNd6BGzYfpiOasIhu69sX9gw9/m03vwJxXsx1q0kqEABdayP7IBsxA/F/
         mTFyRpoFeGWysbL5Ze6wXisRLh+bTYvCjBJZaHBNm+2WmMzSMS9AgmAWaAzD70zh/qD3
         fHYn8zfAxgAd+qFk9VRyBmqZLYxbYqc2sagm9Ksn1WNRZDxpTmaNIYxvJ8fCWOdSawnn
         W16/BODXG7oOLdCONZmQmYtkhpiOG25+Zrl3jatMZzwU+Pl9YDpOSt0laQjgYQUQ5OMk
         lsw4a8GKH8+Ql0Ub3DSMrNq0aN8l3+LA8JE0CBeSZX46Qj5tTRoyBXMe7/qWICvkJnes
         6SoA==
X-Gm-Message-State: ABuFfoiJAtDymTXlpmGSM3HkbBMSnRSa40AXcmMiUXUOPZoUbvA28PiZ
        eFwJfgIguXdrDR8uYLRT60tq6aGwIzo=
X-Google-Smtp-Source: ANB0VdbjTLXtZZr6VvDrlDpESJPHLHZVeWmg5I7ZjfVtoJYwbJQ9njTD5Tj3YueixZt1ZnUB+YAxgQ==
X-Received: by 2002:a50:9e85:: with SMTP id a5-v6mr13830676edf.92.1537754375169;
        Sun, 23 Sep 2018 18:59:35 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id d12-v6sm5892599ede.78.2018.09.23.18.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 18:59:34 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id t15so10122194wrx.1;
        Sun, 23 Sep 2018 18:59:34 -0700 (PDT)
X-Received: by 2002:adf:e484:: with SMTP id i4-v6mr6939043wrm.145.1537754374017;
 Sun, 23 Sep 2018 18:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <CAGb2v66kp4B5VZfmTc8L6qt=OPHjbYBtXRbC=L6jGTzvEKvb=w@mail.gmail.com>
 <CAGb2v65LzGgXORTx7PR+udZsrgGgmnXeaOW-jb=KMjHjTg7bRg@mail.gmail.com> <6201242.bzTTWRITmP@jernej-laptop>
In-Reply-To: <6201242.bzTTWRITmP@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 24 Sep 2018 09:59:22 +0800
X-Gmail-Original-Message-ID: <CAGb2v64m-mNOe+GFUZ6msisdkADRKK3m7zpwPqQ-=auV5sxXNw@mail.gmail.com>
Message-ID: <CAGb2v64m-mNOe+GFUZ6msisdkADRKK3m7zpwPqQ-=auV5sxXNw@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 13/27] drm/sun4i: Add support for H6 DE3
 mixer 0
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
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
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 3:40 AM Jernej Škrabec <jernej.skrabec@siol.net> wrote:
>
> Dne sobota, 22. september 2018 ob 15:47:03 CEST je Chen-Yu Tsai napisal(a):
> > On Sat, Sep 22, 2018 at 9:23 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > > On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net>
> wrote:
> > > > Mixer 0 has 1 VI and 3 UI planes, scaler on all planes and can output
> > > > 4K image @60Hz. It also support 10 bit colors.
> > >
> > > AFAICT 10 bit color support is not implemented? Please mention this.
>
> ok.
>
> > >
> > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > ---
> > > >
> > > >  drivers/gpu/drm/sun4i/sun8i_mixer.c | 13 +++++++++++++
> > > >  1 file changed, 13 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > > b/drivers/gpu/drm/sun4i/sun8i_mixer.c index a9218abf0935..54eca2dd4b33
> > > > 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > > @@ -540,6 +540,15 @@ static int sun8i_mixer_remove(struct
> > > > platform_device *pdev)> >
> > > >         return 0;
> > > >
> > > >  }
> > > >
> > > > +static const struct sun8i_mixer_cfg sun50i_h6_mixer0_cfg = {
> > >
> > > Please sort the per-compatible structures according to "version sort"
> > > rules.>
> > > > +       .ccsc           = 0,
> > > > +       .is_de3         = true,
> > > > +       .mod_rate       = 600000000,
> > > > +       .scaler_mask    = 0xf,
> > > > +       .ui_num         = 3,
> > > > +       .vi_num         = 1,
> > > > +};
> > > > +
> > > >
> > > >  static const struct sun8i_mixer_cfg sun8i_a83t_mixer0_cfg = {
> > > >
> > > >         .ccsc           = 0,
> > > >         .scaler_mask    = 0xf,
> > > >
> > > > @@ -587,6 +596,10 @@ static const struct sun8i_mixer_cfg
> > > > sun8i_v3s_mixer_cfg = {> >
> > > >  };
> > > >
> > > >  static const struct of_device_id sun8i_mixer_of_table[] = {
> > > >
> > > > +       {
> > > > +               .compatible = "allwinner,sun50i-h6-de3-mixer-0",
> > > > +               .data = &sun50i_h6_mixer0_cfg,
> > > > +       },
> > >
> > > Same here.
> > >
> > > ChenYu
> >
> > BTW, DE 3.0 includes a register in DE TOP called "DE IP configure register",
> > which gives the number of IP blocks per class, per mixer. If we retrieve
> > the configuration from this register, then we shouldn't need to
> > differentiate between mixer-0 and mixer-1 with compatible strings.
> >
> > What do you think?
>
> IIRC, not all setting were correct when read from registers, but I would need
> to check again. I'm also not sure if register holds all possible settings, so
> it is safer to have separate list. We would also have to devise mechanism to
> get this data from DE2/3 CCU driver (it occupies the same memory space).
>
> Perhaps the strongest argument is that some SoCs with DE3 have HW bug in
> mixer1 block, including that in H6. In order to work, mod clock has to be
> enabled for mixer0 and mixer1 at the same time. I would associate that quirk
> with mixer1 compatible.

OK. That makes sense. So apart from the mentioning 10 bit support status
in the commit log,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
