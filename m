Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932577AbeE3Xcm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 19:32:42 -0400
Received: from ozlabs.org ([203.11.71.1]:50807 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753734AbeE3Xcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 19:32:41 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 31 May 2018 09:32:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: linux-next: manual merge of the powerpc tree with the kbuild tree
Message-ID: <20180531093216.5c91aa2b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Ru_ne_nrKN=hqgwpUNXRDNB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ru_ne_nrKN=hqgwpUNXRDNB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  arch/powerpc/kernel/module_64.c

between commit:

  06aeb9e3f2bc ("powerpc/kbuild: move -mprofile-kernel check to Kconfig")

from the kbuild tree and commit:

  250122baed29 ("powerpc64/module: Tighten detection of mcount call sites w=
ith -mprofile-kernel")

from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/kernel/module_64.c
index 55bccc315e1a,f7667e2ebfcb..000000000000
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@@ -462,9 -466,12 +466,12 @@@ static unsigned long stub_for_addr(cons
  	return (unsigned long)&stubs[i];
  }
 =20
 -#ifdef CC_USING_MPROFILE_KERNEL
 +#ifdef CONFIG_MPROFILE_KERNEL
- static bool is_early_mcount_callsite(u32 *instruction)
+ static bool is_mprofile_mcount_callsite(const char *name, u32 *instructio=
n)
  {
+ 	if (strcmp("_mcount", name))
+ 		return false;
+=20
  	/*
  	 * Check if this is one of the -mprofile-kernel sequences.
  	 */

--Sig_/Ru_ne_nrKN=hqgwpUNXRDNB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsPNIAACgkQAVBC80lX
0GySDwf+KMfNFbnc+SDtymp5YdW9K61AWysy5duqE7dY2up0PK8jZC+7NwLEcJex
ZVHRK9tmmLSvCfH3sJ8615NNlJUfIgsmL/w8xaNtu+EDIE8uh/wtSweXDqaewdDA
S7DDzF28Z9CsKPMKQQWEzXZSFi2tGdVznRa3IcSgHsdIVCBlD+RFeWlvhAF/5KIG
sLTdBo0JfTCMLFrXZtpALcFe2V88HDLA1KUpd8oHyjFaHq/1QROYLEV6aF/HLHb5
nvpmV7fa+QzJHHEFJuP+Eikindx6YyyQLGXNNis8Ey7WB98vdFuEe/UK0wmywPy4
j1KXufYi517zjxbVvZ72NYKCxc5QVA==
=x/mn
-----END PGP SIGNATURE-----

--Sig_/Ru_ne_nrKN=hqgwpUNXRDNB--
