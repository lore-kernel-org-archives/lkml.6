Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeCVQMK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:12:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49011 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751689AbeCVQMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:12:06 -0400
Date: Thu, 22 Mar 2018 17:12:04 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH 03/10] drm/sun4i: Don't pretend to handle ARGB8888 with
 the frontend
Message-ID: <20180322161204.dpi6puzvosesm5xt@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-4-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="doy7hfckjtsgsqwj"
Content-Disposition: inline
In-Reply-To: <20180321152904.22411-4-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--doy7hfckjtsgsqwj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Beside the discussion with Chen-Yu,

On Wed, Mar 21, 2018 at 04:28:57PM +0100, Paul Kocialkowski wrote:
> It turns out that the frontend is not capable of preserving the alpha
> component (that is always set to 0xff), so only support XRGB8888
> instead.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---

[...]

> diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/=
sun4i_layer.c
> index eb93df445a10..15238211a61a 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
> @@ -100,9 +100,9 @@ static void sun4i_backend_layer_atomic_update(struct =
drm_plane *plane,
>  		sun4i_frontend_update_coord(frontend, plane);
>  		sun4i_frontend_update_buffer(frontend, plane);
>  		sun4i_frontend_update_formats(frontend, plane,
> -					      DRM_FORMAT_ARGB8888);
> +					      DRM_FORMAT_XRGB8888);
>  		sun4i_backend_update_layer_frontend(backend, layer->id, plane,
> -						    DRM_FORMAT_ARGB8888);
> +						    DRM_FORMAT_XRGB8888);

Even though it's slightly related, these changes should be justified
in the commit log. From what you currently explain, this makes 0
difference, since XRGB and ARGB with an alpha component to 0xff is
exactly the same thing.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--doy7hfckjtsgsqwj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqz1dMACgkQ0rTAlCFN
r3S//g//RT5mB+QlYOBWWPBL9EZ3wJn0CF2PZX7Y1sH1+op/fwYkcnb62aST23Le
3wwBuhB0MNxIDrZwXDZhR4MsI2QHObSh7w3WSZpNIpwpOr/XcMg9r35FQ8H7R1Et
F767Op33Kq+B3P2EzeYFDVsPM37RMQWC68JgMHKb2oFPOmsZ1fUYhPTTy2oDaW1b
XgQch9oKxSLcOu7x440yceios7Y2WShixSaGoCT+NJnuRHGSWOKQ+E5nwakhg9R2
EUySe5NllBp9T2t4mAigxdQHVDlrPtY9KpUXsUki4CNim9mh6yW7nNRaZq6yahm4
YHiU2rPm2j/HZbLhMmOJra/br9IqiMq1RcOUIsIxchxOarD/XZwe53pwKBf/ADZr
26RdaMtx5fOMl9taP6ZwdpAkMtlwOdKUOefdwA7JP4aMeKa4G8tIAETWiVpn4LMB
Z1ZxFK0LJ0PK61z38IObpo5dOAlxsWtrJzV4c9jPyFeP0Jgy1Y4eKWjLbJTg7AYX
VcyHshb16DdTcl5d0RATNiqdT00zpx6Oy1+e3H0Fm3OPnK7IlpR/4Whb/C8ATM21
O8fKo5GLr5/Q5pfsDIQhlTUhovjeH+5lvsR/Xu2UfhC6f7vW91v0AvohdXxIgSNW
RWnnlTlm11lGGLhSMp13rLHPDwpbvicnb4smivfdAL5wC0v93H4=
=1n9b
-----END PGP SIGNATURE-----

--doy7hfckjtsgsqwj--
