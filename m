Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E8EECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AEB215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AEB215E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeI0Ufk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:35:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40656 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeI0Ufk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:35:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id j62-v6so5183746edd.7;
        Thu, 27 Sep 2018 07:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1il2Nqf0kQ+yKYGeQhVEWTl3F8qYWRASqe1kYkVxU4=;
        b=PJfQ1gM0mCoP/9UzWUWcvRxu26jvmk3FR/sgtNyMsMbCCnwQ559wbLzis1ar+CE3Zr
         xeAylfN3hgtQ41YmqdDdBj435es448o01WbtYie9fxsaunivLt8hSo3gfbZEj8oGZDPb
         QI8Ne02MJY65fJAgUnrYnuGo/dsRvYoXPiATm2trRdWLqQlgmotWN2lmnizfhnigYqpE
         RO5LFei5s28SEBEiz7SxmqQVYlpn2FYnpCWAdkMy+PprCXRvLKMAOat2aElqmTF55o3U
         9p38xkk26NCguYDDXMblV4BtLtfVW9xKf8mY/7OF+w7Q908unHLXH1OtuBgpxvEr2Kja
         3Tbw==
X-Gm-Message-State: ABuFfojuXt4/xovtSDS3aMb6aH262PKpbWk2iqkkHDOPHeQPOh4hw0b0
        NANFjM1DJc9OXsTzM5OMWDX2ixEp0pU=
X-Google-Smtp-Source: ACcGV61MyLSr61hr2BfsnQoH4GpIJT2ZxbHEMmM+JfLvsgCa6osr8IwZ7Nw+J/QpabXMApVdwAKAtA==
X-Received: by 2002:a17:906:838a:: with SMTP id p10-v6mr2088252ejx.3.1538057830217;
        Thu, 27 Sep 2018 07:17:10 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id ay6-v6sm101268ejb.4.2018.09.27.07.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 07:17:09 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id y25-v6so6090277wmi.1;
        Thu, 27 Sep 2018 07:17:09 -0700 (PDT)
X-Received: by 2002:a1c:8dd1:: with SMTP id p200-v6mr8114625wmd.145.1538057828877;
 Thu, 27 Sep 2018 07:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-5-jagan@amarulasolutions.com> <CAGb2v66No3-AODYCCGifBrm9uvPjaNdR2W5MDQdazRAPomT9CQ@mail.gmail.com>
 <CAMty3ZBUQKVLJsmkU=hjaO_O5bhetDfAh9-7iLkUqOznVc0KyA@mail.gmail.com>
In-Reply-To: <CAMty3ZBUQKVLJsmkU=hjaO_O5bhetDfAh9-7iLkUqOznVc0KyA@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 27 Sep 2018 22:16:56 +0800
X-Gmail-Original-Message-ID: <CAGb2v67pKgORe7uo6r6F+xaVi=Q-p6_DKotZJD7P=46Z=4RhEA@mail.gmail.com>
Message-ID: <CAGb2v67pKgORe7uo6r6F+xaVi=Q-p6_DKotZJD7P=46Z=4RhEA@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 04/12] drm/sun4i: sun6i_mipi_dsi: Enable
 missing DSI bus clock
To:     Jagan Teki <jagan@amarulasolutions.com>
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
        Mike Turquette <mturquette@baylibre.com>,
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

On Thu, Sep 27, 2018 at 9:44 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Thu, Sep 27, 2018 at 6:13 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > Hi,
> >
> > On Thu, Sep 27, 2018 at 7:49 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > DSI bus_clk is already available in sun6i_dsi but missed to
> > > get the clk and process for enable/disable.
> > >
> > > This patch add support for it.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > index 8e9c76febca2..156b371243c6 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > @@ -1004,6 +1004,12 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> > >                 return PTR_ERR(dsi->reset);
> > >         }
> > >
> > > +       dsi->bus_clk = devm_clk_get(dev, "bus");
> > > +       if (IS_ERR(dsi->bus_clk)) {
> > > +               dev_err(dev, "Couldn't get the DSI bus clock\n");
> > > +               return PTR_ERR(dsi->bus_clk);
> > > +       }
> > > +
> >
> > The DSI driver uses devm_regmap_init_mmio_clk, which enables the
> > clock behind the scenes when regmap access needs it enabled.
> >
> > Did you have any issues without this patch?
>
> I'm unable to read register values via devmem, I see all 0's for all
> dsi reg space.

Well that is to be expected given how mmio with clk regmap works.
Did you encounter any other problems besides this?

FYI you can dump regmap contents using /sys/kernel/debug/regmap/*/registers

ChenYu
