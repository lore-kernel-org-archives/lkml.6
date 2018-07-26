Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814E9C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADFB2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UaS6R9xs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADFB2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbeGZKB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:01:56 -0400
Received: from ozlabs.org ([203.11.71.1]:43915 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbeGZKB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:01:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41bm0D5gbhz9ryn;
        Thu, 26 Jul 2018 18:46:04 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532594765;
        bh=Y72KONttnfzs80Ub744twyfmq9p4lQR+3aWQ4q96OAg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UaS6R9xsjuClQXg3Ff5HP9y9NScGue0wYWpXasmobsq9FWOvzFivFqYRpmiYg1XjM
         thBZVfos32p2+8iji9SKjEHBcpEApcEnFfdllCWUFRUoUNivzF2fabODAGacR3YMOY
         gdv1/JRc5fbvdAx9d+ZoYZGiuBbYnf6Wtgzb6XL13P3JLcjXZchx/d/h6jLrReqm8f
         DgKF5rFDkfjrKSMHMxNLD4ysamBzjA56iajpLD/dfP5Qda3pY+rzybHmX4xdlfJDAY
         EftwUpeqN0Jfh8FSY+JfaMfxPXdZ0tB3FtYvtWFLMx8IxtHYdPCsiXDRluKYU7kwlT
         Ojwebuivbd9mQ==
Date:   Thu, 26 Jul 2018 18:45:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: linux-next: build failure after merge of the block tree
Message-ID: <20180726184547.67a3fc8e@canb.auug.org.au>
In-Reply-To: <20180726084833.GA23310@lst.de>
References: <20180726145624.13a604ed@canb.auug.org.au>
        <20180726084833.GA23310@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/70p9RtVLeQqjD+QhWGJrsdY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/70p9RtVLeQqjD+QhWGJrsdY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Thu, 26 Jul 2018 10:48:33 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jul 26, 2018 at 02:56:24PM +1000, Stephen Rothwell wrote:
> > diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> > index 86121a7a19b2..8c30ac7d8078 100644
> > --- a/drivers/nvme/target/rdma.c
> > +++ b/drivers/nvme/target/rdma.c
> > @@ -891,7 +891,7 @@ nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
> > =20
> >  	inline_page_count =3D num_pages(port->inline_data_size);
> >  	inline_sge_count =3D max(cm_id->device->attrs.max_sge_rd,
> > -				cm_id->device->attrs.max_sge) - 1;
> > +				cm_id->device->attrs.max_send_sge) - 1; =20
>=20
> This should be max_recv_sge.

Thanks, I will fix up my resolution for tomorrow.

--=20
Cheers,
Stephen Rothwell

--Sig_/70p9RtVLeQqjD+QhWGJrsdY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltZijsACgkQAVBC80lX
0GxAygf/XFg0MfBLbXfHngI2FwBMjRTkdEzxg+2C50gqm9q7Rp4+XEK7fBgKZEJ8
b8eifsulcO8JdjqJc7BzDMI25Us18AGoZAhzAFckj0w6VU1P1KcmOIOEzmg6G1CB
PEt0AbJ0c1lhQMUy1ZP5zu6SqJMHcledv9h2UwjdJOdXUvfIOH3oSFYfe97jzzrn
gtUgPuKvYT2NZ7+Hio5h03NhZyqnFpIuWrFgTaooG4UVbGbzdTEBw05Gid+Byz3p
cEQbrcEZvKoLL3OkMuRkAMnmUodWrkBOONdnBV7mjjJLvjyo/fFk+mcXcKZm000l
Xl1z2lMzi866pAwMn8snHqmLaveUug==
=GNdC
-----END PGP SIGNATURE-----

--Sig_/70p9RtVLeQqjD+QhWGJrsdY--
