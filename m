Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeC0XUY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 19:20:24 -0400
Received: from ozlabs.org ([103.22.144.67]:54519 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752647AbeC0XUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 19:20:22 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 28 Mar 2018 10:19:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>
Subject: linux-next: manual merge of the arm64 tree with the arm64-fixes
 tree
Message-ID: <20180328101911.3a07eb89@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/teGBpzZQ_oaaCeWqeg4YZp/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/teGBpzZQ_oaaCeWqeg4YZp/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm64 tree got a conflict in:

  arch/arm64/kernel/cpu_errata.c

between commit:

  e21da1c99200 ("arm64: Relax ARM_SMCCC_ARCH_WORKAROUND_1 discovery")

from the arm64-fixes tree and commit:

  c0cda3b8ee6b ("arm64: capabilities: Update prototype for enable call back=
")

from the arm64 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/kernel/cpu_errata.c
index b5a28336c077,4613e4d75c73..000000000000
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@@ -178,8 -196,8 +196,8 @@@ enable_smccc_arch_workaround_1(const st
  	case PSCI_CONDUIT_HVC:
  		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
  				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
 -		if (res.a0)
 +		if ((int)res.a0 < 0)
- 			return 0;
+ 			return;
  		cb =3D call_hvc_arch_workaround_1;
  		smccc_start =3D __smccc_workaround_1_hvc_start;
  		smccc_end =3D __smccc_workaround_1_hvc_end;
@@@ -188,8 -206,8 +206,8 @@@
  	case PSCI_CONDUIT_SMC:
  		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
  				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
 -		if (res.a0)
 +		if ((int)res.a0 < 0)
- 			return 0;
+ 			return;
  		cb =3D call_smc_arch_workaround_1;
  		smccc_start =3D __smccc_workaround_1_smc_start;
  		smccc_end =3D __smccc_workaround_1_smc_end;

--Sig_/teGBpzZQ_oaaCeWqeg4YZp/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq60W8ACgkQAVBC80lX
0GxD8gf/VsnwGnwYC4Pd2gLNMD0yN0oxqCDSrPS2N/zHuX50M5/9+OyLknPW1eyw
IFhGr7FH2qoqojnzvUG5RY9wJdyv/FxDxk8KInlZ7JJyEDH+0qwaOgvGIS6cwHuQ
ZISPQJVMyTRcodVpb7OXlj1XomR6vcSUGtgoE1AgpvFjevRQuFrCG4jrF49bwoLp
fVDgzjY4FOYT0CR46U++CjCgtnxCKDukYPAGullOPLGeh160CXIKqaXGw+SerOXT
UgNVWsH0/nqIi1rd5fo0Q2VU+On4q1UHP6yvSphLUFJOq73NiyiaoU7U5BeO7ahl
lr+u7LioUr7vMKOAZVKK4WZKxmlnlg==
=yKs/
-----END PGP SIGNATURE-----

--Sig_/teGBpzZQ_oaaCeWqeg4YZp/--
