Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2818DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BE921473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kdh/lVY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbeLQXgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 18:36:54 -0500
Received: from ozlabs.org ([203.11.71.1]:60603 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbeLQXgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 18:36:54 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Jcxb3RKLz9s2P;
        Tue, 18 Dec 2018 10:36:51 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545089811;
        bh=9D0kxCmxEPsOtphjPXkZHbypTpjaAJv+tIS/zx49t2k=;
        h=Date:From:To:Cc:Subject:From;
        b=kdh/lVY4cVtb2wOHCd4Dn5IVnz6xrrgF7ZqXrEsapqu4RPEa2F1uR/S+4UWFwjNAS
         4MrHfSpO5sV3/MLemEUQg/WwVPPT+xwbs76JQ+1WoBRofKJLuBzc5xAcMm3OrAnxLU
         uHpBxOpXOfDX/Nuv9A2F6e6EpFmvMgnmIc52bt62Wcz+1IjUOYdXADak1GLyCa+SHL
         yZ6aeU4uxz6QsUqF2UzYgKqJO5mF4Jghwfc0rj9cA+VEr5P/AK3YpMbtIwmmuQpK7/
         YdonFY2xVRmctaJ/+9ePvdH7/9WpNDNdzw8NQc45aZKeJT7f8k2rlNotdwjKUEb7km
         waQtqrDGSsG6g==
Date:   Tue, 18 Dec 2018 10:36:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: manual merge of the vfs tree with the fscrypt tree
Message-ID: <20181218103650.6b1d79be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GtBjbh0pu_fBDE94CCWbl=2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GtBjbh0pu_fBDE94CCWbl=2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  include/linux/fs.h

between commit:

  a2bd7d2fc32c ("fs-verity: add setup code, UAPI, and Kconfig")

from the fscrypt tree and commit:

  013c7af575e5 ("vfs: Implement a filesystem superblock creation/configurat=
ion context")

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
index b2f9913eee10,169ca472d16a..000000000000
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@@ -62,8 -61,8 +62,10 @@@ struct workqueue_struct
  struct iov_iter;
  struct fscrypt_info;
  struct fscrypt_operations;
 +struct fsverity_info;
 +struct fsverity_operations;
+ struct fs_context;
+ struct fs_parameter_description;
 =20
  extern void __init inode_init(void);
  extern void __init inode_init_early(void);

--Sig_/GtBjbh0pu_fBDE94CCWbl=2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwYMxIACgkQAVBC80lX
0Gw0+Af9HSMH5V6xVdbu9aJ24NXfK9WxHeT3jPT5397i3ia2QbPkIfNfmmSq4dTV
RmAkbv5llYsXGTWA4VBts0qcG56aXGwarI4sQ87w/eBcHGYjmOcX3cWTAfeqg39W
ZqRG0kC2J3SZNt7jGROiuH5Iq7xsCkuAeng8h7dyRr89FnDp76tOFijViAQSy4PA
NKdbXR3+k1aCQywF/f4Nu9xBfD+UPcA07tgvcrIXEEubIfRgsGOvRMvBcfIEl59N
c4LN9okNAGcCTIRCrHpUw4R22PObxcymej5RcZfOupy3VzcvdtlgvJx44b3eAVXC
yQ52Ug4TrfdPEk4kprAbRXneWUSnFg==
=zeBu
-----END PGP SIGNATURE-----

--Sig_/GtBjbh0pu_fBDE94CCWbl=2--
