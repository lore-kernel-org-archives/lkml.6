Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5j2VCxX6GVsjFgAAmS7hNA
	; Fri, 08 Jun 2018 03:37:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1605D607DC; Fri,  8 Jun 2018 03:37:57 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HaAGfLPN"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A031E602FC;
	Fri,  8 Jun 2018 03:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A031E602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbeFHDhx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 23:37:53 -0400
Received: from ozlabs.org ([203.11.71.1]:40345 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752329AbeFHDhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 23:37:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4127Qj4lpdz9s3q;
        Fri,  8 Jun 2018 13:37:48 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1528429070;
        bh=YE7eK0oWDOy/PGqiodXcLmpyS4riGUtF6efzG07j2Ig=;
        h=Date:From:To:Cc:Subject:From;
        b=HaAGfLPNLlh3z1nlGYLaLbOlPkChNzq8lcfsFjYAmHbyW2Fl0/DG2IvCV0OiZI+tH
         rG74FRh/Rzz9MqIe+JQ2t+RCmsiIKsBmRUpEgbWjDZCWr8b4afQcX08cuuZAQJ01DP
         HUxELml3v4zs6ABI0F7xV1Gmp83PDdxt8NyahJ/gBDOwS2yF2kd7/J9ITb8ix53Qdw
         mjkE4rEJYCcLLSoIvzb2R1TwDACB4XMEmUjYk2g7D1gqixUElW9ZoaHDkYqkMFLbOC
         ggiZVdjgS7R+uLQdVEj1JHClmJV6hVqDjZNJZlZRBMarA4J0d2a2rHPY1SNqAej2pJ
         ZIzZF+XtVeXzQ==
Date: Fri, 8 Jun 2018 13:37:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Tobin C. Harding" <me@tobin.cc>
Subject: linux-next: build warning after merge of the random tree
Message-ID: <20180608133748.58a272d5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CQuTvknR=BFhx8rb09qkq+T"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CQuTvknR=BFhx8rb09qkq+T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Theodore,

After merging the random tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

lib/vsprintf.c:1668:13: warning: 'have_filled_random_ptr_key' defined but n=
ot used [-Wunused-variable]
 static bool have_filled_random_ptr_key __read_mostly;
             ^~~~~~~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  bfe80ed3d7c7 ("vsprintf: add command line option debug_boot_weak_hash")

--=20
Cheers,
Stephen Rothwell

--Sig_/CQuTvknR=BFhx8rb09qkq+T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsZ+gwACgkQAVBC80lX
0Gwn4QgApiEiqB/lA1gsaZfeVzvuqOU4jf2K501KHhT1/84mcCxPEzoz4QvXng6y
ps0JrT1dI2qriqKePzAnpc6dr5WrBay45qkJCUYz8TT4WzoTKaJAySP1G4eP+ItB
+XcL2iWho9dmLCPUdRZqp2qL5HJAV3DCyuH3jxJmH7MVFmYM6Vx0gD3yxZLQEu5L
ULLmM9Zsy6TaoDdcoarajyDJeeOfgo0NUPBdmpH9p1QKEpVuQqMxdKpc0NW5WD5G
8dgU2xernEpGKZejOmQJ60nhIFG2LKPzKBGx74D1RcD3pwZ21NNrj1mW/K0U/nAE
TEP/TPNZjH0lvX1JVdw3PhrNnZe+mQ==
=G6po
-----END PGP SIGNATURE-----

--Sig_/CQuTvknR=BFhx8rb09qkq+T--
