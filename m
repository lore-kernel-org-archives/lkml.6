Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E7BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C6720878
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tRc8ie+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C6720878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbeGWFtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 01:49:33 -0400
Received: from ozlabs.org ([203.11.71.1]:47863 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727765AbeGWFtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 01:49:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41YpvM1dFHz9s2M;
        Mon, 23 Jul 2018 14:50:07 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532321412;
        bh=nvCZvOuNl7jMQfdPj98ExgYbBTMd3+aFcHZ2QB5N1io=;
        h=Date:From:To:Cc:Subject:From;
        b=tRc8ie+E8YUJcnIAU5jZQVV493/XgoCdWmZQ9CCxbHwBLigyNFRNmIJTbVQfO2IGI
         vo5eBvbzKAC7iXIax144iDh0CzkfVOsV0C7UBEb6rCpdSJJ9TQ41YwiYOD+IxJjjK4
         oKCl/feTy5Ce8K1o9/yQJno8a0aUF4nBCL7BL05Hz166/tJYx0HJ6gJk+2G2XPn4LO
         fUQtFH5iRIr80aQ+zmj+1dLEA3Qfq0F6hECH9Wot0FQ0mWUWBhhEHGHnFLsPuWWTTw
         q4VD3iYKaHjOSL5VFfF0hQoJRbHdab4kJQqeQ6kKoh5LHnJZPB0mhL+p0vw8HZtbLs
         zBiSChZsdlZ7w==
Date:   Mon, 23 Jul 2018 14:50:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>, Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: linux-next: build failure after merge of the drm-msm tree
Message-ID: <20180723145006.5a26207f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+xjnmUetd=y0duXd=.MLNVr"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+xjnmUetd=y0duXd=.MLNVr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

[Dave, this will presumably soon turn up in the drm tree]

After merging the drm-msm tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c: In function 'dpu_plane_destroy':
drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:1483:3: error: too few arguments =
to function 'drm_plane_helper_disable'
   drm_plane_helper_disable(plane);
   ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/msm/msm_drv.h:43:0,
                 from drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:24:
include/drm/drm_plane_helper.h:72:5: note: declared here
 int drm_plane_helper_disable(struct drm_plane *plane,
     ^~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  drm_plane_helper_disable ("drm/msm: Add SDM845 DPU support")

interacting with commit

  070473bcf703 ("drm: add missing ctx argument to plane transitional helper=
s")

from the drm tree.

I have added this merge fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 23 Jul 2018 12:47:04 +1000
Subject: [PATCH] drm: msm: merge fix for drm_plane_helper_disable() API cha=
nge

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/ms=
m/disp/dpu1/dpu_plane.c
index d3d7ebf0c394..b640e39ebaca 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -1480,7 +1480,7 @@ static void dpu_plane_destroy(struct drm_plane *plane)
=20
 		mutex_destroy(&pdpu->lock);
=20
-		drm_plane_helper_disable(plane);
+		drm_plane_helper_disable(plane, NULL);
=20
 		/* this will destroy the states as well */
 		drm_plane_cleanup(plane);
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/+xjnmUetd=y0duXd=.MLNVr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltVXn4ACgkQAVBC80lX
0GzjNgf/Z6u2dz+1Fp7VQC3NvGWmKTfv7kkl/Anz1D6xfWlOCaJTi+Dv7VZFHcZp
oWnAolpBpEHeUHU/BIjm+HdieSYdg6nqFJg5mjLVPxe7CUUO0s9Mvh7rg+Th0vNK
NTj+vGPLgSSIVtPWw7NVkZXj1DEDLQpmYMhGDVdARudHSbnbMG8Udq5xCV1RVLJC
gDApa50kjrfb3Ujsh5dZ8x1qaOXX5KE0taakB4545enOiFvfTuPHKRFG5t38OGwh
a+/7yOZguW831CkJ1g2u+Noe2Vo7nn5IfPwpthfq/kBUkXyokkhSmPkCVFhsGnKj
ht7Tf+2gNgNLtIsAoOzUfCk3VPoaVw==
=pqLA
-----END PGP SIGNATURE-----

--Sig_/+xjnmUetd=y0duXd=.MLNVr--
