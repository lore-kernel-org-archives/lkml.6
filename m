Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB566C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8018020896
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bK3LBWPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8018020896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbeKNMUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:20:00 -0500
Received: from ozlabs.org ([203.11.71.1]:60841 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbeKNMUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:20:00 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42vp8D4fQrz9s5c;
        Wed, 14 Nov 2018 13:18:52 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1542161932;
        bh=webNLDgLcXsUW8TkXpBg7XqNn2CCVOY1K82Uy7efB0c=;
        h=Date:From:To:Cc:Subject:From;
        b=bK3LBWPMxiY6LwOFUD5f/3YQAsRgh1fnvaCDyjxm2aH8iO6S8zTn+8yDay2mMms9F
         UvKQHqvSrRmB5zyh+SpMbp4HiW+caLR2HGKQrkx6LBRnd6Ut8kvOCX/K+fXTu/nHka
         MEPqizfYqyxxogx5fATAB4Wn3a2kyHhvM26/5yVXtgqkH1MX4lnC8BiR5w5Z3k7/ny
         +TCvQrHc5Gm5H04g2LLFbA3SoCiF6Qh2kPsNeGzx4urxGh+cVXgEQjCzzwTvfDFs3z
         syIbqxDQv5btfhVJ816WoI8wOZSqGIpiC4oB2VhPJM+p6xVr+ULJsApZmlHxubZN4x
         7cyj/q2YB2QDg==
Date:   Wed, 14 Nov 2018 13:18:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: linux-next: build warning after merge of the spi tree
Message-ID: <20181114131844.57c4cdc7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5f3EPhnFLnSgg2zs24/CD3y"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5f3EPhnFLnSgg2zs24/CD3y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

After merging the spi tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

drivers/spi/spi-npcm-pspi.c: In function 'npcm_pspi_recv':
drivers/spi/spi-npcm-pspi.c:226:17: warning: 'val' may be used uninitialize=
d in this function [-Wmaybe-uninitialized]
   *priv->rx_buf =3D val;
   ~~~~~~~~~~~~~~^~~~~

Introduced by commit

  2a22f1b30cee ("spi: npcm: add NPCM PSPI controller driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/5f3EPhnFLnSgg2zs24/CD3y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvrhgQACgkQAVBC80lX
0GwXmwf+L7MaZLWwEA55feuVGMgIrYpNcZVcSFHNl/WE8OoGoyvMOTdtoTpHXPhe
0KWX2GCoEMYeruXR14lvZEwefVLeFF7dwf5u8zA0tXiIGX6j3Tg88ld/PacrCp6U
yh9hjylLdcVBIHEnI0HuIDO0LJ6BWoBIDArsOPnp5a7IgsC36gIiaiuLLzhQWwuX
02pl8fu0t3VmbQjvHBWyP0Xz8+vS0Wf8nKGPmTqOC7KZFqcYWc+LdXIXetc6F+kj
RnmrB1Q7c06xJW8CLXe6IGe8O5JOvqPDww4pIedbxhzPzNz3Duu/QPfqgLUHMIhy
oKsibhURMoxk3ewvU7R+X0KfvXO8Ug==
=vbCi
-----END PGP SIGNATURE-----

--Sig_/5f3EPhnFLnSgg2zs24/CD3y--
