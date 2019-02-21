Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3864C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913502086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="u2aA8OJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfBUGNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 01:13:36 -0500
Received: from ozlabs.org ([203.11.71.1]:38829 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfBUGNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 01:13:35 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 444kgJ4Qkjz9s2R;
        Thu, 21 Feb 2019 17:13:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550729612;
        bh=QVsEB6pCTEipcjKOhiA/JuFqpak/3Y+fUPdGn7/S0hw=;
        h=Date:From:To:Cc:Subject:From;
        b=u2aA8OJTkPmGxaQAcqKbDbGF4mBrkRIqrnBDm5eNJBac3aVF7O4P/85oKqBQZZS9A
         dxyBUSIjRL5jMeixQHMUy9YYlYQLolwcoJ6JrjXDW6mwzSmwko1AwgSL0ztxza7kym
         AZLmvBvyyell4+BSwo5ezCo3+P3vHoppxgbl7dg7ZQ1SaGvM8o4fatGWf5gp3UGYmY
         JXF1/p7xBTccxu+BVRxo+bpiDJb7z3mRW5zMBBI/QyCLlF9wnvh4rOXfOXiBkgZihy
         vPnZnbG2rc8noMtNI4neB6Oz5pTHWqWuXKDtID8c0CERh/hdAiWUS9YS7nNbJmVtgT
         +MLDW7NYV3/hA==
Date:   Thu, 21 Feb 2019 17:13:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: linux-next: build failure after merge of the xarray tree
Message-ID: <20190221171332.262cf619@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/e9dqugCWODAQ208HfahNA5W"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e9dqugCWODAQ208HfahNA5W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the xarray tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from include/linux/uio.h:12,
                 from include/linux/socket.h:8,
                 from include/rdma/rdma_cm.h:37,
                 from drivers/infiniband/core/restrack.c:6:
drivers/infiniband/core/restrack.c: In function 'rt_xa_alloc_cyclic':
include/linux/kernel.h:40:18: warning: passing argument 3 of '__xa_alloc' m=
akes pointer from integer without a cast [-Wint-conversion]
 #define U32_MAX  ((u32)~0U)
                  ^~~~~~~~~~
drivers/infiniband/core/restrack.c:26:27: note: in expansion of macro 'U32_=
MAX'
  err =3D __xa_alloc(xa, id, U32_MAX, entry, GFP_KERNEL);
                           ^~~~~~~
In file included from include/linux/radix-tree.h:31,
                 from include/linux/fs.h:15,
                 from include/linux/seq_file.h:11,
                 from arch/powerpc/include/asm/machdep.h:12,
                 from arch/powerpc/include/asm/archrandom.h:7,
                 from include/linux/random.h:166,
                 from include/linux/net.h:22,
                 from include/linux/skbuff.h:29,
                 from include/linux/if_arp.h:26,
                 from include/rdma/ib_addr.h:39,
                 from include/rdma/rdma_cm.h:39,
                 from drivers/infiniband/core/restrack.c:6:
include/linux/xarray.h:524:61: note: expected 'void *' but argument is of t=
ype 'unsigned int'
 int __must_check __xa_alloc(struct xarray *, u32 *id, void *entry,
                                                       ~~~~~~^~~~~
drivers/infiniband/core/restrack.c:26:36: error: incompatible type for argu=
ment 4 of '__xa_alloc'
  err =3D __xa_alloc(xa, id, U32_MAX, entry, GFP_KERNEL);
                                    ^~~~~
In file included from include/linux/radix-tree.h:31,
                 from include/linux/fs.h:15,
                 from include/linux/seq_file.h:11,
                 from arch/powerpc/include/asm/machdep.h:12,
                 from arch/powerpc/include/asm/archrandom.h:7,
                 from include/linux/random.h:166,
                 from include/linux/net.h:22,
                 from include/linux/skbuff.h:29,
                 from include/linux/if_arp.h:26,
                 from include/rdma/ib_addr.h:39,
                 from include/rdma/rdma_cm.h:39,
                 from drivers/infiniband/core/restrack.c:6:
include/linux/xarray.h:525:3: note: expected 'struct xa_limit' but argument=
 is of type 'void *'
   struct xa_limit, gfp_t);
   ^~~~~~~~~~~~~~~
drivers/infiniband/core/restrack.c:29:28: warning: passing argument 3 of '_=
_xa_alloc' makes pointer from integer without a cast [-Wint-conversion]
   err =3D __xa_alloc(xa, id, *next, entry, GFP_KERNEL);
                            ^~~~~
In file included from include/linux/radix-tree.h:31,
                 from include/linux/fs.h:15,
                 from include/linux/seq_file.h:11,
                 from arch/powerpc/include/asm/machdep.h:12,
                 from arch/powerpc/include/asm/archrandom.h:7,
                 from include/linux/random.h:166,
                 from include/linux/net.h:22,
                 from include/linux/skbuff.h:29,
                 from include/linux/if_arp.h:26,
                 from include/rdma/ib_addr.h:39,
                 from include/rdma/rdma_cm.h:39,
                 from drivers/infiniband/core/restrack.c:6:
include/linux/xarray.h:524:61: note: expected 'void *' but argument is of t=
ype 'u32' {aka 'unsigned int'}
 int __must_check __xa_alloc(struct xarray *, u32 *id, void *entry,
                                                       ~~~~~~^~~~~
drivers/infiniband/core/restrack.c:29:35: error: incompatible type for argu=
ment 4 of '__xa_alloc'
   err =3D __xa_alloc(xa, id, *next, entry, GFP_KERNEL);
                                   ^~~~~
In file included from include/linux/radix-tree.h:31,
                 from include/linux/fs.h:15,
                 from include/linux/seq_file.h:11,
                 from arch/powerpc/include/asm/machdep.h:12,
                 from arch/powerpc/include/asm/archrandom.h:7,
                 from include/linux/random.h:166,
                 from include/linux/net.h:22,
                 from include/linux/skbuff.h:29,
                 from include/linux/if_arp.h:26,
                 from include/rdma/ib_addr.h:39,
                 from include/rdma/rdma_cm.h:39,
                 from drivers/infiniband/core/restrack.c:6:
include/linux/xarray.h:525:3: note: expected 'struct xa_limit' but argument=
 is of type 'void *'
   struct xa_limit, gfp_t);
   ^~~~~~~~~~~~~~~

Caused by commit

  fd47c2f99f04 ("RDMA/restrack: Convert internal DB from hash to XArray")

from the rdma tree interacting with commit

  a3e4d3f97ec8 ("XArray: Redesign xa_alloc API")

from the xarray tree.

I added the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 21 Feb 2019 17:07:22 +1100
Subject: [PATCH] RDMA/restrack: fix for __xa_alloc() API change

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/infiniband/core/restrack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/r=
estrack.c
index fa804093fafb..5cb381a986c1 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -23,10 +23,10 @@ static int rt_xa_alloc_cyclic(struct xarray *xa, u32 *i=
d, void *entry,
 		*id =3D 0;
=20
 	xa_lock(xa);
-	err =3D __xa_alloc(xa, id, U32_MAX, entry, GFP_KERNEL);
+	err =3D __xa_alloc(xa, id, entry, XA_LIMIT(*id, U32_MAX), GFP_KERNEL);
 	if (err && *next !=3D U32_MAX) {
 		*id =3D 0;
-		err =3D __xa_alloc(xa, id, *next, entry, GFP_KERNEL);
+		err =3D __xa_alloc(xa, id, entry, XA_LIMIT(0, *next), GFP_KERNEL);
 	}
=20
 	if (!err)
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/e9dqugCWODAQ208HfahNA5W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxuQYwACgkQAVBC80lX
0GxmVwf/cEWamI1bh+DIqaGS2Se06+ts10egGLhV4BLkjLptH49TCOBXbt3TexM+
ZssmBDZm4VDPV67eHLilyvyyWvfrIshtntzPbROe3lzxEHWa2aM5IDHueUdv9VpQ
5IiOtigs9mD413jEZgEA40whRd2QBuezgLtcaMwYCtZCr2oIo5TinnKmNOS5N6Hy
DNgCnGcGRtCx34ILTzW4a4z7+CsFxMCNPWN09I9hYrrzhRkPXQoO/LLgNMD3pGyd
ygR2osqsFtp2dXg3NwhazNnfA/+cpjadR+oQbYBooRkT0rAahgutH6veurOUtScP
ZMkzEB+6Xv7g71C3oy+hQoZTusDWXQ==
=g/G2
-----END PGP SIGNATURE-----

--Sig_/e9dqugCWODAQ208HfahNA5W--
