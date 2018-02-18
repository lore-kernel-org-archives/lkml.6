Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeBRXKz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 18:10:55 -0500
Received: from ozlabs.org ([103.22.144.67]:42703 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751686AbeBRXKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 18:10:53 -0500
Date: Mon, 19 Feb 2018 10:10:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@linux.ie>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: linux-next: manual merge of the drm tree with Linus' tree
Message-ID: <20180219101050.0a1514e5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/P17WcQI3Tc.MVWsW1UimB00"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P17WcQI3Tc.MVWsW1UimB00
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/i915/intel_breadcrumbs.c

between commit:

  117172c8f9d4 ("drm/i915/breadcrumbs: Ignore unsubmitted signalers")

from Linus' tree and commit:

  b7a3f33bd5ab ("drm/i915/breadcrumbs: Drop request reference for the signa=
ler thread")

from the drm tree.

These are basically identical for the conflicting section except that
the former added a line:

	GEM_BUG_ON(!i915_gem_request_completed(request));

which I left in.

I fixed it up (see above) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/P17WcQI3Tc.MVWsW1UimB00
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqKB/oACgkQAVBC80lX
0GxxNgf/ZUzIScORpShGKUS2sZtpz5ALI5/Si3ZkVsv5xBP89x1ELA5WjCvpa1ey
PigMK34/jMmXtewX8CB2IU0tQukEKRhOu7SKDT1tj9dUcHvk0iRPT5ENMCQnEFb5
5MX5G5WgJPl+i0TvxbTGSZCt0XDRaigCwmac/Gf6TR+4w6wG8SF+CYWafme9JPrD
t+UYUwj33kONOtb2FDqsWvB3IBblHMlwvbevP9o7f8GgBAKgsHOsP9Ketxpk7dmt
kVFyjtLXQYt3YGHJ1ujL7HaFlPmeBZCzcjPmwQAldet+YwWBDInbSZjdsRvMOvu5
k79R6qTl0WVP6vJAkhrimOg8O9lVhw==
=5lv5
-----END PGP SIGNATURE-----

--Sig_/P17WcQI3Tc.MVWsW1UimB00--
