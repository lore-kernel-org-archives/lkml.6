Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353E4C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4B021486
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4B021486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeLCJz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:55:28 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39414 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLCJz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:55:27 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so10151615edt.6;
        Mon, 03 Dec 2018 01:55:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppQqETSEtQ8o22fzvv7O3C3bq1hMhcqdPHZFTNyzrq0=;
        b=pP8g0s+uyjVleREVhRd6MzJJtRGjMBOUewX5vajrcx1fij//nXsTpce4DFtvmVUCTp
         uPj/K4SAN06PFtnUDNOEWUAbQfr8pmMlYt3fckGBtsMw4F1gJNL7UsI0NxJZfeVvvmIW
         SQxCxxbinqb9mDdbHMpsPeWuEXAFq/MN+MaV3ptN6/oXOjjwJGp8eVnih8a1yeNjnJ5N
         1crRoFqmFNpNq/kVhyNIjYb6j8Z+PGAF+rll6T+6NkCrskgT5ikjIQL+V/HX1pRASW6v
         mEm4XyFjgw4LA2omkyvzqNnZt3wINXK0XVzs8ixiZPL1RgcOsDuhf+YwRpat3YtnV4Tr
         lJug==
X-Gm-Message-State: AA+aEWaG8Xg/zXo3qjE9mIaysVW0Bb5lJd4TJ0WGNWgHLihOEKbk9AB5
        7q0Yq+PE+07KmCiRMaLsrho+/oEVw88=
X-Google-Smtp-Source: AFSGD/VJNzi/W8SVYJ+9gXkxCYYQTJo10EjfNSegy7HozQ7bC8tNHAEeBSJmaWFCRVFlFG+HunebzQ==
X-Received: by 2002:a50:9849:: with SMTP id h9mr13324946edb.36.1543830907091;
        Mon, 03 Dec 2018 01:55:07 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id n29sm3723855edd.40.2018.12.03.01.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 01:55:06 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id s14so5057249wmh.1;
        Mon, 03 Dec 2018 01:55:06 -0800 (PST)
X-Received: by 2002:a1c:91d1:: with SMTP id t200mr7520225wmd.111.1543830906225;
 Mon, 03 Dec 2018 01:55:06 -0800 (PST)
MIME-Version: 1.0
References: <20181130075849.16941-1-wens@csie.org> <20181130075849.16941-6-wens@csie.org>
 <CAMty3ZAuBM0s3eNhQBySSaUrUAkiF=Hk+Ab=gsN=QucLJv0zyw@mail.gmail.com>
In-Reply-To: <CAMty3ZAuBM0s3eNhQBySSaUrUAkiF=Hk+Ab=gsN=QucLJv0zyw@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 3 Dec 2018 17:54:54 +0800
X-Gmail-Original-Message-ID: <CAGb2v64dbDW9Fpb_B0d8wQW7WTELqGoUzasV_KXonfEkucRZTA@mail.gmail.com>
Message-ID: <CAGb2v64dbDW9Fpb_B0d8wQW7WTELqGoUzasV_KXonfEkucRZTA@mail.gmail.com>
Subject: Re: [PATCH 5/6] [DO NOT MERGE] ARM: dts: sunxi: bananapi-m2p: Add
 HDF5640 camera module
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 5:52 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Fri, Nov 30, 2018 at 1:29 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > The Bananapi M2+ comes with an optional sensor based on the ov5640 from
> > Omnivision. Enable the support for it in the DT.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi | 87 +++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
> > index b3283aeb5b7d..d97a98acf378 100644
> > --- a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
> > +++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
> > @@ -89,6 +89,42 @@
> >                 };
> >         };
> >
> > +       reg_cam_avdd: cam-avdd {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "csi-avdd";
> > +               regulator-min-microvolt = <2800000>;
> > +               regulator-max-microvolt = <2800000>;
> > +               startup-delay-us = <200>; /* 50 us + board delays */
> > +               enable-active-high;
> > +               gpio = <&pio 3 14 GPIO_ACTIVE_HIGH>; /* PD14 */
> > +       };
> > +
> > +       reg_cam_dovdd: cam-dovdd {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "csi-dovdd";
> > +               regulator-min-microvolt = <2800000>;
> > +               regulator-max-microvolt = <2800000>;
> > +               /*
> > +                * This regulator also powers the pull-ups for the I2C bus.
> > +                * For some reason, if this is turned off, subsequent use
> > +                * of the I2C bus, even when turned on, does not work.
> > +                */
> > +               startup-delay-us = <200>; /* 50 us + board delays */
> > +               regulator-always-on;
> > +               enable-active-high;
> > +               gpio = <&pio 3 14 GPIO_ACTIVE_HIGH>; /* PD14 */
> > +       };
> > +
> > +       reg_cam_dvdd: cam-dvdd {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "csi-dvdd";
> > +               regulator-min-microvolt = <1500000>;
> > +               regulator-max-microvolt = <1500000>;
> > +               startup-delay-us = <200>; /* 50 us + board delays */
> > +               enable-active-high;
> > +               gpio = <&pio 3 14 GPIO_ACTIVE_HIGH>; /* PD14 */
> > +       };
> > +
> >         reg_gmac_3v3: gmac-3v3 {
> >                       compatible = "regulator-fixed";
> >                       regulator-name = "gmac-3v3";
> > @@ -106,6 +142,26 @@
> >         };
> >  };
> >
> > +&csi {
> > +       status = "okay";
> > +
> > +       port {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               /* Parallel bus endpoint */
> > +               csi_from_ov5640: endpoint {
> > +                       remote-endpoint = <&ov5640_to_csi>;
> > +                       bus-width = <8>;
> > +                       data-shift = <2>;
>
> If I'm not wrong, the data-shift is not available in sun6i at-least in
> conf register.

Indeed. Seems only a few drivers actually take this into account. Since
this is just an example, I'm not going to respin it.

ChenYu
