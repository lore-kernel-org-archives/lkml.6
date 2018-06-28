Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90B1C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C4F279A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Xi/UD2gU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C4F279A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030227AbeF1WOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:14:24 -0400
Received: from ozlabs.org ([203.11.71.1]:57715 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966165AbeF1WOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:14:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41GvFl10sDz9s0w;
        Fri, 29 Jun 2018 08:14:18 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530224059;
        bh=CM3SqbVFClN7XWyrLu2nU55whTFu1y3bnxycei9cdQ0=;
        h=Date:From:To:Cc:Subject:From;
        b=Xi/UD2gU+/BFeJ8Qxyuj77XPxkZlIsKHaW1YAKZyDftWocsLyjjuK1QofkxbGDl9H
         KJZ6Zq/1wWxao3yA1KfVTY4XrVxbqHLM8zWfbTNCl6VxLcds3QTS86bU+A3lLzsnZu
         40HZN3g72cv/+AqJwe587EnE8+oyyaYHZ5kmHmaH8e/DwzI4jpVDo/LYKVm0oGiL/D
         xL+MBOGqRp9LYpxUbvjWotmOPpZfMXKThKba5570by35A8s1+so+9EUNlLqA23HVyH
         1E5esorGHRxG7nGSgBWzBPvsoUpqKe7LIa+8/6BygoIPcdjQMoqgYJVPG5cMmHkD7N
         eTRi4MuvSNeOg==
Date:   Fri, 29 Jun 2018 08:14:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>
Subject: linux-next: manual merge of the net tree with Linus' tree
Message-ID: <20180629081405.448f9296@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/U//oadUTyerfbGXo2YR_t=K"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/U//oadUTyerfbGXo2YR_t=K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net tree got a conflict in:

  net/smc/af_smc.c

between commit:

  a11e1d432b51 ("Revert changes to convert to ->poll_mask() and aio IOCB_CM=
D_POLL")

from Linus' tree and commit:

  24ac3a08e658 ("net/smc: rebuild nonblocking connect")

from the net tree.

I did the obvious syntactic fix up but, given that the commit that the
net tree commit is fixing ie being reverted, I wonder if the net tree
commit is needed (or correct?) any more.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/U//oadUTyerfbGXo2YR_t=K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls1Xa0ACgkQAVBC80lX
0GwCIwf/Tx5E8E3MKxblgBLwIElwAqw65GTKhLkiH4XuGvlOJ2vHq64hHM/AaOzF
dJf1zcNRlp0uthIrt/AYS6tyEy8FHGeVH8UFW4KXC2xx7OJY5Mb3tdTVdP6q3q8c
WSCrR3jSa7VibmPDKTCuFVHyN5fz4Ei/kSX3Op8xLnd/4nMAbjmk6a3dibk6lVVs
xlLf0ZTGs00Ou88OymSM9Dmdn7Q47w6Utaoq97qPtUoKFulcykbL+W7LgU+07AwN
fQx2VcnUiXNAsyIo6IkBqnjm8R2TKODqUKy5UeXCnhz5IK4StpaFcqvgl6qA/uhZ
2JlU/xNb1xrEXwZA5pYebptluTWcAQ==
=cFIX
-----END PGP SIGNATURE-----

--Sig_/U//oadUTyerfbGXo2YR_t=K--
