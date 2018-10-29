Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35FBC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4432081B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lwX16Qln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4432081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeJ3Ikq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 04:40:46 -0400
Received: from ozlabs.org ([203.11.71.1]:56987 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbeJ3Ikp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 04:40:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42kWY16zc7z9s4s;
        Tue, 30 Oct 2018 10:49:41 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1540856982;
        bh=P+43lsHtURQ4DqO5/oheyVDrmVTYn3+X1/rMuBJKb/8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lwX16Qln7YfWLn+czRcMRfUkmlUbRYfobYRkwU4s3Tt2295YfSIC7+S2rKhgXA/ES
         0HkpQESum1R0rTqaXXNG/v4/eju4ltsUfdVyfdYd/XYFyDUgHInrzPXPZzAbSz5yKE
         43DvLdrjctWLAtRgrqaVTlNVyohwmuzroLOH+Efi3uYpjZVAS2SxXenLMoLKllnx+5
         sr52ssEFoMYoHxZhiUOZZnNeDkVw6BXb6yBv6ZPVcxWokddGJkj7ADHUHTsIbDqR28
         Ox0PeP4phW3kbfwoKOdAdC4kiC++nu53jJDJuYMOBHv61xyW6mu5hIltW1O9ZrVBKc
         KC2nNNhRzC0EQ==
Date:   Tue, 30 Oct 2018 10:49:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: linux-next: manual merge of the compiler-attributes tree with
 the kbuild tree
Message-ID: <20181030104941.4fef7dad@canb.auug.org.au>
In-Reply-To: <20181030104637.382c26d0@canb.auug.org.au>
References: <20181030104637.382c26d0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/prGLk=SPVJhnyjw2advDw+v"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/prGLk=SPVJhnyjw2advDw+v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 30 Oct 2018 10:46:37 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the compiler-attributes tree got a conflict
> in:
>=20
>   include/linux/compiler-gcc.h
>=20
> between commit:
>=20
>   94c7dfd01652 ("kernel hacking: support building kernel with -Og optimiz=
ation level")
>=20
> from the kbuild tree and commits:
>=20
>   5c67a52f3da0 ("Compiler Attributes: always use the extra-underscores sy=
ntax")
>   989bd5000f36 ("Compiler Attributes: remove unneeded sparse (__CHECKER__=
) tests")
>=20
> from the compiler-attributes tree.
>=20
> I fixed it up (the latter just removed the __CHECKER__ check, so I did
> that) and can carry the fix as necessary. This is now fixed as far as

On reflection, that may not have been the correct resolution ...

--=20
Cheers,
Stephen Rothwell

--Sig_/prGLk=SPVJhnyjw2advDw+v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvXnJUACgkQAVBC80lX
0GzSMQf+Ia9raa6TFw2/b2jCHHACUhRRGuG5IZf/7uwEQHp93IMNzbcIV3IYPapM
nZGLl07sn+Mg1YYLQnARGcvJGKGkixabUa3mNYBtRJBkRukux7GHLZvUrWK2X9ww
2/Pf9MvgYUH6ZrQMu0KG7yzFL6ll7m+ogB3oKQ4YXBw5Pi0YYIUeFi+zi5ApYWQr
dWaZb9sutM0L3DT8VA8XdCAGtYOvbJhJ/jsprLrUk7ljFdl+LRkWRTDR/CaA7yXq
l+ZN2VSo8or5lX4v8tCdeC4937q1mrXwdQuNMAP/UvEiQDk3JAXHmM6mapcwUftk
vrO753vgO/udpDX4q2Qmwb/h5Z/VHg==
=WAqG
-----END PGP SIGNATURE-----

--Sig_/prGLk=SPVJhnyjw2advDw+v--
