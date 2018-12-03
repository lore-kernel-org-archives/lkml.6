Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804C7C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C72A2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="MHjzkQ5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C72A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeLCRxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:53:16 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36838 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbeLCRxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:53:16 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so9933957itj.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jrZm1EVRc3lEWmoL1Qrzl/u0xfvJ16xasMcx5rZfWPM=;
        b=MHjzkQ5D55rQRC09jOgOH9wq3Rk8bQbipn5cgUcx8cJ2yq/xkBw6vmZ4xp9wVcrYXH
         LsOTTGFCmVLohXxqhbWUEE8ABkEMr2Kt+MklKzDjtf6svGiVDoQMzrJ8YbAr2WfpJUFa
         TaljyRsAWVWbpXiRRY7aj1xRG0BRLCKfbOz7yluoANdSIJ9z8L3FDaJ25unZYv9jfk/g
         nX951/4yFCd8XqjUsxHXA05AG85dxUhRNTl3viQtVepsk+lx4ph4UV5ianzUTj0O0sDl
         bSCfyWM11/7T/mavxDwIc6sNxyJ/bGQMtO5SWu956TQFsNEH4MoA33xisPFyrP+oxLYy
         rB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jrZm1EVRc3lEWmoL1Qrzl/u0xfvJ16xasMcx5rZfWPM=;
        b=uTeSDsXsXIARr68cy0WJkyNMHVuSDY6jzGt7c5+kI+s+SsefYcZgsD3qPpJTOOQkZC
         zvmYMFZUMRlRKwbAbjHkm2CoZ9JJ86DMM6mXX5q+Riofq6RqfPnQ2wtVddo1ms+53SyR
         WY83L6/+Ca/Vs0EeGRlyUZj4Vn3IVJYFhAfKkKFc2c3PmEwZZMvpQYm70sjxFNP66ltW
         Cg8QjkrTNKOIgdeOJL/umWBy+oYPPYsFtuwzmb6xjl9Xlr4icB/z2Q0eGQR4Ccv30Xg6
         +kPJgDe9ldBD322tRPhTRz/QRfcaUIxczXCyAmqvmGYzTkyw2PrhTlVfbiM4a4sFNG7y
         avag==
X-Gm-Message-State: AA+aEWa1gs4MK9qZCrqJexJCNfOT2+TzrlcOXUQIcCOGJTdTE9rO78E4
        U1Yr+mPH76wkKSf447/HRihUEzvdoxLVY2GNVcBGoA==
X-Google-Smtp-Source: AFSGD/U3dYAM8cLPdIisk0V1q1bwKif+eSHDkiHenUVaNNbJIsqarq0U51ofWMatd8hPL+qciP6UMdEiKInK5xMqsWI=
X-Received: by 2002:a24:ce42:: with SMTP id v63mr8519661itg.136.1543859591740;
 Mon, 03 Dec 2018 09:53:11 -0800 (PST)
MIME-Version: 1.0
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
 <20181121033652.12247-7-manivannan.sadhasivam@linaro.org> <CAL_JsqJ=88ORdgbRDn+VWk9=ydShidqwOxdAMfDbH4W2drnXzA@mail.gmail.com>
 <CAOesGMgSxwcmBLDvxsvcCJ9-NvJ3-wK8fZBZV2ZNuzAa1idi3w@mail.gmail.com> <CAL_JsqLZY_5rZ35YSGeH7wmEZoLP1TjG+0n4BWGiUBwOFSq-Vw@mail.gmail.com>
In-Reply-To: <CAL_JsqLZY_5rZ35YSGeH7wmEZoLP1TjG+0n4BWGiUBwOFSq-Vw@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 3 Dec 2018 09:53:00 -0800
Message-ID: <CAOesGMi=qFB0jTTAzTYxBduYf_7RVwOZkKNjckpqg6tbd3sPow@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] arm: dts: Add devicetree for OrangePi 2G IoT board
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org,
        Amit Kucheria <amit.kucheria@linaro.org>,
        LinusW <linus.walleij@linaro.org>, zhao_steven@263.net,
        overseas.sales@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 9:21 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Dec 3, 2018 at 11:11 AM Olof Johansson <olof@lixom.net> wrote:
> >
> > On Mon, Dec 3, 2018 at 7:54 AM Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Tue, Nov 20, 2018 at 9:38 PM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > Add initial devicetree support for OrangePi 2G IoT board from Xunlo=
ng.
> > > >
> > > > Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.=
org>
> > > > ---
> > > >  arch/arm/boot/dts/Makefile                    |  2 +
> > > >  .../boot/dts/rda8810pl-orangepi-2g-iot.dts    | 40 +++++++++++++++=
++++
> > > >  2 files changed, 42 insertions(+)
> > > >  create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
> > > >
> > > > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefil=
e
> > > > index b0e966d625b9..a0fdad8f10dd 100644
> > > > --- a/arch/arm/boot/dts/Makefile
> > > > +++ b/arch/arm/boot/dts/Makefile
> > > > @@ -806,6 +806,8 @@ dtb-$(CONFIG_ARCH_QCOM) +=3D \
> > > >         qcom-msm8974-sony-xperia-castor.dtb \
> > > >         qcom-msm8974-sony-xperia-honami.dtb \
> > > >         qcom-mdm9615-wp8548-mangoh-green.dtb
> > > > +dtb-$(CONFIG_ARCH_RDA) +=3D \
> > > > +       rda8810pl-orangepi-2g-iot.dtb
> > > >  dtb-$(CONFIG_ARCH_REALVIEW) +=3D \
> > >
> > > Question for Arnd/Olof: can we *please* start putting new SoC familie=
s
> > > in sub-dirs?
> >
> > I think we're at a point where it's becoming quite awkward to keep it
> > in a flat directory, yes.
> >
> > Best way to handle this is usually right before the closing of a merge
> > window, so let's do it then. It'll be a conflict-ridden mess if we try
> > to stage something in -next, so I'd rather just do it directly in our
> > tree as a one-shot thing.
>
> While I'd like to see the whole thing converted, I was only asking
> about this one platform. That should be doable now, right?

I'd rather apply this to current scheme and then move everything once,
instead of having maintainers go "Oh, I guess I need to move mine" and
we end up with an onslaught of conflicting pull requests to move
things apart.


-Olof
