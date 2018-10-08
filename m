Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BBFC6787D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D3C2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cKyv59Sp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D3C2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeJHHMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 03:12:43 -0400
Received: from ozlabs.org ([203.11.71.1]:55485 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeJHHMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 03:12:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42T0vJ1hMcz9sCV;
        Mon,  8 Oct 2018 11:03:40 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538957020;
        bh=Jk7lY59AMqb11AmrgEohCYOwe4ibAiYH1IdlF6b1y0w=;
        h=Date:From:To:Cc:Subject:From;
        b=cKyv59Sp5wYHk8SGgqsrL7UblRaAEnEawZVGgSoxts6FSLOoQLsd6K1Op8vnH1IdG
         j6Oqc5PGDXTDneo20q9OTwQHwlq8HHBWBQEL7pkAffrxDMk6cAL9viEZFQHh7ONNJW
         yKltx5yfp+aaH/KwNnnOFH45Fymz5zlBdp05qlH2mGUEG0pMoLrf/91KsgdgqxTFZR
         +MBxPcHuWqOv4+nAtHgp9n27Obljsrr7awLu1nKscJOgRmaUtObR7pp9b93N9pX6uk
         d+SeIko762pA71FkVLx9qoKn+z9srzRUDbwNlbhxxZJIEP5n5C8/Iw2RI0IMNMa+rO
         YQLXZvxFIBeUg==
Date:   Mon, 8 Oct 2018 11:03:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: manual merge of the rdma tree with the vfs tree
Message-ID: <20181008110320.2597e3d5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SATp6qxSk=.N3Oj+J=eHjRo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SATp6qxSk=.N3Oj+J=eHjRo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rdma tree got a conflict in:

  drivers/infiniband/Kconfig

between commit:

  f57d445eb317 ("Make anon_inodes unconditional")

from the vfs tree and commit:

  914e5d7d4697 ("RDMA: Fix building with CONFIG_MMU=3Dn")

from the rdma tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/infiniband/Kconfig
index 176b943dfec9,0a3ec7c726ec..000000000000
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@@ -25,6 -25,8 +25,7 @@@ config INFINIBAND_USER_MA
 =20
  config INFINIBAND_USER_ACCESS
  	tristate "InfiniBand userspace access (verbs and CM)"
 -	select ANON_INODES
+ 	depends on MMU
  	---help---
  	  Userspace InfiniBand access support.  This enables the
  	  kernel side of userspace verbs and the userspace

--Sig_/SATp6qxSk=.N3Oj+J=eHjRo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu6nsgACgkQAVBC80lX
0GwDzgf/QT0194qWd27r3opEUyyTr7iswkiaVzqN8gl2zR69duvPhCrIrZC13W6p
S6/h4msZku4py0RPzz1nO/hkQ2i86Fe4oSq57PQWAcTTdHa8gMxI0neANAPBYY5R
4E+Hzi3D2vPPx+KgLDWKEH5SxlC8Pqc4qBFJtgczjiWTnnCHeY5B2Rck15xOBeAA
Ncn0RdeNH2RJbKLrsxpI9uTW9VIXCjLDsgXlsQvdBawZ2FdN77Iny/jjAPbFJxCs
Rysabc/DOgPTZ+a21OtwZBSDBZYxC2WpRe+SPfXo5JRcWldY75Iu0GAb55Z9lAUV
n+Tvw5Q92RVDMuryAIWr2lzuuXwYkQ==
=+0PC
-----END PGP SIGNATURE-----

--Sig_/SATp6qxSk=.N3Oj+J=eHjRo--
