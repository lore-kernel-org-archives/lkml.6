Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4238DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CFA2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aUslwsok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfARAcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 19:32:36 -0500
Received: from ozlabs.org ([203.11.71.1]:44853 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfARAcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 19:32:35 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43ghjV59cCz9sCh;
        Fri, 18 Jan 2019 11:32:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547771553;
        bh=SqX4ugTmGJY8bUxe7DGBPR32E3ZEAliC5r7vOtllh+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aUslwsokUbwbVK0V9z1eqQI2ixKHv2dmiFEdbSz4evymK8DPEzUGlmYiza3zYa6PT
         EgTOErkQWwlOfxP7ObXYxxpczOh2Vtba2X1f1XvCo5pBt0dGRFFwQZiVacopCmgaRZ
         K/RRkptFIaZV4CJbI/N4MVFvl8yVhCwQThUW+J/hosFQwLfUf2equXk70795FYttlJ
         6k7+D0GyYZuMFpYadSaHen7zu/xusYCR5mTD6ObW/Wbs4QdFLtfusg+SqmjLWW6fiu
         YTPXuqndPekbtTs2S645W+C/bK+J73UCH7o72igvWZ0AGosFFTUsuvskDuzS4m6UPo
         Ly4go4YMC8LXg==
Date:   Fri, 18 Jan 2019 11:32:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: linux-next: Fixes tag needs some work in the tip tree
Message-ID: <20190118113230.3d11be0c@canb.auug.org.au>
In-Reply-To: <alpine.DEB.2.21.1901180044260.1647@nanos.tec.linutronix.de>
References: <20190118093135.39cf071e@canb.auug.org.au>
        <alpine.DEB.2.21.1901180044260.1647@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FhimryAl9WKVCOptJXBrdFv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FhimryAl9WKVCOptJXBrdFv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Fri, 18 Jan 2019 00:45:44 +0100 (CET) Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Fri, 18 Jan 2019, Stephen Rothwell wrote:
> > Commit
> >=20
> >   a31e184e4f69 ("x86/pkeys: Properly copy pkey state at fork()")
> >=20
> > Fixes tag
> >=20
> >   Fixes: e8c24d3a23a ("x86/pkeys: Allocation/free syscalls")
> >=20
> > has these problems:
> >=20
> >   - SHA1 should be at least 12 digits long =20
>=20
> Sigh. I'll add that to my sanity checks, but this one has to be as is as
> it's in the middle of a series of fixes pending for linus tree.

That's OK, more of a reminder ... the abbreviated SHA1 is unique now,
but may not be in the future - of course 12 digits does not guarantee
that either.  I am told we already have some clashes using 11 digits :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/FhimryAl9WKVCOptJXBrdFv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxBHp4ACgkQAVBC80lX
0GwCPwgAoJEVXnt9cOhGIZM6Bk78/iwOOLgxmyt/gJ36b/KuthmfzMEsKiGUO480
rw1dFYF0h9fV4l6fxKTSele8FPAiP/ZIoi+UOP7rgoSB3TrOMi8R1B59r7I62QZa
LvRWOcLX2kKhRf59Nb/vkUusDRCbL9y6zuJubKnr0iBcf1X5s4p4aqpDVv/4RPAK
B6HBQSFbxBGqEsUSl5ia79KZBC4F7VI5FRauq+2iDpFExAk1R2k12peSn+c5pkuM
GFYa7GeODL298syWkyDiYZ61TbD9xNRH5X8Wt8Kf0JHFcq7F5q6ybZC3T6E3uRbz
CY6hLp61qm9lA3LkiecY3PnMvN59tQ==
=W/Xv
-----END PGP SIGNATURE-----

--Sig_/FhimryAl9WKVCOptJXBrdFv--
