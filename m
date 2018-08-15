Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EB2C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75F1214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EZMlTg+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75F1214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbeHPCnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:43:37 -0400
Received: from ozlabs.org ([203.11.71.1]:53637 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbeHPCng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:43:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41rR4v68SSz9s0R;
        Thu, 16 Aug 2018 09:49:03 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534376945;
        bh=IgqAW5OG3Gp3wcnqL8FW0HAhC+znoT0xIJFjBig2meY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EZMlTg+kTNnlsXvmBVRwgZbDdCKypQLlH1n9tZtdwBK5DrKsKMXpG1ECdfk68Uj2o
         Ae0g/Ep24J9rg4AmspsHfTupG2R5IqXDjxVe66fMIr23ZBvItuQuoSzF82OHbN6D17
         Kxsdor9UGCCo2uu4tovhVyKZOuulDBX0a5t8LANqtxji9HOTNs7JtMLpzIV8WLayzS
         vn7sPhunjkglMCSSqO+MDnScbGNKOeXAOuBOJgdaG1ogN3tezDKYLAM78aI5jgx0p7
         wiHFuLRCXpde1dqVOIAqUziK9gsZp0ehX6pOpCn+XMvUMy9lzyrPWqQoVD1E+UZyFx
         7eCh2a7HsbSVg==
Date:   Thu, 16 Aug 2018 09:49:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: linux-next: manual merge of the staging tree with the crypto
 tree
Message-ID: <20180816094903.7744e6b0@canb.auug.org.au>
In-Reply-To: <20180709141510.19e1a851@canb.auug.org.au>
References: <20180709141510.19e1a851@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/upyty1xtbrJvU==k2faYGk4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/upyty1xtbrJvU==k2faYGk4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 9 Jul 2018 14:15:10 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the staging tree got a conflict in:
>=20
>   drivers/staging/skein/skein_generic.c
>=20
> between commit:
>=20
>   e50944e219f9 ("crypto: shash - remove useless setting of type flags")
>=20
> from the crypto tree and commit:
>=20
>   ee55fe552fcd ("staging/skein: Remove Skein and Threefish code")
>=20
> from the staging tree.
>=20
> I fixed it up (I removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between Linus' tree and the staging tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/upyty1xtbrJvU==k2faYGk4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt0u+8ACgkQAVBC80lX
0Gy7xgf+Pu959NmJH1jaCFZHTYPqC4ac/D+oqPNzZw88GtrLEy4jKUTF55m4ksms
vO+xA5s5ET86Dqkqh5OP9nIGMoHb3r7RxRmxt/dvdjQpF5vfN8xJCifCPd0+WkEg
XOPETR/+FkeXhv8TjHtTSfGP4jsSU2xVJmcZdok9xhn2kKtlthWEqJK3i5Af3yvV
y9Frv+k0T3NOPkLwbP4TG1HFuMua2B0v3NzeenjwXTcGT/fZ4POC5+/9qfSGQrb7
OJ3CgcgC7imhY08zKVUjSR+EIeB5rZP7YGgIe5uWAbnD1kSO6vJ6X/YQZog4Y72L
IFy75ug07I4tL9ZkZaWLyfMEV997HQ==
=27hh
-----END PGP SIGNATURE-----

--Sig_/upyty1xtbrJvU==k2faYGk4--
