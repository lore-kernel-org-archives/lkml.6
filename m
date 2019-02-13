Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CE7C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713BC222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQOt+KVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389537AbfBMNN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:13:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36600 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733220AbfBMNN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:13:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so1968646ljk.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zBVGPIl77A6T4nt2AQmWlHxw7DBCxUKBUmxAuHFPJ2Q=;
        b=ZQOt+KVHXL7+bO+WoguF6Ew5btUUrd/SiI/m8k081Om8LOIRrRy1dIEWU9/kLMWI0+
         jwCHkZprC9xit2q004nBZ2gDdViLfJMMHB1M4/KMx8AM4jdzNBaRaJweaER413UxfSre
         P7uOpDVNgoKJNSI60x3EDN0qCt2FTDwermkEIH8TKpdKmbO92y5SAAz3gW9JMa74DpGS
         hFBQDlO9LKrxow14rGbTbKzy1JezlURlTjvmzUqEgc2WuCHYF0Q02l8kHO2bYe3dO1Tm
         sZmh3IIDVoagaeC++j32TafIskhM0gH4JpK0cjaycHPpyUKSCXiIM0Wsh7XvdqC9kYDb
         crIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zBVGPIl77A6T4nt2AQmWlHxw7DBCxUKBUmxAuHFPJ2Q=;
        b=qdY+G6jRuuB8G/iDeJhRDcXHn+7XMUiWR3HmpAohu/Rr1njv+jw/+ei+MblENfsdVZ
         f1z6Ihpk9iXInZUeEZcDKpINKdup3QAYhrgSv3WDb2AZRE+vaEQ8faXeZTmh7dlXm+bD
         7AW7A7XOrFtKtTgh72Gu9OfXJpZvkN5nZMrIFCkmy2EgrLf33CVpSvgZBJClPOnmdEtE
         eIegTSnP0pkzrfdUBEyHNew14IXdN1GHaY3N/WPmXbdKQ/c4bwIsg/DlBYO5A4YEaYxx
         Pu7xG74U8Igj0eXHsWFeWXSRBpeFPcQaWBXAJEGw+4SUXwncRpllyS3Y2TqCttqnvjAs
         py7g==
X-Gm-Message-State: AHQUAuaZqLZ1QqeTG7n0HoKwv+ziZ9Zd04tJvoNlDZ0FokPpw9X8SekB
        O1jIu2aQEwcnpsYFAI3clzmL0bqjIhzYcLKnzz9kNA==
X-Google-Smtp-Source: AHgI3IaDOicHkL37jQX3Dh0LiTQmnm+iyPoaKhBsj+Pj+x/A+KB0ckfOss5/0yPnIx1G2fX/Yzn2iCOHZ1ZRXasxNr4=
X-Received: by 2002:a2e:9d83:: with SMTP id c3-v6mr285394ljj.9.1550063606715;
 Wed, 13 Feb 2019 05:13:26 -0800 (PST)
MIME-Version: 1.0
References: <b8101fd6d303c1993ee294eeee8bce4d24b9547f.1550061925.git.baolin.wang@linaro.org>
 <CAMpxmJX7WdtbN=w8D=ZPwAFsamoTm89KeC42ag_LoSoJBFjiRg@mail.gmail.com>
In-Reply-To: <CAMpxmJX7WdtbN=w8D=ZPwAFsamoTm89KeC42ag_LoSoJBFjiRg@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 13 Feb 2019 21:13:15 +0800
Message-ID: <CAMz4kuKz1d6HpPWyB_aanAvzsiqR6UkGK5ysYjdG7B5=vYRYUQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: gpio: Use SoC compatible string instead
 of wildcard string
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 at 20:57, Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
>
> =C5=9Br., 13 lut 2019 o 13:49 Baolin Wang <baolin.wang@linaro.org> napisa=
=C5=82(a):
> >
> > Use SoC compatible string instead of wildcard string.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  .../devicetree/bindings/gpio/gpio-eic-sprd.txt     |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt b=
/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
> > index 93d98d0..54040a2 100644
> > --- a/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
> > +++ b/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
> > @@ -33,7 +33,7 @@ Required properties:
> >    "sprd,sc9860-eic-latch",
> >    "sprd,sc9860-eic-async",
> >    "sprd,sc9860-eic-sync",
> > -  "sprd,sc27xx-eic".
> > +  "sprd,sc2731-eic".
> >  - reg: Define the base and range of the I/O address space containing
> >    the GPIO controller registers.
> >  - gpio-controller: Marks the device node as a GPIO controller.
> > @@ -86,7 +86,7 @@ Example:
> >         };
> >
> >         pmic_eic: gpio@300 {
> > -               compatible =3D "sprd,sc27xx-eic";
> > +               compatible =3D "sprd,sc2731-eic";
> >                 reg =3D <0x300>;
> >                 interrupt-parent =3D <&sc2731_pmic>;
> >                 interrupts =3D <5 IRQ_TYPE_LEVEL_HIGH>;
> > --
> > 1.7.9.5
> >
>
> Hi,
>
> please indicate the module this concerns in the subject line.
> Something like: "dt-bindings: gpio: sprd: ..."

Sure. Thanks.

--=20
Baolin Wang
Best Regards
