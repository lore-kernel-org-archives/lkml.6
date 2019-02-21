Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C71C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFE9207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Oubu607o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfBUNKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:10:35 -0500
Received: from ozlabs.org ([203.11.71.1]:46051 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfBUNKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:10:35 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 444vwR6BfTz9s6w;
        Fri, 22 Feb 2019 00:10:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550754631;
        bh=VyBi7tizfr5EXlIi1or/xg3sXLrex4CS72pxDiVm7OA=;
        h=Date:From:To:Cc:Subject:From;
        b=Oubu607okYHQpc3TCa6h7Uq/ZyPhrwrJWtTJ7N26cfX3sNjp8xUtXXWUOnaycowcC
         NZlyyINvrmVKYVA7F5+uAc32UW5jOan24u+OPJYyS8DkOcGNQoEDFQaudrG9XuO9uO
         NG6oOyFKheyfAZHTYnLC6EsWk/SHnX5WqmDges9ctv2ogvy5MLOORzw3y4idf4T+vq
         Pu5q3Ne1KVR6KTqAh9F7b0cCqoAUXQznL37pcgiqEzjAjfzwt8gDkbP0f4PjG2kYXI
         YRTjFFqGXWXdPYmM59xVFDMR6d0hFBwrPSDE9U9A3ti5L8QP2nAv6JJHJdDb7AKnC3
         ROqCnK8HtXArg==
Date:   Fri, 22 Feb 2019 00:10:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: linux-next: Fixes tag needs some work in the sound tree
Message-ID: <20190222001029.03c14a16@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//8bgML0XMvcBgnKBnLQAEFd"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//8bgML0XMvcBgnKBnLQAEFd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

In commit

  de73e99af971 ("ALSA: hda/realtek: Enable audio jacks of ASUS UX362FA with=
 ALC294")

Fixes tag

  Fixes: 4e0511067 ("ALSA: hda/realtek: Enable audio jacks of ASUS UX533FD =
with ALC294")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_//8bgML0XMvcBgnKBnLQAEFd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxuo0UACgkQAVBC80lX
0Gz8QggAhXz5FXPnGxbAHVD+5ZUAdpzl5Xz0fOhu/d+Vyjhm1HHEmYzOSWblF7fi
hIBruh0DddGLt2V1j1hTHvBOeWmqM+nxPDiE0HXw7lsAMO5QEVlgaZrCyrCSQbZb
7rAKPvlFyEPE7QvAxYjMaPnLwOoE8Glys7HZVCdfQvM9vgAQ6qDQa+4sjvDl0/lh
38rriCe99J3R3FSsHFrCpel9YHnC5bNDTzgw67XxVHZTBR7/+/IoEUadwCTSG17+
wsYqeitjgpvQeaMHFVhcI2AdI98CZLy9ldrs3oH0MeIwi1Vxj/5arEpIkCLJIBem
f1OX+JQx/azvrq6xwpmmNuL29zJoLQ==
=eFle
-----END PGP SIGNATURE-----

--Sig_//8bgML0XMvcBgnKBnLQAEFd--
