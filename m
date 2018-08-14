Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5ADC46470
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347EE216E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347EE216E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbeHNUy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:54:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728692AbeHNUy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:54:28 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7EI49Zj086715
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:06:09 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kv2854npm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:06:09 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <davidj@linux.ibm.com>;
        Tue, 14 Aug 2018 12:06:08 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Aug 2018 12:06:06 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7EI65BN19595284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Aug 2018 11:06:05 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CD60C6059;
        Tue, 14 Aug 2018 12:06:05 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91D79C6055;
        Tue, 14 Aug 2018 12:06:04 -0600 (MDT)
Received: from dev.watson.ibm.com (unknown [9.31.111.83])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 14 Aug 2018 12:06:04 -0600 (MDT)
From:   David Jacobson <davidj@linux.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     David Jacobson <david@davidej.com>, Petr Vorel <pvorel@suze.cz>,
        David Jacobson <davidj@linux.ibm.com>
Subject: [PATCH 7/7] emvtest: Add ability to run all tests
Date:   Tue, 14 Aug 2018 14:05:51 -0400
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180814180551.28311-1-davidj@linux.ibm.com>
References: <20180814180551.28311-1-davidj@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18081418-0020-0000-0000-00000E504FF5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009544; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01073490; UDB=6.00553126; IPR=6.00853448;
 MB=3.00022715; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-14 18:06:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081418-0021-0000-0000-000062ACFC8B
Message-Id: <20180814180551.28311-7-davidj@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808140185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

evmtest tests functionality of different IMA-Appraisal policies.

To simplify testing, this patch defines an evmtest config file.  This
allows for running all tests at once, rather than invoking each test
individually. Variables can be set once rather than specifying
parameters at runtime on the command line.

Signed-off-by: David Jacobson <davidj@linux.ibm.com>
---
 evmtest/README       | 19 +++++++++++++++--
 evmtest/evmtest      | 51 +++++++++++++++++++++++++++++++++++++++++++-
 evmtest/example.conf | 14 ++++++++++++
 3 files changed, 81 insertions(+), 3 deletions(-)
 create mode 100644 evmtest/example.conf

diff --git a/evmtest/README b/evmtest/README
index ac0c175..6f1c5c8 100644
--- a/evmtest/README
+++ b/evmtest/README
@@ -20,8 +20,8 @@ used to check a kernel's configuration and validate compatibility with IMA.
 COMMANDS
 --------
 
- runtest <test name> - Run a specific test
- runall <configuration> - Run all tests
+ runtest <test name> 	 - Run a specific test
+ runall  <configuration> - Run all tests
 
 OPTIONS
 -------
@@ -34,7 +34,21 @@ OPTIONS
  --vm				Validate compatibility with a virtual machine
 
 
+CONFIGURATION FILE
+------------------
+
+The `example.conf` provides a skeleton configuration file, where the only
+variable that *must* be defined is `IMA_KEY`.
+
+* `IMA_KEY` - The private key for the certificate on the IMA Trusted Keyring
 
+* `KBUILD_DIR` - Should point to a kernel build tree. If not provided, the test
+will use `/lib/modules/$(uname -r)/build`.
+
+* `KERN_IMAGE` - Should point towards an unsigned kernel image. If not provided,
+the test will attempt to use the running kernel.
+
+* `VERBOSE` - If set to 1, will add -v to all tests run
 
 BACKGROUND
 ----------
@@ -42,6 +56,7 @@ The Linux kernel needs to be configured properly with a key embedded into the
 kernel and loaded onto the `.builtin_trusted_keys` keyring at boot in order to
 run evmtest.
 
+
 === 1. Confirming the kernel is properly configured with IMA enabled.
 
 A number of Kconfig options need to be configured to enable IMA and permit
diff --git a/evmtest/evmtest b/evmtest/evmtest
index dfe39a9..74c829c 100755
--- a/evmtest/evmtest
+++ b/evmtest/evmtest
@@ -17,7 +17,7 @@ fi
 
 source $EVMDIR/files/common.sh
 usage (){
-	echo "Usage: evmtest [[runtest] <test_name>] [options]"
+	echo "Usage: evmtest [[runtest|runall] <test_name|config>] [options]"
 	echo ""
 	echo "Tests may be called directly by cd'ing to the evmtest directory:"
 	echo "$ cd $EVMDIR/functions"
@@ -69,6 +69,55 @@ elif [[ "$1" == "runtest" ]]; then
 		runtest $@
 		exit $?
 	fi
+elif [[ "$1" == "runall" ]]; then
+	if [[ -z $2 || ! -e $2 ]]; then
+		echo "evmtest runall <config file>"
+		echo "[!] Please provide a config file"
+		exit 1
+	fi
+	source $2 # Load in config
+	if [[ $VERBOSE -eq 1 ]]; then
+		V="-v"
+	fi
+
+	# Key is not optional
+	if [[ -z $IMA_KEY ]]; then
+		echo "[*] Please correct your config file"
+		exit 1
+	fi
+
+	EVMTEST_require_root
+	FAIL=0
+	echo "[*] Running tests..."
+	# 1
+	$EVMDIR/functions/r_env_validate.sh -r $V
+
+	# 2
+	if [[ -z $KERN_IMAGE ]]; then
+		$EVMDIR/functions/r_kexec_sig.sh -k $IMA_KEY $V
+	else
+		$EVMDIR/functions/r_kexec_sig.sh -k $IMA_KEY -i $KERN_IMAGE $V
+	fi
+	FAIL=$((FAIL+$?))
+	# 3
+	if [[ -z $KBUILD_DIR ]]; then
+		$EVMDIR/functions/r_kmod_sig.sh -k $IMA_KEY $V
+	else
+		$EVMDIR/functions/r_kmod_sig.sh -b $KBUILD_DIR -k $IMA_KEY $V
+	fi
+	FAIL=$((FAIL+$?))
+	# 4
+	$EVMDIR/functions/r_policy_sig.sh -k $IMA_KEY $V
+	FAIL=$((FAIL+$?))
+	# 5
+	$EVMDIR/functions/r_validate_boot_record.sh $V
+	FAIL=$((FAIL+$?))
+	# 6
+	$EVMDIR/functions/r_xattr_preserve.sh $V
+	FAIL=$((FAIL+$?))
+	echo "..."
+	echo "[*] TESTS PASSED: $((6-FAIL))"
+	echo "[*] TESTS FAILED: $FAIL"
 else
 	usage
 fi
diff --git a/evmtest/example.conf b/evmtest/example.conf
new file mode 100644
index 0000000..fd1c8fe
--- /dev/null
+++ b/evmtest/example.conf
@@ -0,0 +1,14 @@
+# This is an example config file
+# There are three variables that can be set when using evmtest runall
+
+#Set this to 1 for verbose output
+VERBOSE=0
+# Path to the private key for the IMA Trusted Keyring
+# This is required
+IMA_KEY=/path/to/your/ima_key
+
+# If this is not provided, tests will run but attempt to copy the running kernel
+KERN_IMAGE=/path/to/unsigned/kernel_image
+
+# If this is not defined, tests will try to find build tree
+KBUILD_DIR=/path/to/kernel/build/tree
-- 
2.17.1

