Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F45C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29ABB22408
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29ABB22408
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbeHJSQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:16:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49068 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728332AbeHJSPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:15:48 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7AFiRQh062327
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 11:45:24 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kscgdtu8h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 11:45:23 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Fri, 10 Aug 2018 16:45:21 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 10 Aug 2018 16:45:18 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7AFjHlJ41222236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Aug 2018 15:45:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16123AE045;
        Fri, 10 Aug 2018 18:45:08 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2803AE051;
        Fri, 10 Aug 2018 18:45:07 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 10 Aug 2018 18:45:07 +0100 (BST)
From:   Ursula Braun <ubraun@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/1] net/smc: send response to test link signal
Date:   Fri, 10 Aug 2018 17:45:11 +0200
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 18081015-4275-0000-0000-000002A7F847
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081015-4276-0000-0000-000037B10A8A
Message-Id: <20180810154511.71106-1-ubraun@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=6 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=773 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808100170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With SMC-D z/OS sends a test link signal every 10 seconds. Linux is
supposed to answer, otherwise the SMC-D connection breaks.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_ism.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index cfade7fdcc6d..e36f21ce7252 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -184,6 +184,37 @@ struct smc_ism_event_work {
 	struct smcd_event event;
 };
 
+#define ISM_EVENT_REQUEST		0x0001
+#define ISM_EVENT_RESPONSE		0x0002
+#define ISM_EVENT_REQUEST_IR		0x00000001
+#define ISM_EVENT_CODE_TESTLINK		0x83
+
+static void smcd_handle_sw_event(struct smc_ism_event_work *wrk)
+{
+	union {
+		u64	info;
+		struct {
+			u32		uid;
+			unsigned short	vlanid;
+			u16		code;
+		};
+	} ev_info;
+
+	switch (wrk->event.code) {
+	case ISM_EVENT_CODE_TESTLINK:	/* Activity timer */
+		ev_info.info = wrk->event.info;
+		if (ev_info.code == ISM_EVENT_REQUEST) {
+			ev_info.code = ISM_EVENT_RESPONSE;
+			wrk->smcd->ops->signal_event(wrk->smcd,
+						     wrk->event.tok,
+						     ISM_EVENT_REQUEST_IR,
+						     ISM_EVENT_CODE_TESTLINK,
+						     ev_info.info);
+			}
+		break;
+	}
+}
+
 /* worker for SMC-D events */
 static void smc_ism_event_work(struct work_struct *work)
 {
@@ -196,6 +227,9 @@ static void smc_ism_event_work(struct work_struct *work)
 		break;
 	case ISM_EVENT_DMB:
 		break;
+	case ISM_EVENT_SWR:	/* Software defined event */
+		smcd_handle_sw_event(wrk);
+		break;
 	}
 	kfree(wrk);
 }
-- 
2.16.4

