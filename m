Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbeBER7U (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:59:20 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41418 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753337AbeBER7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:59:10 -0500
X-Google-Smtp-Source: AH8x225pg9wHvB+WJ0TGSKKEUJ8dtxFpC1SQzXPcxaVZqTzgNSKSdeUFpBxIHC7E45z0eD91xYej/g==
Date: Mon, 5 Feb 2018 18:59:06 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        linux-next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: mediatek: Explicitly include pinctrl headers
Message-ID: <20180205175906.GA8237@ulmo>
References: <20180205124750.19305-1-thierry.reding@gmail.com>
 <20180205125436.24005-1-thierry.reding@gmail.com>
 <CA+55aFy--bQRDZEUsBfiWhyP+Of3+s4zEcKo1T8cCoAMXBrwsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <CA+55aFy--bQRDZEUsBfiWhyP+Of3+s4zEcKo1T8cCoAMXBrwsw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2018 at 09:42:21AM -0800, Linus Torvalds wrote:
> On Mon, Feb 5, 2018 at 4:54 AM, Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> >
> > Include these headers explicitly to avoid the build failure.
>=20
> I don't think you need to include *both*.
>=20
> <linux/device.h> used to include just <linux/pinctrl/devinfo.h>.
>=20
> I'll edit your patches to include just that.
> <linux/pinctrl/consumer.h> will come in automatically through it.

I was trying to avoid any implicit inclusion, but looking at
pinctrl/devinfo.h it has a comment right above the pinctrl/consumer.h
include that makes it clear that pinctrl/devinfo.h is the consumer of
pinctrl for the core, so I guess the implicit include is fine here.

I do question, though, if drivers have any business including this
pinctrl/devinfo.h in the first place. For the Mediatek ethernet it seems
like selecting the default state is redundant (the core should already
have taken care of that, and the driver never selects a different state
anywhere).

The same is true of drm/rockchip, which also only seems to select a
state which the pinctrl core should've selected by default already. See
arch/arm/boot/dts/rk3288.dtsi which sets up the "lcdc" state as the only
state for the LVDS output.

Anyway, I think going with the pinctrl/devinfo.h include only is fine
for now. If it turns out that the Mediatek ethernet and Rockchip LVDS
drivers can just omit the bits fiddling with struct dev_pin_info, we can
swap out the pinctrl/devinfo.h include for pinctrl/consumer.h at that
time.

LinusW: what are your thoughts on the struct dev_pin_info usage by these
drivers? Does their code seem redundant to you, too?

Thierry

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlp4m2YACgkQ3SOs138+
s6HD/g//e5A3+nHTrM4YlAnZpGcLfRY2PPmdZDiVqRQqdCGyHb/F5/HeqrUe0UAb
IPrMfG9sRlTQ/wa2EbHNpiHh2CR6Jbi40/gCXYhNZfrMIgGh0BOcbTxM9kJT91Nt
WeYpZz5oSEbDRzHRRjtXJidPxi57q2Z2P3Bh6selfsneiH4/2lm0Ruz+9FLZEZL0
yvAW6yDNfsrwl52aSV1LuoqW2HXC8wuR/k4dAho7cWk0aQ6m/0ut9Guo+Ct1iXY7
p7lvJtR7N3pRfKIbEZUy/slNghslGi+4E9Bv8SFc6DChuBS1djq/yL7/quuKTB4k
H8fu5aG1ejIveBlBeYxtCZ+9AFcsParNS7nkQKFmB7l69j+QbN07bMudkcVp+iDj
QSo16WGNTnC6mXU9aYq0DS7ii+Lfg5a20bB21J2j7npKyFwHOMG+Y7upuzYOuntN
T6EubAB2UZzRfbCW9virvORz4/1vt3jrU9+QBmjGdDQuVWAFLUwwfcv63sf9ggH1
OopDJPBZCMRWu8Qfs6kwxsDej/s65cxCtNozmDoWrDrBJ55h5ws2eHbhl7dFAL4r
vZtvKSBjGMzFhBgeXVmQ0y+pQ/OT0maVI7BLhap/ySMT94Yc7/+mBSBLrePQacKR
ate3DgmS9vtCf8LkM4auq7M6EEpKlEqxFISPwjqzl2tYoNqPPFQ=
=MqSi
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
