Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752462AbeC0Ip1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:45:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37939 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752176AbeC0IpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:45:24 -0400
Message-ID: <1522140259.1110.43.camel@bootlin.com>
Subject: Re: [PATCH 02/10] drm/sun4i: Disable YUV channel when using the
 frontend and set interlace
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Date: Tue, 27 Mar 2018 10:44:19 +0200
In-Reply-To: <20180327081731.he3lhnvqffuimsi5@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
         <20180321152904.22411-3-paul.kocialkowski@bootlin.com>
         <20180323095529.5nptn5achjt3esog@flea>
         <1522137643.1110.4.camel@bootlin.com>
         <20180327081731.he3lhnvqffuimsi5@flea>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-TqBgsmTIJVY3lX8S124X"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TqBgsmTIJVY3lX8S124X
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2018-03-27 at 10:17 +0200, Maxime Ripard wrote:
> On Tue, Mar 27, 2018 at 10:00:43AM +0200, Paul Kocialkowski wrote:
> > Hi,
> >=20
> > On Fri, 2018-03-23 at 10:55 +0100, Maxime Ripard wrote:
> > > On Wed, Mar 21, 2018 at 04:28:56PM +0100, Paul Kocialkowski wrote:
> > > > The YUV channel was only disabled in
> > > > sun4i_backend_update_layer_formats,
> > > > which is not called when the frontend is selected.
> > > >=20
> > > > Thus, creating a layer with a YUV format handled by the backend
> > > > and
> > > > then
> > > > switching to a format that requires the frontend would keep the
> > > > YUV
> > > > channel enabled for the layer.
> > > >=20
> > > > This explicitly disables the YUV channel for the layer when
> > > > using
> > > > the
> > > > frontend as well. It also sets the relevant interlace bit, which
> > > > was
> > > > missing in the frontend path as well.
> > >=20
> > > This should be part of a separate patch. Usually, if you write "it
> > > also does..." at the end of your commit log, it's a pretty good
> > > indication that it should be another patch :)
> >=20
> > I must say, I figured that this part was missing in the frontend
> > path by
> > chance and couldn't really test the feature, so I'm also tempted to
> > drop
> > it altogether. What do you think?
>=20
> If you haven't been able to test it, then yeah, don't submit it.

Alright, noted.

> > Also, is interlacing actually used on any of the video outputs we
> > support? Perhaps RGB?
>
> Composite would be a better guess :)

Oh and I was wondering what CVBS was about. Now I know!
It seems that we don't support it for now apparently, anyway.

Thanks,

--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
--=-TqBgsmTIJVY3lX8S124X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlq6BGMACgkQ3cLmz3+f
v9EuTwf/ZgY6AiQawQw8GZcWQhxbI/5pi6HlkzM4ZAj6tLeIdkKO6S8tc/m4bvVv
YnoVFqBpQitrwBHzvvRhhNVdoT5+tWOhpMxZyfrhBGwCBpMJkoaNj4rCE2zdEOCR
nj1+tJ+ff/+QYmqDJkG9npdSRkFFYwsge/vMbnFi4QC2XBLD4f9ttE3DwWSRrNfb
6HvoqWTsyOsX6E7596lw5hb7pVPxVDnz/psL5JgI3MkK3NQSlwnYTqwAwX0+O+8j
343oY5cIK8palTNz6IcEE8o18mFqSLz9wa/3e71dh80afKCoPb6SFUuJr8eZL+z3
1UjNqkD1REzRB6pNnZ47qx0najarWQ==
=o2eA
-----END PGP SIGNATURE-----

--=-TqBgsmTIJVY3lX8S124X--
