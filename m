Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBAAC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0859C21904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="d4q2FbZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392640AbfBMQTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:19:43 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36157 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbfBMQTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:19:43 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so5163752otk.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 08:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uQn0e18MAiop804coB+aUVWsY7wEtvXCPcsxsNvGqEM=;
        b=d4q2FbZquwOPD6u4Hh+IcVWY5AprhbhxpH8avllH4tx1t3NQ4WIaW98OgYUU6d1Md5
         uCIsLbEOmPbpRVjvSxSEjtuaKxPTLyfSDlaIFM6v/3YmBdvu2/uMYJLs74NZwahnG6Wi
         xY5jCLOPZs2as4NSIWypLVh9UXXbFVGHRBa61wnyUvJZJKSAnYHe4OEUZ7MTCsYlKa5L
         q3EuTvCGgeF/6YAp73kMmnXAIenExEIC5M/SRjKum/CF2TfhgS0AjkN0hmZ36YHb4S1/
         zi/pZSjQzbyARnXVw5SyUEjjKQXGySMRFBAifz4smOzA6m+2N6SZ7fbANiVeFAJOwLs4
         vh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uQn0e18MAiop804coB+aUVWsY7wEtvXCPcsxsNvGqEM=;
        b=k6j0V1s651Ek6GZVgR6oYj71dZ5X81twG3yvSHRBkscldJ317cF9tXKehoYz+gTBsY
         QNgJSB73dcwivD0VZmRYvLYeFXiH4PXvS8Hi/cd60YOhKA9BolPQcvI8Qq/CxsmY453u
         uSdkPKbPD4BLJ6JO6376ywNBwVztP046Q8Zfhb2Vt+EcYvZYDYGmbWHeP65pn3ZLTBR8
         NDM6It7EpgUVRioa+Q1tdwOWf2Yb7iVMOoxTNB2OVrDYwj+KOSMhgGJAoawHkpSWG4j1
         9vzqtvrzHjBvEI8kIe+tey10fFQHx7AXO0T1IFWzvTMLDwCJj+E1HZ+z4W+kt9MYttb8
         47QQ==
X-Gm-Message-State: AHQUAuYFY0wFNLppt9bH1bZPMXIF5vkA7QWNWQq/lhMQHbRePEVVOO/E
        VnAigB+WvFTm2Oyp2fEcyIxmf+h9BLrjt6G0/tfKPw==
X-Google-Smtp-Source: AHgI3IbD9biGMUhEJz/SijA2fzCuMSA1oJwsEIfiiJDOPnrAZ5zLqKPSJGVK+94FsKDbmumvYW6n0giayhZ2tsW/Jwk=
X-Received: by 2002:a05:6830:1658:: with SMTP id h24mr681810otr.301.1550074221979;
 Wed, 13 Feb 2019 08:10:21 -0800 (PST)
MIME-Version: 1.0
References: <b8101fd6d303c1993ee294eeee8bce4d24b9547f.1550061925.git.baolin.wang@linaro.org>
 <0438b78c7f9f9bc3f0e7bcbcef3873fd2dd7e259.1550061925.git.baolin.wang@linaro.org>
 <CAMpxmJWuMWBSPjoJWkfagAAopYjohA0rhxUacNPXhhiTFZJorA@mail.gmail.com> <CAMz4kuJRvYo699J5SiG9mhjy5pt1hke8yXwoj9KfmZBTKkkKzw@mail.gmail.com>
In-Reply-To: <CAMz4kuJRvYo699J5SiG9mhjy5pt1hke8yXwoj9KfmZBTKkkKzw@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 13 Feb 2019 17:10:11 +0100
Message-ID: <CAMpxmJXbuOuMvxe+bXqjaCrVU5WXxQ=fZTU9iA8Opnqrx25eMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: sprd: Change to use SoC compatible string
To:     Baolin Wang <baolin.wang@linaro.org>
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

=C5=9Br., 13 lut 2019 o 14:15 Baolin Wang <baolin.wang@linaro.org> napisa=
=C5=82(a):
>
> On Wed, 13 Feb 2019 at 20:59, Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
> >
> > =C5=9Br., 13 lut 2019 o 13:49 Baolin Wang <baolin.wang@linaro.org> napi=
sa=C5=82(a):
> > >
> > > Change to use SoC compatible string instead of wildcard string.
> > >
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > ---
> > >  drivers/gpio/gpio-pmic-eic-sprd.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pm=
ic-eic-sprd.c
> > > index ac573da..24228cf 100644
> > > --- a/drivers/gpio/gpio-pmic-eic-sprd.c
> > > +++ b/drivers/gpio/gpio-pmic-eic-sprd.c
> > > @@ -364,7 +364,7 @@ static int sprd_pmic_eic_probe(struct platform_de=
vice *pdev)
> > >  }
> > >
> > >  static const struct of_device_id sprd_pmic_eic_of_match[] =3D {
> > > -       { .compatible =3D "sprd,sc27xx-eic", },
> > > +       { .compatible =3D "sprd,sc2731-eic", },
> > >         { /* end of list */ }
> > >  };
> > >  MODULE_DEVICE_TABLE(of, sprd_pmic_eic_of_match);
> > > --
> > > 1.7.9.5
> > >
> >
> > We guarantee to make older device-trees to work with new kernel so you
> > can add the new compatible, but you can't remove the old one.
>
> But the old one is incorrect, and we still keep it?
>

Well in theory the device-tree is supposed to be a stable ABI so once
it's released, it should work with any following kernel version.

In practice changes are sometimes allowed and there are also bugs in DT fil=
es.

Linus: what do you think?

Bart
