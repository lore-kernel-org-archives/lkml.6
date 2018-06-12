Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D659DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BAF208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BAF208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933730AbeFLH5G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:57:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933437AbeFLH5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:57:04 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5C7sTLv086181
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:57:04 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jj6t811f2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:57:03 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 12 Jun 2018 08:57:01 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Jun 2018 08:56:58 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5C7uvbe30736394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jun 2018 07:56:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25ED4AE057;
        Tue, 12 Jun 2018 08:45:49 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E60D8AE059;
        Tue, 12 Jun 2018 08:45:48 +0100 (BST)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.92])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jun 2018 08:45:48 +0100 (BST)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, cohuck@redhat.com
Subject: [PATCH v3 5/8] vfio: ccw: Suppress unused event parameter
Date:   Tue, 12 Jun 2018 09:56:47 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
References: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18061207-0012-0000-0000-0000027E6F48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061207-0013-0000-0000-000020AF843E
Message-Id: <1528790210-19535-6-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=892 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806120094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fsm_func_t function type definition does not need the event
parameter since all functions are in a state/event table.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c     | 24 ++++++++----------------
 drivers/s390/cio/vfio_ccw_private.h |  5 ++---
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index e672d14..2d55742 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -65,8 +65,7 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
 	return ret;
 }
 
-static int fsm_notoper(struct vfio_ccw_private *private,
-			enum vfio_ccw_event event)
+static int fsm_notoper(struct vfio_ccw_private *private)
 {
 	struct subchannel *sch = private->sch;
 
@@ -81,29 +80,25 @@ static int fsm_notoper(struct vfio_ccw_private *private,
 /*
  * No operation action.
  */
-static int fsm_nop(struct vfio_ccw_private *private,
-		    enum vfio_ccw_event event)
+static int fsm_nop(struct vfio_ccw_private *private)
 {
 	return private->state;
 }
 
-static int fsm_io_error(struct vfio_ccw_private *private,
-			 enum vfio_ccw_event event)
+static int fsm_io_error(struct vfio_ccw_private *private)
 {
 	pr_err("vfio-ccw: FSM: I/O request from state:%d\n", private->state);
 	private->io_region.ret_code = -EIO;
 	return private->state;
 }
 
-static int fsm_io_busy(struct vfio_ccw_private *private,
-			enum vfio_ccw_event event)
+static int fsm_io_busy(struct vfio_ccw_private *private)
 {
 	private->io_region.ret_code = -EBUSY;
 	return private->state;
 }
 
-static int fsm_disabled_irq(struct vfio_ccw_private *private,
-			     enum vfio_ccw_event event)
+static int fsm_disabled_irq(struct vfio_ccw_private *private)
 {
 	struct subchannel *sch = private->sch;
 
@@ -118,8 +113,7 @@ static int fsm_disabled_irq(struct vfio_ccw_private *private,
 /*
  * Deal with the ccw command request from the userspace.
  */
-static int fsm_io_request(struct vfio_ccw_private *private,
-			   enum vfio_ccw_event event)
+static int fsm_io_request(struct vfio_ccw_private *private)
 {
 	union orb *orb;
 	struct ccw_io_region *io_region = &private->io_region;
@@ -160,8 +154,7 @@ static int fsm_io_request(struct vfio_ccw_private *private,
 /*
  * Got an interrupt for a normal io (state busy).
  */
-static int fsm_irq(struct vfio_ccw_private *private,
-		    enum vfio_ccw_event event)
+static int fsm_irq(struct vfio_ccw_private *private)
 {
 	struct irb *irb = &private->irb;
 
@@ -180,8 +173,7 @@ static int fsm_irq(struct vfio_ccw_private *private,
 /*
  * Got a sub-channel event .
  */
-static int fsm_sch_event(struct vfio_ccw_private *private,
-			 enum vfio_ccw_event event)
+static int fsm_sch_event(struct vfio_ccw_private *private)
 {
 	unsigned long flags;
 	int ret = private->state;
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index a2be0c9..521ba0b 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -86,14 +86,13 @@ enum vfio_ccw_event {
 /*
  * Action called through jumptable.
  */
-typedef int (fsm_func_t)(struct vfio_ccw_private *, enum vfio_ccw_event);
+typedef int (fsm_func_t)(struct vfio_ccw_private *);
 extern fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS];
 
 static inline void vfio_ccw_fsm_event(struct vfio_ccw_private *private,
 				     int event)
 {
-	private->state = vfio_ccw_jumptable[private->state][event](private,
-								   event);
+	private->state = vfio_ccw_jumptable[private->state][event](private);
 }
 
 extern struct workqueue_struct *vfio_ccw_work_q;
-- 
2.7.4

