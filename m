Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1056AC282D0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D016C2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VYZB1VaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbfA2Ut4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:49:56 -0500
Received: from ozlabs.org ([203.11.71.1]:36205 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbfA2Uty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:49:54 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43pzC300sKz9sBb;
        Wed, 30 Jan 2019 07:49:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548794991;
        bh=nbBOnrtPQ4q1chupqROTjNZZY1t+DeiAYfwjSEbZu8o=;
        h=Date:From:To:Cc:Subject:From;
        b=VYZB1VaS7xWIy/zZrLG7vhOB0TBOiYFjEvFlRsywb5aTxzRYYH/ksVpCMRKWm+qTt
         xswWKFNJLzUmZsnNikTxFcyszSxAVGhrmLKpl5k5onZ5Mr+Z6idcdIGH1js7pZZ6lt
         NRBOyayP1zGUnzuusmz6FyKgYDWvNOnblIb5sJ2ry+BGkd3VJMooQMNNu9gHKKut85
         1m0dsqPo9rxmbbYKA05DK9MOu7cXlIUur6n6PAPfU1yLR0OKz5VUfuCk8NinkR+D/C
         W6iV8n+Ja0JCvk+X7Z/YjS/haXKqC2GhT6oUkNtWDMn5ZMZMiicYbQ8m7koF5mmQnp
         ncPECXkjUNdUQ==
Date:   Wed, 30 Jan 2019 07:49:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Watson <davejwatson@fb.com>
Subject: linux-next: Fixes tags need some work in the net tree
Message-ID: <20190130074939.03c7ac10@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Ye_IUSmdmxYlZXhS7CsnT=z"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ye_IUSmdmxYlZXhS7CsnT=z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  1023121375c6 ("net: tls: Fix deadlock in free_resources tx")

Fixes tag

  Fixes: a42055e8d2c30 ("Add support for async encryption of records...")

has these problem(s):

  - Subject does not match target commit subject

In commit

  32eb67b93c9e ("net: tls: Save iv in tls_rec for async crypto requests")

Fixes tag

  Fixes: a42055e8d2c30 ("Add support for async encryption of records...")

has these problem(s):

  - Subject does not match target commit subject

--=20
Cheers,
Stephen Rothwell

--Sig_/Ye_IUSmdmxYlZXhS7CsnT=z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxQvGMACgkQAVBC80lX
0Gxy+wf/WxMHLhIt5mf7GXfKJMLjMM6ZVELxvHPWYHlf/E7WiMBqqVZ5x6/3qJbY
xBSOMP3pAcJBzcjoiHQNbO/0PJzypC0hKTLNvMg99iMNgPE84NnXQ1dxOUPfpgFB
9apZ78yUqLb/I973ne3jvqtMYg2yXwqGSap2fjuU8fogf/UMEkswMmfXLNCVCK9I
gWYFO6CjvgKjWjIBUcQR5ndnf7iEkNzynkWJVt2gmoy6r/TVGIDu6UIWuQHOOF8w
ct8ZEah8jESzsS5TOUZqlNHJyEwH04MKdYHSEVj12SjxQtbyPGE5u0A73z2m2S0y
DfCk+Xkl3LxvIrOuHPk7WDDy7mzUmw==
=LYvE
-----END PGP SIGNATURE-----

--Sig_/Ye_IUSmdmxYlZXhS7CsnT=z--
