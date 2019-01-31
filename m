Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33D3C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF23218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfAaS4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:56:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728174AbfAaS4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:56:23 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0VIsAvc142498
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 13:56:22 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qc60cj45e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 13:56:21 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 31 Jan 2019 18:56:19 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 18:56:15 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0VIuE3q20054198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 18:56:15 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD45E4C044;
        Thu, 31 Jan 2019 18:56:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A19534C046;
        Thu, 31 Jan 2019 18:56:13 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.107.203])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Jan 2019 18:56:13 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        David Howells <dhowells@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 1/3] selftest/ima: cleanup the kexec selftest
Date:   Thu, 31 Jan 2019 13:55:34 -0500
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
References: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19013118-0020-0000-0000-0000030F7AEA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013118-0021-0000-0000-000021607FB9
Message-Id: <1548960936-7800-2-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=902 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the few bashisms in the script and use the complete option name
for clarity.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tools/testing/selftests/ima/test_kexec_load.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/ima/test_kexec_load.sh b/tools/testing/selftests/ima/test_kexec_load.sh
index 1c10093fb526..74423c4229e2 100755
--- a/tools/testing/selftests/ima/test_kexec_load.sh
+++ b/tools/testing/selftests/ima/test_kexec_load.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0+
 # Loading a kernel image via the kexec_load syscall should fail
-# when the kerne is CONFIG_KEXEC_VERIFY_SIG enabled and the system
+# when the kernel is CONFIG_KEXEC_VERIFY_SIG enabled and the system
 # is booted in secureboot mode.
 
 TEST="$0"
@@ -12,7 +12,7 @@ rc=0
 ksft_skip=4
 
 # kexec requires root privileges
-if [ $UID != 0 ]; then
+if [ $(id -ru) != 0 ]; then
 	echo "$TEST: must be run as root" >&2
 	exit $ksft_skip
 fi
@@ -33,17 +33,17 @@ secureboot=`hexdump $file | awk '{print substr($4,length($4),1)}'`
 
 # kexec_load should fail in secure boot mode
 KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
-kexec -l $KERNEL_IMAGE &>> /dev/null
-if [ $? == 0 ]; then
-	kexec -u
-	if [ "$secureboot" == "1" ]; then
+kexec --load $KERNEL_IMAGE 2>&1 /dev/null
+if [ $? -eq 0 ]; then
+	kexec --unload
+	if [ $secureboot -eq 1 ]; then
 		echo "$TEST: kexec_load succeeded [FAIL]"
 		rc=1
 	else
 		echo "$TEST: kexec_load succeeded [PASS]"
 	fi
 else
-	if [ "$secureboot" == "1" ]; then
+	if [ $secureboot -eq 1 ]; then
 		echo "$TEST: kexec_load failed [PASS]"
 	else
 		echo "$TEST: kexec_load failed [FAIL]"
-- 
2.7.5

