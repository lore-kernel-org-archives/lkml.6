Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B87C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520D721550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520D721550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390480AbeIUVwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:52:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388909AbeIUVwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:52:30 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22A96C059B76;
        Fri, 21 Sep 2018 16:02:59 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D8E2230912F4;
        Fri, 21 Sep 2018 16:02:57 +0000 (UTC)
Message-ID: <551884c4290b58a8bdcf5fc02b3b29a7b1ac7844.camel@redhat.com>
Subject: Re: [PATCH] IB/mlx4: Remove unnecessary parentheses
From:   Doug Ledford <dledford@redhat.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 21 Sep 2018 12:02:56 -0400
In-Reply-To: <20180920033229.15102-1-natechancellor@gmail.com>
References: <20180920033229.15102-1-natechancellor@gmail.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-CEagSXfSaqMJxZ0kvSCr"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 21 Sep 2018 16:02:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CEagSXfSaqMJxZ0kvSCr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-09-19 at 20:32 -0700, Nathan Chancellor wrote:
> Clang warns when more than one set of parentheses are used in single
> conditional statements.
>=20
> drivers/infiniband/hw/mlx4/mcg.c:676:16: warning: equality comparison
> with extraneous parentheses [-Wparentheses-equality]
>                         if ((method =3D=3D IB_MGMT_METHOD_GET_RESP)) {
>                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/infiniband/hw/mlx4/mcg.c:676:16: note: remove extraneous
> parentheses around the comparison to silence this warning
>                         if ((method =3D=3D IB_MGMT_METHOD_GET_RESP)) {
>                             ~       ^                         ~
> drivers/infiniband/hw/mlx4/mcg.c:676:16: note: use '=3D' to turn this
> equality comparison into an assignment
>                         if ((method =3D=3D IB_MGMT_METHOD_GET_RESP)) {
>                                     ^~
>                                     =3D
>=20
> Remove the unnecessary parentheses to silence this warning.
>=20
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied to for-next, thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-CEagSXfSaqMJxZ0kvSCr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlulFjAACgkQuCajMw5X
L91FBg/+N9IjWWGLCBrNlJboa98FuGpxWU0/RN1P7N8DPoZ3SecK4eHWFZzpcCQz
fi1xEdRtZhqTBLOUJzPQUSIJ9k8QwI8Z4vSLEiFn0mZyq4JitzN/yC493/7wTbHk
J6imJtVrpS7v22wHM4fKzniJJw4JG7oHMkEq2e5+u1PQRHOzdk8xWZG9hr8ip6hD
xCeKHKWMWr9/CS2JkpTYy5jbpyaAJFV19ee/Ta+LcJVp82tDOvQEGWHAWSrf0xF6
q3E/Pr7ADspLZOh8Rdvw0EVPQIIv3iDV60hjLhBsooVEFSRVsq1LJO171wJFlQzK
adD4IoxLOl/ushGOIyTGI413WvA1SMrDPU6cxLvIFMXAMlv7lor2RxumyOX+sARx
Plv7r4CfWl82z07PbN8vqZP5oyy7QhmHZKazVGnnmRks4kU3m3JG0z3jK+cubN9W
OTEinmeONgkex9aveal+KEEYpTFjzIotbL26OsrnyGUCs3338Kd320PZ0/vr7yWr
QiRqOrZcIdU7WhiWGkUh2vlozFC20+eDtcrVAwyB8opmXvodxdgd0Ne2NgCDnXbj
5x+eyXbFqFjPHG1X2aSqFyWKZhihswRyCXhm0g1Mq1ITHg4uZsVsIRscmc/qa/gf
xJ4G5QjKavDYNrD7zqulbpyahDcbz0JABEO0hHmkSAqWXNNN9Bs=
=tPdz
-----END PGP SIGNATURE-----

--=-CEagSXfSaqMJxZ0kvSCr--

