Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2502C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C48320892
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PrTUeyWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C48320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbeLCAX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 19:23:59 -0500
Received: from ozlabs.org ([203.11.71.1]:43609 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbeLCAX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 19:23:59 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 437Qhn1Kz4z9s8J;
        Mon,  3 Dec 2018 11:23:52 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543796633;
        bh=E8C0FgJwzfDVqZTCy7G1+wx8aAb6o9c5/UboPF1ck+o=;
        h=Date:From:To:Cc:Subject:From;
        b=PrTUeyWHBA8E7G99QRq5WPfjcmrOQSmVXOCuN366Sb/JCB1eLvv8XBoH3ZIZ+TduO
         p3mv2YldUrT7UZbhqtk3qIZrK0bC+99e4+xO/nYhfx1+AENWiUj9DvV/Tb/XJMUDqX
         Ujhc0Nhmu+ZZl0NsRcJ7gtkpc5JRLBRd0aAoXJoFwS5X0rFPM/5PQ1ckzekkQZnhWD
         QZXQnEExbLaR55IwdolsqnatdYrzuK7NfrYl3LBJ06EVE2KJe+7MbzXe+UbcwTZG/A
         sIdTmFHGvLU3qOic2xEaXl+Pohly5pi6TTrn6/dYZTSKX2KNnsacbgZcc4tTHfiVo1
         3U3fXV5mVg48g==
Date:   Mon, 3 Dec 2018 11:23:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@google.com>
Subject: linux-next: manual merge of the vfs tree with the fscrypt tree
Message-ID: <20181203112345.6c9a786a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Q._oDp0b403T/oqY4d.1U0j"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Q._oDp0b403T/oqY4d.1U0j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  include/linux/fs.h

between commit:

  a2bd7d2fc32c ("fs-verity: add setup code, UAPI, and Kconfig")

from the fscrypt tree and commit:

  37744f3d21f8 ("vfs: Implement a filesystem superblock creation/configurat=
ion context")
  d5ab33dfd7bc ("vfs: syscall: Add fsinfo() to query filesystem information=
")

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

diff --cc include/linux/fs.h
index d7bf524a0517,aae0aec1adb4..000000000000
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@@ -62,8 -61,10 +62,12 @@@ struct workqueue_struct
  struct iov_iter;
  struct fscrypt_info;
  struct fscrypt_operations;
 +struct fsverity_info;
 +struct fsverity_operations;
+ struct fs_context;
+ struct fs_parameter_description;
+ struct fsinfo_kparams;
+ enum fsinfo_attribute;
 =20
  extern void __init inode_init(void);
  extern void __init inode_init_early(void);

--Sig_/Q._oDp0b403T/oqY4d.1U0j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwEd5EACgkQAVBC80lX
0GzUYQf+JTTe3SpIyGyM3DJH59W/CzMXmFtMyUiTsBwmu8aeS/94BxXX7yFbHjNu
g41M2VoWm0MrNCmrai7uVo5LEp07xUCf6OwizLvdU8Lwdtu/208VqvRARgsJFCRD
JzOvp80BOqIZbGzr43jCZzq/BdlX3kPcVGm/VFjXvxA2PRyKbGSSyyfZAT9R2fAk
NL4l6R+/qvKHbgFvVMRJNOlhCe/zAYMYJFj2GS8O2hAW3RVFTtB4KEN47ZnUwVjX
v57v2nf9mNwCDYdCcAn+eVZfS0wjgOsICgeUoRkIBiymz5hi0wq8wzsqRovvp9E6
ch9bUs8ajz7bqH273qk+vPA2CLrTog==
=PX9N
-----END PGP SIGNATURE-----

--Sig_/Q._oDp0b403T/oqY4d.1U0j--
