Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8EEC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 05:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E469423D70
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 05:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iCyhOiUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E469423D70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeFVFQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 01:16:29 -0400
Received: from ozlabs.org ([203.11.71.1]:35349 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750937AbeFVFQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 01:16:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Bmy26Rhkz9s3C;
        Fri, 22 Jun 2018 15:16:26 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529644587;
        bh=cpLWM423sWqE/WImzW/4Xo7LEt9E4z1oK8qn/XiUq3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iCyhOiULtPC91wPwvR8g8jCNm7ajuXmlnpA7ILrN3OCvdLK/6oSUA0Hb4P0dmQh8Y
         SsEz5HhsosDYeSSvgUjAmxQngzWLOTDnVu1iGI4AEb0Xdq7EdeNE7w5qqrrYKRdunN
         qfgmWhTrXawOL4TU1kMzRZ1Aj8vm8505OvJ3y0ssjG2Sf3r+mvfP7QnQQydXjf63Be
         wMXjEPmKG4HJhGN//BvhWRGXQXv/s/gfb2xCKuqjOHZQs+fsuLpLPRmuYYsVJmmu3K
         fsl1u/znMVmur4zv06u3c30HFmdKfD6/AVoYlpuPCJTTquAA02811RcyplIcJzMMB2
         LFVp6sSBb+jdg==
Date:   Fri, 22 Jun 2018 15:16:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: new location for the drm-fixes tree.
Message-ID: <20180622151626.2964fe9a@canb.auug.org.au>
In-Reply-To: <CAPM=9ty1xJiPH+TyQSWC2NXYVSEmHF_=3pMVoHoSHXbkwiBPmQ@mail.gmail.com>
References: <CAPM=9ty1xJiPH+TyQSWC2NXYVSEmHF_=3pMVoHoSHXbkwiBPmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8hALKPrQ7bmoaUcP1IYsSTK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8hALKPrQ7bmoaUcP1IYsSTK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Fri, 22 Jun 2018 13:14:07 +1000 Dave Airlie <airlied@gmail.com> wrote:
>
> drm-fixes is now in the same tree as drm-next
>=20
> git://git.freedesktop.org/git/drm/drm drm-fixes.

Hmmm, I have never had a drm-fixes tree ... but I have added it now, thanks.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/8hALKPrQ7bmoaUcP1IYsSTK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsshioACgkQAVBC80lX
0Gzg8gf+OAR46MyqJlU+IEozUGHeqpO6ySlpnuQwqVrKkSkXJiGy/4cRaf7MaYr4
IYhJuotOBnz/0i9FjuWjAZI0KwGkGw8GYlpUZn/ZXGBgIDqLt6u48gLPohjGSATi
xGuR5908IiN+qrTIjuRlfZYwF72Zew/qt3cZ+JosB0oFUtVU34XTywTYDxH5IfXD
PUu2VT/NkNIsU1jGqubHu2j/nH0aYDlTWZihHX/293sVElYqJSVs1tNXNhDXCs52
PPjVRYuj2yl9ozhDWrvkZwPKRDSJ+VrqwXagUS2DMJjsk+WTBZ24wD4QD1jvDL5e
0z4iRq2i17yh38ug7iH9wTnaZueW6g==
=DptT
-----END PGP SIGNATURE-----

--Sig_/8hALKPrQ7bmoaUcP1IYsSTK--
