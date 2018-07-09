Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6875C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8119F2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IE5z2KSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8119F2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752914AbeGIEPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:15:15 -0400
Received: from ozlabs.org ([203.11.71.1]:57577 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751159AbeGIEPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:15:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41PBnW1pPwz9s19;
        Mon,  9 Jul 2018 14:15:11 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531109712;
        bh=EZzSrMdJgc0+3WuGep2TWuoPkHbKmjFMD5+3kR3RkOY=;
        h=Date:From:To:Cc:Subject:From;
        b=IE5z2KStrZlkVEiY1DBz2T2nBTpcTTOjOA+yowRvUsRrtgqi2JsmuvknPxo+qSiHT
         DXQ6/yjWJECeclYQg1lPSp0DP/AU3A0aNqf1+tkRrQLqE+7sH+shY8QUCd6W0Mz+5N
         jiSRLY1oqwNDHBj16VEQudMKpuSYZcITD9QPFmND7ts4dkGagg1JRVX46KIF5xcrTC
         cjDH3hmWT7nZ/eGRgbdyViBwEWW4VReHkkKjv1uB3Tb0q78Sm/HMxL5FW7T6PQzaBJ
         pM1bybTSkN09FmLl6v0l3yTBwuco//+82oJOb/K1scZ15uo9rKP+1rCJdg6+wy4/RE
         7I5ILqaM4CUtA==
Date:   Mon, 9 Jul 2018 14:15:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: linux-next: manual merge of the staging tree with the crypto tree
Message-ID: <20180709141510.19e1a851@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/a5JKtwXSHbpLfl+t1FN4Fvh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/a5JKtwXSHbpLfl+t1FN4Fvh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Today's linux-next merge of the staging tree got a conflict in:

  drivers/staging/skein/skein_generic.c

between commit:

  e50944e219f9 ("crypto: shash - remove useless setting of type flags")

from the crypto tree and commit:

  ee55fe552fcd ("staging/skein: Remove Skein and Threefish code")

from the staging tree.

I fixed it up (I removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/a5JKtwXSHbpLfl+t1FN4Fvh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltC4U4ACgkQAVBC80lX
0GyBIAf9EfZfypf3LmgP+OhGy+jbSkJ2kAiLOC2/x7hkoFIHmH8o0b1GNIc5lT/5
Uc26sD5jwq92sSQgloIPuOOAsl+z0enRaGKu2M30yAc+YnBAJCJfS33N8VAGS8IU
6UCasRaA9+2OFDT1iowbgdZ0tTOCY/V3OPzc71g3PdA5zO9/CX/IRbNWBUEBB5ZK
RdFLxRgRI+3JTeg+RMD9Ssp+FaCkjxmeG2Yqlmil/OVzV+TqMvZaO5RQk1WxLk2F
Vy/m6wb11uFF20HwPcMf00wXDiU3iYcClcD4pfzpfp7Ud4yig4iHIRzWzeHrw//h
68rWRyYudjCtgWpPcCLx8mRs04tpQw==
=PbV7
-----END PGP SIGNATURE-----

--Sig_/a5JKtwXSHbpLfl+t1FN4Fvh--
