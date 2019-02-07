Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A9FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4B52084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Pp5kwhi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfBGErv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 23:47:51 -0500
Received: from ozlabs.org ([203.11.71.1]:52857 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbfBGEru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 23:47:50 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43w5Qr0NMRz9s9G;
        Thu,  7 Feb 2019 15:47:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549514868;
        bh=RPU3prFxlrArfYSoGKL+tEERo5oeOEfrXgN+d0bmOLk=;
        h=Date:From:To:Cc:Subject:From;
        b=Pp5kwhi9MkPk7vWYo+c9LheTxZlZZFyeNZ8OD4f39DFbaPkjEXTXEJTv2SZq91dT7
         DbcOEBnbAJ5a5hVlCOrsYO2SzzKKW2n2nMAN2DhE9xHt/1blKtJqTk1HmSdoSkE8v2
         YB6sIOTh+S46EQJ6UbLLB0dctGZ3uXTyhMnyDFAE6yJ9EFMGRNE8zhPqtiamZ9vZpy
         4u3IJCLR68RkIxq3SEax+BVV0+ez+SDw2srG+SMwN7uVbEZpGQkMYp4dIVzJ0257h0
         VTqrAMvdeaRTT87wigtxykeN2qXUdd2lIOfXjnZUcqiHy0NiIVuUmPzqOuLNjQfJLx
         wkaquWLuc1zZw==
Date:   Thu, 7 Feb 2019 15:47:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the scsi-mkp tree with the fixes tree
Message-ID: <20190207154747.03209c75@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tL67iu3TIvWPDkzPspvZxii"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tL67iu3TIvWPDkzPspvZxii
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi-mkp tree got a conflict in:

  drivers/scsi/osd/osd_initiator.c

between commit:

  24648908acac ("scsi: osd: osd_initiator: mark expected switch fall-throug=
hs")

from the fixes tree and commit:

  19fcae3d4f2d ("scsi: remove the SCSI OSD library")

from the scsi-mkp tree.

I fixed it up (the latter removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/tL67iu3TIvWPDkzPspvZxii
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxbuHMACgkQAVBC80lX
0GygAQf/aD4jQN/1bUKPbM1BZraKjY75NNx/raTJSCvqLOH0bBObqLthBmNi5R6p
RAcS7cdI+HxkkkPZEqR3NxQc0OhhGtX9AJKa8IHVj0jIIxpst9J0mxmtoQ3IZdzl
kJE24Il/t6Qd686TQMGIC4wUl/rlxTUIUrgQHVl0KJ9GXJEjFCBVfbnnWlBDz8zG
8E9ztw/gxX2WW93vEiFBeL3tGHmbpBrsWvM6E8WZm7mxh6NKJ2aFnq6EUyVQpbqu
l3ngvrGN9JDNyJsZtFixMhDrCurPPsKjS1Ic85G4DN46TUAAX28embx+/Qf3xHhT
beg4s5O5q5CW+y1bgciphWlYEilm3w==
=quQL
-----END PGP SIGNATURE-----

--Sig_/tL67iu3TIvWPDkzPspvZxii--
