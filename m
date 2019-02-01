Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C38C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D00218F0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BajNbnwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfBALxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:53:55 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42887 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfBALxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:53:55 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so4817741lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 03:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xpRTTMlXvo5iJGg8Z+QDezDrFBfn1zKTvs291ylpF/k=;
        b=BajNbnwafd+Y9vEr27RgET3wODGRDc8jo1IJ41kPua5DIUQskDKod/VXbJ0NMIV2vs
         qMpLQ5Z6vsyNcUBOyiAirDLn7utambUZ0qMy4QmcZdqQP3uKqrFT+fEph5y0QzOs6IxN
         9FGw5VjpU0Qvl3R0j3PxUH34pIMWfxgZthTGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xpRTTMlXvo5iJGg8Z+QDezDrFBfn1zKTvs291ylpF/k=;
        b=EYyxekHD+gtqIObGgcLtHudWJpaF8RfIF9dIb0K3SzjmLxpRqKz3FVXRxQ2aHu6oeC
         TbtjJe7MRuBv1NGFjL8LWs4CH5QqbPS4UWaF1hPuwpjCn00HrAxwJIYG7RlazK1GrxNH
         S6hkHYAi0lcxB2FKfr9N0riIgwJxchoyB1DYq/xtmi52Rq1EWOKBAkeKn1g8wZzMUV6+
         uo6slqy22kka43aF0zTc6rix+ee8C2+RSQxyekc1gzo5lUFOcf69PytRE+M317Pk1AS8
         zGKPpBM8uQ0n+v+1Y+lLGxCleCRVmzJ0HN0lcrFJHBLI6h+GOo6XG1xir1BtI6q0E46F
         6wqw==
X-Gm-Message-State: AHQUAuaZLBCUPp3bOQZCSYo19TqBqLIVICP2xDynUx7ykSqGT3WsyFg1
        ORkahbXYvT9Pty0u9JrAjnjExxXctfSccZJqVGEvQQ==
X-Google-Smtp-Source: AHgI3IZdhQBgZpxs/IBN5+9GwRe8RZuo48hCOuYc/lZTwNWld+Ik8lnQVZcFXW3aUzFxZO5vfpkypX71H28UTOEBaAY=
X-Received: by 2002:a19:f013:: with SMTP id p19mr3305023lfc.61.1549022033248;
 Fri, 01 Feb 2019 03:53:53 -0800 (PST)
MIME-Version: 1.0
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
 <CAK8P3a2zkhrZLMi5KZ5=fGJCt85dad3_pZC0o7GqcwJkk4es9w@mail.gmail.com>
In-Reply-To: <CAK8P3a2zkhrZLMi5KZ5=fGJCt85dad3_pZC0o7GqcwJkk4es9w@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 1 Feb 2019 19:53:42 +0800
Message-ID: <CAMz4ku+PR4bHtcPu2uT2f974+FWJVi8Tp3WzmuqE1TS-M-QawQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Add one new cell to present
 hardware slave id
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        DTML <devicetree@vger.kernel.org>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, eric.long@unisoc.com,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,
On Thu, 31 Jan 2019 at 00:52, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jan 22, 2019 at 2:21 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > The DMA engine clients can trigger DMA engine automatically by setting
> > the corresponding hardware slave id for the DMA engine. Thus add one
> > cell to present the hardware slave id for DMA clients.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/dma/sprd-dma.txt |   12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/sprd-dma.txt b/Documentation/devicetree/bindings/dma/sprd-dma.txt
> > index 7a10fea..7812cf0 100644
> > --- a/Documentation/devicetree/bindings/dma/sprd-dma.txt
> > +++ b/Documentation/devicetree/bindings/dma/sprd-dma.txt
> > @@ -6,8 +6,8 @@ Required properties:
> >  - compatible: Should be "sprd,sc9860-dma".
> >  - reg: Should contain DMA registers location and length.
> >  - interrupts: Should contain one interrupt shared by all channel.
> > -- #dma-cells: must be <1>. Used to represent the number of integer
> > -       cells in the dmas property of client device.
> > +- #dma-cells: must be <2>. Used to represent the channel id and slave id
> > +       of integer cells in the dmas property of client device.
> >  - #dma-channels : Number of DMA channels supported. Should be 32.
> >  - clock-names: Should contain the clock of the DMA controller.
> >  - clocks: Should contain a clock specifier for each entry in clock-names.
> > @@ -28,14 +28,16 @@ apdma: dma-controller@20100000 {
> >
> >  Client:
> >  DMA clients connected to the Spreadtrum DMA controller must use the format
> > -described in the dma.txt file, using a two-cell specifier for each channel.
> > -The two cells in order are:
> > +described in the dma.txt file, using a three-cell specifier for each channel.
> > +The three cells in order are:
> >  1. A phandle pointing to the DMA controller.
> >  2. The channel id.
> > +3. The hardware slave id which is used for clients to trigger DMA engine
> > +automatically.
>
> I notice that this is an incompatible binding change. Is that necessary?
> If the current code works, I'd suggest allowing both #dma-cells=<2>
> and <3>, and then implementing both in the driver.

Yes, this is necessary.

Yes, current code can work, but the problem is that the DMA clients
must add one property (something like "sprd,slave-id") to specify the
slave id. So considering this, we want to change the dma-cells to 2,
including dma channel and dma slave id, which can avoid introducing
some similar properties for DMA clients.

Now there are no DMA clients in mainline for Spreadtrum platform, and
we want to upstream our first DMA clients: SPI controller. So no other
drivers need to change when we changing dma cells. Thanks.

-- 
Baolin Wang
Best Regards
