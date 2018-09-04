Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5462C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A865D2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A865D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeIDN3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:29:45 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45396 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbeIDN3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:29:45 -0400
Received: by mail-ed1-f68.google.com with SMTP id p52-v6so2617123eda.12;
        Tue, 04 Sep 2018 02:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GmPlO1sgJIbeSvaxL+ZJmZOcbaS6EypK9oQ1dK6HKas=;
        b=O4IygNj4bHKN9B3jXMasRHHro/n5EAegv/pFo5XyCJr3bmIGavgyBfCjBR+Oo+ogAs
         Lb0lF3pE7E+U+HnVWomc7wChqqL3q5rhSrdXPCriUutHes4OxA++9F36tMyBqg2/PRVr
         7hiiUJgDsCW51Q5MHzAuTjOIjuPj4VKyreNlWcnkPODxuSAjtQW6AxewDX3NV+2a6CWH
         YfEkEmnFNlzJDEjx0hNrhUpRdNGRoiuzad7A1pGPD6MWF4lEu15jL3gIwkbsb8dr2wUN
         wdDRClZnNK2D4B3qYbdnODOpPGLyaIk/Mu5XV79ItyJTtE6zsZbFFZoJ9HR/t2CGQIWX
         +aag==
X-Gm-Message-State: APzg51DaQoIKjxBUyKUTBNLlc6tsJb6RBCFD1tQgtJai/eOyzM3jIS2M
        cmJqrvWgQBnWL97b0DGUtbPCAU8gyt4=
X-Google-Smtp-Source: ANB0VdbP/xGiIfNXxBVSxSElrKo7itmwkXS3o6k4xHO4Mqx5TZ8jIZKzYLzL28srzzYHb6S8duZwmg==
X-Received: by 2002:a50:a105:: with SMTP id 5-v6mr34308337edj.186.1536051932485;
        Tue, 04 Sep 2018 02:05:32 -0700 (PDT)
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com. [74.125.82.43])
        by smtp.gmail.com with ESMTPSA id u53-v6sm14445746edm.51.2018.09.04.02.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 02:05:31 -0700 (PDT)
Received: by mail-wm0-f43.google.com with SMTP id q8-v6so3470697wmq.4;
        Tue, 04 Sep 2018 02:05:30 -0700 (PDT)
X-Received: by 2002:a7b:c04c:: with SMTP id u12-v6mr1847653wmc.24.1536051930478;
 Tue, 04 Sep 2018 02:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-8-jernej.skrabec@siol.net> <CAGb2v65AsKzEH3AgmQi+RRvVa6AO-cpAckGnNkvWwONsCCsoxw@mail.gmail.com>
In-Reply-To: <CAGb2v65AsKzEH3AgmQi+RRvVa6AO-cpAckGnNkvWwONsCCsoxw@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 4 Sep 2018 17:05:16 +0800
X-Gmail-Original-Message-ID: <CAGb2v67udJ1_668Q4MFb3MbEQXzukNBKtEu3FYHsw+QyVA9J2Q@mail.gmail.com>
Message-ID: <CAGb2v67udJ1_668Q4MFb3MbEQXzukNBKtEu3FYHsw+QyVA9J2Q@mail.gmail.com>
Subject: Re: [PATCH 07/27] dt-bindings: clock: sun8i-de2: Add H6 DE3 clock description
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

On Tue, Sep 4, 2018 at 4:59 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> Hi,
>
> On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> >
> > This commit adds necessary description and dt includes for H6 DE3 clock.
> > It is very similar to others, but memory region has some additional
> > registers not found in DE2.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> >  Documentation/devicetree/bindings/clock/sun8i-de2.txt | 5 +++--
> >  include/dt-bindings/clock/sun8i-de2.h                 | 3 +++
> >  include/dt-bindings/reset/sun8i-de2.h                 | 1 +
> >  3 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/sun8i-de2.txt b/Documentation/devicetree/bindings/clock/sun8i-de2.txt
> > index e94582e8b8a9..41a52c2acffd 100644
> > --- a/Documentation/devicetree/bindings/clock/sun8i-de2.txt
> > +++ b/Documentation/devicetree/bindings/clock/sun8i-de2.txt
> > @@ -1,5 +1,5 @@
> > -Allwinner Display Engine 2.0 Clock Control Binding
> > ---------------------------------------------------
> > +Allwinner Display Engine 2.0/3.0 Clock Control Binding
> > +------------------------------------------------------
> >
> >  Required properties :
> >  - compatible: must contain one of the following compatibles:
> > @@ -8,6 +8,7 @@ Required properties :
> >                 - "allwinner,sun8i-v3s-de2-clk"
> >                 - "allwinner,sun50i-a64-de2-clk"
> >                 - "allwinner,sun50i-h5-de2-clk"
> > +               - "allwinner,sun50i-h6-de3-clk"
> >
> >  - reg: Must contain the registers base address and length
> >  - clocks: phandle to the clocks feeding the display engine subsystem.
> > diff --git a/include/dt-bindings/clock/sun8i-de2.h b/include/dt-bindings/clock/sun8i-de2.h
> > index 3bed63b524aa..7768f73b051e 100644
> > --- a/include/dt-bindings/clock/sun8i-de2.h
> > +++ b/include/dt-bindings/clock/sun8i-de2.h
> > @@ -15,4 +15,7 @@
> >  #define CLK_MIXER1             7
> >  #define CLK_WB                 8
> >
> > +#define CLK_BUS_ROT            9
> > +#define CLK_ROT                        10
> > +
> >  #endif /* _DT_BINDINGS_CLOCK_SUN8I_DE2_H_ */
> > diff --git a/include/dt-bindings/reset/sun8i-de2.h b/include/dt-bindings/reset/sun8i-de2.h
> > index 9526017432f0..1c36a6ac86d6 100644
> > --- a/include/dt-bindings/reset/sun8i-de2.h
> > +++ b/include/dt-bindings/reset/sun8i-de2.h
> > @@ -10,5 +10,6 @@
> >  #define RST_MIXER0     0
> >  #define RST_MIXER1     1
> >  #define RST_WB         2
> > +#define RST_ROT                3
>
> Looking at the DE 2.0 register guide, the "Rotate" related fields are also
> found on the A83T. So this is not DE 3.0 specific. And you could also have
> the H6 DE3 compatible fall back to the A83T for the common parts.

I take that back. The A83T has a different clock tree structure because it
lacks the DE mod clock, so it's not compatible.

> ChenYu
>
> >
> >  #endif /* _DT_BINDINGS_RESET_SUN8I_DE2_H_ */
> > --
> > 2.18.0
> >
