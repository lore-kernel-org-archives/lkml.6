Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3A9C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1D424BC3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1D424BC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752990AbeGCLT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:19:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752554AbeGCLT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:19:27 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63BIWbb133091
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 07:19:27 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0667571f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 07:19:27 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Tue, 3 Jul 2018 05:19:26 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 05:19:23 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63BJMGj11862508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 04:19:22 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9069D7805C;
        Tue,  3 Jul 2018 05:19:22 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C9657805F;
        Tue,  3 Jul 2018 05:19:22 -0600 (MDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 05:19:21 -0600 (MDT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH] ima: Remove unused is_ima_appraise_enabled() function.
Date:   Tue,  3 Jul 2018 07:19:17 -0400
X-Mailer: git-send-email 2.14.4
X-TM-AS-GCONF: 00
x-cbid: 18070311-0036-0000-0000-00000A0A3D9E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009300; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01055912; UDB=6.00541614; IPR=6.00833834;
 MB=3.00021975; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-03 11:19:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070311-0037-0000-0000-000047F7FB41
Message-Id: <20180703111917.3265212-1-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused is_ima_appraise_enabled() function.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 include/linux/ima.h                   |  6 ------
 security/integrity/ima/ima_appraise.c | 10 ----------
 2 files changed, 16 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 0e4647e0eb60..7f6952f8d6aa 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -75,17 +75,11 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
 #endif
 
 #ifdef CONFIG_IMA_APPRAISE
-extern bool is_ima_appraise_enabled(void);
 extern void ima_inode_post_setattr(struct dentry *dentry);
 extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		       const void *xattr_value, size_t xattr_value_len);
 extern int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name);
 #else
-static inline bool is_ima_appraise_enabled(void)
-{
-	return 0;
-}
-
 static inline void ima_inode_post_setattr(struct dentry *dentry)
 {
 	return;
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 8bd7a0733e51..7bf7fcacfdbb 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -33,16 +33,6 @@ static int __init default_appraise_setup(char *str)
 
 __setup("ima_appraise=", default_appraise_setup);
 
-/*
- * is_ima_appraise_enabled - return appraise status
- *
- * Only return enabled, if not in ima_appraise="fix" or "log" modes.
- */
-bool is_ima_appraise_enabled(void)
-{
-	return ima_appraise & IMA_APPRAISE_ENFORCE;
-}
-
 /*
  * ima_must_appraise - set appraise flag
  *
-- 
2.17.1

