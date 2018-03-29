Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbeC2FRl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 01:17:41 -0400
Received: from ozlabs.org ([103.22.144.67]:44669 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750709AbeC2FRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 01:17:39 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 29 Mar 2018 16:16:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc: Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: linux-next: manual merge of the kvm-arm tree with the arm64
 tree
Message-ID: <20180329161644.10fcb26d@canb.auug.org.au>
In-Reply-To: <20180328160541.5b900f71@canb.auug.org.au>
References: <20180328160541.5b900f71@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3+cUiNl/hD40JntsE_I/P4O"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3+cUiNl/hD40JntsE_I/P4O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 28 Mar 2018 16:05:41 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the kvm-arm tree got a conflict in:
>=20
>   arch/arm64/kernel/cpufeature.c
>=20
> between commits:
>=20
>   143ba05d867a ("arm64: capabilities: Prepare for fine grained capabiliti=
es")
>   12eb369125ab ("arm64: cpufeature: Avoid warnings due to unused symbols")
>=20
> from the arm64 tree and commit:
>=20
>   a1efdff442ec ("arm64: cpufeatures: Drop the ARM64_HYP_OFFSET_LOW featur=
e flag")
>=20
> from the kvm-arm tree.
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
> diff --cc arch/arm64/kernel/cpufeature.c
> index 96b15d7b10a8,5b25d56bccfd..000000000000
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@@ -838,19 -826,11 +838,6 @@@ static bool has_no_hw_prefetch(const st
>   		MIDR_CPU_VAR_REV(1, MIDR_REVISION_MASK));
>   }
>  =20
> - static bool hyp_offset_low(const struct arm64_cpu_capabilities *entry,
> - 			   int __unused)
>  -static bool runs_at_el2(const struct arm64_cpu_capabilities *entry, int=
 __unused)
> --{
> - 	phys_addr_t idmap_addr =3D __pa_symbol(__hyp_idmap_text_start);
> -=20
> - 	/*
> - 	 * Activate the lower HYP offset only if:
> - 	 * - the idmap doesn't clash with it,
> - 	 * - the kernel is not running at EL2.
> - 	 */
> - 	return idmap_addr > GENMASK(VA_BITS - 2, 0) && !is_kernel_in_hyp_mode(=
);
>  -	return is_kernel_in_hyp_mode();
> --}
> --
>   static bool has_no_fpsimd(const struct arm64_cpu_capabilities *entry, i=
nt __unused)
>   {
>   	u64 pfr0 =3D read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);

This is now a conflict between the kvm tree and the arm64 tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/3+cUiNl/hD40JntsE_I/P4O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq8drwACgkQAVBC80lX
0GxPpQf/eFtcnQJX9lQJegXBKQs6Xe6TuhovRwYV5xmoL/e5keRwlA5M6k3d3IAJ
OH7zqUICY6NROOXPWP0xnC7OsviQy268/RXV7jSDD7gHVNI4WVHHM8OQU3UiEOIs
P++K1RUgB37kOOz+HEC/M40BBj4Rikln87frj+gkxWEiYmLLLEVZuGXoC9D8TRcF
Bv3tisAWZ11Xu0QNbltp+Gmndiv3rz7+Yd1MQ/TjEnEdC4XciS6kizefAoqwIuih
kXNzR7arqdf8iyaob8HAXaK4gu1u6GzCbo+uLwP9gRGl6KvPhAexJfub6A4KvCZU
o4LwyeHkhBOFj9S1I0J5SdXNgJTwhQ==
=xdhb
-----END PGP SIGNATURE-----

--Sig_/3+cUiNl/hD40JntsE_I/P4O--
