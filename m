Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78556C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 02:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33791214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 02:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GlCzeKfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfA2CCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 21:02:43 -0500
Received: from ozlabs.org ([203.11.71.1]:35805 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfA2CCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 21:02:43 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43pVBQ4HgXz9sDK;
        Tue, 29 Jan 2019 13:02:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548727360;
        bh=hZ7TmYQeneGRgsNEjjNaJKmhfemPDlNm4IYajKyI77k=;
        h=Date:From:To:Cc:Subject:From;
        b=GlCzeKfMCcxE5ybIf7Cy7suMP3MQlHkt+NSEsRl0F7zCKxbN9XPi3Y2SVJTIox7p1
         xxrjXulbqpFFSCcCrXJyFm/Td0hYLqUJ9MtUikqrbuALDkXtySSf2IFbAyzRjvCG45
         kVqawvYREP03hFAAWZs0Rppa1dVfE4Th3zEuSyNyTbR0FJUX5vjbOlxQ93aFt1WxP9
         xSo5IFeC2xFqSSRVoFTWZ4my2YsXSpq7g/1GC1w9xj5TWkiN8lw0gjtKjfEWiekey3
         mfiXwZrjB8seyjLxY6qXvTIHviw0yIZy0PdilE8o97deVBiyk0xpy9H/U+umoultKp
         58dteHDUGMHKQ==
Date:   Tue, 29 Jan 2019 13:02:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Ashish Kumar <Ashish.Kumar@nxp.com>
Subject: linux-next: build warning after merge of the spi tree
Message-ID: <20190129130237.677e5ac8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/apUL4Ig7jufd.FnWq5Z.JP3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/apUL4Ig7jufd.FnWq5Z.JP3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the spi tree, today's linux-next build (KCONFIG_NAME)
produced this warning:

WARNING: modpost: missing MODULE_LICENSE() in drivers/spi/spi-nxp-fspi.o
see include/linux/module.h for more information

Introduced by commit

  a5356aef6a90 ("spi: spi-mem: Add driver for NXP FlexSPI controller")

--=20
Cheers,
Stephen Rothwell

--Sig_/apUL4Ig7jufd.FnWq5Z.JP3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxPtD0ACgkQAVBC80lX
0GwcUQf+OOSsK0id705XZPIlNDC18ASqQkgmbzhh/YYsgbziD/M51zRM8Hv3yz1u
3aL0ny4yYc2uGwXE0ezcZPHqoteKGzl2z6exl2gebhhHKfD8D25nruM2tJUL20Pq
+xNuCGjDQmFxuCfv4PK7mQV1TysVss71QtdOeCdpCurAtTy/B95uaHzwQ/gs9Yud
Er2wa9v98v42jPbYGb+0lInmLYGnOzJzKtp0OR/sHi2z/mNfZ4+6cxPvfEOq6N6J
OcBHwyh+uT+GqN0tqahGp1m7mpcQQlPrzOqdUjOEde21yCRsm+w3G4T+PL2BY6EU
zAPlxMu9EEc/ovZOkTCkP7G8RmaDGA==
=2Ua7
-----END PGP SIGNATURE-----

--Sig_/apUL4Ig7jufd.FnWq5Z.JP3--
