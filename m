Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3014AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 00:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34B320663
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 00:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DFylXH2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34B320663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407940AbeKWKza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 05:55:30 -0500
Received: from ozlabs.org ([203.11.71.1]:33571 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729836AbeKWKza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 05:55:30 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 431GxQ1C0Qz9s3C;
        Fri, 23 Nov 2018 11:13:27 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1542932014;
        bh=d2eyL8rxv5i6FsYCXA79zvnpIxPu+G5YMWrrH2JEunw=;
        h=Date:From:To:Cc:Subject:From;
        b=DFylXH2I9P6dRPOUwOGvV7lmSeWXG6lQquRpw+bSt9XC3WjdRsI+sSbhwOJvQmaYR
         EDU6L62xaWMX7Sr17aeo+3w4fRVq0x+0hFVayBLMO2AArpoyscsVqOO0k6zoDmuoIc
         ridC1n2EDF9Hmt++3I2rpaFJi9p6QL3J1v4ozAH2tc1gjDU3V3WK9g1yLqL1s/IfDa
         yDKM5m9uJ0Slr7Aem6iJa75CdSEJQdbGDpym5zJ+Qko3LbQ5l2//ac3yIor7JtK5mX
         UW/37jg9+f6i6l6LdxYndeKdtf9TY88SwIjqDjTeo80XbyvMGVt9Vcufv8r/ZTiYHs
         LY+kBH0/n8ejQ==
Date:   Fri, 23 Nov 2018 11:13:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: linux-next: manual merge of the drm-misc tree with the drm tree
Message-ID: <20181123111309.74882d70@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/sPCzz=0NRvj.EWUcJp_LpA7"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sPCzz=0NRvj.EWUcJp_LpA7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/gpu/drm/Makefile

between commit:

  2bb42410b1bd ("drm: Remove drm_global.{c,h} v2")

from the drm tree and commit:

  c6fdea6e1a19 ("drm: Merge drm_info.c into drm_debugfs.c")

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

diff --cc drivers/gpu/drm/Makefile
index 7f3be3506057,7c88f12096c5..000000000000
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@@ -10,8 -10,8 +10,8 @@@ drm-y       :=3D	drm_auth.o drm_bufs.o dr
  		drm_scatter.o drm_pci.o \
  		drm_sysfs.o drm_hashtab.o drm_mm.o \
  		drm_crtc.o drm_fourcc.o drm_modes.o drm_edid.o \
- 		drm_info.o drm_encoder_slave.o \
+ 		drm_encoder_slave.o \
 -		drm_trace_points.o drm_global.o drm_prime.o \
 +		drm_trace_points.o drm_prime.o \
  		drm_rect.o drm_vma_manager.o drm_flip_work.o \
  		drm_modeset_lock.o drm_atomic.o drm_bridge.o \
  		drm_framebuffer.o drm_connector.o drm_blend.o \

--Sig_/sPCzz=0NRvj.EWUcJp_LpA7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv3RhUACgkQAVBC80lX
0Gys+QgAk7eSH5O298kafMwyh6zFaQS68csl/LnHa23k9yeMhRe3FNZaJmKbF1wv
4ofzRc4fQZOIlIpfDmMagwvSzcBb1t1HbfVrsw0UYLzZqua6bn82xLSHA4KSWY3y
15Uvtxn3e4oUm1Edc0DBBhtyTlofI9XiriZUcvM5a2uCL0lePcot/zkGaw+pV+Es
70LOoY/HuCXNpu56dxZQISkLHD6IGaKuckoOi3F2n5M0iNMizKsdky+Lbnk20K98
z1W72YMYFvGQbKwZ++YkaP1fDGnnfXFnoi8mqs9Q5RZerx8VupqyTz1xyVlnJlyZ
AFb7n6D4Y+0UMPFnAnpFIjX21Cwc1Q==
=qzfl
-----END PGP SIGNATURE-----

--Sig_/sPCzz=0NRvj.EWUcJp_LpA7--
