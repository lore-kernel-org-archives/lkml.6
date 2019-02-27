Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDB5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D56A218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GH/djHOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfB0AZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 19:25:53 -0500
Received: from ozlabs.org ([203.11.71.1]:40333 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbfB0AZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 19:25:52 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 448GgK1syKz9s9y;
        Wed, 27 Feb 2019 11:25:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551227149;
        bh=U/Sc36NM+XPbJyYn1C/aYK1ReX2IojUW72rZdFJxlng=;
        h=Date:From:To:Cc:Subject:From;
        b=GH/djHOSvruc2lMkAbrS4c15iw/RlOQgvSEJKD3Eol8srdv2+jy95pMC+YeaNqoSM
         47kFfY4dcDTn9uVRxg7KpcfmuHMf2hSAjxk7dsSpUSJiprUq8e50jJfAXtpjYz9v+c
         CI/UoSzl1qXCNcbtHvmyBlownI/PWvxDFlRAvnhbAcRaP1iVUPFR7x1kciIn8YK3BO
         362lsDMaVYCCDP1t3zd2cRZfBs4peBjGuE9HkcsP4VRjhjWqkz0YVtJdi2KBcZh7AA
         cR4Cv7nZwtWJo8p+gmuaTrMr4EyyM1u/PntZKqUa0K1SmReBxTby/Jwuym8k0wl8Xd
         1PsQInzia1zyw==
Date:   Wed, 27 Feb 2019 11:25:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: linux-next: manual merge of the net-next tree with the rdma tree
Message-ID: <20190227112522.2f32b5d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/61E+E=v=M=v7ar4TF936D8O"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/61E+E=v=M=v7ar4TF936D8O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/infiniband/hw/mlx4/Kconfig

between commit:

  6fa8f1afd337 ("IB/{core,uverbs}: Move ib_umem_xxx functions from ib_core =
to ib_uverbs")

from the rdma tree and commit:

  f4b6bcc7002f ("net: devlink: turn devlink into a built-in")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/infiniband/hw/mlx4/Kconfig
index db4aa13ebae0,4e9936731867..000000000000
--- a/drivers/infiniband/hw/mlx4/Kconfig
+++ b/drivers/infiniband/hw/mlx4/Kconfig
@@@ -1,7 -1,7 +1,6 @@@
  config MLX4_INFINIBAND
  	tristate "Mellanox ConnectX HCA support"
  	depends on NETDEVICES && ETHERNET && PCI && INET
- 	depends on MAY_USE_DEVLINK
 -	depends on INFINIBAND_USER_ACCESS || !INFINIBAND_USER_ACCESS
  	select NET_VENDOR_MELLANOX
  	select MLX4_CORE
  	---help---

--Sig_/61E+E=v=M=v7ar4TF936D8O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx12PIACgkQAVBC80lX
0GwydAf/f5cBV+Q5Mk8KlUIarqwXrGwbQBHcqEbqNWDb135JeKDx16nJAua05vS9
F+f9WKYZHVqN0ZOtM8QGbEHJJnad+MeJJxgdZkazTHPmAn+uR/jXNvhUsfHNfsiC
3iiCCFxk2+kdzx0Dagp53huNFg7hRmJCIrFNh1Rff+Nt/f16mcFR6vrSE2QyaznH
caMhE6dl4wDAQMcloViKatxUtvTdsbRDBRmb9Q9MErY80V1UC8SISy4RAt8okx1A
ahEvzpgRiYpP/t2RMvBQ8yNVJnQ663slbYPZIGMEBApCI1aa4mX7PxC7vzeLBMMr
NTazxzxhYP+AmhYgrMt4utiGapsBhA==
=78aA
-----END PGP SIGNATURE-----

--Sig_/61E+E=v=M=v7ar4TF936D8O--
