Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1727C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 05:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818C8217F9
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 05:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CAXsH38B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbeLPFXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 00:23:49 -0500
Received: from ozlabs.org ([203.11.71.1]:38587 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729069AbeLPFXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 00:23:49 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43HXkp5CSkz9s3C;
        Sun, 16 Dec 2018 16:23:46 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544937826;
        bh=lrLyyLQKTLUZk3gxF58a0m7cq9LLQtsUiEcmOdbyeaM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CAXsH38BwetJ0W0TMZ3x1yw4PA87bzv4oaxByFD4k0SA19b4HAQlXhVZQLGl0rds9
         blajzSFl7lr5o7Po9HIfzUMTm3qARLxgcLWEJJD4QbBUQukuM5Y4BvmNdvJgEPd/V8
         u/3e93GRozBosqgrCRaH+Mqkwl0IpuABduirdvcBGX+c16+lQ3K9G/+fNGJVmnTu41
         ahpupR3lhnQ7Oi4zcjOCeIPG0Ma9snwYoOHrDAbTQj0cFj3L+1RGUeIBAYI7AovGE9
         dJY5B0ALsiI52HMNUBi26IAMEbixTTay19bWshiZcF3Y/2MiX4/5vP0GIAX+GxV2L6
         xO25AgjQeUU6g==
Date:   Sun, 16 Dec 2018 16:23:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-next] Request to add auxdisplay tree
Message-ID: <20181216162345.24fa1876@canb.auug.org.au>
In-Reply-To: <CANiq72=EefCCj=ErujVHZesn0aiO5aDT2tKobzUCVw3aTsRS0A@mail.gmail.com>
References: <CANiq72=EefCCj=ErujVHZesn0aiO5aDT2tKobzUCVw3aTsRS0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xW=uoNGq3157LHUHVF1MAIz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xW=uoNGq3157LHUHVF1MAIz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Miguel,

On Fri, 14 Dec 2018 17:11:09 +0100 Miguel Ojeda <miguel.ojeda.sandonis@gmai=
l.com> wrote:
>
> Can you please add the auxdisplay tree into linux-next?
>=20
>     https://github.com/ojeda/linux.git auxdisplay
>=20
> It is extremely low volume, but from time to time there is a patch.

Added from Monday.  Out of interest, will this tree be sent directly to
Linus or merged vi some other tree?

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/xW=uoNGq3157LHUHVF1MAIz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwV4WEACgkQAVBC80lX
0GzRhgf/SXcTPiWLNiP63WWI2ynEkKjwrDr8y5kVrfHUKpaHYPKdrOjdqlk5DOuv
n7AsUGE4gMHyO2fE0RzHIoraC7nkw/FT50JlqdAW0y1FEmE3Li2aFH7ZUqFCM/nQ
RuB0WKEqyWgNFMGefZfbRVu3fuMUy73dmtoLL8R0FKTEGDT/lLmHATyUqtFiZ70S
oeUGOPz26voiC3s8xjFpIQVqQaSEMR9YCvT+n9Oy5fGx98GmX6z+y1b58Dtp54pM
G4eEg01y6KyMjzBxLZoH+HgHf50k2C6HYlmgts1FiOTGNq2XMP2MnnFHxG1T++XD
E6sHg/k3Zgh21LPFikj0bEfTgYNdaQ==
=tZ95
-----END PGP SIGNATURE-----

--Sig_/xW=uoNGq3157LHUHVF1MAIz--
