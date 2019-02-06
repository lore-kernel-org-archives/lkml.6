Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2901FC282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E97217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YRMWKb0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfBFAm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:42:28 -0500
Received: from ozlabs.org ([203.11.71.1]:33931 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfBFAm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:42:27 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43vN254bWdz9s3x;
        Wed,  6 Feb 2019 11:42:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549413745;
        bh=ITvP7eJdcFdf7HrD0EEx4bD0OXqgpL390EIFX4S5BCM=;
        h=Date:From:To:Cc:Subject:From;
        b=YRMWKb0yR+4ISDzFKgXwz2TdxXWmwVpFpDXu2rZTAWUEpPsrFIvXrRGdRMLRYbBpd
         /cgG7JFg2fT2/+ltrqGvqe9cnRcEjgsRUp1IQx5w//35qXMSssXd/w/drf5gi0x/oz
         hxAuvRfmwejlPFhxJumu9NU7izzQMJobKVVBOCL1oMJGpdprYi3dvGMUG+ot9cG7la
         X8PvKeXEnIYkedaYtw+zGRA7+bLJZQXV+E+k0qZKAdtHgValfRrcem3xd1+dXgVxDc
         o/70DHBK2I1VQwKW19f0WlmlVGjiFudetNr4H9xInyGA4m5b51caedJ21DAYCzSbS9
         tuCTxafiHBYCQ==
Date:   Wed, 6 Feb 2019 11:42:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: linux-next: manual merge of the drm-intel tree with the drm tree
Message-ID: <20190206114220.5632c187@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XUHT78JYPH91x4gAW9wdL.Q"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XUHT78JYPH91x4gAW9wdL.Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-intel tree got a conflict in:

  drivers/gpu/drm/i915/i915_pci.c

between commit:

  fcd70cd36b9b ("drm: Split out drm_probe_helper.h")

from the drm tree and commit:

  5f5c139d6900 ("drm/i915: Allocate active tracking nodes from a slabcache")

from the drm-intel tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/i915/i915_pci.c
index 5d05572c9ff4,36fa6f1905fc..000000000000
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@@ -26,8 -26,7 +26,9 @@@
  #include <linux/vgaarb.h>
  #include <linux/vga_switcheroo.h>
 =20
 +#include <drm/drm_drv.h>
 +
+ #include "i915_active.h"
  #include "i915_drv.h"
  #include "i915_selftest.h"
 =20

--Sig_/XUHT78JYPH91x4gAW9wdL.Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxaLWwACgkQAVBC80lX
0GyQ5Qf/QB6W0fsgclxSn92fdfS1sA2Sirv0GdLVK45gy7YQLuplprQn+g/0F1Mn
cGCpcULL0kVQus/avo5acFxQBffTHpvgXVurhNWZa/N7lsSnrA2w/k4yJF50M2ZU
8niXZu+EPJb5kjmhEfWyTGL3X4eBbgChBXxnrX05yWYbRP4lLm4oi8oNeHwHJ510
CrM/TDrhBfFaehhJNnNc1sCQPTd10W5Y3hcnBuOYn+qYpdVHdInjz4GdsPQZsvdr
V76lTo9n7LOwPbA646DWvRk7ZW191hGXAiTWSn3+ez5gmdyCgC0zOpEfIirJUS6K
YtiNKoAph+LSUnoAsGNQKXewkRDSdg==
=+cpd
-----END PGP SIGNATURE-----

--Sig_/XUHT78JYPH91x4gAW9wdL.Q--
