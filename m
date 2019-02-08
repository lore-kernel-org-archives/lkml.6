Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55081C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077502085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ta74V24r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfBHAYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:24:38 -0500
Received: from ozlabs.org ([203.11.71.1]:42677 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfBHAYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:24:37 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43wbXd3nK4z9s4Z;
        Fri,  8 Feb 2019 11:24:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549585473;
        bh=F+Ol9VIQ/KIpQv1ZCwgFmesYZI3WKoPX3O/w7xq7/2w=;
        h=Date:From:To:Cc:Subject:From;
        b=Ta74V24rN5zjB8J6i/looRnlGDxkt8HZDypMNHJ4DQOGQ6gjVMoAFOiWLEy/Y26qK
         fvka2DiCa8LnqxQ75eLGv9s59mWuEivHbt5g1uJdENOd0ItxoiayJyRKQg9pY4XOIl
         up8AhdMGmulLyABJ/eaqrGMjnFQEaliOYqgkCI/ixbcLjTDIcs+Zkek30Rn1JWjI5G
         8lgpVuX34n5IN01veUgP2Q6lI0F0/ssm9rUVCDZ/opIWSo8+e4A7T6eZFPoMgrs3nF
         ObN/Tv2HdNvyWPbViaE099RT3NtXfIPBFlcK77wSCvrUixiYwRLUxagkdAA93hViKh
         3fW6McIcvIAmQ==
Date:   Fri, 8 Feb 2019 11:24:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20190208112432.77b8f1e3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GKDw+/7SxWRfZF.DWRdE5wk"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GKDw+/7SxWRfZF.DWRdE5wk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/mellanox/mlx5/core/en_tc.c

between commit:

  218d05ce326f ("net/mlx5e: Don't overwrite pedit action when multiple pedi=
t used")

from the net tree and commit:

  c500c86b0c75 ("net/mlx5e: support for two independent packet edit actions=
")

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
index b5c1b039375a,85c5dd7fc2c7..000000000000
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@@ -1310,15 -1308,12 +1309,12 @@@ static int parse_tunnel_attr(struct mlx
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
@@@ -1466,19 -1454,17 +1455,17 @@@ static int __parse_cls_flower(struct ml
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
@@@ -1937,12 -1880,11 +1883,11 @@@ static struct mlx5_fields fields[] =3D=20
  	OFFLOAD(UDP_DPORT, 2, udp.dest,   0),
  };
 =20
 -/* On input attr->num_mod_hdr_actions tells how many HW actions can be pa=
rsed at
 - * max from the SW pedit action. On success, it says how many HW actions =
were
 - * actually parsed.
 +/* On input attr->max_mod_hdr_actions tells how many HW actions can be pa=
rsed at
 + * max from the SW pedit action. On success, attr->num_mod_hdr_actions
 + * says how many HW actions were actually parsed.
   */
- static int offload_pedit_fields(struct pedit_headers *masks,
- 				struct pedit_headers *vals,
+ static int offload_pedit_fields(struct pedit_headers_action *hdrs,
  				struct mlx5e_tc_flow_parse_attr *parse_attr,
  				struct netlink_ext_ack *extack)
  {
@@@ -1957,17 -1899,15 +1902,17 @@@
  	__be16 mask_be16;
  	void *action;
 =20
- 	set_masks =3D &masks[TCA_PEDIT_KEY_EX_CMD_SET];
- 	add_masks =3D &masks[TCA_PEDIT_KEY_EX_CMD_ADD];
- 	set_vals =3D &vals[TCA_PEDIT_KEY_EX_CMD_SET];
- 	add_vals =3D &vals[TCA_PEDIT_KEY_EX_CMD_ADD];
+ 	set_masks =3D &hdrs[0].masks;
+ 	add_masks =3D &hdrs[1].masks;
+ 	set_vals =3D &hdrs[0].vals;
+ 	add_vals =3D &hdrs[1].vals;
 =20
  	action_size =3D MLX5_UN_SZ_BYTES(set_action_in_add_action_in_auto);
 -	action =3D parse_attr->mod_hdr_actions;
 -	max_actions =3D parse_attr->num_mod_hdr_actions;
 -	nactions =3D 0;
 +	action =3D parse_attr->mod_hdr_actions +
 +		 parse_attr->num_mod_hdr_actions * action_size;
 +
 +	max_actions =3D parse_attr->max_mod_hdr_actions;
 +	nactions =3D parse_attr->num_mod_hdr_actions;
 =20
  	for (i =3D 0; i < ARRAY_SIZE(fields); i++) {
  		f =3D &fields[i];
@@@ -2085,52 -2027,53 +2032,55 @@@ static int alloc_mod_hdr_actions(struc
  static const struct pedit_headers zero_masks =3D {};
 =20
  static int parse_tc_pedit_action(struct mlx5e_priv *priv,
- 				 const struct tc_action *a, int namespace,
+ 				 const struct flow_action_entry *act, int namespace,
  				 struct mlx5e_tc_flow_parse_attr *parse_attr,
+ 				 struct pedit_headers_action *hdrs,
  				 struct netlink_ext_ack *extack)
  {
- 	struct pedit_headers masks[__PEDIT_CMD_MAX], vals[__PEDIT_CMD_MAX], *cmd=
_masks;
- 	int nkeys, i, err =3D -EOPNOTSUPP;
+ 	u8 cmd =3D (act->id =3D=3D FLOW_ACTION_MANGLE) ? 0 : 1;
+ 	int err =3D -EOPNOTSUPP;
  	u32 mask, val, offset;
- 	u8 cmd, htype;
+ 	u8 htype;
 =20
- 	nkeys =3D tcf_pedit_nkeys(a);
+ 	htype =3D act->mangle.htype;
+ 	err =3D -EOPNOTSUPP; /* can't be all optimistic */
 =20
- 	memset(masks, 0, sizeof(struct pedit_headers) * __PEDIT_CMD_MAX);
- 	memset(vals,  0, sizeof(struct pedit_headers) * __PEDIT_CMD_MAX);
+ 	if (htype =3D=3D FLOW_ACT_MANGLE_UNSPEC) {
+ 		NL_SET_ERR_MSG_MOD(extack, "legacy pedit isn't offloaded");
+ 		goto out_err;
+ 	}
 =20
- 	for (i =3D 0; i < nkeys; i++) {
- 		htype =3D tcf_pedit_htype(a, i);
- 		cmd =3D tcf_pedit_cmd(a, i);
- 		err =3D -EOPNOTSUPP; /* can't be all optimistic */
+ 	mask =3D act->mangle.mask;
+ 	val =3D act->mangle.val;
+ 	offset =3D act->mangle.offset;
 =20
- 		if (htype =3D=3D TCA_PEDIT_KEY_EX_HDR_TYPE_NETWORK) {
- 			NL_SET_ERR_MSG_MOD(extack,
- 					   "legacy pedit isn't offloaded");
- 			goto out_err;
- 		}
+ 	err =3D set_pedit_val(htype, ~mask, val, offset, &hdrs[cmd]);
+ 	if (err)
+ 		goto out_err;
 =20
- 		if (cmd !=3D TCA_PEDIT_KEY_EX_CMD_SET && cmd !=3D TCA_PEDIT_KEY_EX_CMD_=
ADD) {
- 			NL_SET_ERR_MSG_MOD(extack, "pedit cmd isn't offloaded");
- 			goto out_err;
- 		}
+ 	hdrs[cmd].pedits++;
 =20
- 		mask =3D tcf_pedit_mask(a, i);
- 		val =3D tcf_pedit_val(a, i);
- 		offset =3D tcf_pedit_offset(a, i);
+ 	return 0;
+ out_err:
+ 	return err;
+ }
 =20
- 		err =3D set_pedit_val(htype, ~mask, val, offset, &masks[cmd], &vals[cmd=
]);
- 		if (err)
- 			goto out_err;
- 	}
+ static int alloc_tc_pedit_action(struct mlx5e_priv *priv, int namespace,
+ 				 struct mlx5e_tc_flow_parse_attr *parse_attr,
+ 				 struct pedit_headers_action *hdrs,
+ 				 struct netlink_ext_ack *extack)
+ {
+ 	struct pedit_headers *cmd_masks;
+ 	int err;
+ 	u8 cmd;
 =20
 -	err =3D alloc_mod_hdr_actions(priv, hdrs, namespace, parse_attr);
 -	if (err)
 -		goto out_err;
 +	if (!parse_attr->mod_hdr_actions) {
- 		err =3D alloc_mod_hdr_actions(priv, a, namespace, parse_attr);
++		err =3D alloc_mod_hdr_actions(priv, hdrs, namespace, parse_attr);
 +		if (err)
 +			goto out_err;
 +	}
 =20
- 	err =3D offload_pedit_fields(masks, vals, parse_attr, extack);
+ 	err =3D offload_pedit_fields(hdrs, parse_attr, extack);
  	if (err < 0)
  		goto out_dealloc_parsed_actions;
 =20
@@@ -2185,22 -2128,17 +2135,22 @@@ static bool csum_offload_supported(stru
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
@@@ -2256,8 -2190,9 +2202,9 @@@ static bool actions_match_supported(str
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

--Sig_/GKDw+/7SxWRfZF.DWRdE5wk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxczEAACgkQAVBC80lX
0Gyhawf/XzmxbaOgHh22uR4tXYbixEvQUeQAZ2m3GGDE2XdDcngMXpA49eTaLrHk
mIWrta+cagqOUk9Al17/jVwDIH9KZWgsZC/H/c/A+GhVlndGmDhLZV/0zc5GUwAr
kl8NnRGBuDoIVg1H0U7uRrjrP+Froc8KgXfzGbJpJ+V5uKbXCCw3yuyqFX9LOx87
LDNa8hvto4DjvCW0ONY8fv1HB6GjKkA7c+4L0E87NJcTyi8j4INBJmoJKF+3qBUR
I27SrIfiURwJ33IJIWRMlWEcK4ko+9vi5/4hLNQa3G2gJZ0rNhPWRUqsBA6a5FNW
ypj86E6+cId4WZPw/NAEtQmkqBbSPg==
=AOHg
-----END PGP SIGNATURE-----

--Sig_/GKDw+/7SxWRfZF.DWRdE5wk--
