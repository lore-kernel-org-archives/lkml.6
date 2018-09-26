Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78BEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8372F2151C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8372F2151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbeIZVuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:50:54 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35202 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbeIZVux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:50:53 -0400
Received: by mail-vs1-f68.google.com with SMTP id l3-v6so6268657vsc.2;
        Wed, 26 Sep 2018 08:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVtwsIhmCH4FS/GMHih6iL0Go+1ueTnSWieXyWwaaAg=;
        b=mFoIFlosHQ1nGL8O/H0PSKHN/1B62HuPOelzcDJFFzFwCz3uCxK3BCMYt05A6Zu1Gt
         ddLJTz8PoAPzWld3n/zdUzSHNIY64EGx0xs/9DznjgptBIC4atk9jdfRTqef9mp1UOxW
         tAOdksoQWab3CsEW9tdO7Z20gw3ljwum6bAnvee3NiANTLk6/vRkfMJ/IXgG60/FfzQl
         2nRzBZ0MUuURn/B9EI30euR2rJhauoSKEWUD8aNXW91MrWiPaBLTCIHKDUyS1BGqsN5E
         d4I0C0PuxrBjd4DZxoc7a31OhXT9/2Wx6Z5BOUn/9X7kUgxkcKAbZSdFWL3oc7gbwf8D
         UL+Q==
X-Gm-Message-State: ABuFfoilyh+vwEINYt8i8RmAFrWx/SbDHja8+sdvKLh7VgwyBANChcmv
        uQzWkFUlOxTIRCR1xdz2MAqZc0OPTwO0jpOe3/4=
X-Google-Smtp-Source: ACcGV620hKDi8aBQMJwwqx6FRDiE2ZCW3l1HwDY+aWZnHwb5Eur8Ux8lN5e73FmSUguCRknBU0S/5DfF1cLeA4iY+mQ=
X-Received: by 2002:a67:6582:: with SMTP id z124-v6mr675337vsb.11.1537976242271;
 Wed, 26 Sep 2018 08:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180918093437.26799-1-lukma@denx.de> <20180918093437.26799-2-lukma@denx.de>
 <5baa1aee.1c69fb81.cc7c6.340b@mx.google.com> <20180926163212.17646e43@jawa>
In-Reply-To: <20180926163212.17646e43@jawa>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Sep 2018 17:37:10 +0200
Message-ID: <CAMuHMdWWYvhGX+SmG+WuLJZAX6PdCSd0hzNqiNB1r_A+B6tbSA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: spi: Provide bindings for fsl dspi
 working in slave mode
To:     lukma@denx.de
Cc:     Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Wed, Sep 26, 2018 at 4:33 PM Lukasz Majewski <lukma@denx.de> wrote:
> > On Tue, Sep 18, 2018 at 11:34:35AM +0200, Lukasz Majewski wrote:
> > > This commit provides the description of new property:
> > > "fsl,spi-slave-mode" which enables support for DSPI driver working
> > > in slave mode.
> > >
> > > As the new compatible shall be used with SPI bus equipped with
> > > master device a new "spidev" based node has been introduced to
> > > avoid confusion.
> > >
> > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > ---
> > >  Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> > > b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt index
> > > 18eeafe359d8..b30af19a2bc5 100644 ---
> > > a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt +++
> > > b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt @@ -26,6
> > > +26,7 @@ Optional SPI properties for slave nodes:
> > >  - fsl,spi-sck-cs-delay: a delay in nanoseconds between stopping
> > > the clock signal and deactivating chip select, at the end of a
> > > transfer.
> > >  - bus-num : the slave chip chipselect signal number.
> > > +- fsl,spi-slave-mode: if present, controller runs in slave mode.
> >
> > There's a standard property for this.
>
> I've just realised that there is "spi-slave" property in the
> Documentation/devicetree/bindings/spi/spi-bus.txt
>
> I will convert the code to use it.
>
> >
> > >
> > >  Example:
> > >
> > > @@ -56,6 +57,13 @@ dspi0@4002c000 {
> > >             fsl,spi-cs-sck-delay = <100>;
> > >             fsl,spi-sck-cs-delay = <50>;
> > >     };
> > > +
> > > +   spidev3@1 {
> > > +           compatible = "fsl,vf610-dspi";
> > > +           spi-max-frequency = <30000000>;
> > > +           reg = <1>;
> > > +           fsl,spi-slave-mode;
> >
> > This doesn't look right for how slave mode is described.
>
> You mean that I shall replace fsl,spi-slave-mode; with "spi-slave" ?
>
> Or is there any other issue with this code?

According to Documentation/devicetree/bindings/spi/spi-bus.txt:
  1. "spi-slave" should be a property of the controller node, not of the
     slave node,
  2. the slave node should be called "slave", without unit address, and
     without "reg" property.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
