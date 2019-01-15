Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A55C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFDF20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SAgWQuqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389967AbfAOUpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:45:14 -0500
Received: from ozlabs.org ([203.11.71.1]:39661 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728576AbfAOUpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:45:14 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43fMm66gwTz9sCh;
        Wed, 16 Jan 2019 07:45:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547585111;
        bh=v8OVTG8o0bybZxbhxI5hTdx0TUt/cjWq03SSDh+Df+k=;
        h=Date:From:To:Cc:Subject:From;
        b=SAgWQuqs6FWyrDaWN3ndUnYotLhJf0RTXV/FYvPbFxW8ymXSrGyay53+3nMCO0NDF
         VgpbrVQcRnd/SKPryTcgI+bsUVVVMOorZjotWhDuDRMoDjaa4UKQcX74mB267iHP6O
         9aBw00l0eW/5Y7tcA/tEh19FGflqIOY3oXgIm78WIoslbfvfaS9f1aSyDG4Rvm/fDr
         GTS2/yBJcoZAvTlOqCIeDx2JJKww/F2ApMj/acpBSm9ZJELiTUKbkc3lpfMEqe+LMG
         eKmKVkh8b6x4Rdw6UTDco6WdbRNm1YshqFflrSEMv48WdWCImH6otSLW+zWv0PNxqb
         kgyFMaXuCzeCA==
Date:   Wed, 16 Jan 2019 07:45:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anand Moon <linux.amoon@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: linux-next: Fixes tag needs work in the amlogic tree
Message-ID: <20190116074510.7c7e6a4a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JwLiueIBRTMFareA/PLW/UJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JwLiueIBRTMFareA/PLW/UJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

[I am experimenting with checking the Fixes tags in commits in linux-next.
Please let me know if you think I am being too strict.]

Hi all,

Commit

  90d2bf8975cc ("ARM64: dts: meson-gxbb-odroidc2: Fix usb phy regulator pow=
er failed warning")

has a malformed Fixes tag:

  Fixes: 5a0803bd5ae (ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes)

There should be at least 12 digits of the commit SHA1 and double quotes
around the commit subject.

--=20
Cheers,
Stephen Rothwell

--Sig_/JwLiueIBRTMFareA/PLW/UJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw+RlYACgkQAVBC80lX
0Gwo3gf9EiuOZIdh3hTk6RDXI6XcWLhYzK2e0I5Qm97mVT65nPEEp/tSgGLXHMYQ
I520HkAjumZEKLP+xtpPS1eGL2O5isXd//qMMMGIrVzpWLQzD92SWXiwHlKQMzrN
/bq2NSn1iAmNnz+Y3Fh1xyOwYTFa2UvdNeYm5XQrEbflE1qLDSDuRGeD0TdnqL95
ThZLPgMf8ZumSMhHcHqRJlsLt0Y5Cxyy3eoAoY3VS4A/I0Gfq86ZQbOfELj/dgCk
D6sLV02RF/9qj0XS6VndNYOqZCy7n2+6K/LDJwFYtkm4g0yzxgOPpa4n6Xg9doGd
wbTwo88Wts4s4g0ZoJDwVR3CnsfUqA==
=ciYL
-----END PGP SIGNATURE-----

--Sig_/JwLiueIBRTMFareA/PLW/UJ--
