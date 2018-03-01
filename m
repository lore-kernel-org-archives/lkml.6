Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965291AbeCAA0i (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 19:26:38 -0500
Received: from ozlabs.org ([103.22.144.67]:47901 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964824AbeCAA0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 19:26:37 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 1 Mar 2018 11:26:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: linux-next: build warnings after merge of the block tree
Message-ID: <20180301112624.652612c7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/BAg3qMi92fQlaVcNyrc4q/D"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BAg3qMi92fQlaVcNyrc4q/D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jens,

After merging the block tree, today's linux-next build (x86_64
allmodconfig) produced these warning:

In file included from drivers/misc/cardreader/rts5209.c:24:0:
include/linux/rtsx_pci.h:40:0: warning: "SG_END" redefined
 #define   SG_END   0x02
=20
In file included from include/linux/dmapool.h:14:0,
                 from include/linux/pci.h:1311,
                 from include/linux/rtsx_pci.h:26,
                 from drivers/misc/cardreader/rts5209.c:24:
include/linux/scatterlist.h:69:0: note: this is the location of the previou=
s definition
 #define SG_END  0x02UL
=20
In file included from drivers/staging/rts5208/rtsx.h:180:0,
                 from drivers/staging/rts5208/rtsx.c:28:
drivers/staging/rts5208/rtsx_chip.h:343:0: warning: "SG_END" redefined
 #define SG_END   0x02
=20
In file included from include/linux/blkdev.h:28:0,
                 from drivers/staging/rts5208/rtsx.c:23:
include/linux/scatterlist.h:69:0: note: this is the location of the previou=
s definition
 #define SG_END  0x02UL
=20

and many more the same.

Introduced by commit

  723fbf563a6a ("lib/scatterlist: Add SG_CHAIN and SG_END macros for LSB en=
codings")

--=20
Cheers,
Stephen Rothwell

--Sig_/BAg3qMi92fQlaVcNyrc4q/D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqXSLAACgkQAVBC80lX
0GyUNQf+J4KSW5Cf/k1fpiW1pNrSsAQ7vopukc3mWcZu+piP2F5MWNaYkyp6o8Zl
6N5jj04X/u0zXzIR7qag8KuE5tXd2gIR6jYb7n3zvq8msTgYbcZCx8aH3vfEYY5/
/yUYrWyqtxfFU2T7FS/b8HrI4CVajRFJHPdguDKuvJ0yv6+RNi/+SFDs5LgVBhqR
h47tyur2D7DLmGDxFp5AgGOPVNkwMFLA1WhbWLrb0y9ARofTL6sFS0/HMSBc7JHc
xIcNfByhXKsjMUz1VCf7sYH61/nM4P8jTNTU8y69f5H6QHX1+FYlV0mFcXWgqWls
xhiF+nRsuXeZ6ymrqAlCSt//4FAxiA==
=gmtV
-----END PGP SIGNATURE-----

--Sig_/BAg3qMi92fQlaVcNyrc4q/D--
