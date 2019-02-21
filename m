Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC75C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AA72080F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qe0j9A8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfBUURO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:17:14 -0500
Received: from ozlabs.org ([203.11.71.1]:55801 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfBUURN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:17:13 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4455Nl0vlpz9s2R;
        Fri, 22 Feb 2019 07:17:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550780231;
        bh=hGv1aSF3somp02UQmIb3nFPhBDkGELnqqrx+uy1W1dU=;
        h=Date:From:To:Cc:Subject:From;
        b=qe0j9A8NEAm0VWKtUTELZUHbuwcj3YqWJSlcyQT6xelCk0GLQgaJ/qA0KPYyGLvx4
         i/HvUhlhwo2WQI4/4IwLh+mnXkUvrXGRYZQMLvOu0g84TboTrmEB7abcS9MU1zbAlG
         Us9BCuVQYa9fIvwcb+CiVekXizROpldOJBX5yj4zcrfNePHEVJ+lBh76xw1InA7ATm
         LQVCKkxH/WHTFEed2sALOD64WbnfTBWOP8I/YGrB+vhJD/bFqdvkQnFJPyzc9CWXB0
         XIFYKiSZXbznJum4PCO0Yx2pNLnpd5w5qsdWIAtGUiG/n2DFsjcnserRJBDpSP9ESH
         K/pDw7zZKjFNQ==
Date:   Fri, 22 Feb 2019 07:16:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Subject: linux-next: Fixes tag needs some work in Linus' tree
Message-ID: <20190222071655.31e0fdbd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lHrgtj6XcjRWGQLRBff+fWi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lHrgtj6XcjRWGQLRBff+fWi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

In commit

  1062af920c07 ("tmpfs: fix link accounting when a tmpfile is linked in")

Fixes tag

  Fixes: f4e0c30c191 ("allow the temp files created by open() to be linked =
to")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/lHrgtj6XcjRWGQLRBff+fWi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxvBzcACgkQAVBC80lX
0GzWPgf/eJLLEeL9nQ+U1BVDfIDO7GHG7/kua8bUonZR+bQVf7gDw9D+WwRotbP1
9GVkOZA5TcwHh2F2TMgXj6UzL4W6U3VrvRDSnhByYw0LktQZyKZ1jDc0uvrP7jDA
kSj1rKf9dsUyvUkD8DSEZAfS1n3DgSXBbbnIUXPWUCO47f1yvClaD2pZRQ5gLHhZ
Dc5dzAz/xVLesmdnV3nEB5tlFrK2tc5DjdLrfLiuwMy18RvuX/3CPmZMSDxhFJyM
EvjsvKExk3n8LFAiMEgf4F9O3pR77NzyN2twqVrSOpb8LqocAWCAFw+nEIu02NdY
w43NLPvM0MFDSbaTGDorzrJxvja1Fw==
=yAbA
-----END PGP SIGNATURE-----

--Sig_/lHrgtj6XcjRWGQLRBff+fWi--
