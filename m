Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752961AbeDLOpN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:45:13 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:51478 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752908AbeDLOpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:45:11 -0400
X-Auth-Info: WQSodfbMSr+KfVe5APJB6gNL6NlLNGGy/AnwnqlQNcI=
Date: Thu, 12 Apr 2018 16:45:01 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Joe Perches <joe@perches.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] mfd: mc13xxx: Add mc34708 adc support
Message-ID: <20180412164501.66b50f81@jawa>
In-Reply-To: <2f5a6878bf17e9cfa78de3c5b2ae52c1e8995bb1.camel@perches.com>
References: <20180411140929.30357-1-lukma@denx.de>
        <2f5a6878bf17e9cfa78de3c5b2ae52c1e8995bb1.camel@perches.com>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/AeRPRXKhF9dReqGEQvnuF_q"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AeRPRXKhF9dReqGEQvnuF_q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Joe,

> On Wed, 2018-04-11 at 16:09 +0200, Lukasz Majewski wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> >=20
> > The mc34708 has an improved adc. The older variants will always
> > convert a fixed order of channels. The mc34708 can do up to eight
> > conversions in arbitrary channel order. Currently this extended
> > feature is not supported. We only support touchscreen conversions
> > now, which will be sampled in a data format compatible to the older
> > chips in order to keep the API between the mfd and the touchscreen
> > driver. =20
> []
> > diff --git a/drivers/mfd/mc13xxx-core.c
> > b/drivers/mfd/mc13xxx-core.c =20
> []
> > +static int mc34708_adc_conversion(struct mc13xxx *mc13xxx,
> > unsigned int mode,
> > +		unsigned int channel, u8 ato, bool atox,
> > +		unsigned int *sample)
> > +{
> > +	int ret, i; =20
> []
> > +	if (mc13xxx->adcflags & MC13XXX_ADC_WORKING) {
> > +		ret =3D -EBUSY;
> > +		goto out;
> > +	} =20
>=20
> This doesn't work.
>=20
> > []
> > +	mc13xxx_irq_free(mc13xxx, MC34708_IRQ_TSDONE,
> > &adcdone_data); +
> > +	if (!ret) {
> > +		ret =3D -ETIMEDOUT;
> > +		goto out;
> > +	} =20
> []
> > +out:
> > +	ret =3D mc13xxx_reg_write(mc13xxx, MC13XXX_ADC0, old_adc0); =20
>=20
> ret is reassigned here, so the ret =3D -<FOO>
> uses above don't do what is expected.

Right. Thanks for spotting this. I will fix it in v2.

>=20
> > +
> > +	mc13xxx->adcflags &=3D ~MC13XXX_ADC_WORKING;
> > +	mc13xxx_unlock(mc13xxx);
> > +
> > +	return ret;
> > +} =20
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/AeRPRXKhF9dReqGEQvnuF_q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlrPcO0ACgkQAR8vZIA0
zr0sjQf+KlaH2c6P+Z5CPbxHMOVbFzsN31RewwIEYWwoBbhktbrYT+ghR47Eq411
foX4R0Zc6aJnoQc1L5cYeLg1upyaTBM4hRl0aXXCuT9J6iYlOH7fMvH+AgdzoH4a
dkRAOE2exrnjeV/5HQiZwsJAeMGWZAP9seWRFAmv2YeChuii3rhLAF1EFPgyvexr
okfWXxqZ99lbfGQkSPaQDiowwWOMYW/wVdm9Jxpxn72i6bGFR8O4p+J1Y1vRFD8y
OiqVMhUh0wSnZbGR6okb5GhfSboi8CCb7QZMWQbqh/lzEQNQTQcwDAqCbL4C5w7S
ei15ycCo747iHicC9BbETpbIKVeWnw==
=MHVE
-----END PGP SIGNATURE-----

--Sig_/AeRPRXKhF9dReqGEQvnuF_q--
