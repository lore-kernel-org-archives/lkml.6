Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeCWAoT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 20:44:19 -0400
Received: from ozlabs.org ([103.22.144.67]:49905 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751553AbeCWAoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 20:44:17 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 23 Mar 2018 11:43:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: DRI <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: linux-next: manual merge of the drm-misc tree with Linus' tree
Message-ID: <20180323114326.6cb18906@canb.auug.org.au>
In-Reply-To: <20180320120841.5b348bf4@canb.auug.org.au>
References: <20180320120841.5b348bf4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bBvXSGChN1XQTvf0F840=bf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bBvXSGChN1XQTvf0F840=bf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 20 Mar 2018 12:08:41 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the drm-misc tree got a conflict in:
>=20
>   drivers/gpu/drm/sun4i/sun4i_tcon.h
>=20
> between commit:
>=20
>   e742a17cd360 ("drm/sun4i: tcon: Reduce the scope of the LVDS error a bi=
t")
>=20
> from Linus' tree and commit:
>=20
>   6664e9dc5383 ("drm/sun4i: Add support for A80 TCONs")
>=20
> from the drm-misc tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/gpu/drm/sun4i/sun4i_tcon.h
> index abdc6ad6b384,d3a945b7bb60..000000000000
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
> @@@ -176,7 -176,7 +176,8 @@@ struct sun4i_tcon_quirks=20
>   	bool	has_channel_1;	/* a33 does not have channel 1 */
>   	bool	has_lvds_alt;	/* Does the LVDS clock have a parent other than the=
 TCON clock? */
>   	bool	needs_de_be_mux; /* sun6i needs mux to select backend */
>  +	bool	supports_lvds;   /* Does the TCON support an LVDS output? */
> + 	bool    needs_edp_reset; /* a80 edp reset needed for tcon0 access */
>  =20
>   	/* callback to handle tcon muxing options */
>   	int	(*set_mux)(struct sun4i_tcon *, const struct drm_encoder *);

This is now a conflict between the drm tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/bBvXSGChN1XQTvf0F840=bf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq0Ta4ACgkQAVBC80lX
0GxciQgAo6y4gPfV9B5LD7NpFBuM4K/EqFfSXt4zcRSIPKHkE8kAP3oQqy1ysIyM
xsDKhJVX0geHZzeePf0rTfaz3PH+/dF4CWQ6df7La5G3NFy+jGkixSJr8zQw2wz7
xO86DOw6iVQFzf+g5Dah3NXlq7IAE9FuSWdrCRzC1n/TefR/GW20eoMtWWyfDW9I
6zIgzNlIbUnli39VTV+pow4qPWD6ZpAELBbRc+gtNk+wFiEWlV+3YoCO7HoBEYoE
a6LHBku1GyJPlIDpNpBEA7YdwFGQwzTo33s99lJMQfogI7tjijBeXL/yh5I05yqA
azfbIotI0jIfpy3MGT5t8ruplyO6SA==
=46+c
-----END PGP SIGNATURE-----

--Sig_/bBvXSGChN1XQTvf0F840=bf--
