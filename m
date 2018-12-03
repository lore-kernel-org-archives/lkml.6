Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9777C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B40B20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eritikvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B40B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeLCRVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:21:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:47240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbeLCRVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:21:46 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F4172145D;
        Mon,  3 Dec 2018 17:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543857702;
        bh=X2qZ6GwYNv4eMDTPMV9pGs6q3gtKZ2GyEOUTmTFUdV8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EritikvdcDwV9trSJfXmbUUvVuOgvKK5qseCpNVsy9to3BwvGPI74QFaSjIWhc8ih
         3zEp8NJU9IgNYTznalf4TosXFE008ov6c9M72AHkLV4buIf9HpehxBMswV8IVu9Rs+
         E9WfO5Ht99saleVn58rxn/lUoLODkMFwo34VKfx8=
Received: by mail-qt1-f171.google.com with SMTP id i7so14635470qtj.10;
        Mon, 03 Dec 2018 09:21:42 -0800 (PST)
X-Gm-Message-State: AA+aEWY6CnICpX+nb6Pwjpb1puWBs1qRQaTvgpjtGfJ1mu4ezwAyDwFA
        ITlLp+2SCDLV8fzxtkhMhpYRxt7FWZNMwXfopg==
X-Google-Smtp-Source: AFSGD/WlvvOwuJswDIQCvhO/1MzKZzl4YBK4cAgaWDxIMek2YNT/JUKXLWljCdM7S7BtjEXAGT568LVpUoTItv1KRZg=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr16474996qts.144.1543857701208;
 Mon, 03 Dec 2018 09:21:41 -0800 (PST)
MIME-Version: 1.0
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
 <20181121033652.12247-7-manivannan.sadhasivam@linaro.org> <CAL_JsqJ=88ORdgbRDn+VWk9=ydShidqwOxdAMfDbH4W2drnXzA@mail.gmail.com>
 <CAOesGMgSxwcmBLDvxsvcCJ9-NvJ3-wK8fZBZV2ZNuzAa1idi3w@mail.gmail.com>
In-Reply-To: <CAOesGMgSxwcmBLDvxsvcCJ9-NvJ3-wK8fZBZV2ZNuzAa1idi3w@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 3 Dec 2018 11:21:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLZY_5rZ35YSGeH7wmEZoLP1TjG+0n4BWGiUBwOFSq-Vw@mail.gmail.com>
Message-ID: <CAL_JsqLZY_5rZ35YSGeH7wmEZoLP1TjG+0n4BWGiUBwOFSq-Vw@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] arm: dts: Add devicetree for OrangePi 2G IoT board
To:     Olof Johansson <olof@lixom.net>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, zhao_steven@263.net,
        overseas.sales@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 11:11 AM Olof Johansson <olof@lixom.net> wrote:
>
> On Mon, Dec 3, 2018 at 7:54 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Tue, Nov 20, 2018 at 9:38 PM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > Add initial devicetree support for OrangePi 2G IoT board from Xunlong=
.
> > >
> > > Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.or=
g>
> > > ---
> > >  arch/arm/boot/dts/Makefile                    |  2 +
> > >  .../boot/dts/rda8810pl-orangepi-2g-iot.dts    | 40 +++++++++++++++++=
++
> > >  2 files changed, 42 insertions(+)
> > >  create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
> > >
> > > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > > index b0e966d625b9..a0fdad8f10dd 100644
> > > --- a/arch/arm/boot/dts/Makefile
> > > +++ b/arch/arm/boot/dts/Makefile
> > > @@ -806,6 +806,8 @@ dtb-$(CONFIG_ARCH_QCOM) +=3D \
> > >         qcom-msm8974-sony-xperia-castor.dtb \
> > >         qcom-msm8974-sony-xperia-honami.dtb \
> > >         qcom-mdm9615-wp8548-mangoh-green.dtb
> > > +dtb-$(CONFIG_ARCH_RDA) +=3D \
> > > +       rda8810pl-orangepi-2g-iot.dtb
> > >  dtb-$(CONFIG_ARCH_REALVIEW) +=3D \
> >
> > Question for Arnd/Olof: can we *please* start putting new SoC families
> > in sub-dirs?
>
> I think we're at a point where it's becoming quite awkward to keep it
> in a flat directory, yes.
>
> Best way to handle this is usually right before the closing of a merge
> window, so let's do it then. It'll be a conflict-ridden mess if we try
> to stage something in -next, so I'd rather just do it directly in our
> tree as a one-shot thing.

While I'd like to see the whole thing converted, I was only asking
about this one platform. That should be doable now, right?

Rob
