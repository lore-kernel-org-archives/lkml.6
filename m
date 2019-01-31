Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB54C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B622218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfAaS42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:56:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728209AbfAaS4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:56:24 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0VIs5vH034695
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 13:56:23 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qc5uku4kd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 13:56:23 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 31 Jan 2019 18:56:20 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 18:56:18 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0VIuHv27471378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 18:56:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C3614C04E;
        Thu, 31 Jan 2019 18:56:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D7404C04A;
        Thu, 31 Jan 2019 18:56:16 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.107.203])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Jan 2019 18:56:15 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        David Howells <dhowells@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 2/3] scripts/ima: define a set of common functions
Date:   Thu, 31 Jan 2019 13:55:35 -0500
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
References: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19013118-0020-0000-0000-0000030F7AEB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013118-0021-0000-0000-000021607FBB
Message-Id: <1548960936-7800-3-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=948 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define and move get_secureboot_mode() to a common file for use by other
tests.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tools/testing/selftests/ima/common_lib.sh      | 20 ++++++++++++++++++++
 tools/testing/selftests/ima/test_kexec_load.sh | 17 +++--------------
 2 files changed, 23 insertions(+), 14 deletions(-)
 create mode 100755 tools/testing/selftests/ima/common_lib.sh

diff --git a/tools/testing/selftests/ima/common_lib.sh b/tools/testing/selftests/ima/common_lib.sh
new file mode 100755
index 000000000000..ae097a634da5
--- /dev/null
+++ b/tools/testing/selftests/ima/common_lib.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+
+get_secureboot_mode()
+{
+	EFIVARFS="/sys/firmware/efi/efivars"
+	# Make sure that efivars is mounted in the normal location
+	if ! grep -q "^\S\+ $EFIVARFS efivarfs" /proc/mounts; then
+		echo "$TEST: efivars is not mounted on $EFIVARFS" >&2
+		exit $ksft_skip
+	fi
+
+	# Get secureboot mode
+	file="$EFIVARFS/SecureBoot-*"
+	if [ ! -e $file ]; then
+		echo "$TEST: unknown secureboot mode" >&2
+		exit $ksft_skip
+	fi
+	return `hexdump $file | awk '{print substr($4,length($4),1)}'`
+}
diff --git a/tools/testing/selftests/ima/test_kexec_load.sh b/tools/testing/selftests/ima/test_kexec_load.sh
index 74423c4229e2..5e3566738888 100755
--- a/tools/testing/selftests/ima/test_kexec_load.sh
+++ b/tools/testing/selftests/ima/test_kexec_load.sh
@@ -5,7 +5,7 @@
 # is booted in secureboot mode.
 
 TEST="$0"
-EFIVARFS="/sys/firmware/efi/efivars"
+. ./common_lib.sh
 rc=0
 
 # Kselftest framework requirement - SKIP code is 4.
@@ -17,19 +17,8 @@ if [ $(id -ru) != 0 ]; then
 	exit $ksft_skip
 fi
 
-# Make sure that efivars is mounted in the normal location
-if ! grep -q "^\S\+ $EFIVARFS efivarfs" /proc/mounts; then
-	echo "$TEST: efivars is not mounted on $EFIVARFS" >&2
-	exit $ksft_skip
-fi
-
-# Get secureboot mode
-file="$EFIVARFS/SecureBoot-*"
-if [ ! -e $file ]; then
-	echo "$TEST: unknown secureboot mode" >&2
-	exit $ksft_skip
-fi
-secureboot=`hexdump $file | awk '{print substr($4,length($4),1)}'`
+get_secureboot_mode
+secureboot=$?
 
 # kexec_load should fail in secure boot mode
 KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
-- 
2.7.5

