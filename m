Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-669745-1523936785-2-14140059680176686082
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523936784; b=s4igPt72ctInlFi+UT/SRHVQ/ras0DoY6W4iYSqcv7iNQrdOQe
    cKTA6/LHHEB6xIgICEAYPNafLHUnfUJuVnoDh4URbtHnCS0eOS1nccQia2af05A2
    DAzfhcSVb0Yim1LuaPg3Vr0TI0Ojur//8tOcb3KsQ4zBf5x9MON7HWhfhebEtvfp
    LBBKo4jabH1zhyhOF4PA2LB9d5Ktzf3OLnR1oCHSnvJ/wAnoSVjW9jmgOSgVVHNx
    TUWgUMNgBSzWbkWfvrvSmqcWk0crgnbbj036jKCq3bwXrSdrx88dopp06ZVhBno3
    rMS2rSEMcVmccM7+8po+bOHcguEE7aN/4tuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523936784; bh=kJ9p7fEtqIERNgoRZg1mLgCF+19Ryk
    OOKvwgZCfd7IE=; b=ZgHex+uditTViJ+idWFm84ke0zYI7ktWznTXNsxicHl9Gx
    cGXaTw97rpMt8TuXDnCM4te5Q/tIVJRKrIVVbJxIce4d/lbKj3O1pC/zgrfHtQqZ
    4JgOTGxz8ALsosgUiF83dB65odpci9f/Vt6MjPu7p0KJjO0ZxZsrweKrGk4wf/X6
    yF5qXJ7Jlt8o+lXZ9GsJ+dGvXVb8VReJA5cORV77kr22u2jEqdjmU9TZ4qneU3rP
    7RfsjvvY/6hEE8Dgoob5W3tpxpdYx0eywW5komzWPX/GYbAki6dCDmFLSWMSU+sl
    LFJcNre6SlL+jPHXqqvu5gB52GLZiin0WNj7oAEA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=roYdqRSz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=roYdqRSz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBzTInBQcgzjwk38oqYfhWLevHt9hrrVyS3iKko63RVU3d1dvDKhoQWtDEgiSUkqjxF64Zn79kkB4qYY4kXWZEuyonr5jloFaXWahp9bBKnlfjH1nCDi
    2LlzgEH+4QgeMZU743N0LYzReEqJbmY3i+l/8OA0f5Qv36ZQNMA3Apml9IP78OzCxpOnJNojU+guk0r7d/NLWbE5hDWu6F5eS5O4w990VrqCVzdXgE+O6KQ5
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=JF9118EUAAAA:8
    a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=KuCSL1JFZU10dv-_TpIA:9
    a=o74DAEksD9oLSYfJ:21 a=eOllWZAG8GY5dTp3:21 a=xVlTc564ipvMDusKsbsT:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeDQDqL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 23:46:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50022 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbeDQDqK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 23:46:10 -0400
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: bart.vanassche@wdc.com, tj@kernel.org, ming.lei@redhat.com,
        Martin@Lichtvoll.de, stable@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: start request gstate with gen 1
Date: Tue, 17 Apr 2018 11:46:20 +0800
Message-Id: <1523936780-1589-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8865 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=962
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804170033
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

rq->gstate and rq->aborted_gstate both are zero before rqs are
allocated. If we have a small timeout, when the timer fires,
there could be rqs that are never allocated, and also there could
be rq that has been allocated but not initialized and started. At
the moment, the rq->gstate and rq->aborted_gstate both are 0, thus
the blk_mq_terminate_expired will identify the rq is timed out and
invoke .timeout early.

For scsi, this will cause scsi_times_out to be invoked before the
scsi_cmnd is not initialized, scsi_cmnd->device is still NULL at
the moment, then we will get crash.

Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Martin Steigerwald <Martin@Lichtvoll.de>
Cc: stable@vger.kernel.org
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-core.c | 4 ++++
 block/blk-mq.c   | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index abcb868..ce62681 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -201,6 +201,10 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	rq->part = NULL;
 	seqcount_init(&rq->gstate_seq);
 	u64_stats_init(&rq->aborted_gstate_sync);
+	/*
+	 * See comment of blk_mq_init_request
+	 */
+	WRITE_ONCE(rq->gstate, MQ_RQ_GEN_INC);
 }
 EXPORT_SYMBOL(blk_rq_init);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f5c7dbc..d62030a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2069,6 +2069,13 @@ static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 
 	seqcount_init(&rq->gstate_seq);
 	u64_stats_init(&rq->aborted_gstate_sync);
+	/*
+	 * start gstate with gen 1 instead of 0, otherwise it will be equal
+	 * to aborted_gstate, and be identified timed out by
+	 * blk_mq_terminate_expired.
+	 */
+	WRITE_ONCE(rq->gstate, MQ_RQ_GEN_INC);
+
 	return 0;
 }
 
-- 
2.7.4
