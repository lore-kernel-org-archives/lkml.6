Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3B0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D282084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Q3Pff+hl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D282084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbeGSDIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 23:08:54 -0400
Received: from ozlabs.org ([203.11.71.1]:58933 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730329AbeGSDIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 23:08:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41WHxL72m3z9s21;
        Thu, 19 Jul 2018 12:28:06 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531967287;
        bh=6fTtjbT1zOOwl3z0Gm7goaQcXJvJepKvjDB4Q/nlHiA=;
        h=Date:From:To:Cc:Subject:From;
        b=Q3Pff+hleVsHLbboqnebt3P/PJNDM7Jjo0zrxrU8HbtHTIo7U09tsrf89qJdnyzs+
         xZpzqa7TFp1dbf0sD0ucDExTGWUUA8guVGDciPwO1YwkxdYj1+enXeMjaTxucskHfa
         zsJA4YNja4L6ymTKMF3ilOpCfkjsQK4LaqQlzMSKM0qiSEj2HT6KctM2NhahlMI08f
         G4RHlIOxrsukVbtksrNcEOJ3dXyUgxCxpRaXPtIq98kQEBhhmBhlcMZhzqJRX5DPRn
         8oI2HuUAcHB3Au5wp3iaBrf8WYtGHPrzzKWGnuus4q2685knlcnVtA9/TIHT0UBm+v
         C7VMRjUr/nSFQ==
Date:   Thu, 19 Jul 2018 12:28:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: linux-next: build warning after merge of the nand tree
Message-ID: <20180719122806.29121ca3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/HPk84SQwlLAuqY1x5FHTTlT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HPk84SQwlLAuqY1x5FHTTlT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Boris,

After merging the nand tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

In file included from include/linux/platform_device.h:14:0,
                 from drivers/mtd/nand/raw/jz4740_nand.c:19:
drivers/mtd/nand/raw/jz4740_nand.c: In function 'jz_nand_detect_bank':
drivers/mtd/nand/raw/jz4740_nand.c:358:23: warning: format '%i' expects arg=
ument of type 'int', but argument 3 has type 'size_t {aka long unsigned int=
}' [-Wformat=3D]
  dev_info(&pdev->dev, "Found chip %i on bank %i\n", chipnr, bank);
                       ^
include/linux/device.h:1397:51: note: in definition of macro 'dev_info'
 #define dev_info(dev, fmt, arg...) _dev_info(dev, fmt, ##arg)
                                                   ^~~

Exposed by commit

  6968e07e8169 ("mtd: rawnand: jz4740: Allow selection of this driver when =
COMPILE_TEST=3Dy")

--=20
Cheers,
Stephen Rothwell

--Sig_/HPk84SQwlLAuqY1x5FHTTlT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltP9zYACgkQAVBC80lX
0GyucggAluG3RdLLD9WaNqGJleJ0Q2fX98PAyDO7AvxvcIIK7wcvajVSLlfbwX/4
aSQwEgewuU40aUpmCtJ7eLBzVVsuVH4Eh/FOXEZp56Co5YvimidmC/Na0VhF1UR9
z9w5Lkksji4pAhJuKeR29cskrf2cFsrQmJci1ERPOOMB6GC0vloIzOYj8QQdTVYr
k65QgKT563OQ+GvkyH/OjiQs0D2ecVIpzp98q1sqUyJ1hds/k5Us06ejBi22KCz5
XJQjJPsWYrN5oAbnps4PjmNoV97IFBfoD/gMmu3HWz+xGMFphiaK5LyBDlKqilc0
Tpzt217KtnBe9oie5DJpDCvrCY2zLA==
=ExGF
-----END PGP SIGNATURE-----

--Sig_/HPk84SQwlLAuqY1x5FHTTlT--
