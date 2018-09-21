Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BDDECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812BA21550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 812BA21550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390638AbeIUVxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:53:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728221AbeIUVxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:53:54 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4CA083091D6F;
        Fri, 21 Sep 2018 16:04:22 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C3806C00B;
        Fri, 21 Sep 2018 16:04:21 +0000 (UTC)
Message-ID: <6bf94546954c509c537603514f0c4c6d5c927419.camel@redhat.com>
Subject: Re: [PATCH] IB/nes: Remove unnecessary parentheses
From:   Doug Ledford <dledford@redhat.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 21 Sep 2018 12:04:19 -0400
In-Reply-To: <20180920032956.14360-1-natechancellor@gmail.com>
References: <20180920032956.14360-1-natechancellor@gmail.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-hhNbv5TVhewKcsoeICF7"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 21 Sep 2018 16:04:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hhNbv5TVhewKcsoeICF7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-09-19 at 20:29 -0700, Nathan Chancellor wrote:
> Clang warns when more than one set of parentheses are used in single
> conditional statements.
>=20
> drivers/infiniband/hw/nes/nes_hw.c:1446:27: warning: equality comparison
> with extraneous parentheses [-Wparentheses-equality]
>         } while ((temp_phy_data2 =3D=3D temp_phy_data));
>                   ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
> drivers/infiniband/hw/nes/nes_hw.c:1446:27: note: remove extraneous
> parentheses around the comparison to silence this warning
>         } while ((temp_phy_data2 =3D=3D temp_phy_data));
>                  ~               ^               ~
> drivers/infiniband/hw/nes/nes_hw.c:1446:27: note: use '=3D' to turn this
> equality comparison into an assignment
>         } while ((temp_phy_data2 =3D=3D temp_phy_data));
>                                  ^~
>                                  =3D
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

--=-hhNbv5TVhewKcsoeICF7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlulFoMACgkQuCajMw5X
L92ZHxAAl4bUiOAlp+UZAD7+BPdUW6u7EvSDU1zaSxjo5ZyBbiH7kdoMezMCYd8+
CaPsk7ZMu/JnGDyrzx91SIe6BYwmytP2tql2D0YdhyM78uW5v/XoQqWbcf9R6XJ1
0g0+NGmkFTi0ujrJK13tBPl6nPrHSvgdYD/iw01lODfOovUMzB4bGV3IVLP0Bsbt
GsZHwuw9p0hfJm+oPLCpI6OOT5ptUZGmRT8qX7ux2zyQlkRdzGgr523MZqVf4xdL
lDCi7HzIV+140Tl8Fbmp9uvHNUw2v0dXDfPtk4pMKlS8EFc7BxJAz/e0gwIfwfDb
Lr2TUtH5SMZgJLCftM0ZyFy86T3b8OrKjz97bZi/ERphvpFd7t5OSBBYTe3yfVry
JH4cIe9eKGnUUxSM37X20dQSunyC9mkFqga5OV6IG+QtSJYkx1BUjtVT2DhqxUKy
XI+MmUM9MFdagxfPexTWX7lJZks/9AcN6bnt4IPj53d7mLlbG+RLvbpkm+vrXDqu
+XtPjpwZJ/8OMZ/FEKMuh9fXc1Y6oajKHrp8Ib1yqdqiTPbnkglgZqPxXXObelkw
3ADApIKBxNV/dWeXlGzLrcxzzhtP0GwLxnauKKQ7H08DuksfKZyys7MeEgsS32nm
9csccdmxoIOjlJfGMz9fN8i7WvJYWEt77lKO6Xccpabmi+/1yRk=
=hT0y
-----END PGP SIGNATURE-----

--=-hhNbv5TVhewKcsoeICF7--

