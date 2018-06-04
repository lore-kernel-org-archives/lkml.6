Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbeFDVJt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:09:49 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:46228 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751288AbeFDVJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:09:46 -0400
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
From: Shuah Khan <shuah@kernel.org>
Subject: [GIT PULL] kselftest update for 4.18-rc1
Message-ID: <97a76254-de1e-813e-13aa-79fe8e5c2065@kernel.org>
Date: Mon, 4 Jun 2018 15:09:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------A4B0CDA5D96F0E2CE7B8226B"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A4B0CDA5D96F0E2CE7B8226B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following Kselftest update for 4.18-rc1

This Kselftest update for 4.18-rc1 consists of:

- Work to restructure timers test suite to move PIE out of rtctest from
  Alexandre Belloni.

- Several minor spelling and bug fixes.

- New cgroup tests from Roman Gushchin and Mike Rapoport.

- Kselftest framework changes to handle and report skipped tests correctly.
  Prior to these changes, framework treated all non-zero return codes from
  tests as failures. When tests are skipped with non-zero return code, due
  to unmet dependencies and/or unsupported configuration, reporting them as
  failed lead to false negatives on the tests that couldn't be run.

- Fixes to test Makefiles to remove unnecessary RUN_TESTS and EMIT_TESTS
  overrides and use common defines from lib.mk.

- Fixes to several tests to return correct Kselftest skip code.

- Changes to improve test output.

diff is attached.

thanks,
-- Shuah

-----------------------------------------------------------------------------------
The following changes since commit b04e217704b7f879c6b91222b066983a44a7a09f:

  Linux 4.17-rc7 (2018-05-27 13:01:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-4.18-rc1

for you to fetch changes up to fa32156921daa5c175228e2cac7679d50efd6c52:

  selftests: lib: fix prime_numbers module search and skip logic (2018-05-30 21:32:55 -0600)

----------------------------------------------------------------
linux-kselftest-4.18-rc1

This Kselftest update for 4.18-rc1 consists of:

- Work to restructure timers test suite to move PIE out of rtctest from
  Alexandre Belloni.

- Several minor spelling and bug fixes.

- New cgroup tests from Roman Gushchin and Mike Rapoport.

- Kselftest framework changes to handle and report skipped tests correctly.
  Prior to these changes, framework treated all non-zero return codes from
  tests as failures. When tests are skipped with non-zero return code, due
  to unmet dependencies and/or unsupported configuration, reporting them as
  failed lead to false negatives on the tests that couldn't be run.

- Fixes to test Makefiles to remove unnecessary RUN_TESTS and EMIT_TESTS
  overrides and use common defines from lib.mk.

- Fixes to several tests to return correct Kselftest skip code.

- Changes to improve test output.

----------------------------------------------------------------
Alexandre Belloni (4):
      selftests: timers: move PIE tests out of rtctest
      selftests: timers: rtcpie: restore previous PIE rate
      selftests: move RTC tests to rtc subfolder
      selftests: rtc: rework rtctest

Anders Roxell (3):
      selftests: kvm: add .gitignore for generated files
      selftests: kvm: update .gitignore with missing file
      selftests/filesystems: devpts_pts included wrong header

Colin Ian King (2):
      selftests: media_tests: fix spelling mistake: "iternations" -> "iterations"
      selftests: filesystems: fix spelling mistake: "desciptor" -> "descriptor"

Daniel Díaz (2):
      selftests/intel_pstate: Improve test, minor fixes
      selftests/intel_pstate: Enhance table printing

Florian Weimer (1):
      selftests/x86: Detect -no-pie availability

Jeffrin Jose T (2):
      selftest: intel_pstate: debug support message from aperf.c and return value
      selftests: intel_pstate: notification about privilege required to run intel_pstate testing script

Mike Rapoport (2):
      selftests: cgroup/memcontrol: add basic test for swap controls
      selftests: cgroup/memcontrol: add basic test for socket accounting

Roman Gushchin (2):
      selftests: cgroup: add memory controller self-tests
      kselftest/cgroup: fix variable dereferenced before check warning

Shuah Khan (Samsung OSG) (37):
      selftests: lib.mk: cleanup RUN_TESTS define and make it readable
      selftests: lib.mk: add SKIP handling to RUN_TESTS define
      selftests: lib.mk: move running and printing result to a new function
      selftests: lib.mk: Include test suite name in the RUN_TESTS output
      selftests: lib.mk: add SKIP handling and test suite name to EMIT_TESTS
      selftests: lib.mk: add test execute bit check to EMIT_TESTS
      selftests: kselftest: change KSFT_SKIP=4 instead of KSFT_PASS
      selftests: android: delete RUN_TESTS and EMIT_TESTS overrides
      selftests: futex: delete RUN_TESTS and EMIT_TESTS overrides
      selftests: mount: delete RUN_TESTS and EMIT_TESTS overrides
      selftests: mqueue: delete RUN_TESTS and EMIT_TESTS overrides
      selftests: memory-hotplug: delete RUN_TESTS and EMIT_TESTS overrides
      selftests: android: ion: return Kselftest Skip code for skipped tests
      selftests: breakpoints: return Kselftest Skip code for skipped tests
      selftests: cpu-hotplug: return Kselftest Skip code for skipped tests
      selftests: cpufreq: return Kselftest Skip code for skipped tests
      selftests: efivarfs: return Kselftest Skip code for skipped tests
      selftests: exec: return Kselftest Skip code for skipped tests
      selftests: filesystems: return Kselftest Skip code for skipped tests
      selftests: firmware: return Kselftest Skip code for skipped tests
      selftests: gpio: return Kselftest Skip code for skipped tests
      selftests: intel_pstate: return Kselftest Skip code for skipped tests
      selftests: ipc: return Kselftest Skip code for skipped tests
      selftests: kmod: return Kselftest Skip code for skipped tests
      selftests: kvm: return Kselftest Skip code for skipped tests
      selftests: lib: add prime_numbers.sh test to Makefile
      selftests: lib: return Kselftest Skip code for skipped tests
      selftests: locking: add Makefile for locking test
      selftests: locking: return Kselftest Skip code for skipped tests
      selftests: media_tests: return Kselftest Skip code for skipped tests
      selftests: membarrier: return Kselftest Skip code for skipped tests
      selftests: memfd: return Kselftest Skip code for skipped tests
      selftests: memory-hotplug: return Kselftest Skip code for skipped tests
      selftests: mqueue: return Kselftest Skip code for skipped tests
      selftests: net: return Kselftest Skip code for skipped tests
      selftests: memfd: split regular and hugetlbfs tests
      selftests: lib: fix prime_numbers module search and skip logic

 MAINTAINERS                                        |    2 +-
 tools/testing/selftests/Makefile                   |    5 +-
 tools/testing/selftests/android/Makefile           |    8 -
 tools/testing/selftests/android/ion/ion_test.sh    |    7 +-
 .../breakpoints/step_after_suspend_test.c          |    6 +-
 tools/testing/selftests/cgroup/Makefile            |   10 +
 tools/testing/selftests/cgroup/cgroup_util.c       |  331 +++++++
 tools/testing/selftests/cgroup/cgroup_util.h       |   41 +
 tools/testing/selftests/cgroup/test_memcontrol.c   | 1015 ++++++++++++++++++++
 .../selftests/cpu-hotplug/cpu-on-off-test.sh       |   14 +-
 tools/testing/selftests/cpufreq/main.sh            |    5 +-
 tools/testing/selftests/efivarfs/efivarfs.sh       |    7 +-
 tools/testing/selftests/exec/execveat.c            |    6 +-
 tools/testing/selftests/filesystems/Makefile       |    1 +
 tools/testing/selftests/filesystems/devpts_pts.c   |   15 +-
 tools/testing/selftests/firmware/fw_fallback.sh    |    4 +-
 tools/testing/selftests/firmware/fw_filesystem.sh  |    4 +-
 tools/testing/selftests/firmware/fw_lib.sh         |    7 +-
 tools/testing/selftests/futex/Makefile             |   12 -
 tools/testing/selftests/gpio/gpio-mockup.sh        |   12 +-
 tools/testing/selftests/intel_pstate/aperf.c       |    6 +-
 tools/testing/selftests/intel_pstate/run.sh        |   47 +-
 tools/testing/selftests/ipc/msgque.c               |    7 +-
 tools/testing/selftests/kmod/kmod.sh               |   13 +-
 tools/testing/selftests/kselftest.h                |    2 +-
 tools/testing/selftests/kvm/.gitignore             |    3 +
 tools/testing/selftests/kvm/lib/assert.c           |    9 +-
 tools/testing/selftests/kvm/vmx_tsc_adjust_test.c  |    2 +
 tools/testing/selftests/lib.mk                     |   55 +-
 tools/testing/selftests/lib/Makefile               |    2 +-
 tools/testing/selftests/lib/bitmap.sh              |    8 +-
 tools/testing/selftests/lib/prime_numbers.sh       |    9 +-
 tools/testing/selftests/lib/printf.sh              |    8 +-
 tools/testing/selftests/locking/Makefile           |   10 +
 tools/testing/selftests/locking/ww_mutex.sh        |    8 +
 tools/testing/selftests/media_tests/Makefile       |    3 +-
 .../selftests/media_tests/media_device_open.c      |    8 +-
.../selftests/media_tests/media_device_test.c      |   10 +-
 .../testing/selftests/membarrier/membarrier_test.c |    7 +-
 tools/testing/selftests/memfd/Makefile             |    6 +-
 .../memfd/{run_tests.sh => run_hugetlbfs_test.sh}  |   18 +-
 tools/testing/selftests/memory-hotplug/Makefile    |    5 +-
 .../selftests/memory-hotplug/mem-on-off-test.sh    |   14 +-
 tools/testing/selftests/mount/Makefile             |   12 +-
 tools/testing/selftests/mount/run_tests.sh         |   12 +
 tools/testing/selftests/mqueue/Makefile            |   12 +-
 tools/testing/selftests/mqueue/mq_open_tests.c     |   37 +-
 tools/testing/selftests/mqueue/mq_perf_tests.c     |    8 +-
 tools/testing/selftests/net/fib_tests.sh           |    8 +-
 tools/testing/selftests/net/netdevice.sh           |   16 +-
 tools/testing/selftests/net/pmtu.sh                |    5 +-
 tools/testing/selftests/net/psock_tpacket.c        |    4 +-
 tools/testing/selftests/net/rtnetlink.sh           |   31 +-
 tools/testing/selftests/rtc/.gitignore             |    2 +
 tools/testing/selftests/rtc/Makefile               |    9 +
 tools/testing/selftests/rtc/rtctest.c              |  238 +++++
 .../{timers/rtctest_setdate.c => rtc/setdate.c}    |    0
 tools/testing/selftests/timers/.gitignore          |    3 +-
 tools/testing/selftests/timers/Makefile            |    4 +-
 tools/testing/selftests/timers/rtcpie.c            |  134 +++
 tools/testing/selftests/timers/rtctest.c           |  403 --------
 tools/testing/selftests/x86/Makefile               |    8 +-
 tools/testing/selftests/x86/trivial_program.c      |   10 +
 63 files changed, 2113 insertions(+), 615 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/Makefile
 create mode 100644 tools/testing/selftests/cgroup/cgroup_util.c
 create mode 100644 tools/testing/selftests/cgroup/cgroup_util.h
 create mode 100644 tools/testing/selftests/cgroup/test_memcontrol.c
 create mode 100644 tools/testing/selftests/kvm/.gitignore
 create mode 100644 tools/testing/selftests/locking/Makefile
 mode change 100644 => 100755 tools/testing/selftests/locking/ww_mutex.sh
 rename tools/testing/selftests/memfd/{run_tests.sh => run_hugetlbfs_test.sh} (88%)
 create mode 100755 tools/testing/selftests/mount/run_tests.sh
 create mode 100644 tools/testing/selftests/rtc/.gitignore
 create mode 100644 tools/testing/selftests/rtc/Makefile
 create mode 100644 tools/testing/selftests/rtc/rtctest.c
 rename tools/testing/selftests/{timers/rtctest_setdate.c => rtc/setdate.c} (100%)
 create mode 100644 tools/testing/selftests/timers/rtcpie.c
 delete mode 100644 tools/testing/selftests/timers/rtctest.c
 create mode 100644 tools/testing/selftests/x86/trivial_program.c
-----------------------------------------------------------------------------------

--------------A4B0CDA5D96F0E2CE7B8226B
Content-Type: text/x-patch;
 name="linux-kselftest-4.18-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-4.18-rc1.diff"

diff --git a/MAINTAINERS b/MAINTAINERS
index ca4afd68530c..a376a4adc675 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11878,7 +11878,7 @@ F:	include/linux/rtc.h
 F:	include/uapi/linux/rtc.h
 F:	include/linux/rtc/
 F:	include/linux/platform_data/rtc-*
-F:	tools/testing/selftests/timers/rtctest.c
+F:	tools/testing/selftests/rtc/
 
 REALTEK AUDIO CODECS
 M:	Bard Liao <bardliao@realtek.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 32aafa92074c..305130de910c 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -3,6 +3,7 @@ TARGETS = android
 TARGETS += bpf
 TARGETS += breakpoints
 TARGETS += capabilities
+TARGETS += cgroup
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += efivarfs
@@ -28,6 +29,7 @@ TARGETS += powerpc
 TARGETS += proc
 TARGETS += pstore
 TARGETS += ptrace
+TARGETS += rtc
 TARGETS += seccomp
 TARGETS += sigaltstack
 TARGETS += size
@@ -134,7 +136,8 @@ ifdef INSTALL_PATH
 	echo "else" >> $(ALL_SCRIPT)
 	echo "  OUTPUT=/dev/stdout" >> $(ALL_SCRIPT)
 	echo "fi" >> $(ALL_SCRIPT)
-	echo "export KSFT_TAP_LEVEL=`echo 1`" >> $(ALL_SCRIPT)
+	echo "export KSFT_TAP_LEVEL=1" >> $(ALL_SCRIPT)
+	echo "export skip=4" >> $(ALL_SCRIPT)
 
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
diff --git a/tools/testing/selftests/android/Makefile b/tools/testing/selftests/android/Makefile
index f6304d2be90c..72c25a3cb658 100644
--- a/tools/testing/selftests/android/Makefile
+++ b/tools/testing/selftests/android/Makefile
@@ -18,10 +18,6 @@ all:
 		fi \
 	done
 
-override define RUN_TESTS
-	@cd $(OUTPUT); ./run.sh
-endef
-
 override define INSTALL_RULE
 	mkdir -p $(INSTALL_PATH)
 	install -t $(INSTALL_PATH) $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)
@@ -33,10 +29,6 @@ override define INSTALL_RULE
 	done;
 endef
 
-override define EMIT_TESTS
-	echo "./run.sh"
-endef
-
 override define CLEAN
 	@for DIR in $(SUBDIRS); do		\
 		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
diff --git a/tools/testing/selftests/android/ion/ion_test.sh b/tools/testing/selftests/android/ion/ion_test.sh
index a1aff506f5e6..69e676cfc94e 100755
--- a/tools/testing/selftests/android/ion/ion_test.sh
+++ b/tools/testing/selftests/android/ion/ion_test.sh
@@ -4,6 +4,9 @@ heapsize=4096
 TCID="ion_test.sh"
 errcode=0
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 run_test()
 {
 	heaptype=$1
@@ -25,7 +28,7 @@ check_root()
 	uid=$(id -u)
 	if [ $uid -ne 0 ]; then
 		echo $TCID: must be run as root >&2
-		exit 0
+		exit $ksft_skip
 	fi
 }
 
@@ -35,7 +38,7 @@ check_device()
 	if [ ! -e $DEVICE ]; then
 		echo $TCID: No $DEVICE device found >&2
 		echo $TCID: May be CONFIG_ION is not set >&2
-		exit 0
+		exit $ksft_skip
 	fi
 }
 
diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index 3fece06e9f64..f82dcc1f8841 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -143,10 +143,14 @@ void suspend(void)
 	int err;
 	struct itimerspec spec = {};
 
+	if (getuid() != 0)
+		ksft_exit_skip("Please run the test as root - Exiting.\n");
+
 	power_state_fd = open("/sys/power/state", O_RDWR);
 	if (power_state_fd < 0)
 		ksft_exit_fail_msg(
-			"open(\"/sys/power/state\") failed (is this test running as root?)\n");
+			"open(\"/sys/power/state\") failed %s)\n",
+			strerror(errno));
 
 	timerfd = timerfd_create(CLOCK_BOOTTIME_ALARM, 0);
 	if (timerfd < 0)
diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
new file mode 100644
index 000000000000..f7a31392eb2f
--- /dev/null
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -Wall
+
+all:
+
+TEST_GEN_PROGS = test_memcontrol
+
+include ../lib.mk
+
+$(OUTPUT)/test_memcontrol: cgroup_util.c
diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
new file mode 100644
index 000000000000..b69bdeb4b9fe
--- /dev/null
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -0,0 +1,331 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/limits.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "cgroup_util.h"
+
+static ssize_t read_text(const char *path, char *buf, size_t max_len)
+{
+	ssize_t len;
+	int fd;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return fd;
+
+	len = read(fd, buf, max_len - 1);
+	if (len < 0)
+		goto out;
+
+	buf[len] = 0;
+out:
+	close(fd);
+	return len;
+}
+
+static ssize_t write_text(const char *path, char *buf, size_t len)
+{
+	int fd;
+
+	fd = open(path, O_WRONLY | O_APPEND);
+	if (fd < 0)
+		return fd;
+
+	len = write(fd, buf, len);
+	if (len < 0) {
+		close(fd);
+		return len;
+	}
+
+	close(fd);
+
+	return len;
+}
+
+char *cg_name(const char *root, const char *name)
+{
+	size_t len = strlen(root) + strlen(name) + 2;
+	char *ret = malloc(len);
+
+	snprintf(ret, len, "%s/%s", root, name);
+
+	return ret;
+}
+
+char *cg_name_indexed(const char *root, const char *name, int index)
+{
+	size_t len = strlen(root) + strlen(name) + 10;
+	char *ret = malloc(len);
+
+	snprintf(ret, len, "%s/%s_%d", root, name, index);
+
+	return ret;
+}
+
+int cg_read(const char *cgroup, const char *control, char *buf, size_t len)
+{
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), "%s/%s", cgroup, control);
+
+	if (read_text(path, buf, len) >= 0)
+		return 0;
+
+	return -1;
+}
+
+int cg_read_strcmp(const char *cgroup, const char *control,
+		   const char *expected)
+{
+	size_t size = strlen(expected) + 1;
+	char *buf;
+
+	buf = malloc(size);
+	if (!buf)
+		return -1;
+
+	if (cg_read(cgroup, control, buf, size))
+		return -1;
+
+	return strcmp(expected, buf);
+}
+
+int cg_read_strstr(const char *cgroup, const char *control, const char *needle)
+{
+	char buf[PAGE_SIZE];
+
+	if (cg_read(cgroup, control, buf, sizeof(buf)))
+		return -1;
+
+	return strstr(buf, needle) ? 0 : -1;
+}
+
+long cg_read_long(const char *cgroup, const char *control)
+{
+	char buf[128];
+
+	if (cg_read(cgroup, control, buf, sizeof(buf)))
+		return -1;
+
+	return atol(buf);
+}
+
+long cg_read_key_long(const char *cgroup, const char *control, const char *key)
+{
+	char buf[PAGE_SIZE];
+	char *ptr;
+
+	if (cg_read(cgroup, control, buf, sizeof(buf)))
+		return -1;
+
+	ptr = strstr(buf, key);
+	if (!ptr)
+		return -1;
+
+	return atol(ptr + strlen(key));
+}
+
+int cg_write(const char *cgroup, const char *control, char *buf)
+{
+	char path[PATH_MAX];
+	size_t len = strlen(buf);
+
+	snprintf(path, sizeof(path), "%s/%s", cgroup, control);
+
+	if (write_text(path, buf, len) == len)
+		return 0;
+
+	return -1;
+}
+
+int cg_find_unified_root(char *root, size_t len)
+{
+	char buf[10 * PAGE_SIZE];
+	char *fs, *mount, *type;
+	const char delim[] = "\n\t ";
+
+	if (read_text("/proc/self/mounts", buf, sizeof(buf)) <= 0)
+		return -1;
+
+	/*
+	 * Example:
+	 * cgroup /sys/fs/cgroup cgroup2 rw,seclabel,noexec,relatime 0 0
+	 */
+	for (fs = strtok(buf, delim); fs; fs = strtok(NULL, delim)) {
+		mount = strtok(NULL, delim);
+		type = strtok(NULL, delim);
+		strtok(NULL, delim);
+		strtok(NULL, delim);
+		strtok(NULL, delim);
+
+		if (strcmp(fs, "cgroup") == 0 &&
+		    strcmp(type, "cgroup2") == 0) {
+			strncpy(root, mount, len);
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+int cg_create(const char *cgroup)
+{
+	return mkdir(cgroup, 0644);
+}
+
+static int cg_killall(const char *cgroup)
+{
+	char buf[PAGE_SIZE];
+	char *ptr = buf;
+
+	if (cg_read(cgroup, "cgroup.procs", buf, sizeof(buf)))
+		return -1;
+
+	while (ptr < buf + sizeof(buf)) {
+		int pid = strtol(ptr, &ptr, 10);
+
+		if (pid == 0)
+			break;
+		if (*ptr)
+			ptr++;
+		else
+			break;
+		if (kill(pid, SIGKILL))
+			return -1;
+	}
+
+	return 0;
+}
+
+int cg_destroy(const char *cgroup)
+{
+	int ret;
+
+retry:
+	ret = rmdir(cgroup);
+	if (ret && errno == EBUSY) {
+		ret = cg_killall(cgroup);
+		if (ret)
+			return ret;
+		usleep(100);
+		goto retry;
+	}
+
+	if (ret && errno == ENOENT)
+		ret = 0;
+
+	return ret;
+}
+
+int cg_run(const char *cgroup,
+	   int (*fn)(const char *cgroup, void *arg),
+	   void *arg)
+{
+	int pid, retcode;
+
+	pid = fork();
+	if (pid < 0) {
+		return pid;
+	} else if (pid == 0) {
+		char buf[64];
+
+		snprintf(buf, sizeof(buf), "%d", getpid());
+		if (cg_write(cgroup, "cgroup.procs", buf))
+			exit(EXIT_FAILURE);
+		exit(fn(cgroup, arg));
+	} else {
+		waitpid(pid, &retcode, 0);
+		if (WIFEXITED(retcode))
+			return WEXITSTATUS(retcode);
+		else
+			return -1;
+	}
+}
+
+int cg_run_nowait(const char *cgroup,
+		  int (*fn)(const char *cgroup, void *arg),
+		  void *arg)
+{
+	int pid;
+
+	pid = fork();
+	if (pid == 0) {
+		char buf[64];
+
+		snprintf(buf, sizeof(buf), "%d", getpid());
+		if (cg_write(cgroup, "cgroup.procs", buf))
+			exit(EXIT_FAILURE);
+		exit(fn(cgroup, arg));
+	}
+
+	return pid;
+}
+
+int get_temp_fd(void)
+{
+	return open(".", O_TMPFILE | O_RDWR | O_EXCL);
+}
+
+int alloc_pagecache(int fd, size_t size)
+{
+	char buf[PAGE_SIZE];
+	struct stat st;
+	int i;
+
+	if (fstat(fd, &st))
+		goto cleanup;
+
+	size += st.st_size;
+
+	if (ftruncate(fd, size))
+		goto cleanup;
+
+	for (i = 0; i < size; i += sizeof(buf))
+		read(fd, buf, sizeof(buf));
+
+	return 0;
+
+cleanup:
+	return -1;
+}
+
+int alloc_anon(const char *cgroup, void *arg)
+{
+	size_t size = (unsigned long)arg;
+	char *buf, *ptr;
+
+	buf = malloc(size);
+	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
+		*ptr = 0;
+
+	free(buf);
+	return 0;
+}
+
+int is_swap_enabled(void)
+{
+	char buf[PAGE_SIZE];
+	const char delim[] = "\n";
+	int cnt = 0;
+	char *line;
+
+	if (read_text("/proc/swaps", buf, sizeof(buf)) <= 0)
+		return -1;
+
+	for (line = strtok(buf, delim); line; line = strtok(NULL, delim))
+		cnt++;
+
+	return cnt > 1;
+}
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
new file mode 100644
index 000000000000..fe82a297d4e0
--- /dev/null
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <stdlib.h>
+
+#define PAGE_SIZE 4096
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+#define MB(x) (x << 20)
+
+/*
+ * Checks if two given values differ by less than err% of their sum.
+ */
+static inline int values_close(long a, long b, int err)
+{
+	return abs(a - b) <= (a + b) / 100 * err;
+}
+
+extern int cg_find_unified_root(char *root, size_t len);
+extern char *cg_name(const char *root, const char *name);
+extern char *cg_name_indexed(const char *root, const char *name, int index);
+extern int cg_create(const char *cgroup);
+extern int cg_destroy(const char *cgroup);
+extern int cg_read(const char *cgroup, const char *control,
+		   char *buf, size_t len);
+extern int cg_read_strcmp(const char *cgroup, const char *control,
+			  const char *expected);
+extern int cg_read_strstr(const char *cgroup, const char *control,
+			  const char *needle);
+extern long cg_read_long(const char *cgroup, const char *control);
+long cg_read_key_long(const char *cgroup, const char *control, const char *key);
+extern int cg_write(const char *cgroup, const char *control, char *buf);
+extern int cg_run(const char *cgroup,
+		  int (*fn)(const char *cgroup, void *arg),
+		  void *arg);
+extern int cg_run_nowait(const char *cgroup,
+			 int (*fn)(const char *cgroup, void *arg),
+			 void *arg);
+extern int get_temp_fd(void);
+extern int alloc_pagecache(int fd, size_t size);
+extern int alloc_anon(const char *cgroup, void *arg);
+extern int is_swap_enabled(void);
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
new file mode 100644
index 000000000000..cf0bddc9d271
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -0,0 +1,1015 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#define _GNU_SOURCE
+
+#include <linux/limits.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <sys/wait.h>
+#include <arpa/inet.h>
+#include <netinet/in.h>
+#include <netdb.h>
+#include <errno.h>
+
+#include "../kselftest.h"
+#include "cgroup_util.h"
+
+/*
+ * This test creates two nested cgroups with and without enabling
+ * the memory controller.
+ */
+static int test_memcg_subtree_control(const char *root)
+{
+	char *parent, *child, *parent2, *child2;
+	int ret = KSFT_FAIL;
+	char buf[PAGE_SIZE];
+
+	/* Create two nested cgroups with the memory controller enabled */
+	parent = cg_name(root, "memcg_test_0");
+	child = cg_name(root, "memcg_test_0/memcg_test_1");
+	if (!parent || !child)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_write(parent, "cgroup.subtree_control", "+memory"))
+		goto cleanup;
+
+	if (cg_create(child))
+		goto cleanup;
+
+	if (cg_read_strstr(child, "cgroup.controllers", "memory"))
+		goto cleanup;
+
+	/* Create two nested cgroups without enabling memory controller */
+	parent2 = cg_name(root, "memcg_test_1");
+	child2 = cg_name(root, "memcg_test_1/memcg_test_1");
+	if (!parent2 || !child2)
+		goto cleanup;
+
+	if (cg_create(parent2))
+		goto cleanup;
+
+	if (cg_create(child2))
+		goto cleanup;
+
+	if (cg_read(child2, "cgroup.controllers", buf, sizeof(buf)))
+		goto cleanup;
+
+	if (!cg_read_strstr(child2, "cgroup.controllers", "memory"))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_destroy(child);
+	cg_destroy(parent);
+	free(parent);
+	free(child);
+
+	cg_destroy(child2);
+	cg_destroy(parent2);
+	free(parent2);
+	free(child2);
+
+	return ret;
+}
+
+static int alloc_anon_50M_check(const char *cgroup, void *arg)
+{
+	size_t size = MB(50);
+	char *buf, *ptr;
+	long anon, current;
+	int ret = -1;
+
+	buf = malloc(size);
+	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
+		*ptr = 0;
+
+	current = cg_read_long(cgroup, "memory.current");
+	if (current < size)
+		goto cleanup;
+
+	if (!values_close(size, current, 3))
+		goto cleanup;
+
+	anon = cg_read_key_long(cgroup, "memory.stat", "anon ");
+	if (anon < 0)
+		goto cleanup;
+
+	if (!values_close(anon, current, 3))
+		goto cleanup;
+
+	ret = 0;
+cleanup:
+	free(buf);
+	return ret;
+}
+
+static int alloc_pagecache_50M_check(const char *cgroup, void *arg)
+{
+	size_t size = MB(50);
+	int ret = -1;
+	long current, file;
+	int fd;
+
+	fd = get_temp_fd();
+	if (fd < 0)
+		return -1;
+
+	if (alloc_pagecache(fd, size))
+		goto cleanup;
+
+	current = cg_read_long(cgroup, "memory.current");
+	if (current < size)
+		goto cleanup;
+
+	file = cg_read_key_long(cgroup, "memory.stat", "file ");
+	if (file < 0)
+		goto cleanup;
+
+	if (!values_close(file, current, 10))
+		goto cleanup;
+
+	ret = 0;
+
+cleanup:
+	close(fd);
+	return ret;
+}
+
+/*
+ * This test create a memory cgroup, allocates
+ * some anonymous memory and some pagecache
+ * and check memory.current and some memory.stat values.
+ */
+static int test_memcg_current(const char *root)
+{
+	int ret = KSFT_FAIL;
+	long current;
+	char *memcg;
+
+	memcg = cg_name(root, "memcg_test");
+	if (!memcg)
+		goto cleanup;
+
+	if (cg_create(memcg))
+		goto cleanup;
+
+	current = cg_read_long(memcg, "memory.current");
+	if (current != 0)
+		goto cleanup;
+
+	if (cg_run(memcg, alloc_anon_50M_check, NULL))
+		goto cleanup;
+
+	if (cg_run(memcg, alloc_pagecache_50M_check, NULL))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_destroy(memcg);
+	free(memcg);
+
+	return ret;
+}
+
+static int alloc_pagecache_50M(const char *cgroup, void *arg)
+{
+	int fd = (long)arg;
+
+	return alloc_pagecache(fd, MB(50));
+}
+
+static int alloc_pagecache_50M_noexit(const char *cgroup, void *arg)
+{
+	int fd = (long)arg;
+	int ppid = getppid();
+
+	if (alloc_pagecache(fd, MB(50)))
+		return -1;
+
+	while (getppid() == ppid)
+		sleep(1);
+
+	return 0;
+}
+
+/*
+ * First, this test creates the following hierarchy:
+ * A       memory.min = 50M,  memory.max = 200M
+ * A/B     memory.min = 50M,  memory.current = 50M
+ * A/B/C   memory.min = 75M,  memory.current = 50M
+ * A/B/D   memory.min = 25M,  memory.current = 50M
+ * A/B/E   memory.min = 500M, memory.current = 0
+ * A/B/F   memory.min = 0,    memory.current = 50M
+ *
+ * Usages are pagecache, but the test keeps a running
+ * process in every leaf cgroup.
+ * Then it creates A/G and creates a significant
+ * memory pressure in it.
+ *
+ * A/B    memory.current ~= 50M
+ * A/B/C  memory.current ~= 33M
+ * A/B/D  memory.current ~= 17M
+ * A/B/E  memory.current ~= 0
+ *
+ * After that it tries to allocate more than there is
+ * unprotected memory in A available, and checks
+ * checks that memory.min protects pagecache even
+ * in this case.
+ */
+static int test_memcg_min(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *parent[3] = {NULL};
+	char *children[4] = {NULL};
+	long c[4];
+	int i, attempts;
+	int fd;
+
+	fd = get_temp_fd();
+	if (fd < 0)
+		goto cleanup;
+
+	parent[0] = cg_name(root, "memcg_test_0");
+	if (!parent[0])
+		goto cleanup;
+
+	parent[1] = cg_name(parent[0], "memcg_test_1");
+	if (!parent[1])
+		goto cleanup;
+
+	parent[2] = cg_name(parent[0], "memcg_test_2");
+	if (!parent[2])
+		goto cleanup;
+
+	if (cg_create(parent[0]))
+		goto cleanup;
+
+	if (cg_read_long(parent[0], "memory.min")) {
+		ret = KSFT_SKIP;
+		goto cleanup;
+	}
+
+	if (cg_write(parent[0], "cgroup.subtree_control", "+memory"))
+		goto cleanup;
+
+	if (cg_write(parent[0], "memory.max", "200M"))
+		goto cleanup;
+
+	if (cg_write(parent[0], "memory.swap.max", "0"))
+		goto cleanup;
+
+	if (cg_create(parent[1]))
+		goto cleanup;
+
+	if (cg_write(parent[1], "cgroup.subtree_control", "+memory"))
+		goto cleanup;
+
+	if (cg_create(parent[2]))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(children); i++) {
+		children[i] = cg_name_indexed(parent[1], "child_memcg", i);
+		if (!children[i])
+			goto cleanup;
+
+		if (cg_create(children[i]))
+			goto cleanup;
+
+		if (i == 2)
+			continue;
+
+		cg_run_nowait(children[i], alloc_pagecache_50M_noexit,
+			      (void *)(long)fd);
+	}
+
+	if (cg_write(parent[0], "memory.min", "50M"))
+		goto cleanup;
+	if (cg_write(parent[1], "memory.min", "50M"))
+		goto cleanup;
+	if (cg_write(children[0], "memory.min", "75M"))
+		goto cleanup;
+	if (cg_write(children[1], "memory.min", "25M"))
+		goto cleanup;
+	if (cg_write(children[2], "memory.min", "500M"))
+		goto cleanup;
+	if (cg_write(children[3], "memory.min", "0"))
+		goto cleanup;
+
+	attempts = 0;
+	while (!values_close(cg_read_long(parent[1], "memory.current"),
+			     MB(150), 3)) {
+		if (attempts++ > 5)
+			break;
+		sleep(1);
+	}
+
+	if (cg_run(parent[2], alloc_anon, (void *)MB(148)))
+		goto cleanup;
+
+	if (!values_close(cg_read_long(parent[1], "memory.current"), MB(50), 3))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(children); i++)
+		c[i] = cg_read_long(children[i], "memory.current");
+
+	if (!values_close(c[0], MB(33), 10))
+		goto cleanup;
+
+	if (!values_close(c[1], MB(17), 10))
+		goto cleanup;
+
+	if (!values_close(c[2], 0, 1))
+		goto cleanup;
+
+	if (!cg_run(parent[2], alloc_anon, (void *)MB(170)))
+		goto cleanup;
+
+	if (!values_close(cg_read_long(parent[1], "memory.current"), MB(50), 3))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	for (i = ARRAY_SIZE(children) - 1; i >= 0; i--) {
+		if (!children[i])
+			continue;
+
+		cg_destroy(children[i]);
+		free(children[i]);
+	}
+
+	for (i = ARRAY_SIZE(parent) - 1; i >= 0; i--) {
+		if (!parent[i])
+			continue;
+
+		cg_destroy(parent[i]);
+		free(parent[i]);
+	}
+	close(fd);
+	return ret;
+}
+
+/*
+ * First, this test creates the following hierarchy:
+ * A       memory.low = 50M,  memory.max = 200M
+ * A/B     memory.low = 50M,  memory.current = 50M
+ * A/B/C   memory.low = 75M,  memory.current = 50M
+ * A/B/D   memory.low = 25M,  memory.current = 50M
+ * A/B/E   memory.low = 500M, memory.current = 0
+ * A/B/F   memory.low = 0,    memory.current = 50M
+ *
+ * Usages are pagecache.
+ * Then it creates A/G an creates a significant
+ * memory pressure in it.
+ *
+ * Then it checks actual memory usages and expects that:
+ * A/B    memory.current ~= 50M
+ * A/B/   memory.current ~= 33M
+ * A/B/D  memory.current ~= 17M
+ * A/B/E  memory.current ~= 0
+ *
+ * After that it tries to allocate more than there is
+ * unprotected memory in A available,
+ * and checks low and oom events in memory.events.
+ */
+static int test_memcg_low(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *parent[3] = {NULL};
+	char *children[4] = {NULL};
+	long low, oom;
+	long c[4];
+	int i;
+	int fd;
+
+	fd = get_temp_fd();
+	if (fd < 0)
+		goto cleanup;
+
+	parent[0] = cg_name(root, "memcg_test_0");
+	if (!parent[0])
+		goto cleanup;
+
+	parent[1] = cg_name(parent[0], "memcg_test_1");
+	if (!parent[1])
+		goto cleanup;
+
+	parent[2] = cg_name(parent[0], "memcg_test_2");
+	if (!parent[2])
+		goto cleanup;
+
+	if (cg_create(parent[0]))
+		goto cleanup;
+
+	if (cg_read_long(parent[0], "memory.low"))
+		goto cleanup;
+
+	if (cg_write(parent[0], "cgroup.subtree_control", "+memory"))
+		goto cleanup;
+
+	if (cg_write(parent[0], "memory.max", "200M"))
+		goto cleanup;
+
+	if (cg_write(parent[0], "memory.swap.max", "0"))
+		goto cleanup;
+
+	if (cg_create(parent[1]))
+		goto cleanup;
+
+	if (cg_write(parent[1], "cgroup.subtree_control", "+memory"))
+		goto cleanup;
+
+	if (cg_create(parent[2]))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(children); i++) {
+		children[i] = cg_name_indexed(parent[1], "child_memcg", i);
+		if (!children[i])
+			goto cleanup;
+
+		if (cg_create(children[i]))
+			goto cleanup;
+
+		if (i == 2)
+			continue;
+
+		if (cg_run(children[i], alloc_pagecache_50M, (void *)(long)fd))
+			goto cleanup;
+	}
+
+	if (cg_write(parent[0], "memory.low", "50M"))
+		goto cleanup;
+	if (cg_write(parent[1], "memory.low", "50M"))
+		goto cleanup;
+	if (cg_write(children[0], "memory.low", "75M"))
+		goto cleanup;
+	if (cg_write(children[1], "memory.low", "25M"))
+		goto cleanup;
+	if (cg_write(children[2], "memory.low", "500M"))
+		goto cleanup;
+	if (cg_write(children[3], "memory.low", "0"))
+		goto cleanup;
+
+	if (cg_run(parent[2], alloc_anon, (void *)MB(148)))
+		goto cleanup;
+
+	if (!values_close(cg_read_long(parent[1], "memory.current"), MB(50), 3))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(children); i++)
+		c[i] = cg_read_long(children[i], "memory.current");
+
+	if (!values_close(c[0], MB(33), 10))
+		goto cleanup;
+
+	if (!values_close(c[1], MB(17), 10))
+		goto cleanup;
+
+	if (!values_close(c[2], 0, 1))
+		goto cleanup;
+
+	if (cg_run(parent[2], alloc_anon, (void *)MB(166))) {
+		fprintf(stderr,
+			"memory.low prevents from allocating anon memory\n");
+		goto cleanup;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(children); i++) {
+		oom = cg_read_key_long(children[i], "memory.events", "oom ");
+		low = cg_read_key_long(children[i], "memory.events", "low ");
+
+		if (oom)
+			goto cleanup;
+		if (i < 2 && low <= 0)
+			goto cleanup;
+		if (i >= 2 && low)
+			goto cleanup;
+	}
+
+	ret = KSFT_PASS;
+
+cleanup:
+	for (i = ARRAY_SIZE(children) - 1; i >= 0; i--) {
+		if (!children[i])
+			continue;
+
+		cg_destroy(children[i]);
+		free(children[i]);
+	}
+
+	for (i = ARRAY_SIZE(parent) - 1; i >= 0; i--) {
+		if (!parent[i])
+			continue;
+
+		cg_destroy(parent[i]);
+		free(parent[i]);
+	}
+	close(fd);
+	return ret;
+}
+
+static int alloc_pagecache_max_30M(const char *cgroup, void *arg)
+{
+	size_t size = MB(50);
+	int ret = -1;
+	long current;
+	int fd;
+
+	fd = get_temp_fd();
+	if (fd < 0)
+		return -1;
+
+	if (alloc_pagecache(fd, size))
+		goto cleanup;
+
+	current = cg_read_long(cgroup, "memory.current");
+	if (current <= MB(29) || current > MB(30))
+		goto cleanup;
+
+	ret = 0;
+
+cleanup:
+	close(fd);
+	return ret;
+
+}
+
+/*
+ * This test checks that memory.high limits the amount of
+ * memory which can be consumed by either anonymous memory
+ * or pagecache.
+ */
+static int test_memcg_high(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *memcg;
+	long high;
+
+	memcg = cg_name(root, "memcg_test");
+	if (!memcg)
+		goto cleanup;
+
+	if (cg_create(memcg))
+		goto cleanup;
+
+	if (cg_read_strcmp(memcg, "memory.high", "max\n"))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.swap.max", "0"))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.high", "30M"))
+		goto cleanup;
+
+	if (cg_run(memcg, alloc_anon, (void *)MB(100)))
+		goto cleanup;
+
+	if (!cg_run(memcg, alloc_pagecache_50M_check, NULL))
+		goto cleanup;
+
+	if (cg_run(memcg, alloc_pagecache_max_30M, NULL))
+		goto cleanup;
+
+	high = cg_read_key_long(memcg, "memory.events", "high ");
+	if (high <= 0)
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_destroy(memcg);
+	free(memcg);
+
+	return ret;
+}
+
+/*
+ * This test checks that memory.max limits the amount of
+ * memory which can be consumed by either anonymous memory
+ * or pagecache.
+ */
+static int test_memcg_max(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *memcg;
+	long current, max;
+
+	memcg = cg_name(root, "memcg_test");
+	if (!memcg)
+		goto cleanup;
+
+	if (cg_create(memcg))
+		goto cleanup;
+
+	if (cg_read_strcmp(memcg, "memory.max", "max\n"))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.swap.max", "0"))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.max", "30M"))
+		goto cleanup;
+
+	/* Should be killed by OOM killer */
+	if (!cg_run(memcg, alloc_anon, (void *)MB(100)))
+		goto cleanup;
+
+	if (cg_run(memcg, alloc_pagecache_max_30M, NULL))
+		goto cleanup;
+
+	current = cg_read_long(memcg, "memory.current");
+	if (current > MB(30) || !current)
+		goto cleanup;
+
+	max = cg_read_key_long(memcg, "memory.events", "max ");
+	if (max <= 0)
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_destroy(memcg);
+	free(memcg);
+
+	return ret;
+}
+
+static int alloc_anon_50M_check_swap(const char *cgroup, void *arg)
+{
+	long mem_max = (long)arg;
+	size_t size = MB(50);
+	char *buf, *ptr;
+	long mem_current, swap_current;
+	int ret = -1;
+
+	buf = malloc(size);
+	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
+		*ptr = 0;
+
+	mem_current = cg_read_long(cgroup, "memory.current");
+	if (!mem_current || !values_close(mem_current, mem_max, 3))
+		goto cleanup;
+
+	swap_current = cg_read_long(cgroup, "memory.swap.current");
+	if (!swap_current ||
+	    !values_close(mem_current + swap_current, size, 3))
+		goto cleanup;
+
+	ret = 0;
+cleanup:
+	free(buf);
+	return ret;
+}
+
+/*
+ * This test checks that memory.swap.max limits the amount of
+ * anonymous memory which can be swapped out.
+ */
+static int test_memcg_swap_max(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *memcg;
+	long max;
+
+	if (!is_swap_enabled())
+		return KSFT_SKIP;
+
+	memcg = cg_name(root, "memcg_test");
+	if (!memcg)
+		goto cleanup;
+
+	if (cg_create(memcg))
+		goto cleanup;
+
+	if (cg_read_long(memcg, "memory.swap.current")) {
+		ret = KSFT_SKIP;
+		goto cleanup;
+	}
+
+	if (cg_read_strcmp(memcg, "memory.max", "max\n"))
+		goto cleanup;
+
+	if (cg_read_strcmp(memcg, "memory.swap.max", "max\n"))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.swap.max", "30M"))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.max", "30M"))
+		goto cleanup;
+
+	/* Should be killed by OOM killer */
+	if (!cg_run(memcg, alloc_anon, (void *)MB(100)))
+		goto cleanup;
+
+	if (cg_read_key_long(memcg, "memory.events", "oom ") != 1)
+		goto cleanup;
+
+	if (cg_read_key_long(memcg, "memory.events", "oom_kill ") != 1)
+		goto cleanup;
+
+	if (cg_run(memcg, alloc_anon_50M_check_swap, (void *)MB(30)))
+		goto cleanup;
+
+	max = cg_read_key_long(memcg, "memory.events", "max ");
+	if (max <= 0)
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_destroy(memcg);
+	free(memcg);
+
+	return ret;
+}
+
+/*
+ * This test disables swapping and tries to allocate anonymous memory
+ * up to OOM. Then it checks for oom and oom_kill events in
+ * memory.events.
+ */
+static int test_memcg_oom_events(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *memcg;
+
+	memcg = cg_name(root, "memcg_test");
+	if (!memcg)
+		goto cleanup;
+
+	if (cg_create(memcg))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.max", "30M"))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.swap.max", "0"))
+		goto cleanup;
+
+	if (!cg_run(memcg, alloc_anon, (void *)MB(100)))
+		goto cleanup;
+
+	if (cg_read_strcmp(memcg, "cgroup.procs", ""))
+		goto cleanup;
+
+	if (cg_read_key_long(memcg, "memory.events", "oom ") != 1)
+		goto cleanup;
+
+	if (cg_read_key_long(memcg, "memory.events", "oom_kill ") != 1)
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_destroy(memcg);
+	free(memcg);
+
+	return ret;
+}
+
+struct tcp_server_args {
+	unsigned short port;
+	int ctl[2];
+};
+
+static int tcp_server(const char *cgroup, void *arg)
+{
+	struct tcp_server_args *srv_args = arg;
+	struct sockaddr_in6 saddr = { 0 };
+	socklen_t slen = sizeof(saddr);
+	int sk, client_sk, ctl_fd, yes = 1, ret = -1;
+
+	close(srv_args->ctl[0]);
+	ctl_fd = srv_args->ctl[1];
+
+	saddr.sin6_family = AF_INET6;
+	saddr.sin6_addr = in6addr_any;
+	saddr.sin6_port = htons(srv_args->port);
+
+	sk = socket(AF_INET6, SOCK_STREAM, 0);
+	if (sk < 0)
+		return ret;
+
+	if (setsockopt(sk, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(yes)) < 0)
+		goto cleanup;
+
+	if (bind(sk, (struct sockaddr *)&saddr, slen)) {
+		write(ctl_fd, &errno, sizeof(errno));
+		goto cleanup;
+	}
+
+	if (listen(sk, 1))
+		goto cleanup;
+
+	ret = 0;
+	if (write(ctl_fd, &ret, sizeof(ret)) != sizeof(ret)) {
+		ret = -1;
+		goto cleanup;
+	}
+
+	client_sk = accept(sk, NULL, NULL);
+	if (client_sk < 0)
+		goto cleanup;
+
+	ret = -1;
+	for (;;) {
+		uint8_t buf[0x100000];
+
+		if (write(client_sk, buf, sizeof(buf)) <= 0) {
+			if (errno == ECONNRESET)
+				ret = 0;
+			break;
+		}
+	}
+
+	close(client_sk);
+
+cleanup:
+	close(sk);
+	return ret;
+}
+
+static int tcp_client(const char *cgroup, unsigned short port)
+{
+	const char server[] = "localhost";
+	struct addrinfo *ai;
+	char servport[6];
+	int retries = 0x10; /* nice round number */
+	int sk, ret;
+
+	snprintf(servport, sizeof(servport), "%hd", port);
+	ret = getaddrinfo(server, servport, NULL, &ai);
+	if (ret)
+		return ret;
+
+	sk = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
+	if (sk < 0)
+		goto free_ainfo;
+
+	ret = connect(sk, ai->ai_addr, ai->ai_addrlen);
+	if (ret < 0)
+		goto close_sk;
+
+	ret = KSFT_FAIL;
+	while (retries--) {
+		uint8_t buf[0x100000];
+		long current, sock;
+
+		if (read(sk, buf, sizeof(buf)) <= 0)
+			goto close_sk;
+
+		current = cg_read_long(cgroup, "memory.current");
+		sock = cg_read_key_long(cgroup, "memory.stat", "sock ");
+
+		if (current < 0 || sock < 0)
+			goto close_sk;
+
+		if (current < sock)
+			goto close_sk;
+
+		if (values_close(current, sock, 10)) {
+			ret = KSFT_PASS;
+			break;
+		}
+	}
+
+close_sk:
+	close(sk);
+free_ainfo:
+	freeaddrinfo(ai);
+	return ret;
+}
+
+/*
+ * This test checks socket memory accounting.
+ * The test forks a TCP server listens on a random port between 1000
+ * and 61000. Once it gets a client connection, it starts writing to
+ * its socket.
+ * The TCP client interleaves reads from the socket with check whether
+ * memory.current and memory.stat.sock are similar.
+ */
+static int test_memcg_sock(const char *root)
+{
+	int bind_retries = 5, ret = KSFT_FAIL, pid, err;
+	unsigned short port;
+	char *memcg;
+
+	memcg = cg_name(root, "memcg_test");
+	if (!memcg)
+		goto cleanup;
+
+	if (cg_create(memcg))
+		goto cleanup;
+
+	while (bind_retries--) {
+		struct tcp_server_args args;
+
+		if (pipe(args.ctl))
+			goto cleanup;
+
+		port = args.port = 1000 + rand() % 60000;
+
+		pid = cg_run_nowait(memcg, tcp_server, &args);
+		if (pid < 0)
+			goto cleanup;
+
+		close(args.ctl[1]);
+		if (read(args.ctl[0], &err, sizeof(err)) != sizeof(err))
+			goto cleanup;
+		close(args.ctl[0]);
+
+		if (!err)
+			break;
+		if (err != EADDRINUSE)
+			goto cleanup;
+
+		waitpid(pid, NULL, 0);
+	}
+
+	if (err == EADDRINUSE) {
+		ret = KSFT_SKIP;
+		goto cleanup;
+	}
+
+	if (tcp_client(memcg, port) != KSFT_PASS)
+		goto cleanup;
+
+	waitpid(pid, &err, 0);
+	if (WEXITSTATUS(err))
+		goto cleanup;
+
+	if (cg_read_long(memcg, "memory.current") < 0)
+		goto cleanup;
+
+	if (cg_read_key_long(memcg, "memory.stat", "sock "))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_destroy(memcg);
+	free(memcg);
+
+	return ret;
+}
+
+#define T(x) { x, #x }
+struct memcg_test {
+	int (*fn)(const char *root);
+	const char *name;
+} tests[] = {
+	T(test_memcg_subtree_control),
+	T(test_memcg_current),
+	T(test_memcg_min),
+	T(test_memcg_low),
+	T(test_memcg_high),
+	T(test_memcg_max),
+	T(test_memcg_oom_events),
+	T(test_memcg_swap_max),
+	T(test_memcg_sock),
+};
+#undef T
+
+int main(int argc, char **argv)
+{
+	char root[PATH_MAX];
+	int i, ret = EXIT_SUCCESS;
+
+	if (cg_find_unified_root(root, sizeof(root)))
+		ksft_exit_skip("cgroup v2 isn't mounted\n");
+
+	/*
+	 * Check that memory controller is available:
+	 * memory is listed in cgroup.controllers
+	 */
+	if (cg_read_strstr(root, "cgroup.controllers", "memory"))
+		ksft_exit_skip("memory controller isn't available\n");
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		switch (tests[i].fn(root)) {
+		case KSFT_PASS:
+			ksft_test_result_pass("%s\n", tests[i].name);
+			break;
+		case KSFT_SKIP:
+			ksft_test_result_skip("%s\n", tests[i].name);
+			break;
+		default:
+			ret = EXIT_FAILURE;
+			ksft_test_result_fail("%s\n", tests[i].name);
+			break;
+		}
+	}
+
+	return ret;
+}
diff --git a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
index f3a8933c1275..bab13dd025a6 100755
--- a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
+++ b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
@@ -2,6 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 SYSFS=
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
 
 prerequisite()
 {
@@ -9,7 +11,7 @@ prerequisite()
 
 	if [ $UID != 0 ]; then
 		echo $msg must be run as root >&2
-		exit 0
+		exit $ksft_skip
 	fi
 
 	taskset -p 01 $$
@@ -18,12 +20,12 @@ prerequisite()
 
 	if [ ! -d "$SYSFS" ]; then
 		echo $msg sysfs is not mounted >&2
-		exit 0
+		exit $ksft_skip
 	fi
 
 	if ! ls $SYSFS/devices/system/cpu/cpu* > /dev/null 2>&1; then
 		echo $msg cpu hotplug is not supported >&2
-		exit 0
+		exit $ksft_skip
 	fi
 
 	echo "CPU online/offline summary:"
@@ -32,7 +34,7 @@ prerequisite()
 
 	if [[ "$online_cpus" = "$online_max" ]]; then
 		echo "$msg: since there is only one cpu: $online_cpus"
-		exit 0
+		exit $ksft_skip
 	fi
 
 	echo -e "\t Cpus in online state: $online_cpus"
@@ -237,12 +239,12 @@ prerequisite_extra()
 
 	if [ ! -d "$DEBUGFS" ]; then
 		echo $msg debugfs is not mounted >&2
-		exit 0
+		exit $ksft_skip
 	fi
 
 	if [ ! -d $NOTIFIER_ERR_INJECT_DIR ]; then
 		echo $msg cpu-notifier-error-inject module is not available >&2
-		exit 0
+		exit $ksft_skip
 	fi
 }
 
diff --git a/tools/testing/selftests/cpufreq/main.sh b/tools/testing/selftests/cpufreq/main.sh
index d83922de9d89..31f8c9a76c5f 100755
--- a/tools/testing/selftests/cpufreq/main.sh
+++ b/tools/testing/selftests/cpufreq/main.sh
@@ -13,6 +13,9 @@ SYSFS=
 CPUROOT=
 CPUFREQROOT=
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 helpme()
 {
 	printf "Usage: $0 [-h] [-todg args]
@@ -38,7 +41,7 @@ prerequisite()
 
 	if [ $UID != 0 ]; then
 		echo $msg must be run as root >&2
-		exit 2
+		exit $ksft_skip
 	fi
 
 	taskset -p 01 $$
diff --git a/tools/testing/selftests/efivarfs/efivarfs.sh b/tools/testing/selftests/efivarfs/efivarfs.sh
index c6d5790575ae..a47029a799d2 100755
--- a/tools/testing/selftests/efivarfs/efivarfs.sh
+++ b/tools/testing/selftests/efivarfs/efivarfs.sh
@@ -4,18 +4,21 @@
 efivarfs_mount=/sys/firmware/efi/efivars
 test_guid=210be57c-9849-4fc7-a635-e6382d1aec27
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 check_prereqs()
 {
 	local msg="skip all tests:"
 
 	if [ $UID != 0 ]; then
 		echo $msg must be run as root >&2
-		exit 0
+		exit $ksft_skip
 	fi
 
 	if ! grep -q "^\S\+ $efivarfs_mount efivarfs" /proc/mounts; then
 		echo $msg efivarfs is not mounted on $efivarfs_mount >&2
-		exit 0
+		exit $ksft_skip
 	fi
 }
 
diff --git a/tools/testing/selftests/exec/execveat.c b/tools/testing/selftests/exec/execveat.c
index 67cd4597db2b..47cbf54d0801 100644
--- a/tools/testing/selftests/exec/execveat.c
+++ b/tools/testing/selftests/exec/execveat.c
@@ -20,6 +20,8 @@
 #include <string.h>
 #include <unistd.h>
 
+#include "../kselftest.h"
+
 static char longpath[2 * PATH_MAX] = "";
 static char *envp[] = { "IN_TEST=yes", NULL, NULL };
 static char *argv[] = { "execveat", "99", NULL };
@@ -249,8 +251,8 @@ static int run_tests(void)
 	errno = 0;
 	execveat_(-1, NULL, NULL, NULL, 0);
 	if (errno == ENOSYS) {
-		printf("[FAIL] ENOSYS calling execveat - no kernel support?\n");
-		return 1;
+		ksft_exit_skip(
+			"ENOSYS calling execveat - no kernel support?\n");
 	}
 
 	/* Change file position to confirm it doesn't affect anything */
diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index 5c7d7001ad37..129880fb42d3 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CFLAGS += -I../../../../usr/include/
 TEST_GEN_PROGS := devpts_pts
 TEST_GEN_PROGS_EXTENDED := dnotify_test
 
diff --git a/tools/testing/selftests/filesystems/devpts_pts.c b/tools/testing/selftests/filesystems/devpts_pts.c
index b9055e974289..b1fc9b916ace 100644
--- a/tools/testing/selftests/filesystems/devpts_pts.c
+++ b/tools/testing/selftests/filesystems/devpts_pts.c
@@ -8,9 +8,10 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include <sys/ioctl.h>
+#include <asm/ioctls.h>
 #include <sys/mount.h>
 #include <sys/wait.h>
+#include "../kselftest.h"
 
 static bool terminal_dup2(int duplicate, int original)
 {
@@ -125,10 +126,12 @@ static int do_tiocgptpeer(char *ptmx, char *expected_procfd_contents)
 		if (errno == EINVAL) {
 			fprintf(stderr, "TIOCGPTPEER is not supported. "
 					"Skipping test.\n");
-			fret = EXIT_SUCCESS;
+			fret = KSFT_SKIP;
+		} else {
+			fprintf(stderr,
+				"Failed to perform TIOCGPTPEER ioctl\n");
+			fret = EXIT_FAILURE;
 		}
-
-		fprintf(stderr, "Failed to perform TIOCGPTPEER ioctl\n");
 		goto do_cleanup;
 	}
 
@@ -279,9 +282,9 @@ int main(int argc, char *argv[])
 	int ret;
 
 	if (!isatty(STDIN_FILENO)) {
-		fprintf(stderr, "Standard input file desciptor is not attached "
+		fprintf(stderr, "Standard input file descriptor is not attached "
 				"to a terminal. Skipping test\n");
-		exit(EXIT_FAILURE);
+		exit(KSFT_SKIP);
 	}
 
 	ret = unshare(CLONE_NEWNS);
diff --git a/tools/testing/selftests/firmware/fw_fallback.sh b/tools/testing/selftests/firmware/fw_fallback.sh
index 8e2e34a2ca69..70d18be46af5 100755
--- a/tools/testing/selftests/firmware/fw_fallback.sh
+++ b/tools/testing/selftests/firmware/fw_fallback.sh
@@ -74,7 +74,7 @@ load_fw_custom()
 {
 	if [ ! -e "$DIR"/trigger_custom_fallback ]; then
 		echo "$0: custom fallback trigger not present, ignoring test" >&2
-		return 1
+		exit $ksft_skip
 	fi
 
 	local name="$1"
@@ -107,7 +107,7 @@ load_fw_custom_cancel()
 {
 	if [ ! -e "$DIR"/trigger_custom_fallback ]; then
 		echo "$0: canceling custom fallback trigger not present, ignoring test" >&2
-		return 1
+		exit $ksft_skip
 	fi
 
 	local name="$1"
diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
index 6452d2129cd9..a4320c4b44dc 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -30,6 +30,7 @@ fi
 
 if [ ! -e "$DIR"/trigger_async_request ]; then
 	echo "$0: empty filename: async trigger not present, ignoring test" >&2
+	exit $ksft_skip
 else
 	if printf '\000' >"$DIR"/trigger_async_request 2> /dev/null; then
 		echo "$0: empty filename should not succeed (async)" >&2
@@ -69,6 +70,7 @@ fi
 # Try the asynchronous version too
 if [ ! -e "$DIR"/trigger_async_request ]; then
 	echo "$0: firmware loading: async trigger not present, ignoring test" >&2
+	exit $ksft_skip
 else
 	if ! echo -n "$NAME" >"$DIR"/trigger_async_request ; then
 		echo "$0: could not trigger async request" >&2
@@ -89,7 +91,7 @@ test_config_present()
 {
 	if [ ! -f $DIR/reset ]; then
 		echo "Configuration triggers not present, ignoring test"
-		exit 0
+		exit $ksft_skip
 	fi
 }
 
diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
index 962d7f4ac627..6c5f1b2ffb74 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -9,11 +9,14 @@ DIR=/sys/devices/virtual/misc/test_firmware
 PROC_CONFIG="/proc/config.gz"
 TEST_DIR=$(dirname $0)
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 print_reqs_exit()
 {
 	echo "You must have the following enabled in your kernel:" >&2
 	cat $TEST_DIR/config >&2
-	exit 1
+	exit $ksft_skip
 }
 
 test_modprobe()
@@ -88,7 +91,7 @@ verify_reqs()
 	if [ "$TEST_REQS_FW_SYSFS_FALLBACK" = "yes" ]; then
 		if [ ! "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
 			echo "usermode helper disabled so ignoring test"
-			exit 0
+			exit $ksft_skip
 		fi
 	fi
 }
diff --git a/tools/testing/selftests/futex/Makefile b/tools/testing/selftests/futex/Makefile
index 8497a376ef9d..12631f0076a1 100644
--- a/tools/testing/selftests/futex/Makefile
+++ b/tools/testing/selftests/futex/Makefile
@@ -17,14 +17,6 @@ all:
 		fi \
 	done
 
-override define RUN_TESTS
-	@export KSFT_TAP_LEVEL=`echo 1`;
-	@echo "TAP version 13";
-	@echo "selftests: futex";
-	@echo "========================================";
-	@cd $(OUTPUT); ./run.sh
-endef
-
 override define INSTALL_RULE
 	mkdir -p $(INSTALL_PATH)
 	install -t $(INSTALL_PATH) $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)
@@ -36,10 +28,6 @@ override define INSTALL_RULE
 	done;
 endef
 
-override define EMIT_TESTS
-	echo "./run.sh"
-endef
-
 override define CLEAN
 	@for DIR in $(SUBDIRS); do		\
 		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
diff --git a/tools/testing/selftests/gpio/gpio-mockup.sh b/tools/testing/selftests/gpio/gpio-mockup.sh
index 183fb932edbd..7f35b9880485 100755
--- a/tools/testing/selftests/gpio/gpio-mockup.sh
+++ b/tools/testing/selftests/gpio/gpio-mockup.sh
@@ -2,10 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
 #exit status
-#1: run as non-root user
+#1: Internal error
 #2: sysfs/debugfs not mount
 #3: insert module fail when gpio-mockup is a module.
-#4: other reason.
+#4: Skip test including run as non-root user.
+#5: other reason.
 
 SYSFS=
 GPIO_SYSFS=
@@ -15,6 +16,9 @@ GPIO_DEBUGFS=
 dev_type=
 module=
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 usage()
 {
 	echo "Usage:"
@@ -34,7 +38,7 @@ prerequisite()
 	msg="skip all tests:"
 	if [ $UID != 0 ]; then
 		echo $msg must be run as root >&2
-		exit 1
+		exit $ksft_skip
 	fi
 	SYSFS=`mount -t sysfs | head -1 | awk '{ print $3 }'`
 	if [ ! -d "$SYSFS" ]; then
@@ -73,7 +77,7 @@ remove_module()
 die()
 {
 	remove_module
-	exit 4
+	exit 5
 }
 
 test_chips()
diff --git a/tools/testing/selftests/intel_pstate/aperf.c b/tools/testing/selftests/intel_pstate/aperf.c
index d21edea9c560..f6cd03a87493 100644
--- a/tools/testing/selftests/intel_pstate/aperf.c
+++ b/tools/testing/selftests/intel_pstate/aperf.c
@@ -9,6 +9,8 @@
 #include <sys/timeb.h>
 #include <sched.h>
 #include <errno.h>
+#include <string.h>
+#include "../kselftest.h"
 
 void usage(char *name) {
 	printf ("Usage: %s cpunum\n", name);
@@ -41,8 +43,8 @@ int main(int argc, char **argv) {
 	fd = open(msr_file_name, O_RDONLY);
 
 	if (fd == -1) {
-		perror("Failed to open");
-		return 1;
+		printf("/dev/cpu/%d/msr: %s\n", cpu, strerror(errno));
+		return KSFT_SKIP;
 	}
 
 	CPU_ZERO(&cpuset);
diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
index c670359becc6..e7008f614ad7 100755
--- a/tools/testing/selftests/intel_pstate/run.sh
+++ b/tools/testing/selftests/intel_pstate/run.sh
@@ -30,9 +30,18 @@
 
 EVALUATE_ONLY=0
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 if ! uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ | grep -q x86; then
 	echo "$0 # Skipped: Test can only run on x86 architectures."
-	exit 0
+	exit $ksft_skip
+fi
+
+msg="skip all tests:"
+if [ $UID != 0 ] && [ $EVALUATE_ONLY == 0 ]; then
+    echo $msg please run this as root >&2
+    exit $ksft_skip
 fi
 
 max_cpus=$(($(nproc)-1))
@@ -48,11 +57,12 @@ function run_test () {
 
 	echo "sleeping for 5 seconds"
 	sleep 5
-	num_freqs=$(cat /proc/cpuinfo | grep MHz | sort -u | wc -l)
-	if [ $num_freqs -le 2 ]; then
-		cat /proc/cpuinfo | grep MHz | sort -u | tail -1 > /tmp/result.$1
+	grep MHz /proc/cpuinfo | sort -u > /tmp/result.freqs
+	num_freqs=$(wc -l /tmp/result.freqs | awk ' { print $1 } ')
+	if [ $num_freqs -ge 2 ]; then
+		tail -n 1 /tmp/result.freqs > /tmp/result.$1
 	else
-		cat /proc/cpuinfo | grep MHz | sort -u > /tmp/result.$1
+		cp /tmp/result.freqs /tmp/result.$1
 	fi
 	./msr 0 >> /tmp/result.$1
 
@@ -82,32 +92,37 @@ _max_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $2 } ')
 max_freq=$(($_max_freq / 1000))
 
 
-for freq in `seq $max_freq -100 $min_freq`
+[ $EVALUATE_ONLY -eq 0 ] && for freq in `seq $max_freq -100 $min_freq`
 do
 	echo "Setting maximum frequency to $freq"
 	cpupower frequency-set -g powersave --max=${freq}MHz >& /dev/null
-	[ $EVALUATE_ONLY -eq 0 ] && run_test $freq
+	run_test $freq
 done
 
-echo "=============================================================================="
+[ $EVALUATE_ONLY -eq 0 ] && cpupower frequency-set -g powersave --max=${max_freq}MHz >& /dev/null
 
+echo "========================================================================"
 echo "The marketing frequency of the cpu is $mkt_freq MHz"
 echo "The maximum frequency of the cpu is $max_freq MHz"
 echo "The minimum frequency of the cpu is $min_freq MHz"
 
-cpupower frequency-set -g powersave --max=${max_freq}MHz >& /dev/null
-
 # make a pretty table
-echo "Target      Actual      Difference     MSR(0x199)     max_perf_pct"
+echo "Target Actual Difference MSR(0x199) max_perf_pct" | tr " " "\n" > /tmp/result.tab
 for freq in `seq $max_freq -100 $min_freq`
 do
 	result_freq=$(cat /tmp/result.${freq} | grep "cpu MHz" | awk ' { print $4 } ' | awk -F "." ' { print $1 } ')
 	msr=$(cat /tmp/result.${freq} | grep "msr" | awk ' { print $3 } ')
 	max_perf_pct=$(cat /tmp/result.${freq} | grep "max_perf_pct" | awk ' { print $2 } ' )
-	if [ $result_freq -eq $freq ]; then
-		echo " $freq        $result_freq             0          $msr         $(($max_perf_pct*3300))"
-	else
-		echo " $freq        $result_freq          $(($result_freq-$freq))          $msr          $(($max_perf_pct*$max_freq))"
-	fi
+	cat >> /tmp/result.tab << EOF
+$freq
+$result_freq
+$((result_freq - freq))
+$msr
+$((max_perf_pct * max_freq))
+EOF
 done
+
+# print the table
+pr -aTt -5 < /tmp/result.tab
+
 exit 0
diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index ee9382bdfadc..dac927e82336 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -196,10 +196,9 @@ int main(int argc, char **argv)
 	int msg, pid, err;
 	struct msgque_data msgque;
 
-	if (getuid() != 0) {
-		printf("Please run the test as root - Exiting.\n");
-		return ksft_exit_fail();
-	}
+	if (getuid() != 0)
+		return ksft_exit_skip(
+				"Please run the test as root - Exiting.\n");
 
 	msgque.key = ftok(argv[0], 822155650);
 	if (msgque.key == -1) {
diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index 7956ea3be667..0a76314b4414 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -62,13 +62,16 @@ ALL_TESTS="$ALL_TESTS 0007:5:1"
 ALL_TESTS="$ALL_TESTS 0008:150:1"
 ALL_TESTS="$ALL_TESTS 0009:150:1"
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 test_modprobe()
 {
        if [ ! -d $DIR ]; then
                echo "$0: $DIR not present" >&2
                echo "You must have the following enabled in your kernel:" >&2
                cat $TEST_DIR/config >&2
-               exit 1
+               exit $ksft_skip
        fi
 }
 
@@ -105,12 +108,12 @@ test_reqs()
 {
 	if ! which modprobe 2> /dev/null > /dev/null; then
 		echo "$0: You need modprobe installed" >&2
-		exit 1
+		exit $ksft_skip
 	fi
 
 	if ! which kmod 2> /dev/null > /dev/null; then
 		echo "$0: You need kmod installed" >&2
-		exit 1
+		exit $ksft_skip
 	fi
 
 	# kmod 19 has a bad bug where it returns 0 when modprobe
@@ -124,13 +127,13 @@ test_reqs()
 		echo "$0: You need at least kmod 20" >&2
 		echo "kmod <= 19 is buggy, for details see:" >&2
 		echo "http://git.kernel.org/cgit/utils/kernel/kmod/kmod.git/commit/libkmod/libkmod-module.c?id=fd44a98ae2eb5eb32161088954ab21e58e19dfc4" >&2
-		exit 1
+		exit $ksft_skip
 	fi
 
 	uid=$(id -u)
 	if [ $uid -ne 0 ]; then
 		echo $msg must be run as root >&2
-		exit 0
+		exit $ksft_skip
 	fi
 }
 
diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 1b9d8ecdebce..15e6b75fc3a5 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -20,7 +20,7 @@
 #define KSFT_XFAIL 2
 #define KSFT_XPASS 3
 /* Treat skip as pass */
-#define KSFT_SKIP  KSFT_PASS
+#define KSFT_SKIP  4
 
 /* counters */
 struct ksft_count {
diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
new file mode 100644
index 000000000000..63fc1ab9248f
--- /dev/null
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -0,0 +1,3 @@
+set_sregs_test
+sync_regs_test
+vmx_tsc_adjust_test
diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selftests/kvm/lib/assert.c
index c9f5b7d4ce38..cd01144d27c8 100644
--- a/tools/testing/selftests/kvm/lib/assert.c
+++ b/tools/testing/selftests/kvm/lib/assert.c
@@ -13,6 +13,8 @@
 #include <execinfo.h>
 #include <sys/syscall.h>
 
+#include "../../kselftest.h"
+
 /* Dumps the current stack trace to stderr. */
 static void __attribute__((noinline)) test_dump_stack(void);
 static void test_dump_stack(void)
@@ -70,8 +72,9 @@ test_assert(bool exp, const char *exp_str,
 
 		fprintf(stderr, "==== Test Assertion Failure ====\n"
 			"  %s:%u: %s\n"
-			"  pid=%d tid=%d\n",
-			file, line, exp_str, getpid(), gettid());
+			"  pid=%d tid=%d - %s\n",
+			file, line, exp_str, getpid(), gettid(),
+			strerror(errno));
 		test_dump_stack();
 		if (fmt) {
 			fputs("  ", stderr);
@@ -80,6 +83,8 @@ test_assert(bool exp, const char *exp_str,
 		}
 		va_end(ap);
 
+		if (errno == EACCES)
+			ksft_exit_skip("Access denied - Exiting.\n");
 		exit(254);
 	}
 
diff --git a/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
index aaa633263b2c..d7cb7944a42e 100644
--- a/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
@@ -28,6 +28,8 @@
 #include <string.h>
 #include <sys/ioctl.h>
 
+#include "../kselftest.h"
+
 #ifndef MSR_IA32_TSC_ADJUST
 #define MSR_IA32_TSC_ADJUST 0x3b
 #endif
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index c1b1a4dc6a96..6466294366dc 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -19,25 +19,43 @@ TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 
 .ONESHELL:
+define RUN_TEST_PRINT_RESULT
+	TEST_HDR_MSG="selftests: "`basename $$PWD`:" $$BASENAME_TEST";	\
+	echo $$TEST_HDR_MSG;					\
+	echo "========================================";	\
+	if [ ! -x $$TEST ]; then	\
+		echo "$$TEST_HDR_MSG: Warning: file $$BASENAME_TEST is not executable, correct this.";\
+		echo "not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]"; \
+	else					\
+		cd `dirname $$TEST` > /dev/null; \
+		if [ "X$(summary)" != "X" ]; then	\
+			(./$$BASENAME_TEST > /tmp/$$BASENAME_TEST 2>&1 && \
+			echo "ok 1..$$test_num $$TEST_HDR_MSG [PASS]") || \
+			(if [ $$? -eq $$skip ]; then	\
+				echo "not ok 1..$$test_num $$TEST_HDR_MSG [SKIP]";				\
+			else echo "not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]";					\
+			fi;)			\
+		else				\
+			(./$$BASENAME_TEST &&	\
+			echo "ok 1..$$test_num $$TEST_HDR_MSG [PASS]") ||						\
+			(if [ $$? -eq $$skip ]; then \
+				echo "not ok 1..$$test_num $$TEST_HDR_MSG [SKIP]"; \
+			else echo "not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]";				\
+			fi;)		\
+		fi;				\
+		cd - > /dev/null;		\
+	fi;
+endef
+
 define RUN_TESTS
 	@export KSFT_TAP_LEVEL=`echo 1`;		\
 	test_num=`echo 0`;				\
+	skip=`echo 4`;					\
 	echo "TAP version 13";				\
 	for TEST in $(1); do				\
 		BASENAME_TEST=`basename $$TEST`;	\
 		test_num=`echo $$test_num+1 | bc`;	\
-		echo "selftests: $$BASENAME_TEST";	\
-		echo "========================================";	\
-		if [ ! -x $$TEST ]; then	\
-			echo "selftests: Warning: file $$BASENAME_TEST is not executable, correct this.";\
-			echo "not ok 1..$$test_num selftests: $$BASENAME_TEST [FAIL]"; \
-		else					\
-		if [ "X$(summary)" != "X" ]; then		\
-				cd `dirname $$TEST` > /dev/null; (./$$BASENAME_TEST > /tmp/$$BASENAME_TEST 2>&1 && echo "ok 1..$$test_num selftests: $$BASENAME_TEST [PASS]") || echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [FAIL]"; cd - > /dev/null;\
-			else				\
-				cd `dirname $$TEST` > /dev/null; (./$$BASENAME_TEST && echo "ok 1..$$test_num selftests: $$BASENAME_TEST [PASS]") || echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [FAIL]"; cd - > /dev/null;\
-			fi;				\
-		fi;					\
+		$(call RUN_TEST_PRINT_RESULT,$(TEST),$(BASENAME_TEST),$(test_num),$(skip))						\
 	done;
 endef
 
@@ -76,9 +94,18 @@ else
 endif
 
 define EMIT_TESTS
-	@for TEST in $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS); do \
+	@test_num=`echo 0`;				\
+	for TEST in $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS); do \
 		BASENAME_TEST=`basename $$TEST`;	\
-		echo "(./$$BASENAME_TEST >> \$$OUTPUT 2>&1 && echo \"selftests: $$BASENAME_TEST [PASS]\") || echo \"selftests: $$BASENAME_TEST [FAIL]\""; \
+		test_num=`echo $$test_num+1 | bc`;	\
+		TEST_HDR_MSG="selftests: "`basename $$PWD`:" $$BASENAME_TEST";	\
+		echo "echo $$TEST_HDR_MSG";	\
+		if [ ! -x $$TEST ]; then	\
+			echo "echo \"$$TEST_HDR_MSG: Warning: file $$BASENAME_TEST is not executable, correct this.\"";		\
+			echo "echo \"not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]\""; \
+		else
+			echo "(./$$BASENAME_TEST >> \$$OUTPUT 2>&1 && echo \"ok 1..$$test_num $$TEST_HDR_MSG [PASS]\") || (if [ \$$? -eq \$$skip ]; then echo \"not ok 1..$$test_num $$TEST_HDR_MSG [SKIP]\"; else echo \"not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]\"; fi;)"; \
+		fi;		\
 	done;
 endef
 
diff --git a/tools/testing/selftests/lib/Makefile b/tools/testing/selftests/lib/Makefile
index 08360060ab14..70d5711e3ac8 100644
--- a/tools/testing/selftests/lib/Makefile
+++ b/tools/testing/selftests/lib/Makefile
@@ -3,6 +3,6 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
-TEST_PROGS := printf.sh bitmap.sh
+TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/lib/bitmap.sh b/tools/testing/selftests/lib/bitmap.sh
index 4dee4d2a8bbe..5a90006d1aea 100755
--- a/tools/testing/selftests/lib/bitmap.sh
+++ b/tools/testing/selftests/lib/bitmap.sh
@@ -1,9 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 # Runs bitmap infrastructure tests using test_bitmap kernel module
 if ! /sbin/modprobe -q -n test_bitmap; then
-	echo "bitmap: [SKIP]"
-	exit 77
+	echo "bitmap: module test_bitmap is not found [SKIP]"
+	exit $ksft_skip
 fi
 
 if /sbin/modprobe -q test_bitmap; then
diff --git a/tools/testing/selftests/lib/prime_numbers.sh b/tools/testing/selftests/lib/prime_numbers.sh
index b363994e5e11..78e7483c8d60 100755
--- a/tools/testing/selftests/lib/prime_numbers.sh
+++ b/tools/testing/selftests/lib/prime_numbers.sh
@@ -2,9 +2,12 @@
 # SPDX-License-Identifier: GPL-2.0
 # Checks fast/slow prime_number generation for inconsistencies
 
-if ! /sbin/modprobe -q -r prime_numbers; then
-	echo "prime_numbers: [SKIP]"
-	exit 77
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+if ! /sbin/modprobe -q -n prime_numbers; then
+	echo "prime_numbers: module prime_numbers is not found [SKIP]"
+	exit $ksft_skip
 fi
 
 if /sbin/modprobe -q prime_numbers selftest=65536; then
diff --git a/tools/testing/selftests/lib/printf.sh b/tools/testing/selftests/lib/printf.sh
index 0c37377fd7d4..45a23e2d64ad 100755
--- a/tools/testing/selftests/lib/printf.sh
+++ b/tools/testing/selftests/lib/printf.sh
@@ -1,9 +1,13 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # Runs printf infrastructure using test_printf kernel module
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 if ! /sbin/modprobe -q -n test_printf; then
-	echo "printf: [SKIP]"
-	exit 77
+	echo "printf: module test_printf is not found [SKIP]"
+	exit $ksft_skip
 fi
 
 if /sbin/modprobe -q test_printf; then
diff --git a/tools/testing/selftests/locking/Makefile b/tools/testing/selftests/locking/Makefile
new file mode 100644
index 000000000000..6e7761ab3536
--- /dev/null
+++ b/tools/testing/selftests/locking/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for locking/ww_mutx selftests
+
+# No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
+all:
+
+TEST_PROGS := ww_mutex.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/locking/ww_mutex.sh b/tools/testing/selftests/locking/ww_mutex.sh
old mode 100644
new mode 100755
index 2c3d6b1878c2..91e4ac7566af
--- a/tools/testing/selftests/locking/ww_mutex.sh
+++ b/tools/testing/selftests/locking/ww_mutex.sh
@@ -1,6 +1,14 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 # Runs API tests for struct ww_mutex (Wait/Wound mutexes)
+if ! /sbin/modprobe -q -n test-ww_mutex; then
+	echo "ww_mutex: module test-ww_mutex is not found [SKIP]"
+	exit $ksft_skip
+fi
 
 if /sbin/modprobe -q test-ww_mutex; then
        /sbin/modprobe -q -r test-ww_mutex
diff --git a/tools/testing/selftests/media_tests/Makefile b/tools/testing/selftests/media_tests/Makefile
index c82cec2497de..60826d7d37d4 100644
--- a/tools/testing/selftests/media_tests/Makefile
+++ b/tools/testing/selftests/media_tests/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+#
+CFLAGS += -I../ -I../../../../usr/include/
 TEST_GEN_PROGS := media_device_test media_device_open video_device_test
-all: $(TEST_GEN_PROGS)
 
 include ../lib.mk
diff --git a/tools/testing/selftests/media_tests/media_device_open.c b/tools/testing/selftests/media_tests/media_device_open.c
index a5ce5434bafd..93183a37b133 100644
--- a/tools/testing/selftests/media_tests/media_device_open.c
+++ b/tools/testing/selftests/media_tests/media_device_open.c
@@ -34,6 +34,8 @@
 #include <sys/stat.h>
 #include <linux/media.h>
 
+#include "../kselftest.h"
+
 int main(int argc, char **argv)
 {
 	int opt;
@@ -61,10 +63,8 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (getuid() != 0) {
-		printf("Please run the test as root - Exiting.\n");
-		exit(-1);
-	}
+	if (getuid() != 0)
+		ksft_exit_skip("Please run the test as root - Exiting.\n");
 
 	/* Open Media device and keep it open */
 	fd = open(media_device, O_RDWR);
diff --git a/tools/testing/selftests/media_tests/media_device_test.c b/tools/testing/selftests/media_tests/media_device_test.c
index 421a367e4bb3..4b9953359e40 100644
--- a/tools/testing/selftests/media_tests/media_device_test.c
+++ b/tools/testing/selftests/media_tests/media_device_test.c
@@ -39,6 +39,8 @@
 #include <time.h>
 #include <linux/media.h>
 
+#include "../kselftest.h"
+
 int main(int argc, char **argv)
 {
 	int opt;
@@ -66,10 +68,8 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (getuid() != 0) {
-		printf("Please run the test as root - Exiting.\n");
-		exit(-1);
-	}
+	if (getuid() != 0)
+		ksft_exit_skip("Please run the test as root - Exiting.\n");
 
 	/* Generate random number of interations */
 	srand((unsigned int) time(NULL));
@@ -88,7 +88,7 @@ int main(int argc, char **argv)
 	       "other Oops in the dmesg. Enable KaSan kernel\n"
 	       "config option for use-after-free error detection.\n\n");
 
-	printf("Running test for %d iternations\n", count);
+	printf("Running test for %d iterations\n", count);
 
 	while (count > 0) {
 		ret = ioctl(fd, MEDIA_IOC_DEVICE_INFO, &mdi);
diff --git a/tools/testing/selftests/membarrier/membarrier_test.c b/tools/testing/selftests/membarrier/membarrier_test.c
index 22bffd55a523..6793f8ecc8e7 100644
--- a/tools/testing/selftests/membarrier/membarrier_test.c
+++ b/tools/testing/selftests/membarrier/membarrier_test.c
@@ -293,10 +293,9 @@ static int test_membarrier_query(void)
 		}
 		ksft_exit_fail_msg("sys_membarrier() failed\n");
 	}
-	if (!(ret & MEMBARRIER_CMD_GLOBAL)) {
-		ksft_test_result_fail("sys_membarrier() CMD_GLOBAL query failed\n");
-		ksft_exit_fail_msg("sys_membarrier is not supported.\n");
-	}
+	if (!(ret & MEMBARRIER_CMD_GLOBAL))
+		ksft_exit_skip(
+			"sys_membarrier unsupported: CMD_GLOBAL not found.\n");
 
 	ksft_test_result_pass("sys_membarrier available\n");
 	return 0;
diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
index 0862e6f47a38..53a848109f7b 100644
--- a/tools/testing/selftests/memfd/Makefile
+++ b/tools/testing/selftests/memfd/Makefile
@@ -4,9 +4,9 @@ CFLAGS += -I../../../../include/uapi/
 CFLAGS += -I../../../../include/
 CFLAGS += -I../../../../usr/include/
 
-TEST_PROGS := run_tests.sh
-TEST_FILES := run_fuse_test.sh
-TEST_GEN_FILES := memfd_test fuse_mnt fuse_test
+TEST_GEN_PROGS := memfd_test
+TEST_PROGS := run_fuse_test.sh run_hugetlbfs_test.sh
+TEST_GEN_FILES := fuse_mnt fuse_test
 
 fuse_mnt.o: CFLAGS += $(shell pkg-config fuse --cflags)
 
diff --git a/tools/testing/selftests/memfd/run_tests.sh b/tools/testing/selftests/memfd/run_hugetlbfs_test.sh
similarity index 88%
rename from tools/testing/selftests/memfd/run_tests.sh
rename to tools/testing/selftests/memfd/run_hugetlbfs_test.sh
index c2d41ed81b24..fb633eeb0290 100755
--- a/tools/testing/selftests/memfd/run_tests.sh
+++ b/tools/testing/selftests/memfd/run_hugetlbfs_test.sh
@@ -1,11 +1,8 @@
 #!/bin/bash
 # please run as root
 
-#
-# Normal tests requiring no special resources
-#
-./run_fuse_test.sh
-./memfd_test
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
 
 #
 # To test memfd_create with hugetlbfs, there needs to be hpages_test
@@ -29,12 +26,13 @@ if [ -n "$freepgs" ] && [ $freepgs -lt $hpages_test ]; then
 	nr_hugepgs=`cat /proc/sys/vm/nr_hugepages`
 	hpages_needed=`expr $hpages_test - $freepgs`
 
+	if [ $UID != 0 ]; then
+		echo "Please run memfd with hugetlbfs test as root"
+		exit $ksft_skip
+	fi
+
 	echo 3 > /proc/sys/vm/drop_caches
 	echo $(( $hpages_needed + $nr_hugepgs )) > /proc/sys/vm/nr_hugepages
-	if [ $? -ne 0 ]; then
-		echo "Please run this test as root"
-		exit 1
-	fi
 	while read name size unit; do
 		if [ "$name" = "HugePages_Free:" ]; then
 			freepgs=$size
@@ -53,7 +51,7 @@ if [ $freepgs -lt $hpages_test ]; then
 	fi
 	printf "Not enough huge pages available (%d < %d)\n" \
 		$freepgs $needpgs
-	exit 1
+	exit $ksft_skip
 fi
 
 #
diff --git a/tools/testing/selftests/memory-hotplug/Makefile b/tools/testing/selftests/memory-hotplug/Makefile
index 686da510f989..e0a625e34f40 100644
--- a/tools/testing/selftests/memory-hotplug/Makefile
+++ b/tools/testing/selftests/memory-hotplug/Makefile
@@ -4,11 +4,8 @@ all:
 include ../lib.mk
 
 TEST_PROGS := mem-on-off-test.sh
-override RUN_TESTS := @./mem-on-off-test.sh -r 2 && echo "selftests: memory-hotplug [PASS]" || echo "selftests: memory-hotplug [FAIL]"
-
-override EMIT_TESTS := echo "$(subst @,,$(RUN_TESTS))"
 
 run_full_test:
-	@/bin/bash ./mem-on-off-test.sh && echo "memory-hotplug selftests: [PASS]" || echo "memory-hotplug selftests: [FAIL]"
+	@/bin/bash ./mem-on-off-test.sh -r 10 && echo "memory-hotplug selftests: [PASS]" || echo "memory-hotplug selftests: [FAIL]"
 
 clean:
diff --git a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
index ae2c790d0880..b37585e6aa38 100755
--- a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
+++ b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
@@ -3,30 +3,33 @@
 
 SYSFS=
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 prerequisite()
 {
 	msg="skip all tests:"
 
 	if [ $UID != 0 ]; then
 		echo $msg must be run as root >&2
-		exit 0
+		exit $ksft_skip
 	fi
 
 	SYSFS=`mount -t sysfs | head -1 | awk '{ print $3 }'`
 
 	if [ ! -d "$SYSFS" ]; then
 		echo $msg sysfs is not mounted >&2
-		exit 0
+		exit $ksft_skip
 	fi
 
 	if ! ls $SYSFS/devices/system/memory/memory* > /dev/null 2>&1; then
 		echo $msg memory hotplug is not supported >&2
-		exit 0
+		exit $ksft_skip
 	fi
 
 	if ! grep -q 1 $SYSFS/devices/system/memory/memory*/removable; then
 		echo $msg no hot-pluggable memory >&2
-		exit 0
+		exit $ksft_skip
 	fi
 }
 
@@ -133,7 +136,8 @@ offline_memory_expect_fail()
 
 error=-12
 priority=0
-ratio=10
+# Run with default of ratio=2 for Kselftest run
+ratio=2
 retval=0
 
 while getopts e:hp:r: opt; do
diff --git a/tools/testing/selftests/mount/Makefile b/tools/testing/selftests/mount/Makefile
index e094f71c6dbc..026890744215 100644
--- a/tools/testing/selftests/mount/Makefile
+++ b/tools/testing/selftests/mount/Makefile
@@ -3,15 +3,7 @@
 CFLAGS = -Wall \
          -O2
 
-TEST_GEN_PROGS := unprivileged-remount-test
+TEST_PROGS := run_tests.sh
+TEST_GEN_FILES := unprivileged-remount-test
 
 include ../lib.mk
-
-override RUN_TESTS := if [ -f /proc/self/uid_map ] ; \
-		      then	\
-				./unprivileged-remount-test ; \
-		      else	\
-				echo "WARN: No /proc/self/uid_map exist, test skipped." ; \
-		      fi
-override EMIT_TESTS := echo "$(RUN_TESTS)"
-
diff --git a/tools/testing/selftests/mount/run_tests.sh b/tools/testing/selftests/mount/run_tests.sh
new file mode 100755
index 000000000000..4ab8f507dcba
--- /dev/null
+++ b/tools/testing/selftests/mount/run_tests.sh
@@ -0,0 +1,12 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+# Run mount selftests
+if [ -f /proc/self/uid_map ] ; then
+	./unprivileged-remount-test ;
+else
+	echo "WARN: No /proc/self/uid_map exist, test skipped." ;
+	exit $ksft_skip
+fi
diff --git a/tools/testing/selftests/mqueue/Makefile b/tools/testing/selftests/mqueue/Makefile
index 743d3f9e5918..8a58055fc1f5 100644
--- a/tools/testing/selftests/mqueue/Makefile
+++ b/tools/testing/selftests/mqueue/Makefile
@@ -1,17 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -O2
 LDLIBS = -lrt -lpthread -lpopt
+
 TEST_GEN_PROGS := mq_open_tests mq_perf_tests
 
 include ../lib.mk
-
-override define RUN_TESTS
-	@$(OUTPUT)/mq_open_tests /test1 || echo "selftests: mq_open_tests [FAIL]"
-	@$(OUTPUT)/mq_perf_tests || echo "selftests: mq_perf_tests [FAIL]"
-endef
-
-override define EMIT_TESTS
-	echo "./mq_open_tests /test1 || echo \"selftests: mq_open_tests [FAIL]\""
-	echo "./mq_perf_tests || echo \"selftests: mq_perf_tests [FAIL]\""
-endef
-
diff --git a/tools/testing/selftests/mqueue/mq_open_tests.c b/tools/testing/selftests/mqueue/mq_open_tests.c
index e0a74bd207a5..9403ac01ba11 100644
--- a/tools/testing/selftests/mqueue/mq_open_tests.c
+++ b/tools/testing/selftests/mqueue/mq_open_tests.c
@@ -33,6 +33,8 @@
 #include <mqueue.h>
 #include <error.h>
 
+#include "../kselftest.h"
+
 static char *usage =
 "Usage:\n"
 "  %s path\n"
@@ -53,6 +55,7 @@ int saved_def_msgs, saved_def_msgsize, saved_max_msgs, saved_max_msgsize;
 int cur_def_msgs, cur_def_msgsize, cur_max_msgs, cur_max_msgsize;
 FILE *def_msgs, *def_msgsize, *max_msgs, *max_msgsize;
 char *queue_path;
+char *default_queue_path = "/test1";
 mqd_t queue = -1;
 
 static inline void __set(FILE *stream, int value, char *err_msg);
@@ -238,35 +241,33 @@ int main(int argc, char *argv[])
 	struct mq_attr attr, result;
 
 	if (argc != 2) {
-		fprintf(stderr, "Must pass a valid queue name\n\n");
-		fprintf(stderr, usage, argv[0]);
-		exit(1);
-	}
+		printf("Using Default queue path - %s\n", default_queue_path);
+		queue_path = default_queue_path;
+	} else {
 
 	/*
 	 * Although we can create a msg queue with a non-absolute path name,
 	 * unlink will fail.  So, if the name doesn't start with a /, add one
 	 * when we save it.
 	 */
-	if (*argv[1] == '/')
-		queue_path = strdup(argv[1]);
-	else {
-		queue_path = malloc(strlen(argv[1]) + 2);
-		if (!queue_path) {
-			perror("malloc()");
-			exit(1);
+		if (*argv[1] == '/')
+			queue_path = strdup(argv[1]);
+		else {
+			queue_path = malloc(strlen(argv[1]) + 2);
+			if (!queue_path) {
+				perror("malloc()");
+				exit(1);
+			}
+			queue_path[0] = '/';
+			queue_path[1] = 0;
+			strcat(queue_path, argv[1]);
 		}
-		queue_path[0] = '/';
-		queue_path[1] = 0;
-		strcat(queue_path, argv[1]);
 	}
 
-	if (getuid() != 0) {
-		fprintf(stderr, "Not running as root, but almost all tests "
+	if (getuid() != 0)
+		ksft_exit_skip("Not running as root, but almost all tests "
 			"require root in order to modify\nsystem settings.  "
 			"Exiting.\n");
-		exit(1);
-	}
 
 	/* Find out what files there are for us to make tweaks in */
 	def_msgs = fopen(DEF_MSGS, "r+");
diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
index 8188f72de93c..b019e0b8221c 100644
--- a/tools/testing/selftests/mqueue/mq_perf_tests.c
+++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
@@ -39,6 +39,8 @@
 #include <popt.h>
 #include <error.h>
 
+#include "../kselftest.h"
+
 static char *usage =
 "Usage:\n"
 "  %s [-c #[,#..] -f] path\n"
@@ -626,12 +628,10 @@ int main(int argc, char *argv[])
 		cpus_to_pin[0] = cpus_online - 1;
 	}
 
-	if (getuid() != 0) {
-		fprintf(stderr, "Not running as root, but almost all tests "
+	if (getuid() != 0)
+		ksft_exit_skip("Not running as root, but almost all tests "
 			"require root in order to modify\nsystem settings.  "
 			"Exiting.\n");
-		exit(1);
-	}
 
 	max_msgs = fopen(MAX_MSGS, "r+");
 	max_msgsize = fopen(MAX_MSGSIZE, "r+");
diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 9164e60d4b66..5baac82b9287 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -5,6 +5,8 @@
 # different events.
 
 ret=0
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
 
 VERBOSE=${VERBOSE:=0}
 PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
@@ -579,18 +581,18 @@ fib_test()
 
 if [ "$(id -u)" -ne 0 ];then
 	echo "SKIP: Need root privileges"
-	exit 0
+	exit $ksft_skip;
 fi
 
 if [ ! -x "$(command -v ip)" ]; then
 	echo "SKIP: Could not run test without ip tool"
-	exit 0
+	exit $ksft_skip
 fi
 
 ip route help 2>&1 | grep -q fibmatch
 if [ $? -ne 0 ]; then
 	echo "SKIP: iproute2 too old, missing fibmatch"
-	exit 0
+	exit $ksft_skip
 fi
 
 # start clean
diff --git a/tools/testing/selftests/net/netdevice.sh b/tools/testing/selftests/net/netdevice.sh
index 903679e0ff31..e3afcb424710 100755
--- a/tools/testing/selftests/net/netdevice.sh
+++ b/tools/testing/selftests/net/netdevice.sh
@@ -8,6 +8,9 @@
 # if not they probably have failed earlier in the boot process and their logged error will be catched by another test
 #
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 # this function will try to up the interface
 # if already up, nothing done
 # arg1: network interface name
@@ -18,7 +21,7 @@ kci_net_start()
 	ip link show "$netdev" |grep -q UP
 	if [ $? -eq 0 ];then
 		echo "SKIP: $netdev: interface already up"
-		return 0
+		return $ksft_skip
 	fi
 
 	ip link set "$netdev" up
@@ -61,12 +64,12 @@ kci_net_setup()
 	ip address show "$netdev" |grep '^[[:space:]]*inet'
 	if [ $? -eq 0 ];then
 		echo "SKIP: $netdev: already have an IP"
-		return 0
+		return $ksft_skip
 	fi
 
 	# TODO what ipaddr to set ? DHCP ?
 	echo "SKIP: $netdev: set IP address"
-	return 0
+	return $ksft_skip
 }
 
 # test an ethtool command
@@ -84,6 +87,7 @@ kci_netdev_ethtool_test()
 	if [ $ret -ne 0 ];then
 		if [ $ret -eq "$1" ];then
 			echo "SKIP: $netdev: ethtool $2 not supported"
+			return $ksft_skip
 		else
 			echo "FAIL: $netdev: ethtool $2"
 			return 1
@@ -104,7 +108,7 @@ kci_netdev_ethtool()
 	ethtool --version 2>/dev/null >/dev/null
 	if [ $? -ne 0 ];then
 		echo "SKIP: ethtool not present"
-		return 1
+		return $ksft_skip
 	fi
 
 	TMP_ETHTOOL_FEATURES="$(mktemp)"
@@ -176,13 +180,13 @@ kci_test_netdev()
 #check for needed privileges
 if [ "$(id -u)" -ne 0 ];then
 	echo "SKIP: Need root privileges"
-	exit 0
+	exit $ksft_skip
 fi
 
 ip link show 2>/dev/null >/dev/null
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without the ip tool"
-	exit 0
+	exit $ksft_skip
 fi
 
 TMP_LIST_NETDEV="$(mktemp)"
diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 1e428781a625..7514f93e1624 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -43,6 +43,9 @@
 #	that MTU is properly calculated instead when MTU is not configured from
 #	userspace
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 tests="
 	pmtu_vti6_exception		vti6: PMTU exceptions
 	pmtu_vti4_exception		vti4: PMTU exceptions
@@ -162,7 +165,7 @@ setup_xfrm6() {
 }
 
 setup() {
-	[ "$(id -u)" -ne 0 ] && echo "  need to run as root" && return 1
+	[ "$(id -u)" -ne 0 ] && echo "  need to run as root" && return $ksft_skip
 
 	cleanup_done=0
 	for arg do
diff --git a/tools/testing/selftests/net/psock_tpacket.c b/tools/testing/selftests/net/psock_tpacket.c
index 7f6cd9fdacf3..7ec4fa4d55dc 100644
--- a/tools/testing/selftests/net/psock_tpacket.c
+++ b/tools/testing/selftests/net/psock_tpacket.c
@@ -60,6 +60,8 @@
 
 #include "psock_lib.h"
 
+#include "../kselftest.h"
+
 #ifndef bug_on
 # define bug_on(cond)		assert(!(cond))
 #endif
@@ -825,7 +827,7 @@ static int test_tpacket(int version, int type)
 		fprintf(stderr, "test: skip %s %s since user and kernel "
 			"space have different bit width\n",
 			tpacket_str[version], type_str[type]);
-		return 0;
+		return KSFT_SKIP;
 	}
 
 	sock = pfsocket(version);
diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index e6f485235435..fb3767844e42 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -7,6 +7,9 @@
 devdummy="test-dummy0"
 ret=0
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 # set global exit status, but never reset nonzero one.
 check_err()
 {
@@ -333,7 +336,7 @@ kci_test_vrf()
 	ip link show type vrf 2>/dev/null
 	if [ $? -ne 0 ]; then
 		echo "SKIP: vrf: iproute2 too old"
-		return 0
+		return $ksft_skip
 	fi
 
 	ip link add "$vrfname" type vrf table 10
@@ -409,7 +412,7 @@ kci_test_encap_fou()
 	ip fou help 2>&1 |grep -q 'Usage: ip fou'
 	if [ $? -ne 0 ];then
 		echo "SKIP: fou: iproute2 too old"
-		return 1
+		return $ksft_skip
 	fi
 
 	ip netns exec "$testns" ip fou add port 7777 ipproto 47 2>/dev/null
@@ -444,7 +447,7 @@ kci_test_encap()
 	ip netns add "$testns"
 	if [ $? -ne 0 ]; then
 		echo "SKIP encap tests: cannot add net namespace $testns"
-		return 1
+		return $ksft_skip
 	fi
 
 	ip netns exec "$testns" ip link set lo up
@@ -469,7 +472,7 @@ kci_test_macsec()
 	ip macsec help 2>&1 | grep -q "^Usage: ip macsec"
 	if [ $? -ne 0 ]; then
 		echo "SKIP: macsec: iproute2 too old"
-		return 0
+		return $ksft_skip
 	fi
 
 	ip link add link "$devdummy" "$msname" type macsec port 42 encrypt on
@@ -511,14 +514,14 @@ kci_test_gretap()
 	ip netns add "$testns"
 	if [ $? -ne 0 ]; then
 		echo "SKIP gretap tests: cannot add net namespace $testns"
-		return 1
+		return $ksft_skip
 	fi
 
 	ip link help gretap 2>&1 | grep -q "^Usage:"
 	if [ $? -ne 0 ];then
 		echo "SKIP: gretap: iproute2 too old"
 		ip netns del "$testns"
-		return 1
+		return $ksft_skip
 	fi
 
 	# test native tunnel
@@ -561,14 +564,14 @@ kci_test_ip6gretap()
 	ip netns add "$testns"
 	if [ $? -ne 0 ]; then
 		echo "SKIP ip6gretap tests: cannot add net namespace $testns"
-		return 1
+		return $ksft_skip
 	fi
 
 	ip link help ip6gretap 2>&1 | grep -q "^Usage:"
 	if [ $? -ne 0 ];then
 		echo "SKIP: ip6gretap: iproute2 too old"
 		ip netns del "$testns"
-		return 1
+		return $ksft_skip
 	fi
 
 	# test native tunnel
@@ -611,13 +614,13 @@ kci_test_erspan()
 	ip link help erspan 2>&1 | grep -q "^Usage:"
 	if [ $? -ne 0 ];then
 		echo "SKIP: erspan: iproute2 too old"
-		return 1
+		return $ksft_skip
 	fi
 
 	ip netns add "$testns"
 	if [ $? -ne 0 ]; then
 		echo "SKIP erspan tests: cannot add net namespace $testns"
-		return 1
+		return $ksft_skip
 	fi
 
 	# test native tunnel erspan v1
@@ -676,13 +679,13 @@ kci_test_ip6erspan()
 	ip link help ip6erspan 2>&1 | grep -q "^Usage:"
 	if [ $? -ne 0 ];then
 		echo "SKIP: ip6erspan: iproute2 too old"
-		return 1
+		return $ksft_skip
 	fi
 
 	ip netns add "$testns"
 	if [ $? -ne 0 ]; then
 		echo "SKIP ip6erspan tests: cannot add net namespace $testns"
-		return 1
+		return $ksft_skip
 	fi
 
 	# test native tunnel ip6erspan v1
@@ -762,14 +765,14 @@ kci_test_rtnl()
 #check for needed privileges
 if [ "$(id -u)" -ne 0 ];then
 	echo "SKIP: Need root privileges"
-	exit 0
+	exit $ksft_skip
 fi
 
 for x in ip tc;do
 	$x -Version 2>/dev/null >/dev/null
 	if [ $? -ne 0 ];then
 		echo "SKIP: Could not run test without the $x tool"
-		exit 0
+		exit $ksft_skip
 	fi
 done
 
diff --git a/tools/testing/selftests/rtc/.gitignore b/tools/testing/selftests/rtc/.gitignore
new file mode 100644
index 000000000000..d0ad44f6294a
--- /dev/null
+++ b/tools/testing/selftests/rtc/.gitignore
@@ -0,0 +1,2 @@
+rtctest
+setdate
diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
new file mode 100644
index 000000000000..de9c8566672a
--- /dev/null
+++ b/tools/testing/selftests/rtc/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -O3 -Wl,-no-as-needed -Wall
+LDFLAGS += -lrt -lpthread -lm
+
+TEST_GEN_PROGS = rtctest
+
+TEST_GEN_PROGS_EXTENDED = setdate
+
+include ../lib.mk
diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
new file mode 100644
index 000000000000..e20b017e7073
--- /dev/null
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Real Time Clock Driver Test Program
+ *
+ * Copyright (c) 2018 Alexandre Belloni <alexandre.belloni@bootlin.com>
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/rtc.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+#define NUM_UIE 3
+#define ALARM_DELTA 3
+
+static char *rtc_file = "/dev/rtc0";
+
+FIXTURE(rtc) {
+	int fd;
+};
+
+FIXTURE_SETUP(rtc) {
+	self->fd = open(rtc_file, O_RDONLY);
+	ASSERT_NE(-1, self->fd);
+}
+
+FIXTURE_TEARDOWN(rtc) {
+	close(self->fd);
+}
+
+TEST_F(rtc, date_read) {
+	int rc;
+	struct rtc_time rtc_tm;
+
+	/* Read the RTC time/date */
+	rc = ioctl(self->fd, RTC_RD_TIME, &rtc_tm);
+	ASSERT_NE(-1, rc);
+
+	TH_LOG("Current RTC date/time is %02d/%02d/%02d %02d:%02d:%02d.",
+	       rtc_tm.tm_mday, rtc_tm.tm_mon + 1, rtc_tm.tm_year + 1900,
+	       rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
+}
+
+TEST_F(rtc, uie_read) {
+	int i, rc, irq = 0;
+	unsigned long data;
+
+	/* Turn on update interrupts */
+	rc = ioctl(self->fd, RTC_UIE_ON, 0);
+	if (rc == -1) {
+		ASSERT_EQ(EINVAL, errno);
+		TH_LOG("skip update IRQs not supported.");
+		return;
+	}
+
+	for (i = 0; i < NUM_UIE; i++) {
+		/* This read will block */
+		rc = read(self->fd, &data, sizeof(data));
+		ASSERT_NE(-1, rc);
+		irq++;
+	}
+
+	EXPECT_EQ(NUM_UIE, irq);
+
+	rc = ioctl(self->fd, RTC_UIE_OFF, 0);
+	ASSERT_NE(-1, rc);
+}
+
+TEST_F(rtc, uie_select) {
+	int i, rc, irq = 0;
+	unsigned long data;
+
+	/* Turn on update interrupts */
+	rc = ioctl(self->fd, RTC_UIE_ON, 0);
+	if (rc == -1) {
+		ASSERT_EQ(EINVAL, errno);
+		TH_LOG("skip update IRQs not supported.");
+		return;
+	}
+
+	for (i = 0; i < NUM_UIE; i++) {
+		struct timeval tv = { .tv_sec = 2 };
+		fd_set readfds;
+
+		FD_ZERO(&readfds);
+		FD_SET(self->fd, &readfds);
+		/* The select will wait until an RTC interrupt happens. */
+		rc = select(self->fd + 1, &readfds, NULL, NULL, &tv);
+		ASSERT_NE(-1, rc);
+		ASSERT_NE(0, rc);
+
+		/* This read won't block */
+		rc = read(self->fd, &data, sizeof(unsigned long));
+		ASSERT_NE(-1, rc);
+		irq++;
+	}
+
+	EXPECT_EQ(NUM_UIE, irq);
+
+	rc = ioctl(self->fd, RTC_UIE_OFF, 0);
+	ASSERT_NE(-1, rc);
+}
+
+TEST_F(rtc, alarm_alm_set) {
+	struct timeval tv = { .tv_sec = ALARM_DELTA + 2 };
+	unsigned long data;
+	struct rtc_time tm;
+	fd_set readfds;
+	time_t secs, new;
+	int rc;
+
+	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
+	ASSERT_NE(-1, rc);
+
+	secs = timegm((struct tm *)&tm) + ALARM_DELTA;
+	gmtime_r(&secs, (struct tm *)&tm);
+
+	rc = ioctl(self->fd, RTC_ALM_SET, &tm);
+	if (rc == -1) {
+		ASSERT_EQ(EINVAL, errno);
+		TH_LOG("skip alarms are not supported.");
+		return;
+	}
+
+	rc = ioctl(self->fd, RTC_ALM_READ, &tm);
+	ASSERT_NE(-1, rc);
+
+	TH_LOG("Alarm time now set to %02d:%02d:%02d.",
+	       tm.tm_hour, tm.tm_min, tm.tm_sec);
+
+	/* Enable alarm interrupts */
+	rc = ioctl(self->fd, RTC_AIE_ON, 0);
+	ASSERT_NE(-1, rc);
+
+	FD_ZERO(&readfds);
+	FD_SET(self->fd, &readfds);
+
+	rc = select(self->fd + 1, &readfds, NULL, NULL, &tv);
+	ASSERT_NE(-1, rc);
+	EXPECT_NE(0, rc);
+
+	/* Disable alarm interrupts */
+	rc = ioctl(self->fd, RTC_AIE_OFF, 0);
+	ASSERT_NE(-1, rc);
+
+	if (rc == 0)
+		return;
+
+	rc = read(self->fd, &data, sizeof(unsigned long));
+	ASSERT_NE(-1, rc);
+	TH_LOG("data: %lx", data);
+
+	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
+	ASSERT_NE(-1, rc);
+
+	new = timegm((struct tm *)&tm);
+	ASSERT_EQ(new, secs);
+}
+
+TEST_F(rtc, alarm_wkalm_set) {
+	struct timeval tv = { .tv_sec = ALARM_DELTA + 2 };
+	struct rtc_wkalrm alarm = { 0 };
+	struct rtc_time tm;
+	unsigned long data;
+	fd_set readfds;
+	time_t secs, new;
+	int rc;
+
+	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
+	ASSERT_NE(-1, rc);
+
+	secs = timegm((struct tm *)&alarm.time) + ALARM_DELTA;
+	gmtime_r(&secs, (struct tm *)&alarm.time);
+
+	alarm.enabled = 1;
+
+	rc = ioctl(self->fd, RTC_WKALM_SET, &alarm);
+	if (rc == -1) {
+		ASSERT_EQ(EINVAL, errno);
+		TH_LOG("skip alarms are not supported.");
+		return;
+	}
+
+	rc = ioctl(self->fd, RTC_WKALM_RD, &alarm);
+	ASSERT_NE(-1, rc);
+
+	TH_LOG("Alarm time now set to %02d/%02d/%02d %02d:%02d:%02d.",
+	       alarm.time.tm_mday, alarm.time.tm_mon + 1,
+	       alarm.time.tm_year + 1900, alarm.time.tm_hour,
+	       alarm.time.tm_min, alarm.time.tm_sec);
+
+	FD_ZERO(&readfds);
+	FD_SET(self->fd, &readfds);
+
+	rc = select(self->fd + 1, &readfds, NULL, NULL, &tv);
+	ASSERT_NE(-1, rc);
+	EXPECT_NE(0, rc);
+
+	rc = read(self->fd, &data, sizeof(unsigned long));
+	ASSERT_NE(-1, rc);
+
+	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
+	ASSERT_NE(-1, rc);
+
+	new = timegm((struct tm *)&tm);
+	ASSERT_EQ(new, secs);
+}
+
+static void __attribute__((constructor))
+__constructor_order_last(void)
+{
+	if (!__constructor_order)
+		__constructor_order = _CONSTRUCTOR_ORDER_BACKWARD;
+}
+
+int main(int argc, char **argv)
+{
+	switch (argc) {
+	case 2:
+		rtc_file = argv[1];
+		/* FALLTHROUGH */
+	case 1:
+		break;
+	default:
+		fprintf(stderr, "usage: %s [rtcdev]\n", argv[0]);
+		return 1;
+	}
+
+	return test_harness_run(argc, argv);
+}
diff --git a/tools/testing/selftests/timers/rtctest_setdate.c b/tools/testing/selftests/rtc/setdate.c
similarity index 100%
rename from tools/testing/selftests/timers/rtctest_setdate.c
rename to tools/testing/selftests/rtc/setdate.c
diff --git a/tools/testing/selftests/timers/.gitignore b/tools/testing/selftests/timers/.gitignore
index 2c8ac8416299..32a9eadb2d4e 100644
--- a/tools/testing/selftests/timers/.gitignore
+++ b/tools/testing/selftests/timers/.gitignore
@@ -9,7 +9,7 @@ nanosleep
 nsleep-lat
 posix_timers
 raw_skew
-rtctest
+rtcpie
 set-2038
 set-tai
 set-timer-lat
@@ -19,4 +19,3 @@ valid-adjtimex
 adjtick
 set-tz
 freq-step
-rtctest_setdate
diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
index 3496680981f2..c02683cfb6c9 100644
--- a/tools/testing/selftests/timers/Makefile
+++ b/tools/testing/selftests/timers/Makefile
@@ -5,13 +5,13 @@ LDFLAGS += -lrt -lpthread -lm
 # these are all "safe" tests that don't modify
 # system time or require escalated privileges
 TEST_GEN_PROGS = posix_timers nanosleep nsleep-lat set-timer-lat mqueue-lat \
-	     inconsistency-check raw_skew threadtest rtctest
+	     inconsistency-check raw_skew threadtest rtcpie
 
 DESTRUCTIVE_TESTS = alarmtimer-suspend valid-adjtimex adjtick change_skew \
 		      skew_consistency clocksource-switch freq-step leap-a-day \
 		      leapcrash set-tai set-2038 set-tz
 
-TEST_GEN_PROGS_EXTENDED = $(DESTRUCTIVE_TESTS) rtctest_setdate
+TEST_GEN_PROGS_EXTENDED = $(DESTRUCTIVE_TESTS)
 
 
 include ../lib.mk
diff --git a/tools/testing/selftests/timers/rtcpie.c b/tools/testing/selftests/timers/rtcpie.c
new file mode 100644
index 000000000000..47b5bad1b393
--- /dev/null
+++ b/tools/testing/selftests/timers/rtcpie.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Real Time Clock Periodic Interrupt test program
+ *
+ * Since commit 6610e0893b8bc ("RTC: Rework RTC code to use timerqueue for
+ * events"), PIE are completely handled using hrtimers, without actually using
+ * any underlying hardware RTC.
+ *
+ */
+
+#include <stdio.h>
+#include <linux/rtc.h>
+#include <sys/ioctl.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <errno.h>
+
+/*
+ * This expects the new RTC class driver framework, working with
+ * clocks that will often not be clones of what the PC-AT had.
+ * Use the command line to specify another RTC if you need one.
+ */
+static const char default_rtc[] = "/dev/rtc0";
+
+int main(int argc, char **argv)
+{
+	int i, fd, retval, irqcount = 0;
+	unsigned long tmp, data, old_pie_rate;
+	const char *rtc = default_rtc;
+	struct timeval start, end, diff;
+
+	switch (argc) {
+	case 2:
+		rtc = argv[1];
+		/* FALLTHROUGH */
+	case 1:
+		break;
+	default:
+		fprintf(stderr, "usage:  rtctest [rtcdev] [d]\n");
+		return 1;
+	}
+
+	fd = open(rtc, O_RDONLY);
+
+	if (fd ==  -1) {
+		perror(rtc);
+		exit(errno);
+	}
+
+	/* Read periodic IRQ rate */
+	retval = ioctl(fd, RTC_IRQP_READ, &old_pie_rate);
+	if (retval == -1) {
+		/* not all RTCs support periodic IRQs */
+		if (errno == EINVAL) {
+			fprintf(stderr, "\nNo periodic IRQ support\n");
+			goto done;
+		}
+		perror("RTC_IRQP_READ ioctl");
+		exit(errno);
+	}
+	fprintf(stderr, "\nPeriodic IRQ rate is %ldHz.\n", old_pie_rate);
+
+	fprintf(stderr, "Counting 20 interrupts at:");
+	fflush(stderr);
+
+	/* The frequencies 128Hz, 256Hz, ... 8192Hz are only allowed for root. */
+	for (tmp=2; tmp<=64; tmp*=2) {
+
+		retval = ioctl(fd, RTC_IRQP_SET, tmp);
+		if (retval == -1) {
+			/* not all RTCs can change their periodic IRQ rate */
+			if (errno == EINVAL) {
+				fprintf(stderr,
+					"\n...Periodic IRQ rate is fixed\n");
+				goto done;
+			}
+			perror("RTC_IRQP_SET ioctl");
+			exit(errno);
+		}
+
+		fprintf(stderr, "\n%ldHz:\t", tmp);
+		fflush(stderr);
+
+		/* Enable periodic interrupts */
+		retval = ioctl(fd, RTC_PIE_ON, 0);
+		if (retval == -1) {
+			perror("RTC_PIE_ON ioctl");
+			exit(errno);
+		}
+
+		for (i=1; i<21; i++) {
+			gettimeofday(&start, NULL);
+			/* This blocks */
+			retval = read(fd, &data, sizeof(unsigned long));
+			if (retval == -1) {
+				perror("read");
+				exit(errno);
+			}
+			gettimeofday(&end, NULL);
+			timersub(&end, &start, &diff);
+			if (diff.tv_sec > 0 ||
+			    diff.tv_usec > ((1000000L / tmp) * 1.10)) {
+				fprintf(stderr, "\nPIE delta error: %ld.%06ld should be close to 0.%06ld\n",
+				       diff.tv_sec, diff.tv_usec,
+				       (1000000L / tmp));
+				fflush(stdout);
+				exit(-1);
+			}
+
+			fprintf(stderr, " %d",i);
+			fflush(stderr);
+			irqcount++;
+		}
+
+		/* Disable periodic interrupts */
+		retval = ioctl(fd, RTC_PIE_OFF, 0);
+		if (retval == -1) {
+			perror("RTC_PIE_OFF ioctl");
+			exit(errno);
+		}
+	}
+
+done:
+	ioctl(fd, RTC_IRQP_SET, old_pie_rate);
+
+	fprintf(stderr, "\n\n\t\t\t *** Test complete ***\n");
+
+	close(fd);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/timers/rtctest.c b/tools/testing/selftests/timers/rtctest.c
deleted file mode 100644
index 411eff625e66..000000000000
--- a/tools/testing/selftests/timers/rtctest.c
+++ /dev/null
@@ -1,403 +0,0 @@
-/*
- *      Real Time Clock Driver Test/Example Program
- *
- *      Compile with:
- *		     gcc -s -Wall -Wstrict-prototypes rtctest.c -o rtctest
- *
- *      Copyright (C) 1996, Paul Gortmaker.
- *
- *      Released under the GNU General Public License, version 2,
- *      included herein by reference.
- *
- */
-
-#include <stdio.h>
-#include <linux/rtc.h>
-#include <sys/ioctl.h>
-#include <sys/time.h>
-#include <sys/types.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <errno.h>
-
-#ifndef ARRAY_SIZE
-# define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-#endif
-
-/*
- * This expects the new RTC class driver framework, working with
- * clocks that will often not be clones of what the PC-AT had.
- * Use the command line to specify another RTC if you need one.
- */
-static const char default_rtc[] = "/dev/rtc0";
-
-static struct rtc_time cutoff_dates[] = {
-	{
-		.tm_year = 70, /* 1970 -1900 */
-		.tm_mday = 1,
-	},
-	/* signed time_t 19/01/2038 3:14:08 */
-	{
-		.tm_year = 138,
-		.tm_mday = 19,
-	},
-	{
-		.tm_year = 138,
-		.tm_mday = 20,
-	},
-	{
-		.tm_year = 199, /* 2099 -1900 */
-		.tm_mday = 1,
-	},
-	{
-		.tm_year = 200, /* 2100 -1900 */
-		.tm_mday = 1,
-	},
-	/* unsigned time_t 07/02/2106 7:28:15*/
-	{
-		.tm_year = 205,
-		.tm_mon = 1,
-		.tm_mday = 7,
-	},
-	{
-		.tm_year = 206,
-		.tm_mon = 1,
-		.tm_mday = 8,
-	},
-	/* signed time on 64bit in nanoseconds 12/04/2262 01:47:16*/
-	{
-		.tm_year = 362,
-		.tm_mon = 3,
-		.tm_mday = 12,
-	},
-	{
-		.tm_year = 362, /* 2262 -1900 */
-		.tm_mon = 3,
-		.tm_mday = 13,
-	},
-};
-
-static int compare_dates(struct rtc_time *a, struct rtc_time *b)
-{
-	if (a->tm_year != b->tm_year ||
-	    a->tm_mon != b->tm_mon ||
-	    a->tm_mday != b->tm_mday ||
-	    a->tm_hour != b->tm_hour ||
-	    a->tm_min != b->tm_min ||
-	    ((b->tm_sec - a->tm_sec) > 1))
-		return 1;
-
-	return 0;
-}
-
-int main(int argc, char **argv)
-{
-	int i, fd, retval, irqcount = 0, dangerous = 0;
-	unsigned long tmp, data;
-	struct rtc_time rtc_tm;
-	const char *rtc = default_rtc;
-	struct timeval start, end, diff;
-
-	switch (argc) {
-	case 3:
-		if (*argv[2] == 'd')
-			dangerous = 1;
-	case 2:
-		rtc = argv[1];
-		/* FALLTHROUGH */
-	case 1:
-		break;
-	default:
-		fprintf(stderr, "usage:  rtctest [rtcdev] [d]\n");
-		return 1;
-	}
-
-	fd = open(rtc, O_RDONLY);
-
-	if (fd ==  -1) {
-		perror(rtc);
-		exit(errno);
-	}
-
-	fprintf(stderr, "\n\t\t\tRTC Driver Test Example.\n\n");
-
-	/* Turn on update interrupts (one per second) */
-	retval = ioctl(fd, RTC_UIE_ON, 0);
-	if (retval == -1) {
-		if (errno == EINVAL) {
-			fprintf(stderr,
-				"\n...Update IRQs not supported.\n");
-			goto test_READ;
-		}
-		perror("RTC_UIE_ON ioctl");
-		exit(errno);
-	}
-
-	fprintf(stderr, "Counting 5 update (1/sec) interrupts from reading %s:",
-			rtc);
-	fflush(stderr);
-	for (i=1; i<6; i++) {
-		/* This read will block */
-		retval = read(fd, &data, sizeof(unsigned long));
-		if (retval == -1) {
-			perror("read");
-			exit(errno);
-		}
-		fprintf(stderr, " %d",i);
-		fflush(stderr);
-		irqcount++;
-	}
-
-	fprintf(stderr, "\nAgain, from using select(2) on /dev/rtc:");
-	fflush(stderr);
-	for (i=1; i<6; i++) {
-		struct timeval tv = {5, 0};     /* 5 second timeout on select */
-		fd_set readfds;
-
-		FD_ZERO(&readfds);
-		FD_SET(fd, &readfds);
-		/* The select will wait until an RTC interrupt happens. */
-		retval = select(fd+1, &readfds, NULL, NULL, &tv);
-		if (retval == -1) {
-		        perror("select");
-		        exit(errno);
-		}
-		/* This read won't block unlike the select-less case above. */
-		retval = read(fd, &data, sizeof(unsigned long));
-		if (retval == -1) {
-		        perror("read");
-		        exit(errno);
-		}
-		fprintf(stderr, " %d",i);
-		fflush(stderr);
-		irqcount++;
-	}
-
-	/* Turn off update interrupts */
-	retval = ioctl(fd, RTC_UIE_OFF, 0);
-	if (retval == -1) {
-		perror("RTC_UIE_OFF ioctl");
-		exit(errno);
-	}
-
-test_READ:
-	/* Read the RTC time/date */
-	retval = ioctl(fd, RTC_RD_TIME, &rtc_tm);
-	if (retval == -1) {
-		perror("RTC_RD_TIME ioctl");
-		exit(errno);
-	}
-
-	fprintf(stderr, "\n\nCurrent RTC date/time is %d-%d-%d, %02d:%02d:%02d.\n",
-		rtc_tm.tm_mday, rtc_tm.tm_mon + 1, rtc_tm.tm_year + 1900,
-		rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
-
-	/* Set the alarm to 5 sec in the future, and check for rollover */
-	rtc_tm.tm_sec += 5;
-	if (rtc_tm.tm_sec >= 60) {
-		rtc_tm.tm_sec %= 60;
-		rtc_tm.tm_min++;
-	}
-	if (rtc_tm.tm_min == 60) {
-		rtc_tm.tm_min = 0;
-		rtc_tm.tm_hour++;
-	}
-	if (rtc_tm.tm_hour == 24)
-		rtc_tm.tm_hour = 0;
-
-	retval = ioctl(fd, RTC_ALM_SET, &rtc_tm);
-	if (retval == -1) {
-		if (errno == EINVAL) {
-			fprintf(stderr,
-				"\n...Alarm IRQs not supported.\n");
-			goto test_PIE;
-		}
-
-		perror("RTC_ALM_SET ioctl");
-		exit(errno);
-	}
-
-	/* Read the current alarm settings */
-	retval = ioctl(fd, RTC_ALM_READ, &rtc_tm);
-	if (retval == -1) {
-		if (errno == EINVAL) {
-			fprintf(stderr,
-					"\n...EINVAL reading current alarm setting.\n");
-			goto test_PIE;
-		}
-		perror("RTC_ALM_READ ioctl");
-		exit(errno);
-	}
-
-	fprintf(stderr, "Alarm time now set to %02d:%02d:%02d.\n",
-		rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
-
-	/* Enable alarm interrupts */
-	retval = ioctl(fd, RTC_AIE_ON, 0);
-	if (retval == -1) {
-		if (errno == EINVAL || errno == EIO) {
-			fprintf(stderr,
-				"\n...Alarm IRQs not supported.\n");
-			goto test_PIE;
-		}
-
-		perror("RTC_AIE_ON ioctl");
-		exit(errno);
-	}
-
-	fprintf(stderr, "Waiting 5 seconds for alarm...");
-	fflush(stderr);
-	/* This blocks until the alarm ring causes an interrupt */
-	retval = read(fd, &data, sizeof(unsigned long));
-	if (retval == -1) {
-		perror("read");
-		exit(errno);
-	}
-	irqcount++;
-	fprintf(stderr, " okay. Alarm rang.\n");
-
-	/* Disable alarm interrupts */
-	retval = ioctl(fd, RTC_AIE_OFF, 0);
-	if (retval == -1) {
-		perror("RTC_AIE_OFF ioctl");
-		exit(errno);
-	}
-
-test_PIE:
-	/* Read periodic IRQ rate */
-	retval = ioctl(fd, RTC_IRQP_READ, &tmp);
-	if (retval == -1) {
-		/* not all RTCs support periodic IRQs */
-		if (errno == EINVAL) {
-			fprintf(stderr, "\nNo periodic IRQ support\n");
-			goto test_DATE;
-		}
-		perror("RTC_IRQP_READ ioctl");
-		exit(errno);
-	}
-	fprintf(stderr, "\nPeriodic IRQ rate is %ldHz.\n", tmp);
-
-	fprintf(stderr, "Counting 20 interrupts at:");
-	fflush(stderr);
-
-	/* The frequencies 128Hz, 256Hz, ... 8192Hz are only allowed for root. */
-	for (tmp=2; tmp<=64; tmp*=2) {
-
-		retval = ioctl(fd, RTC_IRQP_SET, tmp);
-		if (retval == -1) {
-			/* not all RTCs can change their periodic IRQ rate */
-			if (errno == EINVAL) {
-				fprintf(stderr,
-					"\n...Periodic IRQ rate is fixed\n");
-				goto test_DATE;
-			}
-			perror("RTC_IRQP_SET ioctl");
-			exit(errno);
-		}
-
-		fprintf(stderr, "\n%ldHz:\t", tmp);
-		fflush(stderr);
-
-		/* Enable periodic interrupts */
-		retval = ioctl(fd, RTC_PIE_ON, 0);
-		if (retval == -1) {
-			perror("RTC_PIE_ON ioctl");
-			exit(errno);
-		}
-
-		for (i=1; i<21; i++) {
-			gettimeofday(&start, NULL);
-			/* This blocks */
-			retval = read(fd, &data, sizeof(unsigned long));
-			if (retval == -1) {
-				perror("read");
-				exit(errno);
-			}
-			gettimeofday(&end, NULL);
-			timersub(&end, &start, &diff);
-			if (diff.tv_sec > 0 ||
-			    diff.tv_usec > ((1000000L / tmp) * 1.10)) {
-				fprintf(stderr, "\nPIE delta error: %ld.%06ld should be close to 0.%06ld\n",
-				       diff.tv_sec, diff.tv_usec,
-				       (1000000L / tmp));
-				fflush(stdout);
-				exit(-1);
-			}
-
-			fprintf(stderr, " %d",i);
-			fflush(stderr);
-			irqcount++;
-		}
-
-		/* Disable periodic interrupts */
-		retval = ioctl(fd, RTC_PIE_OFF, 0);
-		if (retval == -1) {
-			perror("RTC_PIE_OFF ioctl");
-			exit(errno);
-		}
-	}
-
-test_DATE:
-	if (!dangerous)
-		goto done;
-
-	fprintf(stderr, "\nTesting problematic dates\n");
-
-	for (i = 0; i < ARRAY_SIZE(cutoff_dates); i++) {
-		struct rtc_time current;
-
-		/* Write the new date in RTC */
-		retval = ioctl(fd, RTC_SET_TIME, &cutoff_dates[i]);
-		if (retval == -1) {
-			perror("RTC_SET_TIME ioctl");
-			close(fd);
-			exit(errno);
-		}
-
-		/* Read back */
-		retval = ioctl(fd, RTC_RD_TIME, &current);
-		if (retval == -1) {
-			perror("RTC_RD_TIME ioctl");
-			exit(errno);
-		}
-
-		if(compare_dates(&cutoff_dates[i], &current)) {
-			fprintf(stderr,"Setting date %d failed\n",
-			        cutoff_dates[i].tm_year + 1900);
-			goto done;
-		}
-
-		cutoff_dates[i].tm_sec += 5;
-
-		/* Write the new alarm in RTC */
-		retval = ioctl(fd, RTC_ALM_SET, &cutoff_dates[i]);
-		if (retval == -1) {
-			perror("RTC_ALM_SET ioctl");
-			close(fd);
-			exit(errno);
-		}
-
-		/* Read back */
-		retval = ioctl(fd, RTC_ALM_READ, &current);
-		if (retval == -1) {
-			perror("RTC_ALM_READ ioctl");
-			exit(errno);
-		}
-
-		if(compare_dates(&cutoff_dates[i], &current)) {
-			fprintf(stderr,"Setting alarm %d failed\n",
-			        cutoff_dates[i].tm_year + 1900);
-			goto done;
-		}
-
-		fprintf(stderr, "Setting year %d is OK \n",
-			cutoff_dates[i].tm_year + 1900);
-	}
-done:
-	fprintf(stderr, "\n\n\t\t\t *** Test complete ***\n");
-
-	close(fd);
-
-	return 0;
-}
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 39f66bc29b82..186520198de7 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -8,6 +8,7 @@ include ../lib.mk
 UNAME_M := $(shell uname -m)
 CAN_BUILD_I386 := $(shell ./check_cc.sh $(CC) trivial_32bit_program.c -m32)
 CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC) trivial_64bit_program.c)
+CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
 
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl mpx-mini-test ioperm \
@@ -31,7 +32,12 @@ BINARIES_64 := $(TARGETS_C_64BIT_ALL:%=%_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
 BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
 
-CFLAGS := -O2 -g -std=gnu99 -pthread -Wall -no-pie
+CFLAGS := -O2 -g -std=gnu99 -pthread -Wall
+
+# call32_from_64 in thunks.S uses absolute addresses.
+ifeq ($(CAN_BUILD_WITH_NOPIE),1)
+CFLAGS += -no-pie
+endif
 
 define gen-target-rule-32
 $(1) $(1)_32: $(OUTPUT)/$(1)_32
diff --git a/tools/testing/selftests/x86/trivial_program.c b/tools/testing/selftests/x86/trivial_program.c
new file mode 100644
index 000000000000..46a447163b93
--- /dev/null
+++ b/tools/testing/selftests/x86/trivial_program.c
@@ -0,0 +1,10 @@
+/* Trivial program to check that compilation with certain flags is working. */
+
+#include <stdio.h>
+
+int
+main(void)
+{
+	puts("");
+	return 0;
+}

--------------A4B0CDA5D96F0E2CE7B8226B--
