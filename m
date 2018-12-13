Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E36C67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D4920870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D4920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbeLMBmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 20:42:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726380AbeLMBmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 20:42:36 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBD1ctJn074904
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 20:42:35 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pbbt7d5k9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 20:42:34 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Thu, 13 Dec 2018 01:42:34 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Dec 2018 01:42:32 -0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBD1gUCI20512930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Dec 2018 01:42:30 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 836817805E;
        Thu, 13 Dec 2018 01:42:30 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B82AA7805C;
        Thu, 13 Dec 2018 01:42:28 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.80.227.60])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 13 Dec 2018 01:42:28 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH] integrity: Remove references to module keyring
Date:   Wed, 12 Dec 2018 23:39:09 -0200
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 18121301-0016-0000-0000-00000963A1B5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010217; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01130942; UDB=6.00587708; IPR=6.00911075;
 MB=3.00024674; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-13 01:42:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121301-0017-0000-0000-000041628DA9
Message-Id: <20181213013909.25737-1-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812130013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From what I can tell, it has never been used.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 security/integrity/digsig.c    | 1 -
 security/integrity/integrity.h | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index c5585e75d5d9..1ff8eab7bc8c 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -34,7 +34,6 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 	".evm",
 	".ima",
 #endif
-	"_module",
 	".platform",
 };
 
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index aafa1266e3d5..26c415c3f879 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -152,9 +152,8 @@ int integrity_kernel_read(struct file *file, loff_t offset,
 
 #define INTEGRITY_KEYRING_EVM		0
 #define INTEGRITY_KEYRING_IMA		1
-#define INTEGRITY_KEYRING_MODULE	2
-#define INTEGRITY_KEYRING_PLATFORM	3
-#define INTEGRITY_KEYRING_MAX		4
+#define INTEGRITY_KEYRING_PLATFORM	2
+#define INTEGRITY_KEYRING_MAX		3
 
 extern struct dentry *integrity_dir;
 

