Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B616FC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB182084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VRWjb9rb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfAVIoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:44:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46932 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbfAVIoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:44:13 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so19776726ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 00:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wd+IFHRFSGZybgssa5Rga5Q6TfQk8CSgVm/c12T9/0A=;
        b=VRWjb9rbVKrA7F6udNsiotHdlr+cRtBmRO70ZktTHSXbxm2xsck2S9bhqm7SW7ZQhC
         N7KKq/i8igdTnCG7tjvSUDmaFbAQvoeYDeBZlTioLcYYYKsjEwyP0F7YO27wDkIGXK4Z
         IrgSbGM4S+qYc4Rstasxg3tNIpA6Hi8rupsUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wd+IFHRFSGZybgssa5Rga5Q6TfQk8CSgVm/c12T9/0A=;
        b=oVgmAPRRbTBJQ+Z6pX1lR2IaGJQw1jNgLRtgFqtidYPXTTTcsYh5RJA9/QdIfxe4IE
         inizGibdGa5qj42co59ScHuaT6Q6h4FUOrCyapq+ml4IDs0xrsjyMP5xE7Xif39/8GAY
         2+Twvdyd2cLZQlGkerBCLCuaYORxh/0KURSNTFPfs+LQCuNPzFThZewrPEUNf9RodX5i
         i30m2/cGHAzwjFPW1bOiNp8lTklN33M5uvpEecS32tbHRJcdVZ7Wo3zt9ZdhqfXXfW40
         Z0O2qcK5nw62TR2hV3BJ8u5kGwsLzSqux9/ggYOLW1qyt6Ega3jKL4B7tQTcSGwO04+E
         v7sw==
X-Gm-Message-State: AJcUukdQFeb6XtxDfxbSEsyDeTIcJeYbuz8Uc4EZj2aVB4lXVbQ0SCU0
        Romorj47Mc/zteYazXFwHvk1lQ9uj9V0EbSK2Vw0sA==
X-Google-Smtp-Source: ALg8bN6yJu2NaGTwPHYW3rAIWMijFOiSamyX6zzFe66bQAjWaqC3cgDaWKsfKhbZLgY650c2kcOPnRlx5TmOygDYKwo=
X-Received: by 2002:a2e:5854:: with SMTP id x20-v6mr19401216ljd.31.1548146651061;
 Tue, 22 Jan 2019 00:44:11 -0800 (PST)
MIME-Version: 1.0
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
 <7538d5806003b8f67e7e0d35638315974b7c2b50.1547559542.git.baolin.wang@linaro.org>
 <CAL_Jsq+VpO+pX0A27-v_U+4kQKXKD5O1EWrn708RDeLsqnU1ng@mail.gmail.com>
 <CAMz4kuK0tvYHL1gGDXCKDzow+YmAj587UoBp=fRi0_sujLh2QQ@mail.gmail.com> <CAMuHMdUGm+AzHsSgPf2Z0aPApzu5-gPuv1YfLU+RhXNb1DQ9yA@mail.gmail.com>
In-Reply-To: <CAMuHMdUGm+AzHsSgPf2Z0aPApzu5-gPuv1YfLU+RhXNb1DQ9yA@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 22 Jan 2019 16:43:58 +0800
Message-ID: <CAMz4kuLfip=5MvUO_bPktAh7zGeOdig3B+PB0WYybCJSu7nj6w@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: spi: Add the DMA properties for the SPI
 dma mode
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>, lanqing.liu@unisoc.com,
        linux-spi <linux-spi@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,
On Tue, 22 Jan 2019 at 16:11, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Baolin,
>
> On Tue, Jan 22, 2019 at 3:23 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > On Mon, 21 Jan 2019 at 21:53, Rob Herring <robh+dt@kernel.org> wrote:
> > > On Tue, Jan 15, 2019 at 7:47 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > From: Lanqing Liu <lanqing.liu@spreadtrum.com>
> > >
> > > The email address should be updated with unisoc.com.
> >
> > Sure.
> >
> > >
> > > > Add the DMA properties for the SPI dma mode.
> > > >
> > > > Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
> > > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/spi/spi-sprd.txt |    9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
> > > > index bad211a..01ef53f 100644
> > > > --- a/Documentation/devicetree/bindings/spi/spi-sprd.txt
> > > > +++ b/Documentation/devicetree/bindings/spi/spi-sprd.txt
> > > > @@ -14,6 +14,12 @@ Required properties:
> > > >         address on the SPI bus. Should be set to 1.
> > > >  - #size-cells: Should be set to 0.
> > > >
> > > > +Optional properties:
> > > > +dma-names: Should contain names of the SPI used DMA channel.
> > > > +dmas: Should contain DMA channels which the SPI used sorted in the
> > > > +       same order as the dma-names property.
> > > > +sprd,dma-slave-ids: Should contain the DMA number that the SPI hardware required.
> > > > +
> > > >  Example:
> > > >  spi0: spi@70a00000{
> > > >         compatible = "sprd,sc9860-spi";
> > > > @@ -21,6 +27,9 @@ spi0: spi@70a00000{
> > > >         interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> > > >         clock-names = "spi", "source","enable";
> > > >         clocks = <&clk_spi0>, <&ext_26m>, <&clk_ap_apb_gates 5>;
> > > > +       dma-names = "rx_chn", "tx_chn";
> > > > +       dmas = <&apdma 11>, <&apdma 12>;
> > > > +       sprd,dma-slave-ids = <11 12>;
> > >
> > > When would this be different values from what's in 'dmas'?
> >
> > Slave id is not always same with the DMA channel number in 'dmas', and
> > it is just coincident for SPI driver. Moreover for different SoC , the
> > slave ids for DMA engine consumers are not same. So we need one
> > property to specify the slave id for the consumers to trigger DMA
> > transfer.
>
> Perhaps the DMA controller should use #dma-cells = <2>, so you can specify
> the second value in the dmas property?

Yes, that's a good point. I will try to change our DMA driver. Thanks.

-- 
Baolin Wang
Best Regards
