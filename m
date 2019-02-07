Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2683C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704DE218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="o9+6mQqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfBGAya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 19:54:30 -0500
Received: from ozlabs.org ([203.11.71.1]:58491 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfBGAya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 19:54:30 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43w0FY6THfz9s3q;
        Thu,  7 Feb 2019 11:54:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549500867;
        bh=gXUt3M6eQWDTfKKfC7V2etgx85SEK62T/SE/qSj3o84=;
        h=Date:From:To:Cc:Subject:From;
        b=o9+6mQqmEIwo8kD7SwMjpKp1lGQoO05Kb1243MGrWHm/NB0bb+6Gi/Dt8iS8qERWg
         bdH3mpxCM/4ynn9d97fzZnpW6mPGHdIaQ0fW1qMwG7oXUX/GHZd/6RAKZbDHzC8zap
         GSEgvOoIaVsKgGyN+7f/o1rOuGmD/1xoQIi4X7HZU2uNJtYxk8/NEdbVW77zyfVGq9
         ltyM7REdH9kYQkUQbWOnny1gaAv5idDTKxcbGksV5Fl245eEJuV7G0W0gnO/1rXf2o
         7MsoiPj8G5hJpoXQGAYjQnTaAgQuVd3AS68Ld4vOYgOjukGXprkEsTsw2tdfcdi4ls
         9/t6VvauVXUCg==
Date:   Thu, 7 Feb 2019 11:54:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guy Shattah <sguy@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20190207115425.61c3708a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9YA.2UXuNSrqpdapv=BbCtf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9YA.2UXuNSrqpdapv=BbCtf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/mellanox/mlx5/core/en_tc.c

between commit:

  1651925d403e ("net/mlx5e: Use the inner headers to determine tc/pedit off=
load limitation on decap flows")

from the net tree and commit:

  738678817573 ("drivers: net: use flow action infrastructure")

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
index 1c3c9fa26b55,83522c926d7c..000000000000
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@@ -1309,15 -1309,12 +1309,12 @@@ static int parse_tunnel_attr(struct mlx
  				       outer_headers);
  	void *headers_v =3D MLX5_ADDR_OF(fte_match_param, spec->match_value,
  				       outer_headers);
-=20
- 	struct flow_dissector_key_control *enc_control =3D
- 		skb_flow_dissector_target(f->dissector,
- 					  FLOW_DISSECTOR_KEY_ENC_CONTROL,
- 					  f->key);
- 	int err =3D 0;
+ 	struct flow_rule *rule =3D tc_cls_flower_offload_flow_rule(f);
+ 	struct flow_match_control enc_control;
+ 	int err;
 =20
  	err =3D mlx5e_tc_tun_parse(filter_dev, priv, spec, f,
 -				 headers_c, headers_v);
 +				 headers_c, headers_v, match_level);
  	if (err) {
  		NL_SET_ERR_MSG_MOD(extack,
  				   "failed to parse tunnel attributes");
@@@ -1465,19 -1455,17 +1455,17 @@@ static int __parse_cls_flower(struct ml
  		return -EOPNOTSUPP;
  	}
 =20
- 	if ((dissector_uses_key(f->dissector,
- 				FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) ||
- 	     dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_ENC_KEYID) ||
- 	     dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_ENC_PORTS)) &&
- 	    dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_ENC_CONTROL)) {
- 		struct flow_dissector_key_control *key =3D
- 			skb_flow_dissector_target(f->dissector,
- 						  FLOW_DISSECTOR_KEY_ENC_CONTROL,
- 						  f->key);
- 		switch (key->addr_type) {
+ 	if ((flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) ||
+ 	     flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ENC_KEYID) ||
+ 	     flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ENC_PORTS)) &&
+ 	    flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ENC_CONTROL)) {
+ 		struct flow_match_control match;
+=20
+ 		flow_rule_match_enc_control(rule, &match);
+ 		switch (match.key->addr_type) {
  		case FLOW_DISSECTOR_KEY_IPV4_ADDRS:
  		case FLOW_DISSECTOR_KEY_IPV6_ADDRS:
 -			if (parse_tunnel_attr(priv, spec, f, filter_dev))
 +			if (parse_tunnel_attr(priv, spec, f, filter_dev, tunnel_match_level))
  				return -EOPNOTSUPP;
  			break;
  		default:
@@@ -2180,22 -2129,17 +2131,22 @@@ static bool csum_offload_supported(stru
  }
 =20
  static bool modify_header_match_supported(struct mlx5_flow_spec *spec,
- 					  struct tcf_exts *exts,
+ 					  struct flow_action *flow_action,
 +					  u32 actions,
  					  struct netlink_ext_ack *extack)
  {
- 	const struct tc_action *a;
+ 	const struct flow_action_entry *act;
  	bool modify_ip_header;
  	u8 htype, ip_proto;
  	void *headers_v;
  	u16 ethertype;
- 	int nkeys, i;
+ 	int i;
 =20
 -	headers_v =3D MLX5_ADDR_OF(fte_match_param, spec->match_value, outer_hea=
ders);
 +	if (actions & MLX5_FLOW_CONTEXT_ACTION_DECAP)
 +		headers_v =3D MLX5_ADDR_OF(fte_match_param, spec->match_value, inner_he=
aders);
 +	else
 +		headers_v =3D MLX5_ADDR_OF(fte_match_param, spec->match_value, outer_he=
aders);
 +
  	ethertype =3D MLX5_GET(fte_match_set_lyr_2_4, headers_v, ethertype);
 =20
  	/* for non-IP we only re-write MACs, so we're okay */
@@@ -2251,8 -2191,9 +2198,9 @@@ static bool actions_match_supported(str
  		return false;
 =20
  	if (actions & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR)
- 		return modify_header_match_supported(&parse_attr->spec, exts,
+ 		return modify_header_match_supported(&parse_attr->spec,
+ 						     flow_action,
 -						     extack);
 +						     actions, extack);
 =20
  	return true;
  }

--Sig_/9YA.2UXuNSrqpdapv=BbCtf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxbgcEACgkQAVBC80lX
0GzIXgf49xjk8Zp9UPc9swOF5xz0KSdEsKVrqncrNFL/YaD4NbqSCQrohK1r/GNU
mBZMAKueD9aeyUNXS5gUDH7joWV00LJfUCIr2hUqgecL7QnB//Iz5S3grV4X5/aP
D+NnQYwnTlt/gkV3wFjvq4cMVmBHATSPaaP4mUMkf+lRCZrElDBHORMJ84uteFKB
304N740Yuk4yZl63VJ03mIGqFn/cqcPhzMtfFtvlqjUiNDQJoEtq39TOsOi9w05K
8nhT8bjgh1wWm4SZWxKFx7kM//GWJvw7KIOu4gl7t0+T+4cmIPRRbwMCtQO6hZMN
tbmDvX0bzDRkZlzVFsAC+dxWEfbr
=ID3t
-----END PGP SIGNATURE-----

--Sig_/9YA.2UXuNSrqpdapv=BbCtf--
