Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147B1C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF05D21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="C1WWjaYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfA3ADA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 19:03:00 -0500
Received: from ozlabs.org ([203.11.71.1]:34321 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbfA3AC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 19:02:59 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43q3Ts0MFMz9sBZ;
        Wed, 30 Jan 2019 11:02:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548806577;
        bh=4AwqajeFbp6Th9RHFA/jMONf6O+aLgjSulyNNi7hv0k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C1WWjaYoi28Z+MsglJo6HDhpbG7ZTAoEBP5ZxaS1u9YyAJHUf5NsRHhbEcM2n+hr1
         903mGXOslTZtRi5T1Z4GCtxnEet98LJpGMEFdouFXiTAwtgnng8qlMcX/o//fG0fJG
         4rFVx1D6qFA8tVCj8d2HT4/FpqWDgTX0Cl50OoNYkgjK+n8x0fZkKdZGaMCpd4tVqz
         5A0J5YyxGzBmmLxZZBxcqbmEt/J7o5yldgfy0Lv3wVfBQ77dzxR9OMHfG+kVsn4Z3c
         0RXxU+B4T+nLtDwKRQCwGuIAIHipN515mcmAYolic1+ZGhvILabu8QsHgszyGDNrNg
         mXP4s8j18Y3Kg==
Date:   Wed, 30 Jan 2019 11:02:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: Fixes tag needs some work in the xfs tree
Message-ID: <20190130110256.41722408@canb.auug.org.au>
In-Reply-To: <20190129234338.GF4205@dastard>
References: <20190130075647.53e86078@canb.auug.org.au>
        <20190129220802.GC4205@dastard>
        <20190130100640.5c2512a4@canb.auug.org.au>
        <20190129234338.GF4205@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Ju_2Cx3TjixfKLr.f9bx+WN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ju_2Cx3TjixfKLr.f9bx+WN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Wed, 30 Jan 2019 10:43:38 +1100 Dave Chinner <david@fromorbit.com> wrote:
>
> .... and in replying to correct me demonstrates the exact point I
> was making - that documenting what configuration should be used to
> avoid the warning acheives far more than just reporting an error.
>=20
> i.e. all those people who /don't follow git development/ and have
> working configs that pre-date the "auto mode" or it being made
> the default now know the correct way to configure their repository.

Point taken.  It now says:

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").
--=20
Cheers,
Stephen Rothwell

--Sig_/Ju_2Cx3TjixfKLr.f9bx+WN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxQ6bAACgkQAVBC80lX
0GwRSQf+LZaMR2p3+rsykF4i5BASfhPanraR7vwDoZ+4uvD53JMFBn401k1J1eH4
9lzUDTrAqzAtbwJKvAHSKiXyMcs4GFPTjzo+pon34imta6FeMB3iOuoz7ENZQny+
Jy9+NOiansUetSm9qbkEkNGhSvaNzZdgKNKhwUuVDMEU2+8wAJaBNNGhsFaLPqT2
Att2ce29ntdWz/BmfPKZLCPO4bWzvOxkcD2AWlICUmb08H1jwhEdFyj/FukJTxrq
d0SqA7jvJXyUZl/QVOmo1nsaC8Ljb4qLHM+JeFVYFKQPp3rZVrpTo7nQcdMk4F2k
qGZPIxy3U/f349/790K17e3fEx9jsg==
=VShS
-----END PGP SIGNATURE-----

--Sig_/Ju_2Cx3TjixfKLr.f9bx+WN--
