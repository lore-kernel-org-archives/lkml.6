Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7781C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 00:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83BC3206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 00:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mP80Yruy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbeLQAZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 19:25:52 -0500
Received: from ozlabs.org ([203.11.71.1]:38129 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730719AbeLQAZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 19:25:52 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43J24W5Dt9z9s4s;
        Mon, 17 Dec 2018 11:25:46 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545006348;
        bh=E1LHC8ZwDlcQvMPrUI7SrAR1Lw+AEJl94rOUdPic+J8=;
        h=Date:From:To:Cc:Subject:From;
        b=mP80YruyguIu8NW4pbKAtE+4X70or7fpKPSVPIvrqfLVy93hTACCV1KNAvBe3Zvoq
         LfFmHarv5MqUqVO1eP0nD/I3srlWiObUlBHWVIAzUVHWjwqFNhwCzpDa0ODqYRZsEz
         sCmLcXhx6xv7QbmAmmF1O7sieJtNLoT7QEIYPE9HxwvrpbyZjCT4CbpuA75nGOEBVK
         DiNUbYz4uJ5/czoRZqDWSPtpHBwzT5zNPeuiOnuYbRLdgl4gPQzJfGDrLHUL9irOiW
         FuXI016t44ajCqJhyCCkdUj68E7WQ0CIX6eNQ5mIQB0iX1I7FLN1WOZsNeMQWRqUfz
         acrbwIlDSFRJw==
Date:   Mon, 17 Dec 2018 11:25:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Eli Britstein <elibr@mellanox.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20181217112546.4e400eb3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/n4jr4mJVHUCHD6pU9.Ubt3B"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/n4jr4mJVHUCHD6pU9.Ubt3B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/mellanox/mlx5/core/en_tc.c

between commit:

  154e62abe9cd ("net/mlx5e: Properly initialize flow attributes for slow pa=
th eswitch rule deletion")

from the net tree and commit:

  e88afe759a49 ("net/mlx5e: Err if asked to mirror a goto chain tc eswitch =
rule")
  e85e02bad29e ("net/mlx5: E-Switch, Rename esw attr mirror count field")

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

diff --cc drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 9dabe9d4b279,53ebb5a48018..000000000000
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@@ -870,9 -903,9 +903,9 @@@ mlx5e_tc_offload_to_slow_path(struct ml
  	struct mlx5_flow_handle *rule;
 =20
  	memcpy(slow_attr, flow->esw_attr, sizeof(*slow_attr));
 -	slow_attr->action =3D MLX5_FLOW_CONTEXT_ACTION_FWD_DEST,
 -	slow_attr->split_count =3D 0,
 -	slow_attr->dest_chain =3D FDB_SLOW_PATH_CHAIN,
 +	slow_attr->action =3D MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
- 	slow_attr->mirror_count =3D 0;
++	slow_attr->split_count =3D 0;
 +	slow_attr->dest_chain =3D FDB_SLOW_PATH_CHAIN;
 =20
  	rule =3D mlx5e_tc_offload_fdb_rules(esw, flow, spec, slow_attr);
  	if (!IS_ERR(rule))
@@@ -887,9 -920,6 +920,9 @@@ mlx5e_tc_unoffload_from_slow_path(struc
  				  struct mlx5_esw_flow_attr *slow_attr)
  {
  	memcpy(slow_attr, flow->esw_attr, sizeof(*slow_attr));
 +	slow_attr->action =3D MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
- 	slow_attr->mirror_count =3D 0;
++	slow_attr->split_count =3D 0;
 +	slow_attr->dest_chain =3D FDB_SLOW_PATH_CHAIN;
  	mlx5e_tc_unoffload_fdb_rules(esw, flow, slow_attr);
  	flow->flags &=3D ~MLX5E_TC_FLOW_SLOW;
  }
@@@ -909,11 -939,13 +942,12 @@@ mlx5e_tc_add_fdb_flow(struct mlx5e_pri
  	struct mlx5e_rep_priv *rpriv;
  	struct mlx5e_priv *out_priv;
  	int err =3D 0, encap_err =3D 0;
+ 	int out_index;
 =20
 -	/* if prios are not supported, keep the old behaviour of using same prio
 -	 * for all offloaded rules.
 -	 */
 -	if (!mlx5_eswitch_prios_supported(esw))
 -		attr->prio =3D 1;
 +	if (!mlx5_eswitch_prios_supported(esw) && attr->prio !=3D 1) {
 +		NL_SET_ERR_MSG(extack, "E-switch priorities unsupported, upgrade FW");
 +		return -EOPNOTSUPP;
 +	}
 =20
  	if (attr->chain > max_chain) {
  		NL_SET_ERR_MSG(extack, "Requested chain is out of supported range");
@@@ -2980,15 -2667,7 +2667,15 @@@ static int parse_tc_fdb_actions(struct=20
  	if (!actions_match_supported(priv, exts, parse_attr, flow, extack))
  		return -EOPNOTSUPP;
 =20
 +	if (attr->dest_chain) {
 +		if (attr->action & MLX5_FLOW_CONTEXT_ACTION_FWD_DEST) {
 +			NL_SET_ERR_MSG(extack, "Mirroring goto chain rules isn't supported");
 +			return -EOPNOTSUPP;
 +		}
 +		attr->action |=3D MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
 +	}
 +
- 	if (attr->mirror_count > 0 && !mlx5_esw_has_fwd_fdb(priv->mdev)) {
+ 	if (attr->split_count > 0 && !mlx5_esw_has_fwd_fdb(priv->mdev)) {
  		NL_SET_ERR_MSG_MOD(extack,
  				   "current firmware doesn't support split rule for port mirroring");
  		netdev_warn_once(priv->netdev, "current firmware doesn't support split =
rule for port mirroring\n");

--Sig_/n4jr4mJVHUCHD6pU9.Ubt3B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwW7QoACgkQAVBC80lX
0Gwvegf/Yewd2xZBUwfUqKvwkYxk7atI6oLm4vk7LmfRICUjqQccU8EhPAzrHU4R
LolHPywYssdxAFET79sB2F8h1HDYlB8IJeRBjSbxLS/zVYgJDMjja71MvRHgIGjR
4idR4sUzt5cQnXuVg0+v8WmTzSy+9oN53mDOtfZG/D8nrwz84WW9CZNMRKOmQ+xd
VWwcFJXcjMQaxwYYZnrHC3LplpeeVpc0r0UC3DijpFjGBdmslMrdYJMGXT2DMXoK
eIIWrBgOWSFz1bqZxrL+nQzsLkDiVUqoSQw4TnuYp/7lqFSMpJlbwAE/AA3yeD3a
Tq9D7zvml+kfuu/maTD7sY0qQW1Uww==
=LAM2
-----END PGP SIGNATURE-----

--Sig_/n4jr4mJVHUCHD6pU9.Ubt3B--
