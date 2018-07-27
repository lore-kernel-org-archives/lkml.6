Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0EAC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6942088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gbNiPA+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6942088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbeG0G3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 02:29:12 -0400
Received: from ozlabs.org ([203.11.71.1]:43355 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbeG0G3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 02:29:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41cH7M47GNz9rxx;
        Fri, 27 Jul 2018 15:09:03 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532668144;
        bh=SKJkWgNC1Fc75VS5loPDYIvdqks9y+mMLdTWGnpe4xo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gbNiPA+C7YCXqsknXLrnwtkeVJlLqYFN+67J7BQ8mGW4zGW6UiUuTY+a9DgZ06oGk
         QVFYTzmbk3P5kZXFYFGcDZHNCdoiMFBLfXzve9sVlVDxMNbqYd8Th89p62qwFFawyC
         RL0PTzULQ1kBzwasi7CNgSRa+xeLANt0yxZS6GiLSXeBzvWQUNk1qKyPpZuQ3NJ5d1
         NwKoyICzq2I1mXyGM/jKQX+MYrI79BwUGqW4k5MTp8ACrjzuCuREmrB6qbAASakG1w
         PHfeCKt4W2/lKkjwOij63RIH6iQRkJgKpzL5iajHuZeJbfnpQwGIYgiZ/LpvbrEYhT
         bl4urBp7xC1ig==
Date:   Fri, 27 Jul 2018 15:09:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: linux-next: manual merge of the net-next tree with the rdma
 tree
Message-ID: <20180727150903.0f2816ba@canb.auug.org.au>
In-Reply-To: <VI1PR0502MB3008702AFA64F44DE57DC9F5D12A0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <20180727123301.3ac97ddc@canb.auug.org.au>
        <20180727024832.GA30023@mellanox.com>
        <20180727132847.2be8563b@canb.auug.org.au>
        <VI1PR0502MB3008702AFA64F44DE57DC9F5D12A0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ag3SSCB8sRIv52EdCbiJq_m"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ag3SSCB8sRIv52EdCbiJq_m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Parav,

On Fri, 27 Jul 2018 04:57:41 +0000 Parav Pandit <parav@mellanox.com> wrote:
>
> >  	for (i =3D 0; i < smcibdev->pattr[ibport - 1].gid_tbl_len; i++) {
> > -		memset(&_gid, 0, SMC_GID_SIZE);
> > -		memset(&gattr, 0, sizeof(gattr));
> > -		if (ib_query_gid(smcibdev->ibdev, ibport, i, &_gid, &gattr))
> > +		gattr =3D rdma_get_gid_attr(smcibdev->ibdev, ibport, i);
> > +		if (IS_ERR(gattr))
> >  			continue;
> > -		if (!gattr.ndev)
> > +		if (!gattr->ndev)
> >  			continue; =20
> This requires a small fix.
> If (!gattr->ndev {
> 	rdma_put_gid_attr(gattr);
> 	continue;
> }

Thanks, I have fixed this up for Monday.
--=20
Cheers,
Stephen Rothwell

--Sig_/ag3SSCB8sRIv52EdCbiJq_m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltaqO8ACgkQAVBC80lX
0Gxj2gf/cGH4xP5XiC5RN6dQEw44mUZPC9/9aOF2QhcWj/6AmlFYWqdYzqKtlKhg
UiwaQ0uYQhxYbmbJr4/nvuwemDwwF1H2RmoWBvgxTJIBtjnI1kQm02aKm8ikwYoP
RkSHlmi9+CESZQ2hFDMs09nD9hZIk1GxVwPZ0XAUQJa4n6emcThqoanEvOeCb00B
IiA0gS5ETYF6KBxXpTzWHQVtR9sUmBt7927jy2AwsBKBJHTahEO4oOFJrmYZVuBJ
naa4Fa4zCpzj3f1gwHhxRf9UONYPqIMIcX7P1IlfCaKASuFIRJrbhPehpqvLDD6F
QurSJ3XodiwHbsvCXHiA8xzYdmx5IA==
=2BXY
-----END PGP SIGNATURE-----

--Sig_/ag3SSCB8sRIv52EdCbiJq_m--
