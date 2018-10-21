Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0E2C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564A42088F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4oUKpQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564A42088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbeJVTvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:51:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728894AbeJVTvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 15:51:41 -0400
Received: from earth.universe (unknown [185.7.230.215])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F3F320895;
        Mon, 22 Oct 2018 11:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540208010;
        bh=EwOozlxLtjCXkhUBDLya0rKQTCPT6FWumsALANLZzmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4oUKpQ5cjtT0MitzKJPkfpUb3/j+hDEDrq3n6IxgsiP0kbhAoW+cqXJ6/m5wFbXf
         eA1HjFGs+Qw99FtHY5uzTe4s/ekU3n6CFisOjErR7SW4Do46FVgu6RiS/l/9aoOWEI
         wwuK8RNxyih9qmOUcIvcJynKBmdiIQmJju4jGdn4=
Received: by earth.universe (Postfix, from userid 1000)
        id 2A43C3C098F; Sun, 21 Oct 2018 23:27:37 +0200 (CEST)
Date:   Sun, 21 Oct 2018 23:27:37 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        David Woodhouse <dwmw2@infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quozl@laptop.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        devel@driverdev.osuosl.org, Linux PM <linux-pm@vger.kernel.org>,
        Stable <stable@vger.kernel.org>
Subject: Re: [PATCH 01/15] power: supply: olpc_battery: correct the
 temperature units
Message-ID: <20181021212737.v546ychvlnkxxvrp@earth.universe>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-2-lkundrak@v3.sk>
 <CAHp75VenECSZWR3RVh=t35Os93t-MzEH_YzPgT=qQWL-SwjgFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a3qwmqvb2q2d7nto"
Content-Disposition: inline
In-Reply-To: <CAHp75VenECSZWR3RVh=t35Os93t-MzEH_YzPgT=qQWL-SwjgFQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a3qwmqvb2q2d7nto
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 19, 2018 at 04:00:32PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> >
> > According to [1] and [2], the temperature values are in tenths of degree
> > Celsius. Exposing the Celsius value makes the battery appear on fire:
> >
> >   $ upower -i /org/freedesktop/UPower/devices/battery_olpc_battery
> >   ...
> >       temperature:         236.9 degrees C
> >
> > Tested on OLPC XO-1 and OLPC XO-1.75 laptops.
>=20
> It's interesting that the very author of that code is not included in
> so-o long Cc list :)
> Cc: David.
>=20
> David, do you remember if and how you had tested temperature report of
> the battery on OLPC? I guess this kind of error would be appear immediate=
ly.

It depends on the way of testing. It's not so obvious when you just
do a `cat /sys/class/power_supply/.../temperature`, since you just
get the raw integer.

> OTOH it might be that power framework had changed requirements (which
> would be noticeable change).

As far as I know, power-supply has always used 1/10 =B0C. People tend
to get units wrong all the time though (i.e. mV instead of uV). I'm
not surprised, that this sneaked into the kernel.

> If the latter is true, this patch misses Fixes tag. Actually in any
> case it misses it.

Yes, this should probably have Fixes: fb972873a767 ("[BATTERY] One Laptop
Per Child power/battery driver").

-- Sebastian

> > [1] include/linux/power_supply.h
> > [2] Documentation/power/power_supply_class.txt
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  drivers/power/supply/olpc_battery.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply=
/olpc_battery.c
> > index 6da79ae14860..5a97e42a3547 100644
> > --- a/drivers/power/supply/olpc_battery.c
> > +++ b/drivers/power/supply/olpc_battery.c
> > @@ -428,14 +428,14 @@ static int olpc_bat_get_property(struct power_sup=
ply *psy,
> >                 if (ret)
> >                         return ret;
> >
> > -               val->intval =3D (s16)be16_to_cpu(ec_word) * 100 / 256;
> > +               val->intval =3D (s16)be16_to_cpu(ec_word) * 10 / 256;
> >                 break;
> >         case POWER_SUPPLY_PROP_TEMP_AMBIENT:
> >                 ret =3D olpc_ec_cmd(EC_AMB_TEMP, NULL, 0, (void *)&ec_w=
ord, 2);
> >                 if (ret)
> >                         return ret;
> >
> > -               val->intval =3D (int)be16_to_cpu(ec_word) * 100 / 256;
> > +               val->intval =3D (int)be16_to_cpu(ec_word) * 10 / 256;
> >                 break;
> >         case POWER_SUPPLY_PROP_CHARGE_COUNTER:
> >                 ret =3D olpc_ec_cmd(EC_BAT_ACR, NULL, 0, (void *)&ec_wo=
rd, 2);
> > --
> > 2.19.0
> >
>=20
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

--a3qwmqvb2q2d7nto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvM70YACgkQ2O7X88g7
+pqmfg/+JkX1Lw0K3PAD9UrZW1Yplr9O68D98XVu9TPSb1cJu1whYaXFPvNEYhIQ
yjG6I1tIKgf17VinnZAcm+uvrAnhzIKYebyPOhY35ao3XxWZri4fmQ5r8jicsD/0
BIe5TqZz28RwdQA6qpXLU1SKtSLfwD/5VlLHQQaSwhD5s8KArMnNU1VGYApzjqe3
53SbAjyzyepvXhEbAfLQiKnxMcH92asZuYGjx1js+nMF85rBMQ4AdQKFwPm7ltOy
C6LGh5mMdS5JkmOxPEekNwbdsX7LDcvVtQ7YFaZXlORT/OmJncYkoCOBt4klzM75
zj96dzoXwLUwbNZQYlxsfjyWwwrzMtMNYdvuygERH88JKlpm3jL+7KnAgivE4JoS
CuwcVQKHlThf3qZ6qCxaZyMAVsGP5qA8sRKh0G/MJtRe3quP9vQSrbFmRQi8XSf7
yQWrYwJl86mt1po7xINqr3+7AOLqw3FKexdMATLXFDzu6FGJDQHhc8MnxamfVT0r
VkmwM88lqeI/jkZTV0wwFmYK/xVjN3/o8usjOofp9vsoDYl4VpbHfncw2veNP5ch
FdXBpCqRvZO1ysE/7VgnX3QNJ5CViqa8n14eWxCArh1j+fb6Bx5UXrYLgt2zKFho
foxb3JrVPR+VY0UIF+4BLwLuPcCO47Zbq9DOjfjimmEqEfBNyPE=
=e80x
-----END PGP SIGNATURE-----

--a3qwmqvb2q2d7nto--
