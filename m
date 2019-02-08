Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640C8C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3238721907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="c/TJY1s8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfBHB1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:27:53 -0500
Received: from ozlabs.org ([203.11.71.1]:38479 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726850AbfBHB1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 20:27:52 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43wcxY10Mfz9sMp;
        Fri,  8 Feb 2019 12:27:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549589269;
        bh=Y42XF+/VDDCMzcz2V6XWhvrORDd+142XwOFmaIkd89g=;
        h=Date:From:To:Cc:Subject:From;
        b=c/TJY1s8y2Lz/nITRy9Pu67f2NvQ23KgdWbaWHGcJsNjPKUgiYNNrgOc45PJe2bdu
         3VSJntAQ0Hgj7VM5o0f2H3J51a0E3zCgojrPQt8glzpE12dCRUBWtf6FrmPhFs8dzC
         Uq952H+R95x1YoJ75dBT3mwtlE/EC/Fj0cvtYUoOmJs39at4dLTxnejovMB1+3SFxR
         2LU8pey+fm1JRd4tyuLz19dbHxabQKGqVT4EbQGZCtGRWdvnNcKcalPA6fAhgwtm/u
         9txWLfxcSW/ZcvpGpeLd9QONfI2SiWh8Ad/5BWwQhGsvfHyVHPNS1oP5ELCf4zWwPZ
         95+xjUj0CirOg==
Date:   Fri, 8 Feb 2019 12:27:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: linux-next: manual merge of the drm-misc tree with the drm tree
Message-ID: <20190208122744.4a63bec0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0_T==Z=29r/u++WozInW5UT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0_T==Z=29r/u++WozInW5UT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/gpu/drm/i915/intel_display.c

between commit:

  9f58892ea996 ("drm/i915: Pull all the reset functionality together into i=
915_reset.c")

from the drm tree and commit:

  d0e93599d396 ("drm/i915: prepare for drmP.h removal from drm_modeset_help=
er.h")

from the drm-misc tree.

I fixed it up (I think I got the right include files in the right order in
the end - see below and please check the final result) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/0_T==Z=29r/u++WozInW5UT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxc2xAACgkQAVBC80lX
0GylaggAjPC9HHdpNadMV9CvoolOn3OaLbZwNK+ZUmluW48Txp3IvtTWNAUqwK/o
/WdATEJlUw4o3AhJR6CqeuU7hN+U+sajYp83L8bHoUx4P0vu5sq0F+RreB7IeDE0
VF1IPW7Hh6oJrg2UVdjFRL2/YWTLjsgVf3nwX9dtyT9e0ujqYzT3iQfmgDix4V6L
Cb0P80XfTBUu9NHzP59M0eMt9wWcjMiHq/K+gN8BnNOi0kXREEurenOH7R3khQYs
YImrErySL2wbc0dVY7/hNAOdziSEgejfm/Dou+MxDeEOXfXIl8RuxRTK5/Bdo6Rx
JYNEKHlCn5uiBqosdVNx3M4s6S2YTg==
=sAO9
-----END PGP SIGNATURE-----

--Sig_/0_T==Z=29r/u++WozInW5UT--
