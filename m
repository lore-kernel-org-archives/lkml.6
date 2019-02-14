Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C17C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BF02229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DibK3K1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391542AbfBNOHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:07:14 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55180 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbfBNOHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:07:13 -0500
Received: by mail-it1-f194.google.com with SMTP id z9so13369309itc.4;
        Thu, 14 Feb 2019 06:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SDweC0/rM/7wIRwhhNBqenxhLevIilMXlbaDUD5AX3E=;
        b=DibK3K1IFnn644i1VQI7ocdSTjWbrqbJqhhpBYf87UCghvxQJvSL/QRz0l6XsbRfai
         tL3xomjENcO1ZP1Ujhz4yHkjJBEWzWlgXEsV31SkMIQ8/SxVPr5kmInv58sf/ufGHTDY
         DjMV1YQxjdIXCbNZrlt21mGX8aOTnLrcZ3QDO/PWdT6wPtZPKYilMNrPzviXWg96/hvp
         IJBG/INd91/Q21fe71wu+bz29cISE8QP1IsgQ6/BUcO+7oFXyAZjny7dL09/ZvFxciEq
         MBPU7GmEaRrMJLcGypHEhk6/iON/zLWpmxSgKP0PX5EWF3434mGTOQdaXjAjitvLYdjC
         GRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDweC0/rM/7wIRwhhNBqenxhLevIilMXlbaDUD5AX3E=;
        b=tv4/C/KZrstA9GDJvHfGXLONQM6OZuiyXt4GU6X1FV2TuquRZHE4Px6ynXMvqHZXyg
         2mJOFpSeWEcUQiIK+uPAQZwzBjVVchfgC2uNA2BauIGb1+DFcszoiiBpY/0E6eZHYs4u
         wbqPz7LeKwcVDuqdA4dTxRx/526RKiSOgjPUEvBbamA3aY2Jrrkbx22640H5kxQWlAFb
         LTjjn6w54NkAco6iw3JTUGyEfIEiBA5tWnR/5kfzpaBgqBKtFnMzsa/qkuq717UiiRdJ
         iLojpJmN0VdOPrm2tujVM5yb2gD2hoU2VHRFENoCADfWdo0MSZBr3tXJDEdfnYnIu6nu
         6afw==
X-Gm-Message-State: AHQUAuYV0aHgg5gMCsMVtC1Y8Ax0FQuNlzsZcKlii5/s+ArYcjNCepeo
        dHV+WiuXrjvYwmEc/ViVh4hFu8tqMlDrdvEJo1w=
X-Google-Smtp-Source: AHgI3IY482eIDUsLvvnmnYjMDQ6H105S0ndyX92l+wfORvgTXxOMNkbjXleDkW0FOaETGIoSce0V0/r6K2WP8z1eTFM=
X-Received: by 2002:a02:b885:: with SMTP id p5mr2157236jam.60.1550153232531;
 Thu, 14 Feb 2019 06:07:12 -0800 (PST)
MIME-Version: 1.0
References: <20190214130910.9201-1-tiny.windzz@gmail.com> <20190214130910.9201-2-tiny.windzz@gmail.com>
 <20190214134617.b44pa7onf3brmhhj@flea>
In-Reply-To: <20190214134617.b44pa7onf3brmhhj@flea>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 14 Feb 2019 22:07:02 +0800
Message-ID: <CAEExFWvG4Vz2KsDnHJ6BL72nD6x=Lp+Hzj+q7LfggzFtzrgRow@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: allwinner: h6: orangepi: Add CPU supply regulator
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, robh+dt@kernel.org,
        mark.rutland@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 9:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi!
>
> Thanks for your patches
>
> On Thu, Feb 14, 2019 at 08:09:07AM -0500, Yangtao Li wrote:
> > The original orangepi use the dcdca to supply the CPU cores. According
> > to the axp805 spec, the range of dcdca is 0.6 to 1.1v, 1.12 to 1.52v.
> > In order to support more CPU frequency, slightly increase the voltage
> > maximum and minimum.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > index b2526dac2fcf..e7aebaf91ede 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > @@ -159,8 +159,8 @@
> >
> >                       reg_dcdca: dcdca {
> >                               regulator-always-on;
> > -                             regulator-min-microvolt = <810000>;
> > -                             regulator-max-microvolt = <1080000>;
> > +                             regulator-min-microvolt = <800000>;
> > +                             regulator-max-microvolt = <1160000>;
>
> This violates the minimum and maximum recommended voltages in the H6
> datasheet. Could you clarify why you are doing so (ideally in the
> commit log)?
In fact, in sunxi's sdk, the actual minimum and maximum voltage of the
cpu is smaller or larger than the datasheet.

For some better quality ic, the minimum voltage can be smaller.
For some poor quality ic, the maximum voltage needs to be increased a little.

MBR,
Yangtao
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
