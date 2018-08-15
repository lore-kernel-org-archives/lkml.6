Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FD9C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3A9214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aKeAByYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3A9214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbeHPCkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:40:23 -0400
Received: from ozlabs.org ([203.11.71.1]:48481 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbeHPCkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:40:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41rR1C5G6pz9ryn;
        Thu, 16 Aug 2018 09:45:51 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534376752;
        bh=HEqVdWgkr+js1ES70zF3zuN4R1yfT9gfsjWysYct+mI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aKeAByYA0r7itnXvKQahFbbUMf7KRkaykLjNz6MOOUHZCXBadDYtBme9CsUSxOryH
         YMOPj3W2Wfm/yLtrLzgy5/rRglghayI1YKdFy7sprxvyASpGVkoXdEEv87nbXviV8M
         ua0tqj4TecEci9Rjggy6HBje12WoLquhwRNco7iGTtdWlmX2TY3zWlB8pGpnvhAi3O
         1cAK3znErY4Atf2Vwqxvp1tzDZ/VobBI5Axc43hScP2TRax8oMH0bOu7XoKDAoL34e
         eiBnSnyz1XX2+ATkCfb62GyUCjVUXB6YZpyLsQ17y4n5D3t9NsUFQ47P1UT1ORUhbq
         RTb5k9zKafcng==
Date:   Thu, 16 Aug 2018 09:45:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: linux-next: manual merge of the net-next tree with the rdma
 tree
Message-ID: <20180816094551.7854fd4d@canb.auug.org.au>
In-Reply-To: <20180802120503.7b7e116f@canb.auug.org.au>
References: <20180802120503.7b7e116f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zQy04OotBTucOsu16=5PMgH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zQy04OotBTucOsu16=5PMgH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 2 Aug 2018 12:05:03 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the net-next tree got a conflict in:
>=20
>   net/rds/ib_send.c
>=20
> between commit:
>=20
>   d34ac5cd3a73 ("RDMA, core and ULPs: Declare ib_post_send() and ib_post_=
recv() arguments const")
>=20
> from the rdma tree and commit:
>=20
>   87f70132b08e ("rds: remove redundant variable 'rds_ibdev'")
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
> diff --cc net/rds/ib_send.c
> index 8ac80c1b051e,c8dd3125d398..000000000000
> --- a/net/rds/ib_send.c
> +++ b/net/rds/ib_send.c
> @@@ -758,8 -758,7 +758,7 @@@ int rds_ib_xmit_atomic(struct rds_conne
>   {
>   	struct rds_ib_connection *ic =3D conn->c_transport_data;
>   	struct rds_ib_send_work *send =3D NULL;
>  -	struct ib_send_wr *failed_wr;
>  +	const struct ib_send_wr *failed_wr;
> - 	struct rds_ib_device *rds_ibdev;
>   	u32 pos;
>   	u32 work_alloc;
>   	int ret;

This is now a conflict between Linux' tree and the rdma tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/zQy04OotBTucOsu16=5PMgH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt0uy8ACgkQAVBC80lX
0GxFJQf9GrbW3g80f43zneyJAxEJSqEJw8U78QaHE0FZj54eUFzQb4zn2dpqNDiX
+gZevngvMnNORkcoYYepU/TBzxOK4AZxvanTe2snEcqkdwtDlnIOjG4l3XzGwq74
43bBhxN/yF/j0t6XdZHVUoBRSaWqF02CESdLKKCsgiQW9hjd7DSqVp7JvzHfruvE
m6e0rT9ymyn9rMCDodwHco4kQAt3lmK3xoHNAiugqB9t0kzEa+l5YhOV3YsMOTxW
9caDqffkyaIObwNJn+buXGC/F+/ttEpz6wiAzHkd74hMyUtfADIDZ2E4ecJifBwZ
BVKBqgukyacTM6ArzgW3qs/sL5KY9g==
=psXN
-----END PGP SIGNATURE-----

--Sig_/zQy04OotBTucOsu16=5PMgH--
