Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8CFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029642087B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sjOGIOBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029642087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeH2E2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:28:03 -0400
Received: from ozlabs.org ([203.11.71.1]:52583 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbeH2E2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:28:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 420RSZ1zCyz9s3x;
        Wed, 29 Aug 2018 10:33:50 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535502830;
        bh=UfH3cUIyrm9SX0EecR4p+gd4RGi1Sd213CK1ttquWIQ=;
        h=Date:From:To:Cc:Subject:From;
        b=sjOGIOBJrJDjaBf0s6zahBBClaCpPtEsc2DFUmhgXOwS4/jj2fwTcNOkUGaY0aDod
         8shkHk0Vd740bITyJLke+CvhHM19VC4qbjh3xz64J4T92IkVHbODr+J1HowiVfsQC7
         LsOgmRZhweK0FYTrJAVXIjgUNLW+OdC80g6FpN1+g83eJAVLYQIL51sgFK1dQHa75n
         QQhNiWFRiRBJpmPcygvoypno1JCgcHnmFS+Sba+NUPO54Ez3rou6Zg1og0COyc/O4H
         VZJGZWG2z0ht5QQQ9te1i8YD3d0bCo0bw8GRZq+gOaLHnWFWHDdOrolQQdvNNSlXN7
         iZ1Aql1C8BiPw==
Date:   Wed, 29 Aug 2018 10:33:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lanqing Liu <lanqing.liu@spreadtrum.com>,
        Baolin Wang <baolin.wang@linaro.org>
Subject: linux-next: build failure after merge of the spi tree
Message-ID: <20180829103349.5cd15637@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pQ3QTpRms9=VG/v/JUkchY/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pQ3QTpRms9=VG/v/JUkchY/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

After merging the spi tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

In file included from include/linux/clk.h:16,
                 from drivers/spi/spi-sprd.c:4:
drivers/spi/spi-sprd.c: In function 'sprd_spi_init_hw':
drivers/spi/spi-sprd.c:462:29: error: 'struct spi_transfer' has no member n=
amed 'word_delay'
  word_delay =3D clamp_t(u16, t->word_delay, SPRD_SPI_MIN_DELAY_CYCLE,
                             ^~

(and many more)

Caused by commit

  e7d973a31c24 ("spi: sprd: Add SPI driver for Spreadtrum SC9860")

I have used the spi tree from next-20180828 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/pQ3QTpRms9=VG/v/JUkchY/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluF6e0ACgkQAVBC80lX
0Gzlegf9F88lNWfvLVrksn1IoiSVJPujlArPrfxSgYMGO5M4Blt3lJCQVFPLVX5R
5uclJdRyCqPPFp02bZcNJvnPp9Sbn2fOvRKbxrfVGhinbXq07pEMrspgm655f5fO
4TTnPJTcDtP4drScF8kIqqHSEH0APFO6RR3dCSKgO4bFTfBeyzimN3Dte0tl5Gon
uwyAhNLu4ARRLoTB7Xhftuwtgm1StDXycNZxS3LCz2Gj8DIMfWng68cj9j2V1xru
dQX6Rm/O+cG4Ng34o3uUaHSQ+t75Au0V/TlBBkrU7Lx/z/+4wxqMC6GALtXI74A4
J5XZpq+y0/o2OU0vhQzYddUZXhCJkg==
=O8ab
-----END PGP SIGNATURE-----

--Sig_/pQ3QTpRms9=VG/v/JUkchY/--
