Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0304FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98BB217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pUf+pAaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfBRUiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:38:51 -0500
Received: from ozlabs.org ([203.11.71.1]:55117 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbfBRUiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:38:50 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 443G142pQhz9s5c;
        Tue, 19 Feb 2019 07:38:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550522328;
        bh=G8WKPUXeotVxGJLhgIXc+4KXv15XmcBUQLbME+hgOK4=;
        h=Date:From:To:Cc:Subject:From;
        b=pUf+pAaDM/Z+7hg6SJ5WZHqt/N2r3bkxHhvT4iM9X/J96RYHWMKcRPuBhI2JJpaN9
         90miV9rpYfED+nAPJNd1tacJkYNnpbGw4V50OvANvP5fbTPGrCjUg/WT+vQjFdvB05
         +AQee/XOb8O8tsNZsUz2e9Wdg8poSkCvOUMGF+Xq2a5Olu32tyCHMQhi5eEx4ygXcp
         1Cv5InJ3KNB5letbiQlGOHnfm9frjr992YawGGvAxmE++qjUYcWZhBW015WlrWVnGU
         qBcHyxrewLsHaO3Z9W+Ab1tnHhI2wKelPQm455am6Jbw9HnV6qCueiC/4/H4ziT/B2
         tbQWJGepfy0nw==
Date:   Tue, 19 Feb 2019 07:38:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the s390 tree
Message-ID: <20190219073847.6f288b66@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/B9/EvsB9I=piEZuCoRd.Qe="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B9/EvsB9I=piEZuCoRd.Qe=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  b99740ef221f ("s390/setup: fix boot crash for machine without EDAT-1")

Fixes tag

  Fixes: 94f85ed3e2 ("s390/setup: fix early warning messages")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/B9/EvsB9I=piEZuCoRd.Qe=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxrF9cACgkQAVBC80lX
0Gy+UAf/Ze5thMdyBppz5qmN/BIEI0bSQ+hSYJ1MUnb3c7eVlFu5fn/6oJTyWNpc
kqk2+Gr9X86R5JM6JhTUv9hXzqNXc4ONyeB2HQLbkncQimeXh4gcVkvNS0VFEsuT
+ty74o0w123QTYcqIyI99ZOMpDtV+MBsHLQ1XZYom20sEztv+5Jm/r6HvtFYexEL
Rp0drPnRb0XYNPnjMx5elmkCFFxTNxpt0B36sDhsqgNiM5VuRxGD+rvbiiJrW9g+
EMjCOeXY4QdKK8ENobPx+MlxAnM0hU7x65iGb/ze0LISArMAiqmXEUUqbfdnhlaq
9usrqJ61WQzfwxpb88+VvVrADLwt1g==
=Llpo
-----END PGP SIGNATURE-----

--Sig_/B9/EvsB9I=piEZuCoRd.Qe=--
