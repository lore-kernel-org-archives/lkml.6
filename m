Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117D2C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDBB20863
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EjwWJqM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfBLAX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:23:27 -0500
Received: from ozlabs.org ([203.11.71.1]:34397 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727463AbfBLAX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:23:27 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43z3KR0Rz9z9s5c;
        Tue, 12 Feb 2019 11:23:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549931003;
        bh=qlM93sVZk3wnUMW9imvkqyzILREiioS1W3X/UHQfoWI=;
        h=Date:From:To:Cc:Subject:From;
        b=EjwWJqM0YXEmspcwDoHiOG1RX0mInAe6mIHc7gjDs93AZB2E4mVK4ZQ0yQUT5CriA
         a9iZ0tR95eQwelaDWEjABVztSfy+sSmY8k3ckLZ11eG45cvLOIRlzrnBkFfhG3E5DN
         RHUiMnc3gXlaYdox0ZYA3aC2YEA3UlRS/YwesJQ5y1vkq0cnrWoa90EGPklKV815Xo
         /g3V7TX/p/g5BTCXu4PqstSOY7s2W/ys654r8Wc3JswaC8oTejELfxJeXp+etX1GqF
         KWeM61pogKXUDBuSZw7jLi2QLJkm+XExBjMPc65Fi3EzgeOSN1CWk0HbUCqXGV3mDr
         vz/rZc1RqDSrw==
Date:   Tue, 12 Feb 2019 11:23:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20190212112320.0996efa7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YbkeD63/IR2nkraSiaXS+k/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YbkeD63/IR2nkraSiaXS+k/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got conflicts in:

  net/ipv4/netfilter/nf_nat_l3proto_ipv4.c
  net/ipv6/netfilter/nf_nat_l3proto_ipv6.c

between commit:

  8303b7e8f018 ("netfilter: nat: fix spurious connection timeouts")

from the net tree and commit:

  303e0c558959 ("netfilter: conntrack: avoid unneeded nf_conntrack_l4proto =
lookups")

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

diff --cc net/ipv4/netfilter/nf_nat_l3proto_ipv4.c
index fa2ba7c500e4,e26165af45cb..000000000000
--- a/net/ipv4/netfilter/nf_nat_l3proto_ipv4.c
+++ b/net/ipv4/netfilter/nf_nat_l3proto_ipv4.c
@@@ -214,8 -214,7 +214,8 @@@ int nf_nat_icmp_reply_translation(struc
  	}
 =20
  	/* Change outer to look like the reply to an incoming packet */
- 	nf_ct_invert_tuplepr(&target, &ct->tuplehash[!dir].tuple);
+ 	nf_ct_invert_tuple(&target, &ct->tuplehash[!dir].tuple);
 +	target.dst.protonum =3D IPPROTO_ICMP;
  	if (!nf_nat_ipv4_manip_pkt(skb, 0, &target, manip))
  		return 0;
 =20
diff --cc net/ipv6/netfilter/nf_nat_l3proto_ipv6.c
index 7a41ee3c11b4,9c914db44bec..000000000000
--- a/net/ipv6/netfilter/nf_nat_l3proto_ipv6.c
+++ b/net/ipv6/netfilter/nf_nat_l3proto_ipv6.c
@@@ -225,8 -225,7 +225,8 @@@ int nf_nat_icmpv6_reply_translation(str
  						     skb->len - hdrlen, 0));
  	}
 =20
- 	nf_ct_invert_tuplepr(&target, &ct->tuplehash[!dir].tuple);
+ 	nf_ct_invert_tuple(&target, &ct->tuplehash[!dir].tuple);
 +	target.dst.protonum =3D IPPROTO_ICMPV6;
  	if (!nf_nat_ipv6_manip_pkt(skb, 0, &target, manip))
  		return 0;
 =20

--Sig_/YbkeD63/IR2nkraSiaXS+k/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxiEfgACgkQAVBC80lX
0GxzNgf+PirhJ6pPEHvtapZE94AYU1Fj7a/ennZKjC239GpoG9nxN+6Zwr0ee/qD
hf9ie8vkYtroxApeWNzoXMpefPTxNfWykXRrVIompckrjajmBBtCQWqEtIXrouTi
2riHBXdL2r3HCdF4RCapqEuxX305Ra4jq47qqpVxxlPCpx+2LcXozSo5WLRx8l5j
eYXcA8mQWedH9UiV7iROCjDqujaxAcirPICGo2YgFCzxg10XtpPp7PP/fWOfQPuE
FUqsLb1+56iyj/aFvBFvyXPUR2bGLEyetbOCf098vINWPsheQ+dbTmLK3XMKBmKp
RFzYAtWvd3LcXAvafQCTGYQnmZ55Zw==
=ullt
-----END PGP SIGNATURE-----

--Sig_/YbkeD63/IR2nkraSiaXS+k/--
