Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E629C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C08218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="caJ87TWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfBRB4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 20:56:32 -0500
Received: from ozlabs.org ([203.11.71.1]:35055 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbfBRB4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 20:56:31 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 442n644x8pz9s3x;
        Mon, 18 Feb 2019 12:56:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550454989;
        bh=zeFyI3Sji6Kn/aPLs7IbNq6lJmmgpgQsM7fhcHSedLQ=;
        h=Date:From:To:Cc:Subject:From;
        b=caJ87TWtKvUms6Gwbhb9oTFYu92SRw1hPuTRqiTsePth9lmWsq4yVT5bRJYhpi9iS
         j76RJVDHf/dc5e2DzfmK0tonXzok84DMVX9IzKoFeBCRcFE2sg5DmQnO180NMip4Vi
         oPEpUzcrUfyEsigGEVuU4pWbhNj4RVRZF/6nzfFOKkxwyqI1umIdsYcAgoPtzfVYQ2
         kEwGwXvqIcb5jpL4nUpMqFfet/pnMcplS7iliTsgLevbYfgxDxMXYjy7ctlMwvUoiF
         BfNMx3hy7EBZL6Bv6nmXl82D7QVsieEy7BGvhpUAzmSMf6StHTzfBd+lZ6BoxVBUnQ
         ahmKNHwC9oM7w==
Date:   Mon, 18 Feb 2019 12:56:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: linux-next: manual merge of the regulator tree with the arm-soc
 tree
Message-ID: <20190218125627.003fc22c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6OserSKOC8v+jPaIAfQNoFv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6OserSKOC8v+jPaIAfQNoFv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the regulator tree got a conflict in:

  arch/arm/mach-pxa/raumfeld.c

between commit:

  0f884f8a090e ("ARM: pxa: remove raumfeld board files and defconfig")

from the arm-soc tree and commit:

  01dc79cd6fe7 ("regulator: fixed/gpio: Pull inversion/OD into gpiolib")

from the regulator tree.

I fixed it up (the former removed the file, so I did that) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/6OserSKOC8v+jPaIAfQNoFv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxqEMsACgkQAVBC80lX
0GwROwf/SwwGRVit6+U+LEWNBpX8CiZt4OZKHSBnOtuEr11de294QGLeYUbkspmB
a18CsDhMcidHv5ubE8N1e53bUgOBmuc/LIZZKGrFuhT1+uouboE36CM3bHZKUeXQ
WY0O6rEHmI1Dy3wNAm/rFQjKe+2o53EHyEM2EU6vJp/aDDhWt2SA6LKnrS0J8Lxc
mWt4KvzL+ZuYx3son78AE95O2YB1A8XOh2m+231k62wGPd1VMcpgQ94l3IZXt7or
klA5dRTpVn+W5AIHTLY6JURBgkdf+ykIZh+zOfiOPJpE4nneXKKUvkWhZ6QhHaS1
nxI0ZhIEMh7jA9v9cdbnvBWK6fkJHA==
=P9BI
-----END PGP SIGNATURE-----

--Sig_/6OserSKOC8v+jPaIAfQNoFv--
