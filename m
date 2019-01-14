Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938EBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59331206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="poLr2KSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfANCsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 21:48:13 -0500
Received: from ozlabs.org ([203.11.71.1]:54879 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfANCsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 21:48:12 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43dHvq3MQXz9s7h;
        Mon, 14 Jan 2019 13:48:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547434087;
        bh=6P7ylzg7kQ8dAG6ONuOPZipGKQejUW77VvwVBtQwako=;
        h=Date:From:To:Cc:Subject:From;
        b=poLr2KSApp0sB87lc4ld2jgOIuhdwoSu+tg23rnoRaYx3QigZiPq9VLfeNyg2KA16
         PS/UP1gpjCoPpswWJRxnvpKH46qyjUs6xrbUqjufnfP+yHkeYpahielJQN+6DaXi1O
         /lHj6GuT5Usbl3e3xc7GzKrJgIsCRiD3hX7AXZwmsrTX7/WO+a22nMAjEEqdt78eT4
         MDbbOIQfStqe2Nc4HSovyJgcrc2gkNtUdrDBQd0wp5wVnxQ35+tfneGSMmqmwutx4z
         SYTDbfcCcjI3p7rf3eispO/t7jRM9kqhoN8A2k4goR94sjMUIFX5mUi5P69npE7xzw
         /0zKLo5XgN5lw==
Date:   Mon, 14 Jan 2019 13:48:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Ching Huang <ching2048@areca.com.tw>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: linux-next: manual merge of the scsi tree with Linus' tree
Message-ID: <20190114134726.335c1da6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bv4Mk9JDXiR+2z=o/_+Ephy"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bv4Mk9JDXiR+2z=o/_+Ephy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi tree got a conflict in:

  drivers/scsi/arcmsr/arcmsr_hba.c

between commit:

  750afb08ca71 ("cross-tree: phase out dma_zalloc_coherent()")

from Linus' tree and commit:

  381d66da7212 ("scsi: arcmsr: Rename acb structure member roundup_ccbsize =
to ioqueue_size")

from the scsi tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/scsi/arcmsr/arcmsr_hba.c
index 57c6fa388bf6,9f85d5abbb0c..000000000000
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@@ -585,12 -641,9 +641,11 @@@ static bool arcmsr_alloc_io_queue(struc
 =20
  	switch (acb->adapter_type) {
  	case ACB_ADAPTER_TYPE_B: {
- 		struct MessageUnit_B *reg;
- 		acb->roundup_ccbsize =3D roundup(sizeof(struct MessageUnit_B), 32);
+ 		acb->ioqueue_size =3D roundup(sizeof(struct MessageUnit_B), 32);
 -		dma_coherent =3D dma_zalloc_coherent(&pdev->dev, acb->ioqueue_size,
 -			&dma_coherent_handle, GFP_KERNEL);
 +		dma_coherent =3D dma_alloc_coherent(&pdev->dev,
- 						  acb->roundup_ccbsize,
++						  acb->ioqueue_size,
 +						  &dma_coherent_handle,
 +						  GFP_KERNEL);
  		if (!dma_coherent) {
  			pr_notice("arcmsr%d: DMA allocation failed\n", acb->host->host_no);
  			return false;
@@@ -616,13 -655,9 +657,11 @@@
  		}
  		break;
  	case ACB_ADAPTER_TYPE_D: {
- 		struct MessageUnit_D *reg;
-=20
- 		acb->roundup_ccbsize =3D roundup(sizeof(struct MessageUnit_D), 32);
+ 		acb->ioqueue_size =3D roundup(sizeof(struct MessageUnit_D), 32);
 -		dma_coherent =3D dma_zalloc_coherent(&pdev->dev, acb->ioqueue_size,
 -			&dma_coherent_handle, GFP_KERNEL);
 +		dma_coherent =3D dma_alloc_coherent(&pdev->dev,
- 						  acb->roundup_ccbsize,
++						  acb->ioqueue_size,
 +						  &dma_coherent_handle,
 +						  GFP_KERNEL);
  		if (!dma_coherent) {
  			pr_notice("arcmsr%d: DMA allocation failed\n", acb->host->host_no);
  			return false;
@@@ -662,11 -671,9 +675,11 @@@
  	case ACB_ADAPTER_TYPE_E: {
  		uint32_t completeQ_size;
  		completeQ_size =3D sizeof(struct deliver_completeQ) * ARCMSR_MAX_HBE_DO=
NEQUEUE + 128;
- 		acb->roundup_ccbsize =3D roundup(completeQ_size, 32);
+ 		acb->ioqueue_size =3D roundup(completeQ_size, 32);
 -		dma_coherent =3D dma_zalloc_coherent(&pdev->dev, acb->ioqueue_size,
 -			&dma_coherent_handle, GFP_KERNEL);
 +		dma_coherent =3D dma_alloc_coherent(&pdev->dev,
- 						  acb->roundup_ccbsize,
++						  acb->ioqueue_size,
 +						  &dma_coherent_handle,
 +						  GFP_KERNEL);
  		if (!dma_coherent){
  			pr_notice("arcmsr%d: DMA allocation failed\n", acb->host->host_no);
  			return false;

--Sig_/bv4Mk9JDXiR+2z=o/_+Ephy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw7+GYACgkQAVBC80lX
0GxXEgf+KTbxTRvd9AMC23zy2LXueVohvU8fiwCMJBGZZyLZnZUEYxkpAatyZSWr
hJzHQb6l8NcgtwWGufwweGMRq+1zspBV/+VfeC1HZslOfPdXaTN/PQeTwpvi93Yc
X+Wh5BsOxP3lufRXaRuMPXYCAkolJMBn2blNwUILMpn2ks5Ehheyybg9m29ghD83
jhXsdpAdsgn1cYYvZf7yqHU2ylWeOfXv4kKaK4nmuhsTgTarvOBUnkj4xJQJWFOf
DRzuk5W3fOHS1/b+jUDB6vULvryG5xWcKxn5TgXdaejzL16RVSmFDRXqdZIM+xKv
p2GSnlHLOeUz+6D1Nwt/XNEdOnClCA==
=KaZp
-----END PGP SIGNATURE-----

--Sig_/bv4Mk9JDXiR+2z=o/_+Ephy--
