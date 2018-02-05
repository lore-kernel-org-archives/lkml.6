Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753636AbeBETJf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 14:09:35 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39608 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753769AbeBETJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 14:09:05 -0500
X-Google-Smtp-Source: AH8x224vbL/qUqKImTk9LizA2LDzYeRAmErg6gG18wOsOJ0T5s0ZGSpmTSedMTcb6dycCNM/r1fPGA==
Date: Mon, 5 Feb 2018 20:08:58 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-gpio@vger.kernel.org, linux-next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: mediatek: Explicitly include pinctrl headers
Message-ID: <20180205190858.GA22699@ulmo>
References: <20180205124750.19305-1-thierry.reding@gmail.com>
 <20180205125436.24005-1-thierry.reding@gmail.com>
 <CA+55aFy--bQRDZEUsBfiWhyP+Of3+s4zEcKo1T8cCoAMXBrwsw@mail.gmail.com>
 <20180205175906.GA8237@ulmo>
 <CACRpkdYrG6=qwJgOTW2ccyq-UBSOkH+EBBui54PtGqJF7CMRDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <CACRpkdYrG6=qwJgOTW2ccyq-UBSOkH+EBBui54PtGqJF7CMRDw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2018 at 08:02:40PM +0100, Linus Walleij wrote:
> On Mon, Feb 5, 2018 at 6:59 PM, Thierry Reding <thierry.reding@gmail.com>=
 wrote:
>=20
> > Anyway, I think going with the pinctrl/devinfo.h include only is fine
> > for now. If it turns out that the Mediatek ethernet and Rockchip LVDS
> > drivers can just omit the bits fiddling with struct dev_pin_info, we can
> > swap out the pinctrl/devinfo.h include for pinctrl/consumer.h at that
> > time.
> >
> > LinusW: what are your thoughts on the struct dev_pin_info usage by these
> > drivers? Does their code seem redundant to you, too?
>=20
> I don't think they should use struct dev_pin_info at all,
> that thing is for the device core only.
>=20
> I like to think that <linux/pinctrl/consumer.h> is for drivers that
> explicitly grab and control pin control states so this driver should
> only include <linux/pinctrl/consumer.h>.
>=20
> Torvalds: can you do it like that instead? Either way will
> make the compile work again, we can also tidy it up later.
> (i.e. I will grep for includes of pinctrl/dev_info.h and replace
> it with consumer.h) at some point.

That won't work, unfortunately, because these drivers actually try to
dereference pointers to struct dev_pin_info and hence need that include
for the structure's definition. Those are the only two drivers I can see
that access this structure directly (other than the device core).

Thierry

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlp4q8gACgkQ3SOs138+
s6GGvxAAsjt1fXB20kn8sxaZdlc3k6zxoxCyig77hTSS/NTeQfhziXbCrciRbGE7
XjpWUkyWiJy/gSdW89tVbe4y4hbGlNjXf3hUqwI8CxFLH7HiVT/iNq0gIbPTspcb
glqgG4vsIywLxSd062zjmPajQmGX/VR91ssbEjZIzlVTMfvKWIohX/GLaRiSx6gB
HkD8yocJpB2ZnwrFLd1nXOKSVE6ALTK0hf3zk4SLJpqAjhM7F1wVLihsjqVjmh8I
u3L1Cd62YEyWPBmruU9nB4RBjfrA00boKt6t3VRiSRUViyR4M5qVkg/BZ97syp/q
V4gbbZ6M4ZaFg+QRuNQCEEhYg2iq8lLmTyWpxDM4PdHMFzxXx6a6tmNjtOMmvf8D
NryeqiVETkPTexA2INK+J3O7/sYspdx4EXTuR34Bc1zhTFhkSjO9mqAboVHvvcX8
e13kjtuopOumJbQzBLkpHSY7fJOIpZEhyctL17embWAmzm6GWFvdGNpdb1rB2GIP
KvL/ZZP45q8UJ8m8G7P2DojCdGOZKPARkoRm0nn1tA7E0j/nlYZ7KzAORoZIFgvR
Fbnvu0mwoi8B0i5W77PkMpcyuzeZJsCEZYaolFaRYdgVebJVJqz4Y5y2dktz8Zo2
8Xte4GCsxGkvzi0OKQnS3+z7yJXsVTlz/L4E6duAGwZUMpLv/DY=
=0Cf3
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
