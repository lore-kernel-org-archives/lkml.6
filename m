Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38995C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058F62084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sO/CJcUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfBULR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:17:57 -0500
Received: from ozlabs.org ([203.11.71.1]:52715 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbfBULR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:17:57 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 444sQV2sB6z9s7h;
        Thu, 21 Feb 2019 22:17:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550747874;
        bh=ruqCCQj41Kdku8ZY2Cv/i3+N8/G539aNn6wqwsfJWV8=;
        h=Date:From:To:Cc:Subject:From;
        b=sO/CJcUgY8m/5rN5NAPEARYZ80wHObto54/4G7eSjQIaWC4JGlFvMQnGNuRQpVouh
         WuwRnTkEXLRay9PrYXeeIVddRY8J+Hm4rRhKPRtIQfI/UJ3BZWIPkppO6KGQI5/OGH
         eHWmgH/JKRr847kC/D5S9BwME1Dhaheyyv4lwcSzpZ1n7Khln5SryEgSpZqF+0INEd
         nUUntYB6XkhztN1RaSc55vNLzaY+frmBPSF0CykMK00nQazrVsUZ3PhdtrcKtJVtM1
         E3F6VE+7IG5pZ1jQtyWNXs8S+NlIFfGUsr+oL11DpT98CSbQE8818j/2vPa1mF3XyX
         tZFXGwlz5BR8A==
Date:   Thu, 21 Feb 2019 22:17:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: linux-next: Fixes tag needs some work in the kvm-ppc tree
Message-ID: <20190221221753.74e37ec1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FOre+3j.TkcYo7/KAoI8gyL"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FOre+3j.TkcYo7/KAoI8gyL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

In commit

  a67614cc05a5 ("KVM: PPC: Release all hardware TCE tables attached to a gr=
oup")

Fixes tag

  Fixes: 121f80ba68f ("KVM: PPC: VFIO: Add in-kernel acceleration for VFIO")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/FOre+3j.TkcYo7/KAoI8gyL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxuiOEACgkQAVBC80lX
0Gy+uwgAnPQhQL6Tds9qPrg/xzRDiKoIm2dus8KExAZWW1xp+fQY2VrNKmmG+Jha
/ULaDzgTsGQOR3kjbUTkAEZnKU0Kxi/48RKWEXpit48Vp/hr5LCTYs2R2WNm7xKp
V6xIgAbSylTeplzO3COm5BT3RPr6kbjVCOCsgDKKnvee25tTarG588h/0VzU4AvU
shunmfE8NNrPLyIJZ7PJOjndR58IKTe5XF2Fy4EDUE6Dv50R/bM7x7/NTG/W9981
/uBQkWfgE7+XAQJ1HSSG+IjFXCs8KYfXw25T6W+pTUzxYO1QxG8KXfxtuaQeZDXj
e6ZH5ZP22SgNDb9p9Yl0dXHuSXLn/Q==
=lt0R
-----END PGP SIGNATURE-----

--Sig_/FOre+3j.TkcYo7/KAoI8gyL--
