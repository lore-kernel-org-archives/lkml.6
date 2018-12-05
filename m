Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B9EC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B4320989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B4320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbeLEBdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:33:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbeLEBdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:33:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BDCF8C057E06;
        Wed,  5 Dec 2018 01:33:10 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-74.rdu2.redhat.com [10.10.112.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B46623844;
        Wed,  5 Dec 2018 01:33:09 +0000 (UTC)
Message-ID: <a15a43d96bdbfc7201df2ea00e813fb4c0a323a1.camel@redhat.com>
Subject: Re: linux-next: manual merge of the mlx5-next tree with the rdma
 tree
From:   Doug Ledford <dledford@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 04 Dec 2018 20:33:08 -0500
In-Reply-To: <20181205120706.294b9422@canb.auug.org.au>
References: <20181205120706.294b9422@canb.auug.org.au>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ODxKlQt9+ykmbI0CeVSH"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 05 Dec 2018 01:33:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ODxKlQt9+ykmbI0CeVSH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FWIW this will go away in a day or two.  I merged mlx5-next into rdma
for-next in order to take a series that depended on it.

On Wed, 2018-12-05 at 12:07 +1100, Stephen Rothwell wrote:
> Hi Leon,
>=20
> Today's linux-next merge of the mlx5-next tree got a conflict in:
>=20
>   drivers/infiniband/hw/mlx5/main.c
>   drivers/infiniband/hw/mlx5/mlx5_ib.h
>=20
> between commit:
>=20
>   36e235c88299 ("RDMA/mlx5: Use the uapi disablement APIs instead of code=
")
>=20
> from the rdma tree and commit:
>=20
>   81773ce5f07f ("RDMA/mlx5: Use stages for callback to setup and release =
DEVX")
>=20
> from the mlx5-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-ODxKlQt9+ykmbI0CeVSH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlwHKtQACgkQuCajMw5X
L92fpQ//T8hLm2O9WblvQt6R4t4H+uYtr2UAo/Q2GU5/riOpZ+UJKV2iYCIgvl/V
ce+wl4DxWneKjkBtCcJczlXs4oXEE37NstOGNZog/bj4h8TKuX8XQBrm28BoBFCe
5DziJigSvBJHQnXR+FPmVt8xnJ4ZAjmH93LcA5j3Mue5ua+e23YfQ8M56Lz/OM7/
mdDp3Ady7kH86tqDYJ2m4m2RFvz+pt3WzkIa7XyVTPKtogAQ0T680LsyJWvMG26c
FBtNMNbA8JswwzQJU5yoJWh7BVZSNE4GHJrID8HOmop5fkvVTW1H2YUr2sozBFtJ
yyE7qO9y9CKpiGltN7FSzuneTo0RgtXkauMh5VA4kWd3mGG6AGtugVzw4DpfVT10
x5wQHUM+367Q13ZvwI3S6y3h9aLvDsrm9Iz7JHwIUKM+IYa1Ak2JagAqAgm6aK8m
BQksWiWqDMwY5acKwe3zNSs3S7WWmBwEmLt+3bJSDEcvTe9Tn8Tt0AwNEKstLpBT
eXlXj1fGc5KjVzOHssA6Mtb1epFZQ5hN7oesqxIh6C2KSZh7jrQOfkf3XjPBiDTz
9Cc7gSeSWOXIQGWErLuDpGekzWSLsnee20u+GeitC4qH8D2yWW6gKFCM+DgOeVBe
Tku6ODcthETaxaR20iVtAlOXVUYmNN0TM6IhKh4/bGOs1nFlwWE=
=e5a9
-----END PGP SIGNATURE-----

--=-ODxKlQt9+ykmbI0CeVSH--

