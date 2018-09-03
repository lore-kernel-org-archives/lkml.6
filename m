Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E101BC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9728C20857
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9728C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeICG7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:59:09 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33159 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeICG7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:59:09 -0400
Received: by mail-oi0-f66.google.com with SMTP id 8-v6so31165270oip.0;
        Sun, 02 Sep 2018 19:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LUCvmUf2uKvc4O6/kSvDR9sdiysdWyH+VyQlvIJZ2rQ=;
        b=PEo7zX40uy7o9esqrTH2mJMyVdyE9zJchj7b74f94mazu+/Lh0/seOy2jTHW7sl4E+
         e5RCq6RFdBJyhVAhLNUh3sQif4q6xEBJnOvJFYmv8RpYCN6EO0XOf54SA/2vY1JMeJ/X
         St0FpOxsyds/FtObFINtJEReJ0HQHbpdfJxjYjsxGOX8qd85+yFgfOqunVKUt7zqyJPw
         y3jtkoolaK18NGqEmHjV3ZmvyV+BYgVBdAxHK2pb02kGzBHQLW07XeANGBwnzE1/amZy
         mq5V8La79J2IDyYhgyRTDC+LkLuBsqETCibysuSvK7n66SwIA/AWpZZPHiOHRH1T7wRe
         CaUQ==
X-Gm-Message-State: APzg51BVBB7i/EitbPwqBL9KdnsC1380WTBK5izRGnTKB+hlOm+iqMwz
        8tvC/To6qJ3m5YwlPk9yVl+z/SSH
X-Google-Smtp-Source: ANB0VdY0lbK15L/wO+qU0VeQDU3cEYVX3HW1mbEjeMcq4gqdLiyc5ltxs26x509b1QaAqneclYr8+w==
X-Received: by 2002:aca:4141:: with SMTP id o62-v6mr18828117oia.24.1535942466792;
        Sun, 02 Sep 2018 19:41:06 -0700 (PDT)
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 207-v6sm17494404oie.14.2018.09.02.19.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 19:41:06 -0700 (PDT)
Received: by mail-oi0-f43.google.com with SMTP id x197-v6so31148691oix.5;
        Sun, 02 Sep 2018 19:41:06 -0700 (PDT)
X-Received: by 2002:aca:b585:: with SMTP id e127-v6mr16946622oif.119.1535942465975;
 Sun, 02 Sep 2018 19:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180830090038.6956-1-kurt@linutronix.de> <20180903023120.GG3850@dragon>
In-Reply-To: <20180903023120.GG3850@dragon>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Sun, 2 Sep 2018 21:40:56 -0500
X-Gmail-Original-Message-ID: <CADRPPNRf8Hzu7FZoSERZLy=jX4c1RG0b3DJuMYhYLw6HjgdsPA@mail.gmail.com>
Message-ID: <CADRPPNRf8Hzu7FZoSERZLy=jX4c1RG0b3DJuMYhYLw6HjgdsPA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: ls208xa: add second duart
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     kurt@linutronix.de, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 2, 2018 at 9:34 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> It looks good to me.  @Leo, are you okay with it?

It looks fine.

Acked-by: Li Yang <leoyang.li@nxp.com>

>
> Shawn
>
> On Thu, Aug 30, 2018 at 11:00:38AM +0200, Kurt Kanzenbach wrote:
> > The NXP LS208xA SoCs have two dual uarts. Thus, add the second one.
> >
> > Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> > index 8cb78dd99672..547a86ec7cd2 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> > @@ -22,6 +22,8 @@
> >               crypto = &crypto;
> >               serial0 = &serial0;
> >               serial1 = &serial1;
> > +             serial2 = &serial2;
> > +             serial3 = &serial3;
> >       };
> >
> >       cpu: cpus {
> > @@ -221,6 +223,20 @@
> >                       interrupts = <0 32 0x4>; /* Level high type */
> >               };
> >
> > +             serial2: serial@21d0500 {
> > +                     compatible = "fsl,ns16550", "ns16550a";
> > +                     reg = <0x0 0x21d0500 0x0 0x100>;
> > +                     clocks = <&clockgen 4 3>;
> > +                     interrupts = <0 33 0x4>; /* Level high type */
> > +             };
> > +
> > +             serial3: serial@21d0600 {
> > +                     compatible = "fsl,ns16550", "ns16550a";
> > +                     reg = <0x0 0x21d0600 0x0 0x100>;
> > +                     clocks = <&clockgen 4 3>;
> > +                     interrupts = <0 33 0x4>; /* Level high type */
> > +             };
> > +
> >               cluster1_core0_watchdog: wdt@c000000 {
> >                       compatible = "arm,sp805-wdt", "arm,primecell";
> >                       reg = <0x0 0xc000000 0x0 0x1000>;
> > --
> > 2.11.0
> >
