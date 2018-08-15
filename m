Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5658C46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6C5216F6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FmOkmrvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6C5216F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbeHOEdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 00:33:04 -0400
Received: from ozlabs.org ([203.11.71.1]:42315 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbeHOEdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 00:33:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41qsfx4GBJz9s8T;
        Wed, 15 Aug 2018 11:43:05 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534297386;
        bh=gcU5dFm1eKeTvjf+cB0G7vyubxF2FWvtpw9FPeGBPCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FmOkmrvxz9MKimrpi9fXCyPMp2NmOHqj+0mIoJRWx64C0JZx4HjRcLYaTg1bMyadc
         oTPq6ysle3zxdJfm9V767Nvza0yqNdak5Jn4/In7Ljc7JCXyMTgbmNBpYlb2zflocS
         EiYp1Emz+pnMXBN2x9dw+dLlxe3mpvDTeLo1iEtS0DH4uDJFuUTi9+Ybzj2/0DVP6s
         Ql4p9Uqhk1aSye1uAG1XOkZvEakdmzndXFqHgpEiR1Bnyh0EIHPjojmb1DkUeNb36J
         XuvVxil+nY6x9CmZbsqAaJPbdp8cFkJ4qLRxd1Z4dk+4vOUVzhQXwZPYbODjIp4I9R
         /q+Ggvkh6a+gg==
Date:   Wed, 15 Aug 2018 11:43:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Wise <swise@opengridcomputing.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: build failure after merge of the block tree
Message-ID: <20180815114303.685b1789@canb.auug.org.au>
In-Reply-To: <20180726145624.13a604ed@canb.auug.org.au>
References: <20180726145624.13a604ed@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vIDoGTdWW5ed7pS+zOHyQVZ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vIDoGTdWW5ed7pS+zOHyQVZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 26 Jul 2018 14:56:24 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the block tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/nvme/target/rdma.c: In function 'nvmet_rdma_find_get_device':
> drivers/nvme/target/rdma.c:894:26: error: 'struct ib_device_attr' has no =
member named 'max_sge'; did you mean 'max_cqe'?
>      cm_id->device->attrs.max_sge) - 1;
>                           ^
> drivers/nvme/target/rdma.c:893:21: note: in expansion of macro 'max'
>   inline_sge_count =3D max(cm_id->device->attrs.max_sge_rd,
>                      ^~~
> In file included from include/linux/list.h:9:0,
>                  from include/linux/module.h:9,
>                  from drivers/nvme/host/rdma.c:15:
> drivers/nvme/host/rdma.c: In function 'nvme_rdma_find_get_device':
> drivers/nvme/host/rdma.c:381:23: error: 'struct ib_device_attr' has no me=
mber named 'max_sge'; did you mean 'max_cqe'?
>       ndev->dev->attrs.max_sge - 1);
>                        ^
> drivers/nvme/host/rdma.c:380:30: note: in expansion of macro 'min'
>   ndev->num_inline_segments =3D min(NVME_RDMA_MAX_INLINE_SEGMENTS,
>                               ^~~
>=20
> Caused by commits
>=20
>   64a741c1eaa8 ("nvme-rdma: support up to 4 segments of inline data")
>   0d5ee2b2ab4f ("nvmet-rdma: support max(16KB, PAGE_SIZE) inline data")
>=20
> interacting with commit
>=20
>   33023fb85a42 ("IB/core: add max_send_sge and max_recv_sge attributes")
>=20
> from the rdma tree.
>=20
> I have applied the following merge fix patch for today:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 26 Jul 2018 14:32:15 +1000
> Subject: [PATCH] nvme-dma: merge fix up for replacement of max_sge
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/nvme/host/rdma.c   | 2 +-
>  drivers/nvme/target/rdma.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index cfa0319fcd1c..368fe5ac0c6b 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -378,7 +378,7 @@ nvme_rdma_find_get_device(struct rdma_cm_id *cm_id)
>  	}
> =20
>  	ndev->num_inline_segments =3D min(NVME_RDMA_MAX_INLINE_SEGMENTS,
> -					ndev->dev->attrs.max_sge - 1);
> +					ndev->dev->attrs.max_send_sge - 1);
>  	list_add(&ndev->entry, &device_list);
>  out_unlock:
>  	mutex_unlock(&device_list_mutex);
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 86121a7a19b2..8c30ac7d8078 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -891,7 +891,7 @@ nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
> =20
>  	inline_page_count =3D num_pages(port->inline_data_size);
>  	inline_sge_count =3D max(cm_id->device->attrs.max_sge_rd,
> -				cm_id->device->attrs.max_sge) - 1;
> +				cm_id->device->attrs.max_send_sge) - 1;
>  	if (inline_page_count > inline_sge_count) {
>  		pr_warn("inline_data_size %d cannot be supported by device %s. Reducin=
g to %lu.\n",
>  			port->inline_data_size, cm_id->device->name,
> --=20
> 2.18.0

This is now needed (with the max_send_sge -> max_recv_sge update in
drivers/nvme/target/rdma.c patch) when I merge the rdma tree with
Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/vIDoGTdWW5ed7pS+zOHyQVZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltzhScACgkQAVBC80lX
0GychQf/dqHMr+UL/drg6+TnENanCESJSaskwmcKgvscSabzZG3lQXj3PBb1Lca9
MkbaG8MSrMRDe7tRspzPNnsFIOShDsY3NhPRb3mqlak4f78uskFl0qNWn4rpXUx0
RO9umzHx1+n+sB1hUG94/2dvmr1SiBmw0zXH18ltEkUHsV3N9BK163TOtPweg411
VxxD6+CkcIGWVHesrkk5ZcX/hjVHOmSwZ7OHkpttLkTew7kcAvpqbknc8mJn6+2J
5J/o43fQ6+EmqkSLpw2jMP9nJzrpSKSZBtRpyc+zYdkJf/qWVwwR1Bb2CszUrLfb
OCC9LGI+YsKUVoBNtaqPwmnWIMkZ8w==
=7siD
-----END PGP SIGNATURE-----

--Sig_/vIDoGTdWW5ed7pS+zOHyQVZ--
