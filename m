Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE8BC64EBD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 02:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F36120C0A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 02:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LvwSYyNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F36120C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeJCJEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 05:04:44 -0400
Received: from ozlabs.org ([203.11.71.1]:58749 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbeJCJEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 05:04:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Q0735c1lz9s3T;
        Wed,  3 Oct 2018 12:18:22 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538533104;
        bh=Ov1Pnse9zzCsItJ0q14e5JQBtO9yTxLkixrQHTX6uUg=;
        h=Date:From:To:Cc:Subject:From;
        b=LvwSYyNhoN5Qe9E6SljQXIOUO/6DjXnU3cACzflZsFngsyKDdnS46GDqPaI53sfDp
         XgQGaOLPruarhkhlbFw/FZqnKdzxj+ZXdbvoPysKWcCtLmOZ/er+WJUQJ3qtZ01UA5
         29v1gH1vVN7oXD1W3RNl8bNBF/lteI2ALvvNeDecyIOdteIoMjTVmuDojE8922wX6z
         ozIypUJp0A2/daTekmGV2f0dRgzWfn2Up2BorbXzUqsIYq2n92T5GyVd0fHSzAbLT7
         UyoAoPK1YMFF8frP3bXtJFSYLJUcNkFiO3KVrTVsjaQJWGbrJ2Ba9Rmj6yOYNmolKm
         tt7OcKmHpLtkw==
Date:   Wed, 3 Oct 2018 12:18:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Christian Brauner <christian@brauner.io>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20181003121804.689fdc08@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/V2B6/bIfgaVfl3eLXzZ7FVW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/V2B6/bIfgaVfl3eLXzZ7FVW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/core/rtnetlink.c

between commit:

  893626d6a353 ("rtnetlink: Fail dump if target netnsid is invalid")

from the net tree and commits:

  c383edc42403 ("rtnetlink: add rtnl_get_net_ns_capable()")
  7e4a8d5a93f6 ("rtnetlink: s/IFLA_IF_NETNSID/IFLA_TARGET_NETNSID/g")

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

diff --cc net/core/rtnetlink.c
index 7f37fe9c65a5,35162e1b06ad..000000000000
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@@ -1895,11 -1910,13 +1910,11 @@@ static int rtnl_dump_ifinfo(struct sk_b
 =20
  	if (nlmsg_parse(cb->nlh, hdrlen, tb, IFLA_MAX,
  			ifla_policy, NULL) >=3D 0) {
- 		if (tb[IFLA_IF_NETNSID]) {
- 			netnsid =3D nla_get_s32(tb[IFLA_IF_NETNSID]);
- 			tgt_net =3D get_target_net(skb->sk, netnsid);
+ 		if (tb[IFLA_TARGET_NETNSID]) {
+ 			netnsid =3D nla_get_s32(tb[IFLA_TARGET_NETNSID]);
+ 			tgt_net =3D rtnl_get_net_ns_capable(skb->sk, netnsid);
 -			if (IS_ERR(tgt_net)) {
 -				tgt_net =3D net;
 -				netnsid =3D -1;
 -			}
 +			if (IS_ERR(tgt_net))
 +				return PTR_ERR(tgt_net);
  		}
 =20
  		if (tb[IFLA_EXT_MASK])

--Sig_/V2B6/bIfgaVfl3eLXzZ7FVW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu0JtwACgkQAVBC80lX
0GzD6wf/e/ZFdNJeRV3wQHxLKUEu9DZcPQL2eSdv26+6HqGK9MZoI93Xx0mIVmLX
IG9NBCUR1BBbSMbGD2bxmv91T0k3ib+EnU6Lq8sbXDSKhoyGgRsPvA0882L7sJQu
o+PYJqA1gDap58VdarCpJd+pizLQ8/7GUEz18fbUSnDWy2tt+zqh3S/n6StCYijh
lt05lWYG0O3lyy5XXONItJH5UfRTLHGpuMfgrzBAyHKfQusEHi38zW3mJDG6SsS4
QCfQDOUicWdWsbWW3zajUmloeKr5zTYm79w4nqVHwIa+YXZclHvxhzSRrtteEIar
RL/WfJai7alBVpki9XM+PLZGrZCUGA==
=JSwx
-----END PGP SIGNATURE-----

--Sig_/V2B6/bIfgaVfl3eLXzZ7FVW--
