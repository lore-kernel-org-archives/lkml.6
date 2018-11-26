Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA9CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5332084E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="li5wl72g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5332084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeKZNaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 08:30:00 -0500
Received: from ozlabs.org ([203.11.71.1]:39681 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbeKZNaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 08:30:00 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4339zz1lS4z9s0t;
        Mon, 26 Nov 2018 13:37:16 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543199840;
        bh=YdU/rfkIbgo/yz2B8GgpRRkkHRNywmikAiZnydWP9WQ=;
        h=Date:From:To:Cc:Subject:From;
        b=li5wl72gqG/eIPz0266/vXph/qTQrHHmL+SIQyj93cxV4mV2WAG4QU0XVNr6lCJG/
         u5OotDMhhN0DeBgWNnROSdqGdnwysYnpSjko1k1aSbW3HGymLLX8gDz5Vnbm7yZHd/
         IlVMG/iLdmeMKi4Keai1v4Th+vhlucL0cUf9wtbmb6FJlBEOpyh+0ZfuP/Sixc5XmC
         hneBp+9b6SKBaqeHNqYipd7H2irPCUZZp3eDhbwtEunijBb+YoRANhfrnaHQyBDq8R
         92y4uzosNFVwJ7JFhPhQoSVRuOUQkkaZVnxEmlGowl6RpLnz2oQnyfvRUQhuaTU5YR
         j9mjfSJQWWXBA==
Date:   Mon, 26 Nov 2018 13:37:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Lyude Paul <lyude@redhat.com>
Subject: linux-next: manual merge of the drm tree with the drm-misc-fixes
 tree
Message-ID: <20181126133715.378e8d9d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qs_cfbgb3z0ReS7cdl193FF"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qs_cfbgb3z0ReS7cdl193FF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/meson/meson_crtc.c

between commit:

  47ebfb6ed13e ("drm/meson: Fixes for drm_crtc_vblank_on/off support")

from the drm-misc-fixes tree and commit:

  f9a2348196d1 ("drm/meson: Support Overlay plane for video rendering")

from the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/meson/meson_crtc.c
index 191b314f9e9e,d78168f979db..000000000000
--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@@ -126,8 -115,8 +131,10 @@@ static void meson_crtc_atomic_disable(s
  	struct meson_crtc *meson_crtc =3D to_meson_crtc(crtc);
  	struct meson_drm *priv =3D meson_crtc->priv;
 =20
+ 	DRM_DEBUG_DRIVER("\n");
+=20
 +	drm_crtc_vblank_off(crtc);
 +
  	priv->viu.osd1_enabled =3D false;
  	priv->viu.osd1_commit =3D false;
 =20

--Sig_/qs_cfbgb3z0ReS7cdl193FF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv7XFsACgkQAVBC80lX
0GzMpQgAmcb2ySHlYwpuRYY+SvS3NKyD66j4nX/WTs/MdCbjJET4e5CNiWegBxwm
+pj7s6p8L9ux54xj+yDJMoNd1nZyblPOPuRtTlDV+/TNEsB5J6OBG7LvSbHZNmvm
VNtCep5DTT4+kFIkj5Mk6kg8KTQEr6Suhv9dTniUOxvvvdwMSt6KyZuiPdsxOp2t
vVPvC8s7jRwvoV2LcL8TXMFulDObpv3NcmSs3q/Bboop1gtT9/QTNFwzOtqKTv6y
cd1Q/MWRHBITB4RupHm32iCASH9qGvvrYkDGjvmMBBZb87/qGr9/G2c/smFP9Jdf
OLFJzLKHXy08L5E+fP0ywXCA3CESxg==
=jSpn
-----END PGP SIGNATURE-----

--Sig_/qs_cfbgb3z0ReS7cdl193FF--
