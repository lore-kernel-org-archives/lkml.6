Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3423CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE0620652
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE0620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeHaPRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:17:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34568 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeHaPRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:17:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id u1-v6so8591350eds.1;
        Fri, 31 Aug 2018 04:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPmr1DX2/HiSUZ0WWNQKY/BJwqiNLoWEkY06X7hidHc=;
        b=NR0x8tR78+s11h9Jb17kWLVAHvVkE8d18E6emRGUGpVOF+N+P/dtqg2/PXPUGsJmOx
         Jsk6jZmdC6Qyr8uDBNiajORmnOu9SQtw7MTR2kEBkdx3herYkqIOKWFK/Y+fQhRREjEp
         +QCW9sHvYEFaoUmstqMjNv7+IMzVQ9j4GVQ1tAAKNp0yZX65Gy2rFGVycnMXzoL/7vEy
         mhZmUgvcQR5nlyW5d0Tn2a4lL3t/J8DZFuQdNcE0BgnmQcBjTyEA0FY4H9kuN8E5ocyb
         1PAseotTXiCh7KUuvNYmUPE+YcdNV4YOMzPInBolJ/6qTxcmgOvLNVbP+3y5NTyLY+RH
         aaJw==
X-Gm-Message-State: APzg51AGi+Otb50AjsZICeEKPD9R9jZzpZDyIWpPYUQmALmGuYIu8bwS
        pJQGjgtWh0RV5+2F3Jpu6eQSiOaoFeQ=
X-Google-Smtp-Source: ANB0VdYf+zK8FnoXYXozc3eAtscwAziCC53n4AqoV+q2pGpqfWK3EHnTH8B8pbq61rkQas8isUgqSg==
X-Received: by 2002:a50:b206:: with SMTP id o6-v6mr16954684edd.160.1535713829664;
        Fri, 31 Aug 2018 04:10:29 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id l30-v6sm4773035edc.70.2018.08.31.04.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 04:10:27 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id m27-v6so10861419wrf.3;
        Fri, 31 Aug 2018 04:10:26 -0700 (PDT)
X-Received: by 2002:adf:e486:: with SMTP id i6-v6mr10729462wrm.145.1535713826606;
 Fri, 31 Aug 2018 04:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <20180830190120.722-10-clabbe.montjoie@gmail.com> <20180831073500.zubqpvar4yhjqrge@flea>
 <20180831075631.GB16301@Red> <CAGb2v65dWmFxacx16taTdDf0WO4vCJfJLrf=7Vh6RtJEjHdH5A@mail.gmail.com>
 <20180831092934.GC16301@Red>
In-Reply-To: <20180831092934.GC16301@Red>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 31 Aug 2018 19:10:13 +0800
X-Gmail-Original-Message-ID: <CAGb2v65H_Aog294NYAmcTGARGiOiyCDy=MT9g8ed=Cxr8Bm3Qg@mail.gmail.com>
Message-ID: <CAGb2v65H_Aog294NYAmcTGARGiOiyCDy=MT9g8ed=Cxr8Bm3Qg@mail.gmail.com>
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

On Fri, Aug 31, 2018 at 5:29 PM Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
>
> On Fri, Aug 31, 2018 at 03:58:34PM +0800, Chen-Yu Tsai wrote:
> > On Fri, Aug 31, 2018 at 3:56 PM Corentin Labbe
> > <clabbe.montjoie@gmail.com> wrote:
> > >
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
> > > > >                     #size-cells = <0>;
> > > > >             };
> > > > >
> > > > > +           ahci: sata@1c18000 {
> > > > > +                   compatible = "allwinner,sun8i-r40-ahci";
> > > > > +                   reg = <0x01c18000 0x1000>;
> > > > > +                   interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> > > > > +                   clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
> > > > > +                   resets = <&ccu RST_BUS_SATA>;
> > > > > +                   resets-name = "ahci";
> > > > > +                   #address-cells = <1>;
> > > > > +                   #size-cells = <0>;
> > > > > +                   status = "disabled";
> > > > > +
> > > > > +                   sata_port: sata-port@0 {
> > > > > +                           reg = <0>;
> > > > > +                           phys = <&sata_phy>;
> > > > > +                   };
> > > > > +           };
> > > > > +
> > > > > +           sata_phy: sata-phy@1c180c0  {
> > > > > +                   compatible = "allwinner,sun8i-r40-sata-phy";
> > > > > +                   reg = <0x1c180c0 0x200>;
> > > >
> > > > Overlapping devices in the DTS is not ok.
> > > >
> > >
> > > I do the same than arch/arm/boot/dts/berlin2.dtsi (sata@e90000 phy@e900a0)
> > > But since it is not a good justification, it seems that regmap is my only solution ?
> >
> > Since you are effectively splitting one device node into two, you should
> > adjust the original (ahci) device nodes register range.
> >
>
> I cannot do that if I remove patch 13, iow If I keep phy init code in both place as you requested.

Then you need to split the phy handling between a10 and r40. A10 doesn't
need phy-supply at the moment anyway. And migrating A10 to newer binding
is only causing you problems anyway. Just drop that part, and handle the
R40.

ChenYu
