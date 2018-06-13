Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0D864C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBEE208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="R2cyjzp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBEE208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935861AbeFMXBk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 19:01:40 -0400
Received: from ozlabs.org ([203.11.71.1]:40677 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935070AbeFMXBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 19:01:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 415j1D0Kqmz9s0W;
        Thu, 14 Jun 2018 09:01:36 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1528930896;
        bh=Hi2bH57UNSto5u7QxftnGRktiyYPYDHEYO2kQ8XNnFk=;
        h=Date:From:To:Cc:Subject:From;
        b=R2cyjzp8GvWEtEFjxyAA8dtDmXEmVlrdirHe+pDKX3XycxnnD/8Toag6lEBOhw3Ds
         xEpJO3Hi+J5f7xKZdgkXvAVKipv6z+IxZkZQMK8Ucb2UV3aRzMPRByXcjbSRZXhJ+4
         TONGWNHbUZYmRkIjXKvZry6miDa7ENGmBIeUXXfe4/E9R9bmCrosYHDJoGyJv31u/E
         qyqwJf/Eo3QFYQNoG8A9U6ANzFax3ETlMOO7gDthdWD3Y8cMWOafEGao+FXCUK4W6N
         HU8MEb62qqqtICwuoHKdn0ABtjI6EhRbdRIKcoTWLgl/Cyg+1VV1BDHHs/8hPtdqj8
         vA7AolXEYvJuw==
Date:   Thu, 14 Jun 2018 09:01:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Aurelien Aptel <aaptel@suse.com>
Subject: linux-next: manual merge of the cifs tree with Linus' tree
Message-ID: <20180614090135.1d71babb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mcQV8Nlb9b44/qk3AS7rt9G"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mcQV8Nlb9b44/qk3AS7rt9G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the cifs tree got a conflict in:

  fs/cifs/transport.c

between commit:

  6da2ec56059c ("treewide: kmalloc() -> kmalloc_array()")

from Linus' tree and commit:

  1560d69e21c6 ("cifs: push rfc1002 generation down the stack")

from the cifs tree.

I fixed it up (the latter removed the code modified by the former) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/mcQV8Nlb9b44/qk3AS7rt9G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlshok8ACgkQAVBC80lX
0GyVVwf/Zu5962r/VKaPnoz1YP+fVgX/pX0ZxnhRduSQzlM02aIo+/TNGPKxy/DJ
s3J3d543a24CIlUaJnbh77m4U1wRLQNWrv0E0ccOx5y1ZHV7s+lR5zighduAbWCH
OThIkScNDKzFOAT0iGi0KS1sl6DVQ5PrS6ToICIODGIx2zBBI4zPcewnSn95PsjH
+QXPebqSFdZthuK9jm9SJ6AHTS3tCif9t+GT5oDvCHft+2USjJM0AwJs+z5PmmTc
4b6inPZ/3sCBoMU3Wc+sTRL0hSZWxpAlLmqRqOfI/jsPn+/PZACwHgu4zPij4a7U
GCuNwTQjSmSlOjo9/zP4mFG0lQHxbg==
=TNAm
-----END PGP SIGNATURE-----

--Sig_/mcQV8Nlb9b44/qk3AS7rt9G--
