Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeBWCJ0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 21:09:26 -0500
Received: from ozlabs.org ([103.22.144.67]:46093 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750916AbeBWCJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 21:09:24 -0500
Date: Fri, 23 Feb 2018 13:09:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, Greentime Hu <green.hu@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Farhan Ali <alifm@linux.vnet.ibm.com>
Subject: linux-next: manual merge of the kvms390 tree with the nds32 tree
Message-ID: <20180223130920.1db2c245@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/z3XI4IZlZiwixXLux8+kDwN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/z3XI4IZlZiwixXLux8+kDwN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvms390 tree got a conflict in:

  drivers/video/console/Kconfig

between commit:

  2312dbf7462b ("drivers/video/concole: add negative dependency for VGA_CON=
SOLE on nds32")

from the nds32 tree and commit:

  2f1ca75f69f3 ("s390/setup : enable display support for KVM guest")

from the kvms390 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/video/console/Kconfig
index 27bb893cf6b2,7aa721e3a581..000000000000
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@@ -9,7 -9,7 +9,7 @@@ config VGA_CONSOL
  	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !FRV && \
  		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
  		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
- 		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !NDS32
 -		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !S390
++		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !NDS32 && !S390
  	default y
  	help
  	  Saying Y here will allow you to use Linux in text mode through a

--Sig_/z3XI4IZlZiwixXLux8+kDwN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqPd9AACgkQAVBC80lX
0GwS2Af+OmtL5nygWdqyvozvkMGsBLadgClRNoqnTNwwib9gxK0IxSUK+eFMubyF
cv/NjMM9bBf9JmQP0J0nkIJJsoJjusUqgAz0PjJ/PJF0Jn+K5D7oDcM4p9990C0O
L2Afh3TQp7xf374naCJ0oHL1ityh6+WjtxWVNJR7I+YDzj0aC2aWQAhLOqmePVC/
c6mjoUMoyOeOxEsOM4O+oF/TeOn/hgEmZp8CJ0RHdhLG4zX6vZzv5vqWlpIGAbTU
auNJFrVSBRJmrhpdheSebRpzV9qxD5hqf15mZaEG/HfYIOvFPOkWTEPpwNuieqx5
E3IQzf41xach4nWBDJV6NhxLwGbpcQ==
=ytTk
-----END PGP SIGNATURE-----

--Sig_/z3XI4IZlZiwixXLux8+kDwN--
