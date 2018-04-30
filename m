Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1984963-1525122216-2-6759670255195724449
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='UTF-8', cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525122215; b=XhwgZ49eFhKywJcqxK24PT66CrqYkgCtSrTxO+veFs7iB9LDe/
    Qgt8oD8Ipp5EpuMiA0Sw4ihK89joGKYUc5dVNdZ1cg/I8oTBfI/oCi1oBICbyvtO
    f4nA+aWSio5x0++z+tDFBYeuKsjfFkTpbjW/aQvGzVlbsrBXdWIQ1X5xFGQ4WD9I
    UEU4ifr+8EQrC/G/7qajyEvSDUKwts7uyjDmgvu5gKZZYsO1FDYWFLFkfp9kX6KV
    Rqwr/VO/BqOfcAgyhsczRqB6kDgljZxZwkS/EEWVVpSW2Gnxd969vmMIjLDsrG0T
    p8Ms2vN2K5F2kjT68Y7c5rZfmaniq9WAfs+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:in-reply-to:references
    :content-type:content-transfer-encoding:sender:list-id; s=fm2;
    t=1525122215; bh=qbqmRhkpvcyIHbtP/SSLxZLxfqUEJ9wpd3L3J9ChNBc=; b=
    dpcKXoxM6JvPH/KnCBj4BLfkLDZiKVI4kCbA6FjxFIp+leWYjC1OMFLaqthtSjWK
    NQtm7tCuRQ0G2uxyF2v6F8MtdV208KAzGDXi0Xjyo6JObHX+HpSfELBTXtVZCQNY
    K8xb2JHgkzKEbC2ERPfwLAEUpiA3GbY9fI7XMQl8boEH84Luv3t/cLD/QL/bDTmG
    UPaYBxbg6r//cAPSnKWy4HXjAl3XzEZGKGAmFQVVo5VP/YoUUEynytQAyRKg62Bz
    +bpWO2FUaZ82dLYcDEUeTcTB5a0WJsLoIGTm+TQaIly2BEIX/yiXdnWph2D04bMS
    DkD3EGKbBB5tSFrKzmPnLQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=SsYGSyjg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-95 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=SsYGSyjg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-95 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGC/mpgK8f+b2IUnz+/xeoH++VQytLRTdWyH6fjJcjUHnm1QLmnRVMeWnzSYuTHtAu6qk43k+6nV5VC1TGLHsAX+RN8i5qxDtiM3qCwy9YyLY3dG0qx5
    k++HcYiplf/QQSpHLwi3htRLLsyVMc4YTv+06EFPcW66pjdRQ1MJlutqqAOrlLf8A7SOz7km1kHlNd1D5J6MAuh0Uxhhu8gFrdxhUIbmQ3yulrZmuw18Hu//
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=vkfgAjWNAAAA:8 a=eaI9A0Ays5jijd5Za5IA:9
    a=4FBsF3pJapm-deHQ:21 a=cwy39cYD_6_qU1tZ:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=s88AYcEWOXMFsoP9cgP2:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755396AbeD3VDW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 17:03:22 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33365 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755369AbeD3VDH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Apr 2018 17:03:07 -0400
X-ME-Sender: <xms:ioTnWiLo8ULU7S_HphNBOQ5f5zYD6bNNRSdNPQzTIYZzwA2TKw8aKg>
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
        <marmarek@invisiblethingslab.com>
To: xen-devel@lists.xenproject.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
        <marmarek@invisiblethingslab.com>, stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 6/6] xen-blkfront: prepare request locally, only then put it on the shared ring
Date: Mon, 30 Apr 2018 23:01:50 +0200
Message-Id: <951a221b0e655b3077d1f96ac365194320bc8809.1525122026.git-series.marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
MIME-Version: 1.0
In-Reply-To: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Do not reuse data which theoretically might be already modified by the
backend. This is mostly about private copy of the request
(info->shadow[id].req) - make sure the request saved there is really the
one just filled.

This is complementary to XSA155.

CC: stable@vger.kernel.org
Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 drivers/block/xen-blkfront.c | 76 +++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 3926811..b100b55 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -525,19 +525,16 @@ static int blkif_ioctl(struct block_device *bdev, fmode_t mode,
 
 static unsigned long blkif_ring_get_request(struct blkfront_ring_info *rinfo,
 					    struct request *req,
-					    struct blkif_request **ring_req)
+					    struct blkif_request *ring_req)
 {
 	unsigned long id;
 
-	*ring_req = RING_GET_REQUEST(&rinfo->ring, rinfo->ring.req_prod_pvt);
-	rinfo->ring.req_prod_pvt++;
-
 	id = get_id_from_freelist(rinfo);
 	rinfo->shadow[id].request = req;
 	rinfo->shadow[id].status = REQ_WAITING;
 	rinfo->shadow[id].associated_id = NO_ASSOCIATED_ID;
 
-	(*ring_req)->u.rw.id = id;
+	ring_req->u.rw.id = id;
 
 	return id;
 }
@@ -545,23 +542,28 @@ static unsigned long blkif_ring_get_request(struct blkfront_ring_info *rinfo,
 static int blkif_queue_discard_req(struct request *req, struct blkfront_ring_info *rinfo)
 {
 	struct blkfront_info *info = rinfo->dev_info;
-	struct blkif_request *ring_req;
+	struct blkif_request ring_req = { 0 };
 	unsigned long id;
 
 	/* Fill out a communications ring structure. */
 	id = blkif_ring_get_request(rinfo, req, &ring_req);
 
-	ring_req->operation = BLKIF_OP_DISCARD;
-	ring_req->u.discard.nr_sectors = blk_rq_sectors(req);
-	ring_req->u.discard.id = id;
-	ring_req->u.discard.sector_number = (blkif_sector_t)blk_rq_pos(req);
+	ring_req.operation = BLKIF_OP_DISCARD;
+	ring_req.u.discard.nr_sectors = blk_rq_sectors(req);
+	ring_req.u.discard.id = id;
+	ring_req.u.discard.sector_number = (blkif_sector_t)blk_rq_pos(req);
 	if (req_op(req) == REQ_OP_SECURE_ERASE && info->feature_secdiscard)
-		ring_req->u.discard.flag = BLKIF_DISCARD_SECURE;
+		ring_req.u.discard.flag = BLKIF_DISCARD_SECURE;
 	else
-		ring_req->u.discard.flag = 0;
+		ring_req.u.discard.flag = 0;
+
+	/* make the request available to the backend */
+	*RING_GET_REQUEST(&rinfo->ring, rinfo->ring.req_prod_pvt) = ring_req;
+	wmb();
+	rinfo->ring.req_prod_pvt++;
 
 	/* Keep a private copy so we can reissue requests when recovering. */
-	rinfo->shadow[id].req = *ring_req;
+	rinfo->shadow[id].req = ring_req;
 
 	return 0;
 }
@@ -693,7 +695,7 @@ static void blkif_setup_extra_req(struct blkif_request *first,
 static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *rinfo)
 {
 	struct blkfront_info *info = rinfo->dev_info;
-	struct blkif_request *ring_req, *extra_ring_req = NULL;
+	struct blkif_request ring_req = { 0 }, extra_ring_req = { 0 };
 	unsigned long id, extra_id = NO_ASSOCIATED_ID;
 	bool require_extra_req = false;
 	int i;
@@ -758,16 +760,16 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
 		 * BLKIF_OP_WRITE
 		 */
 		BUG_ON(req_op(req) == REQ_OP_FLUSH || req->cmd_flags & REQ_FUA);
-		ring_req->operation = BLKIF_OP_INDIRECT;
-		ring_req->u.indirect.indirect_op = rq_data_dir(req) ?
+		ring_req.operation = BLKIF_OP_INDIRECT;
+		ring_req.u.indirect.indirect_op = rq_data_dir(req) ?
 			BLKIF_OP_WRITE : BLKIF_OP_READ;
-		ring_req->u.indirect.sector_number = (blkif_sector_t)blk_rq_pos(req);
-		ring_req->u.indirect.handle = info->handle;
-		ring_req->u.indirect.nr_segments = num_grant;
+		ring_req.u.indirect.sector_number = (blkif_sector_t)blk_rq_pos(req);
+		ring_req.u.indirect.handle = info->handle;
+		ring_req.u.indirect.nr_segments = num_grant;
 	} else {
-		ring_req->u.rw.sector_number = (blkif_sector_t)blk_rq_pos(req);
-		ring_req->u.rw.handle = info->handle;
-		ring_req->operation = rq_data_dir(req) ?
+		ring_req.u.rw.sector_number = (blkif_sector_t)blk_rq_pos(req);
+		ring_req.u.rw.handle = info->handle;
+		ring_req.operation = rq_data_dir(req) ?
 			BLKIF_OP_WRITE : BLKIF_OP_READ;
 		if (req_op(req) == REQ_OP_FLUSH || req->cmd_flags & REQ_FUA) {
 			/*
@@ -778,15 +780,15 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
 			 * since it is guaranteed ordered WRT previous writes.)
 			 */
 			if (info->feature_flush && info->feature_fua)
-				ring_req->operation =
+				ring_req.operation =
 					BLKIF_OP_WRITE_BARRIER;
 			else if (info->feature_flush)
-				ring_req->operation =
+				ring_req.operation =
 					BLKIF_OP_FLUSH_DISKCACHE;
 			else
-				ring_req->operation = 0;
+				ring_req.operation = 0;
 		}
-		ring_req->u.rw.nr_segments = num_grant;
+		ring_req.u.rw.nr_segments = num_grant;
 		if (unlikely(require_extra_req)) {
 			extra_id = blkif_ring_get_request(rinfo, req,
 							  &extra_ring_req);
@@ -796,7 +798,7 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
 			 */
 			rinfo->shadow[extra_id].num_sg = 0;
 
-			blkif_setup_extra_req(ring_req, extra_ring_req);
+			blkif_setup_extra_req(&ring_req, &extra_ring_req);
 
 			/* Link the 2 requests together */
 			rinfo->shadow[extra_id].associated_id = id;
@@ -804,12 +806,12 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
 		}
 	}
 
-	setup.ring_req = ring_req;
+	setup.ring_req = &ring_req;
 	setup.id = id;
 
 	setup.require_extra_req = require_extra_req;
 	if (unlikely(require_extra_req))
-		setup.extra_ring_req = extra_ring_req;
+		setup.extra_ring_req = &extra_ring_req;
 
 	for_each_sg(rinfo->shadow[id].sg, sg, num_sg, i) {
 		BUG_ON(sg->offset + sg->length > PAGE_SIZE);
@@ -831,10 +833,20 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
 	if (setup.segments)
 		kunmap_atomic(setup.segments);
 
+	/* make the request available to the backend */
+	*RING_GET_REQUEST(&rinfo->ring, rinfo->ring.req_prod_pvt) = ring_req;
+	wmb();
+	rinfo->ring.req_prod_pvt++;
 	/* Keep a private copy so we can reissue requests when recovering. */
-	rinfo->shadow[id].req = *ring_req;
-	if (unlikely(require_extra_req))
-		rinfo->shadow[extra_id].req = *extra_ring_req;
+	rinfo->shadow[id].req = ring_req;
+
+	if (unlikely(require_extra_req)) {
+		*RING_GET_REQUEST(&rinfo->ring, rinfo->ring.req_prod_pvt) = extra_ring_req;
+		wmb();
+		rinfo->ring.req_prod_pvt++;
+		/* Keep a private copy so we can reissue requests when recovering. */
+		rinfo->shadow[extra_id].req = extra_ring_req;
+	}
 
 	if (new_persistent_gnts)
 		gnttab_free_grant_references(setup.gref_head);
-- 
git-series 0.9.1
