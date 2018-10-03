Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C45C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790F621477
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uvgLNLYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790F621477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeJCPET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:04:19 -0400
Received: from ozlabs.org ([203.11.71.1]:46643 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbeJCPET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 11:04:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Q84m3WvSz9sBh;
        Wed,  3 Oct 2018 18:16:56 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538554617;
        bh=Q/iMz4BH2INBK0dmZUFMo3l1xkwsjEJxPEfESFMb5mA=;
        h=Date:From:To:Cc:Subject:From;
        b=uvgLNLYRwd9kXDCThfr7ecfzJplm8aECkCD6FSqJOmhoDdDEqBiwUraSwplAgnbfv
         00gREYX88r4EH9N4latSWo7Cljl+BatZaJoAid9Cn5hAC6e7l2yD58tFid84UQx4DS
         fYiS7pfkIMDwgXQ4F4J9Hb2zz3baUVKbYmxNsLmYi0MV/oXoWVXUujuog7vaXFFtxK
         RHweH8Ib3m+l1y8enOLAiF/TKkGvLS8yjdgIacMYKhVUtU5W1cEmIul4MHVmO3ARxb
         +AnjXJlIHLiREMQPHqf339hlm0K22DWtR+cfD//zqIGUcUyJTSF4d+qk5WpwAyG90W
         /z3bhH4IYwSoQ==
Date:   Wed, 3 Oct 2018 18:16:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: linux-next: manual merge of the xarray tree with the f2fs tree
Message-ID: <20181003181638.54613336@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OH7K2l5jMLWmlJ/r.Kys7JU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OH7K2l5jMLWmlJ/r.Kys7JU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the xarray tree got a conflict in:

  fs/f2fs/data.c

between commit:

  bab475c5414e ("Revert: "f2fs: check last page index in cached bio to deci=
de submission"")

from the f2fs tree and commit:

  dfe989c12c50 ("pagevec: Use xa_mark_t")

from the xarray tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/f2fs/data.c
index 9ef6f1f01eda,6962491172a5..000000000000
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@@ -2029,10 -2000,10 +2029,10 @@@ static int f2fs_write_cache_pages(struc
  	pgoff_t index;
  	pgoff_t end;		/* Inclusive */
  	pgoff_t done_index;
 -	pgoff_t last_idx =3D ULONG_MAX;
  	int cycled;
  	int range_whole =3D 0;
- 	int tag;
+ 	xa_mark_t tag;
 +	int nwritten =3D 0;
 =20
  	pagevec_init(&pvec);
 =20

--Sig_/OH7K2l5jMLWmlJ/r.Kys7JU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu0evIACgkQAVBC80lX
0GzCPggAjvc2pN9Bj45/oKQWJhtX9Ox/fN33t8gmsNHtVP+fH4BocR+pxvQ3FF11
qr5oHK/MRjPajb1D5fkJ1ZN/mVdN1GFQe+/rQodiUkxW5Elv88iozHxF9lTNpewk
0dwF7eumAhAGuUQJduYcHxR9zFV6ygFZXoo/8mSzgQb/qwPu7fbkcZrmYSwW4AAP
rkpE9atgAeFnq4O0tyk3lbeczLOwWtRgt14ngNO8m3smGK/Tb76/XdyMrcWavJ1R
y80HOzmTvhddcjAWISkHUXu7QpoebJ9XNeb9m+OI2pmGgBVlMgA50ntEnlLhXoZa
scYIXhDI9c6gf0U7TeRehPUNxZbjmA==
=dkCD
-----END PGP SIGNATURE-----

--Sig_/OH7K2l5jMLWmlJ/r.Kys7JU--
