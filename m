Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91126C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616AF218D0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfBZX1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:27:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729364AbfBZX1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:27:52 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QNO7f0021297
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 18:27:51 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qwc6f1751-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 18:27:50 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 26 Feb 2019 23:27:48 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Feb 2019 23:27:46 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1QNRjkK32506058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 23:27:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD077A4051;
        Tue, 26 Feb 2019 23:27:45 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E0F9A4040;
        Tue, 26 Feb 2019 23:27:45 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.106.105])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Feb 2019 23:27:44 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v2 3/5] selftests/ima: define common logging functions
Date:   Tue, 26 Feb 2019 18:26:58 -0500
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
References: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19022623-0008-0000-0000-000002C54C64
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022623-0009-0000-0000-00002231977C
Message-Id: <1551223620-11586-4-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=879 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902260158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define log_info, log_pass, log_fail, and log_skip functions.

Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tools/testing/selftests/ima/common_lib.sh      | 43 +++++++++++++++++++++++---
 tools/testing/selftests/ima/test_kexec_load.sh | 19 +++---------
 2 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/ima/common_lib.sh b/tools/testing/selftests/ima/common_lib.sh
index 5583ea74c14e..c6d04006281d 100755
--- a/tools/testing/selftests/ima/common_lib.sh
+++ b/tools/testing/selftests/ima/common_lib.sh
@@ -1,5 +1,36 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Kselftest framework defines: ksft_pass=0, ksft_fail=1, ksft_skip=4
+
+VERBOSE="${VERBOSE:-1}"
+
+log_info()
+{
+	[ $VERBOSE -ne 0 ] && echo "[INFO] $1"
+}
+
+# The ksefltest framework requirement returns 0 for PASS.
+log_pass()
+{
+
+	[ $VERBOSE -ne 0 ] && echo "$1 [PASS]"
+	exit 0
+}
+
+# The ksefltest framework requirement returns 1 for FAIL.
+log_fail()
+{
+	[ $VERBOSE -ne 0 ] && echo "$1 [FAIL]"
+	exit 1
+}
+
+# The ksefltest framework requirement returns 4 for SKIP.
+log_skip()
+{
+	[ $VERBOSE -ne 0 ] && echo "$1"
+	exit 4
+}
 
 # The secure boot mode can be accessed either as the last integer
 # of "od -An -t u1 /sys/firmware/efi/efivars/SecureBoot-*" or from
@@ -8,17 +39,19 @@
 get_secureboot_mode()
 {
 	local efivarfs="/sys/firmware/efi/efivars"
+
 	# Make sure that efivars is mounted in the normal location
 	if ! grep -q "^\S\+ $efivarfs efivarfs" /proc/mounts; then
-		echo "$TEST: efivars is not mounted on $efivarfs" >&2
-		exit $ksft_skip
+		log_skip "efivars is not mounted on $efivarfs"
 	fi
 
 	# Get secureboot mode
 	local file="$efivarfs/../vars/SecureBoot-*/data"
 	if [ ! -e $file ]; then
-		echo "$TEST: unknown secureboot mode" >&2
-		exit $ksft_skip
+		log_skip "unknown secureboot mode"
 	fi
-	return `od -An -t u1 /sys/firmware/efi/vars/SecureBoot-*/data`
+	ret=`od -An -t u1 /sys/firmware/efi/vars/SecureBoot-*/data`
+	[ $ret -eq 1 ] && log_info "secure boot mode enabled"
+
+	return $ret
 }
diff --git a/tools/testing/selftests/ima/test_kexec_load.sh b/tools/testing/selftests/ima/test_kexec_load.sh
index 35934e0665f1..8b99017538ba 100755
--- a/tools/testing/selftests/ima/test_kexec_load.sh
+++ b/tools/testing/selftests/ima/test_kexec_load.sh
@@ -6,15 +6,10 @@
 
 TEST="$0"
 . ./common_lib.sh
-rc=0
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
 
 # kexec requires root privileges
 if [ $(id -ru) -ne 0 ]; then
-	echo "$TEST: requires root privileges" >&2
-	exit $ksft_skip
+	log_skip "requires root privileges" >&2
 fi
 
 get_secureboot_mode
@@ -26,18 +21,14 @@ kexec --load $KERNEL_IMAGE 2>&1 > /dev/null
 if [ $? -eq 0 ]; then
 	kexec --unload
 	if [ $secureboot -eq 1 ]; then
-		echo "$TEST: kexec_load succeeded [FAIL]"
-		rc=1
+		log_fail "kexec_load succeeded"
 	else
-		echo "$TEST: kexec_load succeeded [PASS]"
+		log_pass "kexec_load succeeded"
 	fi
 else
 	if [ $secureboot -eq 1 ]; then
-		echo "$TEST: kexec_load failed [PASS]"
+		log_pass "kexec_load failed"
 	else
-		echo "$TEST: kexec_load failed [FAIL]"
-		rc=1
+		log_fail "kexec_load failed"
 	fi
 fi
-
-exit $rc
-- 
2.7.5

