Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C008C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B2A20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B2A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbeHaPi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:38:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34056 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeHaPi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:38:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id u1-v6so8630969eds.1;
        Fri, 31 Aug 2018 04:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KW8GJf+OfR3vh5KT0z9ctRnhW9IhO1vlBZ9ucCcJ3Jo=;
        b=UTF9ZRhweWwQqeSvjcdELQcQmCXHCDu2TmR/PVDVdo39/H7abePdOhjansf3rc29lA
         Pom6NQnuFrz5hP0eYCBUZPzt0rnZQFWkCXESwrUb9P0OyIX6AhtGdoQtJQ1sUAGd2z6O
         Qdc3kTVPM73BvMxIrTXcJlC2BY6ReShngvvDE92R2hSr35ttrkwNRmHxDcRW3FlmMd12
         kpIwtMFF8CIwrIJD1ccbyWzqdI4Pp6seIeGzG6rfcexYmG9lMP2c04wWrlAWxXeFPruQ
         rST4LP15wgb7ZGdGVZlQc4nQ1vYCYsbA5TPEXbXCt9AzjOzU8RH5TKOvFp6bF7HEfaYL
         EYng==
X-Gm-Message-State: APzg51DrNkyAGnNxORl9ADDfti0WIqrt0P3hY+HUrwo1qcx0JYW78kX6
        5KPiCI3MAsmkRvM9e4v8P+W4HJzwO+I=
X-Google-Smtp-Source: ANB0VdbOH5Fye/b91oWL2UC+pWZxPDO/3YVr1a8+dF04ZQ8r5SEiUj+ClMNijUWorrSN+RTCQtKDEw==
X-Received: by 2002:a50:8d5e:: with SMTP id t30-v6mr17735839edt.256.1535715112189;
        Fri, 31 Aug 2018 04:31:52 -0700 (PDT)
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com. [74.125.82.46])
        by smtp.gmail.com with ESMTPSA id g20-v6sm1614906edm.36.2018.08.31.04.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 04:31:50 -0700 (PDT)
Received: by mail-wm0-f46.google.com with SMTP id s12-v6so4921595wmc.0;
        Fri, 31 Aug 2018 04:31:50 -0700 (PDT)
X-Received: by 2002:a1c:f0a:: with SMTP id 10-v6mr4625417wmp.58.1535715109917;
 Fri, 31 Aug 2018 04:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <20180830190120.722-10-clabbe.montjoie@gmail.com> <20180831073500.zubqpvar4yhjqrge@flea>
 <20180831075631.GB16301@Red> <20180831102021.idz42sfgldihpkrp@flea> <20180831105412.GD16301@Red>
In-Reply-To: <20180831105412.GD16301@Red>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 31 Aug 2018 19:31:37 +0800
X-Gmail-Original-Message-ID: <CAGb2v65m73mZkQ9qbYne-utZPujEvRftYGz5kYCx=8t-C-=DJQ@mail.gmail.com>
Message-ID: <CAGb2v65m73mZkQ9qbYne-utZPujEvRftYGz5kYCx=8t-C-=DJQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/13] ARM: dts: sun8i: r40: add sata node
To:     LABBE Corentin <clabbe.montjoie@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>, axboe@kernel.dk,
        Hans de Goede <hdegoede@redhat.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-ide@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 6:54 PM Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
>
> On Fri, Aug 31, 2018 at 12:20:21PM +0200, maxime.ripard@bootlin.com wrote:
> > On Fri, Aug 31, 2018 at 09:56:31AM +0200, Corentin Labbe wrote:
> > > On Fri, Aug 31, 2018 at 09:35:00AM +0200, Maxime Ripard wrote:
> > > > On Thu, Aug 30, 2018 at 09:01:16PM +0200, Corentin Labbe wrote:
> > > > > R40 have a sata controller which is the same as A20.
> > > > > This patch adds a DT node for it.
> > > > >
> > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > > > > ---
> > > > >  arch/arm/boot/dts/sun8i-r40.dtsi | 23 +++++++++++++++++++++++
> > > > >  1 file changed, 23 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > index 852c2ccc3268..d6b5820da850 100644
> > > > > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > @@ -550,6 +550,29 @@
> > > > >                         #size-cells = <0>;
> > > > >                 };
> > > > >
> > > > > +               ahci: sata@1c18000 {
> > > > > +                       compatible = "allwinner,sun8i-r40-ahci";
> > > > > +                       reg = <0x01c18000 0x1000>;
> > > > > +                       interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> > > > > +                       clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
> > > > > +                       resets = <&ccu RST_BUS_SATA>;
> > > > > +                       resets-name = "ahci";
> > > > > +                       #address-cells = <1>;
> > > > > +                       #size-cells = <0>;
> > > > > +                       status = "disabled";
> > > > > +
> > > > > +                       sata_port: sata-port@0 {
> > > > > +                               reg = <0>;
> > > > > +                               phys = <&sata_phy>;
> > > > > +                       };
> > > > > +               };
> > > > > +
> > > > > +               sata_phy: sata-phy@1c180c0  {
> > > > > +                       compatible = "allwinner,sun8i-r40-sata-phy";
> > > > > +                       reg = <0x1c180c0 0x200>;
> > > >
> > > > Overlapping devices in the DTS is not ok.
> > > >
> > >
> > > I do the same than arch/arm/boot/dts/berlin2.dtsi (sata@e90000
> > > phy@e900a0)
> > >
> > > But since it is not a good justification, it seems that regmap is my
> > > only solution ?
> >
> > I'm not even sure why you are moving the phy out of its original node
> > (and driver).
> >
>
> For using the phy-supply already handled by the code.
> The other choice is to add another xxx-supply to ahci_platform.
> Or to use hackily port_regulator for this regulator.

The PHY registers are in the AHCI's "vendor specific registers"
region. Following that are the per-port registers, which the ahci
driver will need access to. This doesn't look like it should
deserve a separate device node.

What's wrong with handling the regulator directly in the ahci-sunxi
PHY init code?

ChenYu
