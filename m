Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F42C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 01:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8C5208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 01:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="r1RunYAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8C5208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933501AbeGIBED (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 21:04:03 -0400
Received: from ozlabs.org ([203.11.71.1]:39811 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933286AbeGIBEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 21:04:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41P6Xv3v1Rz9s01;
        Mon,  9 Jul 2018 11:03:59 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531098239;
        bh=cH8fyMABF98tCJkiB10vd2RUnIhT+AGcJMMjL8gbqM0=;
        h=Date:From:To:Cc:Subject:From;
        b=r1RunYAhS/uQ+0kniBILIbN8VzlD8kN+TbwZT/m2PvVJ+lIfv0QHqBTBSBkYJPzCr
         CY56jkcyuTE3thrCqkyFc/u7iZifrBN6OLQ/SEQ8jlps/qdA5sLVwiBwyCYsrrVUaG
         OtzVfyqJtrD01BN5CFd3cwbdlxj/5oAWQYBEVGNyaYzbbRjVe6HKRAwxHuQ+1fB0Cx
         izCDzCR62jQcWEZOwW44cz76I+Vd0eEQNi+4GhNaj9iBgwbrPki2bfXzfMA0/FKNLd
         uASY/CJH1LzXIkq5/7B/T9l2cqE68VgH6Rw9yKr9cDbeaaF3g9sOkgo53whoajL9fA
         Qgp22LVE4kSpQ==
Date:   Mon, 9 Jul 2018 11:03:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davide Caratti <dcaratti@redhat.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180709110358.338e5113@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9PpNYWlCsVIL+lh_In2gPfm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9PpNYWlCsVIL+lh_In2gPfm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/sched/act_tunnel_key.c

between commit:

  38230a3e0e09 ("net/sched: act_tunnel_key: fix NULL dereference when 'goto=
 chain' is used")

from the net tree and commit:

  036bb44327f5 ("net: sched: change type of reference and bind counters")

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

diff --cc net/sched/act_tunnel_key.c
index 9bc6c2ae98a5,3ec585d58762..000000000000
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@@ -252,9 -477,8 +477,9 @@@ static int tunnel_key_dump(struct sk_bu
  	struct tcf_tunnel_key_params *params;
  	struct tc_tunnel_key opt =3D {
  		.index    =3D t->tcf_index,
- 		.refcnt   =3D t->tcf_refcnt - ref,
- 		.bindcnt  =3D t->tcf_bindcnt - bind,
+ 		.refcnt   =3D refcount_read(&t->tcf_refcnt) - ref,
+ 		.bindcnt  =3D atomic_read(&t->tcf_bindcnt) - bind,
 +		.action   =3D t->tcf_action,
  	};
  	struct tcf_t tm;
 =20

--Sig_/9PpNYWlCsVIL+lh_In2gPfm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltCtH4ACgkQAVBC80lX
0Gx3BwgAi4vk3GYrxETkRJFC4YltgXQX5XuXZRioXt26KtfPe9XkMPydt8yFykp1
B17hdMzT07CIyxXXh9yPrblVcOj9ASekjgd8UU2JVahH5w1JmybFGSOYWWmLtSs5
BjORfp/ZWOcaI7d8FHnrItlXI9ud+HQwJhIBeUDmYPrInqXGEKPpIg+bSIXCvAAE
mcd+in8o0DytVwbPdzbJXMQ+8bmS7AMGSf5U/8xEnoiFAc8x9NEsro+CgojElnqO
gDkV/+i6x6qcy3MbYA2QYqcAo5a1OcsJnwHXyCmMtRzZzTIMIXaEI/nHFcrSKRti
aIMAaHwTpJMgA2O7IL4ruT/dGUMeDQ==
=1VZg
-----END PGP SIGNATURE-----

--Sig_/9PpNYWlCsVIL+lh_In2gPfm--
