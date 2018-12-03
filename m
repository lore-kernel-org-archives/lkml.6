Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78C7C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 01:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6001208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 01:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="k++RHfa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6001208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbeLCBur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 20:50:47 -0500
Received: from ozlabs.org ([203.11.71.1]:41851 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbeLCBur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 20:50:47 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 437Scy2tyGz9s55;
        Mon,  3 Dec 2018 12:50:41 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543801842;
        bh=HSq1ryeJAoIH3GCHiQ8JjHGjp094ipsVRYEWAJSq/KY=;
        h=Date:From:To:Cc:Subject:From;
        b=k++RHfa53gxuIKIMhAqre0J/NDh+cmiynnlhxLzFlV3qOi7Z6jCcO1EP4oSTvUZ11
         JtKGk+p1iLOAH2jAlH1iCWjPeM/9nE6HUoWXvIz2cI9ubha1AFBodb1sfzzOHFlWuI
         zpU7kvmXXBaZUKw9gXxqx3F7cqBMW4ZdAstMI8oW9lomQQi5Bq0zx31rVHBdIHG4tj
         V3rHjK8rMBUpIrTpWx7jPmUVypmT4IG8aIPptY8vbVp7FA3MXnZZ9d3BtF7GFj/vCo
         meiNkJP4Ii+4RNGDWIY5T52QDNrV0G8XRm9dEb9uhWibJKGBNotpl8hv9NDXyyCFPJ
         b11KM+mc8ks3w==
Date:   Mon, 3 Dec 2018 12:50:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hurley <john.hurley@netronome.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20181203125041.43c7cc9e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Um9+JVZzR5Tzltt1Un+xbg2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Um9+JVZzR5Tzltt1Un+xbg2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/netronome/nfp/flower/offload.c

between commits:

  b5f0cf083400 ("nfp: flower: prevent offload if rhashtable insert fails")

from the net tree and commit:

  7885b4fc8d8e ("nfp: flower: allow non repr netdev offload")

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

diff --cc drivers/net/ethernet/netronome/nfp/flower/offload.c
index 2f49eb75f3cc,545d94168874..000000000000
--- a/drivers/net/ethernet/netronome/nfp/flower/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/offload.c
@@@ -480,14 -469,10 +464,15 @@@ nfp_flower_add_offload(struct nfp_app *
  	err =3D rhashtable_insert_fast(&priv->flow_table, &flow_pay->fl_node,
  				     nfp_flower_table_params);
  	if (err)
 -		goto err_destroy_flow;
 +		goto err_release_metadata;
 +
- 	err =3D nfp_flower_xmit_flow(netdev, flow_pay,
++	err =3D nfp_flower_xmit_flow(app, flow_pay,
 +				   NFP_FLOWER_CMSG_TYPE_FLOW_ADD);
 +	if (err)
 +		goto err_remove_rhash;
 =20
- 	port->tc_offload_cnt++;
+ 	if (port)
+ 		port->tc_offload_cnt++;
 =20
  	/* Deallocate flow payload when flower rule has been destroyed. */
  	kfree(key_layer);

--Sig_/Um9+JVZzR5Tzltt1Un+xbg2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwEi/EACgkQAVBC80lX
0GzCTQf/WWTJ7sL324fQtSAMk+FGpwXtFSOstSYA4eMAvcel3lFL2+33p/+a35VJ
LCYN7dLwbrudXvk40RJiButA1Kjg894lN3/kixodznHyiuUNf951ASuLXWYpu0Sz
FbbRJaYt60IqdWTIviJM8Q33wPndSY5btFnyutQ2p/NVpUB6h8PI66j08HVRgjDI
nBA2218DbXEoWY15AcxPxRX9ypaW34+aGZEBRm/pwkxO7XmcIfngU6q/Ec8cmkio
VllA/ApYr+Xx02UTLwMZzQBB2dB6HHTeozgzrcZ2R85793dfCya0Jchk6y+atg2j
S9UogUv9g2yzk9HWUnDgN/wzNBpJFA==
=4/vs
-----END PGP SIGNATURE-----

--Sig_/Um9+JVZzR5Tzltt1Un+xbg2--
