Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374EEC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D110820652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Z3pCGthu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D110820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbeJAOo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 10:44:26 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:10427 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeJAOo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 10:44:26 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181001080751epoutp039efd313f1a744ca8e42004a46f99ccbf~ZbZ2gerjk2909029090epoutp03N;
        Mon,  1 Oct 2018 08:07:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181001080751epoutp039efd313f1a744ca8e42004a46f99ccbf~ZbZ2gerjk2909029090epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538381271;
        bh=W9ypesF+wMff7sBGwyDVM3awPAzY6WnHkN9cz2syasg=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=Z3pCGthuD/rXGrP6IAfFglT0mmqhpO9yP/tCKLDbJgJl0AgEyj9MzIN3IZfC8FX1U
         h6vMzMvFE7F0V/w6tGOfWb2mIIrYy6HL6LryeFr1Sr3zg2n1Y+Xx+RSoDOvMlir6Ui
         0H5oV75ekjYvDTZUjy7lrZBimqa7M8DzoLc6xgEI=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20181001080751epcas2p1440af208e1b14f81d3a7e1dbf17eb4a9~ZbZ2KpHJR0841008410epcas2p1O;
        Mon,  1 Oct 2018 08:07:51 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.F1.04069.7D5D1BB5; Mon,  1 Oct 2018 17:07:51 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20181001080750epcas2p21b4c3e14be32859f31bede0656ffa09d~ZbZ11UqNW1409214092epcas2p2X;
        Mon,  1 Oct 2018 08:07:50 +0000 (GMT)
X-AuditID: b6c32a48-e71ff70000000fe5-a6-5bb1d5d7d38c
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.E3.03633.6D5D1BB5; Mon,  1 Oct 2018 17:07:50 +0900 (KST)
Received: from localhost ([106.116.147.110]) by mmp1.samsung.com (Oracle
        Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with
        ESMTPA id <0PFW003JPUL10E60@mmp1.samsung.com>; Mon, 01 Oct 2018 17:07:50
        +0900 (KST)
From:   =?utf-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: Bad MAINTAINERS pattern in section 'SAMSUNG EXYNOS TRUE RANDOM
 NUMBER GENERATOR (TRNG) DRIVER'
Date:   Mon, 01 Oct 2018 10:07:37 +0200
In-reply-to: <20180928220330.31325-1-joe@perches.com>
Message-id: <875zym5bue.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-version: 1.0
Content-type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsWy7bCmme71qxujDQ69ZLGYff8xi8XlXXPY
        LGac38dk0br3CLsDi8emVZ1sHl9WXWP2+LxJLoA5issmJTUnsyy1SN8ugStj37KMguXCFX/O
        7GRsYFwr0MXIySEhYCLR+KyNuYuRi0NIYAejxLu3/WwQzndGifdTj7B0MXKAVc3e6QoR380o
        8fboWnYI5x2jRPftHawgo9gE7CX6j+xjAbFFBFQkNjy/xQxiMwukSNz8sIcVZJCwQK7E3SkK
        IGEWAVWJResXs4PYnAKmEieuPWQEsXkFjCW+TdwHNlJUwFLiXt9dNoi4oMSPyfdYIEbmSnxq
        +g92g4TAHjaJKzffsEK84yLxZ/JLNghbWOLV8S3sELa0xLNVGxkh7HKJHzf6WCGaWxglFk/o
        hCqylvizaiIbxAY+iY7Df9khvueV6GgTgijxkOi68oEF4vkORoll286wT2CUnoXkwFlIDpwF
        1M4soCmxfpc+RFhbYtnC18wQtq3EunXvWRYwsq5iFEstKM5NTy02KjDRK07MLS7NS9dLzs/d
        xAiOdy2PHYwHzvkcYhTgYFTi4Q04tD5aiDWxrLgy9xCjCtCgRxtWX2CUYsnLz0tVEuENurIh
        Wog3JbGyKrUoP76oNCe1+BCjNAeLkjjvQ+m50UIC6YklqdmpqQWpRTBZJg5OqQbG9hdtQUkp
        /G+rH3I13d9h38nz+NTjRwe2R7wqiQ0PdhJRl/NJ3sl87aeL8eOlf67vXBwZtfDWa3n9HRue
        yfp3LdTkvf1zTnio2oYj+957iO03bFcwc05lcWNzXfh2k8F8VU69F6HeP4orM4Tcpj6Uv8pm
        8cq0Rkqab++EgOAl/C2JMolcDx8rsRRnJBpqMRcVJwIAMWdhuf8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsVy+t9jAd1rVzdGG9w/p2kx+/5jFovLu+aw
        Wcw4v4/JonXvEXYHFo9NqzrZPL6susbs8XmTXABzFJdNSmpOZllqkb5dAlfGvmUZBcuFK/6c
        2cnYwLhWoIuRg0NCwERi9k7XLkYuDiGBnYwST382MHYxcgI57xglmicEg9hsAvYS/Uf2sYDY
        IgIqEhue32IGsZkFUiQ2v5rKDDJHWCBX4u4UBYhWE4mvr56zg9gsAqoSi9YvBrM5BUwlTlx7
        CDaeV8BY4tvEfawgtqiApcS9vrtsEHFBiR+T77FAjM+WuHDxDcsERr5ZSFKzkKRmAW1mFtCU
        WL9LHyKsLbFs4WtmCNtWYt269ywLGFlXMUqmFhTnpucWGxUY5aWW6xUn5haX5qXrJefnbmIE
        huy2w1r9OxgfL4k/xCjAwajEwxtwaH20EGtiWXFl7iFGFaBZjzasvsAoxZKXn5eqJMIbdGVD
        tBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe/vxjkUIC6YklqdmpqQWpRTBZJg5OqQbGgCmT4tSU
        FTum9NXZrfqzc4/HscmrD2s25satadde+ocl6LGL3uup81l87j+4Gxb9/YSa/xK5vjjHMqWO
        X/bcD3piFmSq5H7Zt8Pl6+RJJf4pmlfX/ThyQFlA1feQucM3lefWvsa79jvY9Sw9bqf4ckLZ
        4Sdf9WP0w1nzxT9+3VJaE8B/7oSEEktxRqKhFnNRcSIAZnRKNWECAAA=
X-CMS-MailID: 20181001080750epcas2p21b4c3e14be32859f31bede0656ffa09d
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20181001080750epcas2p21b4c3e14be32859f31bede0656ffa09d
References: <20180928220330.31325-1-joe@perches.com>
        <CGME20181001080750epcas2p21b4c3e14be32859f31bede0656ffa09d@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2018-09-29 sob 00:03>, when Joe Perches wrote:
> Please fix this defect appropriately.
>
> linux-next MAINTAINERS section:
>
> 	12851	SAMSUNG EXYNOS TRUE RANDOM NUMBER GENERATOR (TRNG) DRIVER
> 	12852	M:	=C5=81ukasz Stelmach <l.stelmach@samsung.com>
> 	12853	L:	linux-samsung-soc@vger.kernel.org
> 	12854	S:	Maintained
> 	12855	F:	drivers/char/hw_random/exynos-trng.c
> -->	12856	F:	Documentation/devicetree/bindings/rng/samsung,exynos5250-trn=
g.txt
>
> Commit that introduced this:
>
> commit 6cd225cc5d8a6526b2bea41955882be55d4f109e
>  Author: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
>  Date:   Fri Dec 22 17:48:35 2017 +0100
>=20=20
>      hwrng: exynos - add Samsung Exynos True RNG driver
>=20=20=20=20=20=20
>      Add support for True Random Number Generator found in Samsung Exynos
>      5250+ SoCs.
>=20=20=20=20=20=20
>      Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
>      Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>      Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
>      Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>=20=20
>   MAINTAINERS                          |   7 ++
>   drivers/char/hw_random/Kconfig       |  12 ++
>   drivers/char/hw_random/Makefile      |   1 +
>   drivers/char/hw_random/exynos-trng.c | 237 ++++++++++++++++++++++++++++=
+++++++
>   4 files changed, 257 insertions(+)
>
> No commit with Documentation/devicetree/bindings/rng/samsung,exynos5250-t=
rng.txt found

Please merge the version 3[1] of the patch you've acked[2].

[1] https://www.spinics.net/lists/linux-samsung-soc/msg61372.html
[2] https://www.spinics.net/lists/linux-samsung-soc/msg61272.html
=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAlux1coACgkQsK4enJil
gBCoYAf/TRdfsYupR+hSviOt6F/mHduwMboNJ4TMl/4iZcg8PMueZSDj74tNMpI3
kTNg7n5bCvNeFliYOu4RfxFUzPuwpxU2YUDgJ2AWmdB5545Ekj8Yq2va6P/sBq9L
TyYogfT5FEBeDG0E2AlsdpB3oWw3I8u/mlvgsTjeRu17ptKGP3euh9bsXDlm/rTo
sTemzSNB0QElUya1r2BO6gvZgO4F5Hvz9AyvWT6W4lM3TDwprqKR98p2IwnXUfvt
KZxOvy9S9IfTtFOOj06APjuJqE4wZ7a8U8UOdMDIKvnN3woeJsCaviWAbS19Gbpw
IObvC9+lYMY0SREXqsKfRdbG0bnOLg==
=+ZAp
-----END PGP SIGNATURE-----
--=-=-=--
