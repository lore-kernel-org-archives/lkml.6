Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA094C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 03:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666EA2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 03:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nXrW2izo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666EA2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeLJDDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 22:03:25 -0500
Received: from ozlabs.org ([203.11.71.1]:43391 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbeLJDDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 22:03:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43CnvY183Kz9s47;
        Mon, 10 Dec 2018 14:03:21 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544411003;
        bh=nnAAWMBEd7AQ6zvmkz30OAc90SJnUa16BLMPHNlsBEQ=;
        h=Date:From:To:Cc:Subject:From;
        b=nXrW2izoA0S9SCxBSiyldatIDXotRZn7IxYa/LIhGMiqoY1YZ9m7ctSl3FxtIAj5s
         WVofxcPH74xDGewYwXgmttv/i6rq7beS2JHU4J5D7UhoakbZo5wFr8EozmRlEcgh28
         FoaMqCXA17Ib5CRsCquiOYtT0TqD+BtFjojmcslSbdYSj75xdr+pXW2h5CWnzqkRPR
         PVfpRFjdt/KU14bVGJlggMxfPm4Lh/pxMN9zZJtKrT45YiXt82BZn+T6JzByNjxeZ6
         X4OmASmtvNNi5OTIA2Bxunvx0udHZDeaKwDsxfpuDGOkhdEuMdLeKSmtoAtx2gm+tq
         uMyRlSgr0pl5Q==
Date:   Mon, 10 Dec 2018 14:03:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>, Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>
Subject: linux-next: manual merge of the drm-msm tree with the drm tree
Message-ID: <20181210140320.5ba2b2e4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yvq14zz5VR3AAQ0TgU1L9rR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yvq14zz5VR3AAQ0TgU1L9rR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-msm tree got a conflict in:

  drivers/gpu/drm/msm/adreno/a5xx_gpu.c

between commit:

  c97ea6a61b5e ("drm: msm: adreno: Use PTR_ERR_OR_ZERO rather than if(IS_ER=
R(...)) +PTR_ERR")

from the drm tree and commits:

  dadb36b7ec42 ("drm/msm: Add a common function to free kernel buffer objec=
ts")
  7799a98edd80 ("drm/msm: Add a name field for gem objects")

from the drm-msm tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/yvq14zz5VR3AAQ0TgU1L9rR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwN13gACgkQAVBC80lX
0Gw4EQf+LTa78benAqBO19IrVd0qbHteZ7MrACogJaKCqq8S7lMSxKm26z7HTi9T
k3L+PG4uSgZn3NthiFEpSMbwFakCuV5Cow5X+aSu38bXuIw0lmFKQAyrspa+PK4G
pMGTxOd8sXiBYNYysXKpitXzJVrP6Q/N4uDaJkjy7qPGSQnHPwCa7B5Ryo3yvcSP
CXrtoT77jlF2MzjSLFtjNz4KdAb9KXU9VcWfREyXncwmZNd+ea4U7GOaABoTOE3p
MZEBRAxI3VWAqyYAZ9CqgdwhxRtyGpJxhpx9W2ItDIBcecR4tPCngTTODc2nw9R+
itG6uwpUwGTuFaJotDIafD3im8Mrkg==
=xEqx
-----END PGP SIGNATURE-----

--Sig_/yvq14zz5VR3AAQ0TgU1L9rR--
