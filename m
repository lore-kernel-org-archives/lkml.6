Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA07C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1182F21470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1182F21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeJQAlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:41:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbeJQAlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:41:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 497FC81DF1;
        Tue, 16 Oct 2018 16:49:46 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-29.rdu2.redhat.com [10.10.112.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DD0A58921;
        Tue, 16 Oct 2018 16:49:45 +0000 (UTC)
Message-ID: <b6585727108669e0c85e7871575c7700d69b5f5d.camel@redhat.com>
Subject: Re: [PATCH] RDMA/ucma: Fix Spectre v1 vulnerability
From:   Doug Ledford <dledford@redhat.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 16 Oct 2018 12:49:43 -0400
In-Reply-To: <20181016145901.GA8811@embeddedor.com>
References: <20181016145901.GA8811@embeddedor.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-7oWFmRGZh9VT3+xkVCdZ"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 16 Oct 2018 16:49:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7oWFmRGZh9VT3+xkVCdZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-10-16 at 16:59 +0200, Gustavo A. R. Silva wrote:
> hdr.cmd can be indirectly controlled by user-space, hence leading to
> a potential exploitation of the Spectre variant 1 vulnerability.
>=20
> This issue was detected with the help of Smatch:
>=20
> drivers/infiniband/core/ucma.c:1686 ucma_write() warn: potential
> spectre issue 'ucma_cmd_table' [r] (local cap)
>=20
> Fix this by sanitizing hdr.cmd before using it to index
> ucm_cmd_table.
>=20
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
>=20
> [1] https://marc.info/?l=3Dlinux-kernel&m=3D152449131114778&w=3D2
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks, applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-7oWFmRGZh9VT3+xkVCdZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlvGFqcACgkQuCajMw5X
L933GQ/9FKrgfV46dfs9EMMIt10+ZedAoecWuffv82YBxey2fPQAFssT6qfM3xM/
bmv9Xy88v19FZeO8dRAQRsYIfzUQzzB6qqVn7d2sgwBw72t5r1Wl1x/8l4CMJjpv
7J0SXy7IKgEoiFYY2/KDj+U/f5x//cTWMD/69CdAbsKs5YKWtN0SPn5UbGOnoISd
s2Q7PlfI1BQbA5gBdTQdbhlN8LcEiqpHVYKLL45g8kxBiv6FRjmVoGezOG5c9giK
4PUZ/joJL+r9MfzUuvl/upvOf1G2KYQdXuVOw+CPwDkNxK/xljweTekR3CpVzI79
dnPvlO4q0mMWPl+N6ldlFqOvwmNCZh9TDrF/fdSqAJRTsuRfrsAWxvcP0HZ06Co2
WEEYESKaDrinIaDKz3nCRSKTUyuQYgoLZMVUdheAeblCu/i6zZZ6KtvOo7SgQMkX
nwNy5xBS+WVPpnndJ4dAl0ev+q6fwXy6ChuapKuYkqEuoltpDOt88NEwz0zQ4NTE
onsf9Gob9MM6G1T2NhvxEFVb8WCW5G3I56CWzGkH9LVSqL8FTq7JdFFOtbU2VOAB
ULG98CTUPO1qx6YivrvY7YH4+WNDNzCeiPLRtDq+pbLhVgxvZWGWzAp8Ykz/dmqi
SUglrNvVJ5O60Ljr18kos7xLti3Jr1HkTI9TF5jOicfLZ6rUkIc=
=3PkR
-----END PGP SIGNATURE-----

--=-7oWFmRGZh9VT3+xkVCdZ--

