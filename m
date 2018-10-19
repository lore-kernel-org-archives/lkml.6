Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BF4ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2904A21470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2904A21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeJSSXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 14:23:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726609AbeJSSXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 14:23:32 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9JADpqi146718
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 06:18:05 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n7bub40vt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 06:18:05 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Fri, 19 Oct 2018 06:18:04 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 19 Oct 2018 06:18:02 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9JAI1ko32047104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Oct 2018 10:18:01 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 037BDAE066;
        Fri, 19 Oct 2018 10:18:01 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDA40AE064;
        Fri, 19 Oct 2018 10:18:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 19 Oct 2018 10:18:00 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, jejb@linux.ibm.com,
        Alexander.Levin@microsoft.com, jsnitsel@redhat.com,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH] docs: Extend trusted keys documentation for TPM 2.0
Date:   Fri, 19 Oct 2018 06:17:58 -0400
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 18101910-0040-0000-0000-0000048339E8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009899; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01104879; UDB=6.00572019; IPR=6.00884930;
 MB=3.00023821; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-19 10:18:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101910-0041-0000-0000-0000088B5176
Message-Id: <20181019101758.1569-1-stefanb@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-18_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810190094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the documentation for trusted keys with documentation for how to
set up a key for a TPM 2.0 so it can be used with a TPM 2.0 as well.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../security/keys/trusted-encrypted.rst       | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 3bb24e09a332..6ec6bb2ac497 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -18,10 +18,33 @@ integrity verifications match.  A loaded Trusted Key can be updated with new
 when the kernel and initramfs are updated.  The same key can have many saved
 blobs under different PCR values, so multiple boots are easily supported.
 
+TPM 1.2
+-------
+
 By default, trusted keys are sealed under the SRK, which has the default
 authorization value (20 zeros).  This can be set at takeownership time with the
 trouser's utility: "tpm_takeownership -u -z".
 
+TPM 2.0
+-------
+
+The user must first create a storage key and make it persistent, so the key is
+available after reboot. This can be done using the following commands.
+
+With the IBM TSS 2 stack::
+
+  #> tsscreateprimary -hi o -st
+  Handle 80000000
+  #> tssevictcontrol -hi o -ho 80000000 -hp 81000001
+
+Or with the Intel TSS 2 stack::
+
+  #> tpm2_createprimary --hierarchy o -G rsa2048 -o key.ctxt
+  [...]
+  handle: 0x800000FF
+  #> tpm2_evictcontrol -c key.ctxt -p 0x81000001
+  persistentHandle: 0x81000001
+
 Usage::
 
     keyctl add trusted name "new keylen [options]" ring
@@ -30,7 +53,9 @@ Usage::
     keyctl print keyid
 
     options:
-       keyhandle=    ascii hex value of sealing key default 0x40000000 (SRK)
+       keyhandle=    ascii hex value of sealing key
+                       TPM 1.2: default 0x40000000 (SRK)
+                       TPM 2.0: no default; must be passed every time
        keyauth=	     ascii hex auth for sealing key default 0x00...i
                      (40 ascii zeros)
        blobauth=     ascii hex auth for sealed data default 0x00...
@@ -84,6 +109,10 @@ Examples of trusted and encrypted key usage:
 
 Create and save a trusted key named "kmk" of length 32 bytes::
 
+Note: When using a TPM 2.0 with a persistent key with handle 0x81000001,
+append 'keyhandle=0x81000001' to statements between quotes, such as
+"new 32 keyhandle=0x81000001".
+
     $ keyctl add trusted kmk "new 32" @u
     440502848
 
-- 
2.17.2

