Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F853C6787D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B947420841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EB8bcx2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B947420841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbeJHJtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 05:49:47 -0400
Received: from ozlabs.org ([203.11.71.1]:48763 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725760AbeJHJtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 05:49:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42T4N45RwPz9sCV;
        Mon,  8 Oct 2018 13:40:20 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538966421;
        bh=Am3Pi3fPhr4NgkCkz44eH7sJXsFlouBh1sagvqEzfjo=;
        h=Date:From:To:Cc:Subject:From;
        b=EB8bcx2+6ZwqYG8OxnoanbOPje6PNP9YUWkCQ9A3fnIdOVwpA106hAbfHzbZVGwLv
         0JhyDdAc9lMtaYFk6MoP7E/A53FNr0AkX77Y/QlYUpAgS/4tB9JSdI2kT/KFMD3Zc9
         H0lclt9FBEwPCcvNExtIj172KcCX6FcTU0hMlDeXWDnIWRsdi+W4HM+u7Dba+MF4oS
         IE5qTn5CmPprgNyHOlNOKON/kqBvH4Z3jX9MtgSh4AfArGXt6u30YqLARHiPhEwZrG
         WqmQxfx4UWAk5Kg//8WH8Cc28WJOY6TAr0KWD1nz6w4n4NALOhxOC1gIjPlVvhcxWb
         nfR2pgMJYZGkA==
Date:   Mon, 8 Oct 2018 13:40:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: linux-next: manual merge of the tip tree with the pm tree
Message-ID: <20181008134020.790092fe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8A/3tsSoWQOAryCmuI_nxw6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8A/3tsSoWQOAryCmuI_nxw6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  drivers/idle/intel_idle.c

between commit:

  a4a008e53c9e ("intel_idle: Get rid of custom ICPU() macro")

from the pm tree and commit:

  f2c4db1bd807 ("x86/cpu: Sanitize FAM6_ATOM naming")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/idle/intel_idle.c
index 791b8a366e6e,c4bb67ed8da3..000000000000
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@@ -1066,43 -1066,46 +1066,43 @@@ static const struct idle_cpu idle_cpu_d
  	.disable_promotion_to_c1e =3D true,
  };
 =20
 -#define ICPU(model, cpu) \
 -	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (unsigned long)&cpu }
 -
  static const struct x86_cpu_id intel_idle_ids[] __initconst =3D {
 -	ICPU(INTEL_FAM6_NEHALEM_EP,		idle_cpu_nehalem),
 -	ICPU(INTEL_FAM6_NEHALEM,		idle_cpu_nehalem),
 -	ICPU(INTEL_FAM6_NEHALEM_G,		idle_cpu_nehalem),
 -	ICPU(INTEL_FAM6_WESTMERE,		idle_cpu_nehalem),
 -	ICPU(INTEL_FAM6_WESTMERE_EP,		idle_cpu_nehalem),
 -	ICPU(INTEL_FAM6_NEHALEM_EX,		idle_cpu_nehalem),
 -	ICPU(INTEL_FAM6_ATOM_BONNELL,		idle_cpu_atom),
 -	ICPU(INTEL_FAM6_ATOM_BONNELL_MID,		idle_cpu_lincroft),
 -	ICPU(INTEL_FAM6_WESTMERE_EX,		idle_cpu_nehalem),
 -	ICPU(INTEL_FAM6_SANDYBRIDGE,		idle_cpu_snb),
 -	ICPU(INTEL_FAM6_SANDYBRIDGE_X,		idle_cpu_snb),
 -	ICPU(INTEL_FAM6_ATOM_SALTWELL,		idle_cpu_atom),
 -	ICPU(INTEL_FAM6_ATOM_SILVERMONT,	idle_cpu_byt),
 -	ICPU(INTEL_FAM6_ATOM_SILVERMONT_MID,	idle_cpu_tangier),
 -	ICPU(INTEL_FAM6_ATOM_AIRMONT,		idle_cpu_cht),
 -	ICPU(INTEL_FAM6_IVYBRIDGE,		idle_cpu_ivb),
 -	ICPU(INTEL_FAM6_IVYBRIDGE_X,		idle_cpu_ivt),
 -	ICPU(INTEL_FAM6_HASWELL_CORE,		idle_cpu_hsw),
 -	ICPU(INTEL_FAM6_HASWELL_X,		idle_cpu_hsw),
 -	ICPU(INTEL_FAM6_HASWELL_ULT,		idle_cpu_hsw),
 -	ICPU(INTEL_FAM6_HASWELL_GT3E,		idle_cpu_hsw),
 -	ICPU(INTEL_FAM6_ATOM_SILVERMONT_X,	idle_cpu_avn),
 -	ICPU(INTEL_FAM6_BROADWELL_CORE,		idle_cpu_bdw),
 -	ICPU(INTEL_FAM6_BROADWELL_GT3E,		idle_cpu_bdw),
 -	ICPU(INTEL_FAM6_BROADWELL_X,		idle_cpu_bdw),
 -	ICPU(INTEL_FAM6_BROADWELL_XEON_D,	idle_cpu_bdw),
 -	ICPU(INTEL_FAM6_SKYLAKE_MOBILE,		idle_cpu_skl),
 -	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP,	idle_cpu_skl),
 -	ICPU(INTEL_FAM6_KABYLAKE_MOBILE,	idle_cpu_skl),
 -	ICPU(INTEL_FAM6_KABYLAKE_DESKTOP,	idle_cpu_skl),
 -	ICPU(INTEL_FAM6_SKYLAKE_X,		idle_cpu_skx),
 -	ICPU(INTEL_FAM6_XEON_PHI_KNL,		idle_cpu_knl),
 -	ICPU(INTEL_FAM6_XEON_PHI_KNM,		idle_cpu_knl),
 -	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		idle_cpu_bxt),
 -	ICPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	idle_cpu_bxt),
 -	ICPU(INTEL_FAM6_ATOM_GOLDMONT_X,	idle_cpu_dnv),
 +	INTEL_CPU_FAM6(NEHALEM_EP,		idle_cpu_nehalem),
 +	INTEL_CPU_FAM6(NEHALEM,			idle_cpu_nehalem),
 +	INTEL_CPU_FAM6(NEHALEM_G,		idle_cpu_nehalem),
 +	INTEL_CPU_FAM6(WESTMERE,		idle_cpu_nehalem),
 +	INTEL_CPU_FAM6(WESTMERE_EP,		idle_cpu_nehalem),
 +	INTEL_CPU_FAM6(NEHALEM_EX,		idle_cpu_nehalem),
- 	INTEL_CPU_FAM6(ATOM_PINEVIEW,		idle_cpu_atom),
- 	INTEL_CPU_FAM6(ATOM_LINCROFT,		idle_cpu_lincroft),
++	INTEL_CPU_FAM6(ATOM_BONNELL,		idle_cpu_atom),
++	INTEL_CPU_FAM6(ATOM_BONNELL_MID,	idle_cpu_lincroft),
 +	INTEL_CPU_FAM6(WESTMERE_EX,		idle_cpu_nehalem),
 +	INTEL_CPU_FAM6(SANDYBRIDGE,		idle_cpu_snb),
 +	INTEL_CPU_FAM6(SANDYBRIDGE_X,		idle_cpu_snb),
- 	INTEL_CPU_FAM6(ATOM_CEDARVIEW,		idle_cpu_atom),
- 	INTEL_CPU_FAM6(ATOM_SILVERMONT1,	idle_cpu_byt),
- 	INTEL_CPU_FAM6(ATOM_MERRIFIELD,		idle_cpu_tangier),
++	INTEL_CPU_FAM6(ATOM_SALTWELL,		idle_cpu_atom),
++	INTEL_CPU_FAM6(ATOM_SILVERMONT,		idle_cpu_byt),
++	INTEL_CPU_FAM6(ATOM_SILVERMONT_MID,	idle_cpu_tangier),
 +	INTEL_CPU_FAM6(ATOM_AIRMONT,		idle_cpu_cht),
 +	INTEL_CPU_FAM6(IVYBRIDGE,		idle_cpu_ivb),
 +	INTEL_CPU_FAM6(IVYBRIDGE_X,		idle_cpu_ivt),
 +	INTEL_CPU_FAM6(HASWELL_CORE,		idle_cpu_hsw),
 +	INTEL_CPU_FAM6(HASWELL_X,		idle_cpu_hsw),
 +	INTEL_CPU_FAM6(HASWELL_ULT,		idle_cpu_hsw),
 +	INTEL_CPU_FAM6(HASWELL_GT3E,		idle_cpu_hsw),
- 	INTEL_CPU_FAM6(ATOM_SILVERMONT2,	idle_cpu_avn),
++	INTEL_CPU_FAM6(ATOM_SILVERMONT_X,	idle_cpu_avn),
 +	INTEL_CPU_FAM6(BROADWELL_CORE,		idle_cpu_bdw),
 +	INTEL_CPU_FAM6(BROADWELL_GT3E,		idle_cpu_bdw),
 +	INTEL_CPU_FAM6(BROADWELL_X,		idle_cpu_bdw),
 +	INTEL_CPU_FAM6(BROADWELL_XEON_D,	idle_cpu_bdw),
 +	INTEL_CPU_FAM6(SKYLAKE_MOBILE,		idle_cpu_skl),
 +	INTEL_CPU_FAM6(SKYLAKE_DESKTOP,		idle_cpu_skl),
 +	INTEL_CPU_FAM6(KABYLAKE_MOBILE,		idle_cpu_skl),
 +	INTEL_CPU_FAM6(KABYLAKE_DESKTOP,	idle_cpu_skl),
 +	INTEL_CPU_FAM6(SKYLAKE_X,		idle_cpu_skx),
 +	INTEL_CPU_FAM6(XEON_PHI_KNL,		idle_cpu_knl),
 +	INTEL_CPU_FAM6(XEON_PHI_KNM,		idle_cpu_knl),
 +	INTEL_CPU_FAM6(ATOM_GOLDMONT,		idle_cpu_bxt),
- 	INTEL_CPU_FAM6(ATOM_GEMINI_LAKE,	idle_cpu_bxt),
- 	INTEL_CPU_FAM6(ATOM_DENVERTON,		idle_cpu_dnv),
++	INTEL_CPU_FAM6(ATOM_GOLDMONT_PLUS,	idle_cpu_bxt),
++	INTEL_CPU_FAM6(ATOM_GOLDMONT_X,		idle_cpu_dnv),
  	{}
  };
 =20

--Sig_/8A/3tsSoWQOAryCmuI_nxw6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu6w5QACgkQAVBC80lX
0GznBwgAkYeIY6JQ/BzLD4zoO3yuMvbrOnipnGOL/cSpDeutvnplSwbB/p2s1VG8
1DmxpdneKlOnwemxrLJaKvncSgEYi5CFk6lLss+rlotbwbhbecqkoIr1MaFCLGdn
YL72Zo3W3AMBqMH0FvhQ2JO/uuwugt3VsCYfXCz7Z2pcQb+nP/cD8JfoClB0ss6X
pTnngFtxWpTb4a1kDSIbw/cC1M6LPfcjhvPh1y0cyJpl2CdxBE0KjXrWx2+xRiKx
qCx1HTdtmcextKdnCDW+TIElF3NWnuLq4IUpof+CS5IUQxDbi8gt0CpIMlKZf1n3
sBwGil4YCQWIkdM4IAZ1aMjWcgAgFQ==
=N36b
-----END PGP SIGNATURE-----

--Sig_/8A/3tsSoWQOAryCmuI_nxw6--
