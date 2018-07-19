Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC26ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406A220684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Aok4or8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406A220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbeGTAha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:37:30 -0400
Received: from ozlabs.org ([203.11.71.1]:46621 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbeGTAha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:37:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41WrQl1bWMz9s1R;
        Fri, 20 Jul 2018 09:51:59 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532044319;
        bh=XChIum8t8+rTrHqhl3x1ZCTiRMZSKMdxxfnSrGO9KM4=;
        h=Date:From:To:Cc:Subject:From;
        b=Aok4or8bYoL+e6lddwQZ97l4/VZ8bIEHxaZ06DtXqhqnzvlpEDBldlFNRuWY5mt39
         GPYfP0jSmygBIlbIhpepvIaO5fDxbF1JYpOH//pSFVLMXwtUIYjL5Yc7fCkAQYoMax
         h0/BETV9fpaGxolIjuRJMZYqFsiiM/mEtal59vgNiyk0SDLWbNzMBSFR2ZHbxMWlud
         P5390ijd7207egEvxX6LYBW5d0d5GDff6Aqw/e+89AATqzkNH/MjdMAMBXLmNmwxcx
         8nem9SNnrJ3cFlgYCyr6SLxvBYPOGldHImdV1NjV8+2OD8RB5WaAXHKO0EDFgKzl3H
         kXlvpcyTvb/AA==
Date:   Fri, 20 Jul 2018 09:51:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: linux-next: manual merge of the powerpc tree with the powerpc-fixes
 tree
Message-ID: <20180720095138.275cc9aa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/M/wB7O1tQxgKIF7Eg3TSknz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M/wB7O1tQxgKIF7Eg3TSknz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  drivers/vfio/vfio_iommu_spapr_tce.c

between commit:

  1463edca6734 ("vfio/spapr: Use IOMMU pageshift rather than pagesize")

from the powerpc-fixes tree and commit:

  00a5c58d9499 ("KVM: PPC: Make iommu_table::it_userspace big endian")

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

diff --cc drivers/vfio/vfio_iommu_spapr_tce.c
index 7cd63b0c1a46,11a4c194d6e3..000000000000
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@@ -487,11 -449,11 +449,11 @@@ static void tce_iommu_unuse_page_v2(str
  	if (!pua)
  		return;
 =20
- 	ret =3D tce_iommu_prereg_ua_to_hpa(container, *pua, tbl->it_page_shift,
- 			&hpa, &mem);
+ 	ret =3D tce_iommu_prereg_ua_to_hpa(container, be64_to_cpu(*pua),
 -			IOMMU_PAGE_SIZE(tbl), &hpa, &mem);
++			tbl->it_page_shift, &hpa, &mem);
  	if (ret)
- 		pr_debug("%s: tce %lx at #%lx was not cached, ret=3D%d\n",
- 				__func__, *pua, entry, ret);
+ 		pr_debug("%s: tce %llx at #%lx was not cached, ret=3D%d\n",
+ 				__func__, be64_to_cpu(*pua), entry, ret);
  	if (mem)
  		mm_iommu_mapped_dec(mem);
 =20
@@@ -599,19 -561,12 +561,12 @@@ static long tce_iommu_build_v2(struct t
  	unsigned long hpa;
  	enum dma_data_direction dirtmp;
 =20
- 	if (!tbl->it_userspace) {
- 		ret =3D tce_iommu_userspace_view_alloc(tbl, container->mm);
- 		if (ret)
- 			return ret;
- 	}
-=20
  	for (i =3D 0; i < pages; ++i) {
  		struct mm_iommu_table_group_mem_t *mem =3D NULL;
- 		unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl,
- 				entry + i);
+ 		__be64 *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry + i);
 =20
  		ret =3D tce_iommu_prereg_ua_to_hpa(container,
 -				tce, IOMMU_PAGE_SIZE(tbl), &hpa, &mem);
 +				tce, tbl->it_page_shift, &hpa, &mem);
  		if (ret)
  			break;
 =20

--Sig_/M/wB7O1tQxgKIF7Eg3TSknz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltRJAoACgkQAVBC80lX
0GyGIwf/UsUGTDeLCB1dBOXDnIOy937KSGh90Zwx+oOyTE8mjziQB/MtJjZeEhVi
GtTzPDqTwZeOKU963SX9EmrkpmyHby/aSWB2iBeVnsCqvsUxSEAXMIUlbttfyCxT
4wDxGKIgAHoSTn7aDJoOjfLd88FiNmCKwX51UFSNqqkbMbQY9s8U7AQ6yuba23gr
y7rZtAddwYo401xYF5TtUxv9OBgkm1vKyA5vtRPvvHuR023ax9+JkI7NX8Djo4BK
/6JyLVIQRqkjal7HoJ9lgUkk2KLB77ENvCdR82DOJZETPG56zSxH6zwPaG5eWRK1
o270Y/I3BCyXzZjC/f8RQg7KGprJcw==
=n+fN
-----END PGP SIGNATURE-----

--Sig_/M/wB7O1tQxgKIF7Eg3TSknz--
