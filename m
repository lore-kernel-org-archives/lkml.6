Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7BEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263F820660
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pf0QkBZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263F820660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeKZWpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:45:22 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46091 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeKZWpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:45:22 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so15503010edt.13;
        Mon, 26 Nov 2018 03:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lvw7BO9vqIh3xNM5ohTUc6wiJZYFlEdlG5VeP+ipl8Q=;
        b=pf0QkBZ8t+oW69UclpkQFlFH2fG4jkPb0rN343OucmBKqwtVdax8ozj/aRbiat+4YR
         Rq2sZ+6jCqkoKei0IoM24wCjJOX264JVcuGzGbRhcC6YxUcj/XmguVHzOuFFiQmXvcJ4
         qzmpZIjmK7u5XwYDbIZSl2DGGXIKxRnuhtjA7oL8JP/JvAUX4/o9ZnQPCfPkZWOsfpl6
         4hs4tLK2OSOi/JYnCAv0wAUZy+SsurAPE6JbIXwQytUA/dvis3f+kbRqY+icEhW1aoff
         ddbm0vU0wOJxRt0CZDIfs4wE2bRHDrSz209GOTyjxyldX9a/B0YKfEfmRxFbfMlNvv6e
         zhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lvw7BO9vqIh3xNM5ohTUc6wiJZYFlEdlG5VeP+ipl8Q=;
        b=FnHCEJLEEWKkSG2eqR8xSK+EL3Fkw8FBBiQONGqXxXBfQ0AtwZ1KO3MqeY188si2e6
         DRArTJn4D1PXc3Er5vNg9HUA3meGVtNhIEZNDL5h/A9olI1sKQ7bg4B36ZHlE69JV9xD
         rpI2/WdHjkdbqo7Yisbuy2xuAiG5P3T9rvP0/EtOLr2X8DA9kk77cMCw7ZQCDACIzHp4
         Aswo8jEwvaH3jhLXiUdKVPehxJjbbHtOYXfoym9CDG3lT3rBE2QUMtRRAWYYY4iVbs49
         wziiXzcG3cL3F/KPaD4+sk8aYx3H9g/jClcKJZyCMXgoCKGMuD8wdC5pSETwdNkiZ2OI
         2CUQ==
X-Gm-Message-State: AA+aEWaPkwEhShrAdvB2M+9hkJSAoT/SkqZvsJphnhExsAY74ofVJT94
        1EbDgqi6sOhxJmZd/IM43hM=
X-Google-Smtp-Source: AFSGD/XDUzpFavW1fLWcwqqNASf2tfmE5StJPhzIuMykjz2WKFa1Y+5NcIMJqxbRc1G78n+Pv2bWlg==
X-Received: by 2002:a50:fa0c:: with SMTP id b12mr21798196edq.138.1543233085872;
        Mon, 26 Nov 2018 03:51:25 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id q4sm121502eda.50.2018.11.26.03.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 03:51:24 -0800 (PST)
Date:   Mon, 26 Nov 2018 12:51:23 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@karo-electronics.de>,
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
Message-ID: <20181126115123.GA15164@ulmo>
References: <20181114215120.vddykljqyavm64wj@pengutronix.de>
 <20181115152545.GA8611@ulmo>
 <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
 <20181116083430.7f1d8452@ipc1.ka-ro>
 <20181116082557.l2ljgu3hsu7tvdci@pengutronix.de>
 <91640f9b-d219-553e-043a-c6151f2f68d7@ysoft.com>
 <20181122162359.ufngpgxkenlmgqni@pengutronix.de>
 <b332b319-cbb3-547f-c8b7-1dd275c1596d@ysoft.com>
 <20181122190321.ktqegs7kpvhcemvi@pengutronix.de>
 <9da8c6d9-d97c-200c-d8e4-2eb9f73eedc5@ysoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <9da8c6d9-d97c-200c-d8e4-2eb9f73eedc5@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 03:15:11PM +0000, Vok=C3=A1=C4=8D Michal wrote:
> On 22.11.2018 20:03, Uwe Kleine-K=C3=B6nig wrote:
> > On Thu, Nov 22, 2018 at 04:46:39PM +0000, Vok=C3=A1=C4=8D Michal wrote:
> >> On 22.11.2018 17:23, Uwe Kleine-K=C3=B6nig wrote:
> >>> On Thu, Nov 22, 2018 at 03:42:14PM +0000, Vok=C3=A1=C4=8D Michal wrot=
e:
> >>>> On 16.11.2018 09:25, Uwe Kleine-K=C3=B6nig wrote:
> >>>>> On Fri, Nov 16, 2018 at 08:34:30AM +0100, Lothar Wa=C3=9Fmann wrote:
> >>>>>> No. You can disable the output driver via pinctrl, so that only the
> >>>>>> selected pull-up/down is relevant. The pin function and GPIO regis=
ter
> >>>>>> settings don't matter at all in this case.
> >>>>
> >>>> Lothar, please can you be more specific how would you do that? IFAIK=
 the
> >>>> pull-up/down internal resistors have effect only if the pin is confi=
gured
> >>>> as GPIO *input* (on i.MX6 at least). See the TRM, 29.4.2.2 Output dr=
iver:
> >>>>
> >>>>     "Internal pull-up, pull-down resistors, and pad keeper are disab=
led in
> >>>>      output mode."
> >=20
> > This would mean you'd have to rely on an external pull up for your use
> > case. I wouldn't be surprised however if DSE=3D0 wouldn't count as "out=
put
> > mode". Given the reliability of NXP documentation I wouldn't bet neither
> > on one nor the other possibility.
>=20
> Yeah, the NXP documentation sometimes does not really match reality.
> My use case is based on the fact that I configure the pin as input in
> the driver. Then it works just fine.
>=20
> >>> So I'd expect this to really work on i.MX6 but not the earlier SoCs
> >>> without a gpio specifier.
> >>
> >> Maybe you would expect it to work but I already tested and measured
> >> that weeks ago ;) It did not work.
> >=20
> > Which pin/gpio do we talk about? Which i.MX6 variant did you test this
> > on? (Assuming i.MX6D or i.MX6Q and PAD_DISP0_DATA09, did you try setting
> >=20
> > 	IOMUXC_SW_MUX_CTL_PAD_DISP0_DATA09 (0x020E0194) =3D 0x00000005
> > 	IOMUXC_SW_PAD_CTL_PAD_DISP0_DATA09 (0x020E04A8) =3D 0x0000b080
> >=20
> > and then play with GPIO 4.30 direction and output value?)
>=20
> My test setup is as follows:
> - SoC is i.MX6DL or i.MX6S - I have three board variants in total.
> - Pin used for PWM/GPIO is PAD_GPIO9.
> - The pin is not connected to any circuit. Just a test point.
> - pinctrl setup in DT:
>    - for "pwm":
>      - fsl,pins =3D <MX6QDL_PAD_GPIO_9__PWM1_OUT 0x8>
>      - IOMUXC_SW_MUX_CTL_PAD_GPIO09 =3D 0x00000004
>      - IOMUXC_SW_PAD_CTL_PAD_GPIO09 =3D 0x00000008
>=20
>    - for "gpio":
>     - fsl,pins =3D <MX6QDL_PAD_GPIO_9__GPIO1_IO09 0xb000>
>     - IOMUXC_SW_MUX_CTL_PAD_GPIO09 =3D 0x00000005
>     - IOMUXC_SW_PAD_CTL_PAD_GPIO09 =3D 0x0000b000

Does it help if you additionally set the ODE bit (bit 11) here?

Thierry

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv73jgACgkQ3SOs138+
s6Eo/hAAiZDZS/s4dgLSQLvuZolBku1IUFAPtT68E1MuS8GLBsO3HsTImJ3/+v9C
QcohCQ4B1ymoOU8x5WcF5kDy928tpvZ7y+u1YG9QUt+jkmZ1tOIUPuSQbjwZsirU
jDJxmLWMZfOuEydNIRM4CPKSyO6l/XD1QMdtV51LkCJLhvCSUv+bFVDwR+EBpXCw
0kBlLPuyjVFmp7Lg2oBIgIY2a56TwgpXJViAWRWxY1ugQaS9qrMj70gxlAjGkY0T
Dz7ZxPTJU7YpggVHF09eO7ReYOFPikSc8hP/2fNIL0O2DbSc04mmbR6sXLY0al5A
opadlDPtRvMli/5ECp0+jneaQStdThmB3DKfFCxG5rNpwb2dlnm//waFahM6Y9cY
Kw+C9AJly3hiG1a2uQnmL5ijaBqyLXPlUAqMr5vtU2CHRNZRiHSmZzASSGObIkcn
4XHYWEkLkxvkxh0Av1Y3vBOX/6+WeZdKWBxNSISDFjG+G74SCKGQpxIRYrLXj+2S
fAUHHZQSvL1RohhEmm9AICTcaQOuJz4aFV+ew4lo82zKhpbS/J7KvCHredi7tzuf
pZI363JxqpalfLZQl7cfzYckbFHSnOb3LaYWiVnKgURt45y9Gd2giHqbrKqGJEmU
SPWgv4bFPRfhnsOb+soBxbZNsOWCUfYPlStImQC+9toyDaIUkM0=
=ImQK
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
