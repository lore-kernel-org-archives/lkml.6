Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56349C46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E42C216F6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lsEFZ2cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E42C216F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbeHOEfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 00:35:39 -0400
Received: from ozlabs.org ([203.11.71.1]:41841 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbeHOEfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 00:35:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41qsjw25H7z9sCS;
        Wed, 15 Aug 2018 11:45:40 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534297540;
        bh=yaq0LFSZy0+YO2v51E9av0N6IV9ES/E56CuWFllnEus=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lsEFZ2czVTw7HdWIJ8jVRgmga5ppie93bBYEqD6GTbB2WMLAQ/A51q6cpDtcu5Tzr
         aueKWu1V+PQ9jWf6Q1dOiiFzV8oW7wXzyGOf00NPynUdC+v4SD/8Y7Ucr/B+n4vrji
         cBxjggQsJCuv0VwymvChCATrsUXeqqXWmb/t7zhQgzHozrLzd+stfZr4EBJnppQUsK
         Lucv9ECSLOvfXYZnlJHxCFN7siKQTzpQhLWKqR0FhdrL7JvFXvX9Vp9Fh/Ptvh4bLh
         j6/W4DRw/QLRNCoKbr/ppPS90xTCWBLI6JcoRIO0TVzjvrIQU1p93Yp8vplbDctp9i
         YDGMA3ZmBt58g==
Date:   Wed, 15 Aug 2018 11:45:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the block tree with the rdma tree
Message-ID: <20180815114539.34e066e1@canb.auug.org.au>
In-Reply-To: <20180726135804.0257047e@canb.auug.org.au>
References: <20180726135804.0257047e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uGvrInghv6l22HbdGxyUkCh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uGvrInghv6l22HbdGxyUkCh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 26 Jul 2018 13:58:04 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the block tree got a conflict in:
>=20
>   drivers/nvme/target/rdma.c
>=20
> between commit:
>=20
>   23f96d1f15a7 ("nvmet-rdma: Simplify ib_post_(send|recv|srq_recv)() call=
s")
>   202093848cac ("nvmet-rdma: add an error flow for post_recv failures")
>=20
> from the rdma tree and commits:
>=20
>   2fc464e2162c ("nvmet-rdma: add unlikely check in the fast path")
>=20
> from the block tree.
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
> diff --cc drivers/nvme/target/rdma.c
> index 1a642e214a4c,e7f43d1e1779..000000000000
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@@ -382,13 -435,22 +435,21 @@@ static void nvmet_rdma_free_rsps(struc
>   static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
>   		struct nvmet_rdma_cmd *cmd)
>   {
>  -	struct ib_recv_wr *bad_wr;
> + 	int ret;
> +=20
>   	ib_dma_sync_single_for_device(ndev->device,
>   		cmd->sge[0].addr, cmd->sge[0].length,
>   		DMA_FROM_DEVICE);
>  =20
>   	if (ndev->srq)
> - 		return ib_post_srq_recv(ndev->srq, &cmd->wr, NULL);
> - 	return ib_post_recv(cmd->queue->cm_id->qp, &cmd->wr, NULL);
>  -		ret =3D ib_post_srq_recv(ndev->srq, &cmd->wr, &bad_wr);
> ++		ret =3D ib_post_srq_recv(ndev->srq, &cmd->wr, NULL);
> + 	else
>  -		ret =3D ib_post_recv(cmd->queue->cm_id->qp, &cmd->wr, &bad_wr);
> ++		ret =3D ib_post_recv(cmd->queue->cm_id->qp, &cmd->wr, NULL);
> +=20
> + 	if (unlikely(ret))
> + 		pr_err("post_recv cmd failed\n");
> +=20
> + 	return ret;
>   }
>  =20
>   static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *qu=
eue)
> @@@ -491,7 -553,7 +552,7 @@@ static void nvmet_rdma_queue_response(s
>   		rsp->send_sge.addr, rsp->send_sge.length,
>   		DMA_TO_DEVICE);
>  =20
> - 	if (ib_post_send(cm_id->qp, first_wr, NULL)) {
>  -	if (unlikely(ib_post_send(cm_id->qp, first_wr, &bad_wr))) {
> ++	if (unlikely(ib_post_send(cm_id->qp, first_wr, NULL))) {
>   		pr_err("sending cmd response failed\n");
>   		nvmet_rdma_release_rsp(rsp);
>   	}

This is now a conflict between Linus' tree and the rdma tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/uGvrInghv6l22HbdGxyUkCh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltzhcMACgkQAVBC80lX
0Gz5Twf/WTBitw/e7LzZv6VSBRZGzjVM1u6Z9lkiDtilGfxLVlZVb/TYCQ40liZ+
CmffmEIVejwXqC3SRQpByXBVUfELeXNJlHHBK6gWXt7uo63NSkqbCHY04fUM1I3n
cAoExhVg6Qggxf4xJ2Qs0hKxIam6Ms7RRqIGACcI93pGO9YbPvYy8To9EdBsx1x0
FTQpPOKvlkU9p0MZCZ6lYt1zCGiJcEsYsdVf7cGrRYI0gFdqsfVhVH00SxMrsLKd
+rJr1D5Ev7x04kg/7grU0qVZn0e5+pLFytIKvRCDSIBNYxj1S2RPorb+y7fVU8oH
8qK6xWqDBCMzp27ukRri+kU/ZeUgoQ==
=WcCg
-----END PGP SIGNATURE-----

--Sig_/uGvrInghv6l22HbdGxyUkCh--
