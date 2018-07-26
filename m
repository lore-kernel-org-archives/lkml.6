Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF41C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795A72083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DKfA27sC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795A72083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbeGZGL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:11:29 -0400
Received: from ozlabs.org ([203.11.71.1]:42671 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbeGZGL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:11:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41bfvF1s8jz9ryl;
        Thu, 26 Jul 2018 14:56:25 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532580988;
        bh=M+kisdIpbgupTC8IIQzMV63/f0sMZLttkfU7CjTCip4=;
        h=Date:From:To:Cc:Subject:From;
        b=DKfA27sCPj1p0gWsJ8YVNsC9mGXxZ76YQysKsW77Qz1flaUkyGpLbwLrBNgm/rH5J
         hCRnX0oh9PA/SnQiyszPJA7uFeRvpYL6cSVcP6aX791tYbuXJbKzvdTLzK8+1BVfN0
         8EbjXadT5ofzQjndyxUW6fTmVL62KP6RmnzQHPXEPM63oUThxbxoQGg2wuzK6HqgOT
         HYhIYefBSS67jrpZQbeBDQMoOgnoF/uUpQPKh7hQG6vH+smvLbqtY9VtUzWGsiZzBm
         y9667VN1+5XqXYTB+gBun6TM1JkUthDWQlGpoHHRbzLspHtjLfjhVqNvnqHzWRFn/M
         90XZk+PTZHneg==
Date:   Thu, 26 Jul 2018 14:56:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Wise <swise@opengridcomputing.com>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20180726145624.13a604ed@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ah2dOQSZExKWY5aI/4O+/7H"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ah2dOQSZExKWY5aI/4O+/7H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/nvme/target/rdma.c: In function 'nvmet_rdma_find_get_device':
drivers/nvme/target/rdma.c:894:26: error: 'struct ib_device_attr' has no me=
mber named 'max_sge'; did you mean 'max_cqe'?
     cm_id->device->attrs.max_sge) - 1;
                          ^
drivers/nvme/target/rdma.c:893:21: note: in expansion of macro 'max'
  inline_sge_count =3D max(cm_id->device->attrs.max_sge_rd,
                     ^~~
In file included from include/linux/list.h:9:0,
                 from include/linux/module.h:9,
                 from drivers/nvme/host/rdma.c:15:
drivers/nvme/host/rdma.c: In function 'nvme_rdma_find_get_device':
drivers/nvme/host/rdma.c:381:23: error: 'struct ib_device_attr' has no memb=
er named 'max_sge'; did you mean 'max_cqe'?
      ndev->dev->attrs.max_sge - 1);
                       ^
drivers/nvme/host/rdma.c:380:30: note: in expansion of macro 'min'
  ndev->num_inline_segments =3D min(NVME_RDMA_MAX_INLINE_SEGMENTS,
                              ^~~

Caused by commits

  64a741c1eaa8 ("nvme-rdma: support up to 4 segments of inline data")
  0d5ee2b2ab4f ("nvmet-rdma: support max(16KB, PAGE_SIZE) inline data")

interacting with commit

  33023fb85a42 ("IB/core: add max_send_sge and max_recv_sge attributes")

from the rdma tree.

I have applied the following merge fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 26 Jul 2018 14:32:15 +1000
Subject: [PATCH] nvme-dma: merge fix up for replacement of max_sge

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/nvme/host/rdma.c   | 2 +-
 drivers/nvme/target/rdma.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cfa0319fcd1c..368fe5ac0c6b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -378,7 +378,7 @@ nvme_rdma_find_get_device(struct rdma_cm_id *cm_id)
 	}
=20
 	ndev->num_inline_segments =3D min(NVME_RDMA_MAX_INLINE_SEGMENTS,
-					ndev->dev->attrs.max_sge - 1);
+					ndev->dev->attrs.max_send_sge - 1);
 	list_add(&ndev->entry, &device_list);
 out_unlock:
 	mutex_unlock(&device_list_mutex);
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 86121a7a19b2..8c30ac7d8078 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -891,7 +891,7 @@ nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
=20
 	inline_page_count =3D num_pages(port->inline_data_size);
 	inline_sge_count =3D max(cm_id->device->attrs.max_sge_rd,
-				cm_id->device->attrs.max_sge) - 1;
+				cm_id->device->attrs.max_send_sge) - 1;
 	if (inline_page_count > inline_sge_count) {
 		pr_warn("inline_data_size %d cannot be supported by device %s. Reducing =
to %lu.\n",
 			port->inline_data_size, cm_id->device->name,
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/ah2dOQSZExKWY5aI/4O+/7H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltZVHgACgkQAVBC80lX
0GxQPwgAj6B7/m8Al58wnDTVGjm9jvMAbnfhuee1TeW4u2jfYOTUw4xfeclDenn6
7xPXXDLHZDF/2rNhO7Wp9CniEywtkoxYHhX5LKNNr/YBAaG1CUImZTnm6sasHFDN
EhFi8aTScahyN05wlXcwbSAcz3rm8SwLb0VH8F/YdulbIa0q7w2arCcNERa/sgpR
3iUFnKwnap3zDNe8sKApQrh3eWcNe0h98Ve8hGAO4qYX7z5dhk0PgJ3mQ6/mr5DP
/8Eb8eVJYe1R9jnW+UQyy6ATdZnv8A3smmCwaxWpQnOoGEYl1UWn8UsV6P4JS/U5
NrgD721lyStmeAHDb9BwdstbmZGtBw==
=4RTM
-----END PGP SIGNATURE-----

--Sig_/ah2dOQSZExKWY5aI/4O+/7H--
