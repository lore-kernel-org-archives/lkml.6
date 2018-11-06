Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279C8C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C4B2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AgjrJWlZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C4B2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbeKFJbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 04:31:21 -0500
Received: from ozlabs.org ([203.11.71.1]:49787 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbeKFJbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 04:31:21 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42pqf24gV0z9s7T;
        Tue,  6 Nov 2018 11:08:58 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1541462940;
        bh=nQPYXqvY42yB47oYQi2vLTm8nuSrPH3/9W3PLDyJB3g=;
        h=Date:From:To:Cc:Subject:From;
        b=AgjrJWlZ2OJhW96Ojgy5DNHqeaTbL1kZcZBis5+2sG991YQGakMoprod6xbYZ5RHs
         wwhqMDBi5YoyHkE/MH51qmmD+MMdJ76BoOtBkkTtnXyca1avvJwLcxyUTNW/MAXXP+
         MVF5pKGKefYmnvl0r1NpKo5JpBiosvLO9t/xH/tmzs9W804TnLx0Wu371ZarFzSHUy
         Kx2QbL64vKcxlkMyo8oBVO4+66KV5h/X+V0lN1dmybOhKkrt+UInJTZR9gukUvWG3r
         SKFYrIBqNMdyAqA2SJfkM+65kt5u75XWD+OilJ0MHYMmVQbTlfmDA5DFqDwUf1J3Fo
         UOHyVWX6S8YTg==
Date:   Tue, 6 Nov 2018 11:08:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the drm-msm tree with the drm-misc tree
Message-ID: <20181106110857.0b38fa37@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yahXGyYDgNmkEuAQJp.Ra5m"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yahXGyYDgNmkEuAQJp.Ra5m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-msm tree got a conflict in:

  drivers/gpu/drm/msm/hdmi/hdmi.c

between commit:

  f384d7d514d1 ("drm: Convert to using %pOFn instead of device_node.name")

from the drm-misc tree and commit:

  bdc309778907 ("drm: msm: Use DRM_DEV_* instead of dev_*")

from the drm-msm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/msm/hdmi/hdmi.c
index 23670907a29d,74ffc2412f68..000000000000
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@@ -579,7 -585,7 +585,7 @@@ static int msm_hdmi_bind(struct device=20
  	hdmi_cfg =3D (struct hdmi_platform_config *)
  			of_device_get_match_data(dev);
  	if (!hdmi_cfg) {
- 		dev_err(dev, "unknown hdmi_cfg: %pOFn\n", of_node);
 -		DRM_DEV_ERROR(dev, "unknown hdmi_cfg: %s\n", of_node->name);
++		DRM_DEV_ERROR(dev, "unknown hdmi_cfg: %pOFn\n", of_node);
  		return -ENXIO;
  	}
 =20

--Sig_/yahXGyYDgNmkEuAQJp.Ra5m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvg25kACgkQAVBC80lX
0GxAMggAiJZdK93sVWWlZu9dKtT/eyjoG3cIWDN+q+EogqUKPM1gvKjGZeOrn6zZ
Eqzles2wqAtHDUwAi85T8GdLByPgGeYQSdjg/4ioLxzzVUIMC8XOr5B/ZH3/C5oT
9Ml9tykS/jd5rDdsxnDqFPX8MA6EsF7I/1zncZjKcs0g8t5+LV+1y7UuvPiAnYHJ
rPaa5eK8Lsy5nYNgOp/RctM2vF3cvGgucmjQgMCGjBKHwukud6mKp48hrbKJ0Fem
zy2JqGn/eayjEaXgB/LQ5B4/MoS42QKm51PF1H46cbfE1Hog3Efx3sHAWr4V7L1H
KVmWr/oU/4oAahW5s96/bdh+fzfO+w==
=Ryr9
-----END PGP SIGNATURE-----

--Sig_/yahXGyYDgNmkEuAQJp.Ra5m--
