Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BAFC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E78E20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MfiW14jM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E78E20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeILFmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:42:12 -0400
Received: from ozlabs.org ([203.11.71.1]:41477 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbeILFmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:42:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4292xX1tVvz9s3Z;
        Wed, 12 Sep 2018 10:40:15 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536712819;
        bh=B1+Nlkk0sBKTMSPSjjVnpuenSurdEHI0Tf9D4PvyqrE=;
        h=Date:From:To:Cc:Subject:From;
        b=MfiW14jM4KQhxzmt7mgonEXDaekRwgzb8VCwHVe3PmFGMNVeBd3SVjYw07vTzq0gx
         aCzyzTV777wMImHK03/c5mVveWl4krwnbLggCU2RzlcgH4Mspur0jxVsjlt705UUlH
         o4/7YcnAjVz6GX8fzWijP13mWTgXS42OvbrLrHNTf8HqAPvbO/F64SRgboR/u96PmB
         KQvFu5B3dD/6JrL00JdMUG2z4J9cLEH2ezBbVTacKxyKxJvEFHfE5UlEAvmPr+xIvS
         hsCkhNmPDMX5svpPCe5W916CV+cqd1o0lEFwMMr4FANbkPJ96ycYudOMdEDknK0V0T
         CPv7mjLPx+KWw==
Date:   Wed, 12 Sep 2018 10:39:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: linux-next: manual merge of the drm-misc tree with the drm tree
Message-ID: <20180912103952.6f439e71@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/aZLBaNy0rR/pAyR8cCuc8g/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aZLBaNy0rR/pAyR8cCuc8g/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/gpu/drm/i915/intel_display.h

between commit:

  dce888798d3e ("drm/i915: remove confusing GPIO vs PCH_GPIO")

from the drm tree and commit:

  d78aa650670d ("drm: Add drm/drm_util.h header file")

from the drm-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/i915/intel_display.h
index e20e6a36a748,809c06ae4c07..000000000000
--- a/drivers/gpu/drm/i915/intel_display.h
+++ b/drivers/gpu/drm/i915/intel_display.h
@@@ -25,22 -25,8 +25,24 @@@
  #ifndef _INTEL_DISPLAY_H_
  #define _INTEL_DISPLAY_H_
 =20
+ #include <drm/drm_util.h>
+=20
 +enum i915_gpio {
 +	GPIOA,
 +	GPIOB,
 +	GPIOC,
 +	GPIOD,
 +	GPIOE,
 +	GPIOF,
 +	GPIOG,
 +	GPIOH,
 +	__GPIOI_UNUSED,
 +	GPIOJ,
 +	GPIOK,
 +	GPIOL,
 +	GPIOM,
 +};
 +
  enum pipe {
  	INVALID_PIPE =3D -1,
 =20

--Sig_/aZLBaNy0rR/pAyR8cCuc8g/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluYYFgACgkQAVBC80lX
0Gx2qAf/bYg4cs1wNRFYgpsUBMqOrJdDH6bKlP872uoMvJ+g2a11x/hcqXjPJ4SM
cPDlZEAqa1k32kg6TZTih2p8R7ShXIRCtCHTNyOdSkuR4KttMHCYgPwod6pxv9ZU
+qUIjKqvh5usL9maRqYRd/fCXjFuUZsgwIfU4d/wY1QnIEzASj4HzqR9VuAr3BcX
TcVXimY+APoKgLWNLQC2f71Vq5fFKCxakfxCClFEaT81xcDYYgUUQunq6JeJqcB5
TE+Eboat+to+hX0SFutZ7d6q1hQLrWxh/SFt6NgzPFSMoJX3G8L5rfIYsOocGHta
sA7u+qyKgp6HUBUKge1rws6RmXMCRA==
=u2C0
-----END PGP SIGNATURE-----

--Sig_/aZLBaNy0rR/pAyR8cCuc8g/--
