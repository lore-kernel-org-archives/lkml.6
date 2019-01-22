Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4873FC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A01F2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfAVILg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:11:36 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:34826 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbfAVILg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:11:36 -0500
Received: by mail-vk1-f195.google.com with SMTP id b18so5175735vke.2;
        Tue, 22 Jan 2019 00:11:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=teir3mBsFUdt388sIJOWTM62fFUlm4syvnMXcwRKWtc=;
        b=DIG5wZjFi5q+FszCti2KdSx774QTykrkqFnBMWYb3HvszE5Z7+Wd6XzTC+fKc2IEKB
         O7+NZe8tBCPiAWe0o0U2Rxw5n0FRX7LxfgYYTAFSgXvHz8ZJb638TV6prnYSWViGiIwk
         q6zx/yFSzEFDXPWxldeqGdAngwLJHAYp0McrG4kuCih8VgKcsjcCv8J55g9mc+lBkNys
         3CG4coJWvTP/8rZcwXWJNwZDNc5b/QEClOj1BynXw6Cp+rOV7t9CWsawJJEotmKz8dJ1
         GWrMtafBmAJYnkJHRabd/Y4NoNC7co1L0fkroQUWkqtImJqLhhZ3FMcsn0FpSSoSBc5d
         OeEw==
X-Gm-Message-State: AJcUukeRMYZlaTw2EUkjmZDDduXCDcssQ23JRGT+DAL0ZIrDkqUVK+NR
        9tDZF4BoEHVuvhq1J06z8skkzUngH1fEXTROC2A=
X-Google-Smtp-Source: ALg8bN4YFYsQFUFZ6Oszu1LQy82nYL3gLoE679oCCVPfYTmZOjk4TETqW46/MWuCM1bFeZW4DkhD53bZn00KOdu1gm0=
X-Received: by 2002:a1f:2145:: with SMTP id h66mr13385195vkh.65.1548144694168;
 Tue, 22 Jan 2019 00:11:34 -0800 (PST)
MIME-Version: 1.0
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
 <7538d5806003b8f67e7e0d35638315974b7c2b50.1547559542.git.baolin.wang@linaro.org>
 <CAL_Jsq+VpO+pX0A27-v_U+4kQKXKD5O1EWrn708RDeLsqnU1ng@mail.gmail.com> <CAMz4kuK0tvYHL1gGDXCKDzow+YmAj587UoBp=fRi0_sujLh2QQ@mail.gmail.com>
In-Reply-To: <CAMz4kuK0tvYHL1gGDXCKDzow+YmAj587UoBp=fRi0_sujLh2QQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Jan 2019 09:11:22 +0100
Message-ID: <CAMuHMdUGm+AzHsSgPf2Z0aPApzu5-gPuv1YfLU+RhXNb1DQ9yA@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: spi: Add the DMA properties for the SPI
 dma mode
To:     Baolin Wang <baolin.wang@linaro.org>
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

Hi Baolin,

On Tue, Jan 22, 2019 at 3:23 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> On Mon, 21 Jan 2019 at 21:53, Rob Herring <robh+dt@kernel.org> wrote:
> > On Tue, Jan 15, 2019 at 7:47 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > From: Lanqing Liu <lanqing.liu@spreadtrum.com>
> >
> > The email address should be updated with unisoc.com.
>
> Sure.
>
> >
> > > Add the DMA properties for the SPI dma mode.
> > >
> > > Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/spi/spi-sprd.txt |    9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
> > > index bad211a..01ef53f 100644
> > > --- a/Documentation/devicetree/bindings/spi/spi-sprd.txt
> > > +++ b/Documentation/devicetree/bindings/spi/spi-sprd.txt
> > > @@ -14,6 +14,12 @@ Required properties:
> > >         address on the SPI bus. Should be set to 1.
> > >  - #size-cells: Should be set to 0.
> > >
> > > +Optional properties:
> > > +dma-names: Should contain names of the SPI used DMA channel.
> > > +dmas: Should contain DMA channels which the SPI used sorted in the
> > > +       same order as the dma-names property.
> > > +sprd,dma-slave-ids: Should contain the DMA number that the SPI hardware required.
> > > +
> > >  Example:
> > >  spi0: spi@70a00000{
> > >         compatible = "sprd,sc9860-spi";
> > > @@ -21,6 +27,9 @@ spi0: spi@70a00000{
> > >         interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> > >         clock-names = "spi", "source","enable";
> > >         clocks = <&clk_spi0>, <&ext_26m>, <&clk_ap_apb_gates 5>;
> > > +       dma-names = "rx_chn", "tx_chn";
> > > +       dmas = <&apdma 11>, <&apdma 12>;
> > > +       sprd,dma-slave-ids = <11 12>;
> >
> > When would this be different values from what's in 'dmas'?
>
> Slave id is not always same with the DMA channel number in 'dmas', and
> it is just coincident for SPI driver. Moreover for different SoC , the
> slave ids for DMA engine consumers are not same. So we need one
> property to specify the slave id for the consumers to trigger DMA
> transfer.

Perhaps the DMA controller should use #dma-cells = <2>, so you can specify
the second value in the dmas property?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
