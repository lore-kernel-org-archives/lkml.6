Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D42D2C004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806D620869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GrYHpRXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806D620869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932544AbeFKWOY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 18:14:24 -0400
Received: from ozlabs.org ([203.11.71.1]:56183 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752768AbeFKWOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 18:14:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 414S3c39Frz9rvt;
        Tue, 12 Jun 2018 08:14:20 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1528755260;
        bh=4h9snFb3f6i9OkFqUOR6WdgPNPkgEMzcbpznJkYCsoM=;
        h=Date:From:To:Cc:Subject:From;
        b=GrYHpRXhJrBES5yuKxjh7lSuedSO7PXGhUeMjN+Y5Ug/d7RjZOWO/XAkFtvls1YTl
         ONhTtO9ENwN57rJHWs00Y7lPCTRfhhn5I/9hMhdRqX0fbTB0W3ZvqoQCbnZD7L1K2o
         7sKionvPBsFH5oKmn5tlSY7DFuJBHYQNXbeI0/pA1UkCfpZ5s0dT2m0ttEnTuwTa/X
         KnqndVhy+IwkHO3NepcrXf+Iq0VjM3S6NieVhRMyudQh803sCs3LuTjdnVA6E7YzdZ
         6nUC0gsC1Sia/FSzE2u7VLPu+/431oKI3dCXcyVGNJGp8ASjkZdBOHZ/NTvtGRwD3K
         yS1ZYBZRFfaew==
Date:   Tue, 12 Jun 2018 08:14:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warnings from Linus' tree
Message-ID: <20180612081413.323d85b8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/W/m1/rBdObywzXKqe1sTqIe"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W/m1/rBdObywzXKqe1sTqIe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Building Linus' tree, today's linux-next build (powerpc ppc64_defconfig)
produced these warning:

ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in=
 section `.gnu.hash'.
ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in=
 section `.gnu.hash'.
ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in=
 section `.gnu.hash'.

This may just be because I have started building using the native Debian
gcc for the powerpc builds ...

--=20
Cheers,
Stephen Rothwell

--Sig_/W/m1/rBdObywzXKqe1sTqIe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlse9DUACgkQAVBC80lX
0GwAawgApdMf0NhVOmjUuHMCIsVcF2VnHyuaeXZRscavEqHiPxuWDsM4siF5nZ1Z
EVBIptKv3UADfLoAWr1k26l7LQpg57iCvTVRwd/8l5KTujs0Qh32vJ87hVHGK57a
7MMD1DC9m2J774Eyrl0ZiZeJPeYP5vdRz5pBcsvINuWwJR51T7NvY6RwZhOrKpNa
D7z4KRX6xA6X3j2wnMwZQNS+r4BbMP79VRzCq5DUn1LtidTS6BcD3u11m6+m3f5W
CZY3lXXbEEkK9i0NYmTTKo+3GR5X8W4Nw92UeIGkmE+bI4DffnJe22Fz0mWXRT1h
hLs6n+kDpZzDtRcB76Tgxy4wyP6fNA==
=BwqD
-----END PGP SIGNATURE-----

--Sig_/W/m1/rBdObywzXKqe1sTqIe--
