Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeDEAmW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 20:42:22 -0400
Received: from ozlabs.org ([103.22.144.67]:46779 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752582AbeDEAmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 20:42:21 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 5 Apr 2018 10:41:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: David Miller <davem@davemloft.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: linux-next: manual merge of the sparc-next tree with the arm64
 tree
Message-ID: <20180405104124.10695ee0@canb.auug.org.au>
In-Reply-To: <20180321103408.49e62310@canb.auug.org.au>
References: <20180321103408.49e62310@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fKO8QIT9t/eUiBCb0sVSha6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fKO8QIT9t/eUiBCb0sVSha6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 21 Mar 2018 10:34:08 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the sparc-next tree got a conflict in:
>=20
>   arch/x86/kernel/signal_compat.c
>=20
> between commit:
>=20
>   266da65e9156 ("signal: Add FPE_FLTUNK si_code for undiagnosable fp exce=
ptions")
>=20
> from the arm64 tree and commit:
>=20
>   d84bb709aa4a ("signals, sparc: Add signal codes for ADI violations")
>=20
> from the sparc-next tree.
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
> diff --cc arch/x86/kernel/signal_compat.c
> index d2884e951bb5,838a4dc90a6d..000000000000
> --- a/arch/x86/kernel/signal_compat.c
> +++ b/arch/x86/kernel/signal_compat.c
> @@@ -26,8 -26,8 +26,8 @@@ static inline void signal_compat_build_
>   	 * new fields are handled in copy_siginfo_to_user32()!
>   	 */
>   	BUILD_BUG_ON(NSIGILL  !=3D 11);
>  -	BUILD_BUG_ON(NSIGFPE  !=3D 13);
>  +	BUILD_BUG_ON(NSIGFPE  !=3D 14);
> - 	BUILD_BUG_ON(NSIGSEGV !=3D 4);
> + 	BUILD_BUG_ON(NSIGSEGV !=3D 7);
>   	BUILD_BUG_ON(NSIGBUS  !=3D 5);
>   	BUILD_BUG_ON(NSIGTRAP !=3D 4);
>   	BUILD_BUG_ON(NSIGCHLD !=3D 6);

This is now a conflict between the adm64 tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/fKO8QIT9t/eUiBCb0sVSha6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrFcLQACgkQAVBC80lX
0GxDYQf+NUSTrDps/TuobY2PK12cmfiZ6nsXKyZvmUsj56QwCydMkcGIpRLkqshh
rc9ztvww9tVmeo3xamOBoe4Dnk167avnKtVJkkWqG+LhR0thZHnD2A/DYd5kvCz/
sZm8rahBdklAlQ6wE8MfKCmH7Zdwm6ECatj0NDrjKy4Gxo37YtZ4yxU5/QAUeFIT
fXyWi2JvToYNFggFLurqW8Iqz5PDSK9FJd3eRTqn9MwM8GCEJwfcXDI+YUn94YBZ
0loYhW0/nLtuzaOnXyu6Eo9B6hgJPUctfWioP4/D+ClrEvQdZdCZKxeqCf+dC+1b
Y/3Za/8gi4lcn7y+zKjB8XLjWRfGYA==
=IeRE
-----END PGP SIGNATURE-----

--Sig_/fKO8QIT9t/eUiBCb0sVSha6--
