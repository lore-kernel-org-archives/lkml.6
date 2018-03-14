Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbeCNKwf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 06:52:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53845 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbeCNKwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 06:52:34 -0400
X-Google-Smtp-Source: AG47ELttUH5nhfWBuUBSHC3uqIZtpq7jf+pZi8zD/qr3S7xzuUYF9YOzhin6b7LHykEmBv46aZ/06w==
Date: Wed, 14 Mar 2018 11:52:30 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Airlie <airlied@linux.ie>,
        Philippe CORNU <philippe.cornu@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/panel: rm68200: add backlight dependency
Message-ID: <20180314105230.GA8564@ulmo>
References: <20180313210015.3344380-1-arnd@arndb.de>
 <20180313230155.GC23414@mithrandir>
 <CAK8P3a3A37_q0PEXFqi2iLR_bJxW=trB3tksZqyjG5MYwaMuXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <CAK8P3a3A37_q0PEXFqi2iLR_bJxW=trB3tksZqyjG5MYwaMuXA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2018 at 09:49:54AM +0100, Arnd Bergmann wrote:
> On Wed, Mar 14, 2018 at 12:01 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Tue, Mar 13, 2018 at 09:59:54PM +0100, Arnd Bergmann wrote:
> >> Like many other panel drivers, this one fails to build
> >> when backlight support is disabled:
> >>
> >> drivers/gpu/drm/panel/panel-raydium-rm68200.o: In function `rm68200_pr=
obe':
> >> panel-raydium-rm68200.c:(.text+0x14a): undefined reference to `devm_of=
_find_backlight'
> >>
> >> This adds the appropriate dependency.
> >>
> >> Fixes: 2b7ed18bed1a ("drm/panel: Add support for Raydium RM68200 panel=
 driver")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  drivers/gpu/drm/panel/Kconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >
> > This shouldn't be necessary. include/linux/backlight.h defines a stub if
> > the backlight class is not enabled.
> >
> > What tree are you seeing this on?
>=20
> This is on linux-next.
>=20
> It must be with BACKLIGHT_CLASS_DEVICE=3Dm and
> DRM_PANEL_RAYDIUM_RM68200=3Dy, meaning that it should
> be sufficient to do
>=20
>     depends on BACKLIGHT_CLASS_DEVICE || BACKLIGHT_CLASS_DEVICE=3Dn
>=20
> to force DRM_PANEL_RAYDIUM_RM68200 to be a loadable module
> whenever BACKLIGHT_CLASS_DEVICE=3Dm. For the patch, I looked at
> what the other drivers in the same directory do and followed their
> example.
>=20
> I see three options here:
>=20
> 1. update my patch changelog with the explanation I wrote here but leave =
it
>     untouched
> 2. use the more elaborate dependency (after testing) but not change the
>     others
> 3. change all panel drivers with a backlight dependency the same way,
>     possibly with a helper symbol like
>=20
> config BACKLIGHT_CLASS_DEVICE_OPTIONAL
>          tristate
>          default m if BACKLIGHT_CLASS_DEVICE=3Dm
>          default y
>=20
>       Arnd

I went with option 1) and added some text that hopefully clarifies the
issue.

	https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3Da8efe516316472ac771=
ba3f591295c7515e46172

Thierry

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqo/usACgkQ3SOs138+
s6FYnA//V6eEr7KbIo9gFPRDOu5Oowu2JrydOtAnOEB/GzyDiO+FEZdr387RUIny
5XUSxIZS/Jv7cN3oFtsKrbHtiKkTi6DT2UQIzSGwMt9gxZZRhni9JvFVksvO7rWW
EhbrihnfFfLH0Bs/PSDV2AMwPWKC/cQilqt6AAgpCgYRVEkRyVluQoKDzMz97fXq
3GHVXQXhUDuS5ZoQkmpXnYtf80KeOe1BHcL63PcQ41YF5XQ5YJ+t2WYPQLeiKNkW
uxi9Lsy0LyfI1YSUYIK79lyHBYGjEN54yj1xL7tiIV5jBsKgLCDjrBHatr7aDP7V
3rKslFSYHkG2Rrr9tyPv2RMqFAJhwxnqxezI5sOcYkvZAwTID53aV2dmpFNaTMO4
Mk/BlVq4CxIL59MArY8SbZpv0mJM5Qy2WtPN/h5DzhWM5/Im4O3KaCSRua3c58yj
w5oIAuRk/qIKOPIMy6tjt+gjD2CrewGWFJy1S4bKOQY7tK+HCMoppF4ZF+ckM+9Y
R0yUk4nv1V8F+TDRPZbN8Mkf4JyWb3BTmcPhWBNxrAbrVDek06rfWOCx7TRGcbH3
QP8vI2gkkBVI8Vq/V7RS7kBMpHMS5mo0vH2OBzJ4isdnfHbffHVq5jcu3/Ygw7UK
Bz6Vx7YspBKuLx6ri4SGiRcP6/3l6t9f4z2iaTPCzC/pVdlvnqY=
=mX/c
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
