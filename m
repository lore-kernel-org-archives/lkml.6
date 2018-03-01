Return-Path: <maxime.ripard@bootlin.com>
X-Google-Smtp-Source: AG47ELufGMoZH2icDA8NLvyMmFzdvvdUVpUsZcx44oOhxtUpHi6AT8hFQ7b1yFHliZ2YplRwmxuk
ARC-Seal: i=1; a=rsa-sha256; t=1519895960; cv=none;
        d=google.com; s=arc-20160816;
        b=GOznWI41FRrQeDPTGlccN1gyuYLmPdXWjZWj8c3yWpMGeRRKv1wxLmNyXHYKcoXaCw
         eByJoEI7DM/wvsTKwxMACbJRygi2UBoh2H3uljoFwKw98h/wyrvuhActPI+HRBZtoUuS
         wpwV5TIDcH5PWGnmI/Zks3B50iJxjG4C6EORSGQ1/OT0L+iF2PKSTOmW612LRi1AQRFX
         YqN7uvlymBa6u2Uu/ojZaDJVOgAlOeIwEs1hZT2Mz6DIBhRz5s5VLGt9vouE3wlES0V+
         nkMPG2F1ohF2hIcLYdKQsfYZkF/+dNdRKw0yvBaYD91iHnOMUyXv2NzsiYMVfsQ5DDRZ
         oK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=xrvHKzy6rlXUIPR+n/KBXcq9mQnrSS9PghICAI5EwsE=;
        b=Hw5VR+jhiuVV5No1GBH2czNJ+8EizmLlppGIWS4ngSyaeOcs9ue8kg3JA4pyJCGKXq
         rrZR70H1j1oJZyPAYwq/Yt5WZEKaxF46FUKHD/wbC3y969QauulYa6K/6tXOd85Xz2ko
         Ao3m103jKXM2HS/m+mTCdNBYxLX3c7EUVyWnsosjYpsllseGyo9qpoNixJ9YXCNiVmPL
         lB++KRlE+5YOaBQB1KGw7b6q0xVRZIkCKxmCDbUxHBMdXehpn2nH3DMh89bRqB0lxhse
         UWp0KjDDtGPuklKAjNa9/ldkidPo8K3XVZo/vx6Xbs2kkYjPIS/TLg4iWCj/Hexmt763
         vtMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of maxime.ripard@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=maxime.ripard@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of maxime.ripard@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=maxime.ripard@bootlin.com
Date: Thu, 1 Mar 2018 10:19:08 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
	Jernej Skrabec <jernej.skrabec@siol.net>,
	Icenowy Zheng <icenowy@aosc.io>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Liu <net147@gmail.com>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/sun4i: link in front-end code if needed
Message-ID: <20180301091908.zcptz3ezqr2c6ly5@flea>
References: <20180223131112.715992-1-arnd@arndb.de>
 <20180226092129.t4uogg2q7jkeolbu@flea.lan>
 <CAK8P3a1w=hLzZLPe1TURPyyu5oxpG8yD0eb_8GrVviUODy0zqQ@mail.gmail.com>
 <20180226105359.k5a3rz2wow4gweba@flea.lan>
 <CAGb2v64RKGMMMF+KZdfVq6BgheAYSJYmb=kg_a0hSp153hNT2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ohkkp44po5ae327o"
Content-Disposition: inline
In-Reply-To: <CAGb2v64RKGMMMF+KZdfVq6BgheAYSJYmb=kg_a0hSp153hNT2Q@mail.gmail.com>
User-Agent: NeoMutt/20180223
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593197807586940998?=
X-GMAIL-MSGID: =?utf-8?q?1593726426702943231?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--ohkkp44po5ae327o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 06:55:49PM +0800, Chen-Yu Tsai wrote:
> On Mon, Feb 26, 2018 at 6:53 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Mon, Feb 26, 2018 at 10:31:51AM +0100, Arnd Bergmann wrote:
> >> On Mon, Feb 26, 2018 at 10:21 AM, Maxime Ripard
> >> <maxime.ripard@bootlin.com> wrote:
> >> > Hi,
> >> >
> >> > On Fri, Feb 23, 2018 at 02:06:52PM +0100, Arnd Bergmann wrote:
> >> >> When the base sun4i DRM driver is built-in but the back-end is
> >> >> a loadable module, we run into a link error:
> >> >>
> >> >> drivers/gpu/drm/sun4i/sun4i_drv.o: In function `sun4i_drv_probe':
> >> >> sun4i_drv.c:(.text+0x60c): undefined reference to `sun4i_frontend_o=
f_table'
> >> >>
> >> >> The dependency is a bit tricky, the best workaround I have come up
> >> >> with is to use a Makefile hack to to interpret both
> >> >> CONFIG_DRM_SUN4I_BACKEND=3Dm and CONFIG_DRM_SUN4I_BACKEND=3Dy
> >> >> as a directive to build the front-end the same way as the main modu=
le.
> >> >>
> >> >> Fixes: dd0421f47505 ("drm/sun4i: Add a driver for the display front=
end")
> >> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> >> ---
> >> >>  drivers/gpu/drm/sun4i/Makefile | 5 ++++-
> >> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i=
/Makefile
> >> >> index 582607c0c488..db14e023256b 100644
> >> >> --- a/drivers/gpu/drm/sun4i/Makefile
> >> >> +++ b/drivers/gpu/drm/sun4i/Makefile
> >> >> @@ -25,6 +25,9 @@ obj-$(CONFIG_DRM_SUN4I)             +=3D sun4i-tc=
on.o
> >> >>  obj-$(CONFIG_DRM_SUN4I)              +=3D sun4i_tv.o
> >> >>  obj-$(CONFIG_DRM_SUN4I)              +=3D sun6i_drc.o
> >> >>
> >> >> -obj-$(CONFIG_DRM_SUN4I_BACKEND)      +=3D sun4i-backend.o sun4i-fr=
ontend.o
> >> >> +obj-$(CONFIG_DRM_SUN4I_BACKEND)      +=3D sun4i-backend.o
> >> >> +ifdef CONFIG_DRM_SUN4I_BACKEND
> >> >> +obj-$(CONFIG_DRM_SUN4I)              +=3D sun4i-frontend.o
> >> >> +endif
> >> >
> >> > Can we just create a Kconfig symbol, selected by DRM_SUN4I_BACKEND,
> >> > and we would export the symbol?
> >>
> >> Yes, I think that would work just as well. Something like
> >>
> >> config DRM_SUN4I_FRONTEND
> >>       tristate
> >>       default DRM_SUN4I if CONFIG_DRM_SUN4I_BACKEND !=3D n
> >>
> >> should do the trick.
> >
> > I had more something like this in mind:
> > https://pastebin.com/raw/XydvzAtz
>=20
> This doesn't solve the issue at hand, which is sun4i-drv (CONFIG_DRM_SUN4=
I)
> requires something in sun4i-backend (CONFIG_DRM_SUN4I_BACKEND), and if
> sun4i-drv is built-in, then anything it uses must also be built-in.

Ah, right. Then I guess Arnd's suggestion is the best we can
have. Arnd, can you resubmit that patch?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ohkkp44po5ae327o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqXxYsACgkQ0rTAlCFN
r3T/NA//TL9bvkhKa91HWj3wRC6m8fHdwPaRdtIcW56+YEi8YVDPy8mb+HmFs9Oz
5QqmMCesVq/X2Mcg4hrCfyObpom+rrcz8X8ed3F6Ati2Z/P6s/ZdZxM1Tf3gyj9/
xb15a4fOxCrVYpsEwVeGuRWTPDNMqrbEhJwLUBNKMcNd9y78lHZ6cPISIQxQ/+dF
MNOj+0VOVd9jeYNEtQcsBm2DA0LqALiFrxNtWRGNgm6VBfHA+kquMdPyItCeRwxk
Hhm7BDkL71AcZqvvZBLZNhGzcL3iFKC4dJ1ZUJGDYaMIZHYKqPtE4GYFnzPNUs4J
g0slnzw9QwSvkBzqxtFAywcixv/jTEWjLPjUcO1is+BnbZs7YJ6vLgAKZmsBW1ON
D1YBILz4nAyEspdYcBjF8m4uF6uf8aHWobus6yc2iwOZSd5LiSV7/yqXiRa5B8xv
slkIOJ92T+k2jUudu6q34EroOHZcLz5L3xSI5y1iDEMiW+AGm3Grm7Dl9JWNmW2i
XSVdJG9ze4L1EQ5TSv6dLpZrOpywsRxG9nPlhbKRPhxjr7Kx9bq3eyDxCVycevf5
fzVmgem14+tyTNbhtL6vrf27WeBLSo64ybvEtm28erw0QJpDJJp0HgnvrEFlQD6j
zioKaEmomkQckLUu/2G9AyrrxsEtXCzTsQkKZ1UNsQj4ukfvnRI=
=MSo0
-----END PGP SIGNATURE-----

--ohkkp44po5ae327o--
