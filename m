Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE320C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0415B21470
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="h6vIqlKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0415B21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbeHPCgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:36:08 -0400
Received: from ozlabs.org ([203.11.71.1]:41925 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbeHPCgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:36:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41rQwM1QXwz9s9J;
        Thu, 16 Aug 2018 09:41:38 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534376499;
        bh=nO25Wdn4gm5LBryXfFw9KvvzUupbE929e/3rFGI73HE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h6vIqlKZRZCd4VJFjDqfb0KJr8DbNquUkqnkh7tEakHLks7oLTNtb5ddqYvHRP4Eu
         QVfb05odsFjquuEyuH/Aie4r4+7YnQjwdaU+ZVsWJZfn4KDlKJZdWS+6Mfwe6CrUjx
         T0oJpxdmmknZq4RD9LB67bbVqHeDc0QSunDlap4bpfEu6s6EGMlt/XXEiEmRDFCiHY
         MbFEW2+/C3Z+wjYH/eEug+UynnL7EhaZH2rNF1rkqiUEjZ5Ui4u19UL5DbCpfTJhCt
         zIj3A6A98PeVNcLrDZLB7Uep8ekJdzM78veA8OyRYLOEl2dCZ9pV58YE0Sr9iiOWzR
         R2Z5Iv7/UT0Mw==
Date:   Thu, 16 Aug 2018 09:41:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: Re: linux-next: manual merge of the net-next tree with the rdma
 tree
Message-ID: <20180816094122.5db6dc79@canb.auug.org.au>
In-Reply-To: <20180702102106.4ac2bd17@canb.auug.org.au>
References: <20180702102106.4ac2bd17@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/q5y.8tMXijdBNzeQesp0aZW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/q5y.8tMXijdBNzeQesp0aZW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 2 Jul 2018 10:21:06 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the net-next tree got a conflict in:
>=20
>   net/smc/smc_ib.c
>=20
> between commit:
>=20
>   ddb457c6993b ("net/smc: Replace ib_query_gid with rdma_get_gid_attr")
>=20
> from the rdma tree and commit:
>=20
>   be6a3f38ff2a ("net/smc: determine port attributes independent from pnet=
 table")
>=20
> from the net-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc net/smc/smc_ib.c
> index 74f29f814ec1,36de2fd76170..000000000000
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
> @@@ -144,6 -143,62 +144,66 @@@ out
>   	return rc;
>   }
>  =20
> + static int smc_ib_fill_gid_and_mac(struct smc_ib_device *smcibdev, u8 i=
bport)
> + {
>  -	struct ib_gid_attr gattr;
>  -	int rc;
>  -
>  -	rc =3D ib_query_gid(smcibdev->ibdev, ibport, 0,
>  -			  &smcibdev->gid[ibport - 1], &gattr);
>  -	if (rc || !gattr.ndev)
>  -		return -ENODEV;
> ++	const struct ib_gid_attr *gattr;
> ++	int rc =3D 0;
> +=20
>  -	memcpy(smcibdev->mac[ibport - 1], gattr.ndev->dev_addr, ETH_ALEN);
>  -	dev_put(gattr.ndev);
>  -	return 0;
> ++	gattr =3D rdma_get_gid_attr(smcibdev->ibdev, ibport, 0);
> ++	if (IS_ERR(gattr))
> ++		return PTR_ERR(gattr);
> ++	if (!gattr->ndev) {
> ++		rc =3D -ENODEV;
> ++		goto done;
> ++	}
> ++	smcibdev->gid[ibport - 1] =3D gattr->gid;
> ++	memcpy(smcibdev->mac[ibport - 1], gattr->ndev->dev_addr, ETH_ALEN);
> ++done:
> ++	rdma_put_gid_attr(gattr);
> ++	return rc;
> + }
> +=20
> + /* Create an identifier unique for this instance of SMC-R.
> +  * The MAC-address of the first active registered IB device
> +  * plus a random 2-byte number is used to create this identifier.
> +  * This name is delivered to the peer during connection initialization.
> +  */
> + static inline void smc_ib_define_local_systemid(struct smc_ib_device *s=
mcibdev,
> + 						u8 ibport)
> + {
> + 	memcpy(&local_systemid[2], &smcibdev->mac[ibport - 1],
> + 	       sizeof(smcibdev->mac[ibport - 1]));
> + 	get_random_bytes(&local_systemid[0], 2);
> + }
> +=20
> + bool smc_ib_port_active(struct smc_ib_device *smcibdev, u8 ibport)
> + {
> + 	return smcibdev->pattr[ibport - 1].state =3D=3D IB_PORT_ACTIVE;
> + }
> +=20
> + static int smc_ib_remember_port_attr(struct smc_ib_device *smcibdev, u8=
 ibport)
> + {
> + 	int rc;
> +=20
> + 	memset(&smcibdev->pattr[ibport - 1], 0,
> + 	       sizeof(smcibdev->pattr[ibport - 1]));
> + 	rc =3D ib_query_port(smcibdev->ibdev, ibport,
> + 			   &smcibdev->pattr[ibport - 1]);
> + 	if (rc)
> + 		goto out;
> + 	/* the SMC protocol requires specification of the RoCE MAC address */
> + 	rc =3D smc_ib_fill_gid_and_mac(smcibdev, ibport);
> + 	if (rc)
> + 		goto out;
> + 	if (!strncmp(local_systemid, SMC_LOCAL_SYSTEMID_RESET,
> + 		     sizeof(local_systemid)) &&
> + 	    smc_ib_port_active(smcibdev, ibport))
> + 		/* create unique system identifier */
> + 		smc_ib_define_local_systemid(smcibdev, ibport);
> + out:
> + 	return rc;
> + }
> +=20
>   /* process context wrapper for might_sleep smc_ib_remember_port_attr */
>   static void smc_ib_port_event_work(struct work_struct *work)
>   {

This is now a conflict between Linus' tree and the rdma tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/q5y.8tMXijdBNzeQesp0aZW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt0uiIACgkQAVBC80lX
0GxrsAf/WYpGh9nOZoybrY2Q54eit8JEsojF5K9BV25Z/HswXe11KYLpHMeDWYXu
WY+TpOTQUFSQIjujOs02zR99s4I6y/cNNz8p28tfl1Nzy/pzuBIqnhzjOr0oEW0A
PfKeP78uBNDoXREhl0XTdU8So2BmAbgBaLf0OUZJzZjnB5I05+N30lVYGtaEGmb7
807LYa4ZnddS9laa/CvET75h+RyNvY0rdeIO8CUbD7uectAU7LCn+ZSBMO7TKPDt
CtEjws5rG/lNt/mhlX0xAYm8YU/MPZnL25xVh57kR0I60Wmzwf/iIwH4r5mWgrdj
j7SxgcxBUdhbWKRJpcMEFopwtqVWIQ==
=XUla
-----END PGP SIGNATURE-----

--Sig_/q5y.8tMXijdBNzeQesp0aZW--
