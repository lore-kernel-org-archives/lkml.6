Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E80C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5951208E3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jiRT8RE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfABBJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 20:09:15 -0500
Received: from ozlabs.org ([203.11.71.1]:54837 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfABBJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 20:09:15 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43TtHC3jV0z9s4s;
        Wed,  2 Jan 2019 12:09:11 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546391352;
        bh=nylm1KhCfsoBhkT63fCk/6vhQYHzm/+QcjPbTDYIoWY=;
        h=Date:From:To:Cc:Subject:From;
        b=jiRT8RE5y8Qj1Np953FgtodYfyNxJovtDkXvsNCXDoGFtWZvJRxUjXKWk4XOpzQhp
         dkMgrd0u+TNR/ld3tIkqaGwJBbVMUMNNF3Vl0iODjnw8q0re3vRAQFzz82nB7nNesQ
         qaOu2RxL+mc3IXBhawh2VNArp6p7IfeTEFEzJBnKvwgMlC5LxUtG0SItWmlP++wBAp
         yHfjJbLfxNGr+jHzJ5RSufSxMZJ7nhGccBd40kCeJlTv3b4fCWy+vxztu/lI2xuSUW
         YJBA7zx/0asKarnDFurqO3D/i3AWnFkk8wtH8At6EIkn9uD7qmhjqAE1RntAzerV/S
         qpkDnMK6ifu1w==
Date:   Wed, 2 Jan 2019 12:09:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Amir Goldstein <amir73il@gmail.com>
Subject: linux-next: manual merge of the vfs tree with the ext3 tree
Message-ID: <20190102120910.7a673e28@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NnCFe0smkMd93ta7/3oa+hz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NnCFe0smkMd93ta7/3oa+hz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/Makefile

between commit:

  d44170a7ba48 ("fs: common implementation of file type")

from the ext3 tree and commits:

  fe43eec04841 ("vfs: Introduce fs_context, switch vfs_kern_mount() to it.")
  82685adaccb3 ("vfs: Add configuration parser helpers")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/Makefile
index da0d43eb2bc5,9a0b8003f069..000000000000
--- a/fs/Makefile
+++ b/fs/Makefile
@@@ -13,7 -13,7 +13,7 @@@ obj-y :=3D	open.o read_write.o file_table
  		seq_file.o xattr.o libfs.o fs-writeback.o \
  		pnode.o splice.o sync.o utimes.o d_path.o \
  		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
- 		fs_types.o
 -		fs_context.o fs_parser.o
++		fs_types.o fs_context.o fs_parser.o
 =20
  ifeq ($(CONFIG_BLOCK),y)
  obj-y +=3D	buffer.o block_dev.o direct-io.o mpage.o

--Sig_/NnCFe0smkMd93ta7/3oa+hz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwsDzYACgkQAVBC80lX
0GyURgf/en+UO6BfIbaIPXKlEDPDl+20r/Te3xZvbqCj5MLErzEjFxzD7qGN5ZlU
loEzuYyMkNDrWKxQvx2BHChu0Re0UD03y9FdC7XyJN9Zc44xiayw8hy4JxepFTjX
yU0FQb/hopfQZ6sXnsBIBd4JnDlKgQ6D901qSr0l6/mXYHy0uxsx6fDNikLMvFxI
ccQ6dyenlMd0FsM9cm1LXEhGMBJKvTvSzhVgRN3FdesRu1k7CN4BoUtljnEjRsyU
PK7GPnlFJ19p2mKSS7EX9f1KmtzIGVv2gOlAacGrbwKOD1BoKLjiWSVrQsV2Hy/K
l/9A7bEhHoxrHpFSIWwQxeyiUQnyzw==
=BK9a
-----END PGP SIGNATURE-----

--Sig_/NnCFe0smkMd93ta7/3oa+hz--
