Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0A4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3834120657
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kJrGQIRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfAJIXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:23:00 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37760 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfAJIXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:23:00 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190110082257euoutp021cad96aaaf489234630d0a8ccf96b3fb~4bw3q4Qx23258832588euoutp02x;
        Thu, 10 Jan 2019 08:22:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190110082257euoutp021cad96aaaf489234630d0a8ccf96b3fb~4bw3q4Qx23258832588euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547108577;
        bh=6+FRAixNa2B8vE3lCnJEiIWQ9c3z4z0f2PjubTw3Cm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kJrGQIRFWXRZrc4zNhyLBq/0WofLt4tejj4Pb8ci87lkkQAYQ9jaYf+0Q/ivaCKDB
         eDUP97uGfevgVpUF6ox01jSkkI+NVwHfZrG+8p9Ie8J8uHaSTqp7pfeAnzhD3VoVUt
         M3fwxzj7phx6G9d5TBbyBXGqCN9bYX9rVzZ5mIeM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190110082257eucas1p15d026a0992bdaa5eacd293b43a700225~4bw3VDevA2126821268eucas1p1b;
        Thu, 10 Jan 2019 08:22:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 16.BA.04806.0E0073C5; Thu, 10
        Jan 2019 08:22:56 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190110082256eucas1p1bb0685cb83aa0a865f2391e43512b417~4bw2mi-ZC2489924899eucas1p1B;
        Thu, 10 Jan 2019 08:22:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190110082256eusmtrp1f9c0d63aa1197c1f166b63ac31881889~4bw2XkjXV0278902789eusmtrp1G;
        Thu, 10 Jan 2019 08:22:56 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-fb-5c3700e0f873
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 90.4B.04128.0E0073C5; Thu, 10
        Jan 2019 08:22:56 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20190110082255eusmtip246a2a3073e6cad67a15da2ff69ba19c1~4bw2L_Q8N1651816518eusmtip2F;
        Thu, 10 Jan 2019 08:22:55 +0000 (GMT)
From:   =?utf-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
To:     <robh+dt@kernel.org>
Cc:     Otto Sabart <ottosabart@seberm.com>, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: fix bad file reference into
 Documentation
Date:   Thu, 10 Jan 2019 09:22:42 +0100
In-Reply-To: <f936ab2a7c34974c67ade29e97fe15bb5781ac39.camel@perches.com>
        (Joe Perches's message of "Wed, 09 Jan 2019 11:35:45 -0800")
Message-ID: <87d0p47wh9.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djPc7oPGMxjDDpnW1rMvv+YxeLyrjls
        Fq/Ov2CzaN17hN2BxWPTqk42jy+rrjF77Fn4ksXj8ya5AJYoLpuU1JzMstQifbsEroyVNyMK
        lnBXTOj6xtzA+JWzi5GTQ0LAROLSjx7WLkYuDiGBFYwS5263QTlfGCXm3FnNDFIlJPCZUWLu
        Dmm4jr9t7BBFyxkl1s+4yAzhPGeUeD/tGBNIFZuAvUT/kX0sILaIgITEoVfngMZycDALpEvM
        negNEhYWCJTomPIYbAGLgKpE48JNjCBzOAU6GCWmH/0J1ssrYCyxbtlzNhBbVMBS4l7fXTaI
        uKDEyZlPwGqYBXIlZp5/A9YsIbCKXaJ34i8miFNdJNbPXc8OYQtLvDq+BcqWkTg9uYcFwi6X
        +HGjjxWiuYVRYvGETqgia4k/qyayQdiOEncO3GUB+UBCgE/ixltBiMV8EpO2TWeGCPNKdLQJ
        QVSrSKzr3wM1Xkqi99UKRgjbQ+Lxxd/Q4J3DKPH3wSeWCYwKs5D8MwvJP7PA4aUpsX6XPkRY
        W2LZwtfMELatxLp171kWMLKuYhRPLS3OTU8tNs5LLdcrTswtLs1L10vOz93ECEw6p/8d/7qD
        cd+fpEOMAhyMSjy8Cf9MY4RYE8uKK3MPMaoATXq0YfUFRimWvPy8VCUR3jvLzWKEeFMSK6tS
        i/Lji0pzUosPMUpzsCiJ81YzPIgWEkhPLEnNTk0tSC2CyTJxcEo1MOq1XNu1Xm2PshWXct+D
        pC1Hwi3jjlWcXLajMLeDP3aGMfttxRCr/v1NW8re30oP2FTxseWt4I8POpftZzzc+IwtaONN
        wyOKjiz8Shv1SyfMfqUsLPqzbNkj0Ygk84/62rVf3fkeX7n7Y9sesdoilpduM8+05/G6+asf
        26G24vOr5cU6VX0fbJVYijMSDbWYi4oTAZ3u9GxCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7oPGMxjDC7tYbWYff8xi8XlXXPY
        LF6df8Fm0br3CLsDi8emVZ1sHl9WXWP22LPwJYvH501yASxRejZF+aUlqQoZ+cUltkrRhhZG
        eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkrb0YULOGumND1jbmB8StnFyMnh4SA
        icSlv23sILaQwFJGibuXjboYOYDiUhIr56ZDlAhL/LnWxdbFyAVU8pRRorn7FhNIgk3AXqL/
        yD4WEFtEQELi0KtzrCA2s0CqxKFdz8FqhAX8JToabzBCzPeQ+LbhGlg9i4CqROPCTYwgQzkF
        OhglZp1qBSviFTCWWLfsORuILSpgKXGv7y4bRFxQ4uTMJywQC7Ilvq5+zjyBUWAWktQsJKlZ
        QD8wC2hKrN+lDxHWlli28DUzhG0rsW7de5YFjKyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcx
        AuNl27GfW3Ywdr0LPsQowMGoxMOb8M80Rog1say4MvcQowrQmEcbVl9glGLJy89LVRLhvbPc
        LEaINyWxsiq1KD++qDQntfgQoynQoxOZpUST84ExnlcSb2hqaG5haWhubG5sZqEkznveoDJK
        SCA9sSQ1OzW1ILUIpo+Jg1OqgXGvfOgu7f7KGUIWXnnfmDzE7vgtu7Eq6HbEkWXiRdMtT930
        WVr8Kew464253qopJo9EC+YIMc9Y0xc3O6DptIDSbZ9G29fG65bunsnnOOMHu5r/w1yGTVKG
        mze6m6XuD3i87F/1ns3n1fYLF+eI+jNUpB10SKmTTzFjKvtwXZy1SM1ohvdtdiWW4oxEQy3m
        ouJEAGxDbPe5AgAA
X-CMS-MailID: 20190110082256eucas1p1bb0685cb83aa0a865f2391e43512b417
X-Msg-Generator: CA
X-RootMTR: 20190110082256eucas1p1bb0685cb83aa0a865f2391e43512b417
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190110082256eucas1p1bb0685cb83aa0a865f2391e43512b417
References: <f936ab2a7c34974c67ade29e97fe15bb5781ac39.camel@perches.com>
        <CGME20190110082256eucas1p1bb0685cb83aa0a865f2391e43512b417@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2019-01-09 =C5=9Bro 20:35>, when Joe Perches wrote:
> On Wed, 2019-01-09 at 20:09 +0100, Otto Sabart wrote:
>> There is no `samsung,exynos5250-trng.txt` file in the documentation and
>> I do not think it ever existed.
>
> There was a patch for this
>
> https://patchwork.kernel.org/patch/10623153/
>
> But is is still unapplied...
>
>> diff --git a/MAINTAINERS b/MAINTAINERS
> []
>> @@ -13309,7 +13309,6 @@ M:	=C5=81ukasz Stelmach <l.stelmach@samsung.com>
>>  L:	linux-samsung-soc@vger.kernel.org
>>  S:	Maintained
>>  F:	drivers/char/hw_random/exynos-trng.c
>> -F:	Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt

+ Rob Herring

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAlw3ANIACgkQsK4enJil
gBCSGgf+KgChboB16JEBC9goGP1qx0Rog0mG/qk9oHT/R9N5mshsQPjcv9tZx6pN
Fui7DCYf3Y8cJw7T3EDoKqI1+YtC6vJBfvmdveRvMquckOJzcycZXL9OBeQqT0fQ
KDX5rnD+LxL2qZHG2xQXlBAzYQpSTrv5mTPbVvf7D8dpoFHs+CffxFLJ3VgZ3Ppj
+/dLzXhPiDzLX7mvQeQvXqMtQZ4uoHRODWIYS0yHEIW3eAFr9mJ7iVpfewGgx04o
mnTV0NVMfT5+EyH5ufDMHGSDo6cOy7ZbW0bvi47hWAyF8i1I+FZQqN6x/KH5PWTW
R2lLDF1+CcdAqEwx30NixiFGoOVjJg==
=gbGC
-----END PGP SIGNATURE-----
--=-=-=--
