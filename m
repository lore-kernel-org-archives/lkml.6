Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933951AbeCTBJj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 21:09:39 -0400
Received: from ozlabs.org ([103.22.144.67]:60183 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932939AbeCTBJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 21:09:35 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 20 Mar 2018 12:08:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: linux-next: manual merge of the drm-misc tree with Linus' tree
Message-ID: <20180320120841.5b348bf4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/MKwiZ/NPRU1RRJCZwW/xlc/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MKwiZ/NPRU1RRJCZwW/xlc/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/gpu/drm/sun4i/sun4i_tcon.h

between commit:

  e742a17cd360 ("drm/sun4i: tcon: Reduce the scope of the LVDS error a bit")

from Linus' tree and commit:

  6664e9dc5383 ("drm/sun4i: Add support for A80 TCONs")

from the drm-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/sun4i/sun4i_tcon.h
index abdc6ad6b384,d3a945b7bb60..000000000000
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@@ -176,7 -176,7 +176,8 @@@ struct sun4i_tcon_quirks=20
  	bool	has_channel_1;	/* a33 does not have channel 1 */
  	bool	has_lvds_alt;	/* Does the LVDS clock have a parent other than the T=
CON clock? */
  	bool	needs_de_be_mux; /* sun6i needs mux to select backend */
 +	bool	supports_lvds;   /* Does the TCON support an LVDS output? */
+ 	bool    needs_edp_reset; /* a80 edp reset needed for tcon0 access */
 =20
  	/* callback to handle tcon muxing options */
  	int	(*set_mux)(struct sun4i_tcon *, const struct drm_encoder *);

--Sig_/MKwiZ/NPRU1RRJCZwW/xlc/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqwXxkACgkQAVBC80lX
0GzLnwf/W3sKMzfVUjfXhvrlYp8Dr0cg4C0opL470C8E1A2LZ27DsRPLkTLREYPz
tfbE4f8e/i/qWGRzaHuxk+hQUO5cEn1xDg03nbigS9ntQKWrLOrKkCNIi9GWFRC3
cj2vlhS9xG+GRISoGiKwNM3hkbU5SEuvAonGVBMTxX/x9SUfSltSw3EjRx85ZiB6
kSP65hdbXU3YThax4HWsAFi4m7/NsnJqi9tiF0MfBAzvhRpY/VW625C3Z+4iiFZ9
Qeg8Peo5OSdc4hbaz8a1SG00SaK9gk/fjhX3hSZ58TgiPMSIvkfT99Pt0W1Z63AV
H2nKmy0yR9m3hwmP0xbEhBiz3bXdaw==
=vvHC
-----END PGP SIGNATURE-----

--Sig_/MKwiZ/NPRU1RRJCZwW/xlc/--
