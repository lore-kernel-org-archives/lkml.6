Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeBZCe5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 21:34:57 -0500
Received: from ozlabs.org ([103.22.144.67]:51509 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751931AbeBZCew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 21:34:52 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 26 Feb 2018 13:34:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, Greentime Hu <green.hu@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Farhan Ali <alifm@linux.vnet.ibm.com>
Subject: linux-next: manual merge of the kvms390 tree with the nds32 tree
Message-ID: <20180226133445.6544ad34@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/dfkQ7_wa2r4qO0oWWCcB842"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dfkQ7_wa2r4qO0oWWCcB842
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvms390 tree got a conflict in:

  drivers/video/console/Kconfig

between commit:

  2312dbf7462b ("drivers/video/concole: add negative dependency for VGA_CON=
SOLE on nds32")

from the nds32 tree and commits:

  8da93aca3729 ("Kconfig : Remove HAS_IOMEM dependency for Graphics support=
")
  416b744f4494 ("s390/setup : enable display support for KVM guest")

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
index 27bb893cf6b2,b9c2c916247e..000000000000
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@@ -9,7 -9,7 +9,7 @@@ config VGA_CONSOL
  	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !FRV && \
  		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
  		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
- 		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !NDS32
 -		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && HAS_IOMEM && !S390
++		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !NDS32 && HAS_IOMEM && !S=
390
  	default y
  	help
  	  Saying Y here will allow you to use Linux in text mode through a

--Sig_/dfkQ7_wa2r4qO0oWWCcB842
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqTckUACgkQAVBC80lX
0GwjqggAobhutCauWvf9iIdFOJEpunmcYkUVNg5IEPR7lJqX6gg/nMpPeosUIi+y
pDou5qgCDFRCCt+P6QFOW5ejom+tcD2OfuG0z8u5ry0LQbwhuxnh0ZdpQ6Soynin
YqGj7cag5In0R/aXZKY8gUyplqVkLb7/s/Z3u2zYGFb1I65F5Ro+HT/bxBx/DSfu
LXX3MPWJVLUflerPOOFez8t09bRw/N6i34MRh4fYbJf4CwRA8t+6VjRzqztpcFFc
g4pOYKebwKctb7UCL4AYqlB5fnrcBqNbiVitlU85LqVCS+8+hv6zLUZYsr9Z5gv8
PYHF1QWJRhYhsZCjM6CzwRnYyq/pNw==
=heql
-----END PGP SIGNATURE-----

--Sig_/dfkQ7_wa2r4qO0oWWCcB842--
