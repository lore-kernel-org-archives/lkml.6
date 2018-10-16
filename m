Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45869C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE38204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE38204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeJPVp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:45:56 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:38630 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPVpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:45:55 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 9ADBFBFE9C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 15:55:19 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 1BD94C1026; Tue, 16 Oct 2018 15:55:19 +0200 (CEST)
Received: from collins (unknown [192.168.1.1])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id 58B19C101E;
        Tue, 16 Oct 2018 15:55:11 +0200 (CEST)
Message-ID: <9f96548a1b79f841130f3bf31b6eae8966fe0baf.camel@paulk.fr>
Subject: Re: [PATCH 04/10] drm/sun4i: Explicitly list and check formats
 supported by the backend
From:   Paul Kocialkowski <contact@paulk.fr>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Date:   Tue, 16 Oct 2018 15:55:40 +0200
In-Reply-To: <20180329075621.it3xltsqw4tbgeyu@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
         <20180321152904.22411-5-paul.kocialkowski@bootlin.com>
         <20180323100330.2sijtsp5bdyyel5a@flea>
         <1522138128.1110.11.camel@bootlin.com>
         <20180329075621.it3xltsqw4tbgeyu@flea>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-hCWXvblWWxxaYsvlGiZv"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hCWXvblWWxxaYsvlGiZv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le jeudi 29 mars 2018 =C3=A0 09:56 +0200, Maxime Ripard a =C3=A9crit :
> On Tue, Mar 27, 2018 at 10:08:48AM +0200, Paul Kocialkowski wrote:
> > On Fri, 2018-03-23 at 11:03 +0100, Maxime Ripard wrote:
> > > On Wed, Mar 21, 2018 at 04:28:58PM +0100, Paul Kocialkowski wrote:
> > > > In order to check whether the backend supports a specific format, a=
n
> > > > explicit list and a related helper are introduced.
> > > >=20
> > > > They are then used to determine whether the frontend should be used
> > > > for
> > > > a layer, when the format is not supported by the backend.
> > > >=20
> > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > ---
> > > >  drivers/gpu/drm/sun4i/sun4i_backend.c | 48
> > > > ++++++++++++++++++++++++++++++++++-
> > > >  drivers/gpu/drm/sun4i/sun4i_backend.h |  1 +
> > > >  2 files changed, 48 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > > b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > > index 274a1db6fa8e..7703ba989743 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > > @@ -172,6 +172,39 @@ static int
> > > > sun4i_backend_drm_format_to_layer(u32 format, u32 *mode)
> > > >  	return 0;
> > > >  }
> > > > =20
> > > > +static const uint32_t sun4i_backend_formats[] =3D {
> > > > +	/* RGB */
> > > > +	DRM_FORMAT_ARGB4444,
> > > > +	DRM_FORMAT_RGBA4444,
> > > > +	DRM_FORMAT_ARGB1555,
> > > > +	DRM_FORMAT_RGBA5551,
> > > > +	DRM_FORMAT_RGB565,
> > > > +	DRM_FORMAT_RGB888,
> > > > +	DRM_FORMAT_XRGB8888,
> > > > +	DRM_FORMAT_BGRX8888,
> > > > +	DRM_FORMAT_ARGB8888,
> > > > +	/* YUV422 */
> > > > +	DRM_FORMAT_YUYV,
> > > > +	DRM_FORMAT_YVYU,
> > > > +	DRM_FORMAT_UYVY,
> > > > +	DRM_FORMAT_VYUY,
> > >=20
> > > Ordering them by alphabetical order would be better.
> >=20
> > Frankly I find it a lot harder to read when the formats are not grouped
> > by "family". This is the drm_fourcc enumeration order, which has some
> > kind of logic behind it. What is the advantage of alphabetical ordering
> > here?
>=20
> It's self-sufficient and self-explanatory. The sorting here, while it
> would make sense lack both: you need to refer to the drm_fourcc.h file
> to get the sorting right (which makes it harder to edit and review,
> and thus more error prone), and it assumes that the editor knows about
> that sorting in the first place.
>=20
> And it's an assumption we can't really make, since some people will
> edit that structure in the first place without any background at all
> with DRM, or even graphics in general.
>=20
> While the assumption you have to make for the alphabetical order is
> that one knows the latin alphabet, which is a pretty obvious one when
> you're doing C programming.
>=20
> > > > +	 */
> > > > +	if (!sun4i_backend_format_is_supported(fb->format->format))
> > > > +		return true;
> > >=20
> > > Even though there's a comment, this is not really natural. We are
> > > checking whether the frontend supports the current plane_state, so it
> > > just makes more sense to check whether the frontend supports the
> > > format, rather than if the backend doesn't support them.
> >=20
> > The rationale behind this logic is that we should try to use the backen=
d
> > first and only use the frontend as a last resort. Some formats are
> > supported by both and checking that the backend supports a format first
> > ensures that we don't bring up the frontend without need.
>=20
> You can achieve pretty much the same thing by doing:
>=20
> if (!sun4i_frontend_format_is_supported())
> 	return false;
>=20
> if (!using_scaling)
> 	return false;
>=20
> if (using_2x_or_4x_scaling)
> 	return false;
>=20
> return true;
>=20
> This is really about whitelisting vs blacklisting, so I'm not sure
> what that would really change in the case you described above.

These sequential tests for blacklisting don't fit the bill here. For
instance, it would always return false when not using scaling for a
format supported only by the frontend, while we'd need to use the
frontend for it.

We still need to know whether the format is supported or not for both
the frontend or the backend, because one is not sufficient to describe
the other and both are involved in the decision to use the frontend.

That is, the set of formats supported by the frontend is not the=20
complementary of the sets of formats supported by the backend (some
formats are supported by both), so we can't exchange one with the
negation of the other in the initial statement.

I agree with the inital comment though, that it seems more natural to
check that the frontend supports a format first.

I think the following combination would be the most comprehensive:

if (!sun4i_frontend_format_is_supported())
	return false;

if (!sun4i_backend_format_is_supported())
	return true;

if (using_2x_or_4x_scaling)
	return false;

if (using_scaling)
	return true;

return false;

What do you think?

Cheers,

Paul

--=20
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

--=-hCWXvblWWxxaYsvlGiZv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlvF7dwACgkQhP3B6o/u
lQx23g/+NGQ/Fk5iDrpAWYpTQCx7gKpkzbCxt6dLn48fm3lcS4ngZ0V2/8QMkPw6
EYUERF6yo6o148Uvc5VoHr529mNTw9jq9I/SLR1pImiFEmW+SOkwq5J/DJD0AZbg
QGrDzPZtCGK3DlmmlnFiFLVErqoN5aPwh2GcQYEm2X0wYrSmHdIg7oMqYDgR/uZO
sc4bdYNmrzqDZkKmHN8ZogtSoryv6qvDAXRIqCPBdvx/QEmAMBAHtjORmVwVuDeV
4Xi5OBbNc5EGxmSbYzurKT4o7F8Rmzgx07hWjw0iZS8LRx2iSjB8jyxfnorTOlYp
pEN5iqkqrg2faDZN0kS/DL6jUWxjHdWc84pZnWLuukIzDImBerG4WV+53kNIwDYI
2+ct4sPYFjIkhWo8KAZTbfeai6WQaQhpaqB1YgkU19eWRfCsqQJOurLzzvf5MFen
bLBcDGFjU1zTQelJ+ZmAVT7/tYDC3OUpuKoCh9y0CeSd/VwhyzcdRlhJrv+MLBa2
bEIU6CRo3v9r1QVqTkqvIa2OEKsJmxkfjkahkZ1BCNvhbQjwOyllO+bCN4Q1wP2i
XYhnTamx7ki9nV6bHlG6GRfHlTmY3X3VEwUG5zYsbTxntP/ija98pOVkhKTGcEau
NugRL9RMQqZwLV48J6Dtb+ybJoMlHzGavaevjlySz9WVtPzj9/E=
=tlep
-----END PGP SIGNATURE-----

--=-hCWXvblWWxxaYsvlGiZv--

