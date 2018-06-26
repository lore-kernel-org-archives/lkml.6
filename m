Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7109AC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2032D26E82
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2032D26E82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755091AbeFZTK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:10:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751885AbeFZTJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:09:42 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QJ8bwd124815
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 15:09:41 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2juu3q0ugq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 15:09:41 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 13:09:40 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 13:09:38 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QJ9bCN45547522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 12:09:37 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 925DD6A054;
        Tue, 26 Jun 2018 13:09:37 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A2366A04F;
        Tue, 26 Jun 2018 13:09:36 -0600 (MDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 13:09:36 -0600 (MDT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v7 1/5] tpm: rename tpm_chip_find_get() to tpm_find_get_ops()
Date:   Tue, 26 Jun 2018 15:09:29 -0400
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180626190933.2508821-1-stefanb@linux.vnet.ibm.com>
References: <20180626190933.2508821-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062619-8235-0000-0000-00000DC8C842
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052708; UDB=6.00539692; IPR=6.00830633;
 MB=3.00021866; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 19:09:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062619-8236-0000-0000-000041AA3CDF
Message-Id: <20180626190933.2508821-2-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename tpm_chip_find_get() to tpm_find_get_ops() to more closely match
the tpm_put_ops() counter part.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-chip.c      |  9 ++++++---
 drivers/char/tpm/tpm-interface.c | 14 +++++++-------
 drivers/char/tpm/tpm.h           |  2 +-
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 0a62c19937b6..242b716aed5e 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -81,18 +81,21 @@ void tpm_put_ops(struct tpm_chip *chip)
 EXPORT_SYMBOL_GPL(tpm_put_ops);
 
 /**
- * tpm_chip_find_get() - find and reserve a TPM chip
+ * tpm_find_get_ops() - find and reserve a TPM chip
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
  *
  * Finds a TPM chip and reserves its class device and operations. The chip must
- * be released with tpm_chip_put_ops() after use.
+ * be released with tpm_put_ops() after use.
+ * This function is for internal use only. It supports existing TPM callers
+ * by accepting NULL, but those callers should be converted to pass in a chip
+ * directly.
  *
  * Return:
  * A reserved &struct tpm_chip instance.
  * %NULL if a chip is not found.
  * %NULL if the chip is not available.
  */
-struct tpm_chip *tpm_chip_find_get(struct tpm_chip *chip)
+struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip)
 {
 	struct tpm_chip *res = NULL;
 	int chip_num = 0;
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index c43a9e28995e..b4bb34216050 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -929,7 +929,7 @@ int tpm_is_tpm2(struct tpm_chip *chip)
 {
 	int rc;
 
-	chip = tpm_chip_find_get(chip);
+	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 
@@ -953,7 +953,7 @@ int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
 {
 	int rc;
 
-	chip = tpm_chip_find_get(chip);
+	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
@@ -1012,7 +1012,7 @@ int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
 	u32 count = 0;
 	int i;
 
-	chip = tpm_chip_find_get(chip);
+	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 
@@ -1141,7 +1141,7 @@ int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
 {
 	int rc;
 
-	chip = tpm_chip_find_get(chip);
+	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 
@@ -1261,7 +1261,7 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 	if (!out || !num_bytes || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
-	chip = tpm_chip_find_get(chip);
+	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 
@@ -1323,7 +1323,7 @@ int tpm_seal_trusted(struct tpm_chip *chip, struct trusted_key_payload *payload,
 {
 	int rc;
 
-	chip = tpm_chip_find_get(chip);
+	chip = tpm_find_get_ops(chip);
 	if (!chip || !(chip->flags & TPM_CHIP_FLAG_TPM2))
 		return -ENODEV;
 
@@ -1351,7 +1351,7 @@ int tpm_unseal_trusted(struct tpm_chip *chip,
 {
 	int rc;
 
-	chip = tpm_chip_find_get(chip);
+	chip = tpm_find_get_ops(chip);
 	if (!chip || !(chip->flags & TPM_CHIP_FLAG_TPM2))
 		return -ENODEV;
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 7f2d0f489e9c..c38772474091 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -535,7 +535,7 @@ static inline void tpm_msleep(unsigned int delay_msec)
 		     delay_msec * 1000);
 };
 
-struct tpm_chip *tpm_chip_find_get(struct tpm_chip *chip);
+struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
 __must_check int tpm_try_get_ops(struct tpm_chip *chip);
 void tpm_put_ops(struct tpm_chip *chip);
 
-- 
2.17.1

