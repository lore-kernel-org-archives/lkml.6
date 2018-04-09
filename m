Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeDIDRV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 23:17:21 -0400
Received: from ozlabs.org ([103.22.144.67]:46007 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751526AbeDIDRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 23:17:19 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 9 Apr 2018 13:16:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>
Subject: linux-next: build failure after merge of the nvdimm tree
Message-ID: <20180409131619.0bc5fb45@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5hwoHcGrw4QE8IXDvwO3B+y"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5hwoHcGrw4QE8IXDvwO3B+y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan,

After merging the nvdimm tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: "of_node_to_nid" [drivers/nvdimm/of_pmem.ko] undefined!

Caused by commit

  717197608952 ("libnvdimm: Add device-tree based driver")

X86 seems to not have a version of of_node_to_nid() even though CONFIG_OF
and CONFIG_NUMA are both 'y' in this build.

I have used the nvdimm tree from next-20180406 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/5hwoHcGrw4QE8IXDvwO3B+y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrK2wQACgkQAVBC80lX
0GyZoQf+KEOKWub2lWSqItFYQpcFmrCVWdp/5A+I3QG4GTZvq1e1MDVmgZVcgOS8
uRlkOMLWBiHVDeP2vH//UraJiMc+8kEFNNUKVQ7waEdZeBZ8ocidZVobQ4CghAL+
1DbbBNwoGaDB6fAR5UfYEboz6mtGnR65bS0jbLyyHs3jLEiKjlWgQAE80aaHB5Ts
aWoIKefZGolth+lxkH5z1dzMDc141pzTfCwI6XwjVtN+lXQ1SavGFW/kzSI47roK
MFXf7qkL+qjGjXDwJ0FEvB4XiAECpWYHOI0FqLg0P/IKVx5fx8gc8VwXUF2oVmuF
D5ey9piew20WD2BW07c2NJKlB4bnZA==
=E15y
-----END PGP SIGNATURE-----

--Sig_/5hwoHcGrw4QE8IXDvwO3B+y--
