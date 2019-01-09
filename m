Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC6CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0635C2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfAIWLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:11:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727648AbfAIWLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:11:19 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09M9nR6100256
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 17:11:18 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pws7vgrj5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 17:11:18 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 22:11:17 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 22:11:14 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09MBDST24641662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 22:11:13 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7728BE720;
        Wed,  9 Jan 2019 22:11:13 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77B7CBE70A;
        Wed,  9 Jan 2019 22:11:13 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 22:11:13 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 5/5] tpm: ppi: Enable submission of optional command parameter for PPI 1.3
Date:   Wed,  9 Jan 2019 17:11:03 -0500
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190109221103.1897677-1-stefanb@linux.vnet.ibm.com>
References: <20190109221103.1897677-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010922-0004-0000-0000-000014CFC6AC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144159; UDB=6.00595717; IPR=6.00924422;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 22:11:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010922-0005-0000-0000-00008A289693
Message-Id: <20190109221103.1897677-6-stefanb@linux.vnet.ibm.com>
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

This patch enables a user to specify the additional optional command
parameter by writing it into the request file:

   # echo "23 16" > request
   # cat request
   23 16

For backwards compatibility:

If only 1 parameter is given then we assume this is the operation request
number.

   # echo "5" > request

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm_ppi.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index ab61ee208125..a07bdf6a4ddf 100644
--- a/drivers/char/tpm/tpm_ppi.c
+++ b/drivers/char/tpm/tpm_ppi.c
@@ -121,9 +121,10 @@ static ssize_t tpm_store_ppi_request(struct device *dev,
 	u32 req;
 	u64 ret;
 	int func = TPM_PPI_FN_SUBREQ;
-	union acpi_object *obj, tmp;
-	union acpi_object argv4 = ACPI_INIT_DSM_ARGV4(1, &tmp);
+	union acpi_object *obj, tmp[2];
+	union acpi_object argv4 = ACPI_INIT_DSM_ARGV4(2, tmp);
 	struct tpm_chip *chip = to_tpm_chip(dev);
+	u64 rev = TPM_PPI_REVISION_1;
 
 	/*
 	 * the function to submit TPM operation request to pre-os environment
@@ -140,20 +141,29 @@ static ssize_t tpm_store_ppi_request(struct device *dev,
 	 * string/package type. For PPI version 1.0 and 1.1, use buffer type
 	 * for compatibility, and use package type since 1.2 according to spec.
 	 */
-	if (strcmp(chip->ppi_version, "1.2") < 0) {
+	if (strcmp(chip->ppi_version, "1.3") == 0) {
+		if (sscanf(buf, "%llu %llu", &tmp[0].integer.value,
+					     &tmp[1].integer.value) != 2)
+			goto ppi12;
+		rev = TPM_PPI_REVISION_2;
+		tmp[0].type = ACPI_TYPE_INTEGER;
+		tmp[1].type = ACPI_TYPE_INTEGER;
+	} else if (strcmp(chip->ppi_version, "1.2") < 0) {
 		if (sscanf(buf, "%d", &req) != 1)
 			return -EINVAL;
 		argv4.type = ACPI_TYPE_BUFFER;
 		argv4.buffer.length = sizeof(req);
 		argv4.buffer.pointer = (u8 *)&req;
 	} else {
-		tmp.type = ACPI_TYPE_INTEGER;
-		if (sscanf(buf, "%llu", &tmp.integer.value) != 1)
+ppi12:
+		argv4.package.count = 1;
+		tmp[0].type = ACPI_TYPE_INTEGER;
+		if (sscanf(buf, "%llu", &tmp[0].integer.value) != 1)
 			return -EINVAL;
 	}
 
 	obj = tpm_eval_dsm(chip->acpi_dev_handle, func, ACPI_TYPE_INTEGER,
-			   &argv4, TPM_PPI_REVISION_1);
+			   &argv4, rev);
 	if (!obj) {
 		return -ENXIO;
 	} else {
-- 
2.17.1

