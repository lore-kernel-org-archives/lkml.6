Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39789C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4DA2086B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4DA2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbeIGTyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:54:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728410AbeIGTyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:54:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3DFF87A87;
        Fri,  7 Sep 2018 15:13:23 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-20.rdu2.redhat.com [10.10.112.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9695B108762;
        Fri,  7 Sep 2018 15:13:22 +0000 (UTC)
Message-ID: <811a6feca9fdea2db59ac392a4711cd897f46cc7.camel@redhat.com>
Subject: Re: [PATCH] infiniband: nes: add unlikely() to assert()
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Faisal Latif <faisal.latif@intel.com>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Chien Tung <chien.tin.tung@intel.com>,
        Roland Dreier <rolandd@cisco.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 07 Sep 2018 11:13:21 -0400
In-Reply-To: <20180905060106.GI2977@mtr-leonro.mtl.com>
References: <20180831192418.12346-1-igor.stoppa@huawei.com>
         <20180905060106.GI2977@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-IP+zaWvXiDu0GpMM6jBS"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 07 Sep 2018 15:13:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 07 Sep 2018 15:13:24 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dledford@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IP+zaWvXiDu0GpMM6jBS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-09-05 at 09:01 +0300, Leon Romanovsky wrote:
> On Fri, Aug 31, 2018 at 10:24:18PM +0300, Igor Stoppa wrote:
> > Typically the assert is expected to not fail.
>=20
> This whole assert can be removed.
>=20
> >=20
> > Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> > Acked-by: Doug Ledford <dledford@redhat.com>
>=20
> Most probably that I missed discussion, but anyway, does this
> "Acked-by" come from internal or external discussion?

This patch was part of a larger series on lkml.  In that context, I
acked it so that the series could be applied by whomever took it (it
didn't belong on rdma-list as a series since only one patch out of some
large number touched rdma files).  Now it is being resent as not part of
a series, but my ack was preserved.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-IP+zaWvXiDu0GpMM6jBS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAluSlZEACgkQuCajMw5X
L93a6g//WBA/uxKA9aeF2MOYzAqZjiVVIfN+n0yyJCmFaKk8NqYdftjbKx5eAIqY
BfjlBUmvI6Tw3S/EnezPUvfZt3aX5jQcy50lqnlVdLHAsbkwuOylQRLB8pxfukqR
uwOrdgKXJAflvskpP+A7dUsY/N/dfTEd2hNh35/IOm8dqLBVNBTAknMnW9VYlQzZ
FrElzH9siUvdZa9j2IKCW/7GtxCpUFqS3m2RAHjkYqYeA+7lkPJhtJDKhFD+2hRM
MWkA1J0P0BnEszjt00VY3atq8HxmIDdlArwjG1egtNE7ZnsncD5a5HDTnnXAZWR6
OY81FdVcf8JP6Giuxhbd6NCSNoZPqSMliDgrlQCaeLccpDaI5bUczhMTYSNDS1Bz
nq3hGxyGenOS5q4EYHCsYsklhFb0q7u9Mo7k9pjF2nCxP/terbdxgCocJDxp4xkR
00SRx/bPJ7KmAjnxp/A5Tf8838ESMzAo2R9jNSQBIZIeWZ+c6cuGy3j+8ELFTLQE
9datkRx2kY/4i9thf3Ygez20MGaEzE1ZsHKmjRXoFshutYMVxIabEou4pA/em1Pr
23/Z6S7O7mvMsX1t9cvhRPQxGmlPitC9y2RV8tELOSRdY8NHuDG8Z7jHx/Jee46G
fXDWS9hPzioyWlGKZTe0xxPSDqIblhZ7m/Fhb+Y+7OFpyRT9Lys=
=qUlD
-----END PGP SIGNATURE-----

--=-IP+zaWvXiDu0GpMM6jBS--

