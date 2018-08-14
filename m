Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE63C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C10E216E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C10E216E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbeHNUyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:54:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728811AbeHNUyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:54:16 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7EI49HS086718
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:05:57 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kv2854nes-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:05:57 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <davidj@linux.ibm.com>;
        Tue, 14 Aug 2018 12:05:56 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Aug 2018 12:05:54 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7EI5rX811010320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Aug 2018 11:05:53 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0902EC6057;
        Tue, 14 Aug 2018 12:05:53 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73FF4C6059;
        Tue, 14 Aug 2018 12:05:52 -0600 (MDT)
Received: from dev.watson.ibm.com (unknown [9.31.111.83])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 14 Aug 2018 12:05:52 -0600 (MDT)
From:   David Jacobson <davidj@linux.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     David Jacobson <david@davidej.com>, Petr Vorel <pvorel@suze.cz>,
        David Jacobson <davidj@linux.ibm.com>
Subject: [PATCH 1/7] evmtest: Regression testing Integrity Subsystem
Date:   Tue, 14 Aug 2018 14:05:45 -0400
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18081418-0020-0000-0000-00000E504FED
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009544; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01073490; UDB=6.00553126; IPR=6.00853448;
 MB=3.00022715; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-14 18:05:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081418-0021-0000-0000-000062ACFC6B
Message-Id: <20180814180551.28311-1-davidj@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808140185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the existing IMA/EVM features of the kernel mature, and new features are
being added, the number of kernel configuration options (Kconfig) and
methods for loading policies have been increasing. Rigorous testing of
the various IMA/EVM features is needed to ensure correct behavior and to
help avoid regressions.

Currently, only IMA-measurement can be tested (via LTP), a feature
introduced in Linux 2.6.30. Since then, IMA has grown to support
IMA-appraisal and IMA-audit. There are no LTP modules to test either of
these features.

This patchset introduces evmtest — a stand alone tool for regression
testing IMA. evmtest can be used to validate individual behaviors by
exercising execve, kexec, module load, and other LSM hooks.  evmtest
uses a combination of invalid signatures, invalid hashes, and unsigned
files to check that IMA-Appraisal catches all cases a running policy has
set. evmtest can also be used to validate that the kernel is properly
configured. For example, there are a number of Kconfig options that need
to be set, in addition to a local CA certificate being built-in or
memory reserved for embedding the certificate post-build.  evmtest
output is consistent. Consistent output allows evmtest to be plugged
into a testing framework/harness. Testing frameworks (such as xfstests)
require deterministic output. XFStests runs a test and compares its
output to a predefined value, created by running the test script under
conditions where it passes. evmtest provides output that can easily be
integrated with xfstests. All tests have a verbose mode (-v) that
outputs more information for debugging purposes.

New tests can be defined by placing them in the functions/ directory.
An "example_test.sh" script is provided for reference.

Example 1:
Successful example test output
$ evmtest runtest example_test -e /bin/bash
[*] Starting test: example_test
[*] TEST: PASSED

Example 1a: successful verbose example test output
$ evmtest runtest example_test -e /bin/bash -v
[*] Starting test: example_test
[*] Example file exists
[*] TEST: PASSED

Example 1b: failed verbose example test output
$ evmtest runtest example_test -e /bin/foo -v
[*] Starting test: example_test
[!] Example file does not exist
[!] TEST: FAILED

SYNOPSIS:
evmtest [runtest|help] test_name [test options]
options:
	-h,--help	Displays a help message
	-v,--verbose	Verbose logging for debugging

Signed-off-by: David Jacobson <davidj@linux.ibm.com>
---
 Makefile.am                         |   5 +-
 configure.ac                        |   1 +
 evmtest/INSTALL                     |  11 ++
 evmtest/Makefile.am                 |  23 ++++
 evmtest/README                      | 190 ++++++++++++++++++++++++++
 evmtest/evmtest                     |  74 ++++++++++
 evmtest/files/common.sh             |  49 +++++++
 evmtest/files/load_policy.sh        |  38 ++++++
 evmtest/functions/example_test.sh   |  75 ++++++++++
 evmtest/functions/r_env_validate.sh | 205 ++++++++++++++++++++++++++++
 10 files changed, 670 insertions(+), 1 deletion(-)
 create mode 100644 evmtest/INSTALL
 create mode 100644 evmtest/Makefile.am
 create mode 100644 evmtest/README
 create mode 100755 evmtest/evmtest
 create mode 100755 evmtest/files/common.sh
 create mode 100755 evmtest/files/load_policy.sh
 create mode 100755 evmtest/functions/example_test.sh
 create mode 100755 evmtest/functions/r_env_validate.sh

diff --git a/Makefile.am b/Makefile.am
index dba408d..0cb4111 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -36,4 +36,7 @@ rmman:
 
 doc: evmctl.1.html rmman evmctl.1
 
-.PHONY: $(tarname)
+evmtest:
+	$(MAKE) -C evmtest
+
+.PHONY: $(tarname) evmtest
diff --git a/configure.ac b/configure.ac
index a5b4288..59ec1d1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -52,6 +52,7 @@ EVMCTL_MANPAGE_DOCBOOK_XSL
 AC_CONFIG_FILES([Makefile
 		src/Makefile
 		packaging/ima-evm-utils.spec
+		evmtest/Makefile
 		])
 AC_OUTPUT
 
diff --git a/evmtest/INSTALL b/evmtest/INSTALL
new file mode 100644
index 0000000..699853e
--- /dev/null
+++ b/evmtest/INSTALL
@@ -0,0 +1,11 @@
+Installation Instructions
+-------------------------
+
+Basic Installation
+------------------
+
+From the root directory of ima-evm-utils, run the commands: `./autogen.sh`
+followed by `./configure`. `cd` to evmtest directory, execute `make`, and
+`sudo make install`.
+For details on how to use `evmtest` See the installed manpage or the README.
+There is an evmtest.html provided as well.
diff --git a/evmtest/Makefile.am b/evmtest/Makefile.am
new file mode 100644
index 0000000..388ead1
--- /dev/null
+++ b/evmtest/Makefile.am
@@ -0,0 +1,23 @@
+prefix=@prefix@
+datarootdir=@datarootdir@
+exec_prefix=@exec_prefix@
+bindir=@bindir@
+
+all: evmtest.1
+
+evmtest.1:
+	asciidoc -d manpage -b docbook -o evmtest.1.xsl README
+	asciidoc INSTALL
+	xsltproc --nonet -o $@ $(MANPAGE_DOCBOOK_XSL) evmtest.1.xsl
+	asciidoc -o evmtest.html README
+	rm -f evmtest.1.xsl
+install:
+	install -m 755 evmtest $(bindir)
+	install -d $(datarootdir)/evmtest/files/
+	install -d $(datarootdir)/evmtest/functions/
+	install -D $$(find ./files/ -not -type d)  $(datarootdir)/evmtest/files/
+	install -D ./functions/* $(datarootdir)/evmtest/functions/
+	cp evmtest.1 $(datarootdir)/man/man1
+	mandb -q
+
+.PHONY: install evmtest.1
diff --git a/evmtest/README b/evmtest/README
new file mode 100644
index 0000000..ac0c175
--- /dev/null
+++ b/evmtest/README
@@ -0,0 +1,190 @@
+evmtest(1)
+==========
+
+
+NAME
+----
+
+evmtest - IMA Regression Testing Utility
+
+SYNOPSIS
+--------
+evmtest <command> [OPTIONS]
+
+DESCRIPTION
+-----------
+
+evmtest can be used to verify various functionalities of IMA. It can also be
+used to check a kernel's configuration and validate compatibility with IMA.
+
+COMMANDS
+--------
+
+ runtest <test name> - Run a specific test
+ runall <configuration> - Run all tests
+
+OPTIONS
+-------
+ -v,--verbose			Verbose mode
+ -h,--help			Display help message
+ -i,--image			Kernel image
+ -k,--key			An IMA key
+ -c,--config			Kconfig for kernel build
+ -b,--kernel_build_directory    The path to a kernel build dir
+ --vm				Validate compatibility with a virtual machine
+
+
+
+
+BACKGROUND
+----------
+The Linux kernel needs to be configured properly with a key embedded into the
+kernel and loaded onto the `.builtin_trusted_keys` keyring at boot in order to
+run evmtest.
+
+=== 1. Confirming the kernel is properly configured with IMA enabled.
+
+A number of Kconfig options need to be configured to enable IMA and permit
+evmtest to validate IMA's functionality. (For directions on building a Linux
+kernel with IMA enabled, refer to the wiki[1].)
+To validate the kernel configuration based on its compatibility with IMA, use
+`evmtest runtest r_env_validate`. This can be called with the path to the kernel
+build as an argument, or the -r (--running) flag to validate the running
+kernel's configuration. To use the --running flag, IKCONFIG must be enabled as
+a Kconfig option, either builtin or as a module. An optional argument for this
+script is "--vm". This will check settings related to running the build in a
+virtual machine.
+
+
+=== 2. Creating a local CA Certificate
+
+IMA relies on two keyrings: `.builtin_trusted_keys` and `.ima.`
+`.builtin_trusted_keys` contains the certificate of the ephemeral key generated
+at build time to sign kernel modules. This section will describe the process of
+generating an "IMA local-CA key" to be placed on the same keyring as the
+kernel module signing key. The purpose of the IMA local CA key is to sign keys
+that will be placed on  the `.ima` keyring. These keys will then be used to sign
+files, kernel images, policies, and kernel modules.
+
+TIP: `man evmctl [GENERATE TRUSTED KEYS]` contains the exact commands needed to
+generate the IMA CA keypair, and IMA keypair used for signing files.
+
+Following these instructions should produce these three files:
+
+* `ima-local-ca.x509` - This will be placed on the .builtin_trusted_keys keyring
+
+* `ima-local-ca.priv` - This will be used in signing the IMA key
+
+* `ima-local-ca.pem`  - This will be placed on the  IMA Trusted keyring
+
+The process for creating an IMA key is described in the same section.
+
+Some distribution kernels reserve memory for inserting a certificate post-build.
+The directions in section 3a do not require rebuilding the kernel, just
+resigning it. For kernels which do not reserve memory for a certificate, see
+section 3b.
+
+
+=== 3a. Inserting a local CA certificate post build into the kernel.
+
+The first method for adding a key to the the .builtin_trusted_keys keyring is
+adding it to the kernel post-build. The following Kconfig options must be set.
+-------------
+CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
+CONFIG_SYSTEM_TRUSTED_KEYRING=y
+CONFIG_SYSTEM_TRUSTED_KEYS=" "
+-------------
+Navigate to the build, and:
+
+`scripts/insert-sys-cert -b vmlinux -c <path to ima-local-ca.pem>`
+
+Delete both:
+
+* arch/x86/boot/compressed/vmlinux
+
+* arch/x86/boot/bzImage
+
+Remake, install, and sign the kernel.
+When prompted for a key size, allot 4096 bytes.
+
+Boot, the key loading should be visible through dmesg.
+
+
+===  3b. Kernel build method for including a local CA certificate.
+
+The second method for adding a key to the .builtin_trusted_keys keyring is
+to include the certificate during the build. Set these Kconfig options:
+-------------
+CONFIG_SYSTEM_TRUSTED_KEYRING=y
+CONFIG_SYSTEM_TRUSTED_KEYS="<path to ima-local-ca.pem>"
+-------------
+Continue the build as normal, sign, and boot. The key loading should be visible
+through dmesg.
+
+
+=== 4. Boot options for running IMA
+
+When running IMA, and specifically evmtest, it is important to have the
+correct boot options. Boot with: `module.sig_enforce=1`. This tells the kernel
+to prevent the loading of any unsigned modules.
+
+When running evmtest, the kernel should be booted with no policy, however,
+for debugging purposes it may be to useful to boot with:
+`ima_policy=tcb`
+This instructs IMA to load a policy which measures all program's exec'd, files
+mmap'd for exec by any user, and all files opened for read by root (fowner=0).
+More documentation is available in the IMA docs.
+evmtest appends the policy during runtime to test specific behavior. For this
+reason, the builtin policy specified on the boot command line should not be
+replaced with a custom policy during boot.
+
+
+=== 5. Loading a certificate on the IMA trusted keyring
+
+(For key creation, see documentation in man evmctl.)
+
+Depending on the distribution, dracut may be enabled to load keys on the IMA
+keyring. Place the IMA keys in: `/etc/ima/keys`
+Reboot, and assuming dracut is enabled to load IMA keys, the key loading should
+be visible in dmesg. The key should also be visible on the `.ima` keyring.
+Verify using keyctl (`keyctl show %keyring:.ima`) or by cat'ing `/proc/keys`
+
+
+=== FAQ
+For questions regarding IMA see the IMA wiki.
+
+=== 1. What additional settings are needed when testing in a virtual machine?
+
+When building for a virtual machine, use the following Kconfig options:
+------------------
+CONFIG_BLK_MQ_VIRTIO=y
+CONFIG_MEMORY_BALLOON=y
+CONFIG_VIRTIO_BLK=y
+CONFIG_SCSI_VIRTIO=y
+CONFIG_HW_RANDOM_VIRTIO=y
+CONFIG_VIRTIO=y
+CONFIG_VIRTIO_MENU=y
+CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_PCI_LEGACY=y
+CONFIG_VIRTIO_BALLOON=y
+-------------------------
+
+=== 2. How can an IMA key be loaded without rebuilding dracut?
+
+First, get the `.ima` keyring ID:
+-------------------------
+keyctl show %keyring:.ima
+-------------------------
+The ID is the number that appears before the keyring description.
+------------------------------------------------
+evmctl import <path to ima key> <.ima keyring ID>
+------------------------------------------------
+This process can be scripted and added to startup/login
+
+== Reference
+
+1. https://sourceforge.net/p/linux-ima/wiki/Home/
+
+Author
+------
+David Jacobson - davidj@linux.ibm.com
diff --git a/evmtest/evmtest b/evmtest/evmtest
new file mode 100755
index 0000000..dfe39a9
--- /dev/null
+++ b/evmtest/evmtest
@@ -0,0 +1,74 @@
+#!/bin/bash
+
+# Initial set up
+DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # Current directory
+# Useful for development
+
+
+# Check to see if we're installed or not
+evmtest=$(type -p evmtest) # Find in path
+if [[ -e "${evmtest}" ]]; then
+	_evmdir=$(dirname ${evmtest})
+	prefix=${_evmdir%%/bin}
+	EVMDIR=${prefix}/share/evmtest
+else
+	EVMDIR=$DIR
+fi
+
+source $EVMDIR/files/common.sh
+usage (){
+	echo "Usage: evmtest [[runtest] <test_name>] [options]"
+	echo ""
+	echo "Tests may be called directly by cd'ing to the evmtest directory:"
+	echo "$ cd $EVMDIR/functions"
+	echo "$ ./<test_name>.sh [arg1] .. [arg2]"
+	echo "Options:"
+	echo "	-h,--help	Displays this help message"
+	echo "Tests available: [R] = Must be run as root"
+	echo ""
+
+	for test in $EVMDIR/functions/*.sh; do
+		test_name=${test/.sh/}
+		test_name=${test_name#$EVMDIR/functions/}
+		if [[ $test_name == r_* ]]; then # r_ = root test
+			root_required="[R]"
+		else
+			root_required="[ ]"
+		fi
+		echo "$root_required $test_name"
+		root_required="" # Reset
+	done
+}
+
+runtest (){
+	local test_name=$1
+	shift # Drop test_name
+
+	if [[ ! -e $EVMDIR/functions/$test_name.sh ]]; then
+		echo "[!] Test: "$test_name" not found"
+		usage
+		exit 1
+	else
+		# Invoke test & pass args, let the test parse args itself
+		($EVMDIR/functions/$test_name.sh $@)
+	fi
+}
+
+if [[ "$#" == 0 ]]; then
+	usage
+	exit 1
+elif [[ "$1" == "-h" || $1 == "--help" || $1 == "help" ]]; then
+	usage
+	exit 0
+elif [[ "$1" == "runtest" ]]; then
+	if [[ -z $2 ]]; then
+		echo "[!] Provide a test"
+		exit
+	else
+		shift # Drop runtest
+		runtest $@
+		exit $?
+	fi
+else
+	usage
+fi
diff --git a/evmtest/files/common.sh b/evmtest/files/common.sh
new file mode 100755
index 0000000..0fc3fd7
--- /dev/null
+++ b/evmtest/files/common.sh
@@ -0,0 +1,49 @@
+#!/bin/bash
+
+# This is the EVMTest common.sh file
+# This is sourced at the top of a test file to provide common variables,
+# paths, and functions.
+
+function EVMTEST_forbid_root {
+	if [[ $UID == 0 ]]; then
+		echo "[!] This test should not be run as root"
+		exit 1
+	fi
+}
+
+function EVMTEST_require_root {
+	if [[ $UID != 0 ]]; then
+		echo "[!] This test must be run as root"
+		exit 1
+	fi
+}
+
+# verbose_output function - will only echo output if verbose is true
+# otherwise, output is muted
+function v_out {
+	[ "$VERBOSE" != "0" ] && { echo "[*] $@" ; return ; }
+}
+
+# Function to fail a test
+function fail {
+	if [[ $VERBOSE != 0 ]]; then
+		if [[ ! -z "$@" ]]; then
+			echo "[!] $@"
+		fi
+	fi
+	echo "[*] TEST: FAILED"
+	exit 1
+}
+
+function begin {
+	echo "[*] Starting test: $TEST"
+}
+
+function passed {
+	echo "[*] TEST: PASSED"
+	exit 0
+}
+# Everything exported should be prefixed with EVMTEST_
+EVMTEST_SECFS_EXISTS=`findmnt securityfs`
+EVMTEST_SECFS=`findmnt -f -n securityfs -o TARGET`
+EVMTEST_BOOT_OPTS=`cat /proc/cmdline`
diff --git a/evmtest/files/load_policy.sh b/evmtest/files/load_policy.sh
new file mode 100755
index 0000000..e22ea21
--- /dev/null
+++ b/evmtest/files/load_policy.sh
@@ -0,0 +1,38 @@
+#!/bin/bash
+
+ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/.."
+source $ROOT/files/common.sh
+EVMTEST_require_root
+
+#This script loads the IMA policy either by replacing the builtin
+#policies specified on the boot command line or by appending the policy
+#rules to the existing custom policy.
+
+# This program assumes that the running kernel has been compiled with
+# CONFIG_IMA_WRITE_POLICY=y
+# To validate this, run env_validate <path_to_kernel_build>
+# Otherwise, this will fail
+
+if [[ "$#" !=  1 || "$1" == "-h" ]]; then
+	echo "load_policy - load an IMA policy."
+	echo "Usage: load_pol <policy pathname>"
+	exit
+fi
+
+IMA_POLICY_LOCATION=$EVMTEST_SECFS/ima/policy
+EVMTEST_POLICY_LOCATION="$( cd "$( dirname "${BASH_SOURCE[0]}" )" \
+	>/dev/null && pwd )/policies"
+if [[ ! -e $EVMTEST_POLICY_LOCATION/$1 ]]; then
+	echo "[!] Policy: $1 not found, ensure it is in files/policies"
+	exit 1
+fi
+TO_LOAD=$EVMTEST_POLICY_LOCATION/$1
+echo $TO_LOAD > $IMA_POLICY_LOCATION
+if [[ $? != 0 ]]; then
+	echo "[!] Load failed - see dmesg"
+	exit 1
+else
+	echo "[*] Policy update completed"
+fi
+
+exit 0
diff --git a/evmtest/functions/example_test.sh b/evmtest/functions/example_test.sh
new file mode 100755
index 0000000..d0cd4bc
--- /dev/null
+++ b/evmtest/functions/example_test.sh
@@ -0,0 +1,75 @@
+#!/bin/bash
+# Author: David Jacobson <davidj@linux.ibm.com>
+TEST="example_test"
+
+ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/.."
+source $ROOT/files/common.sh
+VERBOSE=0
+
+# This is an example test for documentation purposes.
+# This test describes the outline of evmtest test files.
+
+# Each file starts with a $TEST variable that gives the name of the test.
+# The next line should have the test author.
+# There are then the three bootstrap lines that follow
+# The first finds the current location of the script, so the needed files can
+# be found relative to it. The second line imports functions and variables
+# that are useful for writing tests. The third sets the output to silent.
+# After that, there is a 2-3 line description of the test.
+# Tests which require root should start with r_
+
+usage () {
+	echo ""
+	echo "example_test -e <example_file> [-vh]"
+	echo ""
+	echo "  This test is an example of how to structure an evmtest."
+	echo ""
+	echo "  -e,--example_file  Any file"
+	echo "  -v,--verbose    Verbose testing"
+	echo "  -h,--help       Displays this help message"
+	echo ""
+}
+
+# Define the usage
+TEMP=`getopt -o 'e:hv' -l 'example_file:,help,verbose' -n\
+	'example_test' -- "$@"`
+# letter followed by : means an argument is taken
+eval set -- "$TEMP"
+while true ; do
+	case "$1" in
+		-h|--help) usage; exit 0 ; shift;;
+		-e|--example_file) EXAMPLE_FILE=$2; shift 2;;
+		-v|--verbose)   VERBOSE=1; shift;;
+		--) shift; break;;
+		*) echo "[*] Unrecognized option $1"; exit 1 ;;
+	esac
+done
+
+# All arguments can be parsed like the above.
+# To require an argument, check that it has been defined. If it has not,
+# display usage and exit.
+if [[ -z $EXAMPLE_FILE ]]; then
+	usage
+	exit 1
+fi
+
+# Define how the test should be run:
+# The two options are: EVMTEST_forbid_root and EVMTEST_require_root
+EVMTEST_forbid_root
+
+# This function outputs that the test is starting:
+begin
+
+# Do whatever testing needs to be done
+if [[ -e $EXAMPLE_FILE ]]; then
+	# Output data for logging / debugging:
+	# [*] = Informative
+	# [!] = Attention Required
+	v_out "Example file exists"
+else
+	# Some condition failed, fail the test
+	fail "Example file does not exist"
+fi
+
+# If all has gone well until here - the test has passed
+passed
diff --git a/evmtest/functions/r_env_validate.sh b/evmtest/functions/r_env_validate.sh
new file mode 100755
index 0000000..19eb0f5
--- /dev/null
+++ b/evmtest/functions/r_env_validate.sh
@@ -0,0 +1,205 @@
+#!/bin/bash
+
+TEST="r_env_validate"
+ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/.."
+source $ROOT/files/common.sh
+VM_VALIDATE=0
+VERBOSE=0
+CONFIG_FILE=""
+# This test serves to validate a kernel build for running with EVMTEST
+# optional argument for validating compatibility with a VM
+
+usage () {
+	echo ""
+	echo "env_validate [-c <config>]|-r] [-vh]"
+	echo ""
+	echo "	This test will validate that a kernel build is compatible with"
+	echo "	evmtest, and is configured correctly. It can be pointed toward"
+	echo "	a build directory where a .config file is provided, or it can"
+	echo "	attempt to pull the config out of a running kernel."
+	echo ""
+	echo "	-c,--config	Kernel config file"
+	echo "	-r,--running	Will attempt to pull running config"
+	echo "	-V,--vm		Will validate that build is vm compatible"
+	echo "	-v,--verbose	Verbose testing [Do not use in test harness]"
+	echo "	-h,--help	Displays this help message"
+	echo ""
+
+}
+
+TEMP=`getopt -o 'hc:rVv' -l 'help,config:,running,vm,verbose' -n\
+		 'env_validate' -- "$@"`
+eval set -- "$TEMP"
+
+while true ; do
+	case "$1" in
+	-h|--help) usage; exit 0 ;;
+	-c|--config) CONFIG=$2; shift 2;;
+	-r|--running) RUNNING=1; shift;;
+	-V|--vm) VM_VALIDATE=1; shift;;
+	-v|--verbose)	VERBOSE=1; shift;;
+	--) shift; break;;
+	*) echo "[*] Unrecognized option $1"; exit 1 ;;
+	esac
+done
+
+# One must be defined
+if [[ -z $CONFIG && -z $RUNNING ]]; then
+	usage
+	exit 1
+# But not both
+elif [[ ! -z $CONFIG && ! -z $RUNNING ]]; then
+	usage
+	exit 1
+fi
+
+INVALID_DEFINITION=() # Variables that aren't assigned correctly
+NOT_DEFINED=() # Variables that need to be defined
+
+function validate {
+	# Test that a variable is defined, and that it has a certain
+	# value
+
+	eval value='$'$1
+	if [[ -z "$value" ]]; then
+		NOT_DEFINED+=( "$1" )
+	elif [[ "$value" != "$2" ]]; then
+		INVALID_DEFINITION+=( "$1" )
+	fi
+}
+
+function validate_defined {
+	# Test that a variable is defined - don't care specifically what that
+	# value is
+
+	eval value='$'$1
+	if [[ -z $value ]]; then
+		NOT_DEFINED+=( "$1" )
+	fi
+}
+
+begin
+
+# If we want to pull the running config
+if [[ ! -z $RUNNING ]]; then
+	EVMTEST_require_root
+	# If we are pulling the running config - root will be required
+	v_out "Trying to find running kernel configuration..."
+	CONFIG_FILE=`mktemp`
+	if [[ -f /proc/config.gz ]]; then
+		v_out "Located kernel config in /proc/config.gz"
+		gunzip -c /proc/config.gz > $CONFIG_FILE
+		v_out "Placed config in $CONFIG_FILE"
+	else
+		v_out "Trying to load configs module to expose config"
+		if [[ -e "/lib/modules/`uname -r`/kernel/kernel/configs.ko" ]];
+		then
+			modprobe configs &>> /dev/null
+
+			gunzip -c /proc/config.gz > $CONFIG_FILE
+		else
+
+			v_out "Could not load configs - kernel may not have"
+			v_out "compiled with ability to get config. Rebuild"
+			v_out "with CONFIG_IKCONFIG enabled."
+			v_out "modprobe loaded configs - reattempting read"
+		fi
+	fi
+fi
+
+if [[ ! -z $CONFIG ]]; then
+	CONFIG_FILE=$CONFIG
+fi
+
+if [[ ! -f $CONFIG_FILE ]]; then
+	fail "Could not find config file"
+fi
+
+v_out "Parsing .config file..."
+# Not safe to source .config file - this is a safer way of reading in variables
+IFS=$'\n'
+for line in $(grep -v -E "#" $CONFIG_FILE); do
+	declare $line
+done
+
+
+# Set all desired values below here
+v_out "Validating keyring configuration..."
+# Keyring configuration
+validate "CONFIG_SYSTEM_EXTRA_CERTIFICATE" "y"
+validate_defined "CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE"
+validate "CONFIG_SYSTEM_TRUSTED_KEYRING" "y"
+validate_defined "CONFIG_SYSTEM_TRUSTED_KEYS"
+
+v_out "Validating integrity configuration..."
+# Integrity configuration
+validate "CONFIG_INTEGRITY" "y"
+validate "CONFIG_INTEGRITY_SIGNATURE" "y"
+validate "CONFIG_INTEGRITY_ASYMMETRIC_KEYS" "y"
+validate "CONFIG_INTEGRITY_TRUSTED_KEYRING" "y"
+validate "CONFIG_INTEGRITY_AUDIT" "y"
+
+v_out "Validating IMA configuration..."
+# IMA configuration
+validate "CONFIG_IMA" "y"
+validate "CONFIG_IMA_MEASURE_PCR_IDX" "10"
+validate "CONFIG_IMA_LSM_RULES" "y"
+validate "CONFIG_IMA_SIG_TEMPLATE" "y"
+validate_defined "CONFIG_IMA_DEFAULT_TEMPLATE"
+validate_defined "CONFIG_IMA_DEFAULT_HASH_SHA256"
+validate_defined "CONFIG_IMA_DEFAULT_HASH"
+validate "CONFIG_IMA_WRITE_POLICY" "y"
+validate "CONFIG_IMA_READ_POLICY" "y"
+validate "CONFIG_IMA_APPRAISE" "y"
+validate "CONFIG_IMA_TRUSTED_KEYRING" "y"
+validate "CONFIG_IMA_LOAD_X509" "y"
+validate_defined "CONFIG_IMA_X509_PATH"
+
+v_out "Validating module signing configuration..."
+# Module signing configuration
+validate_defined "CONFIG_MODULE_SIG_KEY"
+validate "CONFIG_MODULE_SIG" "y"
+
+if [[ $VM_VALIDATE == 1 ]]; then
+	v_out "Validating VM configuration"
+
+	validate "CONFIG_BLK_MQ_VIRTIO" "y"
+	validate "CONFIG_MEMORY_BALLOON" "y"
+	validate "CONFIG_VIRTIO_BLK" "y"
+	validate "CONFIG_SCSI_VIRTIO" "y"
+	validate "CONFIG_HW_RANDOM_VIRTIO" "y"
+	validate "CONFIG_VIRTIO" "y"
+	validate "CONFIG_VIRTIO_MENU" "y"
+	validate "CONFIG_VIRTIO_PCI" "y"
+	validate "CONFIG_VIRTIO_PCI_LEGACY" "y"
+	validate "CONFIG_VIRTIO_BALLOON" "y"
+fi
+
+if [ ${#INVALID_DEFINITION[@]} != 0 ]; then
+	v_out "The following configuration variables have the wrong value"
+	for var in "${INVALID_DEFINITION[@]}"; do
+		eval value='$'$var
+		v_out "$var ($value)"
+	done
+fi
+
+if [ ${#NOT_DEFINED[@]} != 0 ]; then
+	v_out "The following configuration variables need to be defined"
+	for var in "${NOT_DEFINED[@]}"; do
+		v_out $var
+	done
+
+fi
+
+[[ "${#NOT_DEFINED[@]}" -eq 0 ]] && [[ "${#INVALID_DEFINITION[@]}" -eq 0 ]]
+code=$?
+
+if [[ ! -z $RUNNING ]]; then
+	rm $CONFIG_FILE
+fi
+
+if [[ $code == 0 ]]; then
+	passed
+else
+	fail
+fi
-- 
2.17.1

