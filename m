Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753297AbeC1V7L (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 17:59:11 -0400
Received: from ozlabs.org ([103.22.144.67]:60803 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752318AbeC1V7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 17:59:10 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 29 Mar 2018 08:58:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the kbuild tree
Message-ID: <20180329085809.78af08ff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yYMVloRgW.c8.CUA3IdrAEv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yYMVloRgW.c8.CUA3IdrAEv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

After merging the kbuild tree, today's linux-next build (x86_64
allmodconfig) failed like this:

net/ipv4/netfilter/nf_nat_snmp_basic_main.c:57:10: fatal err
or: nf_nat_snmp_basic.asn1.h: No such file or directory
 #include "nf_nat_snmp_basic.asn1.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~

Presuambly caused by commit

  9ee1b1bb8743 ("kbuild: rename *-asn1.[ch] to *.asn1.[ch]")

though I am not sure why it didn't fail yesterday.

I reverted that commit (and the following one because of a conflict)
for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/yYMVloRgW.c8.CUA3IdrAEv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq8D/EACgkQAVBC80lX
0GxC0Af/USeKpvx3Nz9eaWH+MaWoUqRW1vs2C9UUIN5KrJcTiwtfnT9aUdcI7FJv
WzhoheM99d1ldjB+SfoZ3hUq5bA48BuqA2qeAihqcCJxjIpGciFBLLlNO0os68hT
f+0EaqHh3lEhSQ9HrAkhrAnGw6DvYQh5ksb2c7x5JIbnZu2kmDYrvrgBsT0cysLE
E2EDvkhSBK1Dgd2ktMeb0iUUZHuBmFtStQIYJxeKnTUoqVxG1/YihwBSOvXSbyyx
yxt61T25xNdDp5sev2ZHOqe7H/0OZlGa4ccGPfEoCk8hZYwpUyf0FrjSh+ORLh0G
EnbPqRwO2veQm2GoHfGhvzPpmRDEXw==
=cKJV
-----END PGP SIGNATURE-----

--Sig_/yYMVloRgW.c8.CUA3IdrAEv--
