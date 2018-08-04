Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5EFC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 06:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0072178F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 06:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeiVvcjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0072178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeHDIyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 04:54:33 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34336 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeHDIyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 04:54:33 -0400
Received: by mail-lj1-f194.google.com with SMTP id f8-v6so6660642ljk.1;
        Fri, 03 Aug 2018 23:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vrq22GFCBJFshSyPMo4bl73SPPyYDMf1fgheMhuLhmg=;
        b=HeiVvcjpd6j3JUErm0YqhGD1Q1yaVN7Ioi5+GyMwVioRVYXsEyZorUuLDhIfqZ/cDr
         /yd5vHkhThK1jKoh19ADlKMvccsgo0e2KLWg5Qz59yZpEJ4vTQtWSXFEracMmeJmKq+l
         MtoC3DZcUcZmvGRKVaUyNeLCG9Vu5C0HPoUJx3mDyX/KvJYzRPcYNhq6s/G9tGgbgsBz
         9vJ3yiu0Zez8FitTnZR8EUf+AQuq3KZ4VyEetFagO9h5XAS7fkr/DkTXY5fnNeKcPzPK
         pfmjPbsXXIlxfa+YrqjOO8VmBSiERFnJmSwscV8qeTaNCPECMwHoJ+dMJEyXrZsZvm6c
         S72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vrq22GFCBJFshSyPMo4bl73SPPyYDMf1fgheMhuLhmg=;
        b=MC4gjXzFjynMxduegdn7f2L2LwHorNucd4kOERsJu7prFXj9uHh3KlnF4StNm8LDxk
         /UtJXUk3wvzwMNPP8Ex16EQInTydbZ2PYtM6Mt08h9WNa61wmrDI+JN7tPtzFSzfWqbn
         8+FCgCJSpBdBgz16vFHQ+durKnLez/jyQFoOakcOkwLHOR3zG+N/WM7r/0uLBZXwbbEm
         GvEmV/19VedB4fCVWzFA6HtVHHJIUp7HQNAFRupWoo001mQUAa/JgPOGFf7z5VyXg/Ih
         /xPG7rMw0zpKFiaGPi+A0x892beBXvojIap6Xf3Scyux+qI0OpekYtKGeURrIvZjE46+
         w9lw==
X-Gm-Message-State: AOUpUlGe8TEQ5hEgHzS1n6NMsGvaeUjUMTjIYE6mGvlzQpX+W+v57U+t
        QabD/SvkRle/xJHEPCTwcFQ=
X-Google-Smtp-Source: AAOMgpfcBKKzhg1EKqeqbb1zK6yPVA4GW/Og8o5+srgQRxwnHBe0CGcZAVXJjjpO2MQ8gEZh/mL/XQ==
X-Received: by 2002:a2e:3005:: with SMTP id w5-v6mr7118016ljw.20.1533365694352;
        Fri, 03 Aug 2018 23:54:54 -0700 (PDT)
Received: from gmail.com (c-2ec26f15-74736162.cust.telenor.se. [46.194.111.21])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1210435ljx.2.2018.08.03.23.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 23:54:52 -0700 (PDT)
Date:   Sat, 4 Aug 2018 08:55:06 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] iio: adc: add support for mcp3911
Message-ID: <20180804065506.GB1727@gmail.com>
References: <20180802191554.20176-1-marcus.folkesson@gmail.com>
 <CAHp75Vf8kMLsoFN_EK150yW_FvH8XfgjiETYAtvW63et5NNurw@mail.gmail.com>
 <20180803230922.22d628fc@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline
In-Reply-To: <20180803230922.22d628fc@archlinux>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy and Jonathan,


On Fri, Aug 03, 2018 at 11:09:22PM +0100, Jonathan Cameron wrote:
> On Thu, 2 Aug 2018 22:52:00 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>=20
> > On Thu, Aug 2, 2018 at 10:15 PM, Marcus Folkesson
> > <marcus.folkesson@gmail.com> wrote:
> > > MCP3911 is a dual channel Analog Front End (AFE) containing two
> > > synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).
> > >
> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com> =20
> >=20
> > > Signed-off-by: Kent Gustavsson <kent@minoris.se> =20
> >=20
> > What is this? Why it's here (presense and location in the message)?
> To clarify... If Kent wrote the patch and you are simply acting
> as gatekeeper / upstreamer you should set the mail to be from Kent
> and put your own Signed-off after his to basically act as a submaintainer
> certifying you believe his sign off and all that entails.
>=20
> If it is a bit of a joint effort then that's fine but for copyright
> purposes there should be some indication of the split.

First, thank you Andy for noticing.

I actually intended to use Co-Developed-by (a pretty new tag)
in combination with Signed-off-by.
But the tag must have disappeared in some preparation stage..

=46rom Documentation/process/submitting-patches.rst ::

	A Co-Developed-by: states that the patch was also created by another devel=
oper
	along with the original author.  This is useful at times when multiple peo=
ple
	work on a single patch.  Note, this person also needs to have a Signed-off=
-by:
	line in the patch as well.

I will switch order and add the Co-Developed-by-tag.
Is this correct?

Co-Developed-by: Kent Gustavsson <kent@minoris.se>  =20
Signed-off-by: Kent Gustavsson <kent@minoris.se> =20
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com> =20

>=20
>=20
> >=20
> > > + * Copyright (C) 2018 Kent Gustavsson <kent@minoris.se> =20
> >=20
> > > + * =20
> >=20
> > Redundant.
> >=20
> > > +static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 le=
n)
> > > +{
> > > +       int ret;
> > > +
> > > +       reg =3D MCP3911_REG_READ(reg, adc->dev_addr);
> > > +       ret =3D spi_write_then_read(adc->spi, &reg, 1, val, len);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > > +       be32_to_cpus(val);
> > > +       *val >>=3D ((4 - len) * 8);
> > > +       dev_dbg(&adc->spi->dev, "reading 0x%x from register 0x%x\n", =
*val,
> > > +                       reg>>1);
> > > +       return ret;
> > > +}
> > > +
> > > +static int mcp3911_write(struct mcp3911 *adc, u8 reg, u32 val, u8 le=
n)
> > > +{
> > > +       dev_dbg(&adc->spi->dev, "writing 0x%x to register 0x%x\n", va=
l, reg);
> > > +
> > > +       val <<=3D (3 - len) * 8;
> > > +       cpu_to_be32s(&val);
> > > +       val |=3D MCP3911_REG_WRITE(reg, adc->dev_addr);
> > > +
> > > +       return spi_write(adc->spi, &val, len + 1);
> > > +} =20
> >=20
> > Can't you use REGMAP_SPI ?
> My instinct is not really. The magic device-addr doesn't help.
> You could work around it but it's not that nice and you'd have
> to create the regmap mapping on the fly or carry static ones
> for each value of htat.
>=20
>=20
>=20
> >=20
> > > +       of_property_read_u32(of_node, "device-addr", &adc->dev_addr);
> > > +       if (adc->dev_addr > 3) {
> > > +               dev_err(&adc->spi->dev,
> > > +                               "invalid device address (%i). Must be=
 in range 0-3.\n",
> > > +                               adc->dev_addr);
> > > +               return -EINVAL;
> > > +       }
> > > +       dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_a=
ddr); =20
> >=20
> > Isn't what we called CS (chip select)?
> Nope. We went around this in an earlier revision. It's an address transmi=
tted
> in the control byte to allow you to 'share' a chip select line between mu=
ltiple
> chips (crazy but true).
>=20
> >=20
> > > +       if (IS_ERR(adc->vref)) { =20
> >=20
> > > + =20
> >=20
> > Redundant.
> >=20
> > > +       if (adc->clki) =20
> >=20
> > Seems to be redundant if clock is optional (it should be NULL and API
> > is NULL-aware).
> >=20
> > > +               clk_disable_unprepare(adc->clki); =20
> >=20
> > > +       if (adc->clki)
> > > +               clk_disable_unprepare(adc->clki); =20
> >=20
> > Ditto.
> >=20
> > > +#if defined(CONFIG_OF) =20
> >=20
> > This prevents playing with the device on ACPI enabled platforms.

I will remove the defined(CONFIG_OF) and not use the of_match_ptr()
macro.=20

> Yeah, that trickery is still little known (and I forget about it from
> time to time).
>=20
> The upshot for those who have missed this is you can use a magic
> acpi device to instantiate based on device tree bindings :)
>=20
> So we need to strip all this 'obvious' protection stuff out of drivers.

Jonathan,
Do you want me to do the same changes for drivers in iio/ ?
I'm probably not the only one looking at other drivers when writing my
own, so I guess this is a rather frequent issue for new drivers?


>=20
> >=20
> > > +               .of_match_table =3D of_match_ptr(mcp3911_dt_ids), =20
> >=20
> > Ditto for macro.
> >=20
>=20

Best regards,
Marcus Folkesson

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAltlTcQACgkQiIBOb1ld
UjKPFw/+NeiGz6rfi628o/DAMpQDQbDHkK/2DmBcJIPpZv1oRuPFbrTFx6ju30/v
dfed1gAcphELG90jVf6nUI7VFie0xUyA9dpZL1orhuS4hl0djUJY+PAztAsckM1a
U6xVGtd7r2zA1uY7Ggf89Gb1VWEpcKQX7HbnI/x41jA7CZExkky43MK6GcdVhOzS
LboSdr+KkEOxq1SvtYkhWST/WOHTmUfL5nobnR0qxhaJpeIskamhtmC4ek8+11kP
N4fjFUIexXxAWnxXkm0hGCxmET5rfl5/+kSaVOprNQ+wm6AmMiUiLY6ujPh0z68L
8tZWMS1XzPUrRd4asb2G3uwCAgKDKVHgwTb3j3l4O5bTXPcHRLdveiykpjNfB5pV
QAvina6KAJ4RLyad/OhTWGB/QWU4YgoL4Ksgf8ZQxqYBjErqutzD0gHOWB9Pst9k
h75Ca2jLrWLxWu+3t+9h25IbiGf0IklgNfKL2GmmtKpjTl1HxBJ3p9S9CClvx4GB
A+Y3LaurPWFT4cIaX1FWW8pnuFoLkDap/Pw3Cd2qZMnRuqkcVWlaPpQIBtcCuGrW
CprEPppwMWRCok2oF4MRyEcBFPPuvNJzUBjVAgtKlVCVvsTkzxKKvjQC3ThGX/On
3NY8XwiPjGWLW9OhCy2J+YvPqIU/1d6kbrK+AVVVz9aamm/xAv8=
=8cpx
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
