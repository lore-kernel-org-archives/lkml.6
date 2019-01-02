Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B80C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424C02080A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="F+aYljxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfABAhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 19:37:08 -0500
Received: from ozlabs.org ([203.11.71.1]:48717 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfABAhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 19:37:08 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43TsZ81Nzhz9s4s;
        Wed,  2 Jan 2019 11:37:03 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546389425;
        bh=okOVSWn7TcvwQmVXsAke0TXZ5ZGZkXq0He958DKDqSU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F+aYljxzqykVz3CcyIOgCEwp7V+m7kFxACLFMAGpuoxz81INrjlstd5O+kcohMpzM
         o9Ylzr7Egj5Xdka6e4wEKJcaHX8D4NCbZWe9vSC9Gq652woL2ssTSdVPFx/lJpENSW
         gNVMFi2SNeN/nJXBq7XhQpUKsHzsr4AMKUbcsOPsYBG9MXkXRU7porIWzL85dkJFcS
         i4Zd2JeCgWeE3Wff5LTJcyVXQBOim6wuRfCSXak+L4mlW8TmedHy8T0NCNoehZ1uKq
         wMqITN/ogwaC/z0dIzFbflP9ithVoltvNZ0TqU/RLDYVLbz4n3ehMjQMoqwxQQnWP0
         FJIrH9lk4Jfbw==
Date:   Wed, 2 Jan 2019 11:37:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>, Eric Biggers <ebiggers@google.com>
Subject: Re: linux-next: manual merge of the jc_docs tree with the fscrypt
 tree
Message-ID: <20190102113702.6e8888b4@canb.auug.org.au>
In-Reply-To: <20181207115340.2465a854@canb.auug.org.au>
References: <20181207115340.2465a854@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//ETDC9oO9CAGT2bX_9x3odt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//ETDC9oO9CAGT2bX_9x3odt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 7 Dec 2018 11:53:40 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Hi all,
>=20
> Today's linux-next merge of the jc_docs tree got a conflict in:
>=20
>   Documentation/filesystems/index.rst
>=20
> between commit:
>=20
>   1b71a6809f96 ("fs-verity: add a documentation file")
>=20
> from the fscrypt tree and commit:
>=20
>   7bbfd9ad8eb2 ("Documentation: convert path-lookup from markdown to rest=
urctured text")
>=20
> from the jc_docs tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc Documentation/filesystems/index.rst
> index 818390c32be6,ba921bdd5b06..000000000000
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@@ -360,13 -360,13 +360,24 @@@ encryption of files and directories
>  =20
>       fscrypt
>  =20
>  +Verity API
>  +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  +
>  +A library which filesystems can hook into to support transparent
>  +authentication of read-only files.
>  +
>  +.. toctree::
>  +    :maxdepth: 2
>  +
>  +    fsverity
> ++
> + Pathname lookup
> + =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +=20
> + Pathname lookup in Linux is a complex beast; the document linked below
> + provides a comprehensive summary for those looking for the details.
> +=20
> + .. toctree::
> +    :maxdepth: 2
> +=20
> +    path-lookup.rst

This is now a conflict between the fscrypt tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_//ETDC9oO9CAGT2bX_9x3odt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwsB64ACgkQAVBC80lX
0GxG/gf+Mecmp6Kpm4B6lOe72Tj4ghgmOuAyqo2AtmmWjVFC82CmnlXbbAi39qPX
zzBjVV6twLwKMdWJbHGw4PClld30n3iup1o5LguljlhLJrbpHXs0mXIrmZsQx7H/
ATIfONXJwpF/M9Yzoi0RmAnoYf5V0yIQIa7sPLDptSpWwoBECvJAtk/8xDhtnm07
+WnDoMHucuVqd8BELHdoOGN86hO8Lw4yQYheKxGeikNj4JCj25Ob6KzOe6zvxj3t
I9Yz3UaZOZlnarg/YUUl32iKEXDdpRIHqbm5zFxxFaZd495Z1+ZrR1zS3/U56GZY
IRSKpkrDVCFucZMQKrYBuLYNWtXNmg==
=tEHw
-----END PGP SIGNATURE-----

--Sig_//ETDC9oO9CAGT2bX_9x3odt--
