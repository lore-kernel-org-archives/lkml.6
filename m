Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7BDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BE8208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BE8208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389502AbeKPT7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:59:39 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43143 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeKPT7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 14:59:39 -0500
Received: by mail-ed1-f68.google.com with SMTP id f4so6401777edq.10;
        Fri, 16 Nov 2018 01:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o7HiIiWdxsWPxERnpuvVbyz65eavanXjc4m6f6LOeMc=;
        b=MzB3w8w589EBMDFllK0pWrWrrSXEnx+AAOWLbSmeHMaq/cr34b4n6VVSskOK9MU6Zc
         pcy/h/avTubXZ7f64j0XqyPbiJDKl8F0fm8dInVCJZV1JuZkstLBC9sbAR36gCz3VhHs
         kwe90vDYG6kRQjVxzB15ygDajYzp+HkVKvPoJXCwJeHiO3dCtVPfYRRZGqI0591TKpKS
         B2z9yx1P+RPR9TBDI9kip1bd8b8kj3WxbGIJ28mt56z2cppx5LfAQLz9flZYc5riXPoo
         /DPlvSatu1Y80SF5oFU3WVsWdshhTJSmZ2XpaXMlnjYnx7GQIhaBzA1RmrBNq/mu8ftt
         Jkbg==
X-Gm-Message-State: AGRZ1gIv0XcU9jXIEpbAsmLTYCAKgq9UpjUIIoOvKtxuvEs3SBMSYE/M
        /vc8Qe/u4riQyJ5zpdPqAWcaThJzvVE=
X-Google-Smtp-Source: AJdET5cAP1MZehLyV2mvDvMB82GdcKNCukKSqoMsip+1DDjn6/9wkfmPkz8QjI2NaLn3epnnwZU/PA==
X-Received: by 2002:a05:6402:184b:: with SMTP id v11mr8990708edy.147.1542361683218;
        Fri, 16 Nov 2018 01:48:03 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id y53sm2973701edd.84.2018.11.16.01.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 01:48:03 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id z13-v6so24190929wrs.3;
        Fri, 16 Nov 2018 01:48:02 -0800 (PST)
X-Received: by 2002:adf:a599:: with SMTP id g25-v6mr9231939wrc.188.1542361682331;
 Fri, 16 Nov 2018 01:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
 <20181115145013.3378-9-paul.kocialkowski@bootlin.com> <20181116093904.4ikn7ldksrm3mp5d@flea>
In-Reply-To: <20181116093904.4ikn7ldksrm3mp5d@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 16 Nov 2018 17:47:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v65EckX0CDbZ5K9VmmayOe3eisOYgUxmPomPgp2_jE5Vww@mail.gmail.com>
Message-ID: <CAGb2v65EckX0CDbZ5K9VmmayOe3eisOYgUxmPomPgp2_jE5Vww@mail.gmail.com>
Subject: Re: [PATCH 08/15] ARM/arm64: sunxi: Move H3/H5 syscon label over to
 soc-specific nodes
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-sunxi@googlegroups.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 5:39 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Nov 15, 2018 at 03:50:06PM +0100, Paul Kocialkowski wrote:
> > Now that we have specific nodes for the H3 and H5 system-controller
> > that allow proper access to the EMAC clock configuration register,
> > we no longer need a common dummy syscon node.
> >
> > Switch the syscon label over to each platform's dtsi file.
> >
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  arch/arm/boot/dts/sun8i-h3.dtsi              | 2 +-
> >  arch/arm/boot/dts/sunxi-h3-h5.dtsi           | 6 ------
> >  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 2 +-
> >  3 files changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> > index 7157d954fb8c..b337a9282783 100644
> > --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> > @@ -134,7 +134,7 @@
> >       };
> >
> >       soc {
> > -             system-control@1c00000 {
> > +             syscon: system-control@1c00000 {
> >                       compatible = "allwinner,sun8i-h3-system-control";
> >                       reg = <0x01c00000 0x1000>;
> >                       #address-cells = <1>;
> > diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> > index 4b1530ebe427..9175ff0fb59a 100644
> > --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> > +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> > @@ -152,12 +152,6 @@
> >                       };
> >               };
> >
> > -             syscon: syscon@1c00000 {
> > -                     compatible = "allwinner,sun8i-h3-system-controller",
> > -                             "syscon";
> > -                     reg = <0x01c00000 0x1000>;
> > -             };
> > -
>
> You're also dropping the syscon compatible there. But I'm not sure how
> it could work with the H3 EMAC driver that would overwrite the
> compatible already.

I assume you are referring to the previous patch? The node names are not
the same, hence the previous patch is adding another node for the system
controller, and this patch removes the old one with the "syscon" compatible.

We already patched the EMAC driver to support the new SRAM controller based
regmap, so other than making people unhappy about having to update their
DT, I don't think there would be any problems. This also means H3 in -next
currently has _two_ syscon nodes.

ChenYu
