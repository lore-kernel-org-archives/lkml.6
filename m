Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6F5B2C004E4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0EC208D5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Nq4hKpOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0EC208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935921AbeFNBnk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 21:43:40 -0400
Received: from ozlabs.org ([203.11.71.1]:53657 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754498AbeFNBni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 21:43:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 415mc84Lg5z9ryk;
        Thu, 14 Jun 2018 11:43:36 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1528940617;
        bh=JpWkxlPolpnWCh8z1K3GNTX/Vwu1Ft+Kx/Hoo1jtuA4=;
        h=Date:From:To:Cc:Subject:From;
        b=Nq4hKpOoVUrSJGk7rd6Pjn8DKueVJjv5+NXifkciTrnLmag5IBYj6ktwlDKcuOQVf
         Xkuvvipig9CiqjpYzLrZeRuQQFboo+RJKkEpEDXTUDyI4xtcgFpyOTIvqjbv3p39Nz
         Ge+0LEetFf6ZTVz93CJVi20saEbzgMoOLvRL+PYGDJL4NNqQepbEkRmil+xDVkW06M
         CGIB2b06d5M331JFJoyt0s5q2As2TrRUDKHJtiFkM1hhHbf537eOJ/a9oy3nY+eg9l
         RHJbQ3Vo8CvBEvSMPt4veZceVMQVt9OKARirCxKDc4f9iaWpkjYvTT+OWw0nXaeHr4
         qWMgUa8Dzh9cg==
Date:   Thu, 14 Jun 2018 11:43:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Guozhonghua <guozhonghua@h3c.com>
Subject: linux-next: manual merge of the akpm-current tree with Linus' tree
Message-ID: <20180614114335.3a38727c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3aIayOpgIvcPGlW9ro7MTL="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3aIayOpgIvcPGlW9ro7MTL=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Today's linux-next merge of the akpm-current tree got a conflict in:

  fs/ocfs2/journal.c

between commit:

  6396bb221514 ("treewide: kzalloc() -> kcalloc()")

from Linus' tree and commits:

  18dc5b7810ff ("ocfs2: without quota support, avoid calling quota recovery=
")
  aa935a9c155b ("ocfs2-without-quota-support-try-to-avoid-calling-quota-rec=
overy-checkpatch-fixes")

from the akpm-current tree.

I fixed it up (the latter akpm-current commit also did the kzalloc to
kcalloc conversion, so I just used that version) and can carry the fix
as necessary. This is now fixed as far as linux-next is concerned, but
any non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/3aIayOpgIvcPGlW9ro7MTL=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlshyEcACgkQAVBC80lX
0GzkdAf9FER5V08G/x4Xfpd7JySbEfe29qm16FzW4aDVTrMSIVfAC2C1pYIYppc0
YdRauUhGEn3DTXO2gpMHLTfpA5/tutMzWVJFrlgJ3vNp31y8ogczc27NOmAdarFg
EKMSyYBPg2aN4irGVPg82H08raDWy/uXsJG9eoV8W0ohlkQK7L8p45leAfaIbdgx
orCGDl0rdJZ5Q1X3XMMiaHzrIbutBGAADaqTdKQaJ7o2mBuXsN4f7CxG2TyAQQti
70MY3PpPUyYVjK9KqdebfY+oLCI43P1X5XAzxQAqi2Rxbu8A38fktcxOov2n8sto
vx5Br6u1yeRkVx9X3mcrmQjUhc0DGQ==
=CeO3
-----END PGP SIGNATURE-----

--Sig_/3aIayOpgIvcPGlW9ro7MTL=--
