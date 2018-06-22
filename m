Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1594C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5E024429
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5E024429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933583AbeFVOza (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:55:30 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:34449 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbeFVOz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:55:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id EAEBD41939;
        Fri, 22 Jun 2018 14:55:27 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id R-QJ8O8mObKW; Fri, 22 Jun 2018 14:55:27 +0000 (UTC)
Received: from [172.20.4.200] (unknown [50.236.218.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 8D779418E7;
        Fri, 22 Jun 2018 14:55:22 +0000 (UTC)
To:     torvalds@linux-foundation.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, davem@davemloft.net
From:   Shuah Khan <shuah@kernel.org>
Subject: [GIT PULL] kselftest fixes update for Linux 4.18-rc2
Message-ID: <c25e444d-734b-34be-2221-783d2dd78fa6@kernel.org>
Date:   Fri, 22 Jun 2018 08:54:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------499CE756772C2F1CD24CB6D9"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------499CE756772C2F1CD24CB6D9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following kselftest fixes update for Linux 4.18-rc2

This Kselftest fixes update for Linux 4.18-rc2:

- Fixes new sparc64 adi driver test compile errors on non-sparc systems.
- Fixes config fragment for sync framework for improved test coverage.
- Fixes several tests to return correct Kselftest skip code.

I included a patch that adds missing SPDX license text in the Makefile for
the new Sparc64 test that went into 4.18-rc1. It should have been added in
the final version of the patches that went into 4.18-rc1.

diff is attached.

thanks,
-- Shuah

-----------------------------------------------------------------------------
The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-4.18-rc2

for you to fetch changes up to eb83d5f7d07ed913d62ca4ad1e14fb6ca4937bab:

  selftests: sparc64: Add missing SPDX License Identifiers (2018-06-18 09:29:20 -0600)

----------------------------------------------------------------
linux-kselftest-4.18-rc2

This Kselftest fixes update for Linux 4.18-rc2:

- Fixes new sparc64 adi driver test compile errors on non-sparc systems.
- Fixes config fragment for sync framework for improved test coverage.
- Fixes several tests to return correct Kselftest skip code.

----------------------------------------------------------------
Fathi Boudra (1):
      selftests: sync: add config fragment for testing sync framework

Shuah Khan (Samsung OSG) (9):
      selftests: pstore: return Kselftest Skip code for skipped tests
      selftests: static_keys: return Kselftest Skip code for skipped tests
      selftests: sysctl: return Kselftest Skip code for skipped tests
      selftests: user: return Kselftest Skip code for skipped tests
      selftests: zram: return Kselftest Skip code for skipped tests
      selftests: vm: return Kselftest Skip code for skipped tests
      selftests: sparc64: Fix to do nothing on non-sparc64
      selftests: sparc64: delete RUN_TESTS and EMIT_TESTS overrides
      selftests: sparc64: Add missing SPDX License Identifiers

 .../selftests/pstore/pstore_post_reboot_tests        |  5 ++++-
 tools/testing/selftests/sparc64/Makefile             | 20 ++++++++++++--------
 tools/testing/selftests/sparc64/drivers/Makefile     |  2 +-
 .../selftests/static_keys/test_static_keys.sh        | 13 +++++++++++++
 tools/testing/selftests/sync/config                  |  4 ++++
 tools/testing/selftests/sysctl/sysctl.sh             | 20 +++++++++++++-------
tools/testing/selftests/user/test_user_copy.sh       |  7 +++++++
 tools/testing/selftests/vm/compaction_test.c         |  4 +++-
 tools/testing/selftests/vm/mlock2-tests.c            | 12 +++++++-----
 tools/testing/selftests/vm/run_vmtests               |  5 ++++-
 tools/testing/selftests/vm/userfaultfd.c             |  4 +++-
 tools/testing/selftests/zram/zram.sh                 |  5 ++++-
 tools/testing/selftests/zram/zram_lib.sh             |  5 ++++-
 13 files changed, 79 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/sync/config
-----------------------------------------------------------------------------

--------------499CE756772C2F1CD24CB6D9
Content-Type: text/x-patch;
 name="linux-kselftest-4.18-rc2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-4.18-rc2.diff"

diff --git a/tools/testing/selftests/pstore/pstore_post_reboot_tests b/tools/testing/selftests/pstore/pstore_post_reboot_tests
index 6ccb154cb4aa..22f8df1ad7d4 100755
--- a/tools/testing/selftests/pstore/pstore_post_reboot_tests
+++ b/tools/testing/selftests/pstore/pstore_post_reboot_tests
@@ -7,13 +7,16 @@
 #
 # Released under the terms of the GPL v2.
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 . ./common_tests
 
 if [ -e $REBOOT_FLAG  ]; then
     rm $REBOOT_FLAG
 else
     prlog "pstore_crash_test has not been executed yet. we skip further tests."
-    exit 0
+    exit $ksft_skip
 fi
 
 prlog -n "Mounting pstore filesystem ... "
diff --git a/tools/testing/selftests/sparc64/Makefile b/tools/testing/selftests/sparc64/Makefile
index 2082eeffd779..a19531dba4dc 100644
--- a/tools/testing/selftests/sparc64/Makefile
+++ b/tools/testing/selftests/sparc64/Makefile
@@ -1,7 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e s/x86_64/x86/)
+
+ifneq ($(ARCH),sparc64)
+nothing:
+.PHONY: all clean run_tests install
+.SILENT:
+else
+
 SUBDIRS := drivers
 
 TEST_PROGS := run.sh
 
+
 .PHONY: all clean
 
 include ../lib.mk
@@ -18,10 +29,6 @@ all:
 		fi \
 	done
 
-override define RUN_TESTS
-	@cd $(OUTPUT); ./run.sh
-endef
-
 override define INSTALL_RULE
 	mkdir -p $(INSTALL_PATH)
 	install -t $(INSTALL_PATH) $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)
@@ -33,10 +40,6 @@ override define INSTALL_RULE
 	done;
 endef
 
-override define EMIT_TESTS
-	echo "./run.sh"
-endef
-
 override define CLEAN
 	@for DIR in $(SUBDIRS); do		\
 		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
@@ -44,3 +47,4 @@ override define CLEAN
 		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
 	done
 endef
+endif
diff --git a/tools/testing/selftests/sparc64/drivers/Makefile b/tools/testing/selftests/sparc64/drivers/Makefile
index 6264f40bbdbc..deb0df415565 100644
--- a/tools/testing/selftests/sparc64/drivers/Makefile
+++ b/tools/testing/selftests/sparc64/drivers/Makefile
@@ -1,4 +1,4 @@
-
+# SPDX-License-Identifier: GPL-2.0
 INCLUDEDIR := -I.
 CFLAGS := $(CFLAGS) $(INCLUDEDIR) -Wall -O2 -g
 
diff --git a/tools/testing/selftests/static_keys/test_static_keys.sh b/tools/testing/selftests/static_keys/test_static_keys.sh
index 24cff498b31a..fc9f8cde7d42 100755
--- a/tools/testing/selftests/static_keys/test_static_keys.sh
+++ b/tools/testing/selftests/static_keys/test_static_keys.sh
@@ -2,6 +2,19 @@
 # SPDX-License-Identifier: GPL-2.0
 # Runs static keys kernel module tests
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+if ! /sbin/modprobe -q -n test_static_key_base; then
+	echo "static_key: module test_static_key_base is not found [SKIP]"
+	exit $ksft_skip
+fi
+
+if ! /sbin/modprobe -q -n test_static_keys; then
+	echo "static_key: module test_static_keys is not found [SKIP]"
+	exit $ksft_skip
+fi
+
 if /sbin/modprobe -q test_static_key_base; then
 	if /sbin/modprobe -q test_static_keys; then
 		echo "static_key: ok"
diff --git a/tools/testing/selftests/sync/config b/tools/testing/selftests/sync/config
new file mode 100644
index 000000000000..1ab7e8130db2
--- /dev/null
+++ b/tools/testing/selftests/sync/config
@@ -0,0 +1,4 @@
+CONFIG_STAGING=y
+CONFIG_ANDROID=y
+CONFIG_SYNC=y
+CONFIG_SW_SYNC=y
diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index ec232c3cfcaa..584eb8ea780a 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -14,6 +14,9 @@
 
 # This performs a series tests against the proc sysctl interface.
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 TEST_NAME="sysctl"
 TEST_DRIVER="test_${TEST_NAME}"
 TEST_DIR=$(dirname $0)
@@ -41,7 +44,7 @@ test_modprobe()
                echo "$0: $DIR not present" >&2
                echo "You must have the following enabled in your kernel:" >&2
                cat $TEST_DIR/config >&2
-               exit 1
+               exit $ksft_skip
        fi
 }
 
@@ -98,28 +101,30 @@ test_reqs()
 	uid=$(id -u)
 	if [ $uid -ne 0 ]; then
 		echo $msg must be run as root >&2
-		exit 0
+		exit $ksft_skip
 	fi
 
 	if ! which perl 2> /dev/null > /dev/null; then
 		echo "$0: You need perl installed"
-		exit 1
+		exit $ksft_skip
 	fi
 	if ! which getconf 2> /dev/null > /dev/null; then
 		echo "$0: You need getconf installed"
-		exit 1
+		exit $ksft_skip
 	fi
 	if ! which diff 2> /dev/null > /dev/null; then
 		echo "$0: You need diff installed"
-		exit 1
+		exit $ksft_skip
 	fi
 }
 
 function load_req_mod()
 {
-	trap "test_modprobe" EXIT
-
 	if [ ! -d $DIR ]; then
+		if ! modprobe -q -n $TEST_DRIVER; then
+			echo "$0: module $TEST_DRIVER not found [SKIP]"
+			exit $ksft_skip
+		fi
 		modprobe $TEST_DRIVER
 		if [ $? -ne 0 ]; then
 			exit
@@ -765,6 +770,7 @@ function parse_args()
 test_reqs
 allow_user_defaults
 check_production_sysctl_writes_strict
+test_modprobe
 load_req_mod
 
 trap "test_finish" EXIT
diff --git a/tools/testing/selftests/user/test_user_copy.sh b/tools/testing/selftests/user/test_user_copy.sh
index d60506fc77f8..f9b31a57439b 100755
--- a/tools/testing/selftests/user/test_user_copy.sh
+++ b/tools/testing/selftests/user/test_user_copy.sh
@@ -2,6 +2,13 @@
 # SPDX-License-Identifier: GPL-2.0
 # Runs copy_to/from_user infrastructure using test_user_copy kernel module
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+if ! /sbin/modprobe -q -n test_user_copy; then
+	echo "user: module test_user_copy is not found [SKIP]"
+	exit $ksft_skip
+fi
 if /sbin/modprobe -q test_user_copy; then
 	/sbin/modprobe -q -r test_user_copy
 	echo "user_copy: ok"
diff --git a/tools/testing/selftests/vm/compaction_test.c b/tools/testing/selftests/vm/compaction_test.c
index 1097f04e4d80..bcec71250873 100644
--- a/tools/testing/selftests/vm/compaction_test.c
+++ b/tools/testing/selftests/vm/compaction_test.c
@@ -16,6 +16,8 @@
 #include <unistd.h>
 #include <string.h>
 
+#include "../kselftest.h"
+
 #define MAP_SIZE 1048576
 
 struct map_list {
@@ -169,7 +171,7 @@ int main(int argc, char **argv)
 		printf("Either the sysctl compact_unevictable_allowed is not\n"
 		       "set to 1 or couldn't read the proc file.\n"
 		       "Skipping the test\n");
-		return 0;
+		return KSFT_SKIP;
 	}
 
 	lim.rlim_cur = RLIM_INFINITY;
diff --git a/tools/testing/selftests/vm/mlock2-tests.c b/tools/testing/selftests/vm/mlock2-tests.c
index 4997b9222cfa..637b6d0ac0d0 100644
--- a/tools/testing/selftests/vm/mlock2-tests.c
+++ b/tools/testing/selftests/vm/mlock2-tests.c
@@ -9,6 +9,8 @@
 #include <stdbool.h>
 #include "mlock2.h"
 
+#include "../kselftest.h"
+
 struct vm_boundaries {
 	unsigned long start;
 	unsigned long end;
@@ -303,7 +305,7 @@ static int test_mlock_lock()
 	if (mlock2_(map, 2 * page_size, 0)) {
 		if (errno == ENOSYS) {
 			printf("Cannot call new mlock family, skipping test\n");
-			_exit(0);
+			_exit(KSFT_SKIP);
 		}
 		perror("mlock2(0)");
 		goto unmap;
@@ -412,7 +414,7 @@ static int test_mlock_onfault()
 	if (mlock2_(map, 2 * page_size, MLOCK_ONFAULT)) {
 		if (errno == ENOSYS) {
 			printf("Cannot call new mlock family, skipping test\n");
-			_exit(0);
+			_exit(KSFT_SKIP);
 		}
 		perror("mlock2(MLOCK_ONFAULT)");
 		goto unmap;
@@ -425,7 +427,7 @@ static int test_mlock_onfault()
 	if (munlock(map, 2 * page_size)) {
 		if (errno == ENOSYS) {
 			printf("Cannot call new mlock family, skipping test\n");
-			_exit(0);
+			_exit(KSFT_SKIP);
 		}
 		perror("munlock()");
 		goto unmap;
@@ -457,7 +459,7 @@ static int test_lock_onfault_of_present()
 	if (mlock2_(map, 2 * page_size, MLOCK_ONFAULT)) {
 		if (errno == ENOSYS) {
 			printf("Cannot call new mlock family, skipping test\n");
-			_exit(0);
+			_exit(KSFT_SKIP);
 		}
 		perror("mlock2(MLOCK_ONFAULT)");
 		goto unmap;
@@ -583,7 +585,7 @@ static int test_vma_management(bool call_mlock)
 	if (call_mlock && mlock2_(map, 3 * page_size, MLOCK_ONFAULT)) {
 		if (errno == ENOSYS) {
 			printf("Cannot call new mlock family, skipping test\n");
-			_exit(0);
+			_exit(KSFT_SKIP);
 		}
 		perror("mlock(ONFAULT)\n");
 		goto out;
diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftests/vm/run_vmtests
index 22d564673830..88cbe5575f0c 100755
--- a/tools/testing/selftests/vm/run_vmtests
+++ b/tools/testing/selftests/vm/run_vmtests
@@ -2,6 +2,9 @@
 # SPDX-License-Identifier: GPL-2.0
 #please run as root
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 mnt=./huge
 exitcode=0
 
@@ -36,7 +39,7 @@ if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
 		echo $(( $lackpgs + $nr_hugepgs )) > /proc/sys/vm/nr_hugepages
 		if [ $? -ne 0 ]; then
 			echo "Please run this test as root"
-			exit 1
+			exit $ksft_skip
 		fi
 		while read name size unit; do
 			if [ "$name" = "HugePages_Free:" ]; then
diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index de2f9ec8a87f..7b8171e3128a 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -69,6 +69,8 @@
 #include <setjmp.h>
 #include <stdbool.h>
 
+#include "../kselftest.h"
+
 #ifdef __NR_userfaultfd
 
 static unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
@@ -1322,7 +1324,7 @@ int main(int argc, char **argv)
 int main(void)
 {
 	printf("skip: Skipping userfaultfd test (missing __NR_userfaultfd)\n");
-	return 0;
+	return KSFT_SKIP;
 }
 
 #endif /* __NR_userfaultfd */
diff --git a/tools/testing/selftests/zram/zram.sh b/tools/testing/selftests/zram/zram.sh
index 754de7da426a..232e958ec454 100755
--- a/tools/testing/selftests/zram/zram.sh
+++ b/tools/testing/selftests/zram/zram.sh
@@ -2,6 +2,9 @@
 # SPDX-License-Identifier: GPL-2.0
 TCID="zram.sh"
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 . ./zram_lib.sh
 
 run_zram () {
@@ -24,5 +27,5 @@ elif [ -b /dev/zram0 ]; then
 else
 	echo "$TCID : No zram.ko module or /dev/zram0 device file not found"
 	echo "$TCID : CONFIG_ZRAM is not set"
-	exit 1
+	exit $ksft_skip
 fi
diff --git a/tools/testing/selftests/zram/zram_lib.sh b/tools/testing/selftests/zram/zram_lib.sh
index f6a9c73e7a44..9e73a4fb9b0a 100755
--- a/tools/testing/selftests/zram/zram_lib.sh
+++ b/tools/testing/selftests/zram/zram_lib.sh
@@ -18,6 +18,9 @@ MODULE=0
 dev_makeswap=-1
 dev_mounted=-1
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 trap INT
 
 check_prereqs()
@@ -27,7 +30,7 @@ check_prereqs()
 
 	if [ $uid -ne 0 ]; then
 		echo $msg must be run as root >&2
-		exit 0
+		exit $ksft_skip
 	fi
 }
 

--------------499CE756772C2F1CD24CB6D9--
