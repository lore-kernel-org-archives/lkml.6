Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03202C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2AA216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2AA216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeI0WxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:53:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35966 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeI0WxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:53:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id f4-v6so5639495edq.3;
        Thu, 27 Sep 2018 09:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+QhkkuE/aSNr/1GY7/FBZYBzRSbsyy/VBOfzU0BL+zI=;
        b=dPKfLuI3rCuT2BafNolzrvCGbRaoosI+YtYu4+/unXdW09tPtxYDNoqjbZCFcNmeYF
         p6LgOhvMQpB8OMTTQaFb7toKA1WG4vL11nLYqxiFNUOxi20jXNpBwZH+bwMJlsGI/RPR
         kgDE6Xy6hvIwt9PsrQ1lYOj3y0JA0RoER3700N1CgHdw8erNxfeDNuprTH/JAhDzns9F
         1ExSHBK4XKnZlZPDgzA1bFKdDBVEWl5wUygzjPrMTU7LYFevNUlEM5MDkGAB3d3IWejh
         iNmOWubYZTCeoK6mS0kTnI7N6TSGNfjXk0jCsJIzLuVnBTvekbz7CMWkqeKixSAs+kKg
         DuIQ==
X-Gm-Message-State: ABuFfogZaVMqfRQkcimJt7sc1VNobSLqo8z31/7n9pMZkrdg04Zfgqwb
        qqhse0Nwyw2RN0J0aZ3Nekg/I0lBgrI=
X-Google-Smtp-Source: ACcGV630h9iLzlfLz2dBPbOaoSF3Xa5TWf4MSbjjHhbtMNzrGjT2D1FJCoXgwhAPi/LftKnuJZMskw==
X-Received: by 2002:a17:906:e2c6:: with SMTP id gr6-v6mr2846366ejb.13.1538066033473;
        Thu, 27 Sep 2018 09:33:53 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id c1-v6sm480844edr.18.2018.09.27.09.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 09:33:52 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id z4-v6so1953196wrb.1;
        Thu, 27 Sep 2018 09:33:51 -0700 (PDT)
X-Received: by 2002:a05:6000:82:: with SMTP id m2mr9264461wrx.28.1538066031697;
 Thu, 27 Sep 2018 09:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-5-jagan@amarulasolutions.com> <CAGb2v66No3-AODYCCGifBrm9uvPjaNdR2W5MDQdazRAPomT9CQ@mail.gmail.com>
 <CAMty3ZBUQKVLJsmkU=hjaO_O5bhetDfAh9-7iLkUqOznVc0KyA@mail.gmail.com>
 <CAGb2v67pKgORe7uo6r6F+xaVi=Q-p6_DKotZJD7P=46Z=4RhEA@mail.gmail.com> <CAMty3ZAsF=uSJqj2L9ZS8N3CqcSUPzFSdtH8WtZPTg3m-K8COQ@mail.gmail.com>
In-Reply-To: <CAMty3ZAsF=uSJqj2L9ZS8N3CqcSUPzFSdtH8WtZPTg3m-K8COQ@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 28 Sep 2018 00:33:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v66RPYqH2uDF_izW3PdNrvBhmXecs5A6ThW-3xMeQampqA@mail.gmail.com>
Message-ID: <CAGb2v66RPYqH2uDF_izW3PdNrvBhmXecs5A6ThW-3xMeQampqA@mail.gmail.com>
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

On Fri, Sep 28, 2018 at 12:26 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Thu, Sep 27, 2018 at 7:47 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Thu, Sep 27, 2018 at 9:44 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > On Thu, Sep 27, 2018 at 6:13 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Thu, Sep 27, 2018 at 7:49 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > > >
> > > > > DSI bus_clk is already available in sun6i_dsi but missed to
> > > > > get the clk and process for enable/disable.
> > > > >
> > > > > This patch add support for it.
> > > > >
> > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > ---
> > > > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 8 ++++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > > index 8e9c76febca2..156b371243c6 100644
> > > > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > > @@ -1004,6 +1004,12 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> > > > >                 return PTR_ERR(dsi->reset);
> > > > >         }
> > > > >
> > > > > +       dsi->bus_clk = devm_clk_get(dev, "bus");
> > > > > +       if (IS_ERR(dsi->bus_clk)) {
> > > > > +               dev_err(dev, "Couldn't get the DSI bus clock\n");
> > > > > +               return PTR_ERR(dsi->bus_clk);
> > > > > +       }
> > > > > +
> > > >
> > > > The DSI driver uses devm_regmap_init_mmio_clk, which enables the
> > > > clock behind the scenes when regmap access needs it enabled.
> > > >
> > > > Did you have any issues without this patch?
> > >
> > > I'm unable to read register values via devmem, I see all 0's for all
> > > dsi reg space.
> >
> > Well that is to be expected given how mmio with clk regmap works.
> > Did you encounter any other problems besides this?
>
> no
>
> >
> > FYI you can dump regmap contents using /sys/kernel/debug/regmap/*/registers
>
> Thanks, but ccu not using regmap I believe so can't see bus enabled
> bit set via devmap
> # devmem 0x01C20060
> 0x33800000

That is perfectly normal. It is only enabled when there are accesses to the
DSI regmap.

ChenYu
