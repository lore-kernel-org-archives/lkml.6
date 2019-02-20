Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172FFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDE320880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="b+q1Pdcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfBTUio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:38:44 -0500
Received: from ozlabs.org ([203.11.71.1]:37309 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfBTUin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:38:43 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 444Tw13HDZz9s21;
        Thu, 21 Feb 2019 07:38:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550695121;
        bh=qIlAy2zURB8dRxbyHDp2p2Oi42J1us7elj7NpBX9qp0=;
        h=Date:From:To:Cc:Subject:From;
        b=b+q1Pdcf2WjS4/AdZWAd+jDjef7Qb2kThS7jlsGYMlPBCZDplyRC7Bs7LqsHJtBnV
         /GF4byD4y5Q2yCRtMTaPXx6EhlJdB67ki/f1o4CMm/x6gB4Dkh4ZZSa40SdFd6/Qfn
         WiMZs64EntzWfa5HDJkOusNTF0vyUI4UpZRpm9LQ2yPWDLkkJZw0MyXkkJj3fmktN+
         7/JwbC+K7/wNLitJt1tCN/fyUGN1leqgVt5mj8E4VrGLDL7PXH86FYKqyZyq/E8/Jv
         l4MIuUbGlpVjjiTGBbekd6jaAI6JFTbHW/2C0pHL/c2yPEA2/qNbmVm0kkWAp05xFe
         9u1V6lVDG4bkQ==
Date:   Thu, 21 Feb 2019 07:38:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <james.morris@microsoft.com>
Subject: linux-next: Fixes tag needs some work in Linus' tree
Message-ID: <20190221073835.7a18f007@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/n5nf79UKNxZ+c28yIBKyNxN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/n5nf79UKNxZ+c28yIBKyNxN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  822ad64d7e46 ("keys: Fix dependency loop between construction record and =
auth key")

Fixes tag

  Fixes: 7ee02a316600 ("keys: Fix dependency loop between construction reco=
rd and auth key")

has these problem(s):

  - Target SHA1 does not exist

--=20
Cheers,
Stephen Rothwell

--Sig_/n5nf79UKNxZ+c28yIBKyNxN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxtussACgkQAVBC80lX
0GxO8AgApex+74qOgOh2047i2KJe/fCQk/X+t9m9uLFdZF/gho78BfoFGTGRkVAv
aPUqizKZRX/PrYkxWShAdxXbSLXiyhbIDvhtspnOAsGpH2/oWHXRY2N91i++0w+r
Lso14pXoPRF0svi+E9cTjFWd8hJleuIlTbsKNSdyOkSlrvEqvJwLZKr0eOf55aea
1PLcY9nbb+jVX0RsNCj6HakxUy3XRSt99h42zrScWdKvoYJk/8hWo5HTtDociGz7
i16wjhKqZBh8derwrFNJVean4jxDET8yGSGGdsLPiFRL14SXEWXd5BPaj0bUbZOG
rve+ee5j1WE7mqp3/ODBcLyF8oAJCQ==
=m1GQ
-----END PGP SIGNATURE-----

--Sig_/n5nf79UKNxZ+c28yIBKyNxN--
