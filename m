Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA38C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E3720856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfAQRlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:41:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729133AbfAQRln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:41:43 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0HHXgwf071935
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 12:41:42 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q2um704h7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 12:41:41 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Thu, 17 Jan 2019 17:41:41 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Jan 2019 17:41:38 -0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0HHfbjf8060994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 17:41:38 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D817A28059;
        Thu, 17 Jan 2019 17:41:37 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C128428065;
        Thu, 17 Jan 2019 17:41:37 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 17 Jan 2019 17:41:37 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 2/5] tpm: ppi: rename TPM_PPI_REVISION_ID to TPM_PPI_REVISION_ID_1
Date:   Thu, 17 Jan 2019 12:41:32 -0500
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190117174135.2117937-1-stefanb@linux.ibm.com>
References: <20190117174135.2117937-1-stefanb@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011717-0052-0000-0000-0000037A06D1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010425; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01147865; UDB=6.00597964; IPR=6.00928163;
 MB=3.00025175; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-17 17:41:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011717-0053-0000-0000-00005F80BC89
Message-Id: <20190117174135.2117937-3-stefanb@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPM PPI 1.3 introduces a function revision 2 for some functions. So,
rename the existing TPM_PPI_REVISION_ID to TPM_PPI_REVISION_ID_1.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: David Safford <david.safford@ge.com>
---
 drivers/char/tpm/tpm_ppi.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index 90b69aeadc99..88ecdae1df03 100644
--- a/drivers/char/tpm/tpm_ppi.c
+++ b/drivers/char/tpm/tpm_ppi.c
@@ -20,7 +20,7 @@
 #include <linux/acpi.h>
 #include "tpm.h"
 
-#define TPM_PPI_REVISION_ID	1
+#define TPM_PPI_REVISION_ID_1	1
 #define TPM_PPI_FN_VERSION	1
 #define TPM_PPI_FN_SUBREQ	2
 #define TPM_PPI_FN_GETREQ	3
@@ -61,7 +61,7 @@ static ssize_t tpm_show_ppi_request(struct device *dev,
 	struct tpm_chip *chip = to_tpm_chip(dev);
 
 	obj = tpm_eval_dsm(chip->acpi_dev_handle, TPM_PPI_FN_GETREQ,
-			   ACPI_TYPE_PACKAGE, NULL, TPM_PPI_REVISION_ID);
+			   ACPI_TYPE_PACKAGE, NULL, TPM_PPI_REVISION_ID_1);
 	if (!obj)
 		return -ENXIO;
 
@@ -103,7 +103,7 @@ static ssize_t tpm_store_ppi_request(struct device *dev,
 	 * version 1.1
 	 */
 	if (acpi_check_dsm(chip->acpi_dev_handle, &tpm_ppi_guid,
-			   TPM_PPI_REVISION_ID, 1 << TPM_PPI_FN_SUBREQ2))
+			   TPM_PPI_REVISION_ID_1, 1 << TPM_PPI_FN_SUBREQ2))
 		func = TPM_PPI_FN_SUBREQ2;
 
 	/*
@@ -125,7 +125,7 @@ static ssize_t tpm_store_ppi_request(struct device *dev,
 	}
 
 	obj = tpm_eval_dsm(chip->acpi_dev_handle, func, ACPI_TYPE_INTEGER,
-			   &argv4, TPM_PPI_REVISION_ID);
+			   &argv4, TPM_PPI_REVISION_ID_1);
 	if (!obj) {
 		return -ENXIO;
 	} else {
@@ -169,7 +169,7 @@ static ssize_t tpm_show_ppi_transition_action(struct device *dev,
 	if (strcmp(chip->ppi_version, "1.2") < 0)
 		obj = &tmp;
 	obj = tpm_eval_dsm(chip->acpi_dev_handle, TPM_PPI_FN_GETACT,
-			   ACPI_TYPE_INTEGER, obj, TPM_PPI_REVISION_ID);
+			   ACPI_TYPE_INTEGER, obj, TPM_PPI_REVISION_ID_1);
 	if (!obj) {
 		return -ENXIO;
 	} else {
@@ -195,7 +195,7 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
 	struct tpm_chip *chip = to_tpm_chip(dev);
 
 	obj = tpm_eval_dsm(chip->acpi_dev_handle, TPM_PPI_FN_GETRSP,
-			   ACPI_TYPE_PACKAGE, NULL, TPM_PPI_REVISION_ID);
+			   ACPI_TYPE_PACKAGE, NULL, TPM_PPI_REVISION_ID_1);
 	if (!obj)
 		return -ENXIO;
 
@@ -263,7 +263,7 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
 		"User not required",
 	};
 
-	if (!acpi_check_dsm(dev_handle, &tpm_ppi_guid, TPM_PPI_REVISION_ID,
+	if (!acpi_check_dsm(dev_handle, &tpm_ppi_guid, TPM_PPI_REVISION_ID_1,
 			    1 << TPM_PPI_FN_GETOPR))
 		return -EPERM;
 
@@ -272,7 +272,7 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
 		tmp.integer.value = i;
 		obj = tpm_eval_dsm(dev_handle, TPM_PPI_FN_GETOPR,
 				   ACPI_TYPE_INTEGER, &argv,
-				   TPM_PPI_REVISION_ID);
+				   TPM_PPI_REVISION_ID_1);
 		if (!obj) {
 			return -ENOMEM;
 		} else {
@@ -338,12 +338,13 @@ void tpm_add_ppi(struct tpm_chip *chip)
 		return;
 
 	if (!acpi_check_dsm(chip->acpi_dev_handle, &tpm_ppi_guid,
-			    TPM_PPI_REVISION_ID, 1 << TPM_PPI_FN_VERSION))
+			    TPM_PPI_REVISION_ID_1, 1 << TPM_PPI_FN_VERSION))
 		return;
 
 	/* Cache PPI version string. */
 	obj = acpi_evaluate_dsm_typed(chip->acpi_dev_handle, &tpm_ppi_guid,
-				      TPM_PPI_REVISION_ID, TPM_PPI_FN_VERSION,
+				      TPM_PPI_REVISION_ID_1,
+				      TPM_PPI_FN_VERSION,
 				      NULL, ACPI_TYPE_STRING);
 	if (obj) {
 		strlcpy(chip->ppi_version, obj->string.pointer,
-- 
2.13.6

