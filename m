Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5897FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC1F21738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="icCWXpOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbfBTCP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:15:59 -0500
Received: from ozlabs.org ([203.11.71.1]:56287 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfBTCP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:15:59 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4441Rc66D2z9s3l;
        Wed, 20 Feb 2019 13:15:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550628956;
        bh=6Ga/YYrGmVU7AkyOcm/4lKRUXuY09FbIYZ6nRp0r9MM=;
        h=Date:From:To:Cc:Subject:From;
        b=icCWXpOW/8HdhM93QGUB8D+c8M67EZk3Ze5BZvJsgT+4+Wf93E9wW9EmaAju7E4UF
         KhIVouzn0VTkNMndkiWRRfk4oKKpYLwUb+9HUAOQFgji1U8qlCqN+2AI/GgWVnX7NY
         0oW6mJnoBCZ/JGgF/7SdqM9qHZOjOLhpNwZaL1mkx/7cw9RfokJEvKzwXflNgt2lyo
         JI4YryaekwoKDUJeFIVbgzUHAkhEdT+7mRo5GeWbdORx/d8pAnXS/F8FsD30bkjnw/
         0iBV+/lXVp+3+UPbYxVGqqQ5nDw/2DCjCcyLBCdeJ1hYamOTTCnY9VgLOHi0DncT4J
         885dEN7N1XiiA==
Date:   Wed, 20 Feb 2019 13:15:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the device-mapper tree
Message-ID: <20190220131555.15317a39@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PVmk/xY08i5Nb.lRcC+fPGh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PVmk/xY08i5Nb.lRcC+fPGh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the device-mapper tree, today's linux-next build
(powerpc_ppc64_defconfig) produced this warning:

In file included from include/linux/blkdev.h:21,
                 from include/linux/blk-mq.h:5,
                 from drivers/md/dm-core.h:14,
                 from drivers/md/dm.c:8:
drivers/md/dm.c: In function 'dec_pending':
include/linux/bio.h:626:15: warning: 'bio' may be used uninitialized in thi=
s function [-Wmaybe-uninitialized]
  bio->bi_next =3D bl->head;
  ~~~~~~~~~~~~~^~~~~~~~~~
drivers/md/dm.c:930:14: note: 'bio' was declared here
  struct bio *bio;
              ^~~

Introduced by commit

  58c66b86cfe7 ("dm: improve noclone_endio() to support multipath target")

--=20
Cheers,
Stephen Rothwell

--Sig_/PVmk/xY08i5Nb.lRcC+fPGh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxsuFsACgkQAVBC80lX
0GwpLQgAiHux41yYTJ7TJsVOCUAyNKhkgVpAJJ7PmKZHgqBSx9ev+FfRCeynGzNE
wGAzX5wuZUprPB1+evEZK5u6LWlW+vn+OnnwpAQznJpIsD03WkuSFODq+KTfnoVq
T+tyZsL2aZloBC0CV0wWBj/ZJ40EO5O/uuauPWLobuw1ot+wMHI+Cid1RuE4V0hU
gpreP5sB8qbKnpAqq55pQpfKN6g+qQIEqUTd9tFesqPeiWSMRKs1vBKdUewQir8j
B12qXrE7+AhmNh8cHzxQwNDgXHmgSj1enWgVYEKQWD/i1LBz5c71o+kGoBTb/h6s
6JVeFtBaoMop602l/nNm/ovd7Nx/9w==
=+D6c
-----END PGP SIGNATURE-----

--Sig_/PVmk/xY08i5Nb.lRcC+fPGh--
