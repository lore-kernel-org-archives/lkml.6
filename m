Return-Path: <sebastian.reichel@collabora.co.uk>
X-Google-Smtp-Source: AIpwx4+C3A2W8CGM8ju7Xgl1SnbYJW72ALfJwK+PPTaV4+A/QQ4gGqpdulCyzzfkPGGd2mSc/vL+
ARC-Seal: i=1; a=rsa-sha256; t=1523308421; cv=none;
        d=google.com; s=arc-20160816;
        b=Ta3lJwNnl8roz6NqCX9OTe817nT679IuRkcr6IpHDsJlNDllSnwlF+oCiQhixRM4mi
         juVpXawoivappGhJ8pSRhVT57saN6Xa5CscmXbZ/pl4IIRRa8a6ru0te7jSoOikZqU7B
         8yxN85dvi3ayYwsskQl5fwQurg4NE7me7t29CJzN52cpbLtRp/1+CdhQl6xguf2NB/xN
         Pfz5dQOvzUDdBtkyxh6Pu1rO//Y3MWVA0C35NlJWoJwAQ4QX2qnMcyJJVsnVCsiTlkHg
         2QCrl0qD9eakQmVN+jUr/c4ljLrqtM13J9cvG6XUX51gTbULUsViKZz0lWzZxq0ESiOm
         nB8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ffonAcNWu/1YZvJhCpFGiQpe2Unm94WGAFSG8FZvofA=;
        b=U+QZl1Q4/BUPwYQeEPm5/1OAcDdEXOl0QEp6Pji3dY/irKgVkuVYpL42OGH3xBPvVA
         Rap5LP4YQQIIRAqVV8pMGYg45ffnivxs38pMGaf4XZZ3P//djy9QcbMIZAN6nHAVBK/a
         dayMejpfPdFzCedCrEtEWrAulK8tAfjTkpkJWqo1Q5ea/+5CRYDenzwEwPIDiPN4RRat
         gkdBVB2ucf7WrfW8ZtqKk3DFigbTRP3rtD97apChILb7lOdxR+TcWodaToZ6JFM7jDpx
         YcakCoowqkPLRIkRux1Wksvz/Oz8matVFS0WlUlGtIo3yTk7fAZLUt6ut/2SGcyLL+IG
         pgxg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sebastian.reichel@collabora.co.uk designates 46.235.227.227 as permitted sender) smtp.mailfrom=sebastian.reichel@collabora.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sebastian.reichel@collabora.co.uk designates 46.235.227.227 as permitted sender) smtp.mailfrom=sebastian.reichel@collabora.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.co.uk
Date: Mon, 9 Apr 2018 23:13:37 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Mark Rutland <mark.rutland@arm.com>, Nandor Han <nandor.han@ge.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCHv2 1/3] dt-bindings: misc: achc: Make ezport
 distinguishable
Message-ID: <20180409211337.goavadt6f22wtkbw@earth.universe>
References: <20180327135259.30890-1-sebastian.reichel@collabora.co.uk>
 <20180327135259.30890-2-sebastian.reichel@collabora.co.uk>
 <20180409185727.j4unhx5ig3fgm6ex@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="acogu7jgkafanp6d"
Content-Disposition: inline
In-Reply-To: <20180409185727.j4unhx5ig3fgm6ex@rob-hp-laptop>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596099171871027959?=
X-GMAIL-MSGID: =?utf-8?q?1597304651315502269?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--acogu7jgkafanp6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 09, 2018 at 01:57:27PM -0500, Rob Herring wrote:
> On Tue, Mar 27, 2018 at 03:52:57PM +0200, Sebastian Reichel wrote:
> > This updates the GE ACHC binding, so that different compatible
> > strings are used for the programming interface, which is the
> > ezport interface from NXP MK20FN1M0VMD12 and the microcontroller's
> > normal SPI interface.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > ---
> >  Documentation/devicetree/bindings/misc/ge-achc.txt | 19 ++++++++++++++=
++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/misc/ge-achc.txt b/Docum=
entation/devicetree/bindings/misc/ge-achc.txt
> > index 77df94d7a32f..6c6bd6568504 100644
> > --- a/Documentation/devicetree/bindings/misc/ge-achc.txt
> > +++ b/Documentation/devicetree/bindings/misc/ge-achc.txt
> > @@ -7,7 +7,13 @@ Note: This device does not expose the peripherals as U=
SB devices.
> > =20
> >  Required properties:
> > =20
> > -- compatible : Should be "ge,achc"
> > +- compatible : Should be
> > +  "ge,achc" (normal interface)
> > +  "ge,achc-ezport" (flashing interface)
> > +
> > +Required properties (flashing interface only):
> > +
> > +- reset-gpios: GPIO Specifier for the reset GPIO
>=20
> Does the reset only affect the flashing interface and are the data pins=
=20
> shared? If not for both, then I think the correct thing to do here is=20
> just extend reg to support multiple values to represent multiple chip=20
> selects.

reset affects the whole chip and the same spi data/clock pins are
being used, so extending reg should work. The flashing cannot happen
with the same speed, though. I'm currently encoding this by using
different "spi-max-frequency" properties. I suppose I could limit
it in the driver instead. I tried to come up with an example for
your suggestion. Is this what you had in mind?

&spi_controller {
    achc@multiple {
        /* 0 =3D flashing interface, 1 =3D normal interface */
        reg =3D <0>, <1>;
        compatible =3D "ge,achc";
        reset-gpios =3D <&gpio42 23 ACTIVE_LOW>;
        spi-max-frequency =3D <42>; /* max speed for normal operation */
    };
};

-- Sebastian

--acogu7jgkafanp6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrL134ACgkQ2O7X88g7
+poINQ//a+J7+V5hKWgwQHchgWZm0WQdrRELqDqmbIuj9XZiHDAMUGf3ffx2t8zQ
mCnwjnjEbHqSLQmJ7seikJzJ/MhHrE4qKMqsy38zacx1TzjmMEAq7IBV8I5V8kVw
UmkFIN47Ng9uTOxGHLoYJqEnQFXtiWf2EmQ+hUMaIDokvzumuEI1muAGLblERL97
nWdCpdgcdIzgTPqgjkDb1a6j8OF4uJFWTh/ci3y9OGe7ytalyuSHKJ3XBBHw+IHJ
up4yvZPx7BE5BAwaRNWoaIPK1Bro8qhRNyCWHS/k7oR96UXEhum2picskVNFYqGm
/MNhe5U5vqS7ysvxadOaw2Z7SDosQL49nKB+6HYFJ1D2VcwKjkoNvyWZ6wHSx8Jm
4/Eas5aS16Qp+hwgF5ir+rTTzUTDCxVy1aSsYM/DCJy5ZjNJ3P/PQpqpk42xBOV6
0QWPhMNeOg+vutYQ5+GJOx2iBZB+CLuP2oxj5zSY2V2HbLIBl4plcfQJm9m/rifJ
/ogKFleLMB5r62B+LHgC2L2QXCQ2hr4f3hCjGCF0J7Cz+eDpQBzYeJur9cL1fBbI
0Wn/5/3UzFKAlHYvMLSjZGyCS2mRCwDeB4Fyx1/GBREp3s6zRAYRJLdV20UHglsR
zAwmF/M2MsdXs45auQU+8VQKAvLt3wFYMNoaMAhEQvWHa5+J1zY=
=A6Mh
-----END PGP SIGNATURE-----

--acogu7jgkafanp6d--
