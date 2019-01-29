Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF646C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD64720869
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fWLywBGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfA2U4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:56:53 -0500
Received: from ozlabs.org ([203.11.71.1]:41971 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbfA2U4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:56:53 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43pzM54BBBz9sBb;
        Wed, 30 Jan 2019 07:56:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548795410;
        bh=tXsRsIcIwjxLiDD95IDaFRxMzzaojHLLyalgclT9puw=;
        h=Date:From:To:Cc:Subject:From;
        b=fWLywBGhdX2l0J2Iu9NablrFJ4TpgPUHvy0k6DREXLagpKdzoP04p6HhtJ3+MYlbI
         oF1DF7ZLG/u6nGb45ogdBZV06QvBoIEeVr/Ci9vbMIyMhM5gw0zUVIi4g9H4rH/EU5
         gPNvD7hucB8p79hlBqwH8VckIeNuAY90QZIA9N7W2RlNSlB8R7nFWki7pVLIp3WfSX
         HAF8W76F28iujfXfcsJcDBBmPtf/4NqP4GBtdQi2HXv+Vojut4npCqoC5clSyqpCNF
         z0km1pYs2LAuMbNIud6feQwX0AloRrd/+GNziDyYYwM+IYaPH0guia3C1xsdxtLAgY
         /w0vFFilMQwDw==
Date:   Wed, 30 Jan 2019 07:56:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: Fixes tag needs some work in the xfs tree
Message-ID: <20190130075647.53e86078@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/RicaNw4dIu0b2+hrLAjDX7W"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RicaNw4dIu0b2+hrLAjDX7W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  4ea899ead278 ("iomap: fix a use after free in iomap_dio_rw")

Fixes tag

  Fixes: ff6a9292e6 ("iomap: implement direct I/O")

has these problem(s):

  - SHA1 should be at least 12 digits long

--=20
Cheers,
Stephen Rothwell

--Sig_/RicaNw4dIu0b2+hrLAjDX7W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxQvg8ACgkQAVBC80lX
0GzruQgAjaZIiKEwYGbf7nYMnVQlLn58+AOaEIMAZQsHJPcrzx30mfHWnYI4UbDk
Ay4n4hTFXNBVptN80fqrD5W1gQs6vSFZwq1wIpvf12+TfI7Uz9nSxh3CDCAQ3wmQ
VG9AaYk4YEgThkkyAX5hwEPQFumvfvgFcqf5sFcwiNg++QN7DvN6mosg1nnPFQWO
uhoLj0M8iJLQYPDb2wFWgqorhVm73cpnMgAVlVzPc3ilh5o0N+O0sutEiGIvi0/1
r5alsoQy0MC0KdtXrv+1oCfFXc03EkLNLUnLq742M3FH23peuZPXKX7Pm1wYEdEz
DD2YxPAOgQuF7aD8ezi9Wnwu0L74tg==
=McsE
-----END PGP SIGNATURE-----

--Sig_/RicaNw4dIu0b2+hrLAjDX7W--
