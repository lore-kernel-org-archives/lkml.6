Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D149C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D404D2186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqV++Z01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbfBFOBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:01:22 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42730 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFOBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:01:22 -0500
Received: by mail-qk1-f193.google.com with SMTP id y140so4251340qkb.9;
        Wed, 06 Feb 2019 06:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WjF+76bcULbKhrq8I92xMY7RtjhTdaN5HE2WR3RNwUI=;
        b=iqV++Z01CL+QkcbR3AXfDBDVr1a8ThWVDb8eVeWvP9TwiTYDrDH6fysSWlUqkHbo2a
         dJGgQ0RGprbiXbTx5m0hXUtZ37WEBrudfuc2vcmDgUVhlwgMClvfm3iy6pEzpi7xUvwp
         zUDISVEWvBZzSRgYD43VgKC8fuaK+pZMy4YRwAnIEdFkRJL6vVKS/DKSUk4XS2rA/4mm
         6T3udFV2XUZl35QAKfY7MvLnykY01bZOcJEJMxPvRpmwjEcPzCGwnkASNrsd74LifQKo
         WAO9gI7vZXOA5x/2vr7cYsO9jENNZKdRkLT3BRaGEOCKagmXUx6LgLRN3+PVc/EgzwAl
         0UUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WjF+76bcULbKhrq8I92xMY7RtjhTdaN5HE2WR3RNwUI=;
        b=oCqUQIixgvf5xWSLCWfNHcV7Lxpnx1QR3n8cB8CJzOxlWOPkT8nxI6Z3L7HfG/vWkU
         /5I/xzOAA4g7EqVXhok/PDiuKfIsZj3gNodDN1TDC59EY1imNTgsDqvJhWIu++Ddlh3+
         yaRPViWqHOqlrlcTTCnAVnc/Toj7gkF7P+fpPLAlY86W4U6dsEq/oWRCce+Ss1MikhAd
         jt/OU5bUtXq2QkP/pXCb9TQ5vZMyBJsA71X/j+47LYHAI09ozqN82AsTmiKcHpULweDp
         m/td6rbC+5GFkRi8xah9eDB5cZr2saWPRHogIM3lRZJySpD7Ij70o6Xv6qcJwBmv+TrK
         rv1A==
X-Gm-Message-State: AHQUAubXRGHlxqysiEnPudQBlwsJewvNmHsnoicsh0Xv02UIqBtPzwiz
        F9mYxDqlN2fEu5O9CcwjYU9U2Z1W
X-Google-Smtp-Source: AHgI3IYHaNbes9SjB+UHqpvsxXvnd7HBntMz4WetXfQvBOHtGU58ruTUAAMePqB2xJqM+xhwhIE25Q==
X-Received: by 2002:ae9:ea02:: with SMTP id f2mr5366032qkg.178.1549461680165;
        Wed, 06 Feb 2019 06:01:20 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e5sm12764440qtr.52.2019.02.06.06.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 06:01:19 -0800 (PST)
Date:   Wed, 6 Feb 2019 12:01:16 -0200
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     stable@vger.kernel.org
Cc:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] drm/vkms: Fix license inconsistent
Message-ID: <20190206140116.7qvy2lpwbcd7wds6@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mtajz6uhwm4audxs"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mtajz6uhwm4audxs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fixes license inconsistent related to the VKMS driver and remove the
redundant boilerplate comment.

Fixes: 854502fa0a38 ("drm/vkms: Add basic CRTC initialization")

Cc: stable@vger.kernel.org
Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
Changes in V2:
  - Add "Cc: stable@vger.kernel.org" tag

 drivers/gpu/drm/vkms/vkms_crc.c    | 3 ++-
 drivers/gpu/drm/vkms/vkms_crtc.c   | 8 +-------
 drivers/gpu/drm/vkms/vkms_drv.c    | 7 +------
 drivers/gpu/drm/vkms/vkms_drv.h    | 2 ++
 drivers/gpu/drm/vkms/vkms_gem.c    | 8 +-------
 drivers/gpu/drm/vkms/vkms_output.c | 8 +-------
 drivers/gpu/drm/vkms/vkms_plane.c  | 8 +-------
 7 files changed, 9 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crc.c b/drivers/gpu/drm/vkms/vkms_cr=
c.c
index 9d9e8146db90..d7b409a3c0f8 100644
--- a/drivers/gpu/drm/vkms/vkms_crc.c
+++ b/drivers/gpu/drm/vkms/vkms_crc.c
@@ -1,4 +1,5 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0+
+
 #include "vkms_drv.h"
 #include <linux/crc32.h>
 #include <drm/drm_atomic.h>
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_c=
rtc.c
index 5a095610726b..6ddaa1610807 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -1,10 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
=20
 #include "vkms_drv.h"
 #include <drm/drm_atomic_helper.h>
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_dr=
v.c
index b13f99a5c849..738dd6206d85 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -1,9 +1,4 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
=20
 /**
  * DOC: vkms (Virtual Kernel Modesetting)
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_dr=
v.h
index e4469cd3d254..81f1cfbeb936 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
 #ifndef _VKMS_DRV_H_
 #define _VKMS_DRV_H_
=20
diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/vkms_ge=
m.c
index 80311daed47a..138b0bb325cf 100644
--- a/drivers/gpu/drm/vkms/vkms_gem.c
+++ b/drivers/gpu/drm/vkms/vkms_gem.c
@@ -1,10 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
=20
 #include <linux/shmem_fs.h>
=20
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms=
_output.c
index c5b16efed51a..3b162b25312e 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -1,10 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
=20
 #include "vkms_drv.h"
 #include <drm/drm_atomic_helper.h>
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_=
plane.c
index 418817600ad1..0e67d2d42f0c 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -1,10 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
=20
 #include "vkms_drv.h"
 #include <drm/drm_plane_helper.h>
--=20
2.20.1


--=20
Rodrigo Siqueira
https://siqueira.tech
Graduate Student
Department of Computer Science
University of S=E3o Paulo

--mtajz6uhwm4audxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlxa6KsACgkQWJzP/com
vP9YhQ//YrBxElJs487jVfcEbwFoPW5obzq41ypfCVuOMfZh5n/dS6IfcmCLCapU
YZEUuqb+iHm+kF/GbrT7JQU/TAstcu59yQx1UovlNVrZ5oi/VEG8+264PbRDZawg
gNp2Dxhz00TpNQ6jnRDem8EogLsiUpBUnh16E6+TEaG1Z/5y3UcB7RkRfuXUCJsh
3ee5lzd/PbUYWIKnhiH6ROBe0/iZ3oW4CtNNmMV1ExHAtQlqlUKoKj3H2sMZO/dy
Ss7/2j6lTEaalsojFS3iphDkZQk4323YqFEJ1ZyaIZvXLCQgqghtqo7Vvtr2Qooa
W+eWDdbfbklPFuoxInFpGnH0w0nxb5wLNxthuJreueawgMK3ehUgxx99NUkdZPNZ
VaWoRCXPDuv6UJWLL3dUMqKljyzMBpnpzSxTClrlQnmHwiEDt+oE/jYyEAohzaDi
jQ0ImV9+FEoPrIm+4jm1plfyc/9sLZvjbbYau64ez6wlKLfJrs7atd1Il0PkFPa7
XOsMVYYpNeZR1ocdowBK6RJFQiM9QXFVXpsa+RnvFEHrQMoFtB3PVlKm1MoHhNwB
hk1P9Er0kn82I++3A51MZ3YCDlVQkbQLeow8va9EUoZTuu/VuN7P0b0hhvM9ncoR
651Q+koTcfThmWvUjdjqqXexIaEwKoBDQ1JPp5BwkWx8UDNY4FQ=
=POEn
-----END PGP SIGNATURE-----

--mtajz6uhwm4audxs--
