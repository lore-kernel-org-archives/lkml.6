Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0D0C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD2420660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD2420660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbeK1Xmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:42:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728373AbeK1Xmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:42:52 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wASCdN8S120751
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 07:41:20 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p1tf6j17q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 07:41:19 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 28 Nov 2018 12:41:17 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Nov 2018 12:41:15 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wASCfEQM14876714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Nov 2018 12:41:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E795D4C04A;
        Wed, 28 Nov 2018 12:41:13 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B58F24C044;
        Wed, 28 Nov 2018 12:41:13 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.168])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Nov 2018 12:41:13 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     pasic@linux.vnet.ibm.com
Cc:     cohuck@redhat.com, farman@linux.ibm.com, alifm@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH v3 5/6] vfio: ccw: Documenting state transitions
Date:   Wed, 28 Nov 2018 13:41:06 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
References: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18112812-0008-0000-0000-00000299C7FA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112812-0009-0000-0000-000022040F83
Message-Id: <1543408867-16465-6-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=789 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811280112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's document the state transitions.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 Documentation/s390/vfio-ccw.txt | 45 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/s390/vfio-ccw.txt b/Documentation/s390/vfio-ccw.txt
index 2be11ad..0a1a19f 100644
--- a/Documentation/s390/vfio-ccw.txt
+++ b/Documentation/s390/vfio-ccw.txt
@@ -263,6 +263,51 @@ Q6. Get the signal and event handler reads out the result from the I/O
     region.
 Q7. Update the irb for the guest.
 
+
+States transitions
+------------------
+
+The CCW VFIO driver maintain a device states to determine the response
+- to external events like interruptions, data send, halt and clear
+  from sub-channels.
+- to configuration events, device binding, mdev creation, VM start/stop.
+- to other events like errors or reset of the VM
+
+The event and states are summed up in the diagramme below:
+
+      bind() unbind()
+        |       ^
+        v       |
+      -------------
+      | NOT_OPER  |<---- error
+      -------------    |
+        |       ^      |
+     create() remove() |
+        v       |      |
+      -------------    |
+      | STANDBY   |<--- release()
+      -------------    |
+        |       ^      |
+      open() release() |
+        v       |      |
+      -------------    |
+   -->|   IDLE    |<--- reset
+   |  -------------    |
+   |    |       ^      |
+   |  write()  err     |
+   |    v       |      |
+   |  -------------    |
+   |  |   BOXED   |    |
+   |  -------------    |
+   |       |           |
+  irq   success        |
+   |       v           |
+   |  -------------    |
+   ---|   BUSY    |>----
+      -------------
+
+
+
 Limitations
 -----------
 
-- 
2.7.4

