Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2B9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C182147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550619038;
	bh=fWo1xkeeNjGWZo2YZUVhWLgi8eFQh0BY6waxHe8D1gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wm9qq0y8l4GhDaqu3yaYk28XMnisirUFaoC7xGfARiueQpWmXl0Tb4v0sTY0+ql/7
	 z1vKsXpWFKBVrns1Auo0rF4ubdDRsLIV2kjwXcyHU4qOqelJ8VuMs/kvccxru4YGnC
	 yCGq5c+1ooHg2562L04a61l3Oe1jLC1rVD8em9AY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfBSXag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:30:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:38642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729700AbfBSXad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:30:33 -0500
Received: from earth.universe (unknown [185.216.33.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 592462147A;
        Tue, 19 Feb 2019 23:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550619032;
        bh=fWo1xkeeNjGWZo2YZUVhWLgi8eFQh0BY6waxHe8D1gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bEMcXfVlwT5xhHDk2YszufV15IA2hVPjBa7CV6jf0PW+SY1eNjM1J/qy7vFVA07UZ
         +Ej6w2sGvTODqYXi3N+X2UAvDc72U5A8mcLf6SSucDSPwRF8sLV19JTXanC7/pv0aL
         zv9EzSA5uyJKNkzyJrXJXIRoTEaBPTE3nTKeb9x4=
Received: by earth.universe (Postfix, from userid 1000)
        id 58B793C08DD; Wed, 20 Feb 2019 00:30:30 +0100 (CET)
Date:   Wed, 20 Feb 2019 00:30:30 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Arthur Demchenkov <spinal.by@gmail.com>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bq27x00: use cached flags
Message-ID: <20190219233030.uo3akxvvf47ymxsg@earth.universe>
References: <20190218065920.16205-1-spinal.by@gmail.com>
 <be028fd4-f05b-4357-d693-46e226b0f2c7@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gt374reos3wdetyp"
Content-Disposition: inline
In-Reply-To: <be028fd4-f05b-4357-d693-46e226b0f2c7@ti.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gt374reos3wdetyp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 19, 2019 at 10:55:37AM -0600, Andrew F. Davis wrote:
> On 2/18/19 12:59 AM, Arthur Demchenkov wrote:
> > The flags were just read by bq27xxx_battery_update(),
> > no need to read them again.
> >=20
> > Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
> > ---
>=20
> Nothing obviously wrong with this patch so:
>=20
> Reviewed-by: Andrew F. Davis <afd@ti.com>
>=20
> At this point we have W1 regmap and so we now have everything we should
> need to convert this driver over to regmap. Then the caching comes for
> free and a lot of checks and such can be dropped.

Yes, bq27xxx could be simplified a lot by converting to regmap and a
patch would be appreciated. This register cannot be cached by regmap,
though. Regmap caching is only for registers, that are not modified
by the hardware (except during reset).

Thanks for the patch and the review, I just merged this to power-supply-nex=
t.

-- Sebastian

>=20
> Thanks,
> Andrew
>=20
> >  drivers/power/supply/bq27xxx_battery.c | 20 ++++----------------
> >  1 file changed, 4 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/sup=
ply/bq27xxx_battery.c
> > index 6dbbe95844a3..29b3a4056865 100644
> > --- a/drivers/power/supply/bq27xxx_battery.c
> > +++ b/drivers/power/supply/bq27xxx_battery.c
> > @@ -1555,27 +1555,14 @@ static bool bq27xxx_battery_dead(struct bq27xxx=
_device_info *di, u16 flags)
> >  		return flags & (BQ27XXX_FLAG_SOC1 | BQ27XXX_FLAG_SOCF);
> >  }
> > =20
> > -/*
> > - * Read flag register.
> > - * Return < 0 if something fails.
> > - */
> >  static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
> >  {
> > -	int flags;
> > -	bool has_singe_flag =3D di->opts & BQ27XXX_O_ZERO;
> > -
> > -	flags =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
> > -	if (flags < 0) {
> > -		dev_err(di->dev, "error reading flag register:%d\n", flags);
> > -		return flags;
> > -	}
> > -
> >  	/* Unlikely but important to return first */
> > -	if (unlikely(bq27xxx_battery_overtemp(di, flags)))
> > +	if (unlikely(bq27xxx_battery_overtemp(di, di->cache.flags)))
> >  		return POWER_SUPPLY_HEALTH_OVERHEAT;
> > -	if (unlikely(bq27xxx_battery_undertemp(di, flags)))
> > +	if (unlikely(bq27xxx_battery_undertemp(di, di->cache.flags)))
> >  		return POWER_SUPPLY_HEALTH_COLD;
> > -	if (unlikely(bq27xxx_battery_dead(di, flags)))
> > +	if (unlikely(bq27xxx_battery_dead(di, di->cache.flags)))
> >  		return POWER_SUPPLY_HEALTH_DEAD;
> > =20
> >  	return POWER_SUPPLY_HEALTH_GOOD;
> > @@ -1612,6 +1599,7 @@ void bq27xxx_battery_update(struct bq27xxx_device=
_info *di)
> >  			cache.capacity =3D bq27xxx_battery_read_soc(di);
> >  			if (di->regs[BQ27XXX_REG_AE] !=3D INVALID_REG_ADDR)
> >  				cache.energy =3D bq27xxx_battery_read_energy(di);
> > +			di->cache.flags =3D cache.flags;
> >  			cache.health =3D bq27xxx_battery_read_health(di);
> >  		}
> >  		if (di->regs[BQ27XXX_REG_CYCT] !=3D INVALID_REG_ADDR)
> >=20

--gt374reos3wdetyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxskZMACgkQ2O7X88g7
+ppFag/8Cm5PzVT+V0CTAJcdVmSmW2D3uTcE4OkT+zftbiyiqPnI31P+7rJ8MDoE
zl+ruccb6ZUp7ngncYfSXcJpGlIo6x5yVfFe+ZNFzn3oWCbSHHfZFW7guVyeVua5
mP4hHR8Q0EWfJld0mAHmqFWKUbq+Fkc2mQTRZRlomlzKyJYRXkKO0zrLTZscDTlZ
eC08urUkv8AZOIcNS23dG4kdaEqXtokQ2z1f1JznRo/DrGTJWoNRmX33O+D5vJpe
u0DW6S6lcWWadMGB5uIRODzjyds7dikF+v3nq4ojw+66VZmyvALD62zrdIuB2oYI
lPA050JNjJ6ELoWhTUYJr70GEtRoJ40ygQLi7+Tj6XlbSwc8yZ+HX0N1Z2Hl7j9e
eZ9UxRkXOrkpo+bjFOCUCdK0Z2v/t7vhaMQrRTvobIm9BpOAO5GCx8Eh7UO1KXnG
k+PObGKxQqwkYISApUOvkF/7asCxRsuLo1zc6qFN28lqDm+GJAHdu/h3cs4DP0hg
ZbuKhjw5W5ItsI48ZADxLY2yrsiF2ngsZmyaLnKMlL8Jqcw5dXDv5q++yC0M79QU
jagWz8AcJK5XAh+H1cNe/ccCGfBGgd1AY21e83ydE/aBd9KedMLt9YR/nZe6FuTt
GZkOaUlVCYoHLTo8nCz7O8VVG4rV3Z8VsHZ3Usclqc4KhbKU4iw=
=3O4w
-----END PGP SIGNATURE-----

--gt374reos3wdetyp--
