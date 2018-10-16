Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF54AC5ACCA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E2420645
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E2420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeJQCPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:15:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbeJQCPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:15:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71897308FF16;
        Tue, 16 Oct 2018 18:23:58 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-29.rdu2.redhat.com [10.10.112.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 346522CFD2;
        Tue, 16 Oct 2018 18:23:57 +0000 (UTC)
Message-ID: <5393ae97b20baf19e9352c3b3a155d83076e67e5.camel@redhat.com>
Subject: Re: [PATCH  v3 0/2] IB/mlx4: Enable debug print of SMPs and enhance
 output for MADs
From:   Doug Ledford <dledford@redhat.com>
To:     =?ISO-8859-1?Q?H=E5kon?= Bugge <Haakon.Bugge@oracle.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     leon@kernel.org
Date:   Tue, 16 Oct 2018 14:23:55 -0400
In-Reply-To: <20181009132740.2210085-1-Haakon.Bugge@oracle.com>
References: <20181009132740.2210085-1-Haakon.Bugge@oracle.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-6T08wPwSugmjpZagFXdD"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 16 Oct 2018 18:23:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6T08wPwSugmjpZagFXdD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-10-09 at 15:27 +0200, H=C3=A5kon Bugge wrote:
> SMPs were not printed at all. Added printing of port number and TID to
> all MADs
>=20
>=20
> H=C3=A5kon Bugge (2):
>   IB/mlx4: Enable debug print of SMPs
>   IB/mlx4: Add port and TID to MAD debug print
>=20
>  drivers/infiniband/hw/mlx4/mad.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>=20
> --
>=20
> v1 -> v2
>     * Fixed incorrect format for printing the TID for the second patch
> v2 -> v3
>    * Made v3 consistently for cover-letter and the two patches, my v2
>      was partly original submission plus a v2. That probably fooled
>      both the kbuild bot and patchwork
>=20
> 2.14.3

Thanks, applied.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-6T08wPwSugmjpZagFXdD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlvGLLsACgkQuCajMw5X
L916+w/+JY6knNWacHkwzA11/iUP3harzSISQ8bqPW2wL4MSb8buO9bvuA/oYZDU
SP3aQdeuXpkz7yjDHooPSlkXLr2WHJz82ZWFxyGW5B0iwg7JZam6zWEROw0HuQQH
WFJC6QaEBmEgJB5En3HDfZPM0Xgvr7BG3L/k4satp6hD6Ei0XAajVeu+GHR2gEmI
CB4pLHoEFqFL/TiUACpWkGvBRIdnsptNtCgRKiJjdmzwlxBqW6Aaw7GbTvncnoEg
mGcfQdvT9JmHBWxv2vRR36mhl0xdZ54DsSwaL9gr1hwIUeIQDvO+/ZX1Rg5JXNp9
UFUp6/o1waLHSPdDohxdGaFiljlg9o/fnTFd56vM6Tep2MeZbuf3hVE6R7gTD+5W
BJmD0KHNtt7+pBrve3DNYV1SU1soXQQLDw+cMUVHX2Ztxtugc+9n40m5CudhTRbK
2CXYJfcZWbtKU8JOguRLRSHvyM+erFnpDz8DBMJszT74axDF3xy6y77ImKCChlfu
0XW4M8gNhVwCk3HInD5X4X3zgOqoslh0C7BR9c/ptA51d5Nr137Acy8w43qTuGC5
4Vw32POBfvCfONB2eqbr7einMWNivaFTI+vl9QEIHrfpYfyyAUgvonPCfB74r3uh
VnrTK6CbBRxZzUZ5Ul9h1sAjz5mSnreUOnql3uQdJI77oWA5Wik=
=G90Z
-----END PGP SIGNATURE-----

--=-6T08wPwSugmjpZagFXdD--

