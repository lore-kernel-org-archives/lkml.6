Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A234C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 03:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01632083E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 03:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KmHn/6TG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01632083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbeG3Ezt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 00:55:49 -0400
Received: from ozlabs.org ([203.11.71.1]:47415 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbeG3Ezt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 00:55:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41f4dV3224z9s1R;
        Mon, 30 Jul 2018 13:22:54 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532920974;
        bh=sgTt7+HPR2I5K2GuAuo8pSl5j2+m6HgwGclMnOGo368=;
        h=Date:From:To:Cc:Subject:From;
        b=KmHn/6TG+4SrMo0+o404GmPlXFwcqyNB65nkwdIv9ea9l+ucoobAXLDPsicR41JuH
         DrgSqeT2fcm9jPvHRK15CkIRLRvX4PF2Fti245qNU98fXHpeW91V/loKfZ+kBMy4CM
         4DBUiOalT9ylSrdu/R8uDcbkMhX+evI5AevQVWmBjjFEGQqNv629Y7jmuJ3fVTTaBv
         zNOU7OEnalVG6T+Tq0ADoC/Vd8RY3smcBttlKuqaAXTS7LabltaRn8p1OLcAn5J1Bl
         Sm+zmge7OlKnendyBZSrvCZhkiOGOyR2vVWwi5Ealobbi8V0qSbBPM13N18XbVVqLq
         /E97k1fEjphJA==
Date:   Mon, 30 Jul 2018 13:22:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: linux-next: manual merge of the crypto tree with the net-next tree
Message-ID: <20180730132253.33633f56@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.2Lzkax8Y_tah6B68DEPXcQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.2Lzkax8Y_tah6B68DEPXcQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

Today's linux-next merge of the crypto tree got conflicts in:

  drivers/net/ethernet/freescale/fec_main.c
  drivers/net/ethernet/freescale/fs_enet/mac-fec.c

between commits:

  16f6e9835bcd ("net: ethernet: freescale: Use generic CRC32 implementation=
")
  d805f6a86829 ("net: ethernet: fs-enet: Use generic CRC32 implementation")

from the net-next tree and commit:

  5d258b48efbd ("net: ethernet: Use existing define with polynomial")

from the crypto tree.

I fixed it up (I used the net-next tree versions (but kept the rmeoval
of the CRC32_POLY and FEC_CRC_POLY defines) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/.2Lzkax8Y_tah6B68DEPXcQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltehI0ACgkQAVBC80lX
0GzO9Af+Lazi5sNSKTL+SrdZpV8CWyXRXYMN7RCl+rIcj0tJQKJ7A/DnFeinQse8
jKpTh6fYtLw+THR1UTipNZsZVw0gGRSp3fdo7KHMPdkwoIa0aeTSSACk1OqI+YOA
R3tLZK0kgzDm9v/LiydL0Smr78tAj56acgrRli7OV2rC483VWeeIhND9DomlZIGi
doYHj/NvvfNBKI+y29v4uqUu9pZNuxzDHwTfRt4TH//o8uK57yqkD8d8QThyOVxi
xUDYyfFBO7y+gh4RcdWHVJHt81lmbRa5MMTgKTHHQFP01tMpMnTo6+o3vQ/0tDtX
T7og/wdWCx6tQLrV1iijdL7+6cb2PQ==
=Xo+y
-----END PGP SIGNATURE-----

--Sig_/.2Lzkax8Y_tah6B68DEPXcQ--
