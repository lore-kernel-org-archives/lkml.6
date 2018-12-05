Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A7BC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980492087F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UegL+8N1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980492087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbeLEBHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:07:12 -0500
Received: from ozlabs.org ([203.11.71.1]:33149 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbeLEBHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:07:10 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 438gYk5fwjz9s8F;
        Wed,  5 Dec 2018 12:07:06 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543972026;
        bh=BXasLvROLjKuD2JIma8KBOtVeeWIh6WbUy1L20nW058=;
        h=Date:From:To:Cc:Subject:From;
        b=UegL+8N1/lcYxK/yROEUR9wDzyO52mCVcbqY+OIgKa4n5794yCVlYITdqMkqYUpzs
         m7fwwW8r8zMI6o1Rw4TOZQ/aLdj55PiihoOzKLvgq+ycwB8cUAzSFL6Esy5WUeJIJR
         er8BvcuJd21hMBdrln9Ud1ZgsgmuZXLgPJePGklGL11ch9hLQvRRG9lx4xXb7Eu1Ou
         QDZ5C8PYcBWT5SkKOb8qlqIag29vFV0jSZz0wxEVKXVn1+I/5rSMinXVQumb0d20Vg
         FIsKRO/NPIVqWAr7jqAKpcLQbvZLQRxuF9TqEmBKstX0vaMkyaLkK/tzOq0tvcodr8
         BUOWkMbFakr8A==
Date:   Wed, 5 Dec 2018 12:07:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the mlx5-next tree with the rdma tree
Message-ID: <20181205120706.294b9422@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/T8tK4Q5bNyrZX7VJB2eHTL3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/T8tK4Q5bNyrZX7VJB2eHTL3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Leon,

Today's linux-next merge of the mlx5-next tree got a conflict in:

  drivers/infiniband/hw/mlx5/main.c
  drivers/infiniband/hw/mlx5/mlx5_ib.h

between commit:

  36e235c88299 ("RDMA/mlx5: Use the uapi disablement APIs instead of code")

from the rdma tree and commit:

  81773ce5f07f ("RDMA/mlx5: Use stages for callback to setup and release DE=
VX")

from the mlx5-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/infiniband/hw/mlx5/main.c
index f9078688da5b,96515a8c9d2c..000000000000
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@@ -6231,6 -6336,12 +6321,9 @@@ static const struct mlx5_ib_profile pf_
  	STAGE_CREATE(MLX5_IB_STAGE_PRE_IB_REG_UMR,
  		     NULL,
  		     mlx5_ib_stage_pre_ib_reg_umr_cleanup),
 -	STAGE_CREATE(MLX5_IB_STAGE_SPECS,
 -		     mlx5_ib_stage_populate_specs,
 -		     NULL),
+ 	STAGE_CREATE(MLX5_IB_STAGE_WHITELIST_UID,
+ 		     mlx5_ib_stage_devx_init,
+ 		     mlx5_ib_stage_devx_cleanup),
  	STAGE_CREATE(MLX5_IB_STAGE_IB_REG,
  		     mlx5_ib_stage_ib_reg_init,
  		     mlx5_ib_stage_ib_reg_cleanup),
diff --cc drivers/infiniband/hw/mlx5/mlx5_ib.h
index a2b35a1a5031,861b68f2e330..000000000000
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@@ -781,6 -784,8 +784,7 @@@ enum mlx5_ib_stages=20
  	MLX5_IB_STAGE_UAR,
  	MLX5_IB_STAGE_BFREG,
  	MLX5_IB_STAGE_PRE_IB_REG_UMR,
 -	MLX5_IB_STAGE_SPECS,
+ 	MLX5_IB_STAGE_WHITELIST_UID,
  	MLX5_IB_STAGE_IB_REG,
  	MLX5_IB_STAGE_POST_IB_REG_UMR,
  	MLX5_IB_STAGE_DELAY_DROP,
@@@ -890,7 -896,9 +895,8 @@@ struct mlx5_ib_pf_eq=20
 =20
  struct mlx5_ib_dev {
  	struct ib_device		ib_dev;
 -	const struct uverbs_object_tree_def *driver_trees[7];
  	struct mlx5_core_dev		*mdev;
+ 	struct notifier_block		mdev_events;
  	struct mlx5_roce		roce[MLX5_MAX_PORTS];
  	int				num_ports;
  	/* serialize update of capability mask

--Sig_/T8tK4Q5bNyrZX7VJB2eHTL3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwHJLoACgkQAVBC80lX
0GyS4Qf+O+tk+o6rVrqlB6yV/4P1AbZRGbwVYUk1ANyBxpjdootHfRqBDtlJtnmV
OteIebarKNgK1bLiKjHzUU8EYWb6vOES5ofpb/CFMd/qTXnzILrz2WajqxET4pNr
1IuaQdU6Q6WNMzCyPrxvtux0KuBGIbCRYeH6jBocOa1pECCZfsbFTKAlxYXUYTKY
gKXhzURcFwj6ubg7E8OM/ophi1Hcxyh2IERqXs47/MJtR0BlbOdl5eysGwqmlRYD
XHwPd0D9yjKX6ZfHXEfbAam3nZhVvHZPC66Xlf8bGZAdr0HBWY8XGxLBsc1/QT6C
LrPsLBra2V6Bhqgf/bVtLSCVl+wKvA==
=exhH
-----END PGP SIGNATURE-----

--Sig_/T8tK4Q5bNyrZX7VJB2eHTL3--
