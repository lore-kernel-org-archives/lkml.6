Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDD3C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F6320673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lj9a+yEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F6320673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbeG0FFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 01:05:18 -0400
Received: from ozlabs.org ([203.11.71.1]:53713 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbeG0FFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 01:05:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41cFGs1lBWz9ryl;
        Fri, 27 Jul 2018 13:45:25 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532663125;
        bh=fxhZu2Anm62TG1XNOIQPzKXI9shpPG57O9m9bL05Shg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lj9a+yEexS+DOV8fyq4uuPMiilD0aEREH7CFqq/KNs+GC9hnmjqYq9yuiXoJXSRcJ
         wEIECGIayj6IFVSH3m6tjXEeqgweA5BumljrD+wYAWkMkCLIfy6OreD4odE1K9gVv8
         cPfgp7uXkMQvROEjf2LkKW45Umk0yXVVOokLaiZ6VxceLKWGHND1Y4qsy7SDFiuNKh
         seaGhZzfhi2P3rmH+XDIdXd+LEMjvKwm0AmWNINYv9zOeGC7PXok3w8Eemk9A4uJNk
         XM83B8hf1aLne8UZ+P1lPJuW5aKXUV4TjIvDIlnfu2zSt1jP7n6Fld44ErHbiFDa/W
         LeTxDjA6RNaKQ==
Date:   Fri, 27 Jul 2018 13:45:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: Re: linux-next: manual merge of the net-next tree with the rdma
 tree
Message-ID: <20180727134524.366e9425@canb.auug.org.au>
In-Reply-To: <20180727132847.2be8563b@canb.auug.org.au>
References: <20180727123301.3ac97ddc@canb.auug.org.au>
        <20180727024832.GA30023@mellanox.com>
        <20180727132847.2be8563b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//JysvMrjrjYAf5O1w89sKoR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//JysvMrjrjYAf5O1w89sKoR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 27 Jul 2018 13:28:47 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> I applied this merge fix patch:

The final conflict resolution actually looks like this:

(the rdma tree changes to net/smc/smc_core.c are dropped)

c1d4bb2af93573ee4a21538a1a97b568a2344499
diff --cc net/smc/smc_ib.c
index 74f29f814ec1,2cc64bc8ae20..debc6e44f738
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@@ -144,6 -142,93 +143,95 @@@ out
  	return rc;
  }
 =20
+ static int smc_ib_fill_mac(struct smc_ib_device *smcibdev, u8 ibport)
+ {
 -	struct ib_gid_attr gattr;
 -	union ib_gid gid;
 -	int rc;
++	const struct ib_gid_attr *gattr;
++	int rc =3D 0;
+=20
 -	rc =3D ib_query_gid(smcibdev->ibdev, ibport, 0, &gid, &gattr);
 -	if (rc || !gattr.ndev)
 -		return -ENODEV;
++	gattr =3D rdma_get_gid_attr(smcibdev->ibdev, ibport, 0);
++	if (IS_ERR(gattr))
++		return PTR_ERR(gattr);
++	if (!gattr->ndev) {
++		rc =3D -ENODEV;
++		goto done;
++	}
+=20
 -	memcpy(smcibdev->mac[ibport - 1], gattr.ndev->dev_addr, ETH_ALEN);
 -	dev_put(gattr.ndev);
 -	return 0;
++	memcpy(smcibdev->mac[ibport - 1], gattr->ndev->dev_addr, ETH_ALEN);
++done:
++	rdma_put_gid_attr(gattr);
++	return rc;
+ }
+=20
+ /* Create an identifier unique for this instance of SMC-R.
+  * The MAC-address of the first active registered IB device
+  * plus a random 2-byte number is used to create this identifier.
+  * This name is delivered to the peer during connection initialization.
+  */
+ static inline void smc_ib_define_local_systemid(struct smc_ib_device *smc=
ibdev,
+ 						u8 ibport)
+ {
+ 	memcpy(&local_systemid[2], &smcibdev->mac[ibport - 1],
+ 	       sizeof(smcibdev->mac[ibport - 1]));
+ 	get_random_bytes(&local_systemid[0], 2);
+ }
+=20
+ bool smc_ib_port_active(struct smc_ib_device *smcibdev, u8 ibport)
+ {
+ 	return smcibdev->pattr[ibport - 1].state =3D=3D IB_PORT_ACTIVE;
+ }
+=20
+ /* determine the gid for an ib-device port and vlan id */
+ int smc_ib_determine_gid(struct smc_ib_device *smcibdev, u8 ibport,
+ 			 unsigned short vlan_id, u8 gid[], u8 *sgid_index)
+ {
 -	struct ib_gid_attr gattr;
 -	union ib_gid _gid;
++	const struct ib_gid_attr *gattr;
+ 	int i;
+=20
+ 	for (i =3D 0; i < smcibdev->pattr[ibport - 1].gid_tbl_len; i++) {
 -		memset(&_gid, 0, SMC_GID_SIZE);
 -		memset(&gattr, 0, sizeof(gattr));
 -		if (ib_query_gid(smcibdev->ibdev, ibport, i, &_gid, &gattr))
++		gattr =3D rdma_get_gid_attr(smcibdev->ibdev, ibport, i);
++		if (IS_ERR(gattr))
+ 			continue;
 -		if (!gattr.ndev)
++		if (!gattr->ndev)
+ 			continue;
 -		if (((!vlan_id && !is_vlan_dev(gattr.ndev)) ||
 -		     (vlan_id && is_vlan_dev(gattr.ndev) &&
 -		      vlan_dev_vlan_id(gattr.ndev) =3D=3D vlan_id)) &&
 -		    gattr.gid_type =3D=3D IB_GID_TYPE_IB) {
++		if (((!vlan_id && !is_vlan_dev(gattr->ndev)) ||
++		     (vlan_id && is_vlan_dev(gattr->ndev) &&
++		      vlan_dev_vlan_id(gattr->ndev) =3D=3D vlan_id)) &&
++		    gattr->gid_type =3D=3D IB_GID_TYPE_IB) {
+ 			if (gid)
 -				memcpy(gid, &_gid, SMC_GID_SIZE);
++				memcpy(gid, &gattr->gid, SMC_GID_SIZE);
+ 			if (sgid_index)
+ 				*sgid_index =3D i;
 -			dev_put(gattr.ndev);
++			rdma_put_gid_attr(gattr);
+ 			return 0;
+ 		}
 -		dev_put(gattr.ndev);
++		rdma_put_gid_attr(gattr);
+ 	}
+ 	return -ENODEV;
+ }
+=20
+ static int smc_ib_remember_port_attr(struct smc_ib_device *smcibdev, u8 i=
bport)
+ {
+ 	int rc;
+=20
+ 	memset(&smcibdev->pattr[ibport - 1], 0,
+ 	       sizeof(smcibdev->pattr[ibport - 1]));
+ 	rc =3D ib_query_port(smcibdev->ibdev, ibport,
+ 			   &smcibdev->pattr[ibport - 1]);
+ 	if (rc)
+ 		goto out;
+ 	/* the SMC protocol requires specification of the RoCE MAC address */
+ 	rc =3D smc_ib_fill_mac(smcibdev, ibport);
+ 	if (rc)
+ 		goto out;
+ 	if (!strncmp(local_systemid, SMC_LOCAL_SYSTEMID_RESET,
+ 		     sizeof(local_systemid)) &&
+ 	    smc_ib_port_active(smcibdev, ibport))
+ 		/* create unique system identifier */
+ 		smc_ib_define_local_systemid(smcibdev, ibport);
+ out:
+ 	return rc;
+ }
+=20
  /* process context wrapper for might_sleep smc_ib_remember_port_attr */
  static void smc_ib_port_event_work(struct work_struct *work)
  {

--=20
Cheers,
Stephen Rothwell

--Sig_//JysvMrjrjYAf5O1w89sKoR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltalVQACgkQAVBC80lX
0GxPMQf/UnQUGwWvvUmQorXHjtr+gZQhUyGOaJUY2QKO22tm72NN09qYxzcgjKjc
TTj4eV1dcRLaBH84ybJo55MWpdogI3/vAl3xPeZGw3SsgEQotZ7Q94mzehTCaiDu
StsEVeuB7w8dBIPHK3vI+ODLCoaJe79b8JZHPiHbJzjYKo0p29dfOJ+u2Dm8/UZJ
ufz9rQXUiQkstF6uD3rfuTy6CNg8IXPsyQAuvzvrpPI8UWJeH3EWAzE1wMLxJhgp
jVAIDe3dR1jGHg4FnnpzH7H3nVFjtqwOTln/pu7zey1Z7RxN0xowH+u/VE730f0G
nqHA2DHEjq3bXcE/gUJByh5nlzk3wg==
=gm3y
-----END PGP SIGNATURE-----

--Sig_//JysvMrjrjYAf5O1w89sKoR--
