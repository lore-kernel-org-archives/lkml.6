Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3355AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4A520685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfAIWLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:11:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727610AbfAIWLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:11:17 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09MAqx3123317
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 17:11:16 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwpxh6w2d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 17:11:14 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 22:11:14 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 22:11:11 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09MBAd724903868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 22:11:10 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C83FDBE71C;
        Wed,  9 Jan 2019 22:11:10 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70B55BE70F;
        Wed,  9 Jan 2019 22:11:10 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 22:11:10 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 3/5] tpm: ppi: Display up to 101 operations as define for version 1.3
Date:   Wed,  9 Jan 2019 17:11:01 -0500
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190109221103.1897677-1-stefanb@linux.vnet.ibm.com>
References: <20190109221103.1897677-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010922-0016-0000-0000-000009725C22
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144159; UDB=6.00595717; IPR=6.00924421;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 22:11:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010922-0017-0000-0000-000041B5FFF3
Message-Id: <20190109221103.1897677-4-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPM PPI 1.3 defines operations up to number 101. We need to query up
to this number to show the user what the firmware implements.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm_ppi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index 68cab248ca23..72182b415c76 100644
--- a/drivers/char/tpm/tpm_ppi.c
+++ b/drivers/char/tpm/tpm_ppi.c
@@ -28,7 +28,7 @@
 #define TPM_PPI_FN_GETRSP	5
 #define TPM_PPI_FN_SUBREQ2	7
 #define TPM_PPI_FN_GETOPR	8
-#define PPI_TPM_REQ_MAX		22
+#define PPI_TPM_REQ_MAX		101 /* PPI 1.3 for TPM 2 */
 #define PPI_VS_REQ_START	128
 #define PPI_VS_REQ_END		255
 
-- 
2.17.1

