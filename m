Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D155C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521092147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DvlADPbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbfA2XGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:06:44 -0500
Received: from ozlabs.org ([203.11.71.1]:58117 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbfA2XGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:06:43 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43q2Dx15phz9sBb;
        Wed, 30 Jan 2019 10:06:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548803201;
        bh=uW3LjPfReF92cfZK/tF9nkl3GOeFk/ODMueK8SrJPk4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DvlADPbWi4lQJLzgIaqtBOUtmPIp+OwmqjHxwc+Ws+2xPLDEZEsE0M0sYUEHC1qRl
         30Br1JiO3mJ90n8iKpVH8fH5o2/bmSmK8sqUpqPoUJTNs0Kg857I0wnH4caDZiLsMd
         PwbPpOpZDvo+ivawSeQMLPe6XCbJ3AtF8zkuy9jdupZ4rcCkmGxDYCXO3YBIx0Us6x
         iimG+h3DjzfiFK5IPtUEZF1yU+Z/oj/sLByqKlSOcsuNx+4U1TP182GM2E3tFQxY1p
         ORuM0qjqQ8jjEq/1cChwQ3Pb8iWfsX6FrznbyMqT6UV6y8ekB4Tety1ZssvjmrIBLw
         FItU7DyaqR3DQ==
Date:   Wed, 30 Jan 2019 10:06:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: Fixes tag needs some work in the xfs tree
Message-ID: <20190130100640.5c2512a4@canb.auug.org.au>
In-Reply-To: <20190129220802.GC4205@dastard>
References: <20190130075647.53e86078@canb.auug.org.au>
        <20190129220802.GC4205@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iLFP5jwk9YbZv+n5EqBFhBM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iLFP5jwk9YbZv+n5EqBFhBM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Wed, 30 Jan 2019 09:08:02 +1100 Dave Chinner <david@fromorbit.com> wrote:
>
> Might be worth adding this to the boiler plate code:
>=20
> 	This can be fixed by adding the following to your ~/.gitconfig file:
>=20
> 	[core]
> 		abbrev =3D 12

Actually, since git v2.11 (released Nov 29, 2016), abbrev =3D auto (which
is the default) means that the default scales with the size of the
repository.  For Linus' tree, that currently produces 12 digit commit
SHA1 abbreviations, but will probably soon become 13.  So the best
currently, is to *not* set core.abbrev (or set it to something above 12
(for future robustness).

See
https://lore.kernel.org/lkml/20181220000112.24891-1-avarab@gmail.com/

--=20
Cheers,
Stephen Rothwell

--Sig_/iLFP5jwk9YbZv+n5EqBFhBM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxQ3IAACgkQAVBC80lX
0Gx37Qf9FSpK4OGd25bXQtiBYLML04zl/2Do252BnI4Gzn0uuvVPIrqh/d7585gs
nF2aL/pWKIDFXge+WzbD+Ki/J3XKMj3NnTHKw6ODd5b2H2EViO+RRv/6hmRdFRIU
8bD8LwsMIudDw43IF25XvOGTEyIAawjwXJhWplho2nciAg30PgsSMsw7UHp7JFF/
vHP3QTI70IC0xjyVH0PloBbhWbTK451LtqbIuum5JVftmy4w1trpm3QHGWfMUS+a
3Mk3JYgcNofj6d7g3TovqaNDAnMQ/CPMox5T2bUs4JZGMtJVcYyHzYJe40L2UY5T
uTZUQFUBPqwbqPYwKZqBxEbCder43A==
=dZmb
-----END PGP SIGNATURE-----

--Sig_/iLFP5jwk9YbZv+n5EqBFhBM--
