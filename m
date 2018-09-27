Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E861EC004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CA42168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QjkdlCgJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CA42168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeI0Wpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:45:47 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45131 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeI0Wpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:45:47 -0400
Received: by mail-io1-f66.google.com with SMTP id e12-v6so2318019iok.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 09:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9hSiC8g54IX3RJR+iMR9+AIUkN0OY+U1tp3s7puVQc=;
        b=QjkdlCgJdx4RgxSnd4IBF9TCLlx15K6CP17BovV3U4xnUDqgAkiNz1vU4KOaB0lscv
         jQkV5+k+4G2Yk2/rdGBuacuVO9YESIiS+eLZR4DO+HDZxAtOi+VPVrnrELx2zPvU1nC7
         1zZpoWFHLRX9SWE9+NKRowoxvJqbh2Rxjhvks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9hSiC8g54IX3RJR+iMR9+AIUkN0OY+U1tp3s7puVQc=;
        b=b+lOQ5utZdIPqVzB+DiG73R79eH+GdtE+BHJC1QtQzxDMPt+BBJLGsOTneGGf58Nb6
         Hwj7BZc8lZDbIecENYLBTMHPQJDgn88QYN4950tXj6muu2MeTjqmOeQJNHMslTduZdlE
         JuJCWu052Z/e1FxE2RS8euscvvlRt3b2Brearw9Ux/kxS+KFKARTRsY0z/hRHlJUNlhx
         kGSHepiLVPuIbckSCExtwnCK8VsD/zPunIR7F+QbIxP4iTv2MRqmMJegJUzVumkkeynY
         DuTNIEO511WFDcWe2/UYL2ZWlWBGwtyen1n3O49vOAzSvL2xsw4kfdiLH12MrueSfRGj
         Q7/A==
X-Gm-Message-State: ABuFfogL9xqV9o4ESFrnZPrd9JQjHp6XRUcyxW8qgUIFTUeEv1Kr3h3r
        luBK5OsxxiExxaxYVp//Mgoc+RWYnj3+7ZGxwTsVew==
X-Google-Smtp-Source: ACcGV62+o7mCNMpe+GL/yo18S2xAjJ7K8jR0nZqh+3wOI0neK7sus0F3j7hJye1+rdEYCT23gvXSrbvQIdAr9D5BF1E=
X-Received: by 2002:a6b:5104:: with SMTP id f4-v6mr9330998iob.114.1538065604192;
 Thu, 27 Sep 2018 09:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-5-jagan@amarulasolutions.com> <CAGb2v66No3-AODYCCGifBrm9uvPjaNdR2W5MDQdazRAPomT9CQ@mail.gmail.com>
 <CAMty3ZBUQKVLJsmkU=hjaO_O5bhetDfAh9-7iLkUqOznVc0KyA@mail.gmail.com> <CAGb2v67pKgORe7uo6r6F+xaVi=Q-p6_DKotZJD7P=46Z=4RhEA@mail.gmail.com>
In-Reply-To: <CAGb2v67pKgORe7uo6r6F+xaVi=Q-p6_DKotZJD7P=46Z=4RhEA@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 27 Sep 2018 21:56:32 +0530
Message-ID: <CAMty3ZAsF=uSJqj2L9ZS8N3CqcSUPzFSdtH8WtZPTg3m-K8COQ@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 04/12] drm/sun4i: sun6i_mipi_dsi: Enable
 missing DSI bus clock
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

On Thu, Sep 27, 2018 at 7:47 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Thu, Sep 27, 2018 at 9:44 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > On Thu, Sep 27, 2018 at 6:13 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, Sep 27, 2018 at 7:49 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > >
> > > > DSI bus_clk is already available in sun6i_dsi but missed to
> > > > get the clk and process for enable/disable.
> > > >
> > > > This patch add support for it.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > index 8e9c76febca2..156b371243c6 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > @@ -1004,6 +1004,12 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> > > >                 return PTR_ERR(dsi->reset);
> > > >         }
> > > >
> > > > +       dsi->bus_clk = devm_clk_get(dev, "bus");
> > > > +       if (IS_ERR(dsi->bus_clk)) {
> > > > +               dev_err(dev, "Couldn't get the DSI bus clock\n");
> > > > +               return PTR_ERR(dsi->bus_clk);
> > > > +       }
> > > > +
> > >
> > > The DSI driver uses devm_regmap_init_mmio_clk, which enables the
> > > clock behind the scenes when regmap access needs it enabled.
> > >
> > > Did you have any issues without this patch?
> >
> > I'm unable to read register values via devmem, I see all 0's for all
> > dsi reg space.
>
> Well that is to be expected given how mmio with clk regmap works.
> Did you encounter any other problems besides this?

no

>
> FYI you can dump regmap contents using /sys/kernel/debug/regmap/*/registers

Thanks, but ccu not using regmap I believe so can't see bus enabled
bit set via devmap
# devmem 0x01C20060
0x33800000
