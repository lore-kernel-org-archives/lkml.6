Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD98C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE066213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="e0L/YEc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfBYGm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 01:42:56 -0500
Received: from ozlabs.org ([203.11.71.1]:34013 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbfBYGmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 01:42:52 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 447C7F0fPMz9s9T;
        Mon, 25 Feb 2019 17:42:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551076969;
        bh=G0GApfhz/C2mEm0Z/mB/J7rqFCD/1rDRva8dqmo3kXY=;
        h=Date:From:To:Cc:Subject:From;
        b=e0L/YEc0OEyifLXKMyQMIblNne+i2oFNvPTdM7US43pzM/CCXTRJnYFKkZ15pGwxa
         gJAirUK+YetXyrC65+27ke8o+oQWt+AyAOLELbq8YbnzPYuLfd2M+VLLxDisVIeXTO
         pnOJ+CaYbUXMOdBbvtrcS7qK+WxFmXqL8aPiiVbMB2wT/eT9Mm0feOoEKupe0OGNEJ
         Zn85oWblV9ZNvCDLxDi5owbEqqYjz+11yu/Vgu4MPvlWcVDT2DP+87Nbmc5sCcXL6N
         FzbS2IJ4KNw8Ekb14CvWJGdvAMFin64j8bGwk72QJXPtN0fbTDAW8TYCqBBtNi8tkc
         VwTyf2Y16VRog==
Date:   Mon, 25 Feb 2019 17:42:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: linux-next: manual merge of the akpm-current tree with the powerpc
 tree
Message-ID: <20190225174248.54aceebd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DLHLTkI0PsEVY/Fy8LWeGXB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DLHLTkI0PsEVY/Fy8LWeGXB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/powerpc/kernel/irq.c

between commit:

  c8e409a33cf8 ("powerpc/irq: use memblock functions returning virtual addr=
ess")
and other patches in the powerpc tree

from the powerpc tree and patch:

  "powerpc: use memblock functions returning virtual address"

from the akpm-current tree.

This file looks the same after applying either of those patches, so I
just used the powerpc version of the file due to the other changes.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

The akpm patch now looks like this:

diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu=
_ftrs.c
index e49bd5efcfe6..28c076c771de 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -810,7 +810,6 @@ static int __init process_cpufeatures_node(unsigned lon=
g node,
 	int len;
=20
 	f =3D &dt_cpu_features[i];
-	memset(f, 0, sizeof(struct dt_cpu_feature));
=20
 	f->node =3D node;
=20
@@ -1005,7 +1004,7 @@ static int __init dt_cpu_ftrs_scan_callback(unsigned =
long node, const char
 	/* Count and allocate space for cpu features */
 	of_scan_flat_dt_subnodes(node, count_cpufeatures_subnodes,
 						&nr_dt_cpu_features);
-	dt_cpu_features =3D __va(memblock_phys_alloc(sizeof(struct dt_cpu_feature=
) * nr_dt_cpu_features, PAGE_SIZE));
+	dt_cpu_features =3D memblock_alloc(sizeof(struct dt_cpu_feature) * nr_dt_=
cpu_features, PAGE_SIZE);
=20
 	cpufeatures_setup_start(isa);
=20
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 8c890c6557ed..e7382abee868 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -196,7 +196,11 @@ void __init allocate_paca_ptrs(void)
 	paca_nr_cpu_ids =3D nr_cpu_ids;
=20
 	paca_ptrs_size =3D sizeof(struct paca_struct *) * nr_cpu_ids;
-	paca_ptrs =3D __va(memblock_phys_alloc(paca_ptrs_size, SMP_CACHE_BYTES));
+	paca_ptrs =3D memblock_alloc_raw(paca_ptrs_size, SMP_CACHE_BYTES);
+	if (!paca_ptrs)
+		panic("Failed to allocate %d bytes for paca pointers\n",
+		      paca_ptrs_size);
+
 	memset(paca_ptrs, 0x88, paca_ptrs_size);
 }
=20
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index e97aaf201d67..c0ed4fa0b9d3 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -127,7 +127,10 @@ static void __init move_device_tree(void)
 	if ((memory_limit && (start + size) > PHYSICAL_START + memory_limit) ||
 	    !memblock_is_memory(start + size - 1) ||
 	    overlaps_crashkernel(start, size) || overlaps_initrd(start, size)) {
-		p =3D __va(memblock_phys_alloc(size, PAGE_SIZE));
+		p =3D memblock_alloc_raw(size, PAGE_SIZE);
+		if (!p)
+			panic("Failed to allocate %lu bytes to move device tree\n",
+			      size);
 		memcpy(p, initial_boot_params, size);
 		initial_boot_params =3D p;
 		DBG("Moved device tree to 0x%px\n", p);

--=20
Cheers,
Stephen Rothwell

--Sig_/DLHLTkI0PsEVY/Fy8LWeGXB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxzjmgACgkQAVBC80lX
0GyZmQf9GQg4sCm+7lVhEvxBnWH4d+gBzOc9omSmR6OCrZcbOf/sbQbo30kRjjyP
c4ILrdxAgt7612DV+B3rV52+axpItoeTujBvF6ybq+P8hMuArEloLx/75G/I7HgK
i/eHkQx2Vg2o8RUG2RJMvxaeRqb726xcIKkTlhS7PDO2rgNZU9k2pHy4SYybgWZc
US6LW65FH3M8KxoHnMe5E1sDVhW8TpU+PdXoWuWJh7iJIeWMbdE5mA1nDf/bs0U9
QuY/oXtfKlnB+cDfpBSEmDdrzYeE+OJkTJtMOB71qNM3eHj4SJa6Gg3kI+1rBLga
e8TX8JlNCwMxvIOGYMJdad13P+Wl/A==
=M324
-----END PGP SIGNATURE-----

--Sig_/DLHLTkI0PsEVY/Fy8LWeGXB--
