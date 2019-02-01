Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727EBC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231382084C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gbRElwZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbfBAAx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 19:53:57 -0500
Received: from ozlabs.org ([203.11.71.1]:37321 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbfBAAxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 19:53:55 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43rJWh6P63z9sMl;
        Fri,  1 Feb 2019 11:53:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548982433;
        bh=LUa66qrn/LX7xAw7MTN+2I872NwrrUKEj9uEPBMaUXU=;
        h=Date:From:To:Cc:Subject:From;
        b=gbRElwZuxCSdWH7mAlBX8AkJ+nikWEjo8Wescxw9A03/zrvo+Jv09tHzqMjpd2HV6
         A9QWwdbUvt59nHjitEdNPon39ZUKFof2cOtFQ73B/VLnyP/ZmWWeP5Jku9zziGAdh7
         FILwGBDAHiE9E98U9nh279Sjm/Z1F4yOmuQh0XigtjXScY+hDh9A+J8A/eOfsVp9L5
         f/AaAb2Jww3vL0pAhteV5xZeRrvvU6eL+M2wYMB1DGuauz5KpeYJJ+zt5aSmiZdRkF
         LA9Wcb7ckX+9OovTuafhPxunmeIQE5XYxTSX0R5oTVUqcmfc1e+1x+DpP6dBggeX34
         J0zWDWuTmu4pQ==
Date:   Fri, 1 Feb 2019 11:53:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josip Pavic <Josip.Pavic@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: linux-next: build warning after merge of the drm tree
Message-ID: <20190201115351.70a23b79@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tHjXEVvVgo3Asx/RuDMdgHF"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tHjXEVvVgo3Asx/RuDMdgHF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:160:9: =
warning: #pragma pack (pop) encountered without matching #pragma pack (push=
) [-Wpragmas]
 #pragma pack(pop)
         ^~~~

Introduced by commit

  1411fd85416f ("Merge remote-tracking branch 'drm/drm-next'")

Commits

  099139bef026 ("drm/amd/display: Pack DMCU iRAM alignment")

from Linus' tree and

  c591d8429df2 ("drm/amd/display: Pack DMCU iRAM alignment")

from the drm tree are identical, but then commit

  bf75572a2536 ("drm/amd/display: Create switching mechanism for ABM 2.2")

added more code before the "#pragma(pop)" and so git's automatic merge
resolution ended up adding the "#pragma(pop)" line twice.

I will fix up the merge resolution for tomorrow.  This will need to be
reported to Linus when the drm tree is merged (or a back merge of
Linus' tree will need to be done - and well commented :-)).

--=20
Cheers,
Stephen Rothwell

--Sig_/tHjXEVvVgo3Asx/RuDMdgHF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxTmJ8ACgkQAVBC80lX
0GxdFwf/TyEr3KPjLAcTYrxVWaaQWHeOf8v0ZRcvhJYb16GpQe7F9CprXURlYutW
OumdQVX0lO8p+q6pJRbJWIgY1lTQsXcPvs5KATjTqsiOIZLwONcYNUIW+G/VqBX1
b206NJHB/yhSbY0DQbOsjB47JAjoUJ0FW7pNxIzSY6tWEn6oUpZi2cp/4kmJH5mL
ASDUOJusWeM6gIkyhh+HFU7p0Z/EkmrMKcqtRQ3pDJ8WTNmnMxCie0nqotR1Azi0
kHlM3bIrErXWxU24yQszbPTq9TF5d6joG34+PCXpvA811+0LYlme5eD+9Qaf0JCp
BwR+SxAJ+JxVZrA18jJ3QoxEMU87+A==
=gOZf
-----END PGP SIGNATURE-----

--Sig_/tHjXEVvVgo3Asx/RuDMdgHF--
