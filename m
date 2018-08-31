Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD39C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AD82083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AD82083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbeHaSOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:14:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727404AbeHaSOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:14:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D17B87A70;
        Fri, 31 Aug 2018 14:07:01 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-121-83.rdu2.redhat.com [10.10.121.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 862914E626;
        Fri, 31 Aug 2018 14:07:00 +0000 (UTC)
Message-ID: <ffe6f38e96c0d84326e2d853e2aa8e9b87b8b9f1.camel@redhat.com>
Subject: Re: [PATCH 01/23] infiniband: nes: add unlikely() to assert()
From:   Doug Ledford <dledford@redhat.com>
To:     Igor Stoppa <igor.stoppa@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Igor Stoppa <igor.stoppa@huawei.com>,
        Chien Tung <chien.tin.tung@intel.com>,
        Roland Dreier <rolandd@cisco.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Date:   Fri, 31 Aug 2018 10:06:59 -0400
In-Reply-To: <20180830223429.30051-2-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
         <20180830223429.30051-2-igor.stoppa@huawei.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-sNj0nZP7Yn9nvKTZ70C4"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 31 Aug 2018 14:07:01 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 31 Aug 2018 14:07:01 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dledford@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sNj0nZP7Yn9nvKTZ70C4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-08-31 at 01:34 +0300, Igor Stoppa wrote:
> Typically the assert is expected to not fail.
>=20
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> Cc: Chien Tung <chien.tin.tung@intel.com>
> Cc: Roland Dreier <rolandd@cisco.com>
> Cc: Faisal Latif <faisal.latif@intel.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>

Acked-by: Doug Ledford <dledford@redhat.com>

> ---
>  drivers/infiniband/hw/nes/nes.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/nes/nes.h b/drivers/infiniband/hw/nes/=
nes.h
> index bedaa02749fb..d2d0098f38e0 100644
> --- a/drivers/infiniband/hw/nes/nes.h
> +++ b/drivers/infiniband/hw/nes/nes.h
> @@ -151,7 +151,7 @@ do { \
> =20
>  #define assert(expr) \
>  do { \
> -	if (!(expr)) { \
> +	if (unlikely(!(expr))) { \
>  		printk(KERN_ERR PFX "Assertion failed! %s, %s, %s, line %d\n", \
>  			   #expr, __FILE__, __func__, __LINE__); \
>  	} \

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
--=-sNj0nZP7Yn9nvKTZ70C4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAluJS4MACgkQuCajMw5X
L92kzw/+PDl/ZO4p4UlfkrucSQmmmR7Ebw1fH3Co5pj9DYlN2IvTSAd8wL/usPdD
Wfukj5+lhpos2GyA8uIt6pxvNlGgmA+3Utrj67LKCGHZxAEz+JtEWGjSLi2iXtEg
ouxf/QYVbsqdveMBPn5b5bkALkxVpde5OFsL6SbKl7daMDkoR9xmRL51GmpnB+Ro
HXaK16A1zhRcuSVlYshV/oN0fdyqhhyDFZTMuFQSAUn+/fc6RutQhxXcfnks30Cv
mT4pqt1CfksDsDdYVByrWLk3GiorScznb9X09leEBOwN53eSJGRbEaTZ5OXC85Vh
WIoNlJFqpK7nNAfAXX0VqU0Zq0xron9VGX02OCiNMsRF/EeA4gyj6MRG2Jh3mdcq
MsjvbqqT5bfWqnumMBpcBQi2pWhqKc99PRkoP6ksjOVErP8QqjOfN2vz3Y9Ici8P
e5dFqxdX2xohE7CoVESK+ZWfDWx7sVxgw6mqDBUNa3hAmqi2jvpqrayiBfNLS6q1
tCj2Qy8ceyGubWzsJXBzerCK3biZ2/PhBUbCV1y7U2uo4W/D2nbg9sSxi21bpxx0
qyzZict0fQGr5C3zBzkAXnSRtCS1ricpFuV5yNDpdHmp5QqzXFq8T6APsCYPbirA
+g7Lna4hfZuzpuC1/bMPuZYh5RYBA136Tqbu5VSIc4uKe8qV7R8=
=K5AT
-----END PGP SIGNATURE-----

--=-sNj0nZP7Yn9nvKTZ70C4--

