Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D48ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796482075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SOnv+ubo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796482075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbeGRCEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:04:44 -0400
Received: from ozlabs.org ([203.11.71.1]:39933 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730614AbeGRCEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:04:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Vfgy5RPXz9s0w;
        Wed, 18 Jul 2018 11:29:18 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531877361;
        bh=eTvxUoch7mIQM+WmnHKvWCSV99Px3NIrEncpxC1fn4s=;
        h=Date:From:To:Cc:Subject:From;
        b=SOnv+uboKeJSAufG7yO38S4njsmzVMj4dkMXMUSEYhho3G/nfW9xPJuy7D6Y0DZva
         dU55BDTKdGh/PIaN7ucbyhYSklRy+WdEV2eyMssn02jjCXanQ7w4ryRqkla1+FPuRR
         6mpzlMZPRnBycG+lFu0YO+tC3Xtrzgupc0QWnL3amyxq/z7OVK/gHXoDaQhT6Rjt6h
         OvFUElLHCZQ3nO9XhFvLKsuIGc4gxi42uG51/ATsx59o5ylhanaVDaSllRNVborXo1
         Tg8BAnUVUUFC+JneDrzXUqEEFECBPHHbtEk1rJCeE8EQAvgLrzBz9tPPH+okd8v1PC
         65RJERrxdMM/Q==
Date:   Wed, 18 Jul 2018 11:28:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Westphal <fw@strlen.de>
Subject: linux-next: manual merge of the netfilter-next tree with the net
 tree
Message-ID: <20180718112853.6abca6f2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/V_RE9HVP16QSLnzQbLQwU91"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/V_RE9HVP16QSLnzQbLQwU91
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the netfilter-next tree got a conflict in:

  include/net/netfilter/nf_tables_core.h

between commit:

  e240cd0df481 ("netfilter: nf_tables: place all set backends in one single=
 module")

from the net tree and commit:

  da8f7d227adc ("netfilter: nf_tables: handle meta/lookup with direct call")

from the netfilter-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/net/netfilter/nf_tables_core.h
index a05134507e7b,0096f65096b5..000000000000
--- a/include/net/netfilter/nf_tables_core.h
+++ b/include/net/netfilter/nf_tables_core.h
@@@ -65,10 -65,11 +65,17 @@@ extern const struct nft_expr_ops nft_pa
  extern struct static_key_false nft_counters_enabled;
  extern struct static_key_false nft_trace_enabled;
 =20
 +extern struct nft_set_type nft_set_rhash_type;
 +extern struct nft_set_type nft_set_hash_type;
 +extern struct nft_set_type nft_set_hash_fast_type;
 +extern struct nft_set_type nft_set_rbtree_type;
 +extern struct nft_set_type nft_set_bitmap_type;
 +
+ struct nft_expr;
+ struct nft_regs;
+ struct nft_pktinfo;
+ void nft_meta_get_eval(const struct nft_expr *expr,
+ 		       struct nft_regs *regs, const struct nft_pktinfo *pkt);
+ void nft_lookup_eval(const struct nft_expr *expr,
+ 		     struct nft_regs *regs, const struct nft_pktinfo *pkt);
  #endif /* _NET_NF_TABLES_CORE_H */

--Sig_/V_RE9HVP16QSLnzQbLQwU91
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltOl9UACgkQAVBC80lX
0GxjeQf9HZlBEGIbKTOJvj/a0hjYbtv/ZWRp0NK40hBOwvIeG4piq571ogqHmeFU
Mh/FPPluqhV5VH53EOCKCzSsaJ3ASBAar6O8PninCeQtp0+ZpA4M2ICtkwzSyStt
odzN7ekGVAJZ/aIdMQXq8hJRuBgEXA9a+UrF4sFxEjge5tnA2Kko16ZoDaRx75Yb
pW2Sk8ZhAZW0KntVFBb2gbx2sxujvbyEq8kMbG82KRhq3oioGo/5qCCmm2avy4X0
QwEGB0K4t4G5nf71fHb7ziRWfdtGeOaHWfwWACrwuvZxRL/iNmWWilAs+5WBfL0A
VmOu0ZsNwp6rth9u5iqBWx9s4DJqeA==
=d2fY
-----END PGP SIGNATURE-----

--Sig_/V_RE9HVP16QSLnzQbLQwU91--
