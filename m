Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932805AbeCEXwh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 18:52:37 -0500
Received: from ozlabs.org ([103.22.144.67]:54757 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932084AbeCEXwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 18:52:35 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 6 Mar 2018 10:52:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Liviu Dudau <Liviu.Dudau@arm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: linux-next: manual merge of the mali-dp tree with the drm-misc tree
Message-ID: <20180306105201.562aa149@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/w6UMv.4asVBVgjO9/G4a.Wm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/w6UMv.4asVBVgjO9/G4a.Wm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Liviu,

Today's linux-next merge of the mali-dp tree got a conflict in:

  drivers/gpu/drm/arm/malidp_planes.c

between commit:

  81af63a4af82 ("drm: Don't pass clip to drm_atomic_helper_check_plane_stat=
e()")

from the drm-misc tree and commit:

  4968211e7b8f ("drm: mali-dp: Uninitialized variable in malidp_se_check_sc=
aling()")

from the mali-dp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/arm/malidp_planes.c
index ee32361c87ac,b2d11df6b5e1..000000000000
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@@ -147,7 -147,13 +146,9 @@@ static int malidp_se_check_scaling(stru
  	if (!crtc_state)
  		return -EINVAL;
 =20
 -	if (crtc_state->enable)
 -		drm_mode_get_hv_timing(&crtc_state->mode,
 -				       &clip.x2, &clip.y2);
 -
+ 	mc =3D to_malidp_crtc_state(crtc_state);
+=20
 -	ret =3D drm_atomic_helper_check_plane_state(state, crtc_state, &clip,
 +	ret =3D drm_atomic_helper_check_plane_state(state, crtc_state,
  						  0, INT_MAX, true, true);
  	if (ret)
  		return ret;

--Sig_/w6UMv.4asVBVgjO9/G4a.Wm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqd2CEACgkQAVBC80lX
0GwHiggAmC2CiY8TcYow3sqv67EosXBCmtZebHu+/G2mEYRlBWV+mQnDetgGpSaR
JXbzcAILmMrn4XdN0fyt0G14I7Gb78xjCxin8227km04fdv90CcqoZ2ydMdmrjEl
WmM1hgno2eVkVh8c6Z6aueSZPwskI7Vjttwrjq3OO6rSEXbB3mvnW24l0g0oaJwn
p4qvNRpBlwBVMT3R55WrhaFuMBoC5YfTo1Ro8o6ACnftDrSsJ6D7gz1wEPJOfLzu
QPpBqm4NLjQB1ST+3QBcuqupwMdRzRy5xljY0+wpCvLKScF2tknhB7SrphcqCmVK
jO5YNrycdspIlnvKuLOGdJkQq11Dgw==
=2DrE
-----END PGP SIGNATURE-----

--Sig_/w6UMv.4asVBVgjO9/G4a.Wm--
