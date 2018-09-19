Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5D9ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FD52151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FD52151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbeISV7M convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:59:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39688 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731391AbeISV7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:59:11 -0400
Received: by mail-ed1-f66.google.com with SMTP id h4-v6so5401049edi.6;
        Wed, 19 Sep 2018 09:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ap6XA8YfQJ6jVr6uiT60QSCnYHR0iC1wmT5crB2hlDs=;
        b=qhkFaImUAF451ZGYfi1oJ30KaKSVqZgMeTmUEUmqEaxU717ccnf57wG/qBwAqcWPJi
         SwTjmM8Vc0PFmGntjHdyYpZVQE77+PoBzH5lvGVWWzqjhZqta+MbvG7iMz70ReIHcsyY
         gvEvG7XVDQGKeGRzNN4aB9qg9lp/fD60mRRLpXNkeRR/W5cDBjhWs9E/LtfgHUdWQusY
         YECi7570RvmYbECqNFnOeSPFiGDPnFIx1POBZ+cuqcGYRCwfEcw1G7KkB7AVSQG8Mghf
         Yrc5tdc+4nZS30N2txaDkobWjKo8zdql1oFIQuhq8OLLqdOIPr4STSco+WgPl6REPx2s
         6ncg==
X-Gm-Message-State: APzg51AYzBYZrAxn3EQ5gzSF4mEPqo/rFrh8pZzMOJtfu5l8+reGgxwl
        sNSjy9gZ9CIsNGHqRKF+0ErM808JtnY=
X-Google-Smtp-Source: ANB0VdZKiQzjGFYSVTqZhSJMEbRxcoi1QTcQ0R13Xw4Lw2dCAMKZ4bVYZjdYJCllZL1nqZFGs4XlEg==
X-Received: by 2002:a50:b544:: with SMTP id z4-v6mr37973266edd.219.1537374031510;
        Wed, 19 Sep 2018 09:20:31 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id k33-v6sm1600692edb.31.2018.09.19.09.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 09:20:31 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id y2-v6so6939388wma.1;
        Wed, 19 Sep 2018 09:20:30 -0700 (PDT)
X-Received: by 2002:a1c:e4c3:: with SMTP id b186-v6mr21670198wmh.116.1537374030577;
 Wed, 19 Sep 2018 09:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180907072234.48282-1-icenowy@aosc.io> <20180907072234.48282-6-icenowy@aosc.io>
 <20180910142354.5ldexkvnan6ohz4x@flea> <1926288.mXGsSvSKgU@jernej-laptop>
 <20180917145452.ewfuqkrxjjosbawd@flea> <f968f15fec21ba5b0415b1792536af3e5aba6e57.camel@aosc.io>
In-Reply-To: <f968f15fec21ba5b0415b1792536af3e5aba6e57.camel@aosc.io>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 20 Sep 2018 00:20:19 +0800
X-Gmail-Original-Message-ID: <CAGb2v64N16=3APDnNN5R+EB0524KR86eq1itOnQ8bXsv-HDUOA@mail.gmail.com>
Message-ID: <CAGb2v64N16=3APDnNN5R+EB0524KR86eq1itOnQ8bXsv-HDUOA@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 5/5] ARM: sun8i: dts: drop A64 HDMI PHY
 fallback compatible from R40 DT
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 6:57 AM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> 在 2018-09-17一的 16:54 +0200，Maxime Ripard写道：
> > On Mon, Sep 10, 2018 at 04:32:30PM +0200, Jernej Škrabec wrote:
> > > Dne ponedeljek, 10. september 2018 ob 16:23:54 CEST je Maxime
> > > Ripard
> > > napisal(a):
> > > > On Fri, Sep 07, 2018 at 03:22:34PM +0800, Icenowy Zheng wrote:
> > > > > The R40 HDMI PHY seems to be different to the A64 one, the A64
> > > > > one
> > > > > has no input mux, but the R40 one has.
> > > > >
> > > > > Drop the A64 fallback compatible from the HDMI PHY node in R40
> > > > > DT.
> > > > >
> > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > > ---
> > > > >
> > > > >  arch/arm/boot/dts/sun8i-r40.dtsi | 3 +--
> > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > b/arch/arm/boot/dts/sun8i-r40.dtsi index
> > > > > ffd9f00f74a4..5f547c161baf
> > > > > 100644
> > > > > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > @@ -800,8 +800,7 @@
> > > > >
> > > > >                 };
> > > > >
> > > > >                 hdmi_phy: hdmi-phy@1ef0000 {
> > > > >
> > > > > -                       compatible = "allwinner,sun8i-r40-hdmi-
> > > > > phy",
> > > > > -                                    "allwinner,sun50i-a64-
> > > > > hdmi-phy";
> > > > > +                       compatible = "allwinner,sun8i-r40-hdmi-
> > > > > phy";
> > > >
> > > > If you could use the A64 phy before, you can still use it now.
> > >
> > > Not exactly. Given that we don't know how to switch between HDMI
> > > PHY clock
> > > parents on A64 (if it is actually connected at all, there is no
> > > information
> > > about that in manual and AW didn't answered our questions, despite
> > > asking them
> > > through different channels), A64 compatible will be associated with
> > > quirk,
> > > which will tell that only one clock parent is usable.
> > >
> > > However, R40 HDMI PHY has definetly two clock parents, as it was
> > > tested by me
> > > and Icenowy and we know how to switch between them without issues.
> > > Technically, we could have A64 compatible there, but that would
> > > mean only
> > > single PHY parent is considered instead of two.
> >
> > The DT change above would mean that you can't operate the R40 phy in
> > the same way than the A64's. From what you're telling me now, this
> > isn't exactly what is going on: you can operate the R40 phy just like
> > the A64: with a single PLL instead of two. You operate in a degraded
> > and non-optimal mode, but it still works.

I suppose it's a slightly different semantic. While we have no definite
data regarding the A64, there are some possibilities:

  1. The muxing mechanism isn't present on the A64, and the HDMI PHY
     only takes one clock.

  2. The muxing is present, but only the first parent is connected.
     Switching to the second input causes it to stop working.

  3. Same as above, but both parents are connected to video0-pll.
     This might be indistinguishable from 1., even if checking whether
     the bit modifications stick or not.

In any case, I think this deserves proper experimentation, and subsequent
documentation in the bindings of our "assumptions" (i.e. educated guess)
about what the hardware is doing.

>
> The status of R40 HDMI PHY input mux is not determined when use A64
> driver, which makes it not working when the bootloader initializes it
> to use the second PLL (the A64 driver will assume the parent is the
> first PLL).

That doesn't sound good. But it really depends on what we assume the
A64 is doing.

ChenYu

> >
> > And it's exactly what the DT is already saying.
> >
> > Maxime
> >
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
