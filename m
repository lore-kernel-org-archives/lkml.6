Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD6DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE40217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="io5SKAqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbeLRDtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:49:03 -0500
Received: from ozlabs.org ([203.11.71.1]:46157 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbeLRDtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:49:03 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43JkXW14Cyz9s0n;
        Tue, 18 Dec 2018 14:48:58 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545104940;
        bh=P4rmSgGTm2B7w1JPksIGLGnYVsLbNQnwRuFL71W531E=;
        h=Date:From:To:Cc:Subject:From;
        b=io5SKAqrU8nfVdv3GnUihL5pE3A7INxXGlsXkXm4mT7K/tJ+IO6CmmsfXlKX5JKI8
         LRYNgQQ8CckQ+gSXwNjoBKzwPVEQSubMz17lbnysuBtNoizmtsrv5WZcqhJqK5QBib
         WFEtYhCwzigEkgRtXB1cLjPOoXWkl3Nrpy8v2Iyq313fAnGRW61zR13+pvUndjS89J
         Q6P7ExglELw2Xq6KJ4uumcEyDLZ169Yml+Ci1JRNqn/DM9BdqS3VIWt9wY1CLw05PJ
         okEKRBDs5yPtGVc/LJt3g4FnRQUk5axfChW1DWdnBOASzFLaEX3lsKLUt1RVr1MkaC
         jsZpoA2R2QPWw==
Date:   Tue, 18 Dec 2018 14:48:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>, Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: linux-next: manual merge of the selinux tree with the vfs tree
Message-ID: <20181218144858.58d8d1f8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Jgy3mWL0eVVCNryKRbK_KCM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Jgy3mWL0eVVCNryKRbK_KCM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Today's linux-next merge of the selinux tree got a conflict in:

  security/selinux/hooks.c

between commit:

  2b8073b14c19 ("LSM: split ->sb_set_mnt_opts() out of ->sb_kern_mount()")

from the vfs tree and commit:

  2cbdcb882f97 ("selinux: always allow mounting submounts")

from the selinux tree.

I fixed it up (I used the vfs tree version, plus added the following
patch but I am not sure if it is correct as the latter patch only affected
selinux) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 18 Dec 2018 14:44:13 +1100
Subject: [PATCH] update for "selinux: always allow mounting submounts"

The check moved.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 135b147c5bd3..a4505144f95e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1527,7 +1527,7 @@ int vfs_get_tree(struct fs_context *fc)
 	if (ret)
 		goto err_sb;
=20
-	if (!(fc->sb_flags & MS_KERNMOUNT)) {
+	if (!(fc->sb_flags & (MS_KERNMOUNT | MS_SUBMOUNT))) {
 		ret =3D security_sb_kern_mount(sb);
 		if (ret)
 			goto err_sb;
--=20
2.19.1

--=20
Cheers,
Stephen Rothwell

--Sig_/Jgy3mWL0eVVCNryKRbK_KCM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwYbioACgkQAVBC80lX
0GyCVAgAmUBgqI0hz1s+BJF+peClzwuxPitHyVDv7TE2mtky4dREBGQ7uIAyTzNT
cTGsJXYTRGd6YhgR6nJGZpr9thKoc+vkfc/8a6SDBzagzLsAohuUXzHNNwp3iERq
ZOhGTrc3HZvpfqycdYjghEtnq7wI/mRw9TUHymQ38/r/bD6AdXZUS5OwBzjOt/tz
Ob1GpxKX2u4DEWOk889AtHKSxFLc0DJmM4wvfPD/9xQBqml8u2XO82P0yL4gx2p0
EdezQSvjKeNugQduLdbJ3o04Vu0HtkVdwOMzt242TIQb1/jmsksVNiPQvy1NjOii
wImpqFpibmScXLL5ls7w3ZS8Yj+YKQ==
=IR7e
-----END PGP SIGNATURE-----

--Sig_/Jgy3mWL0eVVCNryKRbK_KCM--
