Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751224AbeC1FGg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 01:06:36 -0400
Received: from ozlabs.org ([103.22.144.67]:58299 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeC1FGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 01:06:34 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 28 Mar 2018 16:05:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <20180328160541.5b900f71@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=VjY42lkaS4LMKFp4zpUwi+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=VjY42lkaS4LMKFp4zpUwi+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  arch/arm64/kernel/cpufeature.c

between commits:

  143ba05d867a ("arm64: capabilities: Prepare for fine grained capabilities=
")
  12eb369125ab ("arm64: cpufeature: Avoid warnings due to unused symbols")

from the arm64 tree and commit:

  a1efdff442ec ("arm64: cpufeatures: Drop the ARM64_HYP_OFFSET_LOW feature =
flag")

from the kvm-arm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/kernel/cpufeature.c
index 96b15d7b10a8,5b25d56bccfd..000000000000
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@@ -838,19 -826,11 +838,6 @@@ static bool has_no_hw_prefetch(const st
  		MIDR_CPU_VAR_REV(1, MIDR_REVISION_MASK));
  }
 =20
- static bool hyp_offset_low(const struct arm64_cpu_capabilities *entry,
- 			   int __unused)
 -static bool runs_at_el2(const struct arm64_cpu_capabilities *entry, int _=
_unused)
--{
- 	phys_addr_t idmap_addr =3D __pa_symbol(__hyp_idmap_text_start);
-=20
- 	/*
- 	 * Activate the lower HYP offset only if:
- 	 * - the idmap doesn't clash with it,
- 	 * - the kernel is not running at EL2.
- 	 */
- 	return idmap_addr > GENMASK(VA_BITS - 2, 0) && !is_kernel_in_hyp_mode();
 -	return is_kernel_in_hyp_mode();
--}
--
  static bool has_no_fpsimd(const struct arm64_cpu_capabilities *entry, int=
 __unused)
  {
  	u64 pfr0 =3D read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);

--Sig_/=VjY42lkaS4LMKFp4zpUwi+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq7IqUACgkQAVBC80lX
0Gx9EwgAhtB95k4OAHs+vYLuZhujx/apeePo7o5lfLL3l9jKlBRXfT/S4QUEQoKw
shMlpH6YbsiQtwr95/51bjshT0zLupO72eYr3OhqHzHCJQ/RGMgg6ajmSybeV16s
9OY0H03N1MPTdUGYjbNMgAUCMuBUeA74dLWLtkVVfe/m9TfLqZ0SMtPNJVbKy8Ok
JCMIJ/KDiNPdvt+PbrpaQQKjbBQWxv09siPvKTlOxE9YExEQ8SlBtyGcy+Dv18LX
dG+nmAJfjLmrvQ0miyMTfXfVRGHcX7yfjLLZJJRxptANBDffuMjozcb7yQKXiywu
0wU/0+SVh+Ixdz03BSe84CsWiaXhag==
=voGw
-----END PGP SIGNATURE-----

--Sig_/=VjY42lkaS4LMKFp4zpUwi+--
