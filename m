Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165A8C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D859520863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D859520863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeK3Oxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:53:52 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42287 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeK3Oxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:53:52 -0500
Received: by mail-ed1-f65.google.com with SMTP id j6so3690394edp.9;
        Thu, 29 Nov 2018 19:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mG8evtSjAEIqTCabuI83P9ZLeSo+48+408z67jqVjIw=;
        b=r59YRoLrSWanpFfuIofH9HNJqsyXuowqU4/Oq1zsietUJHKkQi66aNiRrzhcpzDSoy
         dhyQeS82SvEyG+d8cImN6t7/pISR0C9zopACZpjCxW3N5bUBHyERgxYu7S6Jd1gnzTFB
         HjGFpBkEavXGfWtzCEjNiEWLAEf0zR8DJmRr8CkdDnZ3yuuGWfXnhYgdjx3zWMUK+vL3
         4lpYQmB4TcZDvQCX7RpT2xShxq4MPDlUbrx1MiEEczv0UY4LygM1rUtycxuZORYU4CUS
         Qm1NtzyQDyuCj1nhMY1p+4OjmHKTTfRemuHXFZ4+74zAbmbSmfJ3NpC62sIVh1mQehqP
         l8fg==
X-Gm-Message-State: AA+aEWZbDmOyQa2wCN4AQZFDy5rNCwbZCj1/OIXDofz5w+H/Vj02q80Z
        KPJIBvvHTGP7WcT+P3Pv47iCBrkrzwQ=
X-Google-Smtp-Source: AFSGD/VeePKhW7/QoyFTfYjjsjtOwqLazqc6eE1GQTYpzjWZRHB9iozFBJJw6UjxV77xRjeQq4CXmw==
X-Received: by 2002:a50:9f64:: with SMTP id b91mr3658719edf.235.1543549118818;
        Thu, 29 Nov 2018 19:38:38 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id r51sm1104896eda.64.2018.11.29.19.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 19:38:38 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id v13so3893683wrw.5;
        Thu, 29 Nov 2018 19:38:38 -0800 (PST)
X-Received: by 2002:a5d:5208:: with SMTP id j8mr3628272wrv.188.1543549117778;
 Thu, 29 Nov 2018 19:38:37 -0800 (PST)
MIME-Version: 1.0
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
 <20181115145013.3378-8-paul.kocialkowski@bootlin.com> <CAGb2v64t6t3Bwf4nc8gQWRDkdv4zGRF1-+Q7snqX6bkEVqirvA@mail.gmail.com>
In-Reply-To: <CAGb2v64t6t3Bwf4nc8gQWRDkdv4zGRF1-+Q7snqX6bkEVqirvA@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 30 Nov 2018 11:38:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v65yNKnqbeQmUYjMzDtydYL=7kxmtPrAEEU9U=a5XbMiFg@mail.gmail.com>
Message-ID: <CAGb2v65yNKnqbeQmUYjMzDtydYL=7kxmtPrAEEU9U=a5XbMiFg@mail.gmail.com>
Subject: Re: [PATCH 07/15] arm64: dts: allwinner: h5: Add system-control node
 with SRAM C1
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-sunxi@googlegroups.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 12:52 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Thu, Nov 15, 2018 at 10:50 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> >
> > Add the H5-specific system control node description to its device-tree
> > with support for the SRAM C1 section, that will be used by the video
> > codec node later on.
> >
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 22 ++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > index b41dc1aab67d..c2d14b22b8c1 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > @@ -94,6 +94,28 @@
> >         };
> >
> >         soc {
> > +               system-control@1c00000 {
> > +                       compatible = "allwinner,sun50i-h5-system-control";
> > +                       reg = <0x01c00000 0x1000>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       ranges;
> > +
> > +                       sram_c1: sram@1d00000 {
> > +                               compatible = "mmio-sram";
> > +                               reg = <0x01d00000 0x80000>;
>
> I'll try to check this one tomorrow.
>
> I did find something interesting on the H3: there also seems to be SRAM at
> 0x01dc0000 to 0x01dcfeff , again mapped by the same bits as SRAM C1.
>
> And on the A33, the SRAM C1 range is 0x01d00000 to 0x01d478ff.
>
> This was found by mapping the SRAM to the CPU, then using devmem to poke
> around the register range. If there's SRAM, the first read would typically
> return random data, and a subsequent write to it would set some value that
> would be read back correctly. If there's no SRAM, a read either returns 0x0
> or some random data that can't be overwritten.
>
> You might want to check the other SoCs.

This range seems to contain stuff other than SRAM, possibly fixed lookup
tables. Since this is entirely unknown, lets just stick to the known full
range instead.

ChenYu

> > +                               #address-cells = <1>;
> > +                               #size-cells = <1>;
> > +                               ranges = <0 0x01d00000 0x80000>;
> > +
> > +                               ve_sram: sram-section@0 {
> > +                                       compatible = "allwinner,sun50i-h5-sram-c1",
> > +                                                    "allwinner,sun4i-a10-sram-c1";
> > +                                       reg = <0x000000 0x80000>;
> > +                               };
> > +                       };
> > +               };
> > +
> >                 mali: gpu@1e80000 {
> >                         compatible = "allwinner,sun50i-h5-mali", "arm,mali-450";
> >                         reg = <0x01e80000 0x30000>;
> > --
> > 2.19.1
> >
