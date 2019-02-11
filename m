Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A533EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7113220855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XFlV56c9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfBKFRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 00:17:36 -0500
Received: from ozlabs.org ([203.11.71.1]:44181 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfBKFRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 00:17:36 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43yYvJ5xKbz9sBZ;
        Mon, 11 Feb 2019 16:17:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549862254;
        bh=ago03U+E9qpIObAtfb7zAVnyB743HvDTgFvnbdBhQ+4=;
        h=Date:From:To:Cc:Subject:From;
        b=XFlV56c9lY/Ft6oZ+r9L1g6a7VYELev9W3sAoJhFpyJI7Nt83afOSVINaqP/QjRAv
         tB9dYkKRsPBakV033IO6vzuoRoEt01FNpUb86pQOYVysrQHD6Xvxzljnk3COgfJ+37
         1lhZJGu/ejsayqalyCoviRO6mNpmdv9/soOtd7JZFrEFaHCIaE75wRAE2bTWeyIuW3
         Ldyn4vVD3MNe0fvzxVPDlkjXHo/tsLb+y4iccyvYYYHBf0ZKf9ut4choK+xhAMCHC5
         5ja04RK1Ep+S2O4LgsCgYNPhw76xBVnHTLco7Ffq7pCs/BI9iXjK/62fIv8iniiAvM
         unBRsPuMXHY8g==
Date:   Mon, 11 Feb 2019 16:17:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJv?= =?UTF-8?B?c8WCYXc=?= 
        <mirq-linux@rere.qmqm.pl>
Subject: linux-next: manual merge of the rtc tree with the clk tree
Message-ID: <20190211161731.56897159@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ldsDebFNaTF3D0e3jIOOtKD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ldsDebFNaTF3D0e3jIOOtKD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rtc tree got a conflict in:

  drivers/clk/at91/sama5d2.c

between commit:

  77977b800451 ("clk: at91: enable AUDIOPLL as source for PCKx on SAMA5D2")

from the clk tree and commit:

  34d2ff2a6019 ("clk: at91: fix masterck name")

from the rtc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/clk/at91/sama5d2.c
index ade063622531,cd0ef7274fdb..000000000000
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@@ -240,8 -240,7 +240,8 @@@ static void __init sama5d2_pmc_setup(st
  	parent_names[1] =3D "mainck";
  	parent_names[2] =3D "plladivck";
  	parent_names[3] =3D "utmick";
- 	parent_names[4] =3D "mck";
+ 	parent_names[4] =3D "masterck";
 +	parent_names[5] =3D "audiopll_pmcck";
  	for (i =3D 0; i < 3; i++) {
  		char name[6];
 =20

--Sig_/ldsDebFNaTF3D0e3jIOOtKD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxhBWsACgkQAVBC80lX
0GyRCwf/YOZwRJZK39xyxAlkUtNWIr27TxWvgXUKN4UML9nh2KZmD1qTd+1voWul
ELbXviG2WY0MJxBc2Cgnn8lAvxP0JZpiATTNQayi2PKO5Qn6GoHyw+GJPVlVPNQi
+292lhcUUnigkig8zksUAJaaWdD18icnFtsAOQSm2hXNplkaVnvnMZdIDuds8hOR
aiUuRyI9GJUMOfBdyT/AU0Ou8bc49OA0bUAehr1lIS0WAQWpGiCqQm7iz/jlAngJ
lUunnWtBREjzbSuhZjuPVutGTc+t5d+eKjnjSPIIrjshDjmqWvqYIgGXYzxWQuIn
q7reBZLapWKABSUF+X+cmFq+NxL7cg==
=S4x3
-----END PGP SIGNATURE-----

--Sig_/ldsDebFNaTF3D0e3jIOOtKD--
