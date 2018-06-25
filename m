Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B6EC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9898F25792
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9898F25792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932203AbeFYKnV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 06:43:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755299AbeFYKnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 06:43:20 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PAdiVI060496
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 06:43:20 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jtvqnxdca-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 06:43:20 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 06:43:17 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 06:43:15 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PAhEp36881570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 10:43:14 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E798AE062;
        Mon, 25 Jun 2018 06:43:08 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10DC2AE05C;
        Mon, 25 Jun 2018 06:43:08 -0400 (EDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 06:43:08 -0400 (EDT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v4 1/5] tpm: rename tpm_chip_find_get() to tpm_find_get_ops()
Date:   Mon, 25 Jun 2018 06:43:08 -0400
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180625104312.2213278-1-stefanb@linux.vnet.ibm.com>
References: <20180625104312.2213278-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062510-0064-0000-0000-0000031FEAA7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009251; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01052060; UDB=6.00539303; IPR=6.00829985;
 MB=3.00021846; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-25 10:43:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062510-0065-0000-0000-000039B59DAE
Message-Id: <20180625104312.2213278-2-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=995 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename tpm_chip_find_get() to tpm_find_get_ops() to more closely match
the tpm_put_ops() counter part.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
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

