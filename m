Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2020282-1526368764-2-1452515631826547126
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526368764; b=CLBKmjJRYJsrqvxwnamq/ya2J9hJm8H8oQd9TvtCcgJIW58+Kj
    BImApN2JbiUEW8mNfIwtHCJhQ+ntfzsSkRcQ7v6hkxicXxUheNENRutjMPw9qPgY
    h0BYN50f7EwRWUAoHmrQ+tQPK8Hx6h12/YTyK3r2aSz4T9eNd6EWiqHJ60XJzZN4
    qgdk85OMV0vm8yr2ttxTi/sqLO1ulW+bmBNSktwG6H7heaPYNlUUtCnbux24le/O
    yOQcNp361ubSKRPzpVdlLwz0s7fjDyzKQYjCyS61TBmUEFhmSMPCutvgjornww0N
    FU7I1AK6FtuSThRkNhs60InmnMSOYuqMUqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526368764; bh=n0vdk3JOR8f9jZGSWMl9yCscwHRZDe
    dStp/m123nYMk=; b=LDpwQlsFFtjiJLSubnatzvsCSXn1wLodD1Kw0y9cZQ67Sw
    /bQrBQxn3hm538oTOwMxDtjRPj3OlpwuJNpAFAvg4eAW4CazjeMCugts/qPHYY+B
    hq7pAPyWW3r9Hit3G8R2dv0s2wD6DTVhyYhdb7ako4kYEMijkyBXbQMv3djyRtxA
    SbOrEuGDJqe9i4Dyynfm+fiE788hXKbMCpOxgikD2Ke7Gg3us9+AcHC7svjoPafW
    +i8u6M8JxDqpRYEu5zHTR0qKnFukFdh1Zqldc1vJV2Esg+Vh1/Q1yT54jYtIFLsb
    CEXUnIuyOXfIQ+XIElhFHlXFuT0W7GE3t8O8AH/w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJRTClP0mzfu/KAlFcVrowe1NIrJn0tTmu5exIPfy6GATCXotQDON8uMw9HSYRngPq9A8W3EwIg7mA+aHfMT/pGnJqrHJSh2vUMLKCJhcfXXryHr/5QE
    3ike4qNB1ixzIe1mpXV3+Z3rYRwnV+q29Nr0ADzrYjsCTedyJWBVDTTgsHdxk3ft8O/i6xKWFDajT8Glnad8y+LvUvIeLIhFP4wRns6XXthlwXs+PTo+jXtz
    h7y/Mi9pbsyW5El7ZcBQrA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VnNF1IyMAAAA:8
    a=VwQbUJbxAAAA:8 a=UG2gtfi55rRx2-XMXtkA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbeEOHTU (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 03:19:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752135AbeEOHTT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 May 2018 03:19:19 -0400
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v3] tpm: check selftest status before retrying full selftest
Date: Tue, 15 May 2018 12:47:12 +0530
X-Mailer: git-send-email 2.13.6
X-TM-AS-GCONF: 00
x-cbid: 18051507-0040-0000-0000-00000439E165
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051507-0041-0000-0000-0000263EEF39
Message-Id: <20180515071712.9331-1-nayna@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-15_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805150077
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

TPM 2.0 supports TPM2_GetTestResult[1], which can be used to check the
selftest status. This patch implements the tpm2_get_selftest_result()
function to check the selftest status before trying full selftest.

[1] As per TCG Specification, Trusted Platform Module Library,
Part 2 - Commands, Section 10.4:

"This command(TPM2_GetTestResult) returns manufacturer-specific information
regarding the results of a self-test and an indication of the test status.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
Tested-by: Mimi Zohar <zohar@linux.vnet.ibm.com> (on Pi with TPM 2.0)
Tested-by: Stefan Berger <stefanb@linux.vnet.ibm.com> (With QEMU with
swtpm TPM 2.0)
---

Changelog:

v3:
* modified to check the selftest status before full selftest command is run
* fixed the patch description
* includes Jarkko's feedbacks

v2:
* changed the subject and updated patch description
* removed the logs

 drivers/char/tpm/tpm.h      |  2 ++
 drivers/char/tpm/tpm2-cmd.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index af3bb87d3ea1..1de4240b52c4 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -114,6 +114,7 @@ enum tpm2_return_codes {
 	TPM2_RC_FAILURE		= 0x0101,
 	TPM2_RC_DISABLED	= 0x0120,
 	TPM2_RC_COMMAND_CODE    = 0x0143,
+	TPM2_RC_NEEDS_TEST      = 0x0153,
 	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
 	TPM2_RC_REFERENCE_H0	= 0x0910,
 	TPM2_RC_RETRY		= 0x0922,
@@ -144,6 +145,7 @@ enum tpm2_command_codes {
 	TPM2_CC_FLUSH_CONTEXT	= 0x0165,
 	TPM2_CC_GET_CAPABILITY	= 0x017A,
 	TPM2_CC_GET_RANDOM	= 0x017B,
+	TPM2_CC_GET_TEST_RESULT = 0x017C,
 	TPM2_CC_PCR_READ	= 0x017E,
 	TPM2_CC_PCR_EXTEND	= 0x0182,
 	TPM2_CC_LAST		= 0x018F,
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 96c77c8e7f40..811bcf221208 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -825,6 +825,43 @@ unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 EXPORT_SYMBOL_GPL(tpm2_calc_ordinal_duration);
 
 /**
+ * tpm2_get_selftest_result() - get the status of selftest
+ * @chip: TPM chip to use
+ *
+ * Return: TPM return code, errno otherwise
+ */
+static int tpm2_get_selftest_result(struct tpm_chip *chip)
+{
+	struct tpm_buf buf;
+	int rc;
+	int test_result;
+	uint16_t data_size;
+	int len;
+	const struct tpm_output_header *header;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_TEST_RESULT);
+	if (rc)
+		return rc;
+
+	len = tpm_transmit(chip, NULL, buf.data, PAGE_SIZE, 0);
+	if (len <  0)
+		return len;
+
+	header = (struct tpm_output_header *)buf.data;
+
+	rc = be32_to_cpu(header->return_code);
+	if (rc)
+		return rc;
+
+	data_size = be16_to_cpup((__be16 *)&buf.data[TPM_HEADER_SIZE]);
+
+	test_result = be32_to_cpup((__be32 *)
+			(&buf.data[TPM_HEADER_SIZE + 2 + data_size]));
+
+	return test_result;
+}
+
+/**
  * tpm2_do_selftest() - ensure that all self tests have passed
  *
  * @chip: TPM chip to use
@@ -857,6 +894,13 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
 			rc = TPM2_RC_SUCCESS;
 		if (rc == TPM2_RC_INITIALIZE || rc == TPM2_RC_SUCCESS)
 			return rc;
+
+		rc = tpm2_get_selftest_result(chip);
+		dev_dbg(&chip->dev, "self test result is %04x\n", rc);
+
+		if (rc == TPM2_RC_TESTING || rc == TPM2_RC_SUCCESS)
+			return TPM2_RC_SUCCESS;
+
 	}
 
 	return rc;
-- 
2.13.6

