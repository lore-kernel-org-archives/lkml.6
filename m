Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF25C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A26217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MXRwdObv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfAWCm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 21:42:28 -0500
Received: from ozlabs.org ([203.11.71.1]:37857 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbfAWCm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 21:42:28 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43kqM44V0Bz9s3q;
        Wed, 23 Jan 2019 13:42:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548211344;
        bh=xnhPFUn+X589nHzuJlTCTbheOFCDr1b6xn1oi5u2j8A=;
        h=Date:From:To:Cc:Subject:From;
        b=MXRwdObvd0Ef49Jl4Gj37T0CrRx2FFjE8AFsV4GoH0RaA0T0IC1P4NMtZxMiGYacA
         WjXSuc/+U30Jq/2m+radMibNGLVihYQ0998wyRsDwQ2Pl04p2u/EtMPDurmbXFIX56
         5pOm8GbM/kn38IBCpNNywMYsrIZ5ajl3h576w1Xh5IdbA15Yzw2yaGpSDIuhnWyaBG
         1xVUN0+EsgxAGAcVh1RajayjMkBFr26yzKA8QQwvAoLbAQNzgt8YTNo7eeFNABm7Ur
         fBQ6vHs75KPBXNdlk69kgyKI4pwzlWkatPCbZvq1DWMiDTp/tANU1D362WGLJeuebF
         soNNwnD0XoQgQ==
Date:   Wed, 23 Jan 2019 13:41:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: linux-next: manual merge of the slave-dma tree with Linus' tree
Message-ID: <20190123134157.29c69b3f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/msBv5YKQHsia=WBv1OUTT1I"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/msBv5YKQHsia=WBv1OUTT1I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vinod,

Today's linux-next merge of the slave-dma tree got a conflict in:

  drivers/dma/imx-sdma.c

between commit:

  750afb08ca71 ("cross-tree: phase out dma_zalloc_coherent()")

from Linus' tree and commit:

  ceaf52265148 ("dmaengine: imx-sdma: pass ->dev to dma_alloc_coherent() AP=
I")

from the slave-dma tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/dma/imx-sdma.c
index 86708fb9bda1,af14a8d6efa8..000000000000
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@@ -1182,8 -1189,8 +1189,8 @@@ static int sdma_request_channel0(struc
  {
  	int ret =3D -EBUSY;
 =20
- 	sdma->bd0 =3D dma_alloc_coherent(NULL, PAGE_SIZE, &sdma->bd0_phys,
 -	sdma->bd0 =3D dma_zalloc_coherent(sdma->dev, PAGE_SIZE, &sdma->bd0_phys,
 -					GFP_NOWAIT);
++	sdma->bd0 =3D dma_alloc_coherent(sdma->dev, PAGE_SIZE, &sdma->bd0_phys,
 +				       GFP_NOWAIT);
  	if (!sdma->bd0) {
  		ret =3D -ENOMEM;
  		goto out;
@@@ -1205,8 -1212,8 +1212,8 @@@ static int sdma_alloc_bd(struct sdma_de
  	u32 bd_size =3D desc->num_bd * sizeof(struct sdma_buffer_descriptor);
  	int ret =3D 0;
 =20
- 	desc->bd =3D dma_alloc_coherent(NULL, bd_size, &desc->bd_phys,
- 				      GFP_NOWAIT);
 -	desc->bd =3D dma_zalloc_coherent(desc->sdmac->sdma->dev, bd_size,
 -				       &desc->bd_phys, GFP_NOWAIT);
++	desc->bd =3D dma_alloc_coherent(desc->sdmac->sdma->dev, bd_size,
++				      &desc->bd_phys, GFP_NOWAIT);
  	if (!desc->bd) {
  		ret =3D -ENOMEM;
  		goto out;

--Sig_/msBv5YKQHsia=WBv1OUTT1I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxH1HUACgkQAVBC80lX
0GznDQgAhP4eSUOMArUCWUJt1zJ7xaqmfn/BElyVcjKPB6GD3skB/zQngpQylLfQ
jmRzTBOaQnWhRhHkzZ/MhkoDB5EUsKZl2L701n8qP6vA1JxPKnX3ruOajgOwDP5j
f+sRSd8hGFl3+ajBfMh646rEg2fQePtD6yAzIbTBk8u1g208YtGzkjGG2MG/fEW9
V6G35Rgqgi+BC5YwsjRP0LrqXBGoc7JqY2DYt0hRA2urD/ms01DkVgErGBJgaAs1
vaPrfaUu8SAYDr0INNFfpDmo4sFcO0vWaEQ6HCt6LbNxARdjEObJ+cDk3QYiyWq+
ttZxcTrjmJ9eWJMH4m34i3QOI4LpMQ==
=PtbG
-----END PGP SIGNATURE-----

--Sig_/msBv5YKQHsia=WBv1OUTT1I--
