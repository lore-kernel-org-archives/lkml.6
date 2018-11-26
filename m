Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EACC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240EE20817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHrdov29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240EE20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbeK0A24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:28:56 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40525 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeK0A24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:28:56 -0500
Received: by mail-ed1-f66.google.com with SMTP id d3so15817855edx.7;
        Mon, 26 Nov 2018 05:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PvoTnl1fyScwZ9OPhWe2dyxBuLCH0L7Dlf/cEQDBvxQ=;
        b=JHrdov29f+fFOiHcdTaAVGcXMUlIBHa047fsw1nhGI64vB9+xyMl2R3+M9W7UV3zAC
         H1Jd3Fso14TYupN7dS0g6E6bzcTa3sejnr7tJTh+iHe7A13DS1vyGhcNpsNUH5rMBkBQ
         aunWpJtiMaU7tdZ8m7FlAFRmi3zPSweW+HiKkhXJAmaQz4voyl5qlU2jMrYfudUZTluA
         dX7xdUj7plbkpMcVNK8PBHHf3sjyPF9OU6737eep/D/1qpbGAfBUMox0sbw0Qv6kmYem
         fgGnKuU1O8YAhJiRjW/aE/sbeYgh/xhUxPnVGSLQ++IddAxVNtMnZtMqyrxUof3+cZxX
         FFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PvoTnl1fyScwZ9OPhWe2dyxBuLCH0L7Dlf/cEQDBvxQ=;
        b=GsbfYACaPGym9Frm/JevEFMq0Wv896B238u0p0JEiIq5gQu28IWb2fQcCuOmKqDZCC
         h5ZbAc4YnsAeI0OV7xJ9FnknStBWMmX019HzQPks6d5o8UoQiOdqKK95sVshA3EDwjdF
         7pxshq4qGdgYqdBlY8NQJTrJp+z/5w3UpklHVc1RP6gVhx4PdBXY3gopQt3MFEMjYaZv
         fgm9D+kxrtkjlU94HDWZ29kmIYJkFwJvDuDD/orzNpBYQMS5RxcIOQVkATpJWftXtLgP
         7auWKDXLYxUYNBweWO7s9956zyS4y4ihhAz0a4cA4dO6QBFeTidqqtqAeHjgTbXw2I5a
         mmOg==
X-Gm-Message-State: AGRZ1gIs7cEsFsaTKvak23sl3772w57Ah3ilNAy6gzpJjWRJ5c+vJz6o
        mOgM+okTt2PlbxOOn1jLxHo=
X-Google-Smtp-Source: AJdET5fWh8qHTFXaS3p8UAXooP6o94VdN1VKcctliLwku8h76iH/xmw218OABEk+Eov03MCU19q9IQ==
X-Received: by 2002:a17:906:3548:: with SMTP id s8-v6mr20245688eja.161.1543239285306;
        Mon, 26 Nov 2018 05:34:45 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id s27-v6sm109706ejm.14.2018.11.26.05.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 05:34:43 -0800 (PST)
Date:   Mon, 26 Nov 2018 14:34:41 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@karo-electronics.de>
Cc:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in
 disabled state
Message-ID: <20181126133441.GA19710@ulmo>
References: <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
 <20181116083430.7f1d8452@ipc1.ka-ro>
 <20181116082557.l2ljgu3hsu7tvdci@pengutronix.de>
 <91640f9b-d219-553e-043a-c6151f2f68d7@ysoft.com>
 <20181122162359.ufngpgxkenlmgqni@pengutronix.de>
 <b332b319-cbb3-547f-c8b7-1dd275c1596d@ysoft.com>
 <20181122190321.ktqegs7kpvhcemvi@pengutronix.de>
 <9da8c6d9-d97c-200c-d8e4-2eb9f73eedc5@ysoft.com>
 <20181126115123.GA15164@ulmo>
 <20181126132316.541a4131@ipc1.ka-ro>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <20181126132316.541a4131@ipc1.ka-ro>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2018 at 01:23:16PM +0100, Lothar Wa=C3=9Fmann wrote:
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Fri, Nov 23, 2018 at 03:15:11PM +0000, Vok=C3=A1=C4=8D Michal wrote:
> > > On 22.11.2018 20:03, Uwe Kleine-K=C3=B6nig wrote: =20
> > > > On Thu, Nov 22, 2018 at 04:46:39PM +0000, Vok=C3=A1=C4=8D Michal wr=
ote: =20
> > > >> On 22.11.2018 17:23, Uwe Kleine-K=C3=B6nig wrote: =20
> > > >>> On Thu, Nov 22, 2018 at 03:42:14PM +0000, Vok=C3=A1=C4=8D Michal =
wrote: =20
> > > >>>> On 16.11.2018 09:25, Uwe Kleine-K=C3=B6nig wrote: =20
> > > >>>>> On Fri, Nov 16, 2018 at 08:34:30AM +0100, Lothar Wa=C3=9Fmann w=
rote: =20
> > > >>>>>> No. You can disable the output driver via pinctrl, so that onl=
y the
> > > >>>>>> selected pull-up/down is relevant. The pin function and GPIO r=
egister
> > > >>>>>> settings don't matter at all in this case. =20
> > > >>>>
> > > >>>> Lothar, please can you be more specific how would you do that? I=
FAIK the
> > > >>>> pull-up/down internal resistors have effect only if the pin is c=
onfigured
> > > >>>> as GPIO *input* (on i.MX6 at least). See the TRM, 29.4.2.2 Outpu=
t driver:
> > > >>>>
> > > >>>>     "Internal pull-up, pull-down resistors, and pad keeper are d=
isabled in
> > > >>>>      output mode." =20
> > > >=20
> > > > This would mean you'd have to rely on an external pull up for your =
use
> > > > case. I wouldn't be surprised however if DSE=3D0 wouldn't count as =
"output
> > > > mode". Given the reliability of NXP documentation I wouldn't bet ne=
ither
> > > > on one nor the other possibility. =20
> > >=20
> > > Yeah, the NXP documentation sometimes does not really match reality.
> > > My use case is based on the fact that I configure the pin as input in
> > > the driver. Then it works just fine.
> > >  =20
> > > >>> So I'd expect this to really work on i.MX6 but not the earlier So=
Cs
> > > >>> without a gpio specifier. =20
> > > >>
> > > >> Maybe you would expect it to work but I already tested and measured
> > > >> that weeks ago ;) It did not work. =20
> > > >=20
> > > > Which pin/gpio do we talk about? Which i.MX6 variant did you test t=
his
> > > > on? (Assuming i.MX6D or i.MX6Q and PAD_DISP0_DATA09, did you try se=
tting
> > > >=20
> > > > 	IOMUXC_SW_MUX_CTL_PAD_DISP0_DATA09 (0x020E0194) =3D 0x00000005
> > > > 	IOMUXC_SW_PAD_CTL_PAD_DISP0_DATA09 (0x020E04A8) =3D 0x0000b080
> > > >=20
> > > > and then play with GPIO 4.30 direction and output value?) =20
> > >=20
> > > My test setup is as follows:
> > > - SoC is i.MX6DL or i.MX6S - I have three board variants in total.
> > > - Pin used for PWM/GPIO is PAD_GPIO9.
> > > - The pin is not connected to any circuit. Just a test point.
> > > - pinctrl setup in DT:
> > >    - for "pwm":
> > >      - fsl,pins =3D <MX6QDL_PAD_GPIO_9__PWM1_OUT 0x8>
> > >      - IOMUXC_SW_MUX_CTL_PAD_GPIO09 =3D 0x00000004
> > >      - IOMUXC_SW_PAD_CTL_PAD_GPIO09 =3D 0x00000008
> > >=20
> > >    - for "gpio":
> > >     - fsl,pins =3D <MX6QDL_PAD_GPIO_9__GPIO1_IO09 0xb000>
> > >     - IOMUXC_SW_MUX_CTL_PAD_GPIO09 =3D 0x00000005
> > >     - IOMUXC_SW_PAD_CTL_PAD_GPIO09 =3D 0x0000b000 =20
> >=20
> > Does it help if you additionally set the ODE bit (bit 11) here?
> >=20
> That only helps to NOT actively pulling the pin HIGH, but the opposite
> is what is needed here.

=46rom the description in the reference manual it sounded like the ODE
would avoid the pin from actively being driven anywhere if configured as
output. So I was hoping that in conjunction with the pull-up it would
actually do the right thing.

Thierry

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv79msACgkQ3SOs138+
s6FdMA//UNvSguIX8sS/vfmK7dI87/H47jK7CWgbpBE6XKTZB0x2qwlTyIIpm8At
JtzsZOJa6+V8wmyTJ0XPlOIBIM/mazjK+SYOI5o98ZtJ7gqkKSbMAK5UKCz9YoJ8
rkzqWMN/Kaj2yI6zFJtAxAxtAovKOVdbRb4tAJtbEMB5597H82OmOVnEatBSZSDP
u9zbN5J2fWNFwk2zIyzoeD1Jq4ZHkaDK2GWS3emVYCwX0z98AIHtkRo+DuX8Ya9/
/oNqGIvBER++5FW2mG9cR2qLCiogSEfh3Qg3AkNXlbiP5sz18cQXgMxE8dPN2IuG
QjqxOBJxc+vTOkn6ip29wZ1FX2hJktvrNp1NhO3w4RPM64/XBJsZg5wSTFjf3a/H
bTC6t5h/uri3/SkKv/h6CYJhwVqtTfGiqZLsjxW7XoWh8kW7JQ8hfKqT82SsBLL0
Qqqse/9whsPqraFa4fWOjT1qcPbw+Ovo1bk4kjXLdmuzdsZlB36H96EtUk1Yluip
SfAY2iqGpZwIylHxGoqO8rmpWTRliHM0DFGN6M9D4fpo0pejx6Juzr4lPhwvTkaT
cN9fHFwJIoYYP0Y0yLWd4to6oSVItGALGAFy7Zk9uBEQcbUGhQ9h3zxLi23VK/4+
/o0V0r+awY085jEq8FDWcV31kPFIqDLTp+rXx3AViWkW+8aFf8w=
=xRNX
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
