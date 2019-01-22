Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1A5C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879D420861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Oy69+kvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfAVEue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 23:50:34 -0500
Received: from ozlabs.org ([203.11.71.1]:44745 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbfAVEue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 23:50:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43kGFM5WM3z9s4s;
        Tue, 22 Jan 2019 15:50:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548132631;
        bh=HZyWAOkyYGsgW+y1rE/pw9s/OJ9g22mrZBEf4lycMtA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Oy69+kvIQMmekQkq3RKh5oCQ1u/oXuObwi9M/JHuY2i33MUg0Th2QDisRzbZ2nefH
         iO8UuCX8BnvRW2tE91J0EI7czNFiyhBxB43CpR0WueWd3PAfWdsEKQlcGbThVufaWu
         7KS3Llumafokqoj/Rwr/AW4CiJ2dSXuQTUjKA2M5Snfhn7ziAvWbtBJfUeKsX2Pk6D
         v+YBloPLNfzwmz8473acJ6lP8rKbDaFIQ+j2utGO/pUgO5XpM66X+F21DoOJM8SgWV
         l29SE63u6S7zR/mKRgesvt+2pmmxp5qRmKGOTz88u0zcoHgocWANG/nt3KmIkJXn3z
         2RO/QmxyKG65A==
Date:   Tue, 22 Jan 2019 15:50:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the pinctrl tree
Message-ID: <20190122155031.65b46a9a@canb.auug.org.au>
In-Reply-To: <CAGb2v65=fa9aL3+wKhbkbeuAVAuFL_KUqSPuQCXveJXU=DJt+Q@mail.gmail.com>
References: <20190122094203.54570662@canb.auug.org.au>
        <CAGb2v65=fa9aL3+wKhbkbeuAVAuFL_KUqSPuQCXveJXU=DJt+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/B8zQFPn1sn1bkRsAbEbKN31"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B8zQFPn1sn1bkRsAbEbKN31
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Chen-Yu,

On Tue, 22 Jan 2019 10:20:28 +0800 Chen-Yu Tsai <wens@csie.org> wrote:
>
> Sorry about that. I've been doing for some time now.
> Should none of the tags be wrapped?

Generally they should be single lines (in my opinion) ... it makes
grepping for things a lot harder if they are split.

--=20
Cheers,
Stephen Rothwell

--Sig_/B8zQFPn1sn1bkRsAbEbKN31
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxGoRcACgkQAVBC80lX
0GyNlQf+OGChGS3usU0pPGKDKIFRcm1ict6MpMHoTdZH3QQ7iMbcSdzMRY73xmIT
aqvr4KE8e2lyp5p3JynWI9XAK/jfwCVmdWQPG0AvmEM3OZKFPI3191kOqOqbWYgs
bFZmOO9LBdO+p+qrPdHbblqAnCRzV6dDCzgX8HYv1Fc+6nU7joZEsFytz2r0RD1J
0yjnzdct+Euyx9fZhfLRvXHKVhtcVcU5CcJzvvpS2x9NOpx9KiR8BVRlU/f52/aR
Ld9Kfde2Q3ljyo8zSWXrEuhSlMtPm+EnQwy9Xw99qv80gyGM0i+ZSCAVEi8k4sIU
IdBkQz3dOVfSLY16ebJdBTNyj52PZQ==
=kqay
-----END PGP SIGNATURE-----

--Sig_/B8zQFPn1sn1bkRsAbEbKN31--
