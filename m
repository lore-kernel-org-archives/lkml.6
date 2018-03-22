Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeCVQTo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:19:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49131 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751319AbeCVQTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:19:41 -0400
Message-ID: <1521735513.1175.51.camel@bootlin.com>
Subject: Re: [PATCH 03/10] drm/sun4i: Don't pretend to handle ARGB8888 with
 the frontend
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Date: Thu, 22 Mar 2018 17:18:33 +0100
In-Reply-To: <20180322161204.dpi6puzvosesm5xt@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
         <20180321152904.22411-4-paul.kocialkowski@bootlin.com>
         <20180322161204.dpi6puzvosesm5xt@flea>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-u+t+ox8eIrFlVgv1hCs1"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-u+t+ox8eIrFlVgv1hCs1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2018-03-22 at 17:12 +0100, Maxime Ripard wrote:
> Hi,
>=20
> Beside the discussion with Chen-Yu,
>=20
> On Wed, Mar 21, 2018 at 04:28:57PM +0100, Paul Kocialkowski wrote:
> > It turns out that the frontend is not capable of preserving the
> > alpha
> > component (that is always set to 0xff), so only support XRGB8888
> > instead.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
>=20
> [...]
>=20
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c
> > b/drivers/gpu/drm/sun4i/sun4i_layer.c
> > index eb93df445a10..15238211a61a 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_layer.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
> > @@ -100,9 +100,9 @@ static void
> > sun4i_backend_layer_atomic_update(struct drm_plane *plane,
> >  		sun4i_frontend_update_coord(frontend, plane);
> >  		sun4i_frontend_update_buffer(frontend, plane);
> >  		sun4i_frontend_update_formats(frontend, plane,
> > -					      DRM_FORMAT_ARGB8888);
> > +					      DRM_FORMAT_XRGB8888);
> >  		sun4i_backend_update_layer_frontend(backend, layer-
> > >id, plane,
> > -						    DRM_FORMAT_ARGB
> > 8888);
> > +						    DRM_FORMAT_XRGB
> > 8888);
>=20
> Even though it's slightly related, these changes should be justified
> in the commit log. From what you currently explain, this makes 0
> difference, since XRGB and ARGB with an alpha component to 0xff is
> exactly the same thing.

The point of this is mostly to fix
sun4i_frontend_drm_format_to_input_fmt and
sun4i_frontend_drm_format_to_output_fmt, that were reporting the wrong
format (ARGB has never been supported).

The change in the internal format used between the frontend and backend
is a direct consequence of correcting the supported format, but brings
no functional change.

I will update the commit message in the next revision to make it clear
what the nature of this change is.

Thanks for the review!

Paul

--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
--=-u+t+ox8eIrFlVgv1hCs1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlqz11kACgkQ3cLmz3+f
v9Ft5Af/Z/afHbaScXXO7dowgWdS70diq+oLYr30SrdccGEORaE4Vhbqp+jU2XqS
6f1DIufQtauV7KjOGTfB2oeb0452OBUqhmWs7lI0v6zase4UaznYwUIjs0aa+Njj
ctaRn3Y4Va5PwSbDLzLPiS5NRvttQa+3JNGZr5+RzYzosJzKtu5v6DL0XCF+pSZA
el64DuHPc2W50T9asWHMGB7Eg6iRvN8jhSZAvIoRwC04lPGkoTXMsf/OnL0M/KvS
hjTxOrQZqe/i4HydJdqvjutscb76ZIw4ENjDKVHT3H+lBokH5T11wblbMsHdpyjM
RtFnRbggljUSPQsFiEf7CzCFD67R8A==
=7OUh
-----END PGP SIGNATURE-----

--=-u+t+ox8eIrFlVgv1hCs1--
