Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504DEC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 03:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33CB2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 03:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MxsjQzkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33CB2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754842AbeFQDlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 23:41:09 -0400
Received: from ozlabs.org ([203.11.71.1]:40939 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754240AbeFQDlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 23:41:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 417g4K4CjMz9s19;
        Sun, 17 Jun 2018 13:41:05 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529206865;
        bh=MX9JPPOAFVERmu/usCIIWCNp6Ttgkv58/RfdxzhqvVY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MxsjQzkwB0wA7oMcthU3A8j/Kgzdxfmef4e12yHcMeqXWOKpelw6fSDcezuwoUXUQ
         ucDhQKcspD52sJ/oekvzosT2KyENR97w6X6cFL/Sd50M4x//1pksAU13FQ5hY5/voX
         COY8M4o1yvx9vHYhPIscGB4Avpdz4jl87KPQhTs10v4Li/zSCgg1hX/POL+SDSu0uK
         5P8mcOo/pEtncaGhNCG60Zmtc2CEJXyejbGti00nZdwNKojQlnyT7GjrxhSlwsk9UH
         1ewP+P50867splruDNo0sos0zewOmoEEjF1nykeh6y/+BouFoOatMeb16wGWElraFm
         AH72Wmf8+hg9g==
Date:   Sun, 17 Jun 2018 13:41:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: XArray -next inclusion request
Message-ID: <20180617134104.68c24ffc@canb.auug.org.au>
In-Reply-To: <20180617021521.GA18455@bombadil.infradead.org>
References: <20180617021521.GA18455@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//10i7lQzwXr2dcjDSpTezyV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//10i7lQzwXr2dcjDSpTezyV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Willy,

On Sat, 16 Jun 2018 19:15:22 -0700 Matthew Wilcox <willy@infradead.org> wro=
te:
>
> Please add
>=20
> git://git.infradead.org/users/willy/linux-dax.git xarray
>=20
> to linux-next.  It is based on -rc1.  You will find some conflicts
> against Dan's current patches to DAX; these are all resolved correctly
> in the xarray-20180615 branch which is based on next-20180615.

Added from tomorrow.

> In a masterstroke of timing, I'm going to be on a plane to Tokyo on
> Monday.  If this causes any problems, please just ignore the request
> for now and we'll resolve it when I'm available to fix problems.

No worries, I will check your other branch and if things are still to
difficult, you will get an email and I will just drop it for a few days.

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

--Sig_//10i7lQzwXr2dcjDSpTezyV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsl2FAACgkQAVBC80lX
0GyZmgf9HRW8/VuzETFcFcp0l4cXJLhNuCSRRP4FXGPKh6KJwwf0FIEW3hmwqoNj
ifKVtyBMtcLg3I6RSizxtAonQp6Cg8+pa84MA6B4I+wP4Dpb7OuhonqRd88oLn5J
7C453g0Deoq4v0vOwXb36WnaxHmo/HejWa8UFXwS9HuTWqCYWSshvWHyXLAUX1Ke
7XPlDXin/YnqxEyHMQokWI4YX1IO2JBzytqrDUPKtL11k20zl0C4JcAEJCTFG5l0
U8vhofT96EUCqCD9Ql7CC7mJIHo5yjZk0Arubd/RgcIm9RV7GWuua3jd//ElFaDb
hnwctZDxCzIYpKHRv3kDGPH2AORxoA==
=xx4Q
-----END PGP SIGNATURE-----

--Sig_//10i7lQzwXr2dcjDSpTezyV--
