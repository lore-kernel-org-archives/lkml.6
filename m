Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751859AbeBRXCZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 18:02:25 -0500
Received: from ozlabs.org ([103.22.144.67]:53473 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbeBRXCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 18:02:24 -0500
Date: Mon, 19 Feb 2018 10:02:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@linux.ie>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: linux-next: manual merge of the drm tree with Linus' tree
Message-ID: <20180219100221.2da15c53@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/acrhl4ZSM1ESndSOb845hAT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/acrhl4ZSM1ESndSOb845hAT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/i915/i915_pmu.h

between commit:

  4c83f0a788cc ("drm/i915/pmu: Fix sleep under atomic in RC6 readout")

from Linus' tree and commit:

  109ec558370f ("drm/i915/pmu: Only enumerate available counters in sysfs")

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

diff --cc drivers/gpu/drm/i915/i915_pmu.h
index bb62df15afa4,5a2e013a56bb..000000000000
--- a/drivers/gpu/drm/i915/i915_pmu.h
+++ b/drivers/gpu/drm/i915/i915_pmu.h
@@@ -96,10 -94,14 +96,18 @@@ struct i915_pmu=20
  	 * struct intel_engine_cs.
  	 */
  	struct i915_pmu_sample sample[__I915_NUM_PMU_SAMPLERS];
 +	/**
 +	 * @suspended_jiffies_last: Cached suspend time from PM core.
 +	 */
 +	unsigned long suspended_jiffies_last;
+ 	/**
+ 	 * @i915_attr: Memory block holding device attributes.
+ 	 */
+ 	void *i915_attr;
+ 	/**
+ 	 * @pmu_attr: Memory block holding device attributes.
+ 	 */
+ 	void *pmu_attr;
  };
 =20
  #ifdef CONFIG_PERF_EVENTS

--Sig_/acrhl4ZSM1ESndSOb845hAT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqKBf0ACgkQAVBC80lX
0GxrfQgAkqqbnXetbSRLCjV92RgdyN2NSfF6DmrF0h1Q8Gq25KOLW1YwAgACWakJ
Aii1O0eaLTrJTFy4qWtgpZj46IHumz89S3snkDsoxsCKyj7AEPrFWyU+v0EzEs2b
Q/dT357rxjzFDsFJHZxJoH+RzYGx1pVdqjmA3+VhsyaGQahsAtNuG6GSNfoN1lOh
kPOmC/u9GuzuHpj4FdnlrwZJ3Nm1/OUmBe2odE6MQgT2s/hjAcQEg9mE2behU7yy
JM8RaXNXljbhbnsRutoriZFNCK/E/QNPOOZjsvbK7Rj0qByuzxBFc+2hhH4tl0ri
zoF1K0SPbZE3TwenHBdrvWTNeAMn/w==
=kHbH
-----END PGP SIGNATURE-----

--Sig_/acrhl4ZSM1ESndSOb845hAT--
