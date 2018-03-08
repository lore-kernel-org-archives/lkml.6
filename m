Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934506AbeCHAsR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 19:48:17 -0500
Received: from ozlabs.org ([103.22.144.67]:53055 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933935AbeCHAsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 19:48:16 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 8 Mar 2018 11:47:54 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@linux.ie>, DRI <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: linux-next: manual merge of the drm tree with the drm-misc-fixes
 tree
Message-ID: <20180308114754.139c45bf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/c7CLoHS8jabwDQ+JQRQ=e8F"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/c7CLoHS8jabwDQ+JQRQ=e8F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/sun4i/sun4i_tcon.c

between commit:

  e742a17cd360 ("drm/sun4i: tcon: Reduce the scope of the LVDS error a bit")

from the drm-misc-fixes tree and commit:

  34d698f6e349 ("drm/sun4i: Add has_channel_0 TCON quirk")

from the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/sun4i/sun4i_tcon.c
index 2de586b7c98b,0d6c5ed44795..000000000000
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@@ -1143,11 -1155,15 +1164,16 @@@ static const struct sun4i_tcon_quirks s
  };
 =20
  static const struct sun4i_tcon_quirks sun8i_a83t_lcd_quirks =3D {
+ 	.has_channel_0		=3D true,
 +	.supports_lvds		=3D true,
  };
 =20
+ static const struct sun4i_tcon_quirks sun8i_a83t_tv_quirks =3D {
+ 	.has_channel_1		=3D true,
+ };
+=20
  static const struct sun4i_tcon_quirks sun8i_v3s_quirks =3D {
- 	/* nothing is supported */
+ 	.has_channel_0		=3D true,
  };
 =20
  /* sun4i_drv uses this list to check if a device node is a TCON */

--Sig_/c7CLoHS8jabwDQ+JQRQ=e8F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqgiDoACgkQAVBC80lX
0Gzl3Qf+N9w7amVhbRjbNX9gPYWr0V8DpSWyLwKxyTgo/RWLPSq702l78cgYjWdL
p8QNziACmrPx9Ef8QN5L0cJAJATkFwRbRKXwfxy90yZi0N758EvpLt+Cq9Sbils4
Ac1tGKP3XPu0cXnWTZEOuihk+NVCy2zQJHBcGtsL7ynPBbSItGHuLuT8Tx3ijCvO
3/CUxCHunKzIy4lx1dTx+Zk9mH/7+345nfz6Za31tpTnPtakCIvj+EsowKCjGudc
+fFPmsOOG2xKy/1rgijucylK5LKXK8CpNe4qwGLEE7AXcJ4oRCnnNiuAOVwhWcS3
7RMwB2lncBVH7EFwvoBKyTUxapQi+w==
=xSRh
-----END PGP SIGNATURE-----

--Sig_/c7CLoHS8jabwDQ+JQRQ=e8F--
