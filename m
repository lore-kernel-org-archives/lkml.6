Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8DEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A010B21738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HwJVWDD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfAJAlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:41:23 -0500
Received: from ozlabs.org ([203.11.71.1]:53131 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfAJAlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:41:22 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43ZnHM3nKFz9sLw;
        Thu, 10 Jan 2019 11:41:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547080879;
        bh=ZyupXi9BFPbujHDlWgxQ6ASZE+TobPl1L2fer6A9zM8=;
        h=Date:From:To:Cc:Subject:From;
        b=HwJVWDD4XYMshsmch9k6WS3nO1f7AP6gsASHl6Gkgo7FRUNF605Oby3JHg09k1hhj
         VMAERaon535n8gXHavHcP0uVyKchBqzhX2oxS63UpWD63P2i5Wwj62aWB2BXBln561
         5X9i6dEP8tK2GXpyEh5+XGr7hGPDLTRfTDCWb3auZmHJWWZpxL3aBhcli2AjImU+Nm
         l/4SdX6PW1fZb2AUGHAumVCi3LWBF6HtKlExhHRi3M0ZeyJZamvEPD87tCHEZ1Gxp2
         rV+sLri7AeH+FP4yBE/FtuAWkQnoPrGn/2MwqVtDHjK5quQ7zfZy3dIeqeuPPaLrNt
         /a+TmxB+G662Q==
Date:   Thu, 10 Jan 2019 11:41:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: linux-next: build warning after merge of the spi tree
Message-ID: <20190110114113.206c0650@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nv.Io.SxpMXN4dhoRe5XDBC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nv.Io.SxpMXN4dhoRe5XDBC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

After merging the spi tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/spi/spi-davinci.c: In function 'davinci_spi_setup':
drivers/spi/spi-davinci.c:426:21: warning: unused variable 'master' [-Wunus=
ed-variable]
  struct spi_master *master =3D spi->master;
                     ^~~~~~

Introduced by commit

  101a68e74fe0 ("spi: davinci: Convert to use CS GPIO descriptors")

--=20
Cheers,
Stephen Rothwell

--Sig_/nv.Io.SxpMXN4dhoRe5XDBC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw2lKkACgkQAVBC80lX
0GyIYQf+PUv+XgHMsQ08i3ot1I9lPw/rNPtWAUqSi7n9W11c/NawKaxx8s5zYzSh
ZaYXLgQWniImQwSn3S3QQOsb+U0/kkk7wX7cE5hgbsQSnHpLzAAysm6EmLBB/5lL
T8xEYLT73ch3nbNaPDVn/KLG+T16KIb1UuVdI1fupfqATez/uvtLVPQ7P7GLblML
6uSLpspUPGEB127KHeYTXDJdFCv90A0VfHjJKTqaZF0ZMT351OuVfDkZBgmiO1Qo
nBqSX2PsUM9RxVtsAQDQlanhcBQXwhwSFsZ6xkUKTBLW1MpEDduCi5K69LHxqQAz
dPdFk4Q5dx7lPPbAmcAH+mYndduUdQ==
=N72P
-----END PGP SIGNATURE-----

--Sig_/nv.Io.SxpMXN4dhoRe5XDBC--
