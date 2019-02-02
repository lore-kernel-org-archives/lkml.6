Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04F6C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177FE2146E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfBBGLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 01:11:23 -0500
Received: from mga02.intel.com ([134.134.136.20]:44681 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfBBGLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 01:11:22 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 22:11:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,551,1539673200"; 
   d="xz'?scan'208";a="315717157"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.107])
  by fmsmga006.fm.intel.com with ESMTP; 01 Feb 2019 22:11:08 -0800
Date:   Sat, 2 Feb 2019 14:11:30 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Florian La Roche <florian.laroche@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, Crt Mori <cmo@melexis.com>,
        Joe Perches <joe@perches.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Florian La Roche <Florian.LaRoche@googlemail.com>, lkp@01.org
Subject: [LKP] 32bd07585d: kernel_selftests.lib.prime_numbers.sh.fail
Message-ID: <20190202061129.GB8158@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
In-Reply-To: <20190119151450.26879-1-Florian.LaRoche@googlemail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

FYI, we noticed the following commit (built with gcc-7):

commit: 32bd07585d303a945d476d3d86b3c0dae43a9919 ("fix int_sqrt() for very =
large numbers")
url: https://github.com/0day-ci/linux/commits/Florian-La-Roche/fix-int_sqrt=
-for-very-large-numbers/20190122-045319


in testcase: kernel_selftests
with following parameters:

	group: kselftests-01

test-description: The kernel contains a set of "self tests" under the tools=
/testing/selftests/ directory. These are intended to be small unit tests to=
 exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m =
4G

caused below changes (please refer to attached dmesg/kmsg for entire log/ba=
cktrace):




KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7=
=2E2-32bd07585d303a945d476d3d86b3c0dae43a9919
2019-02-01 19:32:50 ln -sf /usr/bin/clang-7 /usr/bin/clang
2019-02-01 19:32:50 ln -sf /usr/bin/llc-7 /usr/bin/llc

2019-02-01 19:32:50 chown lkp capabilities -R
2019-02-01 19:32:50 su lkp -c make run_tests -C capabilities 2>&1
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/capabilities'
gcc -O2 -g -std=3Dgnu99 -Wall    test_execve.c -lcap-ng -lrt -ldl -o /usr/s=
rc/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/=
tools/testing/selftests/capabilities/test_execve
gcc -O2 -g -std=3Dgnu99 -Wall    validate_cap.c -lcap-ng -lrt -ldl -o /usr/=
src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919=
/tools/testing/selftests/capabilities/validate_cap
TAP version 13
selftests: capabilities: test_execve
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
# validate_cap:: Capabilities after execve were correct
# validate_cap:: Capabilities after execve were correct
# validate_cap:: Capabilities after execve were correct
# [RUN]	+++ Tests with uid =3D=3D 0 +++
# [NOTE]	Using a user namespace for tests
# [RUN]	Root =3D> ep
ok 1 Passed
# Check cap_ambient manipulation rules
ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
ok 4 PR_CAP_AMBIENT_RAISE worked
ok 5 Basic manipulation appears to work
# [RUN]	Root +i =3D> eip
ok 6 Passed
# [RUN]	UID 0 +ia =3D> eipa
ok 7 Passed
ok 8 # skip SUID/SGID tests (needs privilege)
Pass 7 Fail 0 Xfail 0 Xpass 0 Skip 1 Error 0
1..8
# validate_cap:: Capabilities after execve were correct
# validate_cap:: Capabilities after execve were correct
# validate_cap:: Capabilities after execve were correct
# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
# [RUN]	+++ Tests with uid !=3D 0 +++
# [NOTE]	Using a user namespace for tests
# [RUN]	Non-root =3D> no caps
ok 1 Passed
# Check cap_ambient manipulation rules
ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
ok 4 PR_CAP_AMBIENT_RAISE worked
ok 5 Basic manipulation appears to work
# [RUN]	Non-root +i =3D> i
ok 6 Passed
# [RUN]	UID 1 +ia =3D> eipa
ok 7 Passed
ok 8 # skip SUID/SGID tests (needs privilege)
Pass 7 Fail 0 Xfail 0 Xpass 0 Skip 1 Error 0
1..8
# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
ok 1..1 selftests: capabilities: test_execve [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/capabilities'
ignored_by_lkp cgroup test

2019-02-01 19:32:50 make run_tests -C cpu-hotplug
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/cpu-hotplug'
TAP version 13
selftests: cpu-hotplug: cpu-on-off-test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
pid 1199's current affinity mask: 3
pid 1199's new affinity mask: 1
CPU online/offline summary:
	 Cpus in online state: 0-1
	 Cpus in offline state: 0
Limited scope test: one hotplug cpu
	 (leaves cpu in the original state):
	 online to offline to online: cpu 1
ok 1..1 selftests: cpu-hotplug: cpu-on-off-test.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/cpu-hotplug'

2019-02-01 19:32:51 make run_tests -C cpufreq
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/cpufreq'
TAP version 13
selftests: cpufreq: main.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
pid 1260's current affinity mask: 3
pid 1260's new affinity mask: 1
not ok 1..1 selftests: cpufreq: main.sh [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/cpufreq'
ignored_by_lkp efivarfs test: /sys/firmware/efi dir does not exist

2019-02-01 19:32:51 make run_tests -C exec
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/exec'
gcc -Wall    execveat.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/exec/execveat
cd /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0da=
e43a9919/tools/testing/selftests/exec && ln -s -f execveat execveat.symlink
cp /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0da=
e43a9919/tools/testing/selftests/exec/execveat /usr/src/perf_selftests-x86_=
64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftest=
s/exec/execveat.denatured
chmod -x /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86=
b3c0dae43a9919/tools/testing/selftests/exec/execveat.denatured
echo '#!/bin/sh' > /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a94=
5d476d3d86b3c0dae43a9919/tools/testing/selftests/exec/script
echo 'exit $*' >> /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945=
d476d3d86b3c0dae43a9919/tools/testing/selftests/exec/script
chmod +x /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86=
b3c0dae43a9919/tools/testing/selftests/exec/script
mkdir -p /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86=
b3c0dae43a9919/tools/testing/selftests/exec/subdir
TAP version 13
selftests: exec: execveat
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
/bin/sh: 0: Can't open /dev/fd/7/usr/src/perf_selftests-x86_64-rhel-7.2-32b=
d07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/exec/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
Check success of execveat(4, '../execveat', 0)... [OK]
Check success of execveat(6, 'execveat', 0)... [OK]
Check success of execveat(8, 'execveat', 0)... [OK]
Check success of execveat(-100, '/usr/src/perf_selfte...ftests/exec/execvea=
t', 0)... [OK]
Check success of execveat(99, '/usr/src/perf_selfte...ftests/exec/execveat'=
, 0)... [OK]
Check success of execveat(10, '', 4096)... [OK]
Check success of execveat(19, '', 4096)... [OK]
Check success of execveat(11, '', 4096)... [OK]
Check success of execveat(16, '', 4096)... [OK]
Check success of execveat(16, '', 4096)... [OK]
Check success of execveat(17, '', 4096)... [OK]
Check failure of execveat(10, '', 0) with ENOENT... [OK]
Check failure of execveat(10, '(null)', 4096) with EFAULT... [OK]
Check success of execveat(6, 'execveat.symlink', 0)... [OK]
Check success of execveat(8, 'execveat.symlink', 0)... [OK]
Check success of execveat(-100, '/usr/src/perf_selfte...xec/execveat.symlin=
k', 0)... [OK]
Check success of execveat(12, '', 4096)... [OK]
Check success of execveat(12, '', 4352)... [OK]
Check failure of execveat(6, 'execveat.symlink', 256) with ELOOP... [OK]
Check failure of execveat(8, 'execveat.symlink', 256) with ELOOP... [OK]
Check failure of execveat(-100, '/usr/src/perf_selftests-x86_64-rhel-7.2-32=
bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/exec/execvea=
t.symlink', 256) with ELOOP... [OK]
Check success of execveat(4, '../script', 0)... [OK]
Check success of execveat(6, 'script', 0)... [OK]
Check success of execveat(8, 'script', 0)... [OK]
Check success of execveat(-100, '/usr/src/perf_selfte...elftests/exec/scrip=
t', 0)... [OK]
Check success of execveat(15, '', 4096)... [OK]
Check success of execveat(15, '', 4352)... [OK]
Check failure of execveat(20, '', 4096) with ENOENT... [OK]
Check failure of execveat(9, 'script', 0) with ENOENT... [OK]
Check success of execveat(18, '', 4096)... [OK]
Check success of execveat(18, '', 4096)... [OK]
Check success of execveat(5, '../script', 0)... [OK]
Check success of execveat(5, 'script', 0)... [OK]
Check success of execveat(5, '../script', 0)... [OK]
Check failure of execveat(5, 'script', 0) with ENOENT... [OK]
Check failure of execveat(6, 'execveat', 65535) with EINVAL... [OK]
Check failure of execveat(6, 'no-such-file', 0) with ENOENT... [OK]
Check failure of execveat(8, 'no-such-file', 0) with ENOENT... [OK]
Check failure of execveat(-100, 'no-such-file', 0) with ENOENT... [OK]
Check failure of execveat(6, '', 4096) with EACCES... [OK]
Check failure of execveat(6, 'Makefile', 0) with EACCES... [OK]
Check failure of execveat(13, '', 4096) with EACCES... [OK]
Check failure of execveat(14, '', 4096) with EACCES... [OK]
Check failure of execveat(99, '', 4096) with EBADF... [OK]
Check failure of execveat(99, 'execveat', 0) with EBADF... [OK]
Check failure of execveat(10, 'execveat', 0) with ENOTDIR... [OK]
Invoke copy of 'execveat' via filename of length 4094:
Check success of execveat(21, '', 4096)... [OK]
Check success of execveat(7, 'usr/src/perf_selftes...yyyyyyyyyyyyyyyyyyyy',=
 0)... [OK]
Invoke copy of 'script' via filename of length 4094:
Check success of execveat(22, '', 4096)... [OK]
Check success of execveat(7, 'usr/src/perf_selftes...yyyyyyyyyyyyyyyyyyyy',=
 0)... [OK]
ok 1..1 selftests: exec: execveat [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/exec'
ignored_by_lkp filesystems test
2019-02-01 19:32:51 mv /lib/udev/rules.d/50-firmware.rules .
2019-02-01 19:32:51 /etc/init.d/udev restart
Restarting udev (via systemctl): udev.service.

2019-02-01 19:32:51 make run_tests -C firmware
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/firmware'
TAP version 13
selftests: firmware: fw_run_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-----------------------------------------------------
Running kernel configuration test 1 -- rare
Emulates:
CONFIG_FW_LOADER=3Dy
CONFIG_FW_LOADER_USER_HELPER=3Dn
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=3Dn
=2E/fw_filesystem.sh: filesystem loading works
=2E/fw_filesystem.sh: async filesystem loading works

Testing with the file present...
Batched request_firmware() try #1: Files /tmp/tmp.QCJhVEPkiu/test-firmware.=
bin and /sys/devices/virtual/misc/test_firmware/read_firmware differ
request #0: firmware was not loaded
not ok 1..1 selftests: firmware: fw_run_tests.sh [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/firmware'
2019-02-01 19:32:51 mv 50-firmware.rules /lib/udev/rules.d/50-firmware.rules

2019-02-01 19:32:51 make run_tests -C ftrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ftrace'
TAP version 13
selftests: ftrace: ftracetest
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2E/ftracetest: 163: [: Illegal number:=20
-e =3D=3D=3D Ftrace unit tests =3D=3D=3D
-e -n [1] Basic trace file check
-e 	[PASS]
-e -n [2] Basic test for tracers
-e 	[PASS]
-e -n [3] Basic trace clock test
-e 	[PASS]
-e -n [4] Basic event tracing check
-e 	[PASS]
-e -n [5] Change the ringbuffer size
-e 	[PASS]
-e -n [6] Snapshot and tracing setting
-e 	[PASS]
-e -n [7] trace_pipe and trace_marker
-e 	[PASS]
-e -n [8] Generic dynamic event - add/remove kprobe events
-e 	[PASS]
-e -n [9] Generic dynamic event - add/remove synthetic events
-e 	[PASS]
-e -n [10] Generic dynamic event - selective clear (compatibility)
-e 	[PASS]
-e -n [11] Generic dynamic event - generic clear event
-e 	[PASS]
-e -n [12] event tracing - enable/disable with event level files
-e 	[PASS]
-e -n [13] event tracing - restricts events based on pid
-e 	[PASS]
-e -n [14] event tracing - enable/disable with subsystem level files
-e 	[PASS]
-e -n [15] event tracing - enable/disable with top level files
-e 	[PASS]
-e -n [16] Test trace_printk from module
-e 	[UNRESOLVED]
-e -n [17] ftrace - function graph filters with stack tracer
-e 	[PASS]
-e -n [18] ftrace - function graph filters
-e 	[PASS]
-e -n [19] ftrace - function glob filters
-e 	[PASS]
-e -n [20] ftrace - function pid filters
-e 	[PASS]
-e -n [21] ftrace - stacktrace filter command
-e 	[PASS]
-e -n [22] ftrace - function trace with cpumask
-e 	[PASS]
-e -n [23] ftrace - test for function event triggers
-e 	[PASS]
-e -n [24] ftrace - function trace on module
-e 	[UNRESOLVED]
-e -n [25] ftrace - function profiling
-e 	[PASS]
-e -n [26] ftrace - function profiler with function tracing
-e 	[PASS]
-e -n [27] ftrace - test reading of set_ftrace_filter
-e 	[PASS]
-e -n [28] ftrace - Max stack tracer
-e 	[PASS]
-e -n [29] ftrace - test for function traceon/off triggers
-e 	[PASS]
-e -n [30] Test creation and deletion of trace instances while setting an e=
vent
-e 	[PASS]
-e -n [31] Test creation and deletion of trace instances
-e 	[PASS]
-e -n [32] Kprobe dynamic event - adding and removing
-e 	[PASS]
-e -n [33] Kprobe dynamic event - busy event check
-e 	[PASS]
-e -n [34] Kprobe dynamic event with arguments
-e 	[PASS]
-e -n [35] Kprobe event with comm arguments
-e 	[PASS]
-e -n [36] Kprobe event string type argument
-e 	[PASS]
-e -n [37] Kprobe event symbol argument
-e 	[PASS]
-e -n [38] Kprobe event argument syntax
-e 	[PASS]
-e -n [39] Kprobes event arguments with types
-e 	[PASS]
-e -n [40] Kprobe event auto/manual naming
-e 	[PASS]
-e -n [41] Kprobe dynamic event with function tracer
-e 	[PASS]
-e -n [42] Kprobe dynamic event - probing module
-e 	[UNRESOLVED]
-e -n [43] Kretprobe dynamic event with arguments
-e 	[PASS]
-e -n [44] Kretprobe dynamic event with maxactive
-e 	[PASS]
-e -n [45] Register/unregister many kprobe events
-e 	[PASS]
-e -n [46] Kprobe events - probe points
-e 	[PASS]
-e -n [47] Kprobe dynamic event - adding and removing
-e 	[PASS]
-e -n [48] test for the preemptirqsoff tracer
-e 	[UNSUPPORTED]
-e -n [49] Test wakeup tracer
-e 	[PASS]
-e -n [50] Test wakeup RT tracer
-e 	[PASS]
-e -n [51] event trigger - test extended error support
-e 	[PASS]
-e -n [52] event trigger - test field variable support
-e 	[PASS]
-e -n [53] event trigger - test inter-event combined histogram trigger
-e 	[PASS]
-e -n [54] event trigger - test multiple actions on hist trigger
-e 	[PASS]
-e -n [55] event trigger - test inter-event histogram trigger onmatch action
-e 	[PASS]
-e -n [56] event trigger - test inter-event histogram trigger onmatch-onmax=
 action
-e 	[PASS]
-e -n [57] event trigger - test inter-event histogram trigger onmax action
-e 	[PASS]
-e -n [58] event trigger - test synthetic event create remove
-e 	[PASS]
-e -n [59] event trigger - test synthetic_events syntax parser
-e 	[PASS]
-e -n [60] event trigger - test event enable/disable trigger
-e 	[PASS]
-e -n [61] event trigger - test trigger filter
-e 	[PASS]
-e -n [62] event trigger - test histogram modifiers
-e 	[PASS]
-e -n [63] event trigger - test histogram trigger
-e 	[PASS]
-e -n [64] event trigger - test multiple histogram triggers
-e 	[PASS]
-e -n [65] event trigger - test snapshot-trigger
-e 	[PASS]
-e -n [66] event trigger - test stacktrace-trigger
-e 	[PASS]
-e -n [67] trace_marker trigger - test histogram trigger
-e 	[PASS]
-e -n [68] trace_marker trigger - test snapshot trigger
-e 	[PASS]
-e -n [69] trace_marker trigger - test histogram with synthetic event again=
st kernel event
-e 	[PASS]
-e -n [70] trace_marker trigger - test histogram with synthetic event
-e 	[PASS]
-e -n [71] event trigger - test traceon/off trigger
-e 	[PASS]
-e -n [72] (instance)  Basic test for tracers
-e 	[PASS]
-e -n [73] (instance)  Basic trace clock test
-e 	[PASS]
-e -n [74] (instance)  Change the ringbuffer size
-e 	[PASS]
-e -n [75] (instance)  Snapshot and tracing setting
-e 	[PASS]
-e -n [76] (instance)  trace_pipe and trace_marker
-e 	[PASS]
-e -n [77] (instance)  event tracing - enable/disable with event level files
-e 	[PASS]
-e -n [78] (instance)  event tracing - restricts events based on pid
-e 	[PASS]
-e -n [79] (instance)  event tracing - enable/disable with subsystem level =
files
-e 	[PASS]
-e -n [80] (instance)  ftrace - stacktrace filter command
-e 	[PASS]
-e -n [81] (instance)  ftrace - test for function event triggers
-e 	[PASS]
-e -n [82] (instance)  ftrace - test for function traceon/off triggers
-e 	[PASS]
-e -n [83] (instance)  event trigger - test event enable/disable trigger
-e 	[PASS]
-e -n [84] (instance)  event trigger - test trigger filter
-e 	[PASS]
-e -n [85] (instance)  event trigger - test histogram modifiers
-e 	[PASS]
-e -n [86] (instance)  event trigger - test histogram trigger
-e 	[PASS]
-e -n [87] (instance)  event trigger - test multiple histogram triggers
-e 	[PASS]
-e -n [88] (instance)  trace_marker trigger - test histogram trigger
-e 	[PASS]
-e -n [89] (instance)  trace_marker trigger - test snapshot trigger
-e 	[PASS]


-e=20
-e # of passed:  85
-e # of failed:  0
-e # of unresolved:  3
-e # of untested:  0
-e # of unsupported:  1
-e # of xfailed:  0
-e # of undefined(test bug):  0
not ok 1..1 selftests: ftrace: ftracetest [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ftrace'

2019-02-01 19:34:47 make run_tests -C futex
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/futex'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/futex/functional'
make ARCH=3Dx86 -C ../../../../.. headers_install
make[2]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919'
  HOSTCC  scripts/basic/fixdep
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  UPD     include/generated/uapi/linux/version.h
  HOSTCC  scripts/unifdef
  INSTALL usr/include/asm-generic/ (37 files)
  INSTALL usr/include/drm/ (26 files)
  INSTALL usr/include/linux/ (503 files)
  INSTALL usr/include/linux/android/ (2 files)
  INSTALL usr/include/linux/byteorder/ (2 files)
  INSTALL usr/include/linux/caif/ (2 files)
  INSTALL usr/include/linux/can/ (6 files)
  INSTALL usr/include/linux/cifs/ (1 file)
  INSTALL usr/include/linux/dvb/ (8 files)
  INSTALL usr/include/linux/genwqe/ (1 file)
  INSTALL usr/include/linux/hdlc/ (1 file)
  INSTALL usr/include/linux/hsi/ (2 files)
  INSTALL usr/include/linux/iio/ (2 files)
  INSTALL usr/include/linux/isdn/ (1 file)
  INSTALL usr/include/linux/mmc/ (1 file)
  INSTALL usr/include/linux/netfilter/ (88 files)
  INSTALL usr/include/linux/netfilter/ipset/ (4 files)
  INSTALL usr/include/linux/netfilter_arp/ (2 files)
  INSTALL usr/include/linux/netfilter_bridge/ (17 files)
  INSTALL usr/include/linux/netfilter_ipv4/ (9 files)
  INSTALL usr/include/linux/netfilter_ipv6/ (13 files)
  INSTALL usr/include/linux/nfsd/ (5 files)
  INSTALL usr/include/linux/raid/ (2 files)
  INSTALL usr/include/linux/sched/ (1 file)
  INSTALL usr/include/linux/spi/ (1 file)
  INSTALL usr/include/linux/sunrpc/ (1 file)
  INSTALL usr/include/linux/tc_act/ (15 files)
  INSTALL usr/include/linux/tc_ematch/ (5 files)
  INSTALL usr/include/linux/usb/ (13 files)
  INSTALL usr/include/linux/wimax/ (1 file)
  INSTALL usr/include/misc/ (2 files)
  INSTALL usr/include/mtd/ (5 files)
  INSTALL usr/include/rdma/ (25 files)
  INSTALL usr/include/rdma/hfi/ (2 files)
  INSTALL usr/include/scsi/ (5 files)
  INSTALL usr/include/scsi/fc/ (4 files)
  INSTALL usr/include/sound/ (16 files)
  INSTALL usr/include/video/ (3 files)
  INSTALL usr/include/xen/ (4 files)
  INSTALL usr/include/asm/ (62 files)
make[2]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919'
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_wait_timeout.c ../include/futextest.h ../include/atomic.h ../inc=
lude/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a94=
5d476d3d86b3c0dae43a9919/tools/testing/selftests/futex/functional/futex_wai=
t_timeout
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_wait_wouldblock.c ../include/futextest.h ../include/atomic.h ../=
include/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303=
a945d476d3d86b3c0dae43a9919/tools/testing/selftests/futex/functional/futex_=
wait_wouldblock
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_requeue_pi.c ../include/futextest.h ../include/atomic.h ../inclu=
de/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d=
476d3d86b3c0dae43a9919/tools/testing/selftests/futex/functional/futex_reque=
ue_pi
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_requeue_pi_signal_restart.c ../include/futextest.h ../include/at=
omic.h ../include/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-32b=
d07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/futex/functio=
nal/futex_requeue_pi_signal_restart
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_requeue_pi_mismatched_ops.c ../include/futextest.h ../include/at=
omic.h ../include/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-32b=
d07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/futex/functio=
nal/futex_requeue_pi_mismatched_ops
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_wait_uninitialized_heap.c ../include/futextest.h ../include/atom=
ic.h ../include/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd0=
7585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/futex/functiona=
l/futex_wait_uninitialized_heap
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_wait_private_mapped_file.c ../include/futextest.h ../include/ato=
mic.h ../include/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd=
07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/futex/function=
al/futex_wait_private_mapped_file
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/futex/functional'
TAP version 13
selftests: futex: run.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified

# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D0 owner=3D1 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D2000000000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D2000000000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1

# futex_requeue_pi_mismatched_ops: Detect mismatched requeue_pi operations
ok 1 futex-requeue-pi-mismatched-ops
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1

# futex_requeue_pi_signal_restart: Test signal handling during requeue_pi
# 	Arguments: <none>
ok 1 futex-requeue-pi-signal-restart
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1

# futex_wait_timeout: Block on a futex and wait for timeout
# 	Arguments: timeout=3D100000ns
ok 1 futex-wait-timeout
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1

# futex_wait_wouldblock: Test the unexpected futex value in FUTEX_WAIT
ok 1 futex-wait-wouldblock
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1

# futex_wait_uninitialized_heap: Test the uninitialized futex value in FUTE=
X_WAIT
ok 1 futex-wait-uninitialized-heap
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_wait_private_mapped_file: Test the futex value of private file mapp=
ings in FUTEX_WAIT
ok 1 futex-wait-private-mapped-file
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
ok 1..1 selftests: futex: run.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/futex'

2019-02-01 19:35:29 make run_tests -C gpio
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/gpio'
make OUTPUT=3D/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476=
d3d86b3c0dae43a9919/tools/gpio/ -C /usr/src/perf_selftests-x86_64-rhel-7.2-=
32bd07585d303a945d476d3d86b3c0dae43a9919/tools/gpio
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919/tools/gpio'
mkdir -p /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86=
b3c0dae43a9919/tools/gpio/include/linux 2>&1 || true
ln -sf /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3=
c0dae43a9919/tools/gpio/../../include/uapi/linux/gpio.h /usr/src/perf_selft=
ests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/gpio/in=
clude/linux/gpio.h
make -f /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b=
3c0dae43a9919/tools/build/Makefile.build dir=3D. obj=3Dlsgpio
make[2]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919/tools/gpio'
  CC       /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/gpio/lsgpio.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/gpio/gpio-utils.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/gpio/lsgpio-in.o
make[2]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919/tools/gpio'
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/gpio/lsgpio
make -f /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b=
3c0dae43a9919/tools/build/Makefile.build dir=3D. obj=3Dgpio-hammer
make[2]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919/tools/gpio'
  CC       /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/gpio/gpio-hammer.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/gpio/gpio-hammer-in.o
make[2]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919/tools/gpio'
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/gpio/gpio-hammer
make -f /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b=
3c0dae43a9919/tools/build/Makefile.build dir=3D. obj=3Dgpio-event-mon
make[2]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919/tools/gpio'
  CC       /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/gpio/gpio-event-mon.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/gpio/gpio-event-mon-in.o
make[2]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919/tools/gpio'
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/gpio/gpio-event-mon
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919/tools/gpio'
gcc -O2 -g -std=3Dgnu99 -Wall -I../../../../usr/include/ -I/usr/include/lib=
mount -I/usr/include/blkid -I/usr/include/uuid    gpio-mockup-chardev.c /us=
r/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a99=
19/tools/gpio/gpio-utils.o  -lmount -o gpio-mockup-chardev
make ARCH=3Dx86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919'
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919'
TAP version 13
selftests: gpio: gpio-mockup.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1.  Test dynamic allocation of gpio successful means insert gpiochip and
    manipulate gpio pin successful
GPIO gpio-mockup test with ranges: <-1,32>:=20
-1,32     =20
gpio<gpio-mockup> test failed
Test gpiochip gpio-mockup: GPIO gpio-mockup test with ranges: <-1,32,-1,32>=
:=20
-1,32,-1,32=20
gpio<gpio-mockup> test failed
Test gpiochip gpio-mockup: GPIO gpio-mockup test with ranges: <-1,32,-1,32,=
-1,32>:=20
-1,32,-1,32,-1,32=20
gpio<gpio-mockup> test failed
Test gpiochip gpio-mockup: 3.  Error test: successful means insert gpiochip=
 failed
3.1 Test number of gpio overflow
GPIO gpio-mockup test with ranges: <-1,32,-1,1024>:=20
-1,32,-1,1024=20
Test gpiochip gpio-mockup: Invalid test successful
GPIO test PASS
ok 1..1 selftests: gpio: gpio-mockup.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/gpio'
ia64 test: not in Makefile
2019-02-01 19:35:36 make TARGETS=3Dia64
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ia64'
Makefile:9: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
gcc     aliasing-test.c   -o aliasing-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ia64'

2019-02-01 19:35:36 make run_tests -C ia64
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ia64'
Makefile:9: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
TAP version 13
selftests: ia64: aliasing-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PASS: /dev/mem 0x0-0xa0000 is readable
PASS: /dev/mem 0xa0000-0xc0000 is mappable
PASS: /dev/mem 0xc0000-0x100000 is readable
PASS: /dev/mem 0x0-0x100000 is mappable
PASS: /sys/devices/pci0000:00/0000:00:02.0/rom read 39422 bytes
PASS: /sys/devices/pci0000:00/0000:00:03.0/rom read 231422 bytes
PASS: /proc/bus/pci/00/00.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/01.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/01.1 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/01.3 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/02.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/03.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/04.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/05.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/06.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/07.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/08.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/09.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/0a.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/0b.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/00.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/01.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/01.1 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/01.3 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/02.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/03.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/04.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/05.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/06.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/07.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/08.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/09.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/0a.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/0b.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/00.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/01.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/01.1 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/01.3 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/02.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/03.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/04.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/05.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/06.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/07.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/08.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/09.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/0a.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/0b.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/00.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/01.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/01.1 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/01.3 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/02.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/03.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/04.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/05.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/06.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/07.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/08.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/09.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/0a.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/0b.0 0x0-0x100000 not mappable
ok 1..1 selftests: ia64: aliasing-test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ia64'

2019-02-01 19:35:39 make run_tests -C ima
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ima'
TAP version 13
selftests: ima: test_kexec_load.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2E/test_kexec_load.sh: 15: [: !=3D: unexpected operator
=2E/test_kexec_load.sh: efivars is not mounted on /sys/firmware/efi/efivars
not ok 1..1 selftests: ima: test_kexec_load.sh [SKIP]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ima'

2019-02-01 19:35:40 make run_tests -C intel_pstate
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/intel_pstate'
gcc  -Wall -D_GNU_SOURCE    msr.c  -lm -o /usr/src/perf_selftests-x86_64-rh=
el-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/int=
el_pstate/msr
gcc  -Wall -D_GNU_SOURCE    aperf.c  -lm -o /usr/src/perf_selftests-x86_64-=
rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/i=
ntel_pstate/aperf
TAP version 13
selftests: intel_pstate: run.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
cpupower: error while loading shared libraries: libcpupower.so.0: cannot op=
en shared object file: No such file or directory
=2E/run.sh: line 90: / 1000: syntax error: operand expected (error token is=
 "/ 1000")
cpupower: error while loading shared libraries: libcpupower.so.0: cannot op=
en shared object file: No such file or directory
=2E/run.sh: line 92: / 1000: syntax error: operand expected (error token is=
 "/ 1000")
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The marketing frequency of the cpu is 0 MHz
The maximum frequency of the cpu is  MHz
The minimum frequency of the cpu is  MHz
Target	      Actual	    Difference	  MSR(0x199)	max_perf_pct
ok 1..1 selftests: intel_pstate: run.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/intel_pstate'

2019-02-01 19:35:41 make run_tests -C ipc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ipc'
gcc -DCONFIG_X86_64 -D__x86_64__ -I../../../../usr/include/    msgque.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae4=
3a9919/tools/testing/selftests/ipc/msgque
msgque.c: In function =E2=80=98restore_queue=E2=80=99:
msgque.c:52:7: warning: implicit declaration of function =E2=80=98msgget=E2=
=80=99 [-Wimplicit-function-declaration]
  id =3D msgget(msgque->key, msgque->mode | IPC_CREAT | IPC_EXCL);
       ^~~~~~
msgque.c:66:7: warning: implicit declaration of function =E2=80=98msgsnd=E2=
=80=99 [-Wimplicit-function-declaration]
   if (msgsnd(msgque->msq_id, &msgque->messages[i].mtype,
       ^~~~~~
msgque.c:76:6: warning: implicit declaration of function =E2=80=98msgctl=E2=
=80=99 [-Wimplicit-function-declaration]
  if (msgctl(id, IPC_RMID, 0))
      ^~~~~~
msgque.c: In function =E2=80=98check_and_destroy_queue=E2=80=99:
msgque.c:87:9: warning: implicit declaration of function =E2=80=98msgrcv=E2=
=80=99 [-Wimplicit-function-declaration]
   ret =3D msgrcv(msgque->msq_id, &message.mtype, MAX_MSG_SIZE,
         ^~~~~~
msgque.c: In function =E2=80=98main=E2=80=99:
msgque.c:203:15: warning: implicit declaration of function =E2=80=98ftok=E2=
=80=99 [-Wimplicit-function-declaration]
  msgque.key =3D ftok(argv[0], 822155650);
               ^~~~
TAP version 13
selftests: ipc: msgque
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..1 selftests: ipc: msgque [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ipc'

2019-02-01 19:35:41 make run_tests -C ir
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ir'
gcc     ir_loopback.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ir/ir_loopback
TAP version 13
selftests: ir: ir_loopback.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Bail out! cannot find lirc device for rc0
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
not ok 1..1 selftests: ir: ir_loopback.sh [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ir'

2019-02-01 19:35:41 make run_tests -C kcmp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kcmp'
gcc -I../../../../usr/include/    kcmp_test.c  -o /usr/src/perf_selftests-x=
86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selft=
ests/kcmp/kcmp_test
TAP version 13
selftests: kcmp: kcmp_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
pid1:  14472 pid2:  14473 FD:  2 FILES:  2 VM:  1 FS:  1 SIGHAND:  1 IO:  0=
 SYSVSEM:  0 INV: -1
PASS: 0 returned as expected
PASS: 0 returned as expected
PASS: 0 returned as expected
Pass 3 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..3
Pass 3 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..3
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..1 selftests: kcmp: kcmp_test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kcmp'
kmod test: not in Makefile
2019-02-01 19:35:42 make TARGETS=3Dkmod
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kmod'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kmod'

2019-02-01 19:35:42 make run_tests -C kmod
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kmod'
TAP version 13
selftests: kmod: kmod.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Fri Feb  1 19:35:42 CST 2019
Running test: kmod_test_0001 - run #0
kmod_test_0001_driver: OK! - loading kmod test
kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0001_fs: OK! - loading kmod test
kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Fri Feb  1 19:35:42 CST 2019
Running test: kmod_test_0001 - run #1
kmod_test_0001_driver: OK! - loading kmod test
kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0001_fs: OK! - loading kmod test
kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Fri Feb  1 19:35:42 CST 2019
Running test: kmod_test_0001 - run #2
kmod_test_0001_driver: OK! - loading kmod test
kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0001_fs: OK! - loading kmod test
kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Fri Feb  1 19:35:42 CST 2019
Running test: kmod_test_0002 - run #0
kmod_test_0002_driver: OK! - loading kmod test
kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0002_fs: OK! - loading kmod test
kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Fri Feb  1 19:35:43 CST 2019
Running test: kmod_test_0002 - run #1
kmod_test_0002_driver: OK! - loading kmod test
kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0002_fs: OK! - loading kmod test
kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Fri Feb  1 19:35:44 CST 2019
Running test: kmod_test_0002 - run #2
kmod_test_0002_driver: OK! - loading kmod test
kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0002_fs: OK! - loading kmod test
kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Fri Feb  1 19:35:44 CST 2019
Running test: kmod_test_0003 - run #0
kmod_test_0003: OK! - loading kmod test
kmod_test_0003: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:44 CST 2019
Running test: kmod_test_0004 - run #0
kmod_test_0004: OK! - loading kmod test
kmod_test_0004: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:45 CST 2019
Running test: kmod_test_0005 - run #0
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:45 CST 2019
Running test: kmod_test_0005 - run #1
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:46 CST 2019
Running test: kmod_test_0005 - run #2
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:46 CST 2019
Running test: kmod_test_0005 - run #3
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:47 CST 2019
Running test: kmod_test_0005 - run #4
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:47 CST 2019
Running test: kmod_test_0005 - run #5
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:48 CST 2019
Running test: kmod_test_0005 - run #6
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:48 CST 2019
Running test: kmod_test_0005 - run #7
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:48 CST 2019
Running test: kmod_test_0005 - run #8
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:49 CST 2019
Running test: kmod_test_0005 - run #9
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:50 CST 2019
Running test: kmod_test_0006 - run #0
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:50 CST 2019
Running test: kmod_test_0006 - run #1
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:51 CST 2019
Running test: kmod_test_0006 - run #2
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:52 CST 2019
Running test: kmod_test_0006 - run #3
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:53 CST 2019
Running test: kmod_test_0006 - run #4
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:54 CST 2019
Running test: kmod_test_0006 - run #5
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:54 CST 2019
Running test: kmod_test_0006 - run #6
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:55 CST 2019
Running test: kmod_test_0006 - run #7
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:56 CST 2019
Running test: kmod_test_0006 - run #8
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:57 CST 2019
Running test: kmod_test_0006 - run #9
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:58 CST 2019
Running test: kmod_test_0007 - run #0
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:59 CST 2019
Running test: kmod_test_0007 - run #1
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:36:00 CST 2019
Running test: kmod_test_0007 - run #2
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:36:02 CST 2019
Running test: kmod_test_0007 - run #3
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:36:02 CST 2019
Running test: kmod_test_0007 - run #4
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
=2E/kmod.sh: line 529: [[: 1 0002:3:1 0003:1:1 0004:1:1 0005:10:1 0006:10:1=
 0007:5:1 0008:150:1 0009:150:1: syntax error in expression (error token is=
 "0002:3:1 0003:1:1 0004:1:1 0005:10:1 0006:10:1 0007:5:1 0008:150:1 0009:1=
50:1")
=2E/kmod.sh: line 529: [[: 1 0002:3:1 0003:1:1 0004:1:1 0005:10:1 0006:10:1=
 0007:5:1 0008:150:1 0009:150:1: syntax error in expression (error token is=
 "0002:3:1 0003:1:1 0004:1:1 0005:10:1 0006:10:1 0007:5:1 0008:150:1 0009:1=
50:1")
Test completed
ok 1..1 selftests: kmod: kmod.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kmod'

2019-02-01 19:36:04 make run_tests -C kvm
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kvm'
make ARCH=3Dx86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919'
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919'
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/assert.c -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/=
testing/selftests/kvm/lib/assert.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/elf.c -o /usr/src/perf_s=
elftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/tes=
ting/selftests/kvm/lib/elf.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/io.c -o /usr/src/perf_se=
lftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/test=
ing/selftests/kvm/lib/io.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/kvm_util.c -o /usr/src/p=
erf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tool=
s/testing/selftests/kvm/lib/kvm_util.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/ucall.c -o /usr/src/perf=
_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/t=
esting/selftests/kvm/lib/ucall.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/sparsebit.c -o /usr/src/=
perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/too=
ls/testing/selftests/kvm/lib/sparsebit.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib/x86_64 -Iinclude/x86_64 -I..   -c lib/x86_64/processor.=
c -o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0=
dae43a9919/tools/testing/selftests/kvm/lib/x86_64/processor.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib/x86_64 -Iinclude/x86_64 -I..   -c lib/x86_64/vmx.c -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a=
9919/tools/testing/selftests/kvm/lib/x86_64/vmx.o
ar crs /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3=
c0dae43a9919/tools/testing/selftests/kvm/libkvm.a /usr/src/perf_selftests-x=
86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selft=
ests/kvm/lib/assert.o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303=
a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kvm/lib/elf.o /usr/src/=
perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/too=
ls/testing/selftests/kvm/lib/io.o /usr/src/perf_selftests-x86_64-rhel-7.2-3=
2bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kvm/lib/kvm=
_util.o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b=
3c0dae43a9919/tools/testing/selftests/kvm/lib/ucall.o /usr/src/perf_selftes=
ts-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/s=
elftests/kvm/lib/sparsebit.o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kvm/lib/x86_64/p=
rocessor.o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/testing/selftests/kvm/lib/x86_64/vmx.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/platform_inf=
o_test.c /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86=
b3c0dae43a9919/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selft=
ests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing=
/selftests/kvm/x86_64/platform_info_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/set_sregs_te=
st.c /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0=
dae43a9919/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/sel=
ftests/kvm/x86_64/set_sregs_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/sync_regs_te=
st.c /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0=
dae43a9919/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/sel=
ftests/kvm/x86_64/sync_regs_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/vmx_tsc_adju=
st_test.c /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d8=
6b3c0dae43a9919/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_self=
tests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testin=
g/selftests/kvm/x86_64/vmx_tsc_adjust_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/cr4_cpuid_sy=
nc_test.c /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d8=
6b3c0dae43a9919/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_self=
tests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testin=
g/selftests/kvm/x86_64/cr4_cpuid_sync_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/state_test.c=
 /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae4=
3a9919/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests-x86=
_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftes=
ts/kvm/x86_64/state_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/evmcs_test.c=
 /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae4=
3a9919/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests-x86=
_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftes=
ts/kvm/x86_64/evmcs_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/hyperv_cpuid=
=2Ec /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0=
dae43a9919/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/sel=
ftests/kvm/x86_64/hyperv_cpuid
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -I. -Iinclude/x86_64 -I..  -pthread  dirty_log_test.c /usr/sr=
c/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/t=
ools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests-x86_64-rhel=
-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kvm/d=
irty_log_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -I. -Iinclude/x86_64 -I..  -pthread  clear_dirty_log_test.c /=
usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a=
9919/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests-x86_6=
4-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests=
/kvm/clear_dirty_log_test
TAP version 13
selftests: kvm: platform_info_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..1 selftests: kvm: platform_info_test [SKIP]
selftests: kvm: set_sregs_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..2 selftests: kvm: set_sregs_test [SKIP]
selftests: kvm: sync_regs_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..3 selftests: kvm: sync_regs_test [SKIP]
selftests: kvm: vmx_tsc_adjust_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..4 selftests: kvm: vmx_tsc_adjust_test [SKIP]
selftests: kvm: cr4_cpuid_sync_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..5 selftests: kvm: cr4_cpuid_sync_test [SKIP]
selftests: kvm: state_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..6 selftests: kvm: state_test [SKIP]
selftests: kvm: evmcs_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..7 selftests: kvm: evmcs_test [SKIP]
selftests: kvm: hyperv_cpuid
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..8 selftests: kvm: hyperv_cpuid [SKIP]
selftests: kvm: dirty_log_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Test iterations: 32, interval: 10 (ms)
Testing guest mode: PA-bits:52, VA-bits:48, 4K pages
guest physical test memory offset: 0x7fbffff000
not ok 1..9 selftests: kvm: dirty_log_test [SKIP]
selftests: kvm: clear_dirty_log_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..10 selftests: kvm: clear_dirty_log_test [SKIP]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kvm'

2019-02-01 19:36:14 make run_tests -C lib
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/lib'
TAP version 13
selftests: lib: printf.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
printf: ok
ok 1..1 selftests: lib: printf.sh [PASS]
selftests: lib: bitmap.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
bitmap: ok
ok 1..2 selftests: lib: bitmap.sh [PASS]
selftests: lib: prime_numbers.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
prime_numbers: [FAIL]
not ok 1..3 selftests: lib: prime_numbers.sh [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/lib'
locking test: not in Makefile
2019-02-01 19:36:14 make TARGETS=3Dlocking
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/locking'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/locking'

2019-02-01 19:36:14 make run_tests -C locking
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/locking'
TAP version 13
selftests: locking: ww_mutex.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
locking/ww_mutex: ok
ok 1..1 selftests: locking: ww_mutex.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/locking'



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script # job-script is attached in th=
is email



Thanks,
Rong Chen

--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.0.0-rc2-00142-g32bd075"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.0.0-rc2 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70300
CONFIG_CLANG_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_RCU_NOCB_CPU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
# CONFIG_X86_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
# CONFIG_QUEUED_LOCK_STAT is not set
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
CONFIG_XEN_DOM0=y
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_MPX=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
# CONFIG_EFI_MIXED is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
# CONFIG_LIVEPATCH is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_TEST_SUSPEND=y
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
# CONFIG_VHOST_VSOCK is not set
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_HAVE_RCU_TABLE_INVALIDATE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM=y
CONFIG_DEV_PAGEMAP_OPS=y
# CONFIG_HMM_MIRROR is not set
# CONFIG_DEVICE_PRIVATE is not set
# CONFIG_DEVICE_PUBLIC is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_XFRM_MODE_TRANSPORT=m
CONFIG_INET_XFRM_MODE_TUNNEL=m
CONFIG_INET_XFRM_MODE_BEET=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
# CONFIG_TCP_CONG_DCTCP is not set
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=m
CONFIG_INET6_XFRM_MODE_BEET=m
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
# CONFIG_IPV6_GRE is not set
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=m
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_NEEDED=y
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
# CONFIG_NF_TABLES_SET is not set
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
# CONFIG_NFT_MASQ is not set
# CONFIG_NFT_REDIR is not set
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
# CONFIG_NFT_QUEUE is not set
# CONFIG_NFT_QUOTA is not set
# CONFIG_NFT_REJECT is not set
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
# CONFIG_NETFILTER_XT_MATCH_SOCKET is not set
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
# CONFIG_IP_SET_HASH_IPMARK is not set
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
# CONFIG_IP_SET_HASH_IPMAC is not set
# CONFIG_IP_SET_HASH_MAC is not set
# CONFIG_IP_SET_HASH_NETPORTNET is not set
CONFIG_IP_SET_HASH_NET=m
# CONFIG_IP_SET_HASH_NETNET is not set
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
# CONFIG_NF_SOCKET_IPV4 is not set
CONFIG_NF_TPROXY_IPV4=m
# CONFIG_NF_TABLES_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_IPV4=m
CONFIG_NF_NAT_MASQUERADE_IPV4=y
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV6 is not set
CONFIG_NF_TPROXY_IPV6=m
# CONFIG_NF_TABLES_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_NF_NAT_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
# CONFIG_IP6_NF_NAT is not set
CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
# CONFIG_NET_SCH_FQ is not set
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
# CONFIG_NET_CLS_FLOWER is not set
# CONFIG_NET_CLS_MATCHALL is not set
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
# CONFIG_NET_ACT_SAMPLE is not set
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_VLAN is not set
# CONFIG_NET_ACT_BPF is not set
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_SKBMOD is not set
# CONFIG_NET_ACT_IFE is not set
# CONFIG_NET_ACT_TUNNEL_KEY is not set
CONFIG_NET_CLS_IND=y
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
# CONFIG_VIRTIO_VSOCKETS is not set
# CONFIG_HYPERV_VSOCKETS is not set
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
CONFIG_FAILOVER=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCI_HYPERV is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# CONFIG_VMD is not set

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#
# CONFIG_MTD_REDBOOT_PARTS is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
# CONFIG_XEN_BLKDEV_BACKEND is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_RSXX=m

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_SGI_IOC4=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=m
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
# CONFIG_TCM_QLA2XXX is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
CONFIG_SCSI_CHELSIO_FCOE=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
CONFIG_SCSI_OSD_INITIATOR=m
CONFIG_SCSI_OSD_ULD=m
CONFIG_SCSI_OSD_DPRINT_SENSE=1
# CONFIG_SCSI_OSD_DEBUG is not set
CONFIG_ATA=m
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_ERA is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
# CONFIG_ISCSI_TARGET_CXGB4 is not set
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=m
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=y
CONFIG_NLMON=m
CONFIG_NET_VRF=y
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
CONFIG_IXGB=m
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=m
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=m
CONFIG_SKGE_DEBUG=y
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
CONFIG_SKY2_DEBUG=y
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_QLGE=m
CONFIG_NETXEN_NIC=m
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
# CONFIG_SFC_FALCON is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_ASIX_PHY is not set
CONFIG_AT803X_PHY=m
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=m
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_DSCC4 is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
# CONFIG_XEN_NETDEV_BACKEND is not set
CONFIG_VMXNET3=m
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=y
CONFIG_ISDN=y
CONFIG_ISDN_I4L=m
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_IPPP_FILTER=y
# CONFIG_ISDN_PPP_BSDCOMP is not set
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y

#
# ISDN feature submodules
#
CONFIG_ISDN_DIVERSION=m

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
# CONFIG_ISDN_DRV_HISAX is not set
CONFIG_ISDN_CAPI=m
# CONFIG_CAPI_TRACE is not set
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPIDRV=m
# CONFIG_ISDN_CAPI_CAPIDRV_VERBOSE is not set

#
# CAPI hardware drivers
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
CONFIG_ISDN_DRV_GIGASET=m
CONFIG_GIGASET_CAPI=y
CONFIG_GIGASET_BASE=m
CONFIG_GIGASET_M105=m
CONFIG_GIGASET_M101=m
# CONFIG_GIGASET_DEBUG is not set
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_ISDN_HDLC=m
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
# CONFIG_INPUT_GP2A is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_OLPC_APSP is not set
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# CONFIG_RANDOM_TRUST_CPU is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=m
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=m
# CONFIG_SPI_DW_PCI is not set
# CONFIG_SPI_DW_MMIO is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_KVM=y
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LYNXPOINT=m
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LTC3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_INTEL_MEI_WDT is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS68470 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
# CONFIG_LIRC is not set
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_XMP_DECODER=m
# CONFIG_IR_IMON_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2=m
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m

#
# Camera sensor devices
#

#
# Flash devices
#

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_M52790=m

#
# Sensors used on soc_camera driver
#

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
CONFIG_MEDIA_TUNER=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_GP8PSK_FE=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_QXL=m
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
CONFIG_LOGO=y
# CONFIG_FB_LOGO_CENTER is not set
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
# CONFIG_SND_HDA_RECONFIG is not set
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_PREALLOC_SIZE=512
CONFIG_SND_SPI=y
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y
# CONFIG_HDMI_LPE_AUDIO is not set
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y

#
# I2C HID support
#
CONFIG_I2C_HID=m

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_MON=y
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
CONFIG_USB_DWC3_HAPS=y
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FOTG210_UDC is not set
# CONFIG_USB_GR_UDC is not set
# CONFIG_USB_R8A66597 is not set
# CONFIG_USB_PXA27X is not set
# CONFIG_USB_MV_UDC is not set
# CONFIG_USB_MV_U3D is not set
# CONFIG_USB_M66592 is not set
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_DUMMY_HCD is not set
CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_MASS_STORAGE=m
# CONFIG_USB_CONFIGFS is not set
# CONFIG_USB_ZERO is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FUNCTIONFS is not set
CONFIG_USB_MASS_STORAGE=m
# CONFIG_USB_GADGET_TARGET is not set
# CONFIG_USB_G_SERIAL is not set
# CONFIG_USB_MIDI_GADGET is not set
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
# CONFIG_USB_G_HID is not set
# CONFIG_USB_G_DBGP is not set
# CONFIG_USB_G_WEBCAM is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
# CONFIG_EDAC_GHES is not set
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
# CONFIG_EDAC_IE31200 is not set
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_PND2 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV8803 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_UIO_HV_GENERIC is not set
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI_IGD=y
# CONFIG_VFIO_MDEV is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TSCPAGE=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_SELFBALLOONING is not set
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
CONFIG_XEN_BACKEND=y
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_TMEM=m
CONFIG_XEN_PCIDEV_BACKEND=m
# CONFIG_XEN_PVCALLS_FRONTEND is not set
# CONFIG_XEN_PVCALLS_BACKEND is not set
# CONFIG_XEN_SCSI_BACKEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_ACPI_PROCESSOR=m
# CONFIG_XEN_MCE_LOG is not set
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_SYMS=y
CONFIG_XEN_HAVE_VPMU=y
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_R8822BE is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_PI433 is not set
# CONFIG_MTK_MMC is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# CONFIG_XIL_AXIS_FIFO is not set
# CONFIG_EROFS_FS is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
CONFIG_DCDBAS=m
# CONFIG_DELL_SMBIOS is not set
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
CONFIG_DELL_RBU=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_HP_WIRELESS is not set
CONFIG_HP_WMI=m
# CONFIG_LG_LAPTOP is not set
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_SAMSUNG_Q10=m
CONFIG_APPLE_GMUX=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_HUAWEI_WMI is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_IOVA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# NXP/Freescale QorIQ SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_NVMEM=y

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FS_ENCRYPTION=y
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EXOFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
# CONFIG_NFSD_SCSILAYOUT is not set
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SUNRPC_DEBUG=y
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_ACL=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=1
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_DEFAULT_SECURITY="selinux"
CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS256_AESNI_SSE2 is not set
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS640_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
# CONFIG_CRYPTO_MORUS1280_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280_AVX2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=m
CONFIG_CRYPTO_SHA256_SSSE3=m
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
# CONFIG_CRYPTO_DEV_CHELSIO is not set
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_SBITMAP=y
CONFIG_PRIME_NUMBERS=m
# CONFIG_STRING_SELFTEST is not set

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_TRACING_EVENTS_GPIO=y
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=m
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=m
CONFIG_INTERVAL_TREE_TEST=m
CONFIG_PERCPU_TEST=m
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_ASYNC_RAID6_TEST=m
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_KSTRTOX=m
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
CONFIG_TEST_UDELAY=m
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_EFI is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set

--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel_selftests'
	export testcase='kernel_selftests'
	export category='functional'
	export need_memory='2G'
	export need_cpu=2
	export kernel_cmdline='erst_disable'
	export job_origin='/lkp/lkp/.src-20190201-101644/allot/cyclic:vm:linux-devel:devel-hourly/vm-snb-4G/kernel_selftests.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='validate'
	export testbox='vm-snb-4G-427'
	export tbox_group='vm-snb-4G'
	export submit_id='5c549eb80b9a934d82d651a2'
	export job_file='/lkp/jobs/scheduled/vm-snb-4G-427/kernel_selftests-kselftests-01-debian-x86_64-2018-04-03.cgz-32bd07585d303a945d476d3d86b3c0dae43a9919-20190202-19842-ybj5cp-3.yaml'
	export id='f475a5b5500e9e542a32a14fd7b518a997362a40'
	export queuer_version='/lkp/lkp/.src-20190201-101644'
	export need_kernel_headers=true
	export need_kernel_selftests=true
	export need_kconfig='CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_TEST_FIRMWARE
CONFIG_TEST_USER_COPY
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_NOTIFIER_ERROR_INJECTION
CONFIG_FTRACE=y
CONFIG_TEST_BITMAP
CONFIG_TEST_PRINTF
CONFIG_TEST_STATIC_KEYS
CONFIG_BPF_SYSCALL=y
CONFIG_NET_CLS_BPF=m
CONFIG_BPF_EVENTS=y
CONFIG_TEST_BPF=m
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HIST_TRIGGERS=y
CONFIG_EMBEDDED=y
CONFIG_GPIO_MOCKUP=y
CONFIG_USERFAULTFD=y
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_PSTORE=y
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_RAM=m
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_EXPERT=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_EFIVAR_FS
CONFIG_TEST_KMOD=m
CONFIG_TEST_LKM=m
CONFIG_XFS_FS=m
CONFIG_TUN=m
CONFIG_BTRFS_FS=m
CONFIG_TEST_SYSCTL=m
CONFIG_BPF_STREAM_PARSER=y
CONFIG_CGROUP_BPF=y
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_NET_VRF=y
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_MACSEC=y
CONFIG_X86_INTEL_MPX=y
CONFIG_RC_LOOPBACK
CONFIG_IPV6_SEG6_LWTUNNEL=y
CONFIG_LWTUNNEL=y
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_KVM_GUEST=y'
	export commit='32bd07585d303a945d476d3d86b3c0dae43a9919'
	export ssh_base_port=23032
	export kconfig='x86_64-rhel-7.2'
	export compiler='gcc-7'
	export rootfs='debian-x86_64-2018-04-03.cgz'
	export enqueue_time='2019-02-02 03:32:09 +0800'
	export _id='5c549eb90b9a934d82d651a3'
	export _rt='/result/kernel_selftests/kselftests-01/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/32bd07585d303a945d476d3d86b3c0dae43a9919'
	export user='lkp'
	export head_commit='ee43103da9ca222c037e3a74e0448106e826b925'
	export base_commit='f17b5f06cb92ef2250513a1e154c47b78df07d40'
	export branch='linux-devel/devel-hourly-2019020103'
	export result_root='/result/kernel_selftests/kselftests-01/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/32bd07585d303a945d476d3d86b3c0dae43a9919/3'
	export scheduler_version='/lkp/lkp/.src-20190201-101644'
	export LKP_SERVER='inn'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-x86_64-2018-04-03.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-snb-4G-427/kernel_selftests-kselftests-01-debian-x86_64-2018-04-03.cgz-32bd07585d303a945d476d3d86b3c0dae43a9919-20190202-19842-ybj5cp-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.2
branch=linux-devel/devel-hourly-2019020103
commit=32bd07585d303a945d476d3d86b3c0dae43a9919
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.2/gcc-7/32bd07585d303a945d476d3d86b3c0dae43a9919/vmlinuz-5.0.0-rc2-00142-g32bd075
erst_disable
max_uptime=3600
RESULT_ROOT=/result/kernel_selftests/kselftests-01/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/32bd07585d303a945d476d3d86b3c0dae43a9919/3
LKP_SERVER=inn
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-7.2/gcc-7/32bd07585d303a945d476d3d86b3c0dae43a9919/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/kernel_selftests_2018-12-12.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/kernel_selftests-x86_64-f5d582777bcb_2018-12-12.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-7.2/gcc-7/32bd07585d303a945d476d3d86b3c0dae43a9919/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-7.2/gcc-7/32bd07585d303a945d476d3d86b3c0dae43a9919/linux-selftests.cgz'
	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export repeat_to=4
	export schedule_notify_address=
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='4G'
	export hdd_partitions='/dev/vda /dev/vdb /dev/vdc /dev/vdd /dev/vde /dev/vdf'
	export swap_partitions='/dev/vdg'
	export vm_tbox_group='vm-snb-4G'
	export nr_vm=56
	export vm_base_id=401
	export kernel='/pkg/linux/x86_64-rhel-7.2/gcc-7/32bd07585d303a945d476d3d86b3c0dae43a9919/vmlinuz-5.0.0-rc2-00142-g32bd075'
	export dequeue_time='2019-02-02 03:32:15 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-4G-427/kernel_selftests-kselftests-01-debian-x86_64-2018-04-03.cgz-32bd07585d303a945d476d3d86b3c0dae43a9919-20190202-19842-ybj5cp-3.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='kselftests-01' $LKP_SRC/tests/wrapper kernel_selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper kernel_selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel_selftests.time
	$LKP_SRC/stats/wrapper time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper last_state
}

"$@"

--vGgW1X5XWziG23Ko
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=kernel_selftests
Content-Transfer-Encoding: quoted-printable

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7=
=2E2-32bd07585d303a945d476d3d86b3c0dae43a9919
2019-02-01 19:32:50 ln -sf /usr/bin/clang-7 /usr/bin/clang
2019-02-01 19:32:50 ln -sf /usr/bin/llc-7 /usr/bin/llc

2019-02-01 19:32:50 chown lkp capabilities -R
2019-02-01 19:32:50 su lkp -c make run_tests -C capabilities 2>&1
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/capabilities'
gcc -O2 -g -std=3Dgnu99 -Wall    test_execve.c -lcap-ng -lrt -ldl -o /usr/s=
rc/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/=
tools/testing/selftests/capabilities/test_execve
gcc -O2 -g -std=3Dgnu99 -Wall    validate_cap.c -lcap-ng -lrt -ldl -o /usr/=
src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919=
/tools/testing/selftests/capabilities/validate_cap
TAP version 13
selftests: capabilities: test_execve
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
# validate_cap:: Capabilities after execve were correct
# validate_cap:: Capabilities after execve were correct
# validate_cap:: Capabilities after execve were correct
# [RUN]	+++ Tests with uid =3D=3D 0 +++
# [NOTE]	Using a user namespace for tests
# [RUN]	Root =3D> ep
ok 1 Passed
# Check cap_ambient manipulation rules
ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
ok 4 PR_CAP_AMBIENT_RAISE worked
ok 5 Basic manipulation appears to work
# [RUN]	Root +i =3D> eip
ok 6 Passed
# [RUN]	UID 0 +ia =3D> eipa
ok 7 Passed
ok 8 # skip SUID/SGID tests (needs privilege)
Pass 7 Fail 0 Xfail 0 Xpass 0 Skip 1 Error 0
1..8
# validate_cap:: Capabilities after execve were correct
# validate_cap:: Capabilities after execve were correct
# validate_cap:: Capabilities after execve were correct
# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
# [RUN]	+++ Tests with uid !=3D 0 +++
# [NOTE]	Using a user namespace for tests
# [RUN]	Non-root =3D> no caps
ok 1 Passed
# Check cap_ambient manipulation rules
ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
ok 4 PR_CAP_AMBIENT_RAISE worked
ok 5 Basic manipulation appears to work
# [RUN]	Non-root +i =3D> i
ok 6 Passed
# [RUN]	UID 1 +ia =3D> eipa
ok 7 Passed
ok 8 # skip SUID/SGID tests (needs privilege)
Pass 7 Fail 0 Xfail 0 Xpass 0 Skip 1 Error 0
1..8
# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
ok 1..1 selftests: capabilities: test_execve [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/capabilities'
ignored_by_lkp cgroup test

2019-02-01 19:32:50 make run_tests -C cpu-hotplug
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/cpu-hotplug'
TAP version 13
selftests: cpu-hotplug: cpu-on-off-test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
pid 1199's current affinity mask: 3
pid 1199's new affinity mask: 1
CPU online/offline summary:
	 Cpus in online state: 0-1
	 Cpus in offline state: 0
Limited scope test: one hotplug cpu
	 (leaves cpu in the original state):
	 online to offline to online: cpu 1
ok 1..1 selftests: cpu-hotplug: cpu-on-off-test.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/cpu-hotplug'

2019-02-01 19:32:51 make run_tests -C cpufreq
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/cpufreq'
TAP version 13
selftests: cpufreq: main.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
pid 1260's current affinity mask: 3
pid 1260's new affinity mask: 1
not ok 1..1 selftests: cpufreq: main.sh [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/cpufreq'
ignored_by_lkp efivarfs test: /sys/firmware/efi dir does not exist

2019-02-01 19:32:51 make run_tests -C exec
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/exec'
gcc -Wall    execveat.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/exec/execveat
cd /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0da=
e43a9919/tools/testing/selftests/exec && ln -s -f execveat execveat.symlink
cp /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0da=
e43a9919/tools/testing/selftests/exec/execveat /usr/src/perf_selftests-x86_=
64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftest=
s/exec/execveat.denatured
chmod -x /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86=
b3c0dae43a9919/tools/testing/selftests/exec/execveat.denatured
echo '#!/bin/sh' > /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a94=
5d476d3d86b3c0dae43a9919/tools/testing/selftests/exec/script
echo 'exit $*' >> /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945=
d476d3d86b3c0dae43a9919/tools/testing/selftests/exec/script
chmod +x /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86=
b3c0dae43a9919/tools/testing/selftests/exec/script
mkdir -p /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86=
b3c0dae43a9919/tools/testing/selftests/exec/subdir
TAP version 13
selftests: exec: execveat
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
/bin/sh: 0: Can't open /dev/fd/7/usr/src/perf_selftests-x86_64-rhel-7.2-32b=
d07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/exec/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
Check success of execveat(4, '../execveat', 0)... [OK]
Check success of execveat(6, 'execveat', 0)... [OK]
Check success of execveat(8, 'execveat', 0)... [OK]
Check success of execveat(-100, '/usr/src/perf_selfte...ftests/exec/execvea=
t', 0)... [OK]
Check success of execveat(99, '/usr/src/perf_selfte...ftests/exec/execveat'=
, 0)... [OK]
Check success of execveat(10, '', 4096)... [OK]
Check success of execveat(19, '', 4096)... [OK]
Check success of execveat(11, '', 4096)... [OK]
Check success of execveat(16, '', 4096)... [OK]
Check success of execveat(16, '', 4096)... [OK]
Check success of execveat(17, '', 4096)... [OK]
Check failure of execveat(10, '', 0) with ENOENT... [OK]
Check failure of execveat(10, '(null)', 4096) with EFAULT... [OK]
Check success of execveat(6, 'execveat.symlink', 0)... [OK]
Check success of execveat(8, 'execveat.symlink', 0)... [OK]
Check success of execveat(-100, '/usr/src/perf_selfte...xec/execveat.symlin=
k', 0)... [OK]
Check success of execveat(12, '', 4096)... [OK]
Check success of execveat(12, '', 4352)... [OK]
Check failure of execveat(6, 'execveat.symlink', 256) with ELOOP... [OK]
Check failure of execveat(8, 'execveat.symlink', 256) with ELOOP... [OK]
Check failure of execveat(-100, '/usr/src/perf_selftests-x86_64-rhel-7.2-32=
bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/exec/execvea=
t.symlink', 256) with ELOOP... [OK]
Check success of execveat(4, '../script', 0)... [OK]
Check success of execveat(6, 'script', 0)... [OK]
Check success of execveat(8, 'script', 0)... [OK]
Check success of execveat(-100, '/usr/src/perf_selfte...elftests/exec/scrip=
t', 0)... [OK]
Check success of execveat(15, '', 4096)... [OK]
Check success of execveat(15, '', 4352)... [OK]
Check failure of execveat(20, '', 4096) with ENOENT... [OK]
Check failure of execveat(9, 'script', 0) with ENOENT... [OK]
Check success of execveat(18, '', 4096)... [OK]
Check success of execveat(18, '', 4096)... [OK]
Check success of execveat(5, '../script', 0)... [OK]
Check success of execveat(5, 'script', 0)... [OK]
Check success of execveat(5, '../script', 0)... [OK]
Check failure of execveat(5, 'script', 0) with ENOENT... [OK]
Check failure of execveat(6, 'execveat', 65535) with EINVAL... [OK]
Check failure of execveat(6, 'no-such-file', 0) with ENOENT... [OK]
Check failure of execveat(8, 'no-such-file', 0) with ENOENT... [OK]
Check failure of execveat(-100, 'no-such-file', 0) with ENOENT... [OK]
Check failure of execveat(6, '', 4096) with EACCES... [OK]
Check failure of execveat(6, 'Makefile', 0) with EACCES... [OK]
Check failure of execveat(13, '', 4096) with EACCES... [OK]
Check failure of execveat(14, '', 4096) with EACCES... [OK]
Check failure of execveat(99, '', 4096) with EBADF... [OK]
Check failure of execveat(99, 'execveat', 0) with EBADF... [OK]
Check failure of execveat(10, 'execveat', 0) with ENOTDIR... [OK]
Invoke copy of 'execveat' via filename of length 4094:
Check success of execveat(21, '', 4096)... [OK]
Check success of execveat(7, 'usr/src/perf_selftes...yyyyyyyyyyyyyyyyyyyy',=
 0)... [OK]
Invoke copy of 'script' via filename of length 4094:
Check success of execveat(22, '', 4096)... [OK]
Check success of execveat(7, 'usr/src/perf_selftes...yyyyyyyyyyyyyyyyyyyy',=
 0)... [OK]
ok 1..1 selftests: exec: execveat [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/exec'
ignored_by_lkp filesystems test
2019-02-01 19:32:51 mv /lib/udev/rules.d/50-firmware.rules .
2019-02-01 19:32:51 /etc/init.d/udev restart
Restarting udev (via systemctl): udev.service.

2019-02-01 19:32:51 make run_tests -C firmware
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/firmware'
TAP version 13
selftests: firmware: fw_run_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-----------------------------------------------------
Running kernel configuration test 1 -- rare
Emulates:
CONFIG_FW_LOADER=3Dy
CONFIG_FW_LOADER_USER_HELPER=3Dn
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=3Dn
=2E/fw_filesystem.sh: filesystem loading works
=2E/fw_filesystem.sh: async filesystem loading works

Testing with the file present...
Batched request_firmware() try #1: Files /tmp/tmp.QCJhVEPkiu/test-firmware.=
bin and /sys/devices/virtual/misc/test_firmware/read_firmware differ
request #0: firmware was not loaded
not ok 1..1 selftests: firmware: fw_run_tests.sh [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/firmware'
2019-02-01 19:32:51 mv 50-firmware.rules /lib/udev/rules.d/50-firmware.rules

2019-02-01 19:32:51 make run_tests -C ftrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ftrace'
TAP version 13
selftests: ftrace: ftracetest
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2E/ftracetest: 163: [: Illegal number:=20
-e =3D=3D=3D Ftrace unit tests =3D=3D=3D
-e -n [1] Basic trace file check
-e 	[PASS]
-e -n [2] Basic test for tracers
-e 	[PASS]
-e -n [3] Basic trace clock test
-e 	[PASS]
-e -n [4] Basic event tracing check
-e 	[PASS]
-e -n [5] Change the ringbuffer size
-e 	[PASS]
-e -n [6] Snapshot and tracing setting
-e 	[PASS]
-e -n [7] trace_pipe and trace_marker
-e 	[PASS]
-e -n [8] Generic dynamic event - add/remove kprobe events
-e 	[PASS]
-e -n [9] Generic dynamic event - add/remove synthetic events
-e 	[PASS]
-e -n [10] Generic dynamic event - selective clear (compatibility)
-e 	[PASS]
-e -n [11] Generic dynamic event - generic clear event
-e 	[PASS]
-e -n [12] event tracing - enable/disable with event level files
-e 	[PASS]
-e -n [13] event tracing - restricts events based on pid
-e 	[PASS]
-e -n [14] event tracing - enable/disable with subsystem level files
-e 	[PASS]
-e -n [15] event tracing - enable/disable with top level files
-e 	[PASS]
-e -n [16] Test trace_printk from module
-e 	[UNRESOLVED]
-e -n [17] ftrace - function graph filters with stack tracer
-e 	[PASS]
-e -n [18] ftrace - function graph filters
-e 	[PASS]
-e -n [19] ftrace - function glob filters
-e 	[PASS]
-e -n [20] ftrace - function pid filters
-e 	[PASS]
-e -n [21] ftrace - stacktrace filter command
-e 	[PASS]
-e -n [22] ftrace - function trace with cpumask
-e 	[PASS]
-e -n [23] ftrace - test for function event triggers
-e 	[PASS]
-e -n [24] ftrace - function trace on module
-e 	[UNRESOLVED]
-e -n [25] ftrace - function profiling
-e 	[PASS]
-e -n [26] ftrace - function profiler with function tracing
-e 	[PASS]
-e -n [27] ftrace - test reading of set_ftrace_filter
-e 	[PASS]
-e -n [28] ftrace - Max stack tracer
-e 	[PASS]
-e -n [29] ftrace - test for function traceon/off triggers
-e 	[PASS]
-e -n [30] Test creation and deletion of trace instances while setting an e=
vent
-e 	[PASS]
-e -n [31] Test creation and deletion of trace instances
-e 	[PASS]
-e -n [32] Kprobe dynamic event - adding and removing
-e 	[PASS]
-e -n [33] Kprobe dynamic event - busy event check
-e 	[PASS]
-e -n [34] Kprobe dynamic event with arguments
-e 	[PASS]
-e -n [35] Kprobe event with comm arguments
-e 	[PASS]
-e -n [36] Kprobe event string type argument
-e 	[PASS]
-e -n [37] Kprobe event symbol argument
-e 	[PASS]
-e -n [38] Kprobe event argument syntax
-e 	[PASS]
-e -n [39] Kprobes event arguments with types
-e 	[PASS]
-e -n [40] Kprobe event auto/manual naming
-e 	[PASS]
-e -n [41] Kprobe dynamic event with function tracer
-e 	[PASS]
-e -n [42] Kprobe dynamic event - probing module
-e 	[UNRESOLVED]
-e -n [43] Kretprobe dynamic event with arguments
-e 	[PASS]
-e -n [44] Kretprobe dynamic event with maxactive
-e 	[PASS]
-e -n [45] Register/unregister many kprobe events
-e 	[PASS]
-e -n [46] Kprobe events - probe points
-e 	[PASS]
-e -n [47] Kprobe dynamic event - adding and removing
-e 	[PASS]
-e -n [48] test for the preemptirqsoff tracer
-e 	[UNSUPPORTED]
-e -n [49] Test wakeup tracer
-e 	[PASS]
-e -n [50] Test wakeup RT tracer
-e 	[PASS]
-e -n [51] event trigger - test extended error support
-e 	[PASS]
-e -n [52] event trigger - test field variable support
-e 	[PASS]
-e -n [53] event trigger - test inter-event combined histogram trigger
-e 	[PASS]
-e -n [54] event trigger - test multiple actions on hist trigger
-e 	[PASS]
-e -n [55] event trigger - test inter-event histogram trigger onmatch action
-e 	[PASS]
-e -n [56] event trigger - test inter-event histogram trigger onmatch-onmax=
 action
-e 	[PASS]
-e -n [57] event trigger - test inter-event histogram trigger onmax action
-e 	[PASS]
-e -n [58] event trigger - test synthetic event create remove
-e 	[PASS]
-e -n [59] event trigger - test synthetic_events syntax parser
-e 	[PASS]
-e -n [60] event trigger - test event enable/disable trigger
-e 	[PASS]
-e -n [61] event trigger - test trigger filter
-e 	[PASS]
-e -n [62] event trigger - test histogram modifiers
-e 	[PASS]
-e -n [63] event trigger - test histogram trigger
-e 	[PASS]
-e -n [64] event trigger - test multiple histogram triggers
-e 	[PASS]
-e -n [65] event trigger - test snapshot-trigger
-e 	[PASS]
-e -n [66] event trigger - test stacktrace-trigger
-e 	[PASS]
-e -n [67] trace_marker trigger - test histogram trigger
-e 	[PASS]
-e -n [68] trace_marker trigger - test snapshot trigger
-e 	[PASS]
-e -n [69] trace_marker trigger - test histogram with synthetic event again=
st kernel event
-e 	[PASS]
-e -n [70] trace_marker trigger - test histogram with synthetic event
-e 	[PASS]
-e -n [71] event trigger - test traceon/off trigger
-e 	[PASS]
-e -n [72] (instance)  Basic test for tracers
-e 	[PASS]
-e -n [73] (instance)  Basic trace clock test
-e 	[PASS]
-e -n [74] (instance)  Change the ringbuffer size
-e 	[PASS]
-e -n [75] (instance)  Snapshot and tracing setting
-e 	[PASS]
-e -n [76] (instance)  trace_pipe and trace_marker
-e 	[PASS]
-e -n [77] (instance)  event tracing - enable/disable with event level files
-e 	[PASS]
-e -n [78] (instance)  event tracing - restricts events based on pid
-e 	[PASS]
-e -n [79] (instance)  event tracing - enable/disable with subsystem level =
files
-e 	[PASS]
-e -n [80] (instance)  ftrace - stacktrace filter command
-e 	[PASS]
-e -n [81] (instance)  ftrace - test for function event triggers
-e 	[PASS]
-e -n [82] (instance)  ftrace - test for function traceon/off triggers
-e 	[PASS]
-e -n [83] (instance)  event trigger - test event enable/disable trigger
-e 	[PASS]
-e -n [84] (instance)  event trigger - test trigger filter
-e 	[PASS]
-e -n [85] (instance)  event trigger - test histogram modifiers
-e 	[PASS]
-e -n [86] (instance)  event trigger - test histogram trigger
-e 	[PASS]
-e -n [87] (instance)  event trigger - test multiple histogram triggers
-e 	[PASS]
-e -n [88] (instance)  trace_marker trigger - test histogram trigger
-e 	[PASS]
-e -n [89] (instance)  trace_marker trigger - test snapshot trigger
-e 	[PASS]


-e=20
-e # of passed:  85
-e # of failed:  0
-e # of unresolved:  3
-e # of untested:  0
-e # of unsupported:  1
-e # of xfailed:  0
-e # of undefined(test bug):  0
not ok 1..1 selftests: ftrace: ftracetest [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ftrace'

2019-02-01 19:34:47 make run_tests -C futex
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/futex'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/futex/functional'
make ARCH=3Dx86 -C ../../../../.. headers_install
make[2]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919'
  HOSTCC  scripts/basic/fixdep
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  UPD     include/generated/uapi/linux/version.h
  HOSTCC  scripts/unifdef
  INSTALL usr/include/asm-generic/ (37 files)
  INSTALL usr/include/drm/ (26 files)
  INSTALL usr/include/linux/ (503 files)
  INSTALL usr/include/linux/android/ (2 files)
  INSTALL usr/include/linux/byteorder/ (2 files)
  INSTALL usr/include/linux/caif/ (2 files)
  INSTALL usr/include/linux/can/ (6 files)
  INSTALL usr/include/linux/cifs/ (1 file)
  INSTALL usr/include/linux/dvb/ (8 files)
  INSTALL usr/include/linux/genwqe/ (1 file)
  INSTALL usr/include/linux/hdlc/ (1 file)
  INSTALL usr/include/linux/hsi/ (2 files)
  INSTALL usr/include/linux/iio/ (2 files)
  INSTALL usr/include/linux/isdn/ (1 file)
  INSTALL usr/include/linux/mmc/ (1 file)
  INSTALL usr/include/linux/netfilter/ (88 files)
  INSTALL usr/include/linux/netfilter/ipset/ (4 files)
  INSTALL usr/include/linux/netfilter_arp/ (2 files)
  INSTALL usr/include/linux/netfilter_bridge/ (17 files)
  INSTALL usr/include/linux/netfilter_ipv4/ (9 files)
  INSTALL usr/include/linux/netfilter_ipv6/ (13 files)
  INSTALL usr/include/linux/nfsd/ (5 files)
  INSTALL usr/include/linux/raid/ (2 files)
  INSTALL usr/include/linux/sched/ (1 file)
  INSTALL usr/include/linux/spi/ (1 file)
  INSTALL usr/include/linux/sunrpc/ (1 file)
  INSTALL usr/include/linux/tc_act/ (15 files)
  INSTALL usr/include/linux/tc_ematch/ (5 files)
  INSTALL usr/include/linux/usb/ (13 files)
  INSTALL usr/include/linux/wimax/ (1 file)
  INSTALL usr/include/misc/ (2 files)
  INSTALL usr/include/mtd/ (5 files)
  INSTALL usr/include/rdma/ (25 files)
  INSTALL usr/include/rdma/hfi/ (2 files)
  INSTALL usr/include/scsi/ (5 files)
  INSTALL usr/include/scsi/fc/ (4 files)
  INSTALL usr/include/sound/ (16 files)
  INSTALL usr/include/video/ (3 files)
  INSTALL usr/include/xen/ (4 files)
  INSTALL usr/include/asm/ (62 files)
make[2]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919'
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_wait_timeout.c ../include/futextest.h ../include/atomic.h ../inc=
lude/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a94=
5d476d3d86b3c0dae43a9919/tools/testing/selftests/futex/functional/futex_wai=
t_timeout
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_wait_wouldblock.c ../include/futextest.h ../include/atomic.h ../=
include/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303=
a945d476d3d86b3c0dae43a9919/tools/testing/selftests/futex/functional/futex_=
wait_wouldblock
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_requeue_pi.c ../include/futextest.h ../include/atomic.h ../inclu=
de/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d=
476d3d86b3c0dae43a9919/tools/testing/selftests/futex/functional/futex_reque=
ue_pi
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_requeue_pi_signal_restart.c ../include/futextest.h ../include/at=
omic.h ../include/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-32b=
d07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/futex/functio=
nal/futex_requeue_pi_signal_restart
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_requeue_pi_mismatched_ops.c ../include/futextest.h ../include/at=
omic.h ../include/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-32b=
d07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/futex/functio=
nal/futex_requeue_pi_mismatched_ops
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_wait_uninitialized_heap.c ../include/futextest.h ../include/atom=
ic.h ../include/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd0=
7585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/futex/functiona=
l/futex_wait_uninitialized_heap
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_wait_private_mapped_file.c ../include/futextest.h ../include/ato=
mic.h ../include/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd=
07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/futex/function=
al/futex_wait_private_mapped_file
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/futex/functional'
TAP version 13
selftests: futex: run.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified

# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D0 owner=3D1 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D2000000000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D2000000000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1

# futex_requeue_pi_mismatched_ops: Detect mismatched requeue_pi operations
ok 1 futex-requeue-pi-mismatched-ops
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1

# futex_requeue_pi_signal_restart: Test signal handling during requeue_pi
# 	Arguments: <none>
ok 1 futex-requeue-pi-signal-restart
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1

# futex_wait_timeout: Block on a futex and wait for timeout
# 	Arguments: timeout=3D100000ns
ok 1 futex-wait-timeout
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1

# futex_wait_wouldblock: Test the unexpected futex value in FUTEX_WAIT
ok 1 futex-wait-wouldblock
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1

# futex_wait_uninitialized_heap: Test the uninitialized futex value in FUTE=
X_WAIT
ok 1 futex-wait-uninitialized-heap
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_wait_private_mapped_file: Test the futex value of private file mapp=
ings in FUTEX_WAIT
ok 1 futex-wait-private-mapped-file
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
ok 1..1 selftests: futex: run.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/futex'

2019-02-01 19:35:29 make run_tests -C gpio
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/gpio'
make OUTPUT=3D/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476=
d3d86b3c0dae43a9919/tools/gpio/ -C /usr/src/perf_selftests-x86_64-rhel-7.2-=
32bd07585d303a945d476d3d86b3c0dae43a9919/tools/gpio
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919/tools/gpio'
mkdir -p /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86=
b3c0dae43a9919/tools/gpio/include/linux 2>&1 || true
ln -sf /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3=
c0dae43a9919/tools/gpio/../../include/uapi/linux/gpio.h /usr/src/perf_selft=
ests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/gpio/in=
clude/linux/gpio.h
make -f /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b=
3c0dae43a9919/tools/build/Makefile.build dir=3D. obj=3Dlsgpio
make[2]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919/tools/gpio'
  CC       /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/gpio/lsgpio.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/gpio/gpio-utils.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/gpio/lsgpio-in.o
make[2]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919/tools/gpio'
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/gpio/lsgpio
make -f /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b=
3c0dae43a9919/tools/build/Makefile.build dir=3D. obj=3Dgpio-hammer
make[2]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919/tools/gpio'
  CC       /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/gpio/gpio-hammer.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/gpio/gpio-hammer-in.o
make[2]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919/tools/gpio'
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/gpio/gpio-hammer
make -f /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b=
3c0dae43a9919/tools/build/Makefile.build dir=3D. obj=3Dgpio-event-mon
make[2]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919/tools/gpio'
  CC       /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/gpio/gpio-event-mon.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/gpio/gpio-event-mon-in.o
make[2]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919/tools/gpio'
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/gpio/gpio-event-mon
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919/tools/gpio'
gcc -O2 -g -std=3Dgnu99 -Wall -I../../../../usr/include/ -I/usr/include/lib=
mount -I/usr/include/blkid -I/usr/include/uuid    gpio-mockup-chardev.c /us=
r/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a99=
19/tools/gpio/gpio-utils.o  -lmount -o gpio-mockup-chardev
make ARCH=3Dx86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919'
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919'
TAP version 13
selftests: gpio: gpio-mockup.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1.  Test dynamic allocation of gpio successful means insert gpiochip and
    manipulate gpio pin successful
GPIO gpio-mockup test with ranges: <-1,32>:=20
-1,32     =20
gpio<gpio-mockup> test failed
Test gpiochip gpio-mockup: GPIO gpio-mockup test with ranges: <-1,32,-1,32>=
:=20
-1,32,-1,32=20
gpio<gpio-mockup> test failed
Test gpiochip gpio-mockup: GPIO gpio-mockup test with ranges: <-1,32,-1,32,=
-1,32>:=20
-1,32,-1,32,-1,32=20
gpio<gpio-mockup> test failed
Test gpiochip gpio-mockup: 3.  Error test: successful means insert gpiochip=
 failed
3.1 Test number of gpio overflow
GPIO gpio-mockup test with ranges: <-1,32,-1,1024>:=20
-1,32,-1,1024=20
Test gpiochip gpio-mockup: Invalid test successful
GPIO test PASS
ok 1..1 selftests: gpio: gpio-mockup.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/gpio'
ia64 test: not in Makefile
2019-02-01 19:35:36 make TARGETS=3Dia64
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ia64'
Makefile:9: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
gcc     aliasing-test.c   -o aliasing-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ia64'

2019-02-01 19:35:36 make run_tests -C ia64
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ia64'
Makefile:9: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
TAP version 13
selftests: ia64: aliasing-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PASS: /dev/mem 0x0-0xa0000 is readable
PASS: /dev/mem 0xa0000-0xc0000 is mappable
PASS: /dev/mem 0xc0000-0x100000 is readable
PASS: /dev/mem 0x0-0x100000 is mappable
PASS: /sys/devices/pci0000:00/0000:00:02.0/rom read 39422 bytes
PASS: /sys/devices/pci0000:00/0000:00:03.0/rom read 231422 bytes
PASS: /proc/bus/pci/00/00.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/01.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/01.1 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/01.3 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/02.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/03.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/04.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/05.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/06.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/07.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/08.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/09.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/0a.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/0b.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/00.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/01.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/01.1 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/01.3 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/02.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/03.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/04.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/05.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/06.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/07.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/08.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/09.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/0a.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/0b.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/00.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/01.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/01.1 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/01.3 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/02.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/03.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/04.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/05.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/06.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/07.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/08.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/09.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/0a.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/0b.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/00.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/01.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/01.1 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/01.3 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/02.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/03.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/04.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/05.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/06.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/07.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/08.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/09.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/0a.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/0b.0 0x0-0x100000 not mappable
ok 1..1 selftests: ia64: aliasing-test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ia64'

2019-02-01 19:35:39 make run_tests -C ima
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ima'
TAP version 13
selftests: ima: test_kexec_load.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2E/test_kexec_load.sh: 15: [: !=3D: unexpected operator
=2E/test_kexec_load.sh: efivars is not mounted on /sys/firmware/efi/efivars
not ok 1..1 selftests: ima: test_kexec_load.sh [SKIP]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ima'

2019-02-01 19:35:40 make run_tests -C intel_pstate
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/intel_pstate'
gcc  -Wall -D_GNU_SOURCE    msr.c  -lm -o /usr/src/perf_selftests-x86_64-rh=
el-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/int=
el_pstate/msr
gcc  -Wall -D_GNU_SOURCE    aperf.c  -lm -o /usr/src/perf_selftests-x86_64-=
rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/i=
ntel_pstate/aperf
TAP version 13
selftests: intel_pstate: run.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
cpupower: error while loading shared libraries: libcpupower.so.0: cannot op=
en shared object file: No such file or directory
=2E/run.sh: line 90: / 1000: syntax error: operand expected (error token is=
 "/ 1000")
cpupower: error while loading shared libraries: libcpupower.so.0: cannot op=
en shared object file: No such file or directory
=2E/run.sh: line 92: / 1000: syntax error: operand expected (error token is=
 "/ 1000")
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The marketing frequency of the cpu is 0 MHz
The maximum frequency of the cpu is  MHz
The minimum frequency of the cpu is  MHz
Target	      Actual	    Difference	  MSR(0x199)	max_perf_pct
ok 1..1 selftests: intel_pstate: run.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/intel_pstate'

2019-02-01 19:35:41 make run_tests -C ipc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ipc'
gcc -DCONFIG_X86_64 -D__x86_64__ -I../../../../usr/include/    msgque.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae4=
3a9919/tools/testing/selftests/ipc/msgque
msgque.c: In function =E2=80=98restore_queue=E2=80=99:
msgque.c:52:7: warning: implicit declaration of function =E2=80=98msgget=E2=
=80=99 [-Wimplicit-function-declaration]
  id =3D msgget(msgque->key, msgque->mode | IPC_CREAT | IPC_EXCL);
       ^~~~~~
msgque.c:66:7: warning: implicit declaration of function =E2=80=98msgsnd=E2=
=80=99 [-Wimplicit-function-declaration]
   if (msgsnd(msgque->msq_id, &msgque->messages[i].mtype,
       ^~~~~~
msgque.c:76:6: warning: implicit declaration of function =E2=80=98msgctl=E2=
=80=99 [-Wimplicit-function-declaration]
  if (msgctl(id, IPC_RMID, 0))
      ^~~~~~
msgque.c: In function =E2=80=98check_and_destroy_queue=E2=80=99:
msgque.c:87:9: warning: implicit declaration of function =E2=80=98msgrcv=E2=
=80=99 [-Wimplicit-function-declaration]
   ret =3D msgrcv(msgque->msq_id, &message.mtype, MAX_MSG_SIZE,
         ^~~~~~
msgque.c: In function =E2=80=98main=E2=80=99:
msgque.c:203:15: warning: implicit declaration of function =E2=80=98ftok=E2=
=80=99 [-Wimplicit-function-declaration]
  msgque.key =3D ftok(argv[0], 822155650);
               ^~~~
TAP version 13
selftests: ipc: msgque
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..1 selftests: ipc: msgque [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ipc'

2019-02-01 19:35:41 make run_tests -C ir
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ir'
gcc     ir_loopback.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ir/ir_loopback
TAP version 13
selftests: ir: ir_loopback.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Bail out! cannot find lirc device for rc0
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
not ok 1..1 selftests: ir: ir_loopback.sh [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/ir'

2019-02-01 19:35:41 make run_tests -C kcmp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kcmp'
gcc -I../../../../usr/include/    kcmp_test.c  -o /usr/src/perf_selftests-x=
86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selft=
ests/kcmp/kcmp_test
TAP version 13
selftests: kcmp: kcmp_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
pid1:  14472 pid2:  14473 FD:  2 FILES:  2 VM:  1 FS:  1 SIGHAND:  1 IO:  0=
 SYSVSEM:  0 INV: -1
PASS: 0 returned as expected
PASS: 0 returned as expected
PASS: 0 returned as expected
Pass 3 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..3
Pass 3 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..3
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..1 selftests: kcmp: kcmp_test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kcmp'
kmod test: not in Makefile
2019-02-01 19:35:42 make TARGETS=3Dkmod
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kmod'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kmod'

2019-02-01 19:35:42 make run_tests -C kmod
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kmod'
TAP version 13
selftests: kmod: kmod.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Fri Feb  1 19:35:42 CST 2019
Running test: kmod_test_0001 - run #0
kmod_test_0001_driver: OK! - loading kmod test
kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0001_fs: OK! - loading kmod test
kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Fri Feb  1 19:35:42 CST 2019
Running test: kmod_test_0001 - run #1
kmod_test_0001_driver: OK! - loading kmod test
kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0001_fs: OK! - loading kmod test
kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Fri Feb  1 19:35:42 CST 2019
Running test: kmod_test_0001 - run #2
kmod_test_0001_driver: OK! - loading kmod test
kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0001_fs: OK! - loading kmod test
kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Fri Feb  1 19:35:42 CST 2019
Running test: kmod_test_0002 - run #0
kmod_test_0002_driver: OK! - loading kmod test
kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0002_fs: OK! - loading kmod test
kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Fri Feb  1 19:35:43 CST 2019
Running test: kmod_test_0002 - run #1
kmod_test_0002_driver: OK! - loading kmod test
kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0002_fs: OK! - loading kmod test
kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Fri Feb  1 19:35:44 CST 2019
Running test: kmod_test_0002 - run #2
kmod_test_0002_driver: OK! - loading kmod test
kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0002_fs: OK! - loading kmod test
kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Fri Feb  1 19:35:44 CST 2019
Running test: kmod_test_0003 - run #0
kmod_test_0003: OK! - loading kmod test
kmod_test_0003: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:44 CST 2019
Running test: kmod_test_0004 - run #0
kmod_test_0004: OK! - loading kmod test
kmod_test_0004: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:45 CST 2019
Running test: kmod_test_0005 - run #0
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:45 CST 2019
Running test: kmod_test_0005 - run #1
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:46 CST 2019
Running test: kmod_test_0005 - run #2
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:46 CST 2019
Running test: kmod_test_0005 - run #3
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:47 CST 2019
Running test: kmod_test_0005 - run #4
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:47 CST 2019
Running test: kmod_test_0005 - run #5
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:48 CST 2019
Running test: kmod_test_0005 - run #6
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:48 CST 2019
Running test: kmod_test_0005 - run #7
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:48 CST 2019
Running test: kmod_test_0005 - run #8
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:49 CST 2019
Running test: kmod_test_0005 - run #9
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:50 CST 2019
Running test: kmod_test_0006 - run #0
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:50 CST 2019
Running test: kmod_test_0006 - run #1
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:51 CST 2019
Running test: kmod_test_0006 - run #2
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:52 CST 2019
Running test: kmod_test_0006 - run #3
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:53 CST 2019
Running test: kmod_test_0006 - run #4
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:54 CST 2019
Running test: kmod_test_0006 - run #5
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:54 CST 2019
Running test: kmod_test_0006 - run #6
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:55 CST 2019
Running test: kmod_test_0006 - run #7
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:56 CST 2019
Running test: kmod_test_0006 - run #8
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:57 CST 2019
Running test: kmod_test_0006 - run #9
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:58 CST 2019
Running test: kmod_test_0007 - run #0
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:35:59 CST 2019
Running test: kmod_test_0007 - run #1
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:36:00 CST 2019
Running test: kmod_test_0007 - run #2
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:36:02 CST 2019
Running test: kmod_test_0007 - run #3
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Fri Feb  1 19:36:02 CST 2019
Running test: kmod_test_0007 - run #4
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
=2E/kmod.sh: line 529: [[: 1 0002:3:1 0003:1:1 0004:1:1 0005:10:1 0006:10:1=
 0007:5:1 0008:150:1 0009:150:1: syntax error in expression (error token is=
 "0002:3:1 0003:1:1 0004:1:1 0005:10:1 0006:10:1 0007:5:1 0008:150:1 0009:1=
50:1")
=2E/kmod.sh: line 529: [[: 1 0002:3:1 0003:1:1 0004:1:1 0005:10:1 0006:10:1=
 0007:5:1 0008:150:1 0009:150:1: syntax error in expression (error token is=
 "0002:3:1 0003:1:1 0004:1:1 0005:10:1 0006:10:1 0007:5:1 0008:150:1 0009:1=
50:1")
Test completed
ok 1..1 selftests: kmod: kmod.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kmod'

2019-02-01 19:36:04 make run_tests -C kvm
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kvm'
make ARCH=3Dx86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919'
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919'
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/assert.c -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/=
testing/selftests/kvm/lib/assert.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/elf.c -o /usr/src/perf_s=
elftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/tes=
ting/selftests/kvm/lib/elf.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/io.c -o /usr/src/perf_se=
lftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/test=
ing/selftests/kvm/lib/io.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/kvm_util.c -o /usr/src/p=
erf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tool=
s/testing/selftests/kvm/lib/kvm_util.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/ucall.c -o /usr/src/perf=
_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/t=
esting/selftests/kvm/lib/ucall.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/sparsebit.c -o /usr/src/=
perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/too=
ls/testing/selftests/kvm/lib/sparsebit.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib/x86_64 -Iinclude/x86_64 -I..   -c lib/x86_64/processor.=
c -o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0=
dae43a9919/tools/testing/selftests/kvm/lib/x86_64/processor.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib/x86_64 -Iinclude/x86_64 -I..   -c lib/x86_64/vmx.c -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a=
9919/tools/testing/selftests/kvm/lib/x86_64/vmx.o
ar crs /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3=
c0dae43a9919/tools/testing/selftests/kvm/libkvm.a /usr/src/perf_selftests-x=
86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selft=
ests/kvm/lib/assert.o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303=
a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kvm/lib/elf.o /usr/src/=
perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/too=
ls/testing/selftests/kvm/lib/io.o /usr/src/perf_selftests-x86_64-rhel-7.2-3=
2bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kvm/lib/kvm=
_util.o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b=
3c0dae43a9919/tools/testing/selftests/kvm/lib/ucall.o /usr/src/perf_selftes=
ts-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/s=
elftests/kvm/lib/sparsebit.o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kvm/lib/x86_64/p=
rocessor.o /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d=
86b3c0dae43a9919/tools/testing/selftests/kvm/lib/x86_64/vmx.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/platform_inf=
o_test.c /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86=
b3c0dae43a9919/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selft=
ests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing=
/selftests/kvm/x86_64/platform_info_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/set_sregs_te=
st.c /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0=
dae43a9919/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/sel=
ftests/kvm/x86_64/set_sregs_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/sync_regs_te=
st.c /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0=
dae43a9919/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/sel=
ftests/kvm/x86_64/sync_regs_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/vmx_tsc_adju=
st_test.c /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d8=
6b3c0dae43a9919/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_self=
tests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testin=
g/selftests/kvm/x86_64/vmx_tsc_adjust_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/cr4_cpuid_sy=
nc_test.c /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d8=
6b3c0dae43a9919/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_self=
tests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testin=
g/selftests/kvm/x86_64/cr4_cpuid_sync_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/state_test.c=
 /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae4=
3a9919/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests-x86=
_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftes=
ts/kvm/x86_64/state_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/evmcs_test.c=
 /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae4=
3a9919/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests-x86=
_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftes=
ts/kvm/x86_64/evmcs_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/hyperv_cpuid=
=2Ec /usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0=
dae43a9919/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/sel=
ftests/kvm/x86_64/hyperv_cpuid
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -I. -Iinclude/x86_64 -I..  -pthread  dirty_log_test.c /usr/sr=
c/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/t=
ools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests-x86_64-rhel=
-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kvm/d=
irty_log_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -I. -Iinclude/x86_64 -I..  -pthread  clear_dirty_log_test.c /=
usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a=
9919/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests-x86_6=
4-rhel-7.2-32bd07585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests=
/kvm/clear_dirty_log_test
TAP version 13
selftests: kvm: platform_info_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..1 selftests: kvm: platform_info_test [SKIP]
selftests: kvm: set_sregs_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..2 selftests: kvm: set_sregs_test [SKIP]
selftests: kvm: sync_regs_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..3 selftests: kvm: sync_regs_test [SKIP]
selftests: kvm: vmx_tsc_adjust_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..4 selftests: kvm: vmx_tsc_adjust_test [SKIP]
selftests: kvm: cr4_cpuid_sync_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..5 selftests: kvm: cr4_cpuid_sync_test [SKIP]
selftests: kvm: state_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..6 selftests: kvm: state_test [SKIP]
selftests: kvm: evmcs_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..7 selftests: kvm: evmcs_test [SKIP]
selftests: kvm: hyperv_cpuid
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..8 selftests: kvm: hyperv_cpuid [SKIP]
selftests: kvm: dirty_log_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Test iterations: 32, interval: 10 (ms)
Testing guest mode: PA-bits:52, VA-bits:48, 4K pages
guest physical test memory offset: 0x7fbffff000
not ok 1..9 selftests: kvm: dirty_log_test [SKIP]
selftests: kvm: clear_dirty_log_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..10 selftests: kvm: clear_dirty_log_test [SKIP]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/kvm'

2019-02-01 19:36:14 make run_tests -C lib
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/lib'
TAP version 13
selftests: lib: printf.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
printf: ok
ok 1..1 selftests: lib: printf.sh [PASS]
selftests: lib: bitmap.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
bitmap: ok
ok 1..2 selftests: lib: bitmap.sh [PASS]
selftests: lib: prime_numbers.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
prime_numbers: [FAIL]
not ok 1..3 selftests: lib: prime_numbers.sh [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/lib'
locking test: not in Makefile
2019-02-01 19:36:14 make TARGETS=3Dlocking
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07=
585d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/locking'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd075=
85d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/locking'

2019-02-01 19:36:14 make run_tests -C locking
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585=
d303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/locking'
TAP version 13
selftests: locking: ww_mutex.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
locking/ww_mutex: ok
ok 1..1 selftests: locking: ww_mutex.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-32bd07585d=
303a945d476d3d86b3c0dae43a9919/tools/testing/selftests/locking'

--vGgW1X5XWziG23Ko--
