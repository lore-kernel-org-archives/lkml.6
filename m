Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8804C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652D520661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652D520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeHaMFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:05:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42820 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeHaMFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:05:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id l5so5752936edw.9;
        Fri, 31 Aug 2018 00:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9Vi850Vp2KqVRL9vE3PU+DhowXo0fb0rVWa5qawSKQ=;
        b=MpeHf+mcrm1Lz3MRf0RBzi9ppIfMQzqbKoCcA2wSTO3CPSOTsC0R2Cfy2t5YRtU8W/
         sdYRQU6ultWmXJ2IvQHpg23qFpcjXePjbNfeQLbYaJX/g03+y0AbFQgkOs25wh3s+1qb
         SnfzSkMxzVVL8D+Plti1cIT2FrRzQF9fhlaKxrWCIgpdrUvX8pWIu4MjThi+LHB4HvFc
         iIJHnRsEPyKnOOq5qn01qbzjK0L72pyGKe5y6fbeLidBZT5yR2YMEAvRIpOhHzu6hSbq
         zsUlyJQmnj6PD3ctPWAagB3ute3xmTpafHxOekhB6ZuGVlXdLHmot5bY7xMMl7c3VYQW
         btuA==
X-Gm-Message-State: APzg51CtQrk8xbhRYpglT7v7hVcxIfUZNAk0Q1+DzOAcAiWnxKc/kWw2
        uIWJuBXAMaVIwn6Qa81XnGVVKkUo0ME=
X-Google-Smtp-Source: ANB0VdbLoLvB8wqbCJlreWPPOMSeYXCl8j4NjvcDPlhxXdaZr4p+HQsMghqjOdavGFX8ipB+iwe1zA==
X-Received: by 2002:a50:82c5:: with SMTP id 63-v6mr16076885edg.200.1535702329130;
        Fri, 31 Aug 2018 00:58:49 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id 25-v6sm4477541edz.45.2018.08.31.00.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 00:58:47 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id m27-v6so10327218wrf.3;
        Fri, 31 Aug 2018 00:58:47 -0700 (PDT)
X-Received: by 2002:adf:8485:: with SMTP id 5-v6mr10098624wrg.34.1535702327182;
 Fri, 31 Aug 2018 00:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <20180830190120.722-10-clabbe.montjoie@gmail.com> <20180831073500.zubqpvar4yhjqrge@flea>
 <20180831075631.GB16301@Red>
In-Reply-To: <20180831075631.GB16301@Red>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 31 Aug 2018 15:58:34 +0800
X-Gmail-Original-Message-ID: <CAGb2v65dWmFxacx16taTdDf0WO4vCJfJLrf=7Vh6RtJEjHdH5A@mail.gmail.com>
Message-ID: <CAGb2v65dWmFxacx16taTdDf0WO4vCJfJLrf=7Vh6RtJEjHdH5A@mail.gmail.com>
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

On Fri, Aug 31, 2018 at 3:56 PM Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
>
> On Fri, Aug 31, 2018 at 09:35:00AM +0200, Maxime Ripard wrote:
> > On Thu, Aug 30, 2018 at 09:01:16PM +0200, Corentin Labbe wrote:
> > > R40 have a sata controller which is the same as A20.
> > > This patch adds a DT node for it.
> > >
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/sun8i-r40.dtsi | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > index 852c2ccc3268..d6b5820da850 100644
> > > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > @@ -550,6 +550,29 @@
> > >                     #size-cells = <0>;
> > >             };
> > >
> > > +           ahci: sata@1c18000 {
> > > +                   compatible = "allwinner,sun8i-r40-ahci";
> > > +                   reg = <0x01c18000 0x1000>;
> > > +                   interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> > > +                   clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
> > > +                   resets = <&ccu RST_BUS_SATA>;
> > > +                   resets-name = "ahci";
> > > +                   #address-cells = <1>;
> > > +                   #size-cells = <0>;
> > > +                   status = "disabled";
> > > +
> > > +                   sata_port: sata-port@0 {
> > > +                           reg = <0>;
> > > +                           phys = <&sata_phy>;
> > > +                   };
> > > +           };
> > > +
> > > +           sata_phy: sata-phy@1c180c0  {
> > > +                   compatible = "allwinner,sun8i-r40-sata-phy";
> > > +                   reg = <0x1c180c0 0x200>;
> >
> > Overlapping devices in the DTS is not ok.
> >
>
> I do the same than arch/arm/boot/dts/berlin2.dtsi (sata@e90000 phy@e900a0)
> But since it is not a good justification, it seems that regmap is my only solution ?

Since you are effectively splitting one device node into two, you should
adjust the original (ahci) device nodes register range.

ChenYu
