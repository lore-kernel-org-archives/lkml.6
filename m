Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22049C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FD820685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfAIWLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:11:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727573AbfAIWLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:11:14 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09M9lJt117646
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 17:11:13 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pwru0srrk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 17:11:12 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 22:11:12 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 22:11:10 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09MB9ho20578446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 22:11:09 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A69ABE71E;
        Wed,  9 Jan 2019 22:11:09 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8CA7BE70F;
        Wed,  9 Jan 2019 22:11:08 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 22:11:08 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 2/5] tpm: ppi: rename TPM_PPI_REVISION_ID to TPM_PPI_REVISION_1
Date:   Wed,  9 Jan 2019 17:11:00 -0500
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190109221103.1897677-1-stefanb@linux.vnet.ibm.com>
References: <20190109221103.1897677-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010922-0016-0000-0000-000009725C20
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144159; UDB=6.00595717; IPR=6.00924421;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 22:11:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010922-0017-0000-0000-000041B5FFF1
Message-Id: <20190109221103.1897677-3-stefanb@linux.vnet.ibm.com>
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

TPM PPI 1.3 introduces a function revision 2 for some functions. So,
rename the existing TPM_PPI_REVISION_ID to TPM_PPI_REVISION_1.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm_ppi.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index 90b69aeadc99..68cab248ca23 100644
--- a/drivers/char/tpm/tpm_ppi.c
+++ b/drivers/char/tpm/tpm_ppi.c
@@ -20,7 +20,7 @@
 #include <linux/acpi.h>
 #include "tpm.h"
 
-#define TPM_PPI_REVISION_ID	1
+#define TPM_PPI_REVISION_1	1
 #define TPM_PPI_FN_VERSION	1
 #define TPM_PPI_FN_SUBREQ	2
 #define TPM_PPI_FN_GETREQ	3
@@ -61,7 +61,7 @@ static ssize_t tpm_show_ppi_request(struct device *dev,
 	struct tpm_chip *chip = to_tpm_chip(dev);
 
 	obj = tpm_eval_dsm(chip->acpi_dev_handle, TPM_PPI_FN_GETREQ,
-			   ACPI_TYPE_PACKAGE, NULL, TPM_PPI_REVISION_ID);
+			   ACPI_TYPE_PACKAGE, NULL, TPM_PPI_REVISION_1);
 	if (!obj)
 		return -ENXIO;
 
@@ -103,7 +103,7 @@ static ssize_t tpm_store_ppi_request(struct device *dev,
 	 * version 1.1
 	 */
 	if (acpi_check_dsm(chip->acpi_dev_handle, &tpm_ppi_guid,
-			   TPM_PPI_REVISION_ID, 1 << TPM_PPI_FN_SUBREQ2))
+			   TPM_PPI_REVISION_1, 1 << TPM_PPI_FN_SUBREQ2))
 		func = TPM_PPI_FN_SUBREQ2;
 
 	/*
@@ -125,7 +125,7 @@ static ssize_t tpm_store_ppi_request(struct device *dev,
 	}
 
 	obj = tpm_eval_dsm(chip->acpi_dev_handle, func, ACPI_TYPE_INTEGER,
-			   &argv4, TPM_PPI_REVISION_ID);
+			   &argv4, TPM_PPI_REVISION_1);
 	if (!obj) {
 		return -ENXIO;
 	} else {
@@ -169,7 +169,7 @@ static ssize_t tpm_show_ppi_transition_action(struct device *dev,
 	if (strcmp(chip->ppi_version, "1.2") < 0)
 		obj = &tmp;
 	obj = tpm_eval_dsm(chip->acpi_dev_handle, TPM_PPI_FN_GETACT,
-			   ACPI_TYPE_INTEGER, obj, TPM_PPI_REVISION_ID);
+			   ACPI_TYPE_INTEGER, obj, TPM_PPI_REVISION_1);
 	if (!obj) {
 		return -ENXIO;
 	} else {
@@ -195,7 +195,7 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
 	struct tpm_chip *chip = to_tpm_chip(dev);
 
 	obj = tpm_eval_dsm(chip->acpi_dev_handle, TPM_PPI_FN_GETRSP,
-			   ACPI_TYPE_PACKAGE, NULL, TPM_PPI_REVISION_ID);
+			   ACPI_TYPE_PACKAGE, NULL, TPM_PPI_REVISION_1);
 	if (!obj)
 		return -ENXIO;
 
@@ -263,7 +263,7 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
 		"User not required",
 	};
 
-	if (!acpi_check_dsm(dev_handle, &tpm_ppi_guid, TPM_PPI_REVISION_ID,
+	if (!acpi_check_dsm(dev_handle, &tpm_ppi_guid, TPM_PPI_REVISION_1,
 			    1 << TPM_PPI_FN_GETOPR))
 		return -EPERM;
 
@@ -272,7 +272,7 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
 		tmp.integer.value = i;
 		obj = tpm_eval_dsm(dev_handle, TPM_PPI_FN_GETOPR,
 				   ACPI_TYPE_INTEGER, &argv,
-				   TPM_PPI_REVISION_ID);
+				   TPM_PPI_REVISION_1);
 		if (!obj) {
 			return -ENOMEM;
 		} else {
@@ -338,12 +338,12 @@ void tpm_add_ppi(struct tpm_chip *chip)
 		return;
 
 	if (!acpi_check_dsm(chip->acpi_dev_handle, &tpm_ppi_guid,
-			    TPM_PPI_REVISION_ID, 1 << TPM_PPI_FN_VERSION))
+			    TPM_PPI_REVISION_1, 1 << TPM_PPI_FN_VERSION))
 		return;
 
 	/* Cache PPI version string. */
 	obj = acpi_evaluate_dsm_typed(chip->acpi_dev_handle, &tpm_ppi_guid,
-				      TPM_PPI_REVISION_ID, TPM_PPI_FN_VERSION,
+				      TPM_PPI_REVISION_1, TPM_PPI_FN_VERSION,
 				      NULL, ACPI_TYPE_STRING);
 	if (obj) {
 		strlcpy(chip->ppi_version, obj->string.pointer,
-- 
2.17.1

