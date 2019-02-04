Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B734BC282D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 05:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868082083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 05:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Y6oBc8gW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfBDFup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 00:50:45 -0500
Received: from ozlabs.org ([203.11.71.1]:55743 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfBDFup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 00:50:45 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43tGyp47lHz9s4Z;
        Mon,  4 Feb 2019 16:50:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549259443;
        bh=E5ofIcMkrbk8x2vbPJMnbrL0KT4ntm1aHoiPymXtAMU=;
        h=Date:From:To:Cc:Subject:From;
        b=Y6oBc8gWVsvrmQ/UQVKHAv5t9W9BP2imSYMZI7Z2iD4ZFiOU6OyRY7l/aDsUoCyYh
         PV1qlnvTW6hyovrnHp3Xq4JcyXlhLIFiZxPLsARu7UgW9PNo4dAMDVc4lXTIq22zYN
         xxpvFJhE49tDyCSeKhhYKggbcUBKSLVIEoIJ9FpUFO0jgB0vGGdNXFrGaUExf9rGup
         Er9HWH1M2hjijzDzOyaf+MYoapysdDVR+2BF3HrZ7Ff+AGHESg8xmB8xSFAs5DFhh1
         QlSqNC2BkWDxYKS3C5VN76OHqLwZPf+WubrtaMbzVUizRei7BjJNCr1cBaeNIAEoz8
         cWwZazRY+v0cw==
Date:   Mon, 4 Feb 2019 16:50:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: linux-next: Fixes tag needs some work in the drm tree
Message-ID: <20190204165039.3380e8f6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/d3wA01fenthDcfpCMvDEd7F"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d3wA01fenthDcfpCMvDEd7F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  4b5105036afb ("drm/amd/display: Don't leak memory when updating streams")

Fixes tags

  Fixes: c00e0cc0fdc0 ("drm/amd/display: Call into DC once per multiplane f=
lip")
  Fixes: ea39594e0855 ("drm/amd/display: Perform plane updates only when ne=
eded")

have this problem:

  - Target SHA1s do not exist

--=20
Cheers,
Stephen Rothwell

--Sig_/d3wA01fenthDcfpCMvDEd7F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxX0q8ACgkQAVBC80lX
0Gy71wf8DfEsu2z9+RUk//kf8+ae4n3uiojF4hJMI2krZ4qXLzebOJM6W4kkRUZy
P46if8L7FdoY2wOEhpVBLmIiUXEgIsi3zZXKeLIri6oNMeWvWSD6bTwRSPQuxGBP
cE9NWRdPZ56fQ3PTGvjvAbieJOmEcHYXCqFgpLZrK7vkbHxHpH5TSeWg0EpiGc6X
7FZmYW/G8Kre2WfWIzrf1VFjfer3ZAxezw15XBd+4ZIluwM2lRBcwG9qRzFczwSi
IIfjTE1kl/g4zncysNjkcd0lKmVLTEh7xcFPpfDBy7IYh8LDhK8rtQ5j4gf/AYXD
rrccPoa2KFu91D0f94efW9w8uQFdbw==
=AQM5
-----END PGP SIGNATURE-----

--Sig_/d3wA01fenthDcfpCMvDEd7F--
