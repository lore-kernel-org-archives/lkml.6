Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CE8C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115142087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="UDdBo4QE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115142087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbeLCRLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:11:20 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53575 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbeLCRLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:11:19 -0500
Received: by mail-it1-f193.google.com with SMTP id g85so10450843ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jZwHL+KrX7TIdnyTLQq0LYgZtjFjZYEP2+6PVqizCAc=;
        b=UDdBo4QEvg4n5FgfTMd+S4wJ/fav7viUpLtZns6RHd16/RRIWwxW0ZxVrNLElepXCx
         xLni/K+julKub2yzycDFRbjlSfNyPSkqILNYUr7ekYopSUfVnnns1iQm9/kdqQ43N3J4
         qJWbryRksRVuuLn7L94PD09YtM5LZd82uGHRUS7TA+i34NrYz6IyjlgXCLtpPyn4RVS+
         u75cULYljUy63l1INcTTjutxVJQJsYnpCzE4CxqOCVYkn0ALBkDTpntefu+9yPuZIlJ4
         bwxUrsoXR4zLtHHjvVadC7ZtSjCLDYGN3qItETaVFIMS3ykJaRR7FER4hptInOmslJcO
         6peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jZwHL+KrX7TIdnyTLQq0LYgZtjFjZYEP2+6PVqizCAc=;
        b=g5qLZBHGYCvdVx8Miz8CTHI+V6yUTeJEtTLsZsLh8hXkacDEvvt2Qywd/Exm62lJAL
         FqEx9+lYHMA877Xpl4ouf5fkrsS+rsBoHikiPmSleGn5Y3fGC355gq4h8ktrGD/1KIm2
         GjspUswLLIxXMn6YZ1u4CbHckjLLFu//0p2pEyrfTghjlOYDHnzu8BcCVYs/p/4jbb/I
         IlDmZaqt0O+f/RUR2M8iR1k+gVbFhli0QRP1Q08ToAi25xnvILZ9O7m80m362ygN6uw3
         NpsCB61ZX3bsrdkvmb85Rq6ZRPwlX7PoVqlxx1LqT2ruv2gWusgb8TRYX4wePv1xeiCP
         N8yg==
X-Gm-Message-State: AA+aEWYNnbOIAPNFwok0goZfnm6L3p7ow6553QUV+SDVN39LCodfKX/m
        NZ0GUsBNV7tcFmPb6L/PA0o/nyQihqQYXHNfCyG2IA==
X-Google-Smtp-Source: AFSGD/WWJlUM2Jfyl1jhFGTE9tmWu7X5SRFwCf/5eQ1tF2y0c6odiUtr1QqJ6xjOzrmCr3nS079A4Wmo96qOZpUEH4w=
X-Received: by 2002:a24:6e88:: with SMTP id w130mr8198378itc.103.1543857077051;
 Mon, 03 Dec 2018 09:11:17 -0800 (PST)
MIME-Version: 1.0
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
 <20181121033652.12247-7-manivannan.sadhasivam@linaro.org> <CAL_JsqJ=88ORdgbRDn+VWk9=ydShidqwOxdAMfDbH4W2drnXzA@mail.gmail.com>
In-Reply-To: <CAL_JsqJ=88ORdgbRDn+VWk9=ydShidqwOxdAMfDbH4W2drnXzA@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 3 Dec 2018 09:11:05 -0800
Message-ID: <CAOesGMgSxwcmBLDvxsvcCJ9-NvJ3-wK8fZBZV2ZNuzAa1idi3w@mail.gmail.com>
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

On Mon, Dec 3, 2018 at 7:54 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Nov 20, 2018 at 9:38 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > Add initial devicetree support for OrangePi 2G IoT board from Xunlong.
> >
> > Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm/boot/dts/Makefile                    |  2 +
> >  .../boot/dts/rda8810pl-orangepi-2g-iot.dts    | 40 +++++++++++++++++++
> >  2 files changed, 42 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
> >
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index b0e966d625b9..a0fdad8f10dd 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -806,6 +806,8 @@ dtb-$(CONFIG_ARCH_QCOM) +=3D \
> >         qcom-msm8974-sony-xperia-castor.dtb \
> >         qcom-msm8974-sony-xperia-honami.dtb \
> >         qcom-mdm9615-wp8548-mangoh-green.dtb
> > +dtb-$(CONFIG_ARCH_RDA) +=3D \
> > +       rda8810pl-orangepi-2g-iot.dtb
> >  dtb-$(CONFIG_ARCH_REALVIEW) +=3D \
>
> Question for Arnd/Olof: can we *please* start putting new SoC families
> in sub-dirs?

I think we're at a point where it's becoming quite awkward to keep it
in a flat directory, yes.

Best way to handle this is usually right before the closing of a merge
window, so let's do it then. It'll be a conflict-ridden mess if we try
to stage something in -next, so I'd rather just do it directly in our
tree as a one-shot thing.


-Olof
