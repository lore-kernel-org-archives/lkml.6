Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2058EC6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 00:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7D324238
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 00:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fRUUkDH3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7D324238
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753179AbeGDAVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 20:21:24 -0400
Received: from ozlabs.org ([203.11.71.1]:50947 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750716AbeGDAVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 20:21:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41L1r04pPyz9s3q;
        Wed,  4 Jul 2018 10:21:20 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530663681;
        bh=NZO2qxD66oczDk88VJujoKpNeV9fzLlOeIxUKA1aTIk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fRUUkDH3+gOTQr1/gDBFvVOnrUhpxDNQfM8H1RZFcAOvy0fejoc4mTh7saVOGm1Bo
         BNEyEN6h0XCMANK5EPIQwQWbGpBsuv2QDrbEVbKPZoabxiyXzNDxpzHp8R4qlNAFS4
         F/u9YXdV4sen1xL/x4SZkOAgnvF8mdMqHZEogAP/TmyUMiomf5/ny+uOwkOb2T88On
         Sp5vjiwJF/WxRMICz1qIJa3iN0D1siFIIk3nEOM/f+/enS8dWQCVK443f2FMDEB960
         NahHnDzRdRVyQ/f2+4eHmuBK26OSb5+sJD/YOtUTlKQ67HCL+e6PL+Pcn/PLWwIQOl
         vXdQxAM2/+TCQ==
Date:   Wed, 4 Jul 2018 10:21:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Norbert Manthey <nmanthey@amazon.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [build-check] scripts: add check_build script
Message-ID: <20180704102120.591e1074@canb.auug.org.au>
In-Reply-To: <01151c44-c3f7-c344-8e58-2e6b348960fb@infradead.org>
References: <1530186789-28808-1-git-send-email-nmanthey@amazon.de>
        <1530623539-650-1-git-send-email-nmanthey@amazon.de>
        <20180703154914.5d3e8f28e1d87e48180073e3@linux-foundation.org>
        <01151c44-c3f7-c344-8e58-2e6b348960fb@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/C1ko7lRZKSE=_y.8e1/xHZp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/C1ko7lRZKSE=_y.8e1/xHZp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 3 Jul 2018 16:27:06 -0700 Randy Dunlap <rdunlap@infradead.org> wrot=
e:
>
> On 07/03/2018 03:49 PM, Andrew Morton wrote:
> > On Tue, 3 Jul 2018 15:12:10 +0200 Norbert Manthey <nmanthey@amazon.de> =
wrote:
> >> +build ()
> >> +{
> >> +	local -r LOG_FILE=3D"$1"
> >> +	local -i STATUS=3D0
> >> +
> >> +	make clean -j $(nproc) &> /dev/null
> >> +	make -j $(nproc) &>> "$LOG_FILE" || STATUS=3D$?
> >> +
> >> +	echo "build status: $STATUS" >> "$LOG_FILE"
> >> +	echo "[$SECONDS] build status: $STATUS"
> >> +	return "$STATUS"
> >> +} =20
> >=20
> > The script never sets nproc.  So I guess this is a bare `make -j'.=20
> > When I type that on my (quite beefy) workstation I get eleventy xillion
> > processes and the machine locks up.  Can't even wiggle the mouse.=20
> > After a 20 minute nap (thanks!) it was still comatose so I hit the big
> > button (who writes this junk??).
> >=20
> > So you might want to take an educated guess from /proc/cpuinfo here. =20
>=20
> or use
> nproc=3D`getconf _NPROCESSORS_ONLN`
>=20
> or double it if you want to keep processes ready/waiting.

I have a program called nproc on my system.  It is part of coreutils.
--=20
Cheers,
Stephen Rothwell

--Sig_/C1ko7lRZKSE=_y.8e1/xHZp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls8EwAACgkQAVBC80lX
0GzqRwf9Haoym3iewNgcAj5VDsY84PuACdUpgJN2NVBfBtnws7VpnIu73C+4UX0Q
X4SbyhA7FsPVVUPXCBSpk69A4UOkJHh/SRuvxQ7QavL+wBm6ys3k9mIxkavCh0Oj
CbZCLJObh9818zMnmdQXgXLZBtSU+3PTEoazI7+jpB/xGg1osoNMi5ckXVrmtBtd
YTLpYGx9F0+LnA2YhGaEGRSNp5h9tGBaSET3tF6q8ozGQmRLBBxH/yho3WAmHZX9
cb8B5sd+X9413nkvTFAoQLotZkOdLGLSVekKwcM+kCBeDSYU+YUIwChSjPHcD2hR
try1Ywd+6oY9XFYHGT7gdHZ1a/YZ8A==
=Olae
-----END PGP SIGNATURE-----

--Sig_/C1ko7lRZKSE=_y.8e1/xHZp--
