Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751670AbeCTXes (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 19:34:48 -0400
Received: from ozlabs.org ([103.22.144.67]:60209 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751515AbeCTXer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 19:34:47 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 21 Mar 2018 10:34:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Khalid Aziz <khalid.aziz@oracle.com>
Subject: linux-next: manual merge of the sparc-next tree with the arm64 tree
Message-ID: <20180321103408.49e62310@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xelN5VzTy5GEMv40EPAOBoo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xelN5VzTy5GEMv40EPAOBoo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

Today's linux-next merge of the sparc-next tree got a conflict in:

  arch/x86/kernel/signal_compat.c

between commit:

  266da65e9156 ("signal: Add FPE_FLTUNK si_code for undiagnosable fp except=
ions")

from the arm64 tree and commit:

  d84bb709aa4a ("signals, sparc: Add signal codes for ADI violations")

from the sparc-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/kernel/signal_compat.c
index d2884e951bb5,838a4dc90a6d..000000000000
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@@ -26,8 -26,8 +26,8 @@@ static inline void signal_compat_build_
  	 * new fields are handled in copy_siginfo_to_user32()!
  	 */
  	BUILD_BUG_ON(NSIGILL  !=3D 11);
 -	BUILD_BUG_ON(NSIGFPE  !=3D 13);
 +	BUILD_BUG_ON(NSIGFPE  !=3D 14);
- 	BUILD_BUG_ON(NSIGSEGV !=3D 4);
+ 	BUILD_BUG_ON(NSIGSEGV !=3D 7);
  	BUILD_BUG_ON(NSIGBUS  !=3D 5);
  	BUILD_BUG_ON(NSIGTRAP !=3D 4);
  	BUILD_BUG_ON(NSIGCHLD !=3D 6);

--Sig_/xelN5VzTy5GEMv40EPAOBoo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqxmnAACgkQAVBC80lX
0GxDbQf+Ln9ODONtb5cYvaYlHsL+eBUbncVaSG/WGwAhuNOhwg1YP9FPlNEleOvX
89zlt3y65wi3B+QgRP7MGh4FxCWJLLlhILbrNpfFYYZETpGnZUemFnluqnlX+Hcx
faPBcHv01sPuVhN0dWQGMAFQmav4duTDSs6wwD9UaZq05wPCJqw55bdkMbGV54rw
yOZbXEiPyWQw3EeKgm+oMKT0JxnLdvCpp7y/xY80jEY0NhHeVJ2Oz4rBIRVQHwBa
ZNAoSZlgmZnk/cJFcz/GXZpUBb2sqWOg8Ju2mMvSJ2SWLgqpDDs/erH5pb+e7c0A
iJxTMh9FWB72fw7pgzyW6m0lwYpSXA==
=XtU2
-----END PGP SIGNATURE-----

--Sig_/xelN5VzTy5GEMv40EPAOBoo--
