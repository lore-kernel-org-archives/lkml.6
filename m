Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AE1C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED45206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="j1HLp3eP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED45206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbeGZXfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 19:35:25 -0400
Received: from ozlabs.org ([203.11.71.1]:37419 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731857AbeGZXfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 19:35:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41c5zP0pbGz9s0R;
        Fri, 27 Jul 2018 08:16:33 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532643393;
        bh=Mmf+yNhDoaMwqlxnUeAa1F6eRH4UhINGyi4pX1vR5L8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j1HLp3ePYmonUJo1+iFSOP9drBBUzbDPMPzjmKNZY+slHcSTVwzWkhosHTrf+msBS
         LTW6qRvcEkmKPhClURCkypval8PAijEJtUrp6VW2SG1NbekqSE82k7+qrvnyB/2p31
         xdy/MvvZxSnHqhaEIDZ9nOeaHmSfzcOjV6cxNiHq5+OcMxWwd4O8pDzOq26LIhTC7k
         wXhYG4DZCF8sB7KHVcXQQ4zXJJRIljtQp7cgBUF0Bz5Mri5u+b9vQFwPJtAsDlHzaA
         LUjq/7XjjuaHYbwLRR5sSkppVo+/TyCV8M55E8ZXAuPZvgkq15F4XabBh3C0knFSTe
         KsjiAVF+b7PVA==
Date:   Fri, 27 Jul 2018 08:16:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Steve Wise" <swise@opengridcomputing.com>
Cc:     "'Jens Axboe'" <axboe@kernel.dk>,
        "'Doug Ledford'" <dledford@redhat.com>,
        "'Jason Gunthorpe'" <jgg@mellanox.com>,
        "'Linux-Next Mailing List'" <linux-next@vger.kernel.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        "'Christoph Hellwig'" <hch@lst.de>
Subject: Re: linux-next: build failure after merge of the block tree
Message-ID: <20180727081631.6ff269f3@canb.auug.org.au>
In-Reply-To: <011b01d424dc$b0a69820$11f3c860$@opengridcomputing.com>
References: <20180726145624.13a604ed@canb.auug.org.au>
        <011b01d424dc$b0a69820$11f3c860$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wt27Km8KLsVssy_rgxtCJoy"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wt27Km8KLsVssy_rgxtCJoy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Steve,

On Thu, 26 Jul 2018 07:32:16 -0500 "Steve Wise" <swise@opengridcomputing.co=
m> wrote:
>
> > diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> > index 86121a7a19b2..8c30ac7d8078 100644
> > --- a/drivers/nvme/target/rdma.c
> > +++ b/drivers/nvme/target/rdma.c
> > @@ -891,7 +891,7 @@ nvmet_rdma_find_get_device(struct rdma_cm_id
> > *cm_id)
> >=20
> >  	inline_page_count =3D num_pages(port->inline_data_size);
> >  	inline_sge_count =3D max(cm_id->device->attrs.max_sge_rd,
> > -				cm_id->device->attrs.max_sge) - 1;
> > +				cm_id->device->attrs.max_send_sge) - 1; =20
>=20
> This should actually be max_recv_sge.

Yeah, Christoph pointed that out as well.  I will correct it today.

Thanks
--=20
Cheers,
Stephen Rothwell

--Sig_/wt27Km8KLsVssy_rgxtCJoy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltaSD8ACgkQAVBC80lX
0Gzr7AgAg+5MfrWwP3KVTHw++7ts7KFnKaOxr6zNy+MsZbGDYFddVg6me5ACm2yX
87Q2uFRg78bk+eE7smqsWbn+iMJ+G6VhDXqJ+H/ZaW4R5A9LPtAO5mSi47oKB6rs
SvIk7Mh4yhbgbsDdxbUrmwAM72hLQJtAxspnrvAdelo49//RVHGJgA5cv+t8nWzo
c4YLntNOyZxrw1/uispe29f0xq2YablEYBUIiqYTl9hfNEdDQ8Vr3h0x7XjhraMN
FPlZNT0uVEfMF9F4lm3xer0igSsybx5I2tYl7dBV8D+vjRvTh2xgfM2QywOOeZoO
Q3aaqXaA576itEUJRrsdUuJIJ7/w5w==
=XlMQ
-----END PGP SIGNATURE-----

--Sig_/wt27Km8KLsVssy_rgxtCJoy--
