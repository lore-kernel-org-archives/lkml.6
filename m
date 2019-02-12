Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CFEC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0077820863
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sQRhpfrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfBLGPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 01:15:03 -0500
Received: from ozlabs.org ([203.11.71.1]:33397 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbfBLGPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 01:15:03 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43zC782pvZz9sMl;
        Tue, 12 Feb 2019 17:15:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549952101;
        bh=7J/3ASKMdwsIT/MvyFQtK9vV2OSVWf0ld9/bxkYliII=;
        h=Date:From:To:Cc:Subject:From;
        b=sQRhpfrXugWzYraB7IiSnSi4cUNaKEtzXsVapQaZ+Ig+1sv8q8zjKcHeIEY5iThM9
         blVjCOEBuT3D6dsahv/IRvoC1DcUOS9DfhWg37IsV4Z3rQ0u0gDYnAQnq5er9tQckN
         asUUxkJp9ZFOmDfiZCMtr7v9EKz9aWqiMg89VXUiZ5OuvZrZiBUOfQiMdz1Z6qesU6
         ZIwmpmlhlRvo0pzHVTx7Rslg6/f8D7Lv6TEgCzZNJc1GfpHgP20WjFh8AmdU8jRsYu
         Chlq6aM6s9WRi3B2XLfTns55BTAoIfw7PWyI/z0wXNLp8BgFHKknSlfLCdY3nrkTYn
         /qBbPsC/GcrHQ==
Date:   Tue, 12 Feb 2019 17:14:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: linux-next: manual merge of the akpm tree with the bpf tree
Message-ID: <20190212171459.294fb74c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/sINFGrBoyrRI+Bmmjq1ZRaL"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sINFGrBoyrRI+Bmmjq1ZRaL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm tree got a conflict in:

  net/xdp/xdp_umem.c

between commit:

  e451eb510684 ("xsk: share the mmap_sem for page pinning")

from the bpf tree and patch:

  "net/xdp/xdp_umem.c: do not use mmap_sem"

from the akpm tree.

I fixed it up (I dropped the akpm tree patch) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/sINFGrBoyrRI+Bmmjq1ZRaL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxiZGMACgkQAVBC80lX
0GxuOgf/VFKxHbtCV3uqyCiE8qQUzfvpfmuqLvUKzx6fdZx5wUrwE/9IOcqSiY5P
Fs5WP3poIqs6OWNPElKspGBCmiWnBzqTBdVVKC8BYlo0AVJmrrqGqq72aMU0WIm8
gfJjwXI8naczhVPQRO/OzQsTlcvGLEX/Xi7DEGIVDzTYPqxuRXsIaTG7XtxPiW47
JqE3+aTqEtjwOYKCKdQJ5FhhniWuyAY2Sp+vBJAiBG1Ltt6UhnSc53G1w6uTtikF
GXWXQxgVrBIH9qhSBCV4kqU9BoA9lbES0b8NG1aNsRpbFApBHjzS5WpVc2ewqT17
3wiZ6gtFN8mVIkbuwrUefr1BEFZinw==
=sd5n
-----END PGP SIGNATURE-----

--Sig_/sINFGrBoyrRI+Bmmjq1ZRaL--
