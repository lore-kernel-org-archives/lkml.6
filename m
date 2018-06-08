Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id w8q2GH+/Glv3egAAmS7hNA
	; Fri, 08 Jun 2018 17:40:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6AE42607E4; Fri,  8 Jun 2018 17:40:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 45E7C605A2;
	Fri,  8 Jun 2018 17:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 45E7C605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbeFHRkQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:40:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752328AbeFHRkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:40:14 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w58Hcpnw062149
        for <linux-kernel@vger.kernel.org>; Fri, 8 Jun 2018 13:40:13 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jfud6g8ux-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 13:40:13 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sebott@linux.ibm.com>;
        Fri, 8 Jun 2018 18:40:11 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Jun 2018 18:40:08 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w58He7fg25428016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jun 2018 17:40:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9945A405D;
        Fri,  8 Jun 2018 18:31:05 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02320A4051;
        Fri,  8 Jun 2018 18:31:05 +0100 (BST)
Received: from icon-9-164-173-92.megacenter.de.ibm.com (unknown [9.164.173.92])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  8 Jun 2018 18:31:04 +0100 (BST)
Date: Fri, 8 Jun 2018 19:40:05 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
X-X-Sender: sebott@schleppi
To: Christoph Hellwig <hch@infradead.org>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [GIT PULL] two more s390 bug fixes for 4.17
In-Reply-To: <alpine.LFD.2.21.1805301425580.1717@schleppi>
References: <20180530075920.1f73275a@mschwideX1> <20180530074130.GA6927@infradead.org> <alpine.LFD.2.21.1805301425580.1717@schleppi>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH?=
 =?ISO-8859-15?Q?_=2F_Vorsitzende_des_Aufsichtsrats=3A_Martina?=
 =?ISO-8859-15?Q?_Koederitz_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp?=
 =?ISO-8859-15?Q?_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Reg?=
 =?ISO-8859-15?Q?istergericht=3A_Amtsgericht_Stuttgart=2C_HRB_2432?=
 =?ISO-8859-15?Q?94=22?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
x-cbid: 18060817-4275-0000-0000-0000028BA690
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060817-4276-0000-0000-00003792BCDB
Message-Id: <alpine.LFD.2.21.1806081921190.1720@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=10 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806080195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 30 May 2018, Sebastian Ott wrote:
> On Wed, 30 May 2018, Christoph Hellwig wrote:
> > > -	req->completion_data = cqr;
> > > +	*((struct dasd_ccw_req **) blk_mq_rq_to_pdu(req)) = cqr;
> > > +
> > 
> > Please don't play such tricks.  In general your driver structure
> > should have struct request embedded.

OK. I did that. Executive summary:

@@ -3077,7 +3078,7 @@ enum blk_eh_timer_return dasd_times_out(struct request *req, bool reserved)
        unsigned long flags;
        int rc = 0;
 
-       cqr = *((struct dasd_ccw_req **) blk_mq_rq_to_pdu(req));
+       cqr = blk_mq_rq_to_pdu(req);
        if (!cqr)
                return BLK_EH_NOT_HANDLED;
 
@@ -3179,7 +3180,7 @@ static int dasd_alloc_queue(struct dasd_block *block)
        int rc;
 
        block->tag_set.ops = &dasd_mq_ops;
-       block->tag_set.cmd_size = sizeof(struct dasd_ccw_req *);
+       block->tag_set.cmd_size = sizeof(struct dasd_ccw_req);


If you agree with this I'll prepare that one for inclusion via Martins
tree.

Regards,
Sebastian

------->8

>From 72470aaf8721e3cff9aac9f1095c22c66164eb7f Mon Sep 17 00:00:00 2001
From: Sebastian Ott <sebott@linux.ibm.com>
Date: Mon, 4 Jun 2018 19:07:39 +0200
Subject: [PATCH] s390/dasd: move dasd_ccw_req to per request data

Let the block layer allocate per request data to store
struct dasd_ccw_req. We still need extra preallocated
memory for usage by ccw programs (which vary in length)
and for requests which don't originate from the block
layer.

Link: https://lkml.kernel.org/r/20180530074130.GA6927@infradead.org
Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c      | 46 ++++++++++++++++++++++--------------------
 drivers/s390/block/dasd_diag.c |  3 ++-
 drivers/s390/block/dasd_eckd.c | 46 +++++++++++++++++++++++-------------------
 drivers/s390/block/dasd_fba.c  |  6 ++++--
 drivers/s390/block/dasd_int.h  |  3 ++-
 5 files changed, 57 insertions(+), 47 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index ed039ab..a8ffbac 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1267,35 +1267,37 @@ struct dasd_ccw_req *dasd_kmalloc_request(int magic, int cplength,
 }
 EXPORT_SYMBOL(dasd_kmalloc_request);
 
-struct dasd_ccw_req *dasd_smalloc_request(int magic, int cplength,
-					  int datasize,
-					  struct dasd_device *device)
+struct dasd_ccw_req *dasd_smalloc_request(int magic, int cplength, int datasize,
+					  struct dasd_device *device,
+					  struct dasd_ccw_req *cqr)
 {
 	unsigned long flags;
-	struct dasd_ccw_req *cqr;
-	char *data;
-	int size;
+	char *data, *chunk;
+	int size = 0;
 
-	size = (sizeof(struct dasd_ccw_req) + 7L) & -8L;
 	if (cplength > 0)
 		size += cplength * sizeof(struct ccw1);
 	if (datasize > 0)
 		size += datasize;
+	if (!cqr)
+		size += (sizeof(*cqr) + 7L) & -8L;
+
 	spin_lock_irqsave(&device->mem_lock, flags);
-	cqr = (struct dasd_ccw_req *)
-		dasd_alloc_chunk(&device->ccw_chunks, size);
+	data = chunk = dasd_alloc_chunk(&device->ccw_chunks, size);
 	spin_unlock_irqrestore(&device->mem_lock, flags);
-	if (cqr == NULL)
+	if (!chunk)
 		return ERR_PTR(-ENOMEM);
-	memset(cqr, 0, sizeof(struct dasd_ccw_req));
-	data = (char *) cqr + ((sizeof(struct dasd_ccw_req) + 7L) & -8L);
-	cqr->cpaddr = NULL;
+	if (!cqr) {
+		cqr = (void *) data;
+		data += (sizeof(*cqr) + 7L) & -8L;
+	}
+	memset(cqr, 0, sizeof(*cqr));
+	cqr->mem_chunk = chunk;
 	if (cplength > 0) {
-		cqr->cpaddr = (struct ccw1 *) data;
-		data += cplength*sizeof(struct ccw1);
-		memset(cqr->cpaddr, 0, cplength*sizeof(struct ccw1));
+		cqr->cpaddr = data;
+		data += cplength * sizeof(struct ccw1);
+		memset(cqr->cpaddr, 0, cplength * sizeof(struct ccw1));
 	}
-	cqr->data = NULL;
 	if (datasize > 0) {
 		cqr->data = data;
  		memset(cqr->data, 0, datasize);
@@ -1333,7 +1335,7 @@ void dasd_sfree_request(struct dasd_ccw_req *cqr, struct dasd_device *device)
 	unsigned long flags;
 
 	spin_lock_irqsave(&device->mem_lock, flags);
-	dasd_free_chunk(&device->ccw_chunks, cqr);
+	dasd_free_chunk(&device->ccw_chunks, cqr->mem_chunk);
 	spin_unlock_irqrestore(&device->mem_lock, flags);
 	dasd_put_device(device);
 }
@@ -3046,7 +3048,6 @@ static blk_status_t do_dasd_request(struct blk_mq_hw_ctx *hctx,
 	cqr->callback_data = req;
 	cqr->status = DASD_CQR_FILLED;
 	cqr->dq = dq;
-	*((struct dasd_ccw_req **) blk_mq_rq_to_pdu(req)) = cqr;
 
 	blk_mq_start_request(req);
 	spin_lock(&block->queue_lock);
@@ -3077,7 +3078,7 @@ enum blk_eh_timer_return dasd_times_out(struct request *req, bool reserved)
 	unsigned long flags;
 	int rc = 0;
 
-	cqr = *((struct dasd_ccw_req **) blk_mq_rq_to_pdu(req));
+	cqr = blk_mq_rq_to_pdu(req);
 	if (!cqr)
 		return BLK_EH_NOT_HANDLED;
 
@@ -3179,7 +3180,7 @@ static int dasd_alloc_queue(struct dasd_block *block)
 	int rc;
 
 	block->tag_set.ops = &dasd_mq_ops;
-	block->tag_set.cmd_size = sizeof(struct dasd_ccw_req *);
+	block->tag_set.cmd_size = sizeof(struct dasd_ccw_req);
 	block->tag_set.nr_hw_queues = DASD_NR_HW_QUEUES;
 	block->tag_set.queue_depth = DASD_MAX_LCU_DEV * DASD_REQ_PER_DEV;
 	block->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
@@ -4043,7 +4044,8 @@ static struct dasd_ccw_req *dasd_generic_build_rdc(struct dasd_device *device,
 	struct ccw1 *ccw;
 	unsigned long *idaw;
 
-	cqr = dasd_smalloc_request(magic, 1 /* RDC */, rdc_buffer_size, device);
+	cqr = dasd_smalloc_request(magic, 1 /* RDC */, rdc_buffer_size, device,
+				   NULL);
 
 	if (IS_ERR(cqr)) {
 		/* internal error 13 - Allocating the RDC request failed*/
diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index 131f198..e1fe024 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -536,7 +536,8 @@ static struct dasd_ccw_req *dasd_diag_build_cp(struct dasd_device *memdev,
 	/* Build the request */
 	datasize = sizeof(struct dasd_diag_req) +
 		count*sizeof(struct dasd_diag_bio);
-	cqr = dasd_smalloc_request(DASD_DIAG_MAGIC, 0, datasize, memdev);
+	cqr = dasd_smalloc_request(DASD_DIAG_MAGIC, 0, datasize, memdev,
+				   blk_mq_rq_to_pdu(req));
 	if (IS_ERR(cqr))
 		return cqr;
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index be208e7..bbf95b7 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -886,7 +886,7 @@ static int dasd_eckd_read_conf_lpm(struct dasd_device *device,
 	}
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* RCD */,
 				   0, /* use rcd_buf as data ara */
-				   device);
+				   device, NULL);
 	if (IS_ERR(cqr)) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			      "Could not allocate RCD request");
@@ -1442,7 +1442,7 @@ static int dasd_eckd_read_features(struct dasd_device *device)
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* PSF */	+ 1 /* RSSD */,
 				   (sizeof(struct dasd_psf_prssd_data) +
 				    sizeof(struct dasd_rssd_features)),
-				   device);
+				   device, NULL);
 	if (IS_ERR(cqr)) {
 		DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s", "Could not "
 				"allocate initialization request");
@@ -1504,7 +1504,7 @@ static struct dasd_ccw_req *dasd_eckd_build_psf_ssc(struct dasd_device *device,
 
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* PSF */ ,
 				  sizeof(struct dasd_psf_ssc_data),
-				  device);
+				   device, NULL);
 
 	if (IS_ERR(cqr)) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
@@ -1815,7 +1815,8 @@ dasd_eckd_analysis_ccw(struct dasd_device *device)
 
 	cplength = 8;
 	datasize = sizeof(struct DE_eckd_data) + 2*sizeof(struct LO_eckd_data);
-	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, cplength, datasize, device);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, cplength, datasize, device,
+				   NULL);
 	if (IS_ERR(cqr))
 		return cqr;
 	ccw = cqr->cpaddr;
@@ -2092,7 +2093,8 @@ dasd_eckd_build_check_tcw(struct dasd_device *base, struct format_data_t *fdata,
 	 */
 	itcw_size = itcw_calc_size(0, count, 0);
 
-	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 0, itcw_size, startdev);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 0, itcw_size, startdev,
+				   NULL);
 	if (IS_ERR(cqr))
 		return cqr;
 
@@ -2186,7 +2188,7 @@ dasd_eckd_build_check(struct dasd_device *base, struct format_data_t *fdata,
 	cplength += count;
 
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, cplength, datasize,
-				  startdev);
+				   startdev, NULL);
 	if (IS_ERR(cqr))
 		return cqr;
 
@@ -2332,7 +2334,7 @@ dasd_eckd_build_format(struct dasd_device *base,
 	}
 	/* Allocate the format ccw request. */
 	fcp = dasd_smalloc_request(DASD_ECKD_MAGIC, cplength,
-				   datasize, startdev);
+				   datasize, startdev, NULL);
 	if (IS_ERR(fcp))
 		return fcp;
 
@@ -3103,7 +3105,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_single(
 	}
 	/* Allocate the ccw request. */
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, cplength, datasize,
-				   startdev);
+				   startdev, blk_mq_rq_to_pdu(req));
 	if (IS_ERR(cqr))
 		return cqr;
 	ccw = cqr->cpaddr;
@@ -3262,7 +3264,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_track(
 
 	/* Allocate the ccw request. */
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, cplength, datasize,
-				   startdev);
+				   startdev, blk_mq_rq_to_pdu(req));
 	if (IS_ERR(cqr))
 		return cqr;
 	ccw = cqr->cpaddr;
@@ -3595,7 +3597,8 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_tpm_track(
 
 	/* Allocate the ccw request. */
 	itcw_size = itcw_calc_size(0, ctidaw, 0);
-	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 0, itcw_size, startdev);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 0, itcw_size, startdev,
+				   blk_mq_rq_to_pdu(req));
 	if (IS_ERR(cqr))
 		return cqr;
 
@@ -3862,7 +3865,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_raw(struct dasd_device *startdev,
 
 	/* Allocate the ccw request. */
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, cplength,
-				   datasize, startdev);
+				   datasize, startdev, blk_mq_rq_to_pdu(req));
 	if (IS_ERR(cqr))
 		return cqr;
 
@@ -4102,7 +4105,7 @@ dasd_eckd_release(struct dasd_device *device)
 		return -EACCES;
 
 	useglobal = 0;
-	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1, 32, device);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1, 32, device, NULL);
 	if (IS_ERR(cqr)) {
 		mutex_lock(&dasd_reserve_mutex);
 		useglobal = 1;
@@ -4157,7 +4160,7 @@ dasd_eckd_reserve(struct dasd_device *device)
 		return -EACCES;
 
 	useglobal = 0;
-	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1, 32, device);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1, 32, device, NULL);
 	if (IS_ERR(cqr)) {
 		mutex_lock(&dasd_reserve_mutex);
 		useglobal = 1;
@@ -4211,7 +4214,7 @@ dasd_eckd_steal_lock(struct dasd_device *device)
 		return -EACCES;
 
 	useglobal = 0;
-	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1, 32, device);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1, 32, device, NULL);
 	if (IS_ERR(cqr)) {
 		mutex_lock(&dasd_reserve_mutex);
 		useglobal = 1;
@@ -4271,7 +4274,8 @@ static int dasd_eckd_snid(struct dasd_device *device,
 
 	useglobal = 0;
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1,
-				   sizeof(struct dasd_snid_data), device);
+				   sizeof(struct dasd_snid_data), device,
+				   NULL);
 	if (IS_ERR(cqr)) {
 		mutex_lock(&dasd_reserve_mutex);
 		useglobal = 1;
@@ -4331,7 +4335,7 @@ dasd_eckd_performance(struct dasd_device *device, void __user *argp)
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* PSF */  + 1 /* RSSD */,
 				   (sizeof(struct dasd_psf_prssd_data) +
 				    sizeof(struct dasd_rssd_perf_stats_t)),
-				   device);
+				   device, NULL);
 	if (IS_ERR(cqr)) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "Could not allocate initialization request");
@@ -4477,7 +4481,7 @@ static int dasd_symm_io(struct dasd_device *device, void __user *argp)
 	psf1 = psf_data[1];
 
 	/* setup CCWs for PSF + RSSD */
-	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 2 , 0, device);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 2, 0, device, NULL);
 	if (IS_ERR(cqr)) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			"Could not allocate initialization request");
@@ -5037,7 +5041,7 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* PSF */	+ 1 /* RSSD */,
 				   (sizeof(struct dasd_psf_prssd_data) +
 				    sizeof(struct dasd_rssd_messages)),
-				   device);
+				   device, NULL);
 	if (IS_ERR(cqr)) {
 		DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
 				"Could not allocate read message buffer request");
@@ -5126,7 +5130,7 @@ static int dasd_eckd_query_host_access(struct dasd_device *device,
 
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* PSF */	+ 1 /* RSSD */,
 				   sizeof(struct dasd_psf_prssd_data) + 1,
-				   device);
+				   device, NULL);
 	if (IS_ERR(cqr)) {
 		DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
 				"Could not allocate read message buffer request");
@@ -5284,8 +5288,8 @@ dasd_eckd_psf_cuir_response(struct dasd_device *device, int response,
 	int rc;
 
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* PSF */ ,
-				  sizeof(struct dasd_psf_cuir_response),
-				  device);
+				   sizeof(struct dasd_psf_cuir_response),
+				   device, NULL);
 
 	if (IS_ERR(cqr)) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index a6b132f..56007a3 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -356,7 +356,8 @@ static struct dasd_ccw_req *dasd_fba_build_cp_discard(
 	datasize = sizeof(struct DE_fba_data) +
 		nr_ccws * (sizeof(struct LO_fba_data) + sizeof(struct ccw1));
 
-	cqr = dasd_smalloc_request(DASD_FBA_MAGIC, cplength, datasize, memdev);
+	cqr = dasd_smalloc_request(DASD_FBA_MAGIC, cplength, datasize, memdev,
+				   blk_mq_rq_to_pdu(req));
 	if (IS_ERR(cqr))
 		return cqr;
 
@@ -490,7 +491,8 @@ static struct dasd_ccw_req *dasd_fba_build_cp_regular(
 		datasize += (count - 1)*sizeof(struct LO_fba_data);
 	}
 	/* Allocate the ccw request. */
-	cqr = dasd_smalloc_request(DASD_FBA_MAGIC, cplength, datasize, memdev);
+	cqr = dasd_smalloc_request(DASD_FBA_MAGIC, cplength, datasize, memdev,
+				   blk_mq_rq_to_pdu(req));
 	if (IS_ERR(cqr))
 		return cqr;
 	ccw = cqr->cpaddr;
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 96709b1..0844e5e 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -184,6 +184,7 @@ struct dasd_ccw_req {
 	struct irb irb;			/* device status in case of an error */
 	struct dasd_ccw_req *refers;	/* ERP-chain queueing. */
 	void *function; 		/* originating ERP action */
+	void *mem_chunk;
 
 	/* these are for statistics only */
 	unsigned long buildclk;		/* TOD-clock of request generation */
@@ -716,7 +717,7 @@ extern struct kmem_cache *dasd_page_cache;
 struct dasd_ccw_req *
 dasd_kmalloc_request(int , int, int, struct dasd_device *);
 struct dasd_ccw_req *
-dasd_smalloc_request(int , int, int, struct dasd_device *);
+dasd_smalloc_request(int, int, int, struct dasd_device *, struct dasd_ccw_req *);
 void dasd_kfree_request(struct dasd_ccw_req *, struct dasd_device *);
 void dasd_sfree_request(struct dasd_ccw_req *, struct dasd_device *);
 void dasd_wakeup_cb(struct dasd_ccw_req *, void *);
-- 
2.7.4
