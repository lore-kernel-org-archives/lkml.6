Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4FDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EC820883
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cG9kME2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfANXq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:46:26 -0500
Received: from ozlabs.org ([203.11.71.1]:43265 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfANXq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:46:26 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43dqqc3733z9sCs;
        Tue, 15 Jan 2019 10:46:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547509582;
        bh=V0N+ql6Xd+1ucZVPI7EGKvOljcTl+xEmGq45eKCJhWY=;
        h=Date:From:To:Cc:Subject:From;
        b=cG9kME2LGpXmDa62ClrKMuzw4tTHO8kSShR76AoHzCXpN7HFHJkEpdMKWU1vbrRnY
         urVZQZ7VfOQhWCGdINcx1R43keWQAHwuhJTe6rqLLhQsCKcY3hJL3CJgqYJvdWFTvR
         9kw6XG9RmBXuO7Ao/xmDD7Ip0mvbYDTYGUl/F3BiuLvHY6PLCueY2LVlqofUAGPTPa
         AYE8zfWWHd5HrLoPnliI/jXfm9UxaTmB0J1HtVOQGhodD3q7lO3/0AWLwzP4CI1Fma
         rStE+nCuxnyxBqMFr4RZDcqxEwtIrYfCDy9n436A4gkOd5JAopbuK2r9LlbrNqwnga
         63n775FSIKAOQ==
Date:   Tue, 15 Jan 2019 10:46:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Liviu Dudau <Liviu.Dudau@arm.com>, Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "James Qian Wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: linux-next: build failure after merge of the mali-dp tree
Message-ID: <20190115104619.516be4b9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ORRWyQUNNFs.5NO+mj+mV2/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ORRWyQUNNFs.5NO+mj+mV2/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Liviu,

After merging the mali-dp tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c: In function 'komed=
a_pipeline_obj_add':
drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c:48:30: error: passi=
ng argument 1 of 'drm_atomic_private_obj_init' from incompatible pointer ty=
pe [-Werror=3Dincompatible-pointer-types]
  drm_atomic_private_obj_init(&pipe->obj, &st->obj,
                              ^~~~~~~~~~
In file included from drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:=
11,
                 from drivers/gpu/drm/arm/display/komeda/komeda_dev.h:12,
                 from drivers/gpu/drm/arm/display/komeda/komeda_private_obj=
.c:7:
include/drm/drm_atomic.h:437:53: note: expected 'struct drm_device *' but a=
rgument is of type 'struct drm_private_obj *'
 void drm_atomic_private_obj_init(struct drm_device *dev,
                                  ~~~~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c:48:42: error: passi=
ng argument 2 of 'drm_atomic_private_obj_init' from incompatible pointer ty=
pe [-Werror=3Dincompatible-pointer-types]
  drm_atomic_private_obj_init(&pipe->obj, &st->obj,
                                          ^~~~~~~~
In file included from drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:=
11,
                 from drivers/gpu/drm/arm/display/komeda/komeda_dev.h:12,
                 from drivers/gpu/drm/arm/display/komeda/komeda_private_obj=
.c:7:
include/drm/drm_atomic.h:438:30: note: expected 'struct drm_private_obj *' =
but argument is of type 'struct drm_private_state *'
      struct drm_private_obj *obj,
      ~~~~~~~~~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c:49:9: error: passin=
g argument 3 of 'drm_atomic_private_obj_init' from incompatible pointer typ=
e [-Werror=3Dincompatible-pointer-types]
         &komeda_pipeline_obj_funcs);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:=
11,
                 from drivers/gpu/drm/arm/display/komeda/komeda_dev.h:12,
                 from drivers/gpu/drm/arm/display/komeda/komeda_private_obj=
.c:7:
include/drm/drm_atomic.h:439:32: note: expected 'struct drm_private_state *=
' but argument is of type 'const struct drm_private_state_funcs *'
      struct drm_private_state *state,
      ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c:48:2: error: too fe=
w arguments to function 'drm_atomic_private_obj_init'
  drm_atomic_private_obj_init(&pipe->obj, &st->obj,
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:=
11,
                 from drivers/gpu/drm/arm/display/komeda/komeda_dev.h:12,
                 from drivers/gpu/drm/arm/display/komeda/komeda_private_obj=
.c:7:
include/drm/drm_atomic.h:437:6: note: declared here
 void drm_atomic_private_obj_init(struct drm_device *dev,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  61f1c4a8ab75 ("drm/komeda: Attach komeda_dev to DRM-KMS")

interacting with commit

  b962a12050a3 ("drm/atomic: integrate modeset lock with private objects")

from the drm tree.

I have applied the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 15 Jan 2019 10:42:04 +1100
Subject: [PATCH] drm/komeda: merge fix for drm_atomic_private_obj_init() AP=
I change

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c b/driv=
ers/gpu/drm/arm/display/komeda/komeda_private_obj.c
index 9edfd6ab0c12..f1c9e3fefa86 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
@@ -45,7 +45,7 @@ static int komeda_pipeline_obj_add(struct komeda_kms_dev =
*kms,
 		return -ENOMEM;
=20
 	st->pipe =3D pipe;
-	drm_atomic_private_obj_init(&pipe->obj, &st->obj,
+	drm_atomic_private_obj_init(&kms->base, &pipe->obj, &st->obj,
 				    &komeda_pipeline_obj_funcs);
=20
 	return 0;
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/ORRWyQUNNFs.5NO+mj+mV2/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw9H0sACgkQAVBC80lX
0Gwjlwf/fLC7NhKAYLX0MfKAV3Sx4pyviHg7su3pI8w3NV2t77JA0IQkb1DkHlDt
SaxCtG0XjnG26nvWduG1RoESnHyVvtKX2uXFdS+nT06PxRjMbbLrqLsJ34Z6GHdr
G2CJxpz/wjmhVELrCY+StBs4+AN/y7Kp5PmSsugdsUBhX+NTOnsfCRKy+IoSGDrn
tUdC2oH5u/W1NxCA7rrggCmA371GJRt2eEiTElpnurcuiv5ZPVb7qkPRyIjZGF3G
CUMaJtISlQLNCir1bVILE21l69PItX5omR/VL6Bk7yIrCtFGXMavpazO4ZS5LqBr
0vBRBDPjVH9mjGebfHe/FHSgOXMJsA==
=W9EV
-----END PGP SIGNATURE-----

--Sig_/ORRWyQUNNFs.5NO+mj+mV2/--
