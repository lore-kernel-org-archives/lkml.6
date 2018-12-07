Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6591BC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214FB2146D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FVAPpqty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214FB2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbeLGCbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:31:48 -0500
Received: from ozlabs.org ([203.11.71.1]:55291 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeLGCbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 21:31:47 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 439xLS2zTvz9s4s;
        Fri,  7 Dec 2018 13:31:41 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544149904;
        bh=ak1PPLTFdCdOJEq54PNUKcRJZCp7H54xjbakmo+9bC0=;
        h=Date:From:To:Cc:Subject:From;
        b=FVAPpqtyFHdfaBPcEiOU3v2mPviG9SWyxBvoUWPB98nrqzIxZIrtPsPNRABR09r9o
         JmKpYhVnvq9TF0y94xMppf7nVnwR9tu/JcLan/61k51IkKLarD+dUmmW3sgRiQV1H7
         IQG+OMHeU9P3ZC1ULDfYdMClXAMpKROqaRGVcddHVBcSAcdw+7x1nFA587HA2JvO2g
         ZLODsMlrm2OyrgT34NhHA7Z8w6EDCs8fwhKrJ89lCKM+bdoAbFSq42uojPViurUN8s
         T6sNlF7qj6ds3UpHXrS1sdPCuaB6VXKjWdGTVrwjbsUaX3bpkhDMj4Y7WV7wrZuU2a
         aYxWrFJXNvCnQ==
Date:   Fri, 7 Dec 2018 13:31:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Francis <David.Francis@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <20181207133141.523b8417@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+s.zoL+r44rIKQ=uSDVM_Bx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+s.zoL+r44rIKQ=uSDVM_Bx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

between commit:

  49f1c44b581b ("rm/amd/display: Fix unintialized max_bpc state values")

from the drm-fixes tree and commits:

  c1ee92f94ce3 ("drm/amd: Add abm level drm property")
  bb47de736661 ("drm/amdgpu: Set FreeSync state using drm VRR properties")

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

diff --cc drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5a6edf65c9ea,32e791d9b9a8..000000000000
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@@ -3063,8 -3234,7 +3235,8 @@@ amdgpu_dm_connector_atomic_duplicate_st
  	__drm_atomic_helper_connector_duplicate_state(connector, &new_state->bas=
e);
 =20
  	new_state->freesync_capable =3D state->freesync_capable;
- 	new_state->freesync_enable =3D state->freesync_enable;
 +	new_state->max_bpc =3D state->max_bpc;
+ 	new_state->abm_level =3D state->abm_level;
 =20
  	return &new_state->base;
  }

--Sig_/+s.zoL+r44rIKQ=uSDVM_Bx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwJ240ACgkQAVBC80lX
0GxqhQf9HTp1YC9uykaXRQ4bhYvLF33YDBYDB/IFYPsgJmJDeKuvBomLV/f+TsJu
vf+Dwg/a359/6CePohUgK516PiaoDeOpHlreSgG0QrcRh/nMrWfmcEvX1cnu8Zf2
59zr6kVJTB4IJcnt7+0Bv3KYp2Vo6uTC7EUYN3x+lGYkYroV5ZzokDXuFboNGmxo
qZ+HOGKKhVPEXjtcfGbIrTSaaVmRxo4UHsOcGrxnwwxktHNcDMbOzwN3V//3yF1l
Yl98X1GFDV+HLDFFAcJoavWUQwHIaBEjTAljdi8Tov+fQixa4Jb8hXMTIMCJoRzj
qt69FGiEVRn7LL9WsiGexzT92nmvbQ==
=+2Fg
-----END PGP SIGNATURE-----

--Sig_/+s.zoL+r44rIKQ=uSDVM_Bx--
