Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D7FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E310D2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TQg92Pv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E310D2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937209AbeFSBVp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 21:21:45 -0400
Received: from ozlabs.org ([203.11.71.1]:47691 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937146AbeFSBVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 21:21:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418qtY48NCz9s2R;
        Tue, 19 Jun 2018 11:21:41 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529371301;
        bh=LMq/LoR+rIwcV2lMRPYT3rDT7W9tMtSInkWHPRdrv/Q=;
        h=Date:From:To:Cc:Subject:From;
        b=TQg92Pv5VxCK175WuhwtyMEh5CABVXtFK/N0kM+9G1MwaRCDK+xKhi4RO4ahp+HIW
         pquXon2dTNvq2EMYYiehmkQHAYSAD2S2eIS9P+bu0AMT3tbqw3QWL2p4aZnd9g3Ant
         tmVd+cqQiFe4hx7SgUWT+OQUROpL9QzfeeNm3/u0Y5MJ7WDES+/cfFTN8u4L8ljBO3
         Y3wA2CddbXz1Zjpwc9jXBn87/6Ip40K1UGwl0yPIfL5GmWKQrAn5iNektPthLEheIR
         ysQOZA3SV2X3qKPel/Xe5Kyp0093RYS949woUEoKkSEm9XIMgJ4+H0GYVtC1YDjAJH
         tN++W6qsUHhyw==
Date:   Tue, 19 Jun 2018 11:21:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: manual merge of the vfs tree with the overlayfs tree
Message-ID: <20180619112140.58be35dd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fM04mZG8oQ6OrLSZGB6.rfU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fM04mZG8oQ6OrLSZGB6.rfU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

Today's linux-next merge of the vfs tree got a conflict in:

  include/uapi/linux/fs.h

between commit:

  1d91ca426d8d ("Partially revert "locks: fix file locking on overlayfs"")

from the overlayfs tree and commit:

  28514d1edad4 ("vfs: Suppress MS_* flag defs within the kernel unless expl=
icitly enabled")

from the vfs tree.

I fixed it up (I used the vfs tree version of the file and added the
following merge fix patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 19 Jun 2018 11:16:12 +1000
Subject: [PATCH] overlayfs: fix up for MS_ constants moving

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/uapi/linux/mount.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 3634e065836c..fb104836a51f 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -37,7 +37,6 @@
=20
 /* These sb flags are internal to the kernel */
 #define MS_SUBMOUNT     (1<<26)
-#define MS_NOREMOTELOCK	(1<<27)
 #define MS_NOSEC	(1<<28)
 #define MS_BORN		(1<<29)
 #define MS_ACTIVE	(1<<30)
--=20
2.17.1

--=20
Cheers,
Stephen Rothwell

--Sig_/fM04mZG8oQ6OrLSZGB6.rfU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsoWqQACgkQAVBC80lX
0GysdAgAo1s7cqVK1K67FxOnlVHga7mJD77YJCLhzSujfwH07/mwJgBKI61aIe+X
0H8/s6trv5LxIMYu8s1y/RwxLU3WjCexG4r+lJMvoxOQ/U2CFHZmQ3okZVC2XVJK
J+n+gm9vZHFKWkfmerQpoZvLYtMKw6krcq7Ov5mYQ63TmcKlhdXscbbIf67w5Fov
K8iQH8ORUpJw9q0Onkun7xREu9JrCm6lkGiCpbiL1i79XJkbVJplq/a7JZWwqYXd
q/tnwQ3Wwa8tsQMXrBzjVAr2L1/J9GNX9PcXZckSrD26Kfi2Q/m4ELki0KjPgcjd
r1yU/2udnG3j/j5mA/B5Op/JRLCYzQ==
=8ziM
-----END PGP SIGNATURE-----

--Sig_/fM04mZG8oQ6OrLSZGB6.rfU--
