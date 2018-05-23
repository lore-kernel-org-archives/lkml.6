Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3351567-1527035184-2-16257357868652532579
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527035183; b=nolIvcmkcSiNFoiZw7XH2NKdZL0RgB4TAIHX0Qkm52HPl4//GA
    RZpN9Ya4j3NCgLwEAdfWrQlHY33zSR9CCf1dQOXKtl0bXdFE7ZI8TPus33xFdyCH
    c2IHnPpWBa92SG2tKwvOoaJADIFtip2g6GQrcdhNd0JDWBNASdWaaLVod+rzKKZc
    bVZQCKahra0m5mK3Z1xQlXIEOQ1+bNFDjFiCxHn81bgI+9wZm/UB9OD0jOYMkEzC
    XAVyMURaVYZAid62TBw/eTQ8q38qXZJ6oXp+QGEmtgVP2NTbgBlfEGQWT6zGzUlg
    FPo2xLnSynaG+v237Gx+dengMnpyW1dxbzpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1527035183; bh=p
    CO9Jm4Jd+VbRMduHTyGnLRSRR9zNa7+VhyKsYZOkRo=; b=HHcqsbCaqjOrPNl5g
    GfcMRbzzeLuWDYOdl+deMrIufvLrj9GY6Kgz2LCkXd9US8dacMcr7bms8Dv6gNyz
    cNZPAcRZL9W3Nka0jEKtaxIBUIJG+Y5O2LKg0RIg7Vk/x/MQPxkRqubm1axPF6TK
    CrI6YX5hnGoOZQp8Kia8aXk0ZvpzVogyixcZBov/G5GqHy+vsON7dxgTgOn6ZHpF
    Ot0OG2O4oKH9p/WdWt3DN3dTD6S0XcjGtguvoUdVXjy98CyxhyFVwZxE4Y8sou6f
    wUowKLmRLEzPRq1bNDC2Ip8H6yR1Ibxd8yJTctiX5wppzfFCGCBtMZb4q4IHfDGm
    QWFwQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGodfJ+aqFEzxBzkLMHFh1kixMGnjguA4roYcC5yTEP/Y2I2TpUgGzyPbBHvxuf4ruToIje1ejRo27ywcOuLUrtyp3qN3YQmM4xC8lSLBrYZqKU1NrMM
    SDG5+xFPYMGFIDAwx3ZlvCj1ddgog9HjNyhY3G98wBtudaivJIEGTsmOcwO5Nv63xMmqf5zsMAM2MjDgSA0WcZSENGGZdyPOQzJk0vQk5l1oc+o/EPX/SaHk
    slsf0EAIm9M3P9kBo+JxuA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VnNF1IyMAAAA:8
    a=VwQbUJbxAAAA:8 a=qInLiUCBm633rOr1I4sA:9 a=DMoWH66i7oLVishk:21
    a=IaPrNXx5b6UKomN-:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753713AbeEWA0S (ORCPT <rfc822;linux@kroah.com>);
        Tue, 22 May 2018 20:26:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753695AbeEWA0N (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 May 2018 20:26:13 -0400
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v7 04/14] integrity: Introduce struct evm_xattr
Date: Tue, 22 May 2018 21:12:43 -0300
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180523001253.15247-1-bauerman@linux.ibm.com>
References: <20180523001253.15247-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052300-0024-0000-0000-0000187696E3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009068; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036241; UDB=6.00530093; IPR=6.00815369;
 MB=3.00021248; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-23 00:26:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052300-0025-0000-0000-0000501C2F47
Message-Id: <20180523001253.15247-5-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230002
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Even though struct evm_ima_xattr_data includes a fixed-size array to hold a
SHA1 digest, most of the code ignores the array and uses the struct to mean
"type indicator followed by data of unspecified size" and tracks the real
size of what the struct represents in a separate length variable.

The only exception to that is the EVM code, which correctly uses the
definition of struct evm_ima_xattr_data.

So make this explicit in the code by removing the length specification from
the array in struct evm_ima_xattr_data. Also, change the name of the
element from digest to data since in most places the array doesn't hold a
digest.

A separate struct evm_xattr is introduced, with the original definition of
evm_ima_xattr_data to be used in the places that actually expect that
definition.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 security/integrity/evm/evm_crypto.c   |  4 ++--
 security/integrity/evm/evm_main.c     | 10 +++++-----
 security/integrity/ima/ima_appraise.c |  7 ++++---
 security/integrity/integrity.h        |  5 +++++
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 494da5fcc092..c03ebb0c20b4 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -302,7 +302,7 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 			const char *xattr_value, size_t xattr_value_len)
 {
 	struct inode *inode = d_backing_inode(dentry);
-	struct evm_ima_xattr_data xattr_data;
+	struct evm_xattr xattr_data;
 	int rc = 0;
 
 	/*
@@ -318,7 +318,7 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 	rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
 			   xattr_value_len, xattr_data.digest);
 	if (rc == 0) {
-		xattr_data.type = EVM_XATTR_HMAC;
+		xattr_data.data.type = EVM_XATTR_HMAC;
 		rc = __vfs_setxattr_noperm(dentry, XATTR_NAME_EVM,
 					   &xattr_data,
 					   sizeof(xattr_data), 0);
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index f9eff5041e4c..65f9578be058 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -134,7 +134,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 					     struct integrity_iint_cache *iint)
 {
 	struct evm_ima_xattr_data *xattr_data = NULL;
-	struct evm_ima_xattr_data calc;
+	struct evm_xattr calc;
 	enum integrity_status evm_status = INTEGRITY_PASS;
 	struct inode *inode;
 	int rc, xattr_len;
@@ -167,7 +167,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 	/* check value type */
 	switch (xattr_data->type) {
 	case EVM_XATTR_HMAC:
-		if (xattr_len != sizeof(struct evm_ima_xattr_data)) {
+		if (xattr_len != sizeof(struct evm_xattr)) {
 			evm_status = INTEGRITY_FAIL;
 			goto out;
 		}
@@ -175,7 +175,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 				   xattr_value_len, calc.digest);
 		if (rc)
 			break;
-		rc = crypto_memneq(xattr_data->digest, calc.digest,
+		rc = crypto_memneq(xattr_data->data, calc.digest,
 			    sizeof(calc.digest));
 		if (rc)
 			rc = -EINVAL;
@@ -518,7 +518,7 @@ int evm_inode_init_security(struct inode *inode,
 				 const struct xattr *lsm_xattr,
 				 struct xattr *evm_xattr)
 {
-	struct evm_ima_xattr_data *xattr_data;
+	struct evm_xattr *xattr_data;
 	int rc;
 
 	if (!evm_key_loaded() || !evm_protected_xattr(lsm_xattr->name))
@@ -528,7 +528,7 @@ int evm_inode_init_security(struct inode *inode,
 	if (!xattr_data)
 		return -ENOMEM;
 
-	xattr_data->type = EVM_XATTR_HMAC;
+	xattr_data->data.type = EVM_XATTR_HMAC;
 	rc = evm_init_hmac(inode, lsm_xattr, xattr_data->digest);
 	if (rc < 0)
 		goto out;
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 8bd7a0733e51..a6b2995b7d0b 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -167,7 +167,8 @@ enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
 		return sig->hash_algo;
 		break;
 	case IMA_XATTR_DIGEST_NG:
-		ret = xattr_value->digest[0];
+		/* first byte contains algorithm id */
+		ret = xattr_value->data[0];
 		if (ret < HASH_ALGO__LAST)
 			return ret;
 		break;
@@ -175,7 +176,7 @@ enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
 		/* this is for backward compatibility */
 		if (xattr_len == 21) {
 			unsigned int zero = 0;
-			if (!memcmp(&xattr_value->digest[16], &zero, 4))
+			if (!memcmp(&xattr_value->data[16], &zero, 4))
 				return HASH_ALGO_MD5;
 			else
 				return HASH_ALGO_SHA1;
@@ -274,7 +275,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 			/* xattr length may be longer. md5 hash in previous
 			   version occupied 20 bytes in xattr, instead of 16
 			 */
-			rc = memcmp(&xattr_value->digest[hash_start],
+			rc = memcmp(&xattr_value->data[hash_start],
 				    iint->ima_hash->digest,
 				    iint->ima_hash->length);
 		else
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 0bb372eed62a..714fe2e135c7 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -78,6 +78,11 @@ enum evm_ima_xattr_type {
 
 struct evm_ima_xattr_data {
 	u8 type;
+	u8 data[];
+} __packed;
+
+struct evm_xattr {
+	struct evm_ima_xattr_data data;
 	u8 digest[SHA1_DIGEST_SIZE];
 } __packed;
 

