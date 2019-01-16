Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC044C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F2A20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HMmkIXKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbfAPCz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:55:58 -0500
Received: from ozlabs.org ([203.11.71.1]:60013 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfAPCz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:55:58 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43fWzv2Pdvz9sCX;
        Wed, 16 Jan 2019 13:55:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547607355;
        bh=ZtzAv9owyVL9WJdjj7WSjXmlzCkRbWlaLnAYZ/AnxYs=;
        h=Date:From:To:Cc:Subject:From;
        b=HMmkIXKa1BoKuBT6c1h91hpnS7x2L7zHB4GJsnTeddENvxXACKS2lCcIkrOnwClNZ
         V1q9j0zl6rk4rzPJjcB9fVbyvBk+je1jzKkCZivW4r9FjMR6TlGgBC+9qWf5b4b+iN
         4nimj2yMnxcnemPi5E/H3zgZwsbN/oQ4R5jbMT68haqOGzIou7ywe5f7eLvmaBVVuh
         X/vJfNXjuDS0tm6vkW9DsmMxkLzVsY39JWpXdLaQAlia38R4xoEDZHn2U4D5ecS/vS
         M1MXS2D+T0vuO6PgT5blOxMzOWaIa13cRxjo5l5yylDJDckizxsdJKLG8zOFdfrNml
         bIEhAbWOXmLng==
Date:   Wed, 16 Jan 2019 13:55:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Omar Sandoval <osandov@fb.com>,
        Eric Biggers <ebiggers@google.com>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20190116135554.34af6248@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5l9rOBvNehAdBfDnosL6lYb"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5l9rOBvNehAdBfDnosL6lYb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (x86_64
allmodconfig) failed like this:

fs/verity/verify.c: In function 'fsverity_verify_bio':
fs/verity/verify.c:272:38: error: macro "bio_for_each_segment_all" requires=
 4 arguments, but only 3 given
   bio_for_each_segment_all(bv, bio, i)
                                      ^
fs/verity/verify.c:272:3: error: unknown type name 'bio_for_each_segment_al=
l'
   bio_for_each_segment_all(bv, bio, i)
   ^~~~~~~~~~~~~~~~~~~~~~~~
fs/verity/verify.c:273:19: error: expected ')' before '->' token
    SetPageError(bv->bv_page);
                   ^~
                   )
fs/verity/verify.c:277:37: error: macro "bio_for_each_segment_all" requires=
 4 arguments, but only 3 given
  bio_for_each_segment_all(bv, bio, i) {
                                     ^
fs/verity/verify.c:277:2: error: 'bio_for_each_segment_all' undeclared (fir=
st use in this function); did you mean 'bio_first_page_all'?
  bio_for_each_segment_all(bv, bio, i) {
  ^~~~~~~~~~~~~~~~~~~~~~~~
  bio_first_page_all
fs/verity/verify.c:277:2: note: each undeclared identifier is reported only=
 once for each function it appears in
fs/verity/verify.c:277:26: error: expected ';' before '{' token
  bio_for_each_segment_all(bv, bio, i) {
                          ^            ~
                          ;

Caused by commit

  eb754eb2a953 ("block: allow bio_for_each_segment_all() to iterate over mu=
lti-page bvec")

interacting with commit

  281bf3cdf27a ("fs-verity: add data verification hooks for ->readpages()")

I have applied the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 16 Jan 2019 13:53:07 +1100
Subject: [PATCH] fs-verity: fix up for bio_for_each_segment_all() API change

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/verity/verify.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index e308f22475e8..dbd388ef32e1 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -266,15 +266,16 @@ void fsverity_verify_bio(struct bio *bio)
 	struct ahash_request *req;
 	struct bio_vec *bv;
 	int i;
+	struct bvec_iter_all iter_all;
=20
 	req =3D ahash_request_alloc(vi->hash_alg->tfm, GFP_KERNEL);
 	if (unlikely(!req)) {
-		bio_for_each_segment_all(bv, bio, i)
+		bio_for_each_segment_all(bv, bio, i, iter_all)
 			SetPageError(bv->bv_page);
 		return;
 	}
=20
-	bio_for_each_segment_all(bv, bio, i) {
+	bio_for_each_segment_all(bv, bio, i, iter_all) {
 		struct page *page =3D bv->bv_page;
=20
 		if (!PageError(page) && !verify_page(inode, vi, req, page))
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/5l9rOBvNehAdBfDnosL6lYb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw+nToACgkQAVBC80lX
0GzeBgf/bcz25oCIjCLN3OoVy3PZIKxFbzN5ocGv09AquEq4bkm79eqB/Hu647z6
grLWVozgu2SAjVLuwvuhIfZCTvYwLRk1mMcJb2jewhvOVqLDmDxtN/58sYRdjEoa
z1kQLDSHyoG9fSBCzUO3V2wLvg3cXqA8mY3/KgWh8/X698IqHfB5Tx3R6sPJG3Cq
EQTER5RC9+bpnbuT5YsnPrk/xGX7gkLo6hsmzaEVaAaA6bO0xyyRbdSg1KfIO+2m
3NOV2vPerYXnug7+5fBujsswzLo7jCiWtcKdGmG1GaSiPXzBgxxZNlUKqBJZwR4x
euA8NwXEUCfpI7elfLihZSVTjnbhIA==
=EzU2
-----END PGP SIGNATURE-----

--Sig_/5l9rOBvNehAdBfDnosL6lYb--
