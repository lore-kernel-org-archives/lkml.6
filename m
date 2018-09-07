Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB48DC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664372083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jeWQcoFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664372083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbeIGHoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 03:44:18 -0400
Received: from ozlabs.org ([203.11.71.1]:35273 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbeIGHoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 03:44:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4262PT5dHGz9s55;
        Fri,  7 Sep 2018 13:05:33 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536289538;
        bh=QR3BAfqkp1HjnXKmy3uOBttZdgduvGSE/fDoyheLTmI=;
        h=Date:From:To:Cc:Subject:From;
        b=jeWQcoFrowvbViNQjj99R+O2k3EgUmcv0czv7OKY4Q5s140yQ6DIMcUbpMf2VTtzU
         nLQhu71t7P4Tw9tffCLyDPAPGvmRcDVSW4TbPbc88jB/iJg+ndSVUupto64jcLlgpX
         znImCz/BaxTUHBHBZAl6/fpyMxFAhqUgyMgq7FGjhtc0WYWm4oNEDS4SBjMCzxSCqK
         1+dETW1COSxrQE2vntb0BAv+c88adNEo3YoTcDCOib7Sn/9TGbKcjpKQblpRYH8+ST
         jIPjxpKcLEdJomKzSG/Z3os5NLDygVn//xRyziSnyZ4EePX4VDB8ZR3/g6MGSHg6WK
         zIIMGvRxbpK4g==
Date:   Fri, 7 Sep 2018 13:05:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: linux-next: manual merge of the kspp tree with the tip tree
Message-ID: <20180907130533.03ba3119@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ChvU3MaG=OK88FENH1qaAfo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ChvU3MaG=OK88FENH1qaAfo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kees,

Today's linux-next merge of the kspp tree got a conflict in:

  drivers/misc/lkdtm/core.c

between commit:

  bef459026b16 ("lkdtm: Test copy_to_user() on bad kernel pointer under KER=
NEL_DS")

from the tip tree and commit:

  f90d1e0c7804 ("lkdtm: Add a test for STACKLEAK")

from the kspp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/misc/lkdtm/core.c
index 5a755590d3dc,aca26d81e9b8..000000000000
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@@ -183,7 -183,7 +183,8 @@@ static const struct crashtype crashtype
  	CRASHTYPE(USERCOPY_STACK_FRAME_FROM),
  	CRASHTYPE(USERCOPY_STACK_BEYOND),
  	CRASHTYPE(USERCOPY_KERNEL),
 +	CRASHTYPE(USERCOPY_KERNEL_DS),
+ 	CRASHTYPE(STACKLEAK_ERASING),
  };
 =20
 =20

--Sig_/ChvU3MaG=OK88FENH1qaAfo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluR6v0ACgkQAVBC80lX
0GwklAf/eZ1gx5K7IRC8oX8WYl4rP1kN6Y+2thbamwW0mfuQMzwlPlYrU6dgSFbG
jXQdqt2NhZ3q9h/jnpQhJD0HbPm8rQa18Ir298iqfwN8qP+K5H/Yoj7g0gQmYnVM
KKTu23JDZMMrpSKAl2RzF92o0cHoSkPhz0EzZksmuwqXPkvX0VuW8s0VBOi5eS3W
xwXy8my1g245KYcun5pCDI/uqlKXKYnwjMRYepEkML0jsgw3x+GwslDNkuEE9kZz
g0S4KL0nKmWBWdPFKMqohAv50YieFS+IcI9P5gA7CFHBcm5SBz/rFQDoWW6P+nss
SA85stTSGWnljxSgFR3ylPaDw59r8g==
=dNGN
-----END PGP SIGNATURE-----

--Sig_/ChvU3MaG=OK88FENH1qaAfo--
