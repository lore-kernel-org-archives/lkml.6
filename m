Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E845C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 02:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF5F20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 02:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF5F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeKBLRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 07:17:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:35747 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbeKBLRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 07:17:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2018 19:11:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,454,1534834800"; 
   d="xz'?scan'208";a="93099162"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Nov 2018 19:11:28 -0700
Date:   Fri, 2 Nov 2018 10:11:45 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
Subject: [LKP] [net/ipv6]  4ed591c8ab:
 kernel_selftests.net.fib-onlink-tests.sh.fail
Message-ID: <20181102021145.GI24195@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lrl7g2KojMNQ8tYq"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrl7g2KojMNQ8tYq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

FYI, we noticed the following commit (built with gcc-7):

commit: 4ed591c8ab44e711e56b8e021ffaf4f407c045f5 ("net/ipv6: Allow onlink r=
outes to have a device mismatch if it is the default route")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: kernel_selftests
with following parameters:

	group: kselftests-02

test-description: The kernel contains a set of "self tests" under the tools=
/testing/selftests/ directory. These are intended to be small unit tests to=
 exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: qemu-system-x86_64 -enable-kvm -cpu kvm64,+ssse3 -smp 2 -m=
 8G

caused below changes (please refer to attached dmesg/kmsg for entire log/ba=
cktrace):




KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7=
=2E2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5
2018-11-01 03:14:05 ln -sf /usr/bin/clang-7 /usr/bin/clang
2018-11-01 03:14:05 ln -sf /usr/bin/llc-7 /usr/bin/llc
media_tests test: not in Makefile
2018-11-01 03:14:05 make TARGETS=3Dmedia_tests
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591=
c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/media_tests'
gcc -I../ -I../../../../usr/include/    media_device_test.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools=
/testing/selftests/media_tests/media_device_test
gcc -I../ -I../../../../usr/include/    media_device_open.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools=
/testing/selftests/media_tests/media_device_open
gcc -I../ -I../../../../usr/include/    video_device_test.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools=
/testing/selftests/media_tests/video_device_test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c=
8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/media_tests'
ignored_by_lkp media_tests test

2018-11-01 03:14:12 make run_tests -C membarrier
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/membarrier'
gcc -g -I../../../../usr/include/    membarrier_test.c  -o /usr/src/perf_se=
lftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/test=
ing/selftests/membarrier/membarrier_test
TAP version 13
selftests: membarrier: membarrier_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1 sys_membarrier available
ok 2 sys membarrier invalid command test: command =3D -1, flags =3D 0, errn=
o =3D 22. Failed as expected
ok 3 sys membarrier MEMBARRIER_CMD_QUERY invalid flags test: flags =3D 1, e=
rrno =3D 22. Failed as expected
ok 4 sys membarrier MEMBARRIER_CMD_GLOBAL test: flags =3D 0
ok 5 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED not registered failure=
 test: flags =3D 0, errno =3D 1
ok 6 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED test: flags =
=3D 0
ok 7 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED test: flags =3D 0
ok 8 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE not register=
ed failure test: flags =3D 0, errno =3D 1
ok 9 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE tes=
t: flags =3D 0
ok 10 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE test: flags=
 =3D 0
ok 11 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
ok 12 sys membarrier MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED test: flags =
=3D 0
ok 13 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
Pass 13 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..13
ok 1..1 selftests: membarrier: membarrier_test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/membarrier'

2018-11-01 03:14:13 make run_tests -C memfd
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/memfd'
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/   -c -o common.o common.c
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    memfd_test.c common.o  -o /usr/src/perf_=
selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/te=
sting/selftests/memfd/memfd_test
memfd_test.c: In function =E2=80=98mfd_assert_get_seals=E2=80=99:
memfd_test.c:74:6: warning: implicit declaration of function =E2=80=98fcntl=
=E2=80=99 [-Wimplicit-function-declaration]
  r =3D fcntl(fd, F_GET_SEALS);
      ^~~~~
memfd_test.c: In function =E2=80=98mfd_assert_open=E2=80=99:
memfd_test.c:197:6: warning: implicit declaration of function =E2=80=98open=
=E2=80=99 [-Wimplicit-function-declaration]
  r =3D open(buf, flags, mode);
      ^~~~
memfd_test.c: In function =E2=80=98mfd_assert_write=E2=80=99:
memfd_test.c:328:6: warning: implicit declaration of function =E2=80=98fall=
ocate=E2=80=99 [-Wimplicit-function-declaration]
  r =3D fallocate(fd,
      ^~~~~~~~~
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    fuse_mnt.c -lfuse -pthread -o /usr/src/p=
erf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tool=
s/testing/selftests/memfd/fuse_mnt
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    fuse_test.c common.o  -o /usr/src/perf_s=
elftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/tes=
ting/selftests/memfd/fuse_test
fuse_test.c: In function =E2=80=98mfd_assert_get_seals=E2=80=99:
fuse_test.c:67:6: warning: implicit declaration of function =E2=80=98fcntl=
=E2=80=99 [-Wimplicit-function-declaration]
  r =3D fcntl(fd, F_GET_SEALS);
      ^~~~~
fuse_test.c: In function =E2=80=98main=E2=80=99:
fuse_test.c:261:7: warning: implicit declaration of function =E2=80=98open=
=E2=80=99 [-Wimplicit-function-declaration]
  fd =3D open(argv[1], O_RDONLY | O_CLOEXEC);
       ^~~~
TAP version 13
selftests: memfd: memfd_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
memfd: CREATE
memfd: BASIC
memfd: SEAL-WRITE
memfd: SEAL-SHRINK
memfd: SEAL-GROW
memfd: SEAL-RESIZE
memfd: SHARE-DUP=20
memfd: SHARE-MMAP=20
memfd: SHARE-OPEN=20
memfd: SHARE-FORK=20
memfd: SHARE-DUP (shared file-table)
memfd: SHARE-MMAP (shared file-table)
memfd: SHARE-OPEN (shared file-table)
memfd: SHARE-FORK (shared file-table)
memfd: DONE
ok 1..1 selftests: memfd: memfd_test [PASS]
selftests: memfd: run_fuse_test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
opening: ./mnt/memfd
fuse: DONE
ok 1..2 selftests: memfd: run_fuse_test.sh [PASS]
selftests: memfd: run_hugetlbfs_test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
memfd-hugetlb: CREATE
memfd-hugetlb: BASIC
memfd-hugetlb: SEAL-WRITE
memfd-hugetlb: SEAL-SHRINK
memfd-hugetlb: SEAL-GROW
memfd-hugetlb: SEAL-RESIZE
memfd-hugetlb: SHARE-DUP=20
memfd-hugetlb: SHARE-MMAP=20
memfd-hugetlb: SHARE-OPEN=20
memfd-hugetlb: SHARE-FORK=20
memfd-hugetlb: SHARE-DUP (shared file-table)
memfd-hugetlb: SHARE-MMAP (shared file-table)
memfd-hugetlb: SHARE-OPEN (shared file-table)
memfd-hugetlb: SHARE-FORK (shared file-table)
memfd: DONE
opening: ./mnt/memfd
fuse: DONE
ok 1..3 selftests: memfd: run_hugetlbfs_test.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/memfd'

2018-11-01 03:14:20 make run_tests -C memory-hotplug
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/memory-hotplug'
TAP version 13
selftests: memory-hotplug: mem-on-off-test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Test scope: 2% hotplug memory
	 online all hot-pluggable memory in offline state:
		 SKIPPED - no hot-pluggable memory in offline state
	 offline 2% hot-pluggable memory in online state
	 trying to offline 1 out of 43 memory block(s):
online->offline memory1
	 online all hot-pluggable memory in offline state:
offline->online memory1
	 Test with memory notifier error injection
ok 1..1 selftests: memory-hotplug: mem-on-off-test.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/memory-hotplug'

2018-11-01 03:14:34 make run_tests -C mount
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/mount'
gcc -Wall -O2    unprivileged-remount-test.c  -o /usr/src/perf_selftests-x8=
6_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selfte=
sts/mount/unprivileged-remount-test
TAP version 13
selftests: mount: run_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: mount: run_tests.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/mount'

2018-11-01 03:14:37 make run_tests -C mqueue
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/mqueue'
gcc -O2    mq_open_tests.c -lrt -lpthread -lpopt -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/sel=
ftests/mqueue/mq_open_tests
gcc -O2    mq_perf_tests.c -lrt -lpthread -lpopt -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/sel=
ftests/mqueue/mq_perf_tests
TAP version 13
selftests: mqueue: mq_open_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Using Default queue path - /test1

Initial system state:
	Using queue path:		/test1
	RLIMIT_MSGQUEUE(soft):		819200
	RLIMIT_MSGQUEUE(hard):		819200
	Maximum Message Size:		8192
	Maximum Queue Size:		10
	Default Message Size:		8192
	Default Queue Size:		10

Adjusted system state for testing:
	RLIMIT_MSGQUEUE(soft):		819200
	RLIMIT_MSGQUEUE(hard):		819200
	Maximum Message Size:		8192
	Maximum Queue Size:		10
	Default Message Size:		8192
	Default Queue Size:		10


Test series 1, behavior when no attr struct passed to mq_open:
Kernel supports setting defaults separately from maximums:		PASS
Given sane values, mq_open without an attr struct succeeds:		PASS
Kernel properly honors default setting knobs:				PASS
Kernel properly limits default values to lesser of default/max:		PASS
Kernel properly fails to create queue when defaults would
exceed rlimit:								PASS


Test series 2, behavior when attr struct is passed to mq_open:
Queue open in excess of rlimit max when euid =3D 0 failed:		PASS
Queue open with mq_maxmsg > limit when euid =3D 0 succeeded:		PASS
Queue open with mq_msgsize > limit when euid =3D 0 succeeded:		PASS
Queue open with total size > 2GB when euid =3D 0 failed:			PASS
Queue open in excess of rlimit max when euid =3D 99 failed:		PASS
Queue open with mq_maxmsg > limit when euid =3D 99 failed:		PASS
Queue open with mq_msgsize > limit when euid =3D 99 failed:		PASS
Queue open with total size > 2GB when euid =3D 99 failed:			PASS
ok 1..1 selftests: mqueue: mq_open_tests [PASS]
selftests: mqueue: mq_perf_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Initial system state:
	Using queue path:			/mq_perf_tests
	RLIMIT_MSGQUEUE(soft):			819200
	RLIMIT_MSGQUEUE(hard):			819200
	Maximum Message Size:			8192
	Maximum Queue Size:			10
	Nice value:				0

Adjusted system state for testing:
	RLIMIT_MSGQUEUE(soft):			(unlimited)
	RLIMIT_MSGQUEUE(hard):			(unlimited)
	Maximum Message Size:			16777216
	Maximum Queue Size:			65530
	Nice value:				-20
	Continuous mode:			(disabled)
	CPUs to pin:				1

	Queue /mq_perf_tests created:
		mq_flags:			O_NONBLOCK
		mq_maxmsg:			65530
		mq_msgsize:			16
		mq_curmsgs:			0

	Started mqueue performance test thread on CPU 1
		Max priorities:			32768
		Clock resolution:		1 nsec

	Test #1: Time send/recv message, queue empty
		(10000000 iterations)
		Send msg:			147.596547974s total time
						14759 nsec/msg
		Recv msg:			150.130935067s total time
						15013 nsec/msg

	Test #2a: Time send/recv message, queue full, constant prio
:
		(100000 iterations)
		Filling queue...done.		0.630813471s
		Testing...done.
		Send msg:			1.292862532s total time
						12928 nsec/msg
		Recv msg:			1.877316438s total time
						18773 nsec/msg
		Draining queue...done.		0.520496192s

	Test #2b: Time send/recv message, queue full, increasing prio
:
		(100000 iterations)
		Filling queue...done.		0.621102054s
		Testing...done.
		Send msg:			1.657194917s total time
						16571 nsec/msg
		Recv msg:			1.636880260s total time
						16368 nsec/msg
		Draining queue...done.		0.573276286s

	Test #2c: Time send/recv message, queue full, decreasing prio
:
		(100000 iterations)
		Filling queue...done.		0.615924126s
		Testing...done.
		Send msg:			1.707979529s total time
						17079 nsec/msg
		Recv msg:			1.635604432s total time
						16356 nsec/msg
		Draining queue...done.		0.560375351s

	Test #2d: Time send/recv message, queue full, random prio
:
		(100000 iterations)
		Filling queue...done.		0.695287009s
		Testing...done.
		Send msg:			1.780201977s total time
						17802 nsec/msg
		Recv msg:			1.696726247s total time
						16967 nsec/msg
		Draining queue...done.		0.589003793s
ok 1..2 selftests: mqueue: mq_perf_tests [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/mqueue'

2018-11-01 03:21:19 make run_tests -C net
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/net'
make ARCH=3Dx86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591=
c8ab44e711e56b8e021ffaf4f407c045f5'
  UPD     include/generated/uapi/linux/version.h
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
  HOSTCC  scripts/unifdef
  INSTALL usr/include/asm-generic/ (37 files)
  INSTALL usr/include/drm/ (26 files)
  INSTALL usr/include/linux/ (500 files)
  INSTALL usr/include/linux/android/ (1 file)
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
  INSTALL usr/include/scsi/ (4 files)
  INSTALL usr/include/scsi/fc/ (4 files)
  INSTALL usr/include/sound/ (16 files)
  INSTALL usr/include/video/ (3 files)
  INSTALL usr/include/xen/ (4 files)
  INSTALL usr/include/asm/ (62 files)
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c=
8ab44e711e56b8e021ffaf4f407c045f5'
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_bpf.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e02=
1ffaf4f407c045f5/tools/testing/selftests/net/reuseport_bpf
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_bpf_cpu.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b=
8e021ffaf4f407c045f5/tools/testing/selftests/net/reuseport_bpf_cpu
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lnuma  reu=
seport_bpf_numa.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e=
711e56b8e021ffaf4f407c045f5/tools/testing/selftests/net/reuseport_bpf_numa
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_dualstack.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e5=
6b8e021ffaf4f407c045f5/tools/testing/selftests/net/reuseport_dualstack
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseaddr=
_conflict.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56=
b8e021ffaf4f407c045f5/tools/testing/selftests/net/reuseaddr_conflict
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    tls.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407=
c045f5/tools/testing/selftests/net/tls
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    socket.c =
 -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f=
407c045f5/tools/testing/selftests/net/socket
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_fan=
out.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021=
ffaf4f407c045f5/tools/testing/selftests/net/psock_fanout
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_tpa=
cket.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e02=
1ffaf4f407c045f5/tools/testing/selftests/net/psock_tpacket
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    msg_zeroc=
opy.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021=
ffaf4f407c045f5/tools/testing/selftests/net/msg_zerocopy
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lpthread  =
tcp_mmap.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b=
8e021ffaf4f407c045f5/tools/testing/selftests/net/tcp_mmap
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lpthread  =
tcp_inq.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8=
e021ffaf4f407c045f5/tools/testing/selftests/net/tcp_inq
tcp_inq.c: In function =E2=80=98main=E2=80=99:
tcp_inq.c:178:4: warning: dereferencing type-punned pointer will break stri=
ct-aliasing rules [-Wstrict-aliasing]
    inq =3D *((int *) CMSG_DATA(cm));
    ^~~
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_snd=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021f=
faf4f407c045f5/tools/testing/selftests/net/psock_snd
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso.c =
 -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f=
407c045f5/tools/testing/selftests/net/udpgso
udpgso.c: In function =E2=80=98send_one=E2=80=99:
udpgso.c:484:3: warning: dereferencing type-punned pointer will break stric=
t-aliasing rules [-Wstrict-aliasing]
   *((uint16_t *) CMSG_DATA(cm)) =3D gso_len;
   ^
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso_be=
nch_tx.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e=
021ffaf4f407c045f5/tools/testing/selftests/net/udpgso_bench_tx
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso_be=
nch_rx.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e=
021ffaf4f407c045f5/tools/testing/selftests/net/udpgso_bench_rx
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    ip_defrag=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021f=
faf4f407c045f5/tools/testing/selftests/net/ip_defrag
TAP version 13
selftests: net: reuseport_bpf
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- IPv4 UDP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing EBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 UDP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing EBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 UDP w/ mapped IPv4 ----
Testing EBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
---- IPv4 TCP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 TCP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 TCP w/ mapped IPv4 ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing filter add without bind...
SUCCESS
ok 1..1 selftests: net: reuseport_bpf [PASS]
selftests: net: reuseport_bpf_cpu
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- IPv4 UDP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
---- IPv6 UDP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
---- IPv4 TCP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
---- IPv6 TCP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
SUCCESS
ok 1..2 selftests: net: reuseport_bpf_cpu [PASS]
selftests: net: reuseport_bpf_numa
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- IPv4 UDP ----
send node 0, receive socket 0
send node 0, receive socket 0
---- IPv6 UDP ----
send node 0, receive socket 0
send node 0, receive socket 0
---- IPv4 TCP ----
send node 0, receive socket 0
send node 0, receive socket 0
---- IPv6 TCP ----
send node 0, receive socket 0
send node 0, receive socket 0
SUCCESS
ok 1..3 selftests: net: reuseport_bpf_numa [PASS]
selftests: net: reuseport_dualstack
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- UDP IPv4 created before IPv6 ----
---- UDP IPv6 created before IPv4 ----
---- UDP IPv4 created before IPv6 (large) ----
---- UDP IPv6 created before IPv4 (large) ----
---- TCP IPv4 created before IPv6 ----
---- TCP IPv6 created before IPv4 ----
SUCCESS
ok 1..4 selftests: net: reuseport_dualstack [PASS]
selftests: net: reuseaddr_conflict
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Opening 127.0.0.1:9999
Opening INADDR_ANY:9999
bind: Address already in use
Opening in6addr_any:9999
Opening INADDR_ANY:9999
bind: Address already in use
Opening INADDR_ANY:9999 after closing ipv6 socket
bind: Address already in use
Successok 1..5 selftests: net: reuseaddr_conflict [PASS]
selftests: net: tls
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 29 tests from 2 test cases.
[ RUN      ] tls.sendfile
[       OK ] tls.sendfile
[ RUN      ] tls.send_then_sendfile
[       OK ] tls.send_then_sendfile
[ RUN      ] tls.recv_max
[       OK ] tls.recv_max
[ RUN      ] tls.recv_small
[       OK ] tls.recv_small
[ RUN      ] tls.msg_more
[       OK ] tls.msg_more
[ RUN      ] tls.sendmsg_single
[       OK ] tls.sendmsg_single
[ RUN      ] tls.sendmsg_large
[       OK ] tls.sendmsg_large
[ RUN      ] tls.sendmsg_multiple
[       OK ] tls.sendmsg_multiple
[ RUN      ] tls.sendmsg_multiple_stress
[       OK ] tls.sendmsg_multiple_stress
[ RUN      ] tls.splice_from_pipe
[       OK ] tls.splice_from_pipe
[ RUN      ] tls.splice_from_pipe2
[       OK ] tls.splice_from_pipe2
[ RUN      ] tls.send_and_splice
[       OK ] tls.send_and_splice
[ RUN      ] tls.splice_to_pipe
[       OK ] tls.splice_to_pipe
[ RUN      ] tls.recvmsg_single
[       OK ] tls.recvmsg_single
[ RUN      ] tls.recvmsg_single_max
[       OK ] tls.recvmsg_single_max
[ RUN      ] tls.recvmsg_multiple
[       OK ] tls.recvmsg_multiple
[ RUN      ] tls.single_send_multiple_recv
[       OK ] tls.single_send_multiple_recv
[ RUN      ] tls.multiple_send_single_recv
[       OK ] tls.multiple_send_single_recv
[ RUN      ] tls.recv_partial
[       OK ] tls.recv_partial
[ RUN      ] tls.recv_nonblock
[       OK ] tls.recv_nonblock
[ RUN      ] tls.recv_peek
[       OK ] tls.recv_peek
[ RUN      ] tls.recv_peek_multiple
[       OK ] tls.recv_peek_multiple
[ RUN      ] tls.recv_peek_multiple_records
[       OK ] tls.recv_peek_multiple_records
[ RUN      ] tls.recv_peek_large_buf_mult_recs
[       OK ] tls.recv_peek_large_buf_mult_recs
[ RUN      ] tls.pollin
[       OK ] tls.pollin
[ RUN      ] tls.poll_wait
[       OK ] tls.poll_wait
[ RUN      ] tls.blocking
[       OK ] tls.blocking
[ RUN      ] tls.nonblocking
[       OK ] tls.nonblocking
[ RUN      ] tls.control_msg
[       OK ] tls.control_msg
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 29 / 29 tests passed.
[  PASSED  ]
ok 1..6 selftests: net: tls [PASS]
selftests: net: run_netsocktests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--------------------
running socket test
--------------------
[PASS]
ok 1..7 selftests: net: run_netsocktests [PASS]
selftests: net: run_afpackettests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--------------------
running psock_fanout test
--------------------
test: control single socket
test: control multiple sockets
test: unique ids

test: datapath 0x0 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D0,20, expect=3D15,5
warning: incorrect queue lengths
info: count=3D0,20, expect=3D20,5
warning: incorrect queue lengths
info: trying alternate ports (20)

test: datapath 0x0 ports 8000,8003
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D5,20, expect=3D20,5

test: datapath 0x1000 ports 8000,8003
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D15,20, expect=3D20,15

test: datapath 0x1 ports 8000,8003
info: count=3D0,0, expect=3D0,0
info: count=3D10,10, expect=3D10,10
info: count=3D17,18, expect=3D18,17

test: datapath 0x3 ports 8000,8003
info: count=3D0,0, expect=3D0,0
info: count=3D15,5, expect=3D15,5
info: count=3D20,15, expect=3D20,15

test: datapath 0x6 ports 8000,8003
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D20,15, expect=3D15,20

test: datapath 0x7 ports 8000,8003
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D20,15, expect=3D15,20

test: datapath 0x2 ports 8000,8003
info: count=3D0,0, expect=3D0,0
info: count=3D20,0, expect=3D20,0
info: count=3D20,0, expect=3D20,0

test: datapath 0x2 ports 8000,8003
info: count=3D0,0, expect=3D0,0
info: count=3D0,20, expect=3D0,20
info: count=3D0,20, expect=3D0,20

test: datapath 0x2000 ports 8000,8003
info: count=3D0,0, expect=3D0,0
info: count=3D20,20, expect=3D20,20
info: count=3D20,20, expect=3D20,20
OK. All tests passed
[PASS]
--------------------
running psock_tpacket test
--------------------
test: TPACKET_V1 with PACKET_RX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V1 with PACKET_TX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V2 with PACKET_RX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V2 with PACKET_TX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V3 with PACKET_RX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V3 with PACKET_TX_RING .................... 100 pkts (14200 b=
ytes)
OK. All tests passed
[PASS]
ok 1..8 selftests: net: run_afpackettests [PASS]
selftests: net: test_bpf.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
test_bpf: ok
ok 1..9 selftests: net: test_bpf.sh [PASS]
selftests: net: netdevice.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
SKIP: eth0: interface already up
Cannot get device udp-fragmentation-offload settings: Operation not support=
ed
PASS: eth0: ethtool list features
PASS: eth0: ethtool dump
PASS: eth0: ethtool stats
SKIP: eth0: interface kept up
ok 1..10 selftests: net: netdevice.sh [PASS]
selftests: net: rtnetlink.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PASS: policy routing
PASS: route get
PASS: tc htb hierarchy
PASS: gre tunnel endpoint
PASS: gretap
RTNETLINK answers: Operation not supported
Cannot find device "ip6gretap00"
Cannot find device "ip6gretap00"
Cannot find device "ip6gretap00"
RTNETLINK answers: Operation not supported
Cannot find device "ip6gretap00"
FAIL: ip6gretap
PASS: erspan
RTNETLINK answers: Operation not supported
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
RTNETLINK answers: Operation not supported
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
RTNETLINK answers: Operation not supported
Cannot find device "ip6erspan00"
FAIL: ip6erspan
PASS: bridge setup
PASS: ipv6 addrlabel
PASS: set ifalias 82e99eb8-f8d9-41da-9405-f42706a55eb8 for test-dummy0
PASS: vrf
PASS: vxlan
PASS: fou
PASS: macsec
PASS: ipsec
FAIL: ipsec_offload netdevsim doesn't support IPsec offload
ok 1..11 selftests: net: rtnetlink.sh [PASS]
selftests: net: fib_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Single path route test
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    Nexthop device deleted
    TEST: IPv4 fibmatch - no route                                      [ O=
K ]
    TEST: IPv6 fibmatch - no route                                      [ O=
K ]

Multipath route test
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    One nexthop device deleted
    TEST: IPv4 - multipath route removed on delete                      [ O=
K ]
    TEST: IPv6 - multipath down to single path                          [ O=
K ]
    Second nexthop device deleted
    TEST: IPv6 - no route                                               [ O=
K ]

Single path, admin down
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    Route deleted on down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]

Admin down multipath
    Verify start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    One device down, one up
    TEST: IPv4 fibmatch on down device                                  [ O=
K ]
    TEST: IPv6 fibmatch on down device                                  [ O=
K ]
    TEST: IPv4 fibmatch on up device                                    [ O=
K ]
    TEST: IPv6 fibmatch on up device                                    [ O=
K ]
    TEST: IPv4 flags on down device                                     [ O=
K ]
    TEST: IPv6 flags on down device                                     [ O=
K ]
    TEST: IPv4 flags on up device                                       [ O=
K ]
    TEST: IPv6 flags on up device                                       [ O=
K ]
    Other device down and up
    TEST: IPv4 fibmatch on down device                                  [ O=
K ]
    TEST: IPv6 fibmatch on down device                                  [ O=
K ]
    TEST: IPv4 fibmatch on up device                                    [ O=
K ]
    TEST: IPv6 fibmatch on up device                                    [ O=
K ]
    TEST: IPv4 flags on down device                                     [ O=
K ]
    TEST: IPv6 flags on down device                                     [ O=
K ]
    TEST: IPv4 flags on up device                                       [ O=
K ]
    TEST: IPv6 flags on up device                                       [ O=
K ]
    Both devices down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]

Local carrier tests - single path
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 - no linkdown flag                                       [ O=
K ]
    TEST: IPv6 - no linkdown flag                                       [ O=
K ]
    Carrier off on nexthop
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 - linkdown flag set                                      [ O=
K ]
    TEST: IPv6 - linkdown flag set                                      [ O=
K ]
    Route to local address with carrier down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 linkdown flag set                                        [ O=
K ]
    TEST: IPv6 linkdown flag set                                        [ O=
K ]

Single path route carrier test
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 no linkdown flag                                         [ O=
K ]
    TEST: IPv6 no linkdown flag                                         [ O=
K ]
    Carrier down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 linkdown flag set                                        [ O=
K ]
    TEST: IPv6 linkdown flag set                                        [ O=
K ]
    Second address added with carrier down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 linkdown flag set                                        [ O=
K ]
    TEST: IPv6 linkdown flag set                                        [ O=
K ]

IPv4 nexthop tests
<<< write me >>>

IPv6 nexthop tests
    TEST: Directly connected nexthop, unicast address                   [ O=
K ]
    TEST: Directly connected nexthop, unicast address with device       [ O=
K ]
    TEST: Gateway is linklocal address                                  [ O=
K ]
    TEST: Gateway is linklocal address, no device                       [ O=
K ]
    TEST: Gateway can not be local unicast address                      [ O=
K ]
    TEST: Gateway can not be local unicast address, with device         [ O=
K ]
    TEST: Gateway can not be a local linklocal address                  [ O=
K ]
    TEST: Gateway can be local address in a VRF                         [ O=
K ]
    TEST: Gateway can be local address in a VRF, with device            [ O=
K ]
    TEST: Gateway can be local linklocal address in a VRF               [ O=
K ]
    TEST: Redirect to VRF lookup                                        [ O=
K ]
    TEST: VRF route, gateway can be local address in default VRF        [ O=
K ]
    TEST: VRF route, gateway can not be a local address                 [ O=
K ]
    TEST: VRF route, gateway can not be a local addr with device        [ O=
K ]

IPv6 route add / append tests
    TEST: Attempt to add duplicate route - gw                           [ O=
K ]
    TEST: Attempt to add duplicate route - dev only                     [ O=
K ]
    TEST: Attempt to add duplicate route - reject route                 [ O=
K ]
    TEST: Append nexthop to existing route - gw                         [ O=
K ]
    TEST: Add multipath route                                           [ O=
K ]
    TEST: Attempt to add duplicate multipath route                      [ O=
K ]
    TEST: Route add with different metrics                              [ O=
K ]
    TEST: Route delete with metric                                      [ O=
K ]

IPv6 route replace tests
    TEST: Single path with single path                                  [ O=
K ]
    TEST: Single path with multipath                                    [ O=
K ]
    TEST: Single path with single path via multipath attribute          [ O=
K ]
    TEST: Invalid nexthop                                               [ O=
K ]
    TEST: Single path - replace of non-existent route                   [ O=
K ]
    TEST: Multipath with multipath                                      [ O=
K ]
    TEST: Multipath with single path                                    [ O=
K ]
    TEST: Multipath with single path via multipath attribute            [ O=
K ]
    TEST: Multipath - invalid first nexthop                             [ O=
K ]
    TEST: Multipath - invalid second nexthop                            [ O=
K ]
    TEST: Multipath - replace of non-existent route                     [ O=
K ]

IPv4 route add / append tests
    TEST: Attempt to add duplicate route - gw                           [ O=
K ]
    TEST: Attempt to add duplicate route - dev only                     [ O=
K ]
    TEST: Attempt to add duplicate route - reject route                 [ O=
K ]
    TEST: Add new nexthop for existing prefix                           [ O=
K ]
    TEST: Append nexthop to existing route - gw                         [ O=
K ]
    TEST: Append nexthop to existing route - dev only                   [ O=
K ]
    TEST: Append nexthop to existing route - reject route               [ O=
K ]
    TEST: Append nexthop to existing reject route - gw                  [ O=
K ]
    TEST: Append nexthop to existing reject route - dev only            [ O=
K ]
    TEST: add multipath route                                           [ O=
K ]
    TEST: Attempt to add duplicate multipath route                      [ O=
K ]
    TEST: Route add with different metrics                              [ O=
K ]
    TEST: Route delete with metric                                      [ O=
K ]

IPv4 route replace tests
    TEST: Single path with single path                                  [ O=
K ]
    TEST: Single path with multipath                                    [ O=
K ]
    TEST: Single path with reject route                                 [ O=
K ]
    TEST: Single path with single path via multipath attribute          [ O=
K ]
    TEST: Invalid nexthop                                               [ O=
K ]
    TEST: Single path - replace of non-existent route                   [ O=
K ]
    TEST: Multipath with multipath                                      [ O=
K ]
    TEST: Multipath with single path                                    [ O=
K ]
    TEST: Multipath with single path via multipath attribute            [ O=
K ]
    TEST: Multipath with reject route                                   [ O=
K ]
    TEST: Multipath - invalid first nexthop                             [ O=
K ]
    TEST: Multipath - invalid second nexthop                            [ O=
K ]
    TEST: Multipath - replace of non-existent route                     [ O=
K ]

IPv6 prefix route tests
    TEST: Default metric                                                [ O=
K ]
    TEST: User specified metric on first device                         [ O=
K ]
    TEST: User specified metric on second device                        [ O=
K ]
    TEST: Delete of address on first device                             [ O=
K ]
    TEST: Modify metric of address                                      [ O=
K ]
Command line is not complete. Try option "help"
    TEST: Prefix route removed on link down                             [ O=
K ]
    TEST: Prefix route with metric on link up                           [ O=
K ]

IPv4 prefix route tests
    TEST: Default metric                                                [ O=
K ]
    TEST: User specified metric on first device                         [ O=
K ]
    TEST: User specified metric on second device                        [ O=
K ]
    TEST: Delete of address on first device                             [ O=
K ]
    TEST: Modify metric of address                                      [ O=
K ]
Command line is not complete. Try option "help"
    TEST: Prefix route removed on link down                             [ O=
K ]
    TEST: Prefix route with metric on link up                           [ O=
K ]

IPv6 routes with metrics
    TEST: Single path route with mtu metric                             [ O=
K ]
    TEST: Multipath route via 2 single routes with mtu metric on first  [ O=
K ]
    TEST: Multipath route via 2 single routes with mtu metric on 2nd    [ O=
K ]
    TEST:     MTU of second leg                                         [ O=
K ]
    TEST: Multipath route with mtu metric                               [ O=
K ]
    TEST: Using route with mtu metric                                   [ O=
K ]
    TEST: Invalid metric (fails metric_convert)                         [ O=
K ]

IPv4 route add / append tests
    TEST: Single path route with mtu metric                             [ O=
K ]
    TEST: Multipath route with mtu metric                               [ O=
K ]
    TEST: Using route with mtu metric                                   [ O=
K ]
    TEST: Invalid metric (fails metric_convert)                         [ O=
K ]

Tests passed: 141
Tests failed:   0
ok 1..12 selftests: net: fib_tests.sh [PASS]
selftests: net: fib-onlink-tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

########################################
Configuring interfaces
RTNETLINK answers: File exists
not ok 1..13 selftests: net: fib-onlink-tests.sh [FAIL]
selftests: net: pmtu.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
TEST: ipv4: PMTU exceptions                                         [ OK ]
connect: Cannot assign requested address
connect: Cannot assign requested address
TEST: ipv6: PMTU exceptions                                         [FAIL]
  PMTU exception wasn't created after exceeding MTU
TEST: vti6: PMTU exceptions                                         [ OK ]
TEST: vti4: PMTU exceptions                                         [ OK ]
TEST: vti4: default MTU assignment                                  [ OK ]
TEST: vti6: default MTU assignment                                  [ OK ]
TEST: vti4: MTU setting on link creation                            [ OK ]
TEST: vti6: MTU setting on link creation                            [ OK ]
TEST: vti6: MTU changes on link changes                             [ OK ]
not ok 1..14 selftests: net: pmtu.sh [FAIL]
selftests: net: udpgso.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4 cmsg
device mtu (orig): 65536
device mtu (test): 1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv4 setsockopt
device mtu (orig): 65536
device mtu (test): 1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv6 cmsg
device mtu (orig): 65536
device mtu (test): 1500
ipv6 tx:1 gso:0=20
ipv6 tx:1452 gso:0=20
ipv6 tx:1453 gso:0 (fail)
ipv6 tx:1452 gso:1452 (fail)
ipv6 tx:1453 gso:1452=20
ipv6 tx:2904 gso:1452=20
ipv6 tx:2905 gso:1452=20
ipv6 tx:65340 gso:1452=20
ipv6 tx:65527 gso:1452=20
ipv6 tx:65528 gso:1452 (fail)
ipv6 tx:1 gso:1 (fail)
ipv6 tx:2 gso:1=20
ipv6 tx:5 gso:2=20
ipv6 tx:16 gso:1=20
ipv6 tx:17 gso:1 (fail)
OK
ipv6 setsockopt
device mtu (orig): 65536
device mtu (test): 1500
ipv6 tx:1 gso:0=20
ipv6 tx:1452 gso:0=20
ipv6 tx:1453 gso:0 (fail)
ipv6 tx:1452 gso:1452 (fail)
ipv6 tx:1453 gso:1452=20
ipv6 tx:2904 gso:1452=20
ipv6 tx:2905 gso:1452=20
ipv6 tx:65340 gso:1452=20
ipv6 tx:65527 gso:1452=20
ipv6 tx:65528 gso:1452 (fail)
ipv6 tx:1 gso:1 (fail)
ipv6 tx:2 gso:1=20
ipv6 tx:5 gso:2=20
ipv6 tx:16 gso:1=20
ipv6 tx:17 gso:1 (fail)
OK
ipv4 connected
device mtu (orig): 65536
device mtu (test): 1600
route mtu (test): 1500
path mtu (read):  1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv4 msg_more
device mtu (orig): 65536
device mtu (test): 1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv6 msg_more
device mtu (orig): 65536
device mtu (test): 1500
ipv6 tx:1 gso:0=20
ipv6 tx:1452 gso:0=20
ipv6 tx:1453 gso:0 (fail)
ipv6 tx:1452 gso:1452 (fail)
ipv6 tx:1453 gso:1452=20
ipv6 tx:2904 gso:1452=20
ipv6 tx:2905 gso:1452=20
ipv6 tx:65340 gso:1452=20
ipv6 tx:65527 gso:1452=20
ipv6 tx:65528 gso:1452 (fail)
ipv6 tx:1 gso:1 (fail)
ipv6 tx:2 gso:1=20
ipv6 tx:5 gso:2=20
ipv6 tx:16 gso:1=20
ipv6 tx:17 gso:1 (fail)
OK
ok 1..15 selftests: net: udpgso.sh [PASS]
selftests: net: ip_defrag.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4 defrag
PASS
seed =3D 1541042704
ipv4 defrag with overlaps
PASS
seed =3D 1541042713
ipv6 defrag
PASS
seed =3D 1541042744
ipv6 defrag with overlaps
PASS
seed =3D 1541042745
ok 1..16 selftests: net: ip_defrag.sh [PASS]
selftests: net: udpgso_bench.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4
tcp
tcp tx:    404 MB/s     6868 calls/s   6868 msg/s
tcp rx:    404 MB/s     6609 calls/s
tcp tx:    365 MB/s     6198 calls/s   6198 msg/s
tcp rx:    365 MB/s     6066 calls/s
tcp tx:    301 MB/s     5121 calls/s   5121 msg/s
tcp rx:    301 MB/s     5041 calls/s
tcp zerocopy
tcp rx:    242 MB/s     3955 calls/s
tcp tx:    242 MB/s     4119 calls/s   4119 msg/s
tcp tx:    283 MB/s     4814 calls/s   4814 msg/s
tcp rx:    286 MB/s     4369 calls/s
tcp tx:    278 MB/s     4716 calls/s   4716 msg/s
tcp rx:    276 MB/s     4128 calls/s
udp
udp rx:     37 MB/s    27038 calls/s
udp tx:     39 MB/s    27888 calls/s    664 msg/s
udp rx:     40 MB/s    28511 calls/s
udp tx:     41 MB/s    29778 calls/s    709 msg/s
udp rx:     40 MB/s    29047 calls/s
udp tx:     41 MB/s    29484 calls/s    702 msg/s
udp rx:     39 MB/s    27825 calls/s
udp gso
udp rx:    138 MB/s    98985 calls/s
udp tx:    142 MB/s     2423 calls/s   2423 msg/s
udp rx:    129 MB/s    92050 calls/s
udp tx:    141 MB/s     2395 calls/s   2395 msg/s
udp rx:    140 MB/s    99778 calls/s
udp tx:    148 MB/s     2515 calls/s   2515 msg/s
udp rx:    137 MB/s    97612 calls/s
ipv6
tcp
tcp tx:    389 MB/s     6614 calls/s   6614 msg/s
tcp rx:    390 MB/s     6516 calls/s
tcp tx:    292 MB/s     4953 calls/s   4953 msg/s
tcp rx:    293 MB/s     4889 calls/s
tcp tx:    342 MB/s     5811 calls/s   5811 msg/s
tcp rx:    341 MB/s     5575 calls/s
tcp zerocopy
tcp tx:    282 MB/s     4786 calls/s   4786 msg/s
tcp rx:    285 MB/s     4386 calls/s
tcp tx:    296 MB/s     5021 calls/s   5021 msg/s
tcp rx:    293 MB/s     4053 calls/s
tcp tx:    249 MB/s     4234 calls/s   4234 msg/s
tcp rx:    251 MB/s     3771 calls/s
udp
udp rx:     36 MB/s    26629 calls/s
udp tx:     37 MB/s    27434 calls/s    638 msg/s
udp rx:     34 MB/s    24992 calls/s
udp tx:     35 MB/s    25714 calls/s    598 msg/s
udp rx:     34 MB/s    25520 calls/s
udp tx:     36 MB/s    26531 calls/s    617 msg/s
udp rx:     35 MB/s    25741 calls/s
udp gso
udp rx:    136 MB/s    99704 calls/s
udp tx:    144 MB/s     2445 calls/s   2445 msg/s
udp rx:    123 MB/s    90363 calls/s
udp tx:    132 MB/s     2239 calls/s   2239 msg/s
udp rx:     99 MB/s    72199 calls/s
udp tx:    116 MB/s     1977 calls/s   1977 msg/s
udp rx:    136 MB/s    99764 calls/s
ok 1..17 selftests: net: udpgso_bench.sh [PASS]
selftests: net: fib_rule_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

######################################################################
TEST SECTION: IPv4 fib rule
######################################################################

    TEST: rule4 check: oif dummy0                             [ OK ]

    TEST: rule4 del by pref: oif dummy0                       [ OK ]
RTNETLINK answers: No route to host

    TEST: rule4 check: from 192.51.100.3 iif dummy0           [FAIL]

    TEST: rule4 del by pref: from 192.51.100.3 iif dummy0     [ OK ]

    TEST: rule4 check: tos 0x10                               [ OK ]

    TEST: rule4 del by pref: tos 0x10                         [ OK ]

    TEST: rule4 check: fwmark 0x64                            [ OK ]

    TEST: rule4 del by pref: fwmark 0x64                      [ OK ]

    TEST: rule4 check: uidrange 100-100                       [ OK ]

    TEST: rule4 del by pref: uidrange 100-100                 [ OK ]

    TEST: rule4 check: sport 666 dport 777                    [ OK ]

    TEST: rule4 del by pref: sport 666 dport 777              [ OK ]

    TEST: rule4 check: ipproto tcp                            [ OK ]

    TEST: rule4 del by pref: ipproto tcp                      [ OK ]

    TEST: rule4 check: ipproto icmp                           [ OK ]

    TEST: rule4 del by pref: ipproto icmp                     [ OK ]

######################################################################
TEST SECTION: IPv6 fib rule
######################################################################

    TEST: rule6 check: oif dummy0                             [ OK ]

    TEST: rule6 del by pref: oif dummy0                       [ OK ]

    TEST: rule6 check: from 2001:db8:1::3 iif dummy0          [ OK ]

    TEST: rule6 del by pref: from 2001:db8:1::3 iif dummy0    [ OK ]

    TEST: rule6 check: tos 0x10                               [ OK ]

    TEST: rule6 del by pref: tos 0x10                         [ OK ]

    TEST: rule6 check: fwmark 0x64                            [ OK ]

    TEST: rule6 del by pref: fwmark 0x64                      [ OK ]

    TEST: rule6 check: uidrange 100-100                       [ OK ]

    TEST: rule6 del by pref: uidrange 100-100                 [ OK ]

    TEST: rule6 check: sport 666 dport 777                    [ OK ]

    TEST: rule6 del by pref: sport 666 dport 777              [ OK ]

    TEST: rule6 check: ipproto tcp                            [ OK ]

    TEST: rule6 del by pref: ipproto tcp                      [ OK ]

    TEST: rule6 check: ipproto icmp                           [ OK ]

    TEST: rule6 del by pref: ipproto icmp                     [ OK ]
ok 1..18 selftests: net: fib_rule_tests.sh [PASS]
selftests: net: msg_zerocopy.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4 tcp -t 1
=2E/msg_zerocopy: setaffinity 2
=2E/msg_zerocopy: setaffinity 3
not ok 1..19 selftests: net: msg_zerocopy.sh [FAIL]
selftests: net: psock_snd.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
dgram
tx: 128
rx: 142
rx: 100
OK

dgram bind
tx: 128
rx: 142
rx: 100
OK

raw
tx: 142
rx: 142
rx: 100
OK

raw bind
tx: 142
rx: 142
rx: 100
OK

raw qdisc bypass
tx: 142
rx: 142
rx: 100
OK

raw vlan
tx: 146
rx: 100
OK

raw vnet hdr
tx: 152
rx: 142
rx: 100
OK

raw csum_off
tx: 152
rx: 142
rx: 100
OK

raw csum_off with bad offset (fails)
=2E/psock_snd: write: Invalid argument
raw min size
tx: 42
rx: 0
OK

raw mtu size
tx: 1514
rx: 1472
OK

raw mtu size + 1 (fails)
=2E/psock_snd: write: Message too long
raw vlan mtu size + 1 (fails)
=2E/psock_snd: write: Message too long
dgram mtu size
tx: 1500
rx: 1472
OK

dgram mtu size + 1 (fails)
=2E/psock_snd: write: Message too long
raw truncate hlen (fails: does not arrive)
tx: 14
=2E/psock_snd: recv: Resource temporarily unavailable
raw truncate hlen - 1 (fails: EINVAL)
=2E/psock_snd: write: Invalid argument
raw gso min size
tx: 1525
rx: 1473
OK

raw gso min size - 1 (fails)
tx: 1524
=2E/psock_snd: recv: Resource temporarily unavailable
raw gso max size
tx: 65559
rx: 65507
OK

raw gso max size + 1 (fails)
tx: 65560
=2E/psock_snd: recv: Resource temporarily unavailable
OK. All tests passed
ok 1..20 selftests: net: psock_snd.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/net'

2018-11-01 03:26:31 make run_tests -C nsfs
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/nsfs'
gcc -Wall -Werror    owner.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4e=
d591c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/nsfs/owner
gcc -Wall -Werror    pidns.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4e=
d591c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/nsfs/pidns
TAP version 13
selftests: nsfs: owner
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: nsfs: owner [PASS]
selftests: nsfs: pidns
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..2 selftests: nsfs: pidns [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/nsfs'
ignored_by_lkp powerpc test
prctl test: not in Makefile
2018-11-01 03:26:33 make TARGETS=3Dprctl
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591=
c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/prctl'
Makefile:14: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
gcc     disable-tsc-ctxt-sw-stress-test.c   -o disable-tsc-ctxt-sw-stress-t=
est
gcc     disable-tsc-on-off-stress-test.c   -o disable-tsc-on-off-stress-test
gcc     disable-tsc-test.c   -o disable-tsc-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c=
8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/prctl'

2018-11-01 03:26:35 make run_tests -C prctl
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/prctl'
Makefile:14: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
TAP version 13
selftests: prctl: disable-tsc-ctxt-sw-stress-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[No further output means we're allright]
ok 1..1 selftests: prctl: disable-tsc-ctxt-sw-stress-test [PASS]
selftests: prctl: disable-tsc-on-off-stress-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[No further output means we're allright]
ok 1..2 selftests: prctl: disable-tsc-on-off-stress-test [PASS]
selftests: prctl: disable-tsc-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
rdtsc() =3D=3D 2136876715236
prctl(PR_GET_TSC, &tsc_val); tsc_val =3D=3D PR_TSC_ENABLE
rdtsc() =3D=3D 2136879059273
prctl(PR_SET_TSC, PR_TSC_ENABLE)
rdtsc() =3D=3D 2136880080692
prctl(PR_SET_TSC, PR_TSC_SIGSEGV)
rdtsc() =3D=3D [ SIG_SEGV ]
prctl(PR_GET_TSC, &tsc_val); tsc_val =3D=3D PR_TSC_SIGSEGV
prctl(PR_SET_TSC, PR_TSC_ENABLE)
rdtsc() =3D=3D 2136884106335
ok 1..3 selftests: prctl: disable-tsc-test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/prctl'

2018-11-01 03:26:58 make run_tests -C proc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/proc'
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-001-lookup.c  -o /us=
r/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045=
f5/tools/testing/selftests/proc/fd-001-lookup
fd-001-lookup.c:17:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-002-posix-eq.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c0=
45f5/tools/testing/selftests/proc/fd-002-posix-eq
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-003-kthread.c  -o /u=
sr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c04=
5f5/tools/testing/selftests/proc/fd-003-kthread
fd-003-kthread.c:17:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-loadavg-001.c  -o =
/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c=
045f5/tools/testing/selftests/proc/proc-loadavg-001
proc-loadavg-001.c:17:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-map-files-001=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021f=
faf4f407c045f5/tools/testing/selftests/proc/proc-self-map-files-001
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-map-files-002=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021f=
faf4f407c045f5/tools/testing/selftests/proc/proc-self-map-files-002
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-syscall.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407=
c045f5/tools/testing/selftests/proc/proc-self-syscall
proc-self-syscall.c:16:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-wchan.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c0=
45f5/tools/testing/selftests/proc/proc-self-wchan
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-uptime-001.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c0=
45f5/tools/testing/selftests/proc/proc-uptime-001
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-uptime-002.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c0=
45f5/tools/testing/selftests/proc/proc-uptime-002
proc-uptime-002.c:18:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    read.c  -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/=
testing/selftests/proc/read
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    self.c  -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/=
testing/selftests/proc/self
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    thread-self.c  -o /usr/=
src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5=
/tools/testing/selftests/proc/thread-self
TAP version 13
selftests: proc: fd-001-lookup
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: proc: fd-001-lookup [PASS]
selftests: proc: fd-002-posix-eq
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..2 selftests: proc: fd-002-posix-eq [PASS]
selftests: proc: fd-003-kthread
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..3 selftests: proc: fd-003-kthread [PASS]
selftests: proc: proc-loadavg-001
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..4 selftests: proc: proc-loadavg-001 [PASS]
selftests: proc: proc-self-map-files-001
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..5 selftests: proc: proc-self-map-files-001 [PASS]
selftests: proc: proc-self-map-files-002
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..6 selftests: proc: proc-self-map-files-002 [PASS]
selftests: proc: proc-self-syscall
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..7 selftests: proc: proc-self-syscall [PASS]
selftests: proc: proc-self-wchan
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..8 selftests: proc: proc-self-wchan [PASS]
selftests: proc: proc-uptime-001
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..9 selftests: proc: proc-uptime-001 [PASS]
selftests: proc: proc-uptime-002
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..10 selftests: proc: proc-uptime-002 [PASS]
selftests: proc: read
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..11 selftests: proc: read [PASS]
selftests: proc: self
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..12 selftests: proc: self [PASS]
selftests: proc: thread-self
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..13 selftests: proc: thread-self [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/proc'

2018-11-01 03:27:17 make run_tests -C pstore
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/pstore'
TAP version 13
selftests: pstore: pstore_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D Pstore unit tests (pstore_tests) =3D=3D=3D
UUID=3D1b5b7a14-1391-4488-bee4-2ba136be2c20
Checking pstore backend is registered ... ok
	backend=3Dramoops
	cmdline=3Dip=3D::::vm-lkp-nex04-8G-16::dhcp root=3D/dev/ram0 user=3Dlkp jo=
b=3D/lkp/jobs/scheduled/vm-lkp-nex04-8G-16/kernel_selftests-kselftests-02-d=
ebian-x86_64-2018-04-03.cgz-4ed591c8ab44e711e56b8e021ffaf4f407c045f5-201811=
01-5823-1u1bjks-3.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-7.2 branch=3Dlin=
ux-devel/devel-hourly-2018102918 commit=3D4ed591c8ab44e711e56b8e021ffaf4f40=
7c045f5 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-7.2/gcc-7/4ed591c8ab44e711e56b8=
e021ffaf4f407c045f5/vmlinuz-4.19.0-04691-g4ed591c erst_disable max_uptime=
=3D3600 RESULT_ROOT=3D/result/kernel_selftests/kselftests-02/vm-lkp-nex04-8=
G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/4ed591c8ab44e711e56b8e=
021ffaf4f407c045f5/3 LKP_SERVER=3Dinn debug apic=3Ddebug sysrq_always_enabl=
ed rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don=
 panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ram=
disk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ig=
nore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115=
200 vga=3Dnormal rw rcuperf.shutdown=3D0
Checking pstore console is registered ... ok
Checking /dev/pmsg0 exists ... ok
Writing unique string to /dev/pmsg0 ... ok
ok 1..1 selftests: pstore: pstore_tests [PASS]
selftests: pstore: pstore_post_reboot_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D Pstore unit tests (pstore_post_reboot_tests) =3D=3D=3D
UUID=3Da2c028aa-199b-4365-b403-f8831048e36b
Checking pstore backend is registered ... ok
	backend=3Dramoops
	cmdline=3Dip=3D::::vm-lkp-nex04-8G-16::dhcp root=3D/dev/ram0 user=3Dlkp jo=
b=3D/lkp/jobs/scheduled/vm-lkp-nex04-8G-16/kernel_selftests-kselftests-02-d=
ebian-x86_64-2018-04-03.cgz-4ed591c8ab44e711e56b8e021ffaf4f407c045f5-201811=
01-5823-1u1bjks-3.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-7.2 branch=3Dlin=
ux-devel/devel-hourly-2018102918 commit=3D4ed591c8ab44e711e56b8e021ffaf4f40=
7c045f5 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-7.2/gcc-7/4ed591c8ab44e711e56b8=
e021ffaf4f407c045f5/vmlinuz-4.19.0-04691-g4ed591c erst_disable max_uptime=
=3D3600 RESULT_ROOT=3D/result/kernel_selftests/kselftests-02/vm-lkp-nex04-8=
G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/4ed591c8ab44e711e56b8e=
021ffaf4f407c045f5/3 LKP_SERVER=3Dinn debug apic=3Ddebug sysrq_always_enabl=
ed rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don=
 panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ram=
disk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ig=
nore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115=
200 vga=3Dnormal rw rcuperf.shutdown=3D0
pstore_crash_test has not been executed yet. we skip further tests.
not ok 1..2 selftests: pstore: pstore_post_reboot_tests [SKIP]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/pstore'
ptp test: not in Makefile
2018-11-01 03:27:18 make TARGETS=3Dptp
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591=
c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/ptp'
Makefile:10: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
gcc -I../../../../usr/include/    testptp.c  -lrt -o testptp
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c=
8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/ptp'

2018-11-01 03:27:20 make run_tests -C ptp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/ptp'
Makefile:10: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
TAP version 13
selftests: ptp: testptp
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: ptp: testptp [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/ptp'

2018-11-01 03:27:20 make run_tests -C ptrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/ptrace'
gcc -iquote../../../../include/uapi -Wall    peeksiginfo.c  -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/=
testing/selftests/ptrace/peeksiginfo
TAP version 13
selftests: ptrace: peeksiginfo
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PASS
ok 1..1 selftests: ptrace: peeksiginfo [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/ptrace'

2018-11-01 03:27:21 make run_tests -C rseq
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/rseq'
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ -shar=
ed -fPIC rseq.c -lpthread -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591=
c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/rseq/librseq.so
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ basic=
_test.c -lpthread -lrseq -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c=
8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/rseq/basic_test
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ basic=
_percpu_ops_test.c -lpthread -lrseq -o /usr/src/perf_selftests-x86_64-rhel-=
7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/rseq/b=
asic_percpu_ops_test
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ param=
_test.c -lpthread -lrseq -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c=
8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/rseq/param_test
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ -DBEN=
CHMARK param_test.c -lpthread -lrseq -o /usr/src/perf_selftests-x86_64-rhel=
-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/rseq/=
param_test_benchmark
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ -DRSE=
Q_COMPARE_TWICE param_test.c -lpthread -lrseq -o /usr/src/perf_selftests-x8=
6_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selfte=
sts/rseq/param_test_compare_twice
TAP version 13
selftests: rseq: basic_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
testing current cpu
ok 1..1 selftests: rseq: basic_test [PASS]
selftests: rseq: basic_percpu_ops_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
spinlock
percpu_list
ok 1..2 selftests: rseq: basic_percpu_ops_test [PASS]
selftests: rseq: param_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..3 selftests: rseq: param_test [PASS]
selftests: rseq: param_test_benchmark
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..4 selftests: rseq: param_test_benchmark [PASS]
selftests: rseq: param_test_compare_twice
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..5 selftests: rseq: param_test_compare_twice [PASS]
selftests: rseq: run_param_test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Default parameters
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Loop injection: 10000 loops
Injecting at <1>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <2>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <3>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <4>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <5>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <6>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <7>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <8>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <9>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Yield injection (25%)
Injecting at <7>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <8>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <9>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Yield injection (50%)
Injecting at <7>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <8>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <9>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Yield injection (100%)
Injecting at <7>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <8>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <9>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Kill injection (25%)
Injecting at <7>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <8>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <9>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Kill injection (50%)
Injecting at <7>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <8>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <9>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Kill injection (100%)
Injecting at <7>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <8>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <9>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Sleep injection (1ms, 25%)
Injecting at <7>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <8>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <9>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Sleep injection (1ms, 50%)
Injecting at <7>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <8>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <9>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Sleep injection (1ms, 100%)
Injecting at <7>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <8>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <9>
Running test spinlock



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script # job-script is attached in th=
is email



Thanks,
Rong Chen

--lrl7g2KojMNQ8tYq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.19.0-04691-g4ed591c"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.19.0 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70300
CONFIG_CLANG_VERSION=0
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
CONFIG_AUDIT_WATCH=y
CONFIG_AUDIT_TREE=y

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
CONFIG_INTEL_RDT=y
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
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
CONFIG_NO_BOOTMEM=y
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
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_PCI_DOMAINS=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
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

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
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
CONFIG_DELL_RBU=m
CONFIG_DCDBAS=m
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
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
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
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_CFQ_GROUP_IOSCHED=y
CONFIG_DEFAULT_DEADLINE=y
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="deadline"
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
CONFIG_HAVE_MEMBLOCK=y
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
CONFIG_NF_NAT_PROTO_DCCP=y
CONFIG_NF_NAT_PROTO_UDPLITE=y
CONFIG_NF_NAT_PROTO_SCTP=y
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
CONFIG_NF_NAT_PROTO_GRE=m
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
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#

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
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_FC is not set

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
# CONFIG_SCSI_MQ_DEFAULT is not set
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
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
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
# CONFIG_DM_MQ_DEFAULT is not set
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
# CONFIG_QTNFMAC_PEARL_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set

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
# CONFIG_CAPI_EICON is not set
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
CONFIG_INPUT_FF_MEMLESS=m
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
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
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
# CONFIG_FB_BROADSHEET is not set
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
# CONFIG_LCD_S6E63M0 is not set
# CONFIG_LCD_LD9040 is not set
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
# CONFIG_HID_GOOGLE_HAMMER is not set
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
# CONFIG_EDAC_SKX is not set
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
# CONFIG_DGNC is not set
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
# CONFIG_DELL_SMBIOS is not set
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_HP_WIRELESS is not set
CONFIG_HP_WMI=m
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
CONFIG_PVPANIC=y
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
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
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_NVMEM=y

#
# HW tracing support
#
CONFIG_STM=m
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
CONFIG_CRYPTO_MCRYPTD=m
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
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

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
CONFIG_CRYPTO_SHA1_MB=m
CONFIG_CRYPTO_SHA256_MB=m
CONFIG_CRYPTO_SHA512_MB=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
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
# CONFIG_CRYPTO_SPECK is not set
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
CONFIG_X509_CERTIFICATE_PARSER=y
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
CONFIG_XXHASH=m
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
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DIRECT_OPS=y
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
CONFIG_ARCH_HAS_SG_CHAIN=y
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

--lrl7g2KojMNQ8tYq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel_selftests'
	export testcase='kernel_selftests'
	export category='functional'
	export need_cpu=2
	export kernel_cmdline='erst_disable'
	export job_origin='/lkp/lkp/.src-20181029-153834/allot/cyclic:vm:linux-devel:devel-hourly/vm-lkp-nex04-8G/kernel_selftests.yaml'
	export queue='validate'
	export testbox='vm-lkp-nex04-8G-16'
	export tbox_group='vm-lkp-nex04-8G'
	export submit_id='5bd9fc700b9a9316bf4751ad'
	export job_file='/lkp/jobs/scheduled/vm-lkp-nex04-8G-16/kernel_selftests-kselftests-02-debian-x86_64-2018-04-03.cgz-4ed591c8ab44e711e56b8e021ffaf4f407c045f5-20181101-5823-1u1bjks-3.yaml'
	export id='1cc21707d0ed9647c5546f34483822d2d5060fea'
	export model='qemu-system-x86_64 -enable-kvm -cpu kvm64,+ssse3'
	export nr_vm=16
	export nr_cpu=2
	export memory='8G'
	export hdd_partitions='/dev/vda'
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
	export commit='4ed591c8ab44e711e56b8e021ffaf4f407c045f5'
	export ssh_base_port=23250
	export kconfig='x86_64-rhel-7.2'
	export compiler='gcc-7'
	export rootfs='debian-x86_64-2018-04-03.cgz'
	export enqueue_time='2018-11-01 03:03:12 +0800'
	export _id='5bd9fc700b9a9316bf4751ae'
	export _rt='/result/kernel_selftests/kselftests-02/vm-lkp-nex04-8G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/4ed591c8ab44e711e56b8e021ffaf4f407c045f5'
	export user='lkp'
	export head_commit='f03cfc83777141455bd340be3db8fa8a6f0193fb'
	export base_commit='84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d'
	export branch='linux-devel/devel-hourly-2018102918'
	export result_root='/result/kernel_selftests/kselftests-02/vm-lkp-nex04-8G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/4ed591c8ab44e711e56b8e021ffaf4f407c045f5/3'
	export LKP_SERVER='inn'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-x86_64-2018-04-03.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-lkp-nex04-8G-16/kernel_selftests-kselftests-02-debian-x86_64-2018-04-03.cgz-4ed591c8ab44e711e56b8e021ffaf4f407c045f5-20181101-5823-1u1bjks-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.2
branch=linux-devel/devel-hourly-2018102918
commit=4ed591c8ab44e711e56b8e021ffaf4f407c045f5
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.2/gcc-7/4ed591c8ab44e711e56b8e021ffaf4f407c045f5/vmlinuz-4.19.0-04691-g4ed591c
erst_disable
max_uptime=3600
RESULT_ROOT=/result/kernel_selftests/kselftests-02/vm-lkp-nex04-8G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/4ed591c8ab44e711e56b8e021ffaf4f407c045f5/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-7.2/gcc-7/4ed591c8ab44e711e56b8e021ffaf4f407c045f5/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/kernel_selftests_2018-10-31.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/kernel_selftests-x86_64-310c7585e830_2018-10-31.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-7.2/gcc-7/4ed591c8ab44e711e56b8e021ffaf4f407c045f5/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-7.2/gcc-7/4ed591c8ab44e711e56b8e021ffaf4f407c045f5/linux-selftests.cgz'
	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export repeat_to=4
	export kernel='/pkg/linux/x86_64-rhel-7.2/gcc-7/4ed591c8ab44e711e56b8e021ffaf4f407c045f5/vmlinuz-4.19.0-04691-g4ed591c'
	export dequeue_time='2018-11-01 03:11:04 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-lkp-nex04-8G-16/kernel_selftests-kselftests-02-debian-x86_64-2018-04-03.cgz-4ed591c8ab44e711e56b8e021ffaf4f407c045f5-20181101-5823-1u1bjks-3.cgz'

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
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='kselftests-02' $LKP_SRC/tests/wrapper kernel_selftests
}

extract_stats()
{
	$LKP_SRC/stats/wrapper kernel_selftests
	$LKP_SRC/stats/wrapper kmsg

	$LKP_SRC/stats/wrapper time kernel_selftests.time
	$LKP_SRC/stats/wrapper time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper last_state
}

"$@"

--lrl7g2KojMNQ8tYq
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj48z9v9ZdADKYSqt8kKSEWvAZo7Ydv/tz/AJuxJZ5
vBF30b/zsUFOhv9TudZULcPnnyAaraV0UdmWBL/0Qq2x8RyxDtkd8eDlFp664TyRWk15adee
FsGoNV0CFcUhdzRTXPevHYdBUb7TqIagSJyWGvZCxHBRKczRzfbfTfEsFBkrer9STPUF/0vB
trjEbqAwz2zwjZs+52TX5tdqo/JvnorKaJn9PQvsym6NBsrJr140RXdeiq8T4Rx2idnOb031
LMHgRP2Drv/IasZN0ezuopYE7Tt0+FA/tcqp9rGRF2ERdDrfnLwKz9Wk5PC3q+aa24sS79ke
k0thG0dU4zsWrn/0GtNwylIBqDwyXOxzMzjywqaHAA/L4wOO5kRdyqRabTPT8o+7NeeicaY7
BgYfUAj4XMoiGNaEtu1RWI3nulbc3zfnen7rVn2g+jUg5oTohxhsZrggKkQtYpjH/AiYKrTP
Ti2aSs2BCz4aHLovYJn9Qam4YdC//9tKxIyrYTlzjaFVyK3TyUrlx77r3cqTTy11u0/4om3l
ibhea7kojMdlgB0fkDvUxTABqNdQ5/lg0bc9wSWs05slg8fxVaieW5C6OynfPb9XNW4sNHXJ
Fa+qe7kwd90IJvAekQ3O3kn73GgSQ0xrVEef5rFPk0Vh6CK5b9cB3+1YZ3Eedg8sZmZGDD6V
n0n/O5yxsMZKDQaPwGgO2tG23ZtSVPK9TM4nAxgmGdZQia5uLPL9nW/ANoMp/8yhniezbobh
/JTE7aXIMBo+LcVxvqe9O9dVh24gEvNTB+tTMZKOEzrPwn+CllgzXtqLeaSES7/Yyx6BOoWp
/CMFg9V0dQ9lzt/wC+RQFPiaV3Dmin2dDaUyXf7sW0VSkD21hASVf50ZaG5Y4m3RE4Hy/fIy
C3CoJhMOrMehyERK/9yLy5Ijh7dxSTmqJC2ckWQ5LhOVTIWm0cHo9m7X8j9Ho4pAOTR4HdVp
te1Y/qBPq3tDx+yOE3jhnn0DypUZ3O36FnXDDoIyaaq7mWwQz0mQt8IzA6cpZmzTzB+qnuW6
2s2PtVIAhvSevHNSlj0jkssvGDvaqGdFPmOZIa3o6ujUd+UqreBkI6KqSAi0gS/50eSQGbd9
ibFhkrym0Vdxb7iV5D9cCbWZBdjrX+fg6DJxKDiyiF9fID3PAROE1HxM6Qswq4PNns7ZGUf9
H/m9GHoOvyjBVnkXA/mh1oitskGbcysTR0CiID1Hwa+SW4rMjH2yLktfgKa0bqpbs+58fjeB
p2aQeUNJqZ4q/Bcv8z5Jv4KawCM6vrGO75v8CK5ds0uJJqUZFnl64MfT1p3WumwG8Es0peXl
LQppsPDs0Jzh/cMHfovMSXpUtsQBYU22BrW1juelblYsc+9QyBZMhpucAHVr3m0LDG1DDSFv
3TyY+2D6oHsJI5elera+/ZUajwiL/LLp07/mey/nnDUUu1zeCcjQ0V6FY4I5+yI2xSGWW22w
nzI9IuEgVLqMn1539OPYkGo9YmfHNIL/HM7opANDxjsn7czHB80Dwy22zZ8Z79ZC38wRBKTb
llrIGl26j3jURFCzg570NY2H6oOg+VUe+DNN6kM6lSMRJOV7uz+QPn9Fy4jf2lUkbgc2jOAt
6UMrQ6YLykzlqXPV/aBi28dLoO+FZFAkdyDcbpnlsKsbQHsori7xWnNO0hQlq86B7sXsViru
vZFI56HxmDNw173hGA8NnrgPw0yP++AnhnVl1UKK4S00Rxdo1cBjtsvkETSfB40ZEkUQgtNf
uZclAY5iN8zbD93c0ib260olpQR6rYPmW0JD+emk95lA3XIZdTvejKiBOC+mlNEs+wpQFPqO
Advm8cWaqn9iYlwpOoioh69ADkZqpsx9hVOWO7xidro8NXR9mRumhFuKXuSl7Jcd6KPcqqvn
h8gVl0pgzstrzwcGAB/3q7nHfnb38B2StMfouDrUFJc4iATM6/R55uOLU/IL0M/753WCK9d8
I4vzLLy4Yvr9IN7LrkdTDIaQlBgXMNj6/2aBIso5MVBrgfvRSPRo85RJLpRzD5RmweWv+3Vi
nYGCIEsK00BIswlQjhz5/LDk1cg9Mi61sZBZEF0A5C92ZBj3Nv0QnWgy0rcFgczDAz2ddJ6Z
hFdZ3fSj66ILAQcawRTbmF3X6slPXP2nfmaZ7QwbU/k8RaYHO8o1NrPm3IpwSNaapj6hXx6W
eCUq9o3eFmRMo0h3c+x4sMQRbHcZRGfVCYz2tp5xq0st6PKHx+DSwky600nBkj9CM0wv601G
RdSpfVv5XlUeP87XEvZDoSag2voLA95vodsTaGiP3hQ9N3v87n1yAgpax6xDvqeBVywE5uHL
1vwQOxicvXh3NIMCzchmIFP28SOJ4Ua4IMDXezGsliNuCA56nYasck0oaqYyAyA4kvNxvt1b
2vETbCt8BJBNyRw7lilmQgftWTucqNySscsmWsqxLACGW+iAoy2cti+08GOaERnlSbTdlBwM
Kp2DqPU6D6WqqH44pjVvvfRSyv1iQRSdKDOZaYwU9CxRIyKSpRrprRii6RwlPYIjlhU7BeE6
WJzbrO3sV+qhgNLO+crqZD/79joUNhScJRxQ9Bafu+vXjj/+8GePBsD8Vuq2Qh9pBQ5bx5Tp
JBXcyLOUO7Z/xNq0uTTcdCC11IowniNWPEr/TGjGDK8XZbz96A0R/SPXx1IDVPbG+37Tv3Ht
A8yv7vnGoEYZdkdYYuWd1B1/aKT8o4JEPp8UylNXrxZ+kz2i81LoKxLeKPHGjm9K2fhAcZUC
hk+EflPDTon+QqJyY7EgzRDwzW/LesVYZO6TA6s4tASUHFnAXcB9Wgy8AhsvACCfUsUdwumO
EcXq5IvxPlZBDQ3ZTlFCPfHArPCk1rK3U2LLxutRUjVXE+7V8dmbB3s5UoDdPJqhfuxGJNYd
GZTNcqYoexY1gv/OUl2daUfYsPwJOUjJ4WmqRM76XgScxdwbYjEXTFeFLDmvswXjfx6EiuBe
yPC29u2VIi9GwMp140yPlxj7NWfaFytka8vfG6uORn+hYtM558wqU38AoHszOXdx1o07Hkdx
2OW0QWvokH86KPFs6MbRFhizAHlrVJBbGmAM8Sq21pjbCYomx5U4DDJT7kUjoURg4VQ6Jxcr
KE8Zy/aTHxO+Xm/HCFW5N8ed3zahNO5QwSMd0972Yzu48qnPhiftWRcUt/AVZTd57jb5VuMp
JGYgGwXBY0q0TdZij/GU2Mp4b8Wj2Isc3LSvD8djP1glFn1Z9qeC9nAicWyo4l3G5V7sOc/n
huNFu1yETLjpC28X38amy3TZ+DR7goF5G2m73889XwtUKdFaLcyJgduE8xiFHtlDwJYt2Hdx
sEV6yZ+zRyptP2LzdHk3yMkajhxuod7s6PY30JWskKlsQN5vaPyuju2y7qvAunX4pwA/dSp8
ZwXd79/iop85gE1B/IAwCtl96O5QfE6KrMLjDax7EpKVGnUiD2D7hpaDwZnLDw6+JztHj10X
cDBCwoQOL+HYA7TYzpPQEZjLJwLSH/nKCEfzOf3BfWaeX8wv4ANcWbft7zMuR1L8nkdVnfwy
9AN3hil5zcKcQvpC25T4ZK+pW8UT77t1QSeZq/qvbUSBwSBtixi5Ccbipx8am24+7VF7HNOn
dlY/z0EZKIkCZI+f4yi7FFLZB+2hlO3Oy30hB0p1SmZ2HakPYsUFvA086uOEU/zuQpZxCG7+
YRhreMGKdeAfgI0oB6cHW1QOsdMnJeX/Gy67rvxjdTEIcAhXDUqRZb9HQ9PAGmeA+895c1Rb
g9Z7XCOdmhjH63TEhW6ybuZe8RuhA/Jo9mWqQgKBYTHpICojt7pKKCK6a8pSin8rpeynezWm
jQKdsk4R8dv9ks8CHV+ae6KJkodd5+gVPZoBCZ/ifHpxeZ3mXdWYkMt+4kQ4JBPgNxEpO2jI
RHWNGoXMGlogzvWexJYwvxm72uOrHpI+K9S+n4HczXPiOq8OqIntxtxHTexFcR262eduKahU
vdzgIlQSY9qLMaV6q74mOiKILlvDDvHeyM+3Sn1bVvCdoavsBN+U9GqogrZiuSbgDWwKTgap
3SFNv/BOouPTIh09TGz0Znr/TPy+3Ja9VnZRxappj9HbSHnj0KOZkrjW287hObsyGIRe5lJR
6CQwBn2kmxbdl7yIWn+VLfMnfY7n4l5/uf9HRoozUXT3gpOcW7kLVgPayfLetydxt2j40Az7
uE2L312nHd+q+C6+dxZx4BwTAZ74GOxcJlbXPn70vmUZOAQYfOh6xlyspy/707gRWzRaBZOC
CiJBH3+hWfU3d9wEY9bMvmeD8xOS5LkgGAdXR9Zxg1tF4ePWww3E6IoD3pnbEkYIF5yAHtvU
gPi3mVupn1OgqvqYA62ADaj4jjarSTil3SGzUHEjB1Kd0zpH8A96jfqMtaJ+PTpb0CGJ1qSF
ZY7ekREgFlGJmOvvqU3Wts31ru8ppoaz1XlKWy0N2bvyyIb3kyDpBN4uPxRWCm7EsbGPZely
RQatdRJsd2n/MDXNJ5x6JbhgoLGM7Kfn3XaClw+pyD6HSKMhC804jvkM7IuxI5oeiUVX99gi
fuWnFjaYKPVWnFcbmVVvJhuJolj0xdmBJ/xUEem030M+4Nh30/NTnZqQDJTwd/PbVAmhQEqS
7AmBoKhkqJ8+A50HTIK+Ja9ZZNijBb5NzXbA8igE2bUFLlkTK1DMk6MuBbDcZiOHC4UUf00X
YPCCT/vmLshTdEoGvP5ivlZ+GrGKhR6ZNBAtUd6u36p8Tv4uDdjr8PfkMDQNEItXvxbRB47/
FUq8YBCWY3H9B9XtaVfSXbW3S8hQ69XGnLfvEVdu/26AIpOGe/o9zaFRihgLqs45M5JIdNFL
/JtP5ws96k0A8n2sUp8L5VSfrqdq55Fk3yWWCXd/VDHLN1ni8DM4qD5TEvJTLAPz/2AXIWEu
BlMMHjMrLEMWYcs2/A/SRhRglvijIOdUCQP+Tr7svKqvSEnTHLnxyy1JFbe4axSYIfSucGHP
+bnuJ3Z/NBRZL/kkFIi6yJhlW2Xr9ISRW2asy7ex9T/0gsM3GKlZ2x8eTUmIoKeZAyzZOque
cwv84vurEKtSTFhoXVzn2KzWP0rQP0ncbAg7G9+YpqUyzQL78hR/l2x0s4/YKySsmKiI2BXM
NJfrXnF8EVXgaR1OTrEANUrVy8akOTCEyw7ZR+/uSmZ2MOAwXudMc0uN48hWCV0HCbMqN8PY
bWUBWDgLJbB+BSIFJqvq0mHgeDkE/vokeVgasIsHiiVgZp8b4Bv6XqH72yPBqNcdkzNrTtip
CjCPsZsndoZ6IkoYV4/QInvW0XaJbPS65TH/fVWxHWewySszjVl9+DgvLqfyA6ItHV2U4eFj
ZmOHOjVQQ0b0lsojEnkiXSDfa+vDYFAXL2aAQBPNjH28JhyHp1tDfm5F1LDwMN5wSNHEUtZM
hreLFbHjVJHzq07Vh0MCje6U6tw+Dd1G+lNhUcvVhr4Ouz/pMPo8fkAdro0qEFEebbvEe4S2
Tnr3iOXO2zJnIg+GsJFzhsAzK7CAGeRcjlTR7DJgmYLYoNOotuYNskDbm8JBpU2Hh+VQavnW
qdxro8SOM2YYrznXaN2tr3wgU0sIjdZuCbel3wnYPbQ24an3gUohTtQVeulcSnB72/fJubam
1rOY5ynggDyb+uGB8qLdWiCs+D4wkOg8dUNUTRoK4WQVVTd+iZwvKEtjpfmsEstv1WFYXh16
lJ5Drl2QG2x7631Xr95LitbkLLVEV8NOU+A6I5imnbMzBUsi7SY/UfrrfVPMkyVqfIJ2BUuM
Z2jeoe5pWk1d6EdjYBpT+9pvQ63pPXRKCp+5yFU3kbFpsPMRkV/aVMwgtsNB4tk1zuCZfyzi
U7bCaNWW2d1Tu09jFdyaf3qx0BjAIzH8+6W50Vcg5jzlJMVVx5fLMY++1FFwUgQMe/nOmzq0
p+2HQoZTnYnrVlWFpSdN5eGxwu5Wp8bKZp07Qz9eqiTXLrqlJn9Wy2Yxf80AhJO3+qEHd2Aq
ZpAjAsHOPB7HxBLWqcpApkxma26S70KTgtbNHxrE8slO9fTWGyQnaPxxk9LNckgeiQOydUeY
w+rO+WsC46lsgnceQn2VSkPObNqd7+Xa+BY9cupP/4eNTyMfVsKqu3Xk0pIfgefEwJAgZmPs
TdH8V7Re9Tvh4I5b8MFWu9yPozRW/HlyB5LS69Vq1GItv6CN4abbxK+TBczylwFtALGR4CoK
AnhsrZ4I4jxAukY+igseRoA9i+4dPbenQuCthVZmHcAdxXUq8hnZt1WBVTL9duNhkCaPAqSB
+NdLP/njtQlLbrj31PnfQMe7W+KVnXheJxi45MG26WDyUmyRvLhFxYS2ewZWpo/6ce8tys/G
imF4I9RDMvmNvi30+U9Zy7na/x8m5ynInjJTPTuCbY02YIW5/mjxac4aQAK+b0PGSrtEarbe
ormPa++bIWZOxIqT/I44XRMqi7z/ELDeNiiw574eVttJ/Cp+kGhQCV0bx+Yu/pfCO+luV17h
pRDh5PV5gMGHHOd9VXuqEXOhKdwnLjssvU6rT+X2MZc1m3DiUfxiZeTnqeX+c8104GDaSN/z
RRv/Q8raP3/qB+wnPA3UXn8urcjJToOVYmMB4T9nlT5OeMHubR0wJVN0lJ6HXpP2K9Xgx1TT
1lqyftB2hxJUVaU8NgwfwpNND7qhL06rh9bkEWh4nNQa5uSLFKUG93gITlhL5ez9/5gP2qWu
s6iJWQac6DLhiqCYY4qIgJgFZktt27fAjY6sRRREYr4Xpq1c7Ajn3UbcLvJGoOKFcWpRJxKF
0u+TqFh6RvIwp5GlxPFFrl4NWpk8Rl4wngcZrp6ENkfrh/Pjtj6DcRfs9FKQyinKqMe4D5Jw
9abUa/ATN8oaUTIwZslX+Ture3L1ReCc1AYU/yOLsNAoJ2ahvPNu+Jlx4lWJPRN1m0cXGJ3p
Kg1xSWDeoGF+eBeDLYaCLUJ/DRNha7jSLXDhVaDbnkKwta7hNxPnGAHMVfdBHBEpogDmhf/b
QehbTw7Am+J+KDfFXkfkF5DBvQbWL2eWnqHR2LZKRmTBLwyIuCSlKucqmufaqog+RIS/4z+9
R6iOjDV37NBes8/YkSt1KpvB5zeBpRA6ElDyKXwkYzEH198H5Z56+tUvBuMsgRlPhFi0X9mn
evFYti0drSTkxUY8PQqUcCi/kTglot9UNnyxqBdPbQt7hLI9XgBitOsMQvin1H1fN3PoaG9c
oqk5f8L98mog0o2tlqE//N2OaLX6A/crXKB0eQlkj4sg77Ves9zWxHfDoybSlNBET+jRUXzO
TfEI7+maSgekD8LhI0dW+OjdHc4Z1HCIaihXLusW7kT7/RFa2aWx+CC/mh0M72+4UQaHGUL8
fFnScn1MqMPafyRKuSZhVRGHGRKLChL+8MHN+CoBonrT5PhcZko5Q3yHBWYu5mShytoFKvWQ
AnXdC9Sg5mWU6+DpFvmkSQXul7at9R82IUp0XmXoj/KHVBOrrDy2Gc4XRZMRLswi4TzqPFdC
1CwVwzcjmYucFLjSW3Qy4pSyVsjOvedlhOxjHWDOXJWZ/ik8p8z2+93Q+hx3r403VJz4CjEg
QIR4j3zbzTuvtKouVEX7wNpabf73BQUNM2mxphafB4Z4hWMeVIUJPnfrUFSdUSQcgehvotuJ
1Ql+TexrtiWunvZGyioHHqr9F+byg8x0z4hu5dWe1qxkuDw1YP6HO/bRdEWIFDMYDk330Fls
fTmbtMUfplHFR8esvfYpUolIHkw6Pqyya3RyOaHTbFjLPQc8vLq+ngbPO8ZrsUsMoGM6GAqX
ulpeYRcTBfoqEOcR78c3LVggEMo+OLmDuuA3IVZ54Vx9igaIyaLKGZskzEfjtirsqUB770fH
l4HLfxFrzOUh+L37nAcHLc4ZLo8HJyaOMGLyK8LnGEil5B1ejiOQfdmYVQ2hDR0DozQxC08h
8/qmITMRexxaDsgHkMU0B5euHwBYMGm/6oDGRVL1ogkoFjGMXKtask4iU8MC0S6d+Z408Vpz
me2K1ciBTTjK/RfN0GiCZ1ZRpP4dNVxwq2jcDjh6Iw+rk+VM3o8VOI/spFV5aYBt/7UWTDyT
O5y75FGpdeIubSiytm24R1Es8iD9IGvEwh3gwMWqSo6cwCK2YkqKT00u8pSvUk+va/5GH/Vm
8ZsdRa/mEaBwWuRIhTcQLSnwHX8mPEb/rqu8CQpJ304k31XxIuUCqz+naL3Eh3tgbI+SDXJl
S9HozZVjnnSd0eBLQs0R1EBtTwzgypQmQt7be6dti0zoGeSYh4/3vCp09s/+NYxgM9ytOVp2
N051Ir4XVtKrop9Nn/IqJhBHh63hpFZPy2loyhCRVJ26pUUjtTcW5HT2mbqgd79uQcjyCbGl
zBfbcQJcpc4znGa7qKqCYzL/VcWI50MuQ6q0KS77XKhHOsSPnLM5bs0EWaBzfMvL2e+L+zm4
E4DHdll87O+sUZVwRSjheK0b/abwe5NcMVzRU5XGL8pSkdk3dyEIBJyLhj0smiVIBoRoZVT2
CEOPphueV7PGXdsB6GcQYXOtRhJL8H8i4E7zM67GZXp6EPB4259wqsdHhHFli7+GOdTHz6rU
sUd2+Ba9CfYX9ZF6NZTUs1ZaVMMx7IDP0i4Gx50aGJHRwqNd0suSbf5CfQaqRzyVcUmSdXRG
fUl62nkZ5xqn7zmxhk1kdVvx4PSOHhptkkrQk6F7Pzs8SyGztRDa/qfMOSiBAYynx3gDyTyC
5UqS8YTlgm/Stfl6wwUtYas6X8otlJzmTLQWIHWiJv53EIFU/1ZJzVxHujS3ARWdFDoAB153
cOEBdTyOLQzYLfH+xD6CS59MxUciURDiJHFjcLbdVKXbEZW2Yx6nWKwq0A0XmMbeiFH1jg2v
/FgZHr0bYo8p2NZ2sZTR+SlUau6KlMPKEEXkHwJJU7loUUpUJLJz25NGOwLxrVnfJf1KhB66
rvlJPcCkxMJJnE819QB25LNR9R9ZrydjTrkj4kga7ydiiYTcHmyzVx29lK6h8HoEq0dj1SED
b9x9jTPH9cADWkHJwJBL3L9xAdHA+tudvmlYwzJSPhq0CCVXcJWdVsrkmV6CPI0ZpJ4rm5E5
Xj/9c43pu6+0X7lI3fiu8Qx4YmXvCAH7FN2tyirbMFj9SCXVUDO0diYQbJ5m43vrvI3HmSNK
wlcvQuiXbr4GScGCBW2VFG7Y+MCQArj4feX/xoXTyWU/aIcHAsw54L8vVroZlQKsD6+i7KH1
915j8u3BwFQr7qt1jrRu6tdgMOVMA39m6mLUlf/+vaOWt9bNGSB1w3cszpfgSRTWQXW5uUmn
oV7mupcZrllS0n9KdCQUAzGf7u3Zg2jb7C1CSSjnWQTqZ+N1l3TGt0IrdXHnDtoPwwWRkHtb
heYxdp8/RZurZxtAVU9YHZhZFPcjbbhsT9IHqOqpNk5pLqo9OJrXHxzWD30+jjv2HP0mOd8K
ehOi8p5STYNG/ZWw2UC6nRuliRfOp/g8E3rUd9v3iEMiCHqHsd3iND4Y0CJ11SEFs53GXuyb
QEjgBWg3uZkkxPYrhXSQquO93hIoz7IMG4S8f/H/hbQath9FLMPf9fuXYAtCxugRHo/+/bGv
pBaxNveCRZX1iAsX/mhqzpOjY9FAhMAOW83oDMBdHz5iNHVKC5uulIHrK2Skve6p8enjbTDh
BZNMgkzLAk7A2dOOyGVc3O8zo8sLvWvIOIhOsZrFaezk/9WfTXQn6QcGnbzbZXmDhamuKuZb
JCKdFmdU2t7Kac+EfzfRfMUkBzgyUnq3TEYjw9TjdNT0xpXFMWcfP5S1JiGtzb3mKF92VU7R
2x2+FiQEWS3RzfvYdELTvV9nCGVwo/PyAjRjhOAe5RHvwTpXojllP9Uz+OBqZt3aw/vxadjH
5EdtmfM3mKJV1Oazr+OfJ+JQZktH85VEy3610zkIaEecAqTy9s/EBMpJWgQ1zzYcV6POWpbA
eHZwCFQr3ZB3+YGHX6byg+IdJhtattk8mGissbGI/mVJ2h9c2AdyF35xXhfXFzUp/CqWP5KL
K42CvUfjEjjSXJrEa0ebO3UlTIgD89xto0ULVCUJDJWfSz96WLoqXOPQTETV2Lp082fo/FGx
81d1AXrVJe7SEgfIafWOfQVor3+SBLCkvIrTtBKHdtHkcndKk9XEV5j0BQlUaCIUPvtf64zj
9yR/+VDpWTx1VXaLGumREbbI+1Syj/PnYX/5ZfYobDAInwnQLP4JX+bpjmsEQjn0ddxG1RjZ
HrA7sdtAOX9RJ1XvRs9oSmCipMzHGs18t7RmOCGFXUgk8kh6DZ4Pskci03KlKTvhNS2IRuIm
AsPDzWhr5b1zN8Uxw/6SETpRCK8fvMFctMEzsoyNtDAoVGlB+02KJtP3dcuPgmf7opa0egjv
6IROoJqmxlqGRI9rdGrtRYagFm9UOyYFgUwzGHBAkIu+UM8rXCK3S8rqVWNyLYMI/8VahCeB
KxPWqaa++X4Bhc9h1nQuRphyHbWEcOpL4xgA5Z6YBVsIdpeovvMaulDtI7MFetWon35SQXZX
dF8kaFz5M/x9d3vRVPptlXM3wpUXWxVieVCh0aEunGUsmXeMscPSihuXlQsRlfTzLsmRZgYF
z2QjsAz12NYjbWfM8LAsEEOD+0cjs2BZegvbyI2/uqgfxBoJBdYqBZwePtSq9B0AoDGTLGQ9
OPSFy75XLNwWJGxNPoSrvRZWO9wR9suRhGvJXVVHcKJjmfXlFju2Zlv4Q47v2VmYJ0AF6i0P
jXbIqupPyhm5DjOaNNdSg5hiP9FtWVa6m3NPOsiABZvovoYQm+DZUknk6RMk3ot96y6THnwX
e9SaOsn0ZF3/nGJC5I3kZ2j9LAW7XduVXvCnrm0FIU38mpkLNBVqVC6/B3EiIXIcGnLmYHO1
C0PkRHFQp0yX38zO05wFucBDUfd17FdsvzHxfT/XYQf0KPiyabIj0P8bP2i4s1Q8UZK4ihC8
4EiwEDJmhqE8t275gVhI4b86sdFsPbKzSNArfbZa5Mjq8fs/dGC+WxKTkGlkkYOIP2uQ+thx
QAnEb6bccqa0Rl/2nrMztDYrXv0NSZn6gPVp8ecs6k7OaKw6F891uYloDzGA9mAKWWLL/CaW
CXQi8q93UPpOqnXCxiRWsrQVZbQdrHeusECQ11QgaOrzlDQVqAfvg2LNvj8JRFbXeX+Wv+cx
rknltqr5wuPr2iyPTSD4n+A7vGLh2GUvql7ugf+majb72RBUc30LB1XO/KMvUqme4S6vm3Tw
GJ7NblV00e1PkRO9yyRqVGF9lVN1R09dun+kK739hL6b/9mBumBIVxPlPxcFRjLBthagUXMZ
RK5teghFRm+uqQY9AkHrYBHsLGyyQo2FQdXyUh8cxPcwASqN4Vg36+BOR4xKy27VNjWf7alq
Q6pJedn8PDKLTS5T8IFGbVKTREPNLBFr9Y9futxeh/q8pUWS2aGymZCgPXUfcU2iPUA0Re3a
xcxgBmRo90GKnrEZzjPMLlLnib2q13COTiOcWOQdCPN5FIhLMxlBzxMJbihO8ZwVybybEfWt
OqlyqeF+wX1b3ns5kqkiyJb7YgNyLg8qtD4ob1sDEfN8vd0CTC3I1H0eCByZzEXQkXjXL+4J
biYMb8GRc9JApDmdT65M0DVea08SGy/e8+ewsJyA73y9Buhh3UiAl6dxc3GCZgcjjoRVb0wI
qYt6FbnAAKqIivgFLg3M1RQ59Unl1QObZsjGaF/8Bva1vJK4hsyvt+21Xg3zzDllQVCwkDMS
p+L7G6E4mZh0ei+mdwjyHfzyTAaBZ4ayf72l/2EXth8f7xJyCYdNU5JkzAM8dtfLrl68eztw
lv60ozKrcXEZI4b04SRJRTbb3WwOzvYonlWlI98DZKC1QKFo832VnxWvp2VU5rSazy3aG9NA
oXu1tZ4W1XP75xiEZFeDdfZDUYkUyl/mFgQUe7mYTsWCe6GtTtoB0eV8JJ5+R/xe/uUVFFra
PjcWnUKIMP+Ur/ndLefjuioWaeD26ElhMQ4JX9zjspCsWzFkZtDSCm63pWjO7xXXHKcOn10z
LOwhdqArk/Idm35uM4iHWAr0w4rJ+GfyMt/vOBk2kNDVtWw//hoPX4XYTQfII3CGYMFsHVBh
OTOTaWNBc7n2TCCBnb4orqg9j7af26JG10b75Tb/ZdlgkjgvQ/RD4edNMHYaGcvZifyenME+
7hz9c2Y4jwr9t8Izb+3sQGhoKjqqAHSgSFK+2Da90lPFMWe974qnLHcWWWNuayvBGEI/pl6s
o+mTjhsyfoxptFKKKwUGoggI9/fo5vuvtxE5j9fL0BEbAAeXRSQQE6/v6BxgDGLNlPQ15eDm
XxRRsBmpV82Gq29igSLxd/zg9du87Otd+smMeYD6gWnpjNR09nOSjTE4i9zHwo5x20tNAFT7
cWEKGvjOgrgCWu6OfjDXsACcapNlgck30A1iAAIziknBecUMHHLS8yT9Amiy81mtdy+WR7cg
pudhyde86vRWimjD4N9mJgCBwOcLut01IN+PrJypXL+Vo23jvcDEyfVsjIIMk2cbDTdnkxfi
64nfj14LYasWicjKba4auhipJ28ESJMvSQ+4ZxKGkSNJ8Z34EkQnKlqjb6GZiN6mPcwObxNX
/+G5pxlmwBscVlC4r4QG9V8y7AP4os88IZq/w8GLja7eycAXNchZvJx4eNfgBANAGhbHZ1Yx
ipdLYBoTLBTR6f+mkMcw697OV2Om30Gw7u4DN1jh/FHPt7lwqyMchq+ZrHTi4toBO0iKr5UU
Oh0OeI5CQ6Q4uxcLHMpzme+ylFdXLCC7CArjcRhLnlazzSD8JqHJiUj2L6yZg4Zq45GjCyXB
MY501eLGwoJIOpdMiwhyGoisNPQ4a2z9P+knwGRtJEY3b1yXbjIdfRX4GMADDr+3+VL5hjRS
S6p7UtQD4D3jZBKshLY6taQz/gpK32uep4lPE7+suLKg/qFI0C6BGXUidp/n59/y/jRHq5Zt
T6XTKW18zc5Jv6SfICoxBsfDd1HY4FqaCBTRpu7pdeS+2hnyYlFLLqifFB6I/yjdl55L3eRn
odOEWpw2yXGaJC+5zWwpYAQYlse/ebtbnN5MQYy8EBURcxb82YWJToAUAkaok6G0cgdNkp7T
O6oATizJfTXh6/Ii6WgxOg/RHzj47ql6s6x6rsEYM37IBj0lbh0ezomJzmFgjMyu6oV/EJ0Z
pKTUcF/L0RLymEuuo7zebro3S+CKjD1Y13djHFSdm6EqW8jUcR0vbOxgoXBwjt025bXL4oBj
Ez+Ep6kWMHvw0aGows9wEFLDzL3cxlUrRVaMyB1Bcz1o0yuU0uxMMs4gTgmOgnABGGEdxXTa
hUyypwIn/tsNEvAHHFDtoXfXa+HUhQVIjzEYe+QHTtP7iD+kpHJlGr6QS7uAEq7hKAn/Q6pF
DwGn5whKh+eMSahcjRt1JZOHilBmYyaJj+nX+2IrAaz0hTFMalOtf81P/NzAn/vJCqhj/w0x
cLCwobk1zKGIXiCojKhkaGHRqtNPvkMj8fwH/0ivHNISaa9xNAc07q1BhDlW+pEwYDjdgUSt
9ZaeJg4cVSwCT4sWh7f4FpscTyq3eja2o+tfTQphTYWU6T/tJOrCLpcS9wqVSgD6RZwH62P/
K8317YrY2tdS2fWxvxHr3+sk7MM/jU4iOTmx50sur5RxFkdeoa2tGxEZAznWDdxrWd62OS+v
o3lmKU7g1OOibUdtjoGaMZBmr0bimxdEJmWDu7qEMo25yhMiY9U+KAjxtNP9yaC8k8MtVvrD
Hh3xS7AfSeMmHnavP2yBJWDJRng9GbDpV2BRBjXeaVW3jEUHwz3cD9uo2CVL/H+P35dMGn2m
/XD900D/1tmLmyokdiqaZA8GqojXvU89YLDdk77gx1XMlEGB00uGI6XglLKL1IvIXJf3jxsr
1KyxceSHphm845bfYXRihcNg3U5O9kl4e3gIo9ngT4KjJ/sVOgl5Gl+Jb20xtml8tQ5r/ZEB
LAk0zO0TQ6mjGmQePH3+MDg2YxIvSQFAZx7wHd6Pxh/UAGchGXy5hY15X0lPhgEECapHN0yQ
wzH3BAU51Rn7wCjiTzHHP/DB/8lQ+kEHq6oAbeppsrTcy69du+DEc0modpapF6YCnsEWMyB0
LPTjHv7UFTQqtAlXpVDIS5U32Q6GOCu6Zo9NE8ARx1Uk5iZlD5L/bRyJaqWrCBmpN6dr9Hyp
tYO6f3ahx3lDNdCaYTSoRfUHcbZve5aHN8WvQS/MYlkK1zTiB8oG70O9vlOits8QLHLLit4I
E0jR3Bz6/iGQvQxXkhwXVYv1Foe+B+qy0nKAkRG/MTvqxjYV9MtKEN9a3ETH+mF/GN/r04xq
T33UOn7WIUcxQsqQGhMNycBLml3VMxYFmQgeAgaIP25UGWSvmfmtEd19xQsyDESaxRpxTGYI
nuPPPhD5SpN4LVXUP8excYVH/GtfZ+wYFQt7HLlGm3E7Uxmop32kSk2hiFAViwoFH16JyFcG
24m90ONJ2B/JFZthiz1olXXJdEOGx8QR7Co0Y9cB0i9wSHJNUMkc+6ZgK2zjlONc2pxbME8C
/lmjcJW9taBI8hn1ZZquJqi2/+N2nIi2UaQDNZiq4nBitQKjrNvWo2WZ2kleIwe+oFwIlYpF
t0zsun+wEoXmLwGFZusJ6ddDLpvXqmkup1VZINFdN85RTZj0A/7lnZIPpzvizOSICSXFhptS
ZbtU6U8lzPDR2x9NKzRfjMYpukdoAtWYWt6vG3bqZlsia+QM1JLnvA4ZtQbWLyFx2fYyMyad
dDX4bHm6diPlPCkbr/UpWpJeEhG+r80JoCVZ15a2HUdsoNnO+DG7UnvV9ifgDK9ZLyKbtnvs
up55CJi4WvkEqM+N4DlQCTGX3+27kqsX9SRaImf46gNwnBF4pmgfYVpKPnLmcVYYX2kD2TgY
C/pMrJtMTeM5vBDC3iyH98cuRTDs4+wF+HAahPG/LaHNI9Nay31356nssQ+UYVbNf1lWsz0a
xY64/WGQYVraEMLW8zrSHovY+ZTPWQ6RzBScRhnvA/81G8fVcfzOg5H78q0yVt0sDORN2eHU
sG698T0GE2oOEifPLAmSrIR2RMSL1uhH4BsIVwtuTHNDLGt9K/YdrG8AfgMRkhD4NmcrhM7P
puXm8tOrfkpD9i3+XhuPiby8RWnIm+XQ6vRuVJwiak8/QsiIgkSCCsjTLP7eAqEDbrStFGua
ri5KgLMAaug7sn6DS6AiERCYbeueF2+pUHi0/yNVyLOFOvXSBjtLgnG1KInazj9gYR0wyeHS
jyghdpxyar7SeWvrTr0zdwnKk0MN35o/DfP7yuR9/+NrF4UUNZ2fKiEPiPFaJvafwjDnluit
Zyzzki2JTG3e87c0wJJ3lCvwRF53JXnh3hPez0ZdqMfd9n579Bh4erDHnXP58N3gY7L0+5am
0rZ5JMPy/jIWxtdqbENE7EsAnEu+ZRH3WRH+6MA2H6ufTFnmQSiatttEdPrX0tJ9jK6I0DCV
CRJoYoa9scUKW07/dxAy8mQ3fFHES72FROcskdHkdTb271VjF8Iz8aXsUsjnUFawcS7lLnZz
65I0vWfKkGyEdoeYupsmywsln8vwnBezelz7KRjI43PBpQ92UkyXQU+dUralkaMJDATLtN5S
yPDR0S9DSFj672OZxan5zjVWrvVC5d3PuLe3cdy2HHYDKNuh6pZE/cqIarFoCCjan0eCwf8k
VtAYFP32bwbI2LWHq0IjvCl5PFNJCJkJMo54HUDojyvmKeIkjL1l+WLVvKH5vNEYzu/dLRxm
55kIKXDi6FqnXFqZi4qS2KHSWrOrSWyYXw+De+ZjetQGrKLEJgz3Jpx7WB1a1BEE33yrm/Uc
jpk6NxuvSGMTXrje5/SEHmQIGj/IG4bzwyFIkerDe+rk6Sb337armsOP8Z/i5JzWKLulCUtu
iYJ9uceLM+nEFq6JEm1kXIJmN61W1A/+tghoqsoTo70tWhiTr3ZFuhUv6VKqjcJv6QLAAFdu
m1tiJlJhMt+jQNc8RXt4SmMODbLDjxlpvYwRqbmH2XH5f8TsY5SlSaU8N9joUPpcXvgCuK14
yZmX1WzjsSFZqq9vhDVuxj/TtGxSc6no9xjQgRI8kfSwsUAcdEuwtlEmsv7xSoPdI0FpwLCi
jUSwBysX7LhAMDL5M8nELBbWLl4mLWU/JYovb7Y1FxXPNOGQf8HuhmB4uvlaBbwLugGp2wY2
0IBGl5/dDAeG2g8NeriTjumAxUbCtDK1K6NZkEH6ntoMXAx206g2WY+feWGjyk7zdWi6O6th
s3SWtvXWJqYNBs+Jjph3NR41c475rVc+dY5qWleRUX1xVQGCYi8HULMnaA6EJ/2BjFJOfhk2
dPOIBAHemS0g8DVw2FlEmH8rribmy3N6NNKhZ4SLFyNiri6uqbt89zOe2R7MKaDR+p3qwJQ3
TENRK4rmBQbR2EuUG9rBMjAQKxsh+OA1qoISkH6gjEAq4qG03A3lCefpDeJeOJo1HxszaQ5T
Ujp2d7mwzpca1v1acHv2moMFSfkxRnDNn0NUMHj8F8vI/UkI9w6pcbPiwnEBkG/+ExT/f/gj
V18abLb98DRE1j1Ele/k4SJeFxnUiffMm/qm78FmyeB3BOCrAZtQHdCCrypyP6E6JyMB8tqs
VyH8ycefsuFWixmzC4nJFTNH0PGjdyqLA+D4N43eMzSHJG5jJkf0onryTv67IsgSDBn38RRy
bBEDquZs5jrKDeVoXe2Oxp3s21ptLYXiyGD69vsR0sMPXg4g28ip1s6xx+MjrlxjPngvE+/h
U1p4MsWzMwdZK/mVWa6o46fWMcQvvEMA6uBTWK02dgm1NSMsIm2ePCud+/JNT4iqa+KmwPBm
8pnAJEcB2YYVZ7b4v0K3vG2VZNLJNri1v3t1K4gNuN4bT2K7cWKfspqKp+lnczGZ52iOl+sa
LPjvZm67Rer72XQVlZEncy2yTlgSpfRXmY4bMaESCmEZdTqLlBn51xPhaej+tF8+eXrQL+PZ
vM9mfOaoeOAOC5NOdS2OlXRZNO0ulk6LzChAdofD2EmlRZ6dFJ+v3EH1aKN/6BcupfkybTv2
JGKD/aemceYs6GZ+P+roj3iv826wMPmkdJxpMtdgFr/AbzyLqWrPtjWpTuVI+Zsjq/Dwb/me
VMa434Y2R/oBVuMPHTHHkFJBvl1nuIE4RPmnbsNfkB+ltkZdW9ZGWm8r4cRMTIknMSsabNwZ
WiSNDmouaStrvUr2CcZmwMTDca1tjGZLk5A2y7+VGfUFZ0cuqZL5KhPguxlZmt/grx+j9AXu
XIdmowjDEPVUWKE14KGxm7kFoz02xn5OIpQZbbgqcGXe0NUAMv984T9HnIE842dFFZu5zAv8
zNE/Tjf+PB0fuSYelsvG3K/Nl8mk/Lg8wFXEmPo2t/bDqY4f52WFbJZ1LfxVUVnfHejugwmg
dqlaI1ClCjN8OwIj3kYmIZG0UEHMYu4Pr6sxu+dNrhi8IQAzG4KxSax1y9UEdbNldbqvb/in
jSWZ1g0wCNWfqleEly4d5VepYQkpfuTDnBNLHqIOWyTx+pD8PHzLb7n2PLbouB/PpLPqX43A
htqLfuaUILqn1c/n1CPiGQnO+96LnbXy6KidPALXIVRveetEX0P64r1vanuxMXVk7qscCvrI
LRu2f6MFJBG9hcZGcAmR8OcPD3MBi1Ci5sKNVnMhPQ04vWvjJ50LAiU8wor73KGJAI/J87Fx
8BRSQfL6FoGVbOWKA/nv5EMnqqlq53sgehoRkVMZ0gBrButs6q5L+TLxj++94F4hJXRx1l0k
smWPiGq52V5p28VVdyWzt9qZnBl+tfXDlxgdo1TiRQ9JRHRZZDWxLOcIpCtx1iA/J0me7BMX
tFmI9SGqze3BY2q8P6TnkHaIQeOrUETbGpno2LD0UdyPPC1jyl0pMlXCymJWs39nYGPZ1J8R
7tmtOhW/ANHNeIiYrJ+I+3Q1BZvw81nzySUl1eycn84gPmWmxaxKNWSq0Y/1NwF6d5J1F9Dz
yuXyuJSMEZKY9vmPx9njGM/3gMb0hUppGwYMwCXLnThj0Zz6xddYtFA81BjDEgilfLoRDW46
y6jEq9x3E+FGofYBKalJb/BBItkdC2zkH5dd2UNRqdvR82spximEL43xlf2qq5O+vvVt0Fbj
qvF7dgu6eJmyTAsHPBSq2Wip+Ft6VWMEo42L1ra0rONkB0eU6z/r1ehXePap/MtVVyHRM/pM
Btc9I6x3rLMk0OqELYaSWGsBHu285Ehe7nP2azB1nuIlm3RrIgWVVD95y8RO1uSZcZHie6kT
MIKMoFjDLNmsazp/mI5Sd2PPVvEpgrRKxunOe7H45BVn4a7+HYkwYOD8mPy2O7tRFzgATWK3
Ju8IVHArEo08zDLNt9NS2RbI2ob5TtnVnvcXelFua6XiaLMU9JlzTXu512O/bKWqCJ1ySS9J
c1kAuuPq7QS+Ds53N/kzgrrTwXjvRG02HW/iYyxQGmpiTJd1lGCty1gGc104ys4xLQoAJxtN
4G5HJeT9Rpd8zkHybTPJr7ym9Zu9AFG4VNPbfElprWg3hQ08PPy8PmmQth+iQNXNHdhb7Jo8
DFSeL2ZkwQiscH6C7bLYXSs10ODjgg9oL3IXNjwSttNJNrXZsKoLaHDVyNQK54sy8FC9abGS
CIF6+LMzF5fvRstrU4d+9sCwnraEpxRVLLMMPgeqVATdB3eiUCRo10JinFaoqgIgie/iZ151
FTWo/WFzesGjvO0Uj0UrkGYqdB6MWNfODvdEm8HIk/6SXrzIUyCsgzhEE3hXg005bew15NJA
EfP6TMaYRHvnCclXfGtmLlI1TqYEtxKoL2JZETk6FCl2CTYAhTaIbUFbT3VkYBpkeJAL+z3I
LrtyNUMnX3NrFFSUR794M1jyxIRsRZpAsA1SYH9qzdiqRNctW+2CtJrxr3o07goXrfkW3u8r
wE58NGWF1srnxGOY4bdLlfEIRv6ecXrWx8wbDe/cwYqXiepe93URDApnuWUPAn1KIth4BucD
JVjDZ4vdA/iPBIiR5mLnbCs9n0NpJvS/nbSazFag4F5MscWBvNSjzyyXuAGLkgAoayuNEGOm
MihtyjXlJnqiFXOlCwrzCbhGIpS0+XPKGW0nlubgZyhp/KFYUnIWdTogZym0zR4mm50riEYF
PSF3rVR1haAdFOEalH7lbf6XrJ8QiCYlw6DMNo1v+pjRTJgRpRHYpcQ7PyhZ4pNR3lhQX5dO
VfTN+62uNqUrDpjfrzOclaWwuivEKFq0+EJLvuf9ebKlanuamnARqQr0Z1+ggua6cwDbGC/v
9lMUIf5OPQshpedzCsSaAwR4hLFADNLqE8Sp4ghryMz/Woa2R9/Qgt7iX4biOHAd5nWPhoHk
ZjKZ4Y8HFMOBVpwrvePxapHZM82TMkTR7Pn9z5WUx0QxcbGOzccA/3QPXxCt5v4ZG8Kb7+PR
NWQXJr8Emvd7/fTO7G21PlP3tNLD3s5zMag6EbUziNA7gy7nSDFT8QOrr4Ssv8VQqS36qjIn
VM4jhmJqFEQdnb4uCZW+czywQSFuV7P/iNItQa0NUW0avyrGhqi7Qzlo1mELuOvYaT3NFVHx
b1ZqJzmmOAR3H2DXl0yOGCjTo3YUV+p8+sfda0j8wBgPxwUuB+pq47rd5XyuH1Jxi6wxWrP1
YHlAUDNYcpxgbg35i/lKR817LyW96oR5HEkNbLNYoqnFMHEpk1Mg1Bo2sBGvXdKDCRqf5XJy
v7OTS84WVP/DC5dJP2JlJFAjP35QmJc34z+APjj5LU4M2mi94tjchS51AORO9CbU03Hq4Dc3
emyFUJ05/bJrUI9nT7xpXd7ILzGfDUBVtmVMwXSuk598zQE0CoCG8vmPG98NeoJJoIhosHvH
JfkL4OT3lenhSHHcIv7vAXV3Q68MURxSaXlPquZCt5pT2h8E0LesGXgvVQ/Aehnu0LZ00bBK
LNk7a5uY35ki0rZk+aF5N9kf5gKDaNgT3uMZKsHk2I8kqp1e8T8HsZ4CpIfEiFzsW5SHwotj
JHsFQUCz0x30I/G7ZgxocCcwcG4pofTQ4Fdh3tUw5chblq34Vgb23SEjcpd3FkCn/Wr45hfH
O8eckZu2Dg2TYPph58kNHhAUQdE7EDQXMZf64GcG63UE2ySf+0LRMlrf/Bef/F2qRoqFiQZ1
D7CnwNe/Z8xFqle/QCDSfAcEmlNoC41SP+x2Mf5fEtXGXNu8nnpZATSiJ0gPMnQSwOVk26a5
LA2y1h9aKJhA95Gsy5gsPMVl7X//KAo9o4SXCuMTkMnTfGGsbvxFvIgVJHCNJ4huqkA9ziz4
ngdPQHc0X+rQ5xQ7HdK7GJG3IRnWuh5gifFyHU7YiZc87DZWmjt5OhIYLF8DjZDK1y8sEY3y
qdXuBJ9qmGfbP0F0gqdOSB/4IMRP638RM9am8TsmuuiHT4yp6sTJRSdWYM9yBPPeZo9gqrgl
yeXHT90CtrQBaVEGvhOmnlR50KtqiIUfRQczeQj8mMGZIiiqGD6AHf/y5rV+ZfGNMHiLZctu
P3DkfQGHI7Em6UGqjL6K5rScDdRi8yk3P/qWKN7Mq/+QY3Z6GLp5iPoGZAB/Ffrb1JRf/LPh
H2H8Q7nZOyIeuFuLKUIceypXx/o9W8IMpHXIAdhg7SyNMOiucq3hGe1PCBizXTp6BO9oAZhN
YPHRd4x6OK4GKjmEbUEPovAfMZt677g5+U7jxjGvWxy0vdHH1rUbASGaGTEO7zeFZTSTJmHi
DVs0RAk+KYi7kjJL6BV7XEQmr7tGL6S8HUVPouQptm2UgqduaiBtE2GIAx/gsXCzHVI/7wev
V/YgNF50OytOtcCSCoRrm4my6iSL5DLsDQ99EH15EzH9cSml73Bfv/uFuAxjXzdTj/7gjVS7
nxrHcSTvQkR2iKp3LzoOkwX5e+bNL7ogz2vY62a8aIfn2h1b+pwA15oO69GA/l0OHi/tV+Vu
YQirua9nRcfpJSiwOx32IZtdt/ZW0x8s5ywy5hqQuRmOU7FeUcNKimW5KreVDipV5gn7vY6Z
A5xRt9j2Dwyj9/sAlUX9XB9rRhMhZk87l3EVYi4dW8/XRjNMItq2P8LeJu+fiALqo6bK+9qX
fvwGqahxNseYNnKvLhQoNP3WHT6Zz5Z+aJDjO2bRCsQZBPjdMSz71X7ok0hkrj+/wymCAQt3
DDPgMq2ZdkNhG4OC9RjqfezurN+37NScKaCQZqIe1Bd3KgWOYR2Tuu2T2GLaA+fgJ/ooDYNz
esGek7Tt7mFcLkCSbG5VWOEbwKwztcifyjFRIEUX9gbkl4ZQJ3+ArVkGRkV37xMYDoCRumAx
iitIXPfE1VMaI2xz5Nro06E/+hNnSU2ABBPtIEyIyiCkdL4pjyVR+8heuAupsoHfklTqiaFM
RdqzVBwdj9YvyYbinTv0yEwi/uRYNvd7ERnz81JXR1SLAq6vD4pQ8DDuVgeKIeW4xeSuMOl7
1vHdzOBJsb5H3knaBMoocqQcFPNxXBOEX0WJSvOrrmMT5TT/arJcvu6c6cQY5MtA2ojwgQov
lLM5v85+cs1dGItEqQaJiGhm1cBlaTz18JwO37eZEi4wCB/v8INArsjcd+v9A5m+6xEoOnbk
vyxae3WwckXoqWgHP5oomJfOb+HJDqGk1KcWl4MhsJu0cIljaq7zxfg1maJRbfQfoaliDVbO
eo7roCxNNCCteb9sZSajdllSqtWi/bSQ6FQygzEzs+MejyiggPfCg3aAaUHh+VSF+KjTMIQJ
yK3HzcJTGKaUU+As0jhccaAQ5cQyiuo9cjeCpdCUdKSVs1pQPZJZyPdYAyp9rOtc99HgPUTN
L5DLDgwnM1Ci1HCHBdVckHPkNHShfTvFfePsml/g2cd+tSFW7BFpXxqy45TS6XQ8UVYH07Nz
K0u/vfEHGV8CaATJikHctvrjGc5srkWs5jWmQX26GCI55sshEGVW2OOgBPCoNXlxYutaaGls
rtPfidz+OXdNSWzGOsA/UTP9WmX5QKStXsSJ6QNtoQsS/mLYCHEVYbGzNgrEK2HYmXNttXnr
uEV9zwAifr3ZP96TPac1KCOMx8CC2pvvP8MsGQ/GsqSJ5YJJLR0TSnlpELlwL2cRAHeGwXFh
3lJVdTaCFNURIXHtI6y4P96QHqrwGMgpKA4Rs65CzFhU5lawczTMvtOyPrZjymTKeb4TIsGY
YBgUy+pSgqE1xDgQ+rFtwFJle8ziS7EPACTfk2G+gjN6cDUo44sCQC/p8oFANDDLqowuVDCH
JO/5Tn57G27MgXtDhjV/DbFn07/RNt/R+0ZSW3q0YTPomNeA3Y/w0fvC/l/pYjGUghyYylFf
FfgfN0PUlzTlEQAIL4iv59mgdwIZnQR42I5bdjobqc/e2JEZlcHZxl4NcRbHjBQN58JW6TWJ
8rQIFF9JsjpD4AJwJDKSAM+KhN/MwGEzgvsNz5lMahRnDaUtW8ai+sugL+zoVJ+iYxluyOxj
C+7+TO5TvnKjGzcZX+fPI+O545QJ2JNgb68tF00R8zdjcpVWPiuudFDrD4Zxayq/oS+Im/qO
XZY7AdbETQm3HMWFr0X+yNuEb+B0DrIY+vyxRUkZhGuQB2fM2CDAwqIhIJMg7MZVQWl1b+zp
xvwKzkik0lwpNx7mIYZh3tDIGbLV7+eOFAJE12XmA5sqhTxQQM5h3R8ZuqdIhNNK23y7t8d3
klKjX5fPHTgZAVrIHzKHqNc130IhRJoUz7e7HuC2u340bLzLsLSKOlFmV3h3Ku6BEYk8bRSL
eAMORoPuDkRYKhUIbcn0B63vFhJ181riK08x9/3UAr62BKe+fR7irEC2pDcGXQf123h9bgYg
hXG5dxGjQKBYTRzh2v6Z3km5sYd97dbhAmKupUUyxfoEzsNHxjFLxQUbCOKIcLgf2HDRhcPq
jYQzGbkramLLoI45/WUuVzxGaenVCPWZh/awNl8h1fUFmZkxsbCZ+ciVFie1PFxtjNKMrGuG
6zneG5gRb5RZxfwnY8N5KgIZgocev0w7Z40GXTpa2NI+f4B3X02TZhxDrwBwgz32hivLTC9l
rYDVMqgTu0imFjOBjDmIjFtFa2iDxRrrLdwFPYbzgb+Z56fgEoyq3ZXSCbPmIN1Kx/Ormsf7
meENZgTwXkRQgLx+Lggc5i3DNo+8AQ6qfu7hyYUvKtk7K+ek9AP2d35GM8kLKd6cmQNp6k3T
xnlQJK+6Sz6UXSi7mAwM/YaspBb7DDnjZ2+7T1GLsvgEou57W4N7PCRkYrIz3lqChZDIHUnQ
7Aao74MMfg+GmDCa2HZm22AzEvftWcVEz/PzQ4E0ycPm4xAIKm2hFoGA0FvhL4yXgp7Nn2gw
/i/ye3e0m15TbaPJ0o6uKgzP5Y3prxKZrvwftxakpqCzSLmMvo91bawMlAeFlghGsBZb+vyM
TtJWhpoJM3olBe2bwSjCUqC1xRGVwdVFVuepuZNtFVAwrMzgrbBQpVEym+ZN91l5CAkuXdHR
Iz965IpAuCZopppYHoArj+Jgf1Rl1DX1sR0a5CxnTKGHpKSxf65kV11FHBHXNZ8QRVAgv72n
Jdio3U4CU00CKS89XwSeElzhahbIZ2/WHuqs7PswrSvIwadWWoX7ykct+lEjO1Vbrm7DShIB
qkCi9/ftyT7xcLrS2z31RiZrGI55v9YsU8yKQbxOvOhCyVj8CqCZ2nxb0SQvgvYi7GPEcww7
U6j0YnqD0t5UazKS5qFB6W5a7UNjI8PB8S1r5mFYWZ2t/zeJRkuzRJcV6HXjGlmOgUSJH1w5
io8Za9nQHxMQUEbToGmGmJoy9y7iCOtyfPZ2oXt2KsEimLEky1+U1EPj6sDt5lXAggqMvg85
u5WuF8v7a5Jt0fROXlVq2JbtVDbGkiHv8jcdT+uC5USr7bk5g3FwldNjLnq++Ys86Ke8PpDA
1UsVf6PPS139x1rVoMaLtSPQP9azRwIYHbyFHC145Eq40t+z3CWaUlcSnIvi09aXGmmmF1Qt
v2zmLvTQqnhg1ycFyFhJ98zMbczlJQOotZER4eTu/zKFGhCX2YkTPvmJN7XWZ7gjNCCOKvy5
qI7ONn5/38L1Iu4nim5YvhXbfxriUkI23cbZ//dXN2UZMYlkKhkc9Eclf8aXNWG3c2Ynsfoj
wtlLixrYJvp1nhWh5XU4HFV9+wjxuCII/hb7xlwP531KqBdutlGI4/+mz8LJ0fyCh6qyKmIh
bAw9JljVTYeeJlEYwcMaGSS8SHOJs0y4GiQSe8hVg4K+nW7mn185pqLvRUVfak4JwK2o8F1G
1z4pQhbDZ+ujG6R3fvsmeYBoP5xReZJm44cK5c+QWf3pgCtDtIdJeL0AV7O68iCX2pkJnTN+
R/pWpAxnHn0H6lThMOeOPqJrSl8uEXJ++uOGfVIahwJv7Twb/5328wAEJvvwFSh5E1N/hDSB
KEy1/3IzPL78EbNpmX+ZF550AtVG4J5QC7TgIarHyb/Kod4HxcFRCH0SKCvYVs+s1Y6tWGr6
D53jZshU6kcKld4Nm9Om1wv4u6S+fJ+2DFqyM46VMIwspAzHbh07z09apHQ1WNwM3NDVd5Ea
UydlsLqPc+k7IRGXYCmpHzNazPc+Af9hxffrKxD9R/lJbd5N609Dv1gdCT2eHY55MfTAUw1/
Q7hFryz9+NJyn01kCdblowIoTS7inm/8s0hDGKpi483X/XyPMHbl52BaMyEqFJI90nqeeu6w
hc+KH73YyoAYy4Ru3uZwFlQXnRL8YqzA8YG0qKeWdMaPoXfpazb4HmLg6KKvAK8SN4y7yNZh
U3Og77GXWRIF9IOr3uPWvFVJBAuyAcVEj9hOAIIf/CX2WP/2SHkkUdrqLJgY6Yybhn5Mt9+K
Duxu2B6NoWtj5mj29IW3rC/Rub2yw0jiytFOC6qCmLi1zK4K3V2D2hR4apQxLp+tCYUfSRgj
r63wv6x2xFGR6SmNQyOV+YRSkaVUZIFuOT0lnGSZHvaNqtQDEngpWLWhiAW743bQkrwWw3MK
P+SV2baUu6Fp/hGfV0jaxuh3vXMlF6cdjZIgGhk7E4jzzK22dHlmt1ydc918DOcze1gQmjWm
w93624rt4o9STTooMLB3HphBcP48nJIp/mrv2hVhhsPey6sYkAK4tofRODt2o/3a4W9wH42c
7s2mgopvcVfkx78N5/b9mKByAsxty5gx5U8mhVRlY1egsorjHPZXCy0wCCnzyrFby4USxbZN
WSMPYg94N2HGPX1tYCvCcQQ0mRl+82ifxuEhguwWdIFdwcTHwyPBFVuy6AWFSJdEFi0L5ViW
3PI4oe7NnZosjpelgfc7yyi0DN11AIWYlgTj96spPqobmbz1/fwIf6+LYUxl6sRhcWtcrKu4
hbPFEGMt0QDH0Al1YHMbluFudyeHk+QOUfwmZPzC0yej7xiecEg6avddSpVnh3GJGsMa576B
gXYDBH+Tkx0FXXHJFDj50TJrjqsV7NLMO4WTSm/7tN7AvTCFPhVFjY44VaX4JrqapoUnOnND
TnSNDu1ztEJYUkLvp7Wj7tZ1lWSVwhTYcwLdObzPc6qwObjVxw8f6z7XMHEDrxw85+blwMXy
s7WSBPZPgFjd+Fo6jlY9kZCBkeLSEcz0DfcUCySVY/JXPYFOouoXDYBH1ho4RMrWc3IFRM8J
CSrNKCSAnnblCH3eOb7WVsOxOLSapsmIjVeVseI0c6vdBSNv94bXi7vSUK96z2BGwXIttzlD
mX8c4UihO4aW+P1Ub8QwLK1ccSvnRl27FqhTaLV/i3CO10xy1tvJ1fP5tkkdPFnbTTMXod1f
XnDJK4oyemKasCW2QTvqDYdFVjeGSlgU5CHaDMlRgyC3hGtvcTe6CLVNeFSfoQooHQN7r3NZ
hK+4/5JHQMXCkIzuQ4SgkqvtUkmx2B5gv+zdg72iJBgA6Kapz5IxRaZ1ZwtgX5TXegJCkIsf
5RSYK9KNkFQMHu3PdzJvyvHlLN7Y+tfNjThjaPA2JKnP1YzemhSEcN0rqLxQ5+yn98Dby3hK
4oXKzyXbcjFdIq3k+I/ySsCkxbtWjpoPth9Hde9yGVZuffoKxEQZRZcHyeQkMoTvXaPiJHqF
k6yorpPrHIG9qvA0oEK6k6HQb8mW4pbtFUZBZNrUM0vttaAoiQd+udvZnC7M/A3XXWUsg0WC
XsmMC4kAvaiRmRuacHJSly+Qr4Qkqs/JhJKmfzjYJcmkTu6pVVA7lDdB+Jse0t06PT6a9tXL
0KCXoCQkXyal9fwatcBCVWyagZXyObcXRxPpCwZJppiZHpsHCwxlR2h2aQXtzogeQ+xsxDg3
zrOvxlfSKjsSj8mDKboviioXNpcU9THLIQ+/kWLdohtDnee+10+Mx5WCpVMDE9TAS+7WtdR2
jXDFLP4/+dGUwkeGwvfhlZ4mhZwkTm4pxvdWItbD2GDws6YjlFJ4nOecVoLxuEimlUa/wO0x
ZFq9b5WGZyuL41lrbeYBiddusiN9xWFouXauso2IM7JKsw4Qa+DDcLv8Or1vbUp9WynFdG4b
zIZY8jfMJ4SEvhAGbuknR9bOtPJUQhPB9/YHlXLA7oSPSsCZRyuV5Ad9Nd7gT55Ig1WR3aaH
gWM1fI2PCpTBmvkwc9LOjlip94LuLNSyGHae/MsReQUp0Rq9DaCBfRH3n1bMk5K7A+fBHZKi
5BXahGpgUEZIxeA/y6+iUDFgKApVmiUaIMZKWxB7zNIPl+/SGtSDDuvP5Fekd2QKQhPlG5fh
0rhylh2YLvE0yb6xkVJrnsQvzUeZNvTJhfq9Sk9dsmJz11E7jTRVtgKk4Bu28LiBxcQl5ETu
cskBMxaAR2ArOWH66NFhBmET187PnRoFEMFFfuuM4pPHr9ANTnbR08AumW+YMh950Fa9FC1W
W4pQr/rQ5ZK3Zv1ACNxwwPqEAXOOKApevpjntcjPNQrDOUHkDHKpo8fK/V6eYODK8x7bCWkW
1QVwxkS1lQjmoDq0f1Iq/oj3Q63SUmN/1QH+kV8kY5OPHdtQx0jVWuzX+KYSn4JLjcGdtZyQ
wzrUH+QAj0gLsHg1nMURdMQGXZltDjAMcc/phrM0XPx9YkkTqVeMu6gYJgroh+oTP+Gow7pE
LA6OT53YfqmD7GLmVg0iItHRyNzDYKF1yXYdeotcO0XC9iwOxZZgvuP8GuZlgK0lGnsGfK1e
ndsokNAV+aESPfbHbclUjvGIh9EcbRhJbNtSRgwNAY43A/u8puLlXV1WaXVhwLoUXpSh0atF
M/IzcRZQi2hBRiSNNKRmbSCYSh2V+8darkPC2inhHEJ+Bu/Pm49BisuQQSMt2UoguuNZemzB
uFVDgq4AWy4buBPGJmC/0donPst4udIG7L5M4B5QRNvjtaDUTKrghAKH5oRk6LXUZAjbN4ID
Z13pBuAcgcz93OQK6PncuPhN1M8IxFaCs8+zTQsJI24vO3f6LhgbzxmN9BKouM4pa7GfS5ne
vs2aflVWKOUKRB9bwTtQLH5NNIIXL7Bs5NZenxR55JxeMljpMF5rSxCTewWr+7ybuQIR4Vf0
LrkiVrrF7ecMAWZz0udfTJAASNkj3pDEw7sFxbnnBBFkCJDq1nY/mJVUQtZYI/rwHwku9peZ
BQeVysXxm5rN5f/SjApgnlBV7/tz5ka362kxeswP9X67kJ5MYiG+ldP6h76YzIvOWt/AspHY
P4uw0yl67yp3C+zZnxo2BVM1Bxtc5epJ9g3xrMwkpAqWsm+wnE6ZtALaWJd2HqyR2+cnAY7e
LqbmmviXaRKFBfqn4TBauXKjPvPNL7EzIC3OQCVaRM3SO4L7/tX2Ksiq8z5zJzYJU3LOpLr0
gJxAV6I2Oug8vpoOzPjmfDIwT3hJ5cXdgRzB80B1Xzt3iGvzKCGqpGIFMr8mVWZW7/SOh8Hz
40UVFWKUIOYTFU5F3opgpfG7ko0Ve31jLkWggBL7zL/tDRSUFzX16r75bhPKghoMWmOP+4ZU
xIuJ+Iqzt6iFUQxXlVjHl83yKX4kKn3pvOAb1hZB5/HDriKFunKQHAAuusTVCbtWRaY3efR0
HsBDApOzQm7MxNOCl6DE94jRW1/cCE/0QjghJQ1UvLO1o5XBFCEpfKC0b1aurw5I+42yqW3L
E4u3agB4B/pBK1b/i89dwY3CBjeJDfZiK4AmbqkYl9EStsWUkt03EwS76r3JgXgoR+1k/TGX
/JyUfUcgGuOMGWFT+Px8hr6koSSiesTOHbdt5VRYcMgpFj+Bv8a82BsgeVfY67KVnBWlL7kn
0RyhabT365lsWtXvhlUEC2XBiUYOsKGkfJOouQ/ffvx4+aHVN2b6YTzvM/wi9sEl0Vi3fRpt
amEXoi+O1YhHoz/ZHPSS2kpiXNat4y3BT6FYldsF33/ygsQrIJXkbeBkH6GmdTfgFhXAf5wt
Ybxy3eB4gNyA9ipWJUgop5abzpUGTA2Rt5D1XFPS5qW8TlqfptxtKxRiJwt9fODh0w3ron9k
UNPAqoJH2gNxYqCUZQTL2bkB/U/F7ESdOvRYfTCFT60WEtt5gEtIVgJ5/A09XORFkmV/U7CL
J/S0EgZiFimIF9HWQFglCaMST336sSDuZrhlpS3Hfv2+7NE0xaNeXZ304Xyn8/A3QJshtNTO
4IrlIxdywItSZg4uZGKxhdPljC3RVJTxlC/+dU90UnfsXK+lQhYa6roAY2bXCec8z3jBd57n
lSZAwCE0XTy1w0uRxhwEleW41wUrsZsAVkPd3R0GtFT69B7PdDw6oNxibZYzTw7d4YnA42u6
ereEm/ZQ0TsRU6DBObgsNbmF61wu26GS3zgXWRZ4sHpbP85vyOKdWVGp8djOeJR3uGOdTCBj
UI+INuaAu3OUiT9bK8kWXGDcQdmudaNxrwvG/97qyoMW9K+6m+LSTGWxSoRRkNJghM7G1guN
UWbXtAOay7KsCzj0ShQht5o9SaxKpAj33vPXJqXd31CjLPyQoVnreG7byjrUePMmz7IHWM+o
rQAhrmIbPRylZYcVDQ0GCkNP29tttDfADdBfV89Z9bJzrZL2Op0WH1NBeH1Vm3jY18ukb/ZW
47wSt/h//dgBngoRxChZuB84QcqYUA+/z7DEMPpJDC9vXUHI2wTZEu91lPiqUcpcjtgN1tJE
UM0xZfBY4J1/BZNE+GD46GTDJTswtzg36KKsE+GcqMTIwnoZusv5v74vD/UJOuhog01N8GD1
SnF/eV3VNBqbo/k8nvYjUReLY/G4bPw3tmvurzsVyKqranwZOWd9CvPbpMOhepcw2GN/ESPK
jDCx0E1QDWIpTVpM8c96BRqFEIaKr9zG5w/YZ/z+HmxjgO1FSYWUQ5pzx768H8odljoQIY1x
M8Oqo53HSbKQLxzY5/eK5d+PDHTBzWM+TNEOrjfx+cuDDmAVWS/yn7lgQ1+/PkJyXBXxDl0U
r84kFEYXnphZRIwhVIobduf+hog8vuSMYtG/N2AtSz6tH1JARbH2SJF5Sol2p1ONY3yumKEV
5nnQd1uCuXwJHP8BqktLk68mbjuTIqJ4ALwL4KA3DNqed9DG2gQfuSF0HQrrzQoyLYwcSORc
uSl+r23mc6B241p4LQwiR2feSltG5+ZsRv/gs9jcY5s45CiDyxlZJqDERuhStAhlnEqB2G0Y
GJ4YJlioEWuc0tCnyRqT51berYMVf8+wLgIjrfLa2JqQnKUq7ms/3vckt3fKLvsW+QXPyA2K
TdyBjOa/upAxAjIgdtwzNAtY4i0APaEO/pw9vmNZvvF2F+SGeUKR09ZG79d5C1gN+Izq7n9v
AkPglzzyjxKoO5aUQqA4E3D7sLaDrNNoTjTmwdWXv7IF0p6qvj9q3j9eMi0lTCJ6QleTv1YT
fDJzhfb5aB+OQTY6BY+3oAilvbYj958BV17/7yiCA9/8IxbLSSyKlcrt0KZ7fPM07cLo5gtH
UuSLBtXTWs+cjg5vpVhUyPNXtPE822TEvt0jCXwDv1N/c3gdGjYELy3doYcs2XAYyL3isFkq
dZ4EsuGe/b5OKU8lDlldvJ93oXVBG2f+WdsnWKablOKkHLbZmv0LOSVvW0K3XY8/1bQ83rPu
nxG63fZi+5lwGZxunYsMCw43VaTHca1lC8g+IcUNdGpS2m/SzAEmPcERk33woUNnIXyG6EAH
+yxXUjoS1Z9Lq28VAyEKMuyFbLD5euvw8eofzpxA71hpteoqwI8PksfX4i+iZ9Kfrof5e3mm
EvKsHjOmKZVZs7BeSFyXXdTd/xGYLz2yDklyhEgd0/dI5hNpImqQaYOcZ4ZBm3LGUMe5U9y8
A+2VutDbjVecI1xoku8iTEgraI12G58T99RtyK7zxLF8qR3RF7F6Nexzz4iHUDoHGk0VZKKM
+X+c3MqMX/QPIC/Vgpp7H+VapCOt5fZ5CHKgdErFd+cNlbUhdc5kwwEQnnfi6hMFvGJFyZM+
TWBVWH+ytI4hAjaStjGSjgD07STgGHIrBiBsyLkm84ETL1Wf9MTHiaqEq5ax298TGrqMxvdr
ASrDFxsz8CpOsDq+lQlAJJFRKv1c/Racg460Dj5xoeQ5dh2AzmIuOhu7an6jNwBVIo/64d9j
DaS0LWlHIdcUg3eu6c5V3NmKEh8y5G8tuG+zIn98hZBtg9PXQ9wvGtrckYAVcnAtQbDhHSyT
CJEexYV9/zGPo4b2z0V7S2XHasfh9fy+IVhXTb2EJSYpuNcIV/FusrdhVcFYCmw2bLnh2CKE
emLnovgMQhcaIyc1vHuu4pDheLs3xj5H5bx8A1nK87v1Dt+Md8lT0YS72p45poAkVyBvCnar
6NmIGwVajyGIi2UZcKlIowgEyouQGld4eA8fI8pkYaVyTsmaK3Prxu/p9PccYyDh3IB/z1gl
T8m+ujTnmHZrDrYyG7i7mSuJtcM/WECqayfWMhLXKX1+VhiWcATXI6In/QGm927cxzRraQY6
8NUMFMYTv4Bt1xxWHqTr12ljwwFGx103KsNjOIZfYqqzFnwmOIqWj522xZuGtKfRYHPLVsRH
zTzajgKrbI8JeDD/mAJOsDjrSEeF38vuBu15jGv5GLK+9XveiD/A+/AMpN4a0QMN3n2+mQM0
kHtOEiR+t+s/zlVeyJ3emzY0snaPn3Im8BlsEHxG2pwx0r1Y7b7rzeVlXlvb14NiOuPtRII+
+QQhq42h1iVh8FkaBFnwL8kDVavHHztvKnoYb7u40meF3Mr9ngaSl6GLkCksdsBeBTddNSoX
w5jM6FwQBzPQ3Wl+5xMgS++TeswuDaYAQnDnf109QTjIKwasG4UDhj4B5sESQigyBTlRvdcf
zRliStts1RilOCKO+PRWsMbtGYx9K43uNNz6hgVC1miYvPn1I/InZXAPzLu2g+W3FXuBk1BG
ZdjSMiXl3bNLIL8tZiyMVWbEXLxkheFcynjY9WfcwBcmqhsTqjwXywHvJRVHBLSO1gzKzhh3
QeRTodY+5/mpTMckB5Z0b60EN5da6ncpGPNKh1KrqikK32f7T1a+v9TZ7d0jRXP2lCWSICiG
4oxkMoZW8VwCz9U3o7CBjhhHSwJV6E1VpIRZZu5YW1zRH4D+YGBpf2+NvH+JFVvvdV3u1+1S
QYHqybDyy9fwz599qgOPrAftVbUXHKBd6bqVGFhY2bMKEt5DaKI8EaCq9hWgkDnMS6Ds1GoX
uvjhljaLyxKouWO/KG1XCKf/dPYE3gVj0oXBzx/GucZGOdyN0L7cDWvCCQ/pxkWR86qkEeU3
FaogYeFiZFB0v3j2H7QRWHBT/RjlBcVEkWn8Wj2WBuqEOONjjwUDfwKcx6/9YYA2cXBd8RXT
Hzp4jYKhtnGkDSJ4TdevrrkgmMB6mf05dbFa7tJTkOC+M4syFD9agRyypwjd7/NER4eE/9ce
FqJ8MLRZTXzaCeKW74y3e8xFnjn+cOjL0KASqMpQL66HakcP7fFf9ACJzU6bAtN7XkGcWH81
JptaQRTFyh/7cq37Z/JHOqJvjT2Om915e9h6XTtt0Rxs2kLQUdXiiU8XFOyk8vjT1QnwXRTl
AzUNl4DiCST34kGdevbhFsy19QfG5VJZTdu/2TiIUnOPeqi86Qhd6zmPZRwGgO6udeybokL7
1DPKjFtrhQapZDL9DcegMWWI1goRAD4yDU7i9bsHnzFif5BueNIJ3IKVVEJyV/+Fk2EZjxSK
SpijbCn8R5HpnMvcJCHIrIaoOgoyuHa+wBMXA71eqqnhr5YwSHD3kRoZ70Z/hYH49mSEjgra
8swiOZ6pVHLD7HVUHGYqpD/V25YnstyoWJRplrgQ9ip3pG3euxBaW4o3YNej/hYeXEvu8pE6
op4SQnYlOkj3ZqjOvA8B8YBltKZjGOoqIWbVrJRprFUluwxActsU1PWQ5wWOs4dubGEIQodJ
g7Y9wU1fCjl9pZOtR8hCPDZUW8Obf56mkMC+L7i1LjjBR+FVIhfpp+USmcmbqjNl+Td0xjG2
yaUsVx7f47D2nbOM2T4czd+aGiRr51qJHiIxvMiRc+ush6DI0K/hZCWHzrEyFB6+jesLmaCg
AlRZm43EF30G9JkDtyxpQANueOBjvAXlGkcYJk4L1P3ZZbXDOCLNeAljJqbMicUr2YK3ALou
eH2EHiIF1aA+6ooO2Pqae0KDc0X3RzZ/VIKkCHWiCR1uoqY1XLPDvtrQI48PNXiDkS0PgcHB
bGIDzh3dKIL/PHYkAeEyChZBK0F0PU5jbomoq+4L9Svl9JKuy7SOhVSz5YPKasC4yujsZu3t
yAsT+9vENSg+Bh+IZHOzxpw9MQMa7Mws6mF64RKHBHfjUXXnRcJ5t8YFFzEi7gXh8Ndl9D0l
zwxQFSdxkXlEFIoT8lbMycnySIMGneI4vMDCeK9F5LWW+5DGbosxWdxWqdO0h1UqJZxOQXuC
h2xjh3WjUa0omHo07oirtEAFQ1vRX6JPyG4hiYuo5mCcLUhYcGZ01ov24HhXplDtykYUgH4R
az4WbdsiMw2FJxBrBh9tibD6SII3l6oT77MP4TNmklhvxkwl+q1l2xclXsL1USBAmd6idcRX
fcYq4q58PstHJm5QKz+vzWqb+l93w+bDF2IzMwY6ylmnElV/GUOa3CrCoCERcAQy9b/L8r+a
vkR0pfHPcCiZZXS9MzfHHXOQJLKhSJSD7XpRwLLVG04UyjUw8kHv9TOeTm6MKs9q1B/yyrFd
xNZMby6b7rGiazd0bHp4FjUHkIf+06ugL0z40/ZEYMiVTlXd1WJhVIw5dY0VmIn+Ep9CTLBl
0Re14drHoB+deUEJ8UB/mYmi7zbqb+dI8omxkw/zqvUl1p6tSxrx+m0lhLVUa24PC+5OMMwD
mO2l/biAwiA+EdzYCGmxyFQGb+YLCsS2dRRhRKRw42QElg6tKuaa8zNloO7OJPmlbkfY9+d+
EgtCbt99gRL2YoZ0pRqI9SNJa/gKq9KofFsGCcBK/zsCTn0+7DKyoMQlWmiLW+Yqx3YMW6UL
BCFLHJHnw3JpXYAJl2Ep5jbPChSMPIkcSysMCbDN9Dn91fRD4+7+Hl6xCCP7ABXKHEkcCocY
c7gMv2Do3UrVNPzcT7ircrLyRrvoPysmni1ikESC2GDox3hwzdtWPeRbA6I0QkF2hifUBDRd
mLX5kPclccMWvN+3KjZOp0FtB86ksg0fFCIerR4XCm09XzwEkM8f4xy7K0dis1Q0XsuTxMLs
eXntmFweSQbLpCwvZjZNzCw+n2jZxHDMzxNokQXDbmF/SMoxQgfPktrxqfJt1XcNpdCwdN/4
HG4ItQ2/raymIna6NP+ZFismTW54Gc966V+vphtaJogzAR7hdUMH0e/jhWHu0c40moIpdSMs
l5nrG5r7JN06aHUkpLKHAGh3kgDFgiiddb6k4grLF/OipEOYH0olQX2HHT+h/SGY5/VXZ7y5
p0/CBKTE65hBYypnuaYKrYY9xb/67qOxLKzx//bGcZJOrKto28sRSLZVpfPb9LVDoupDgLU+
xeUGBnh/ZeqJgMW6yYtrKsDKhaQse0k+L5Gpm/9FgNv3vrSKXJOUpOSBRTl8fBOywhf7bT8R
wsmkrr7zvyKNwliF4O1JgZDiaklBws/rivALyPA/EgDDNBANiRKKxThp3WrzCcKJDPTfJUtl
XpCdjOKJvX09NLcS7enWiMDgHcae7oywJab8IOCDMb/aDtd+DxS/3v+iyI6uxg+Y3Jf+kcLM
JMLtXYuVuo2ZXptzokwTS97v8eQjfQzUXJJx4FO1HiakBrfem/ctrc8lQXocbzu5HwDK1n24
PaNYS5W+5bWb03ox2xUzXrOtgLfqkugVQgmTSBLQR9o3NeDgBkJ50N8FRpJ+ViHw34n6f/lo
uU0UAJjlOQ4+EtbsKM2KOTCTpJ1nUqEYrqJtkUAC9KN96wmI6vzUOF24SmLuqEzIG5fgcOQN
QDtnwhzyjo++T+zLoxaE93tnzyVwGH7KArX7lphjeY5mjJWzkL1pPhtZzOUijMt+CAAfYUlz
Rxo2oMJOm7dKEDc17CP1x9Q2Pe8gZthfOkvZ9zuExkNvfYq3RTKkTcR+TuHKLr0d5K+rPIZ6
kD6nEpnu3VCLwv/xpD1H3GoAjhXVUpF2wGK/ys0U3p6FG3pz8Sm8+NnGIdAdcRx/tuF62Dop
J9hJXh6wmEINIFj9ZJwoanD8BMPJV5BuXu/d+4Cd25wox5blZCUhYTStQJTngyp3B5b+aw8x
88sfulb3vfraz1EmbZua1IfWzPd03/G7H+uZnxsV9hvXGT8zRmMKLeEvitlLIeMhqu4fE3gc
Eg9E8W7epUzBdU3sNtCRvDIMHMm3slVzzb4FzCbKOCly6mB5dbsAM90IpUlYXMn/6DM3YVs8
NS6PXDlai/rd2uXdR6ccozq3GgiD7crOdaXBXWoS7rsTc7z84gRjDazBGJTBAT0O4QRaxjwR
cZKdv8GNb7wOUMM1/yOcQoaRUebAJHHLu2E7o6QBFbnTwQhRlwmU3LOscWy3N3SXKko2t/Qn
eWc3VmrQDCdnN/kP6gQsySyYEYmX01pz5YWu+1sLZmtXysbqXgYYWBPt9FxZ+7T0hO2yJfvo
WYHN3xp6g3hjbzRjjCA66UN2x4I4zWM2gyJ+dS+zLU6d/ucDaIFsuKaV9rqhYoIjIM45ACvz
+vR6fgqvVkPMqMAYzSoWoydb2qta3L3ZEsiw2WBIZFi9WJpRWj7kqHIzEdvJqjV6dRNu0CRw
K7ovcgQn/8lYtjqAmNz+PuzJcttfSsefXTesyD7m1JZ+5blrfw9BY8HmvWwZc9hJI4XpEdKv
0uPKHgzdISfqvETHRSkgpz2LGfv9G3XoSEbGCeadzzevc8bjB7jomG2fqk4v9rqMZrR5zkzj
81u6BGW3Ar8fibBFseEmCtY2BMxwkpIGFg88KOBrbZYX3byIlgZtIHInmY3tQWixcht2rpeZ
x7QeDVzteEW7oHjBO0aZDCh1A5cQkL7hHQI6RtOLM4YZvJC1TF5wkuhrWRaZV9SFPCK8ZAjE
kiaXIlm1Z5+IvcxwGVjv0sK5EzxlXz2weXUs7BlTaF77x9vWLF8xGYDVPCwWXvxEsCjCpnLV
EtD1SVgzkFdjH86+WnTxsgvPoi0N8tTpKg2PH33iXbN9CZVMBPSsMNpmpxE9UoeslVbsPfEY
hvISm6xsfgxK7bdERfIn2UlFppvUVTWEagThYvsooqBq20fzQ3Qvbzf5FtynzoaBA+lNtted
uN5fZKThfRS9SDhD0+XgkYkB9azHeJUVmxkMy/G08qE+t2IGhyqtT37rtHVtOFtccYAYl/hV
KQW44b+ixIZgQ2WwWd/xXmPBSqq1PzrPK/v6Es0yYklqkjQiiRR6FP0SPdJGW8I4lvISb6oG
WVSOjV/MsdZIb6A/IyxH5eAvi3bh/iBx2OJFcl9E4vWtKy+3sSt6T48fJefeskQT6//iR5WP
Y7rb3CWWywXcopadfr8czfwXIbFRhhxZrfiHPAz+G70Q/uypfgDdSKU53q/wha0btAeuZ+Rj
uPViWV0QkgI97ac5IJzUNanSrzePkQdFdPJ73vk5R7sPSonlTmlAMSYf6x0NIlFU18/E4MvY
6lbmoUGd0YTBCEA3ObEJI1Wk9tAJoLOnuGHM75Uz09jnNxz/qST4FhMEYrEyQVQqPRi5ujBk
5ifgAosopkx3/EqK8Di1oNnodfK9En0+GEZvD1so3oBX1ACpcEfb0oP+ZbOudbOyevi45j1m
Li75Tewj1khyljduzpyeCoaF05JEjg+/YDj4JG/bbl4zJbdx87MJCOwYsxu37beBlfPaHMel
eEUaeKv3AJqCkn5sr+oX45lIlOeIzkcXRk5UwKVqO3le9qYt3zjJVdGGbkvvNKsMliEcZnRb
WM3B7MLTDD6MPtboJimXbk5Lh0bov8m9/jhajfb1wLS5RWSp+viGNz6Tgts3zDjiP7hDeptb
V4yoFQycl290AOxjjzWz6Do23Vh7Ue1D5nxaCFwLrIOU4fVaAx3k81MFOst0CRX270uIshME
F/hvsQWmdkKgePQGkjud6WZLr/3iUl414StmRjzq8K2JoV107a4vcSsQTu4yPFJOJJmXaBCO
WcS5lfQQgaQez80w/xBGD56kYNvRkLwTQvQ2xJGHZHZUievJraqIrI6hYPeCeI9vMVjtBM+t
bRLX6zFpQoddWRhq/4vM/R7Vsh2skO4/YMlmwGKgX6FcmXXXen/fm9CL0X/A0CIL1jz/46UD
3gLGl6bh0dLjTniW31RMK/GyCJoajeZbyNDQnaa4LXS3DQ89BDJ+XX9ypFuC3fHPsQ0s0EXh
PtiGWPmQw2Vo3oT/gWHMj7JSk9stcyfYJA7mNkONNGsaj+Uvi32RgOuBgzK0xd7X6aZY3Y/R
qb3Zho89STq3KoRGNdgRHOkm/MYyDRRCqNo4ZjKgX6FjtHDdzhDee8uRtbqCa96WTm72Heyt
Dv27fcJS1llVpVckNpS3N3BddoTJMPYmXZs4IwOipDI2YqkAC/MizmKlTzsz2+ySjOvyG6Cp
wDDfuUBh4WciJWFE4LFGQlwUsZ2wYRyXx/F8Yqn6RvgDDMVlL1J6YKhk+sPnh1dP2XKKNMW1
f2VV2ypuFxZcd5QGdLY0u+nt22ZyqvOe7cRFfnGdL3LAUJlP7lhy8uUls5MaeYX+efiu6jNh
tCW98eNnDw7T1jderTRJGZ1L+0wRdV9QjoZ9VUVlxBUvNLQw0ldPcQglDBy0dYUgb10Y3cKS
OCanz0zNjgnu6IbH9Gk7t6B4yZQlI9LWn8EqFewPOniGwdgc0EoyYMleCiIO7Q0glSKq4X8a
FqEDzYrRTpwsItPp1BV5KB4cfohGCq02kM5iY3QBbyTldLERnXFBOs+vrUa1Z+c7cHMF6DH6
nTGEVTn9T4Z/2zfEA+gjDY7HqccAzA5640BwuMGAGZacafeopr2lHki8G4bYhWLNuavPJ5U+
sWMPFMiki4lUO82iMp+/f3xeDT4oJ8F47ZpbZWA53NU8POVKFtMAqDs5SLvepsxsIXEgObYu
zV51VWEId4BH/1O6gISZyG1FFhocTQ4U1oTUVMtF6d2JxRDQwE/atGuUu3jPS9iwaaqMDaE9
bVcxjYToUyGtL5gfPjC8tZpEZRP3/EPr8dSrdCUbRIxlADk05G0QaJZCjDorz9o6TZGyZZWn
D/9k5Nd793d9vKjogPZ2FyUPlmg0l9CfMRa1PoMie7oOIxpjKs0Us6iGCXiJQljAt6sJUtcv
Ob3uamzBMvx3iNRvyWuYkZqIvR0Zlehz3wjTLb8EMQWgt2kZH47Rv9PHR5zlTgDfJ/jpcb9n
ZUSdSqDx3OCydnF3j3z034UlJX+29+jn259Cs5+wdni8GLry7S1Cn09juf7Jx+2dbNjy8w50
qQ4xmRGOIRYdcss5SNj/PZWY60EMpRsChDVXH25ms1YJ37HW8NrCW9VtDLbwapN7+YlqJyy1
iaoNX+ywIIS78y0GRyk9QUVcvpf/C3WUFC9RCbTk4ra63b/X58isuHfdtb2ZgZi6/SZ6KsVy
z86+CLB2B9uQki8+L0uetgOfjt7BSwiI4uMgkhngwysep39UJX0dueTmeRqihatJ5Y2kp5+7
TIAu1WVxVG9dsgsKISeQJtZ5kMZ5Q45q5/AY9FLZGRYumnPXpYUF7ZDzWWwiP7FnjJquGn0b
6RMjzeL5LrTF9JIFEbU9+AfIp/EoimIwmsCtYi1U8ixO6hfSlMS64HKvfTecL9oCpFEIc7Mv
ze1YmcvKpoALwKmt65XnSifQBOwQeG/UUnugmua5ZNfRwe3awcadmGB1WsloqeUw/cVZKNyw
dkM1m12CocmtsM1VQsEcLXN3ELjK7HdHOf7+hNdihSd6GZpjsXd5Z3ki4I+q8Jtjks/vAooh
k1o8+v0eNYkZg9MDJ1/x1ygIK/mMnUK922XDomyO9ISyvwEYm8MA1KvWCuOMuK0eS8B9tuPw
UxGZ2Ore2i8ctn7i6uzdaU/BLOoV8eULLiozHkvOa3zCWqz8R/b+dxpkYJyt9Z22wakCl/jT
tgF3SmDtjJBW8JBQQ9oHh6WlPvOQyx33i1h+fvKLtpkFSzHyR54URxnrgKErVyA2ImFsJpJF
TF4VazhqPfAlfBKri0nr/clcyOef8GbN75pHzLptG2BibHzGwTy7ReQI5AwxPZLqXhNVLYZy
3rAcdJn8BnLl7nLw+P/PkIxqjnhJ7rSOAi7qxuAvt1JYUchYIwWtAxFRMsgPOpzDGJsVXYY9
Nevjmr1kHPQ9uad2eC87IEMKlibJePJUTFO4QhW5Wj1DGo/OW8egiCKadRb8M0FJ1irx6UWd
impujD3S1GMndNGumgwYoGBAjdaF3NiKSVs99V1mLbgajaZrpqALv9kmmqBg6HbEbDp38XcL
0KNOV+XTybSc//CQezWN37cbKuad4SsdPYn6DWH1F98BiOLodY3jy8oO5j91iTwhhmfLX20Q
CuyrLQw9zRmu8MjEPwBNXjB7bdm8+X+kQ0Xvx/IyhIxAxb9XDhrr4Sq8tXtjFwBDcC3Ex0AV
gklhOrrHft0g/3n3EhY+VCEOw/t597oaDB8KVFne1Loku0UIKONthqEmgoI9h9eqxQyMB/K5
HsRY36ElExC5U4BeYsduMDeYNJihf1i1adbvL6gWRIcGNYSeJs3cBAF2FoD0DTyDM70I4IbN
bDoDuAxD0Scvx48tBuLeyJpk+7Tc67CI/Zz6Xs/4SEW5I+kR99APokfu3FpSiupzdcJ7XQf4
BhSUmOcciJFyW8sEgIOXIYBk283Nxgi5pHYCsEbtfXHxlAZNeJlLCo3GHAfzdlc5jWVMvsqk
lchYeCDnF+RjKn6c60XszCCtCstgYvhvfDTnPQgoFW5YmNqqz+DyEV8N8bjJIxE3ab12pLC5
WcvyO85tB2oru2zy6maXLMCyXw3NOpfT7fER6vhKyCGm2vJFhsEmZThFT7intapa6ArpECvP
5t88Ol//BtySZ4qurz1Y1C2qESp+evBqye4MMCV0t4BhDZddeVu1ggybVT8bFy8qM/oTsFAJ
y9tF1yRrGnGoFubNWScGS9UCcdHu1/1Wpk+YK3uG3ZayJSnZBf5AVgSi7YiHY3nrTcmffJJX
hrWwxV/iNPiOsrMp0ernEMO9uv2jXbL6CuW5axkk1hnD7eq7O9k/gKYRqAn07M/V8JUdz8PV
JWNRyqjuCCPx3hWGVX68smxvZB6XodzrrMWSgulWKdd4oqoIeVWCsPivvS4DQ2hBohQvzOFO
rSIO9mSdWuItakdfEDFrgd8/botGY0aq34yijHQEhurMu6QK0j5gmfR7qSZGgyO2GJcoo2C7
T3QUJLPmhiLZxc+LCK5ZpKZu1pYusO98SRjDwAAYwEoX9DJrr7/sjfBsxwDIODD8an6x08zb
nnteYul9koqwMBNHb9oUac+hj59YkeqZyoFiVRqI3+0eJYD/0PLSNxKUjpTS52AnjvGLYMrd
dUtg1iX71TeokqwPPHZfGcshKoefKZ1xzrvJNYpjxElCmz2frlPUjOckMPVo/xd++ajsfiaM
sl9tQfDVM2uC6g1iOqZxfIQZG5+5gvFD6UfPj5Ofh5YEIuOF7bReAMLhYJfKZcPQcR7e3P+u
q7YAdAkMYjw9IhExwWeLDLbQfV3+XQiZSI4q6FsbLfZHCTGARit9Vc6j9Q4Keqi/mclSGJkf
50pKtACN3+fVCR3lVAeX2r3A+MLCi4XNV29xTUGt0W69l1n0fnIxhD19AJrswIa0W+bsXa3b
wqFt48Hxo3YgZQsH2DC+yAm++gETx5zMwlLuq1X8k3EQy3jo9BGJ3cI2GTPU126rzfX0FrQx
+EWW5SIMLKeNm2mFsa8/KEwYqQ0sk+U7e/KjPVoizapBuoe8tfnzoRe+PNtaC0LX1kgRp22G
SqCeLM+PP36Bn2/OP0uOa/EB8d8mVbcW532yuP7NwjxcYx2e0I7KO+bUlS9K3GAdCruML+U9
tgfroX1pk3flRF55TgbCVOe1P7Sp2rK0QOfeQVxBukgh71euDlWYA60B8lfI88/j54H6434t
/y+ltJIAZqg00Em4pBtBiFf5Ct1bhEtKXIVax9TU7VW87uJKovMaduTUd27Lheemi5a0wIwi
Dhdj4mvpFINe8xbi65b06Fg3uId0NDyvNWf7kfkV18Wirz6Ejaa9GZEoGT9ZHvzpmSbVze0z
xXfHrO/qEtfyH1elkM6H42oQfqsan+5w5S8aEDDah5OrYawHOFSbjBpV5gETItUY/Ib85S8x
n9uhdP30JtLAnzCgFXQM2CF+dFeBeqEh0kmOWsYWAq+51Ke9xYSBcsAdYVbHNEdKCUa9T/sX
Yv4umw6NdjyZHOUL+YQBJxo3ZBoPHL6y8WWFZcqDUA/StpsEcLqQkhOz9+vU/oC7APKYe1hA
JE6n5yP8h6G0T6Rr2LU8qtdsdOU+Fjd2QBDyRaDRCPIYBnfyUaxJEFiamYC3+915ix3Jrcx9
fJUThdWB526JvESouDezl0WLSgIbV4ufKDS4CYw3dj5eekSDCCmcMbvFyllUImpU4FxCvgJj
YHS1bTd7QGtHsX5OEKkM9e36dFZ6JSTZzksdWYA8Pi9MmY8Dsno3by11xF5zpGQQznqTEFo8
Yr9SBRmrLQ4yku1vfayJ0scl9fd+08LiVIymeTgr5E8is0Px2IIieuew4qHZZpehdnu9Pg+L
NG3sZ5HbRJa7u8bFawv65bpBbe/cWHM4Ug0eO7N0+IHBRk3mWTW1Ma2l3a8S+Emcwk5X1v6X
ZLUMZ8PRKm7/NsTHXwjvsnjsZUNi4ubfNIT3QZL0gEJABwiz29f3WWBEiyRElRg5MIfzrZTP
wVXWivy7Qh6CgO6ojxaD1G15j7AhIwygkq1lblY5fn2S2E5F1IETG0i+WE++SasUvqmN/JTF
fK8pgSxW6gZgv0MXV3bda3v59wmmS4oGDNWx2UtIdNIAP504faXaBPoxb3DZDRP0Uz13UzKo
NBKpej9xKA08ZrpoGmkGo+vRGUhv0cYzy7ClBy/MEUlNLgA22fYGN9t5qh6cXnzNsJIfqqL3
jpbrdW30mKbHIXanUzeVtwGRIZ4YxLwAx2LSxmIOap74CQ4sfJRpRn/1nc4+PLxpfQhqtI1h
HtPQs+w1PmB5SZyy2b/Mh50GiFpVW8RAeKaihozHgw9OJ1ZsU0w5DcOP878/xTJCMv1TIDeW
UNGHU9vYT2ct4i9pxbVyrXI4sNSLF4K9wy495qgL3HNVktaFbIu0xx7zQmiX8H5GgmYaNCFj
1JjZXYA3Fnyamssx7o092oCbk68NhIW28M0yErwSZ944+ZGdYWWioDqyNbRKO6hn0vBD4t+l
UszdUgaMtdPRY0FvUM0NIiopPdB9TKcbf8e5zYBqYHgyR3EaJOQakHjsR8O2R+pAh+P8Ug3S
kKgl2LcEMxo7W3DFl+Z/sNVLzv+w9CT9tC0fzx+nNKVaEY9mvF7PMScnpBzG5J7VQl+uPgQb
3sWGNsFhNyBnH4x7P/2NwpT+AX2hLRCwmE+VWd2Nx3krxMF0YT43jPDZ6cSR5pTrDOalKhb0
uER+QfxFmIuUcswgeJx1AvAXMfRuCid3cKPKaRoflGdG7iYpilpl9K8wfD1yMW/CuBvkoW3B
XsUdlSj/msfVGJAwzbKFkL/1uyE2pBUeav422WHzfoL7Ssx9yOmS1hXz+LsmUAMY7skt0Jla
x6Ach3CylOY11nDbnV9ASce1rd8TBS5w+hy/j1HrE96WdDsYOu0l0q+Qp0Hau6FHisjCS47N
IfbiMh2WrjLARD7/tERZyItRsEaVIhh02ut0xgJoAYvaL6jDNEnhNxtXOz4DxaeQYPLD4LH7
4XLRHIQU6b4tj+Jvpt+Hs32I3BuiCe/53BBq/v7Nrcl96WgKs3zs6BssBPWTnPgYW6RuhmKE
SLkmfm66aPRPnSY1/sOMsWDjTchTz771SN0xkk3GpBWJfXpaP7IiP4E1n1oO/WGMJYLGg9Mv
mimRdB0YOi2fUIao3W0nYbqUyiqh0prMZsrZj+oHz50pmFH8797pTcaAZcPgd+wp617uqCrk
ON9Ru//hiRpJMYsx5cUbc+TAQm6Gl4d3tvFEwZf15bVvh/GrGTQB9y2YNDWJkMQEyMoEi8Uc
6ABFvNYHgx9GpsiYpOgDtlaigbAT0KhkJkTtQPhw9B6D6c5lR/PDtjRYuAp18HM4S+B8A7GT
KS+wFihZ0GbqR57DCf2mpGqm9AmSt6sUFyKbZe/5a2MEkbuEe5jxcG266tuTklyhD3sSpkse
fMWLXq/yxNkPlRkcwxExHJZIAxZIy1Ig51ijB3AFBfmmIYvb52BC0iO8h3a1b2DfBbOyp0b4
+3zfVAMXoWQPDAWaoxb3BDe8hkoz/bHcHHrRgxa9/zMEizfyOgfH1lyynRMIxfWMhUG5gwad
Jwj7rY3ETk6+eKxOyW+s2PRXQMo1uo7n7LKXn8VJBA++yedEvnps2xZUwf/dVq+g9E6Cb1b3
ZDwmLY+1v/im3c6so8cBXhrVIk3V9ccdphnKaK0rjDdGxr4bQxl3bGfORJBYKrwcy+FR/FRj
XjET+edtfX7m1A35ZZGPODTv7rnkRLkIEqBWSJU3jsRoSmObU+ITkK/UUGERbAs3Ntaq53ZV
WnpYjDLcsvQU/c3f1+Kxsg5jqvkopeVTRWPgs9RwFrXfywz++JngcQpHK/Rf87wCdmG7ySX6
FA5X3GzU1jGBg6K6IBGOpE9Zv/hJhWCbRivKYytBdYoHuPmeBwKx6ahWg9t9xyiM2ZQz3ZCy
CStWz1181t03cF+AcpV7qWQkCYp82kHkcW9w4kpABkALW4Q3M6zsc4sfNuaTQzhMQsUp3jWl
lsHwmub+iGKtKAw+6h4LQpvdvVU9r+jdpGcSaVb9PiOmLPQ0Vc3ih4f9S7t6Bk4TJ/uO26eY
bzG2yvln5bTzaFiJ1OX5Ab+ZrJBPhHDpBJGeMBTdM/TkGAX8ECRl/XM7VuApIj+fHhr7uhY6
92WbkNhYtm6Prv2YoC+y5clH9v9XrM3zQPlRF64ZkU2bOojwQaxlxJ4vCJJ4VMEHnm6LR/tM
GxiPl06WenBsnofjlPeqYvp1zyn31pXZl38TqisnoiHgIMDX5yqkYEvq/Fuk0Nml48ud1f3d
tGoAPBztUtR4613s6qPlGw/QLkPwUiLg0YdYXdHt3EA+v/NvTi+ro561J/MRSTSFaVqEZ1FZ
dh2ZFPItdmp70SKRQbWYhbGKaU9iZvQr1OgxmfDidXGREJgVh/2mD8XT6oKu8BGtQV4ebjEF
dOBojKWbr4CdLJDzEqGaJt5EA15OfS34J1cYyJ9G/zT75/9ijbI2PLWsP8JZ8MD+zaktJtAC
r1IoTtquqvN+Y8HucJ/yCcSW8ICD+J9HWHaIkYz1s/fUQ91nLJHTB05QxyoMSssPvNjC8bhG
4UhQUx6dMi4KeOTZmGHBlePrigGEsILF1h61JpaAnf5i6KEJIyOQSwnf/oVbn1PSqrToGvtn
GQWi6xxHhoKKqr2HOVbMCsUK3Wy1nHFuP0BOSJBQfOw5YN4sezIz20AvXo+dsHEGWYuTktkA
tkm1mA3Rj0XyBgqABVn3c7yCaSorVGyqj01UP70vn17Y3O1s0GaQ2swLbzA6vixh7sprIK5Z
afodPSBhFo7FmU94uEANNK8On34rTlIoGROo6jcHcVEHMvZZm7G8AfD+Bsqw8RwFxQfRQ7Xi
k5r0jSBUfDhsHEZuda9o5qDxwGtPbUgZqa0QACheNVslWMzuXOUfihK7G0DzfyjPyLRhLpCr
3WP5iMg/tqdHsYAcVL6U16OBe0JJgw9WUvWvrVr0401oD/jMjXeAvQCjNcpHOht61CMD5MMq
UZmvRt34xNcwQ70ZuJoUa6G41dm1RRzzEo91lTn/Is7W8rhXpH9YH2TJZAgDOF6os4oloV8H
SXR73OHxWMDX/4qIMnjNfxyar75wJ70FO21N1/tE2H98zHAt4r74PSqeGoLP7KgoajBBpQKW
/msntl5VsXW/PQ3aeoD42RIMtoY+z84toqF26wRH5E/5479Mt6Jm0cYL3nkiKMhS1Xw8ty9V
zEuZowfsnTt9W8GaWpfSLMwzT8jMhU+NwuBtqeYR/r+YWyNrlbYdBln3Yptkb4Swe4XSJWc6
/u3E7fsAwcUJuSZ5kMav2tyiNPfuLIh74RlqNUBj2hm7EOsCrGKvKqi0lRUyxlgYzyCAhVtg
V3a48dNCPQDWtBecCde4Q1pcIYwLJTQCvSY3mDjfJbCJmesXtbb2PYzhqIOW1swX2enRPnW1
hxuaSK8iQAKIONEU9f1l9B1ZhQUIZ5kIm3gnoQdKa0Ip6IIVrXTdS5VzQg8zEJ7JVLJR2GWA
vA6XDsjvPrvGthMTRO7kmEIIGVnuovTNt3moWunbZIE2IPACgXRy5i10zOt4BQa3PORMawjM
IiQMsonwf8FJAPYDtyNbOHyKUpoHndlbV6j3Cq6n/u9H6cQbl6tlbdJSJmeVodi75R6K+vhJ
OA7xUvcL8UCzzZECLQr+yed3Ak49q7+dfogGOsy0G6rNC3WUkEb7tcJYRX2JOFFafuwZ+R2K
axD84b8FDWM2OUs84Kt85yT6eJvyg3TO21SEhjSKMh9sxOUu+tWfWVKW2OBe2lPWG7TqyGZi
9WG+A/mZx99PP5U8bf1wtEGWNsVkFjTehk2UvRgVw8WqtaJo5ilmb1qj8RB3OFJ5Bju6OTkj
WIz7f/yiLrHRctJrdBetJJflERHPDf8fFl984avFYvHcATr7Onq4XTXMZYGEP99oqI/sdt/Y
DNenA/x9ue3200s/Q5Kfdzzl27N360fPgtnLAovAXmXJ0U7Wysedy2rmjlNd4W0pngAEzra4
TbGl22yU64B6H6BzrByJEiY0PDq617jqGlhdKjntPNToLB9cd4ZWHet8GBww0k7AmB74QaSL
OpyePjFw/hOoqZvR+tZ0FxnxaGh1KHgzXncgmY7DhkwTvu02+EOwgtNck/PazMqjigf37Bb8
niofz0NxRTceYBgeyZ9k/6HNz92lHO1nGgWUhlAr9KjiyidZ8QjmEFvXydRaaP/Q7qwtcB9X
fSARmQhA2vBgWky4VWTUJcqiY6DmgaNEq7rqBsrThMouYoZDkgNa6eFb4bOovWtnPRF2HYq2
mhOojJ424Q7pQ3A1R726fhFBj/AHBlRGcazNsbZVqqK/wFqJqt9qIz+j3ZBcX2R7Rc8UR1i0
dw/LwlA+K7GD9tkkF8TFM+x+gCy/yKHt7Z8zxhEm85037rgTWwKCckfsAgO9kccvoL22KwGO
c+t2NlTmev6RJ2vlFfs/2mycp3DLew6IeeGss5wA4uEC/hW5Gqe0dHLv4YaKB8VmP9DXH17j
TPtjfbRyXB86Nn5N0xaQLc5BrFgEmhykIJOj9H9y4EmDunPawNdnQWvq8P/qv0QniLCpxT9M
rnPYU5WIDTOCPe3NV8V1FN67Rlk9ra4CdOyKiycsNtcHlPCI4QRU3m0JWFZzrG9o31Mz7Mq/
CxrXHTiu6IGabVFfKq+z57zHlsNlBHEgR2R7VlpEEgdKoo1WEYYIYugDj7I7hh5g3Mol7rB2
zaVuInfbcTKHJ3FEs/BlIXeKNWzwiF8y9+dO8n7NJ4lsuo0gUR00Nu5/kvsYkkwstp1lTPyH
6tbhczfEx3nOYQfDajWBE4BEV0P4vHHCEMczIUnGiJB8BH0pYnPoumeQnm4HGWintDvDlDt0
qPtnbpp4gLCyT8HOBZvUD2Jd50zYFWhQrboQQCDAbibqifyJJJE03i3VIICa1KMoW7uEXk4o
F2P5O2DjKLT7NVGGQ+QwatKaNtUm8bW5mhogVNePRo+wDxvMvpIw6/rw6BJi+4FRJRp1rs2g
91IBGRws1rTRwU3DpQG9FJfZIHzW6FI80BasUDhGnrIEvmfaUr3eewPraGNmIFDTH+2YDzRv
QVT+rlS/rBSQcIZ6q/DnuuO0v0q0J8+LlsmLC7yRUiInpYYn1AFFs/FNcOmpfBt3iK28wjPx
XhDcAuXQGuT78HNN8WAqIgijdz4pgz6WuqCD/Sut6Acnm0F5eWkuZNDkY6mkbleVp1oTK00L
k708x/W1wd7h//6zxDkArHaDj7NKU1jx/Eb6wljfouMmRp1aJk+/MkZ70XUIIKRHGslnWmsZ
rxLT2VTixTz1yssKxPEsfjxc5TUdGc9PU85BT6Mg0Buhl4MUnPT0wUL/xnqfgrWhi+FXTBq0
JsQJtg0WmoSNV9p31XuhAI2tYnRseQ2ClNUnZxHskx0sqLBVz1pLnv8UcsYel/z9RQdkTwve
g6VXATesZ6FDAtq+U/yEHxEB7AwAISXGIRcG/Q9fKmQuNXKw8HutVvIo5BZpEQXjy7MlvkpT
VmXS79mA4WnUcC9yR3pmACMpoqty5xRj2PNrWDsklGtGvNkCOZVWbfuSjqP0LSf9IQc66Qcc
iiqBiZu4fQlAOtOFsu5gk8vnZBLBlQIeXGn09XffC4CZzI4gBSe2OOCi8HTNT8sum1Z1NwHE
OzyYrmbLOWENhSr1X2oP7rA0I1vhrUojaRlT7gOswqEz8Pc0QEeXDIytD+jHDTKP0fSkS/hP
GfeReFQDphZr2ifv9+DGpKmT/BFxiRQzUBrTDFUc+o/IKrnr5OrcjAuLd0WDeSPHhTOm0p7D
6y1ENjAMAiVz6NJ/3GzzL61QNC58rcsWM/5dO+Nebga69v7r6fgszdpq6caTeD6tqMpVNn5g
wDjfBKwWgOw0orOX4rI1pgVBQeQxaXI8R1IBk3IAV3Y3jlZTOxAdC20s+swrNSh84XaoMpOb
oD6sJKYXMqG4ZbSmlppKMVdLKsiCtdIsxwNqeS7kQrqCTvzGcXp5sK7TAyViOM80WsLcLhi1
KzD+A0eRpNlX4SPbClUT4T2wU9issUhlXjbJ3Nydrr+95Hm7UCdwRRnWHqhOm9jyT1MHyWO5
6ObJa93u8YPw17BhXEyai5hhv+VO94drxSytDpNpXxnbRHqtDTuzDB/i/5UVwySmVQ96X46X
GJEVhu66iers6TCu34YaMg0Jjpax7CHgknXFCFHY1sVCpvi3tsQEeRuKtquGjoHyIpAdiHcF
WVWT58SWRfmveVeQGOzejmtuf8HBO+Ahd2Oz3od7kioI2DWDVkKAZ2x4njnDZy2necH2UgwH
P2xur01Lsh+Ju1KHcgCLm3zEWIYO/NSgE7HP7V0JIPLq/iD+rJqr3OIvERT0RzZCIZ5WYIB5
avEHlS5gLAwrt7qtu++uWSFgkON7SHYK3c+XaS7XhY0NgafF8E4d1h9i4suaWJWAKJiJdpuZ
IJHA/KEDm0Azkm985tDZh+nEY6rNeZ1yFIKW7FjhCy5m/ewhtoH2epPOeQHbVp8iGBD7hU1i
fyJ8HBGnc9m7xgBn6vsQsp9A3bMCYocKdoFu+kWfQrZ3rRN9nP0espNZpntGjv1p9o759+U6
g0yF4eSwSgn3bTVR1ATjHOOb6Z4cXWVJnxJ6L5fRuW28C3yCXt/bgy3dnn5cyc0Q8oHSSc5+
NHRm5qPykRG/i2fypB+fipw77CvKX31ljJOqdPXINSrSHqU6T8AbJtKvCBR6B9KLM7lBpjMM
pA+HeTUZ+0YXYdu4TWByo0p8HJ0QWN5pA0gjEUF18Gfka9wpaTgdkRwQqHNYERSEvR9LS2Bd
QlKWBCeyB5TM8R8bV06DmOCi3Oz8Qsfm9WRGlj0S9e2OZMfL8BQ5WAbHPjaTPpRujshL153c
/ju6fDOpe8NOgMihpOdWiuihtzh6ybeJcH/ok3C7PLxu/NhW+qE9Eym9e0n9XRjcymd/yTEd
EEFDnAB0LLq/waoDYQoKDjEE+dxNbVDUm7xH+sdh38pJfra02zs/92Oy2/c9KqwTL0pMEHvE
8GFIfoePDC3GzYGzcnRZB573mbKozQk1y4cgwOSb9ObpV2aqSwylKZtJt+YctBBBicE4U+gv
P2/5QCBPJ8Fg7wBZdnwz6xLmFGsUhAU8GH41Pi7gXzGQQHFJYE1j3ytvgnw42rsRNvZ5YceJ
KX+wCuY0b3Dt+l0KgxL40NBWlHPo46ZBKbXu+TV6gYmELsjegZzCYOFIgjkEOgpgKomH1aqO
LMHXHxru0NEOpBPffvRu/ist66QnV6Y86XWBx6F+ng60vFVwsS1NQouXFdIDDn+tCGCjuMQo
sLR52CR/ArdhNxG0P7B1joRkz+Pgawl8wsZeCZS08h7p6/MkkJ+kl0pie5V5bfvceA29cLxj
jDr9LlbYUjxJte2BpFhglmetZQkNthQpUXD1FTWMJiKSVqF5a/jGW2Lojp1nYQkiHv4GZf42
MXLcc/+XlWrwH1xRFBGoaGQNg//zQz+wYST1z6jdgUuu1ju92qS22ibnevhbEJEyO4MWWAmi
ZexgkajFIxURU6xeCHpJChn/QxWqTwWTuLZd1CDdyH4bNiygG1pyT7M/oqyB/RWqmAKjWixL
YZByDEZRZYxHEu0wrlJEVFN8whR2/RKmzrQOCdIBUuuVsMd7Q8cY6yDgXqO6yhPESgJHCQfM
Y2sThOYm2ZoyCT0AnTlUrLBvdTKiy/tVK91DB0ClNSb5KhqTd9xtBz5rLvWyWopPR9Z9JCau
pNBgppC0SyzvTnEbyMi0nMiugkwHFQKzQ4MYUpSY/k984e/JSP/hTJpakqN3Cblqh21w8lAW
mxhePHcKAMlYn1r0lq6w+jpp3YrKIpnkFXbed86IdSqt5o1nD6XJUYrMcK4guM8g/2rpZ/dV
7zDVe4dm8Sy96vIfiA7o0V81cE19oePAIhefOOsajmwsmqRVCOS4d9Ho2MkF7U89lTkr2wpP
EqvBuJhAwEimMJ+YL/ZGg6eWfF/snduMWI1SVzrhVcI64CcBFtkOYZzPgZAsP37iSOh4FZ8g
NWkXS93Okl/2sz3pj7d/lbs5j6D1QDlc/dRg8QOPAcAnmRPc7rcXFThK4aZuv15kIv+ZnRRo
Xi8DoEGziMf6E3/oaOaZXZNlyBCEgAPotrKhn6bNu2I2cTy6DWeWb6x33klX36lcIVqXjvQH
oyNH8t+w1IyB7T7xcAtKJ9YrhlkcokZYTtX1Vfn6NFa5ppsj8idlACeE3TutT0sg8oBLgL+0
u9/x3H3c0/CrlL9TgJr42S0mJpHh4ODW+syjNw2L2GgjdUOaei6vJjPBPWmJ+wju44LVE/FZ
fdi4e+rWo61Bybook0MX7IRUKhXrbkGcE88tT2lkT0bnPkLgK1/trRkamqDnCx0XLQOagMpB
yik5HUCxkaLe7cYz99AI8yHGdYgaijhPNydp2+XEjrmC/YY4kQySt4yTdsJBGxpVEN8R+fOG
qAM1xPVyYzqjs0//V0zM3Hi60t/SzanJ4i6Z/P4mWo7cYWPaFeLjnM40HKsWJ503yzDrf6G1
osHvf2m3oMsg8Rz/0Wjt7zK6DXQlx3udFtR8D3GRvrbYBdJ7O717orE5r0edUvHEEE9jPXM+
zrpzqLRMjXM0RqVUTvtS8czD/uz/nATEI8ExoC1V81sY9p+hl1yyEP6uTNjAohf4OhvxopYQ
xFbo/r058yQ+Z/vUw1zmCXNlQFPM3rZbnacco3zwXPmvsoGW13BMwok3S8KN/imL1XMzKX6x
ixJ+jEV+VMwFauOt80Nu5BT9GCal9z46CTGRayX8LZ2LAtX8b5rvUNsczgamj1i9/EvI+E1O
W8RSDVwmUBkL6W/XFaksOzTWJRff7iJYwycL82SXrSkabYxoWORFtrPOsRPwTirxfXdSlgBN
V4Pdk5mFkgPFxUOvbkeZEE21m34Ddkc4jlMe6T7b+qF3uW8SSWWhEfHPVjX/0OCpYHlRnqwD
MZMK5lvAvpRBmLxXb5PR7t1UsWWPolNFfHCvSk/SL5AJbTF8twXlTfgqOV+KG5u6LlrGSRcE
LRhkC1r3ocwRNeONNhCi3cXtP0xGmQybetuiGIBKfjrj9cu/L9zgmqA/7aHZVIbTM0my7/yZ
m0IUMrgDmUTKIQAR0iGMaBcWMysuebkExXgnL0Ea6dGbSOv29iEBFD2OpKDesNlxBsMzJ7EG
65Vl5Yt76jJ8K2BbezWajTtOgcPkVM+GUSWWV12oc8YZm+b2VlpjlH+Bf3zRJPAr5LeMku/1
yGFT3F4zD58O+Lt9BIRE55l95dsHP47HbJOoRDLtOCe/ZaJXsSPW5KMWWz7bYixUkxkspS0H
L8K5MbQI//a3tN+1iY03RE7EaQ2SBGguPXPXQSXiRgp470A5s45X1+njOCz6Z1nOoCrzrwvk
ABGy13hnsHaDKIkXLahltmaUzRZUhZDX5a93dtSIis6b32o9pV/S/NvSYhl4cprhLJYtuLpP
2cYwvN4v22ePTI/XaO/Y6YJI7dv73UVIYmzJV2+MwyZIOEKMMd64eqw8uUAEK1Bwv9zf6/lp
E9abFWnhtkXN94gtW3W/wWceMm7agP8wmtJQQbihgy7qssepdQrZ3n1cbGNvWHXNFmSwVnlQ
3X+SvfdtXrB+QHFGOkKscJp0hIY3wsphgPLWl5PZqgOxyUMUF0FoW2HKyYfQehmVKo/Rf6Ze
LX308ZPaKTolMgZiNJYbyMtTf2EBc0L8Qeg5WQNy9XbQFb3a0/8RgkY4i2YROSkKmTSi+YRD
/pDhpNKj/U1ve8yyqfose8yqeG0gTmqMNqmT3WhdOUEE7fNDn3/Q9tUcb3AP5Px04TTqqLVz
fv1PY9QQGDV8j2kFhLczStdrZdRYZp8Zm+h1ttSAHkaXwfq/uwFO7yxcyXsWQG99KL0Y8p58
l9n1Lc6K7iYFvxtF4vQCMgx51p4x/L+CrXBDzSGi70+uS2TGAPYQX6aJ2j19G2nDf/BT0Ron
gSHIwDjAGHRMa9FYmlwLPeTYFqeeKekyibiiA7896cDKqXq1nznwHn6B4cEX7qHbRyFUMwHt
H2DR+GQrC+QLE+U/vp+pePIJJtPNF5X/qgE6BMKwDHlSEYkh/8rCk4SG0OxSiCIjkyJ0PlQK
K0GE9LwuWEN0KE7i4RDGmBunaYQrLe4qc11ZEkqr9v7v41xX1mjZPueEWJs0Z5n4iuORoxSn
svpPcdC3jJ9GYGbzVI8MW5erHJFL7dPaLxJsNWhMLwlaYuqB4HRbAqn2Y8zWp2N325pFWqB6
3t8aYy5xkRUg4TC2y6oaFA/h/JwfIllWzQ/pDnvoIvCZUFMh/bQ3tn9Fk0yAT5m42BhYbJvU
Gj7A7T+QNUTMuwlkJtGDQedYM0S48YU7+YFIiY02SGqRXbuYpPe9b9wpD24sny1QrnoA/INy
eMNevUPbDyntGojlYLICm9ll4u7bDQhxEdeQT/Uu4jZc83k8eBKoP9g9lNLg/G0783iSEyJO
5+OcO5MXdHObA5uLmFBz/1VJ+Cp5D06WX1Wi6SPYIk9LQD8OX5K+4v32re+JxNWgIc1+cWcr
mt7pxU3aABNwmOnIhrJF7E4daru//Xx+tu7nVMeqcmAqvCkUEhnIPLO7Kb1hy3p+4uBAXm7e
EoMIunO1E5gbAcWQXZcPvEhI3dHqUcw6oSEtPdZv4UTapm24v4H0sepevYRexjgCBs1RCn+v
S0G/ePDHqwbbMlkdOM0BnRwxNtjHxtXbuEZ0coIe9mZ/7lMxTsjtl0P/4kmu5irc1nCU+HhT
wNljWLvIEvoqXWq78weRaZ5AFIBS7LaSKGOlFX487MZ3Qthv1+0slepQLepdu3x0T1mvxyqc
gg0/qQ4Kk9tk4i6V1wlDOFJw/F8FXekpgT1Q9JQaOvVi2QHw6v8fV6TDAf4KT13iSWhlGZgI
n901r/4WNS0WgRrfpLZ8Uyt5TYUuWMeJMaXCWHz6bErsR80ePd3hvN0sgciM/ek34Etnz9ft
jCi3XKVJfrjyNG0cUsjZ1QIK6nmQFgKRmSDlX7RlgNJgd8wICG+73dnVapq6tOSBxLOD+7yV
M0+nf7yYPrRpOsW+dzpFJoI1O5fBBrUr3MJJQZColjzR6YyDLAbmADt1+bNL9oK8rmKGerlI
kZq5kIsNSaiJFfzSFyYkS491UMTwMFkS/kTrybjl3QCoOgZuSjal3Pc7Fu+Egz8SCArNAHIW
qfS3RsJjj1D3kHBoI8D7SbzHfRN99Zgu3c0Z0qYFtkkXDMXILmTcviYeZDv+3wWx5JxxoIaQ
7YErzW96UXZSIPvWu4NiN21BkGJWJhc6byNGhOjWgV7s07CQu35Amsirh+tNSgnWYd8zkJGT
NRR0uG0eL66SGh44Kl89n/2Uc26lJXCUOouEJXgSmID8I63ZXy8F8qffkR6QUe0f1Z/ImRUX
QLjvdIPZf5mJuoSlUVXdahqSGYz0NJQBv97KeqLmBobih6HIqhuiHsyrmVsdU0gZpxprCYiA
xbQxSjCe4MtuBr/j1jQgNbG+1pZu7GnqaZ4MPEzKceCHz55HbFsZtRoEkMmwoFQ12o0ss1HL
wF0I/gWev9DrWpT4kSAfKRtAUnw1v1Dc1Puw3r2FgwPWjRv3hiedcF+bPUg3V4/v8AxQZ6d8
gM2Ow0eAABWUO+A5uV5/y8fgd+uTEXzidRnPcgXSH2S+gqjuefGJ7sxN7ZfIj+qcYJPdKKaM
QEb9KCbeq7sHddh2G0INRxKox7hPFX16R0vPQAFLdW4h1eMEh5DlYUG0bEr7JBOZOZq1gU8w
mfZMPrP9Uw62W7xleYQ4n1ELh7Tb00usKp0RedCiq8ZGYRlN4rdUiL0XRmCCdxK4F8rZcutR
jMKLBr0aEJ54g/5ndBBe2d50bfVqmcST8piHkiiZith43s6XEWvrG5xxqB9Wh/qKuFR50yKL
P0HPD+PCtJzJaVi8cpbpjRcqq01kCOc/xuxynJhNVbekO9uywWDRXRG460+OQ8ACjNX000Ku
DpSeAADCL1FBIdghPP2UyPluOI6Hst82g3jsFqI8Olw7vBhB91gu7ukGOaRjL+rETDlVWUMj
20tsQ2baDNb79O8k3miY73Z294/wXLUg8Qxphg/ecCeYSa34puGaotl+dvBSta6GaG2HEZLt
C/8LJp2RkgzqBWa/dy3Hucaec8N5rn8d1vjEAkJ/kXOVvNcWWO7CicCBzvh2gyjo1rU/wBdH
hMyU4itxkoCxUp6aYJXL6tSOIDcm1pxIXBLwDpjgUQBlKzNdXHh4Pd6V44gnPBEMIkv29GTl
PlXDxrbnDHlXVAK/MQdYx+I686RF5/zEAXo1fvkG0AE8xSLxPVK3bnv9CH2S/X9PIfKEltoF
hMJdwJUtM3QbZBsoBGHaywyl3G4yv613irRrF6jF6fewOv0BgKE5U6FMjQmsCXRoMmJwvkZ3
xjXIFU3ZOf6LB8ox0ENP34F0KX4hX0uN0PBsBBtliJ35nlDGQdxMZdpJh6TdLF84zWswMASf
Zps1G7j13VFLZovIpUzyqHe/PnuDbOfZwd+siHvqlxpaWe1vLJqBhK65cRtxaMyKqrEqfsXd
fivPxxVr5vfBBprzNkIY3enAo0mExuD+mXA1WI7rP4QMqoyfEt1JHaYPJosztp2PZ1IaRN8m
QUxxiQK8RMJvMKKGKTDs6+BJoVu+Jm65LY2S5P+3OztTnud+VmcjgWYAsWJDJxcGsDHHH+WE
NweRBljGkT2AeTIVTzYA8XuaZ5IHZ0Lv1hSbKdRe2Zh+JjGggiTNz5mLYVzJZAeWlmNeMJ7Q
5GM4menI3OcTk/HqfwmF9MZuKgWSh3FRddFZcsw2+l5fe+MfhFmaQzuCB1NLyAgvk9qUeXs/
a7+fOL/dAgsmwxHAzX21Z4rhpTevbCatCaTXPFnkmbtoFksXAWJyPwUV9zn+eQyl4DZjym93
7PGI0KyN0BxP/3B5yFRsK5hYio0f9712FRFhj9+IxGiBmfyrdYeHt/DCQx48JLSgdZO/ZG1e
zTQJn12zqPXEO/Op/BdeWI5zGmW2VubXzRj0bYIN370qGuhmE2wEj7QlFex+fHrBIqqwceCr
OXvQuMIIHDYaydpVTwpAIUyIi8Jhe8Sr5Zf2e+wyLzpaqLRh+MxZ16tFCNaJPOyJxnqYQR+p
EzbGGRc0/Vk6yLj5kVHo9LY6vZGMpB4W/F2z3R6VeGCUmj5ONgdZJA9uuBRarGjAr20AdZkh
R3wpUGIQJ05hWLxxYLsg+f/fCmmvcLCwNO9xO+qPg5PzoVbPZa7uP5XdlWOxSJrMNIwYTPwq
LxGLNksaYYJ/7gkzMR1/EBzDC7B/LHu1PMzjl4qpKnXVlU/9jtb4qUPKlDeSSvhFq0uo9s3M
g5SHoDyO+ofMfS1XRdWjtBKh4+NyVrzCLRiz3py/Vy3Tj/VS24FtK90IE7oisrF4nY+b2XUB
LDuHtIbNYFKwlCIoPBVDO/slsOIwfMS+9Uvy27jVXYsDO8Y5zoYubyVlzqaDQGAyk8f/lwYD
KQafsObAA564TAMvDq6Bm1DeMqg0d5x/D+YHSWsllDrznKwJAtsH20QxTjOCuG4VsXmW4bpD
VcT1xTHHOW9ViiwKJoTj/nNGj19eVaMg4nJHGyL3/wOHFi1EanrWvC5hxjwqY+qZ6HBPSsbe
g3lzBmHQ/Xh3k6VeALlwS6au2iimg3pEHxk2SYx9lt4rOskI+dIaXNL7PNYzhROMFgoB8UBG
a6NgUG0Au7VLChFBQHhnvK/dRwe1qczN478cp4saBhANsY6QduIhbahJGfQ6f3vfoLnRILjn
hG0WJBdj2rXf006XKqmc7k7TficwHPnQUh0QjXpQpJ0XR9gp6Mn7JGRYyCgqMbTuitNp34Fa
qIUSXYbM2Jh011osDs16CUK327z+ETaCr/ClGN8xiZUhOHCoX7jORwXjUTDe2/EVCkaDcOo+
kxgY5ZHMR9bO25F0bnL0ijIM73LDz6stl1LbtSWN8OKpRypei/iSO2p1x+t3dWoK1optXF6C
GyojJ6zBNSdFxIpNR8MbYtEPnNFZ0Nv0SIcH9XXqx3+ZoiJn0d8i+poNYQ7rQbzzvE2tmUgc
hEhLd+4KDMplytrbYKQ7YhMx/vrt3DbQczDhHo/PVCaDc+dyV4Frmf1MNs4NwmgEUD8PJRuI
t3j4gnisJBdHnJK+XpaP8beAcbHYI4hosYHOzPbUW9KmPLFxqhuEnxblPK2h3vTuo4f69BRf
n+BxhqhSCFcnQqoOGOpxVwRSWfafvqhW7cWQUP7tdj7sStMWzW1umOQLIwamU5GHL4ANgpv1
y82UnRmmCwmKX7X40PLFdUjMOTOMvRNIJBoXSNoYWKibuCnk10A2N/lJfq0qk/7wT+iPyR1D
p1UD71nIchfVc+R0SGcr8QkeV07CQSXFzfp0BGjhtZzu1Oyn4ONOP9jpn+aXIV5hjyJouUqE
EJklF4aX7casq8YIgpk4Ejpbh7ti78xNPdW8mmFridvYID0Id3ByoPjlAv0qy3q6PfkY8+a/
FbYffcsPzdY9sTmBtf+2ZluMrplIQ4ccFIPr/w8ayAe/Svqd8F5I+OMhI9v1N6/lR/qdxhFS
0T6FyOZLsSX3dZGpYEWn/QU5y6vn7flrqNMSfTKixvz4/uCfmYWeFFrCBtaVSbgMXHdRkRm5
7DkqkBNqGogkkqfBJoP2qopcjDp/2eABSa+XKNn32CoKWROF7sfqMZz2oVu+wpJ4qmEx98HZ
pTrDWGh6wlYzXTMy3sEHRPjYE5nwH0EjBQS7o7pZvGkNol6Qo9WsN3Fp5RKvSNns1CjaeYf3
mNvVc6/Jaf7RbXhFP5y35T8O1C5q+aN7JJ8R4DasnAmS6GHCqr/zLSTlyCLELM6ffKBvNk4n
zc/ZxAEs1+rUwVtT3gEU+Zrf8LOPzdEQabdfd+yhhqwRYjnMg8SHKGsJzL9lFo90nwBvJjnd
sT+3DuPZTJWETS6+1gQVGxzt5iWJGTjtMZQ8D5ym7bMPXJkJGOkfP4A8lRxxH1NfQXW8tOWM
gtbP3LzZoVTMDLTrH3LiEa9dKQrn86/DvxUls7nh7bLTd4U7lhVZOQ/Q5gq0033mEOJee3IE
NxdrQC1OSrBgh0xRSiCsI81x02dpeODtjB4lvaZEyiSlJiP9cDC2bHWDc0hW6WdE942I9A8V
/PRXbYS/jB6cQqrvsfDK1H6Nd+TsDEBUu/yYZWP5Xj0MHnlxnrays8+9PaQQ10IkRGTKD7K+
zwmO2WpPgCbCB9nbcRiiIIBGXb8PzeWwnHYvt/A1/Wx09rltUmBpLEjBwBv92lp3dbxD0So3
gjwYttNzU1D2UfBhPJIFnY2C1mjfIjy5N/BmKRcz/6chIaKF50aBAKkbqZo2zxBW3zwB+1HD
tG89qAwLOr4u/Pk+hd2/yt89nAj037S5YOGR8Cr/7mDQs/99TDQ7x2SMnA1BRNeuEnT4CZk1
3hKv+Vj/TgkeFnzq06Jjl/ltXEXbbZre1ygo3ahkkqxInOQHAUtWchKSwGv0HFJXb7CoLp8S
oH88l87Q77kv0IlFW0A8X+KB6hRd8A1yQBR/QxKUhhwSTzXG1TiGjQEIHovoQO42dYyfXHiQ
WuL954M/jyyLAwR6/dC8EKBXEZILsUzjE/19vie95stn0uf+J9+cC6ZUn4UsoQ9CdxAu32J+
wMrVufelrzpmPCLW5OHwOM7Mcba6KwFQKN6w+KBspMnrMFPk9VMH/B3xlU57gvktlm/eNWGD
5ozJzst25Y+3/Exa8getqF2BUyl3KBvy4ta2gHfOIp+Cmm4tIaII89/46nSoGDE2jLrOHRl3
7hmzL6sw8LscThOzuc2YhpEJ66yeAyYXK/dpSbdWwG/rtmdvvH3xv1zPlzryCyDYyC0/Rb7a
xqrt5Og2EtpQR9CuAJG4YPKtdnssOm3V8vk2xemVQnMn1m+MpaoCX1lUZ1z5HYod6EVLVCrZ
Bx/QCbTFReRGxlujYVx9OOiJlNQr5rLsN6Afy1yj1axNv8pgjqmiZWKFS24k65gpu4Z8tqPj
q+Pa/qHNKWJXZQ/qSA7wNYSgNqBTTUq4t1Lfi8HQoiLKtimSbHdiEF85UCS6ElUEvHPMMHXV
FYmbKOZcNqTZ1iFd2nl5pSklyrNajUsnJ8fxE9hUc9Yf+NIisNnSGhA+22YYYXyKAeK/a5Su
BSYiVy6jvdZEsrgLi50zRqf+ky/Nt75PoiaLZssQNx5dySG+sg3oo1JEEOoNYfjAQskFpNrh
ISXHTbyxRtQUeIXtq6x1J+n/n+jO3hDTcDWBHUCHSFBYrVTudzSWzh4wIcYHZ2YtOVsU6riP
WLFim254rfPCZI74AK+6KecSdkqrzi8c2x5MOe7fmeQyHFW+TCHX9c8w8Jhs5bkCMkG8P7L3
S5MYj//wJXVyiWQCn9w582SbazbleVypE2vL8uriFKHA+T/DkqtbD8T1nYmGpSGZ8tIn8f/r
9Rhz4tnDGD/lAA+GyVVed6kekMZka6nRhdX5JuAa7leUPRGXT9UeCvt8VPWv66ON9mOSEA/a
M+wGMImun6m2HzNoARD60ib84TFdwxugGM0UfioIb/MVqHita0ovDh/w1dwO2GQnETi2zMob
d896pVA7YDja77WbPX7cwWY5dZbyf2NtFnyEvXpqS11JfdL9PQF3E6BNJfsCrLMKZSMYEEIX
RS5pu8PP/uweVPHqStL5flY61/BecMbZuKty+8pYipUn7kUKl5hbIpJB1FdzLaYZTcfPIn9v
HlO6TUW4X6UlSqm/s3SczruedPFlFVN9rmRezmZQYVEUHGu6lOFlL2Q5040rNXDB28K5p8rp
X1/cdQen5oPMW74KIJb3A6TH3Hl2+MAePlbUhH2SzqpTGSrI/1xMGQZ+IwwCJyW0pUQ5Prwr
k3QeIUI9q1b0btQGBY6UzgA5m7phLDUuZik6kSt4qv6672fLh75jXNpRz7qM79sdDpFImK2M
4jUWl1ymqmcyzf7YtEatVdV+tdonHEY+voFpBt/QQcTzf2f31fk/zP3G8luydvxCoUzZ/aH8
Djxu6j0HOgf+gQgwBOvsENASeHq8cQGO3g+zcTw0d8Py3CuvH6cj6TEWvHf8VH+klKrJ35eN
9sw3ICrbPo+CR5xXUHr6FIMKJgxV967FqRIB4O3cqZTMilujIfWojHCiKPiheylCTgLDoefr
7vN7OAa9tu5+LuYWGFCalHbTo7oikeHUmrE9KRT9cmLqZOeeZBTphfW/1on9W1x4UN7Zdyvv
I7R1CYfHvOaiUCkpjlxm7AD78uKiu4TU/BZp7zl+a+SUWWiwKtwdzK3Cx6uQ7GTxYvD2QqJd
cmzdlkCwcNi0FqtUbaLoy19zW9AvfrXJVmZmrMfHsH+kLtiFaUQDv1QJ/jDJXiZ4Q3QtoTP5
zvXUqvf5cQVuFVahgkA46h52U0CIFNKLne1lOj+y8raDm93jArkK+DVGkXLHhCtC321EkMNp
A776zoJI7jbVuKdiRMM87VOiDhah+Pb70gewEKhGeJOfHuoi4oisXbtxV378GvTWQ/zDCQZx
CKvjMgSJKWmHf9YygCN844SVpAWELU9lqWj3knoYRkK953+6kM/AZETLij3ygtARV7nBmRpE
tsCNq8P/RStBAJG0lWFiQ/ifwFymvJ28EKKfr9oWAua6ckVwnzIuqW33vmwky0EdtovmGO1l
xoB3CS+Sg80ZGpdIFJS5Y5yWZms6wrXl3j7AwWJ4lY9whSIf4pHBpZm49tndl9KB5E4QVdUY
xhdZalY9JqSYLuMUmN4zPtYFsoKKq5VvkOQyhxbIST5vFCthDwDyQTT0EIToCx6i2jk2/dyW
Qryyz+Uawjq38ymkuNqj8fTtxWrL80l6jYNiod93QfifmTRui9BkOy4WD5vjucl33tk/2wXH
TOaVGIqsQKZuC8x6RD9Tr+6s0oaU3jY1xzaj0nf2TVrm4lZVUvBwLaO51+F3CSBKPbQi+BGL
TIbN++hIhQ2GGcxSf+9D81wPTrach+opRks/7/Y0RN43GlkXpboREwcJ2kcMv9DJuoN6qc5l
1OLk4Y9dyycZUnVhkmxZNZcH11E+TISQ7M4P8N2itUcrjlLL3B3iB+x+mPkfitAriF21PZhw
a4WItniQ55/rWtFvrbK5TLYDj9ixFsZgnWhjeouaDm3XqIa4ZdVRMpys/geQpjR35lFt7s5A
psX/Z8vi+dcGpCTe4X2SLsu4d0dCNbzLWi/jB4mSKc1x8nGLqbSH2kBHJ7m/+sr9rvNVsOFN
FLJhUN5GXNm9p+t4tpnouJfDkli0WwfwRjcY+Nv93jUw3u8DvaUg36jEOufyOTn/5pmWdbp/
r97puLlU16PJsXfVQmUXR82vvf0eY0SUJPDNF/vHeKiANKzOPZHnKA6t3DypYdaAgo9raqxz
CqkuswhE89RMHi4dvr1hlV2EsK85xdeqZ6f7FEl1gmQ6WNFpEUTws9yLVIN99LzIwDV4nZm4
mivYeJzMikI2JEfINf3Utj+B8wzUxobgghFWZorSCEUn8LIkNRlumrYDE5gxKVTCHdPKTMNF
cZpEGm8bYidRaBEP3D1RQK4rUMDIcKs5ppLnwJOVqvo8JWd2ER5CakqTZY10EcmJadPOw5ui
Uu3Ax+0X0ClsealypQ+5N7FYEGBMnjfAlRNFev+Cw2MIdt5w/E7p2qEjdiK0pq8QjnegnA8l
8x2a3AD1fM1xhAviEvob5kUxsamYCI9fWGw8xqhKgcv0hU5Ti93X/5zcXv5NwvaOYSt8Kx/P
sle0PwmVo85QQrIXAlWIEjgQjsHfeDr5jBGjyNSTUezxU58yVtcN2u3yMzueIlr1T2U1oxxi
LNG5xamvx6bIRLqRZR+r8h07Qg1L5tNka8fIKyPHEK5fRhSlk8B+VZwZXsNAybdXsaDQaz6M
8jVdHLcH8oKDDx2nJD5gLqy6k+BP+wkc55ANLUD+RrfJgdscZaBIH3hoh6cSMQP1IqYtSCHy
5CzYdwSNRwxSLhAIZvDp3YgFoXO6oQZoQsDhRLGIcaQZ7dDpFxUqJSZ8SCgIOYJBVfKy6fCR
4cHug9Rx1cnqk+U28vqnSBFtnrS3Tq0Fi6P5/WnQbHJlHKgfw9WlslL+KsNPbYTluogI379V
sPdrJ/x1x3gIboWrNQf21b4FaXNeI0sOw1th2gYP6Ef7okwsYfVngu+NU2UwHpbfDAkiMKHK
OMdLggfcnExS+TOr6TQo9gcaw6Y6JBM+GTK8QBUhBYX82eI0/Gymhcy00MOu3gYndrkn2Czt
eyOfVursWTOLJ5ETt0fLNvjs7eEcD3I1jgkAYb5HrNAG02qbw9087wuqarC6N767SJ0RCoq5
KfQv8xnKiJM7fMPhJkWCuzhZcr1Z5bWB+ZU18x4DnHrpohi3t4tjEPPSW9jsr2NH8RIej6xR
75xC8EywYSKDw9I9Ue1HLAFDKS+r2KkjD802nAJ4vNEq/WkJbDJSak401SOmSEaxwC+GFxcK
c/jJEg4boLWSC4FvxstbmURV/y3xMLPjew8HkyyB+8hZANWU2Nqgp1SrU34N+KiaynDcEzXV
H3gcBjpVSCae7vJ0rM3RxIkLnTHN8+qtncaiY0GfnweLoUTa6ygvhFreCJlhdb9g7B0yZ5nX
oObYyWSwKh/HFSjUDnbMEpYnMJIfw8wmPtpJVGpvRE5wX1olvwZoc45ZAZebt3ojFiiBpV2Y
5b4y3fWNkDJ0/VBUlVS4VXrg6EzTPAAB74+hJaPNlgr5cFbwztDdq8nwPc2Yzc1nnk5wf9P8
LFx1ZQHcXMiLj7g2B7AsIv3fn+dUxjh4/4ptTF1T+/mGFi7RJH3jvHkT+rdUZDUDFb62EkUw
caEiiD/tEpnDZa0Qqg3IfS1fT0JduXKLrJLVhh+iZzLyRJ91o7EMjeJyNkjClfrfdYa6SPoH
NYcIYCEHIowOwFEYrzFSFG+y9xJXNsusDX8oq6k6tg8zV8DTXNVdFEQDSY6Blq4cVczZOnQT
ckEhUx2pR/XUGeoMBiXg7YwgiRp2fBmEF6doU/121bOsAN6+QNDogMGxnzxn/7mneOxI+XCQ
yZhyWcenKRwJbVpTzDK6jcXMpJRH6IkUe7PlxZemdUgQt9Xdx8sia8hh6hWpOAV4BvZnMrCd
TTpCTQ9xOv01a4LKErGoGv8+mv4VTy5X+U9J+wCxwcTLaTBMPlbMesCwxTZKbrMcm7bVI/Bj
7PlhpQ4bm2r/kh+tJ6IEWX196A6ea61ezq3Sk0Sq6SWVC3uiAtaj6XzKdAupDqY8MR/0hS40
8kB7SMIeNQc7zjgtewjCoiaNzr+gxWu+KXlB4VPExR1NwLOxMAlGRjKUBGEBAtzqPx+clf09
4IshMnbSAZaCp2Yzjaj9EbAiVGZuV8uOtfJFXbD+t20BkzY9w0GEUeqM6yabVzXbeZj6y1yD
3iNkuB48ca2fvEfSNkxIYHrQpWospar80mumYGg6PgF9B4ZHUHe65d3EEd/rMdVU8rTO+jR3
iL3GFg2eqaBgJ8xrAUBoeCwdmdY1P1NaibEwFca1IApg1aFlZeSDcsniV3+mho5sUYbeW+ob
JGIByiBQeOixOe24LIPhDlQ4ZwN8gCPkVK83uEsSMg8in8LYYkDWbYL+EEaFpArzX2AJ6G2A
GFi3B0diJaLCfG5YF3vHhLi2ANPePkQhpLulIGCKDL79kZggMfhXLwBHb28FQKhYpe1K5Q/t
vsTLbVggjVozIXj3LYXY7n+24OmbGZ73mb/kKWK5U7gI+hi6WLdTyVXelqBhwlQxFoShnwhA
jBxNC+oxX0hgyP7gG2PutrU15LmfZvDGVwudjgiEuUVGLIF4YwJRqmkmLr86Mx/YY0Xs9D3f
kAVrETdorKKJqzCvPpbPw2w2WQXZ5NpGAL6XKxjp4hcaSZ3mJZtqqv53i8Tk8wC8NRwwXbaM
+/wjwFnOV7TyctGtRODCDmw8iGGCtdUer+fhRlTfXfqDkjopBMIP05MKg+5x7zUf9ORrOrWZ
g39Q1R8pi9X5PnQhcf2rx1W7a1DE+KHhAWW+Z15SG2rqzP+YMIHpdk4Y+q3uRJQ3vZoLqo9D
ugdD1dilNuTiXt8PlVH9sIeHEIqtR6/GbqyVF+gkzh6JvbY8SQcKZycfE8lSxhsI8upRm46b
McbXr8aU1zG4eTDeUfjaYeL5P0hAml1iIPRnsMsyu/3xF4ziZA91baSiHCKWr9xnbk8+2zk9
IDfMbr2siYZenQOFnEO05HrLAnWWNu881/DyxwtJp/Pf6SFzsuLLVRYicgiuNPk8lAAAhyUr
M4rC5lyg4WYDQeq8Qs0lpNrHd/S5Pktz6isk0MSxYSJc4GCIKdJOgGHkUkFpv4U3leaiJsv0
MS+fUMYbPTr1FBKsDlbzSvf14pIb7cZiaKCM43yciYWeeNNtZT05psCZ+fIm+romBdrf+2iM
0JgODdCfUrKXKje378GaX4hMbgjbm7/gviGIB54YVvL/2ox1qBb2HI4msr6wqLBe849GM1MP
xgZWD4Af9UITVSfcHi52hBFk8LnD//BF/D7j7oWYCZSK1qo7MjcbAVQsgma8LthWus+2yUcY
QrBGfEw4fwsUh1KJlG6uUptNnmWZIikynYQsQS2rGts2TW2a3qFWb06c4CZ4AkUlpQ+TG7y9
wlyfoesPe7pQGPL6gmiOLPekQDN8tLF6J2dhn/vKtiHRdF9iAYj0FPsBWxLQDIcrKB2pwQJh
bDEokZJXWhNq7398QbXGuMwmiBfZNSLwz/13C9JJ+SmtK3C2f998PHLySICcu0VHpgxFQs0W
gn0v8HRvpWtN9VsN4FZUgz3idSY2GvsfiaSVvV8vth9rUr8hI2/Wcx2iQH5m9tmwgajWsGwM
+k7uAGiM2Rmj7QhJQFfXTTqUHikpDQBnNyJfdITvvITpu2q8Ci5O7mpY/6Se4Ovn9nv4V/zS
XuBsWbH1tZa6/2ZC5urxaGTBkEJNEc8lSkQNkGSRkJ/6oFAG83E8nud2kOoBOOOj2vNFI7eh
GrSpHK+YW+HcWWylMIT7yjEk47wmXrRzUXLZRt+HTXmQBr5aqBAmFg82GlLFRnqn6QEKZM5R
glpRZz78nW9r0QXITNXbPcUPj5HXWESnqInkEKW+51PDJ2lJRkcPEZ0AQVOPDCLyM1LUDALv
SlwXGZakNs+P3jvY1mJglqRlRZoInags9VwHcNVASt6cXPmhHVUz2ZQSgpuVQUhj4v3mD6Es
geqlBz7LHt5WcJMpGJ1fEu0JM+uISLR7JuxL0570m6hN/hstJqhH11V608DIX8484JmWPxgd
YSEuv4H02cWUMG9+MZ/Hisn/4CSh9S5qCDd7SSSzkmSF8UhFgzpsT45vhpcHlzN9ui+lWgKJ
cSXGpqEMA5axxy/GD8wl+PBclpIbL+uroHZPGPtJtde7OCFR9qydK0l8mmaElklcGgPYd0cS
KO8eMZvu8nnbXG8qL4VtyWWfp++olUWwy9KUJzbsuQos3233F60CpYz3zLDyeuh1lOAtQkIP
oaENN+oMeERsTeaNooquIPMLUvjeQo2MzGQtr/zICX8vhUPeddwGuNj8s9X0p6krBylEwqcL
BN0Odfioio4zgRRuvA/COJH5RWReAk6hrr43fsp2YDss9lnUlfTmXabinPDbPDC20WlIpdai
5gNG4dtvhCVyQCMDwKa5N2bZlyeEl5vcKNjgDce+zsDfhFMyroudASe/fk40hg+0Zn/tguat
DgffTaaE31OHB5BrXABHldcNKSBITBH8AX94PVctP050eyWN1Xz/9CLeKbxPQmI1qozC0j3m
elbtW1JEyatMiFdkJ3zJTd09V6t48DZh7CtPqSwXr9DEQCYWBKzc8lYVR9GZWLE6/U/OIXJE
5pLNPRiA5yNKwEfFiHnyyhF5EsgIgKxk5DbvOmtM3bTCNG/zBQ+vGgv6pvIVZARIPa2kx7+z
RV5hx1nmG5AEzVQNeXFOk30uFKQ75nn/QBrcgUpQeruffbw/9ywJBIB9qCBtt9y6o/hlGP3/
cY1Qstd26fyAz/mL4PEy4BLxU2ZVo9nqQeCE5LSCbvTl68P84IxRr9p0p9SxsgY71lOe7aWl
YJjtyp7BepdCAFUfl5duYPfAeIhUzBk4rTotKbMlbkGPCQuyJJjz72kkpmEKM0IxsQ11XZgv
fEc89EoqTDU1InDF5j9R2N7xkmtOT6kxkeRHdtft98HYPEbKON/qkRP6c3zRaw9nPHYJVVBs
uc4g/ipIizS+d6zkQ5whgg3dyUhWbbteUDKy8eI4cAESbSI9+0R6fQB2N5g6xatc1Jy2m7qG
uYc7rHQe8EYj/Ie1UzrVusaoYEOSyz7XattpGffeGkggyCP6NUyXDUx23YL7d5WrW3lKW4y3
Cdrn3VjRje9qEbKuh3aBsroSeBpNcTFRuajAmPGJxGI04nHoi2N4zbzOUyAdtTEA7sE6oZ50
P6jyoJzydh1oLdPlrA4/l1Q4FIsnmYA0m6oOdUEwMwUEPA3XKLcGV5c54UbAi/Kw5j+CjN4Q
bYhB32i0o6wt7cuiOC+OtyemiHVj1U7Z9agIbDA21r+61XUupFiy90piMUUMCmacRDZh+CF+
HjSnlmlvmUmZ2kqi2KHGiK+3JK4reRdTeS2sDDQwU06u1oTK983Ja2cnVncVkS+Y+OaiXAa+
/WKGtRTPbiPWeyU+c8AxE/4yh/D984v+/bdkZ8lrbtBIBrD1Ym1yUScGC+AZuQFGN1ggboI1
rizux6q9Thn/lnDbzQ0atu+PoLuxZF1x8vPo/kwmo3iLh8kRxT45RZICQ22qRyHiRpqXV0sR
X1+M4v5/RlHLmd2SVxZ7UJ/pvhdLzw+UoFQrIADMtkHFWEZL7EWL7bHHvVQBGoOlD547pysc
N5vi/I18yHVNTBp4elp1vnlh6UMG1QsmEG2TWf0JyDB6V78L8w2k4z/j5lfS0H9NwKKQl7nR
uuMV11SogK3400Jv7l87qgVEUnbqXJX/vpS5ovgEBvni3siYfBcHPIUr0XXMWmZTKWWB+sRh
Ku9bWZwwfjFQwXQPKHzHDi9h2wYuldmxTBjQnv5HC+PGFjgkFLqI+Z3n/lP39Z1bzlnpaXvX
P8UnPWn3yG0vT6xMCtLCou/w5c52OuSg9WdxHqP4Y8G4Sb1i75DSkGAuPaahLgIccIwNV3Il
gAAAAFVLSMR3aVh1AAHy/wL+mQ/QEQR0scRn+wIAAAAABFla

--lrl7g2KojMNQ8tYq
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=kernel_selftests
Content-Transfer-Encoding: quoted-printable

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7=
=2E2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5
2018-11-01 03:14:05 ln -sf /usr/bin/clang-7 /usr/bin/clang
2018-11-01 03:14:05 ln -sf /usr/bin/llc-7 /usr/bin/llc
media_tests test: not in Makefile
2018-11-01 03:14:05 make TARGETS=3Dmedia_tests
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591=
c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/media_tests'
gcc -I../ -I../../../../usr/include/    media_device_test.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools=
/testing/selftests/media_tests/media_device_test
gcc -I../ -I../../../../usr/include/    media_device_open.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools=
/testing/selftests/media_tests/media_device_open
gcc -I../ -I../../../../usr/include/    video_device_test.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools=
/testing/selftests/media_tests/video_device_test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c=
8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/media_tests'
ignored_by_lkp media_tests test

2018-11-01 03:14:12 make run_tests -C membarrier
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/membarrier'
gcc -g -I../../../../usr/include/    membarrier_test.c  -o /usr/src/perf_se=
lftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/test=
ing/selftests/membarrier/membarrier_test
TAP version 13
selftests: membarrier: membarrier_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1 sys_membarrier available
ok 2 sys membarrier invalid command test: command =3D -1, flags =3D 0, errn=
o =3D 22. Failed as expected
ok 3 sys membarrier MEMBARRIER_CMD_QUERY invalid flags test: flags =3D 1, e=
rrno =3D 22. Failed as expected
ok 4 sys membarrier MEMBARRIER_CMD_GLOBAL test: flags =3D 0
ok 5 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED not registered failure=
 test: flags =3D 0, errno =3D 1
ok 6 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED test: flags =
=3D 0
ok 7 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED test: flags =3D 0
ok 8 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE not register=
ed failure test: flags =3D 0, errno =3D 1
ok 9 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE tes=
t: flags =3D 0
ok 10 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE test: flags=
 =3D 0
ok 11 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
ok 12 sys membarrier MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED test: flags =
=3D 0
ok 13 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
Pass 13 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..13
ok 1..1 selftests: membarrier: membarrier_test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/membarrier'

2018-11-01 03:14:13 make run_tests -C memfd
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/memfd'
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/   -c -o common.o common.c
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    memfd_test.c common.o  -o /usr/src/perf_=
selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/te=
sting/selftests/memfd/memfd_test
memfd_test.c: In function =E2=80=98mfd_assert_get_seals=E2=80=99:
memfd_test.c:74:6: warning: implicit declaration of function =E2=80=98fcntl=
=E2=80=99 [-Wimplicit-function-declaration]
  r =3D fcntl(fd, F_GET_SEALS);
      ^~~~~
memfd_test.c: In function =E2=80=98mfd_assert_open=E2=80=99:
memfd_test.c:197:6: warning: implicit declaration of function =E2=80=98open=
=E2=80=99 [-Wimplicit-function-declaration]
  r =3D open(buf, flags, mode);
      ^~~~
memfd_test.c: In function =E2=80=98mfd_assert_write=E2=80=99:
memfd_test.c:328:6: warning: implicit declaration of function =E2=80=98fall=
ocate=E2=80=99 [-Wimplicit-function-declaration]
  r =3D fallocate(fd,
      ^~~~~~~~~
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    fuse_mnt.c -lfuse -pthread -o /usr/src/p=
erf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tool=
s/testing/selftests/memfd/fuse_mnt
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    fuse_test.c common.o  -o /usr/src/perf_s=
elftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/tes=
ting/selftests/memfd/fuse_test
fuse_test.c: In function =E2=80=98mfd_assert_get_seals=E2=80=99:
fuse_test.c:67:6: warning: implicit declaration of function =E2=80=98fcntl=
=E2=80=99 [-Wimplicit-function-declaration]
  r =3D fcntl(fd, F_GET_SEALS);
      ^~~~~
fuse_test.c: In function =E2=80=98main=E2=80=99:
fuse_test.c:261:7: warning: implicit declaration of function =E2=80=98open=
=E2=80=99 [-Wimplicit-function-declaration]
  fd =3D open(argv[1], O_RDONLY | O_CLOEXEC);
       ^~~~
TAP version 13
selftests: memfd: memfd_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
memfd: CREATE
memfd: BASIC
memfd: SEAL-WRITE
memfd: SEAL-SHRINK
memfd: SEAL-GROW
memfd: SEAL-RESIZE
memfd: SHARE-DUP=20
memfd: SHARE-MMAP=20
memfd: SHARE-OPEN=20
memfd: SHARE-FORK=20
memfd: SHARE-DUP (shared file-table)
memfd: SHARE-MMAP (shared file-table)
memfd: SHARE-OPEN (shared file-table)
memfd: SHARE-FORK (shared file-table)
memfd: DONE
ok 1..1 selftests: memfd: memfd_test [PASS]
selftests: memfd: run_fuse_test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
opening: ./mnt/memfd
fuse: DONE
ok 1..2 selftests: memfd: run_fuse_test.sh [PASS]
selftests: memfd: run_hugetlbfs_test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
memfd-hugetlb: CREATE
memfd-hugetlb: BASIC
memfd-hugetlb: SEAL-WRITE
memfd-hugetlb: SEAL-SHRINK
memfd-hugetlb: SEAL-GROW
memfd-hugetlb: SEAL-RESIZE
memfd-hugetlb: SHARE-DUP=20
memfd-hugetlb: SHARE-MMAP=20
memfd-hugetlb: SHARE-OPEN=20
memfd-hugetlb: SHARE-FORK=20
memfd-hugetlb: SHARE-DUP (shared file-table)
memfd-hugetlb: SHARE-MMAP (shared file-table)
memfd-hugetlb: SHARE-OPEN (shared file-table)
memfd-hugetlb: SHARE-FORK (shared file-table)
memfd: DONE
opening: ./mnt/memfd
fuse: DONE
ok 1..3 selftests: memfd: run_hugetlbfs_test.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/memfd'

2018-11-01 03:14:20 make run_tests -C memory-hotplug
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/memory-hotplug'
TAP version 13
selftests: memory-hotplug: mem-on-off-test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Test scope: 2% hotplug memory
	 online all hot-pluggable memory in offline state:
		 SKIPPED - no hot-pluggable memory in offline state
	 offline 2% hot-pluggable memory in online state
	 trying to offline 1 out of 43 memory block(s):
online->offline memory1
	 online all hot-pluggable memory in offline state:
offline->online memory1
	 Test with memory notifier error injection
ok 1..1 selftests: memory-hotplug: mem-on-off-test.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/memory-hotplug'

2018-11-01 03:14:34 make run_tests -C mount
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/mount'
gcc -Wall -O2    unprivileged-remount-test.c  -o /usr/src/perf_selftests-x8=
6_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selfte=
sts/mount/unprivileged-remount-test
TAP version 13
selftests: mount: run_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: mount: run_tests.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/mount'

2018-11-01 03:14:37 make run_tests -C mqueue
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/mqueue'
gcc -O2    mq_open_tests.c -lrt -lpthread -lpopt -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/sel=
ftests/mqueue/mq_open_tests
gcc -O2    mq_perf_tests.c -lrt -lpthread -lpopt -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/sel=
ftests/mqueue/mq_perf_tests
TAP version 13
selftests: mqueue: mq_open_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Using Default queue path - /test1

Initial system state:
	Using queue path:		/test1
	RLIMIT_MSGQUEUE(soft):		819200
	RLIMIT_MSGQUEUE(hard):		819200
	Maximum Message Size:		8192
	Maximum Queue Size:		10
	Default Message Size:		8192
	Default Queue Size:		10

Adjusted system state for testing:
	RLIMIT_MSGQUEUE(soft):		819200
	RLIMIT_MSGQUEUE(hard):		819200
	Maximum Message Size:		8192
	Maximum Queue Size:		10
	Default Message Size:		8192
	Default Queue Size:		10


Test series 1, behavior when no attr struct passed to mq_open:
Kernel supports setting defaults separately from maximums:		PASS
Given sane values, mq_open without an attr struct succeeds:		PASS
Kernel properly honors default setting knobs:				PASS
Kernel properly limits default values to lesser of default/max:		PASS
Kernel properly fails to create queue when defaults would
exceed rlimit:								PASS


Test series 2, behavior when attr struct is passed to mq_open:
Queue open in excess of rlimit max when euid =3D 0 failed:		PASS
Queue open with mq_maxmsg > limit when euid =3D 0 succeeded:		PASS
Queue open with mq_msgsize > limit when euid =3D 0 succeeded:		PASS
Queue open with total size > 2GB when euid =3D 0 failed:			PASS
Queue open in excess of rlimit max when euid =3D 99 failed:		PASS
Queue open with mq_maxmsg > limit when euid =3D 99 failed:		PASS
Queue open with mq_msgsize > limit when euid =3D 99 failed:		PASS
Queue open with total size > 2GB when euid =3D 99 failed:			PASS
ok 1..1 selftests: mqueue: mq_open_tests [PASS]
selftests: mqueue: mq_perf_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Initial system state:
	Using queue path:			/mq_perf_tests
	RLIMIT_MSGQUEUE(soft):			819200
	RLIMIT_MSGQUEUE(hard):			819200
	Maximum Message Size:			8192
	Maximum Queue Size:			10
	Nice value:				0

Adjusted system state for testing:
	RLIMIT_MSGQUEUE(soft):			(unlimited)
	RLIMIT_MSGQUEUE(hard):			(unlimited)
	Maximum Message Size:			16777216
	Maximum Queue Size:			65530
	Nice value:				-20
	Continuous mode:			(disabled)
	CPUs to pin:				1

	Queue /mq_perf_tests created:
		mq_flags:			O_NONBLOCK
		mq_maxmsg:			65530
		mq_msgsize:			16
		mq_curmsgs:			0

	Started mqueue performance test thread on CPU 1
		Max priorities:			32768
		Clock resolution:		1 nsec

	Test #1: Time send/recv message, queue empty
		(10000000 iterations)
		Send msg:			147.596547974s total time
						14759 nsec/msg
		Recv msg:			150.130935067s total time
						15013 nsec/msg

	Test #2a: Time send/recv message, queue full, constant prio
:
		(100000 iterations)
		Filling queue...done.		0.630813471s
		Testing...done.
		Send msg:			1.292862532s total time
						12928 nsec/msg
		Recv msg:			1.877316438s total time
						18773 nsec/msg
		Draining queue...done.		0.520496192s

	Test #2b: Time send/recv message, queue full, increasing prio
:
		(100000 iterations)
		Filling queue...done.		0.621102054s
		Testing...done.
		Send msg:			1.657194917s total time
						16571 nsec/msg
		Recv msg:			1.636880260s total time
						16368 nsec/msg
		Draining queue...done.		0.573276286s

	Test #2c: Time send/recv message, queue full, decreasing prio
:
		(100000 iterations)
		Filling queue...done.		0.615924126s
		Testing...done.
		Send msg:			1.707979529s total time
						17079 nsec/msg
		Recv msg:			1.635604432s total time
						16356 nsec/msg
		Draining queue...done.		0.560375351s

	Test #2d: Time send/recv message, queue full, random prio
:
		(100000 iterations)
		Filling queue...done.		0.695287009s
		Testing...done.
		Send msg:			1.780201977s total time
						17802 nsec/msg
		Recv msg:			1.696726247s total time
						16967 nsec/msg
		Draining queue...done.		0.589003793s
ok 1..2 selftests: mqueue: mq_perf_tests [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/mqueue'

2018-11-01 03:21:19 make run_tests -C net
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/net'
make ARCH=3Dx86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591=
c8ab44e711e56b8e021ffaf4f407c045f5'
  UPD     include/generated/uapi/linux/version.h
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
  HOSTCC  scripts/unifdef
  INSTALL usr/include/asm-generic/ (37 files)
  INSTALL usr/include/drm/ (26 files)
  INSTALL usr/include/linux/ (500 files)
  INSTALL usr/include/linux/android/ (1 file)
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
  INSTALL usr/include/scsi/ (4 files)
  INSTALL usr/include/scsi/fc/ (4 files)
  INSTALL usr/include/sound/ (16 files)
  INSTALL usr/include/video/ (3 files)
  INSTALL usr/include/xen/ (4 files)
  INSTALL usr/include/asm/ (62 files)
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c=
8ab44e711e56b8e021ffaf4f407c045f5'
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_bpf.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e02=
1ffaf4f407c045f5/tools/testing/selftests/net/reuseport_bpf
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_bpf_cpu.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b=
8e021ffaf4f407c045f5/tools/testing/selftests/net/reuseport_bpf_cpu
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lnuma  reu=
seport_bpf_numa.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e=
711e56b8e021ffaf4f407c045f5/tools/testing/selftests/net/reuseport_bpf_numa
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_dualstack.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e5=
6b8e021ffaf4f407c045f5/tools/testing/selftests/net/reuseport_dualstack
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseaddr=
_conflict.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56=
b8e021ffaf4f407c045f5/tools/testing/selftests/net/reuseaddr_conflict
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    tls.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407=
c045f5/tools/testing/selftests/net/tls
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    socket.c =
 -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f=
407c045f5/tools/testing/selftests/net/socket
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_fan=
out.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021=
ffaf4f407c045f5/tools/testing/selftests/net/psock_fanout
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_tpa=
cket.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e02=
1ffaf4f407c045f5/tools/testing/selftests/net/psock_tpacket
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    msg_zeroc=
opy.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021=
ffaf4f407c045f5/tools/testing/selftests/net/msg_zerocopy
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lpthread  =
tcp_mmap.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b=
8e021ffaf4f407c045f5/tools/testing/selftests/net/tcp_mmap
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lpthread  =
tcp_inq.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8=
e021ffaf4f407c045f5/tools/testing/selftests/net/tcp_inq
tcp_inq.c: In function =E2=80=98main=E2=80=99:
tcp_inq.c:178:4: warning: dereferencing type-punned pointer will break stri=
ct-aliasing rules [-Wstrict-aliasing]
    inq =3D *((int *) CMSG_DATA(cm));
    ^~~
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_snd=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021f=
faf4f407c045f5/tools/testing/selftests/net/psock_snd
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso.c =
 -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f=
407c045f5/tools/testing/selftests/net/udpgso
udpgso.c: In function =E2=80=98send_one=E2=80=99:
udpgso.c:484:3: warning: dereferencing type-punned pointer will break stric=
t-aliasing rules [-Wstrict-aliasing]
   *((uint16_t *) CMSG_DATA(cm)) =3D gso_len;
   ^
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso_be=
nch_tx.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e=
021ffaf4f407c045f5/tools/testing/selftests/net/udpgso_bench_tx
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso_be=
nch_rx.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e=
021ffaf4f407c045f5/tools/testing/selftests/net/udpgso_bench_rx
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    ip_defrag=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021f=
faf4f407c045f5/tools/testing/selftests/net/ip_defrag
TAP version 13
selftests: net: reuseport_bpf
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- IPv4 UDP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing EBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 UDP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing EBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 UDP w/ mapped IPv4 ----
Testing EBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
---- IPv4 TCP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 TCP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 TCP w/ mapped IPv4 ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing filter add without bind...
SUCCESS
ok 1..1 selftests: net: reuseport_bpf [PASS]
selftests: net: reuseport_bpf_cpu
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- IPv4 UDP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
---- IPv6 UDP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
---- IPv4 TCP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
---- IPv6 TCP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
SUCCESS
ok 1..2 selftests: net: reuseport_bpf_cpu [PASS]
selftests: net: reuseport_bpf_numa
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- IPv4 UDP ----
send node 0, receive socket 0
send node 0, receive socket 0
---- IPv6 UDP ----
send node 0, receive socket 0
send node 0, receive socket 0
---- IPv4 TCP ----
send node 0, receive socket 0
send node 0, receive socket 0
---- IPv6 TCP ----
send node 0, receive socket 0
send node 0, receive socket 0
SUCCESS
ok 1..3 selftests: net: reuseport_bpf_numa [PASS]
selftests: net: reuseport_dualstack
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- UDP IPv4 created before IPv6 ----
---- UDP IPv6 created before IPv4 ----
---- UDP IPv4 created before IPv6 (large) ----
---- UDP IPv6 created before IPv4 (large) ----
---- TCP IPv4 created before IPv6 ----
---- TCP IPv6 created before IPv4 ----
SUCCESS
ok 1..4 selftests: net: reuseport_dualstack [PASS]
selftests: net: reuseaddr_conflict
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Opening 127.0.0.1:9999
Opening INADDR_ANY:9999
bind: Address already in use
Opening in6addr_any:9999
Opening INADDR_ANY:9999
bind: Address already in use
Opening INADDR_ANY:9999 after closing ipv6 socket
bind: Address already in use
Successok 1..5 selftests: net: reuseaddr_conflict [PASS]
selftests: net: tls
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 29 tests from 2 test cases.
[ RUN      ] tls.sendfile
[       OK ] tls.sendfile
[ RUN      ] tls.send_then_sendfile
[       OK ] tls.send_then_sendfile
[ RUN      ] tls.recv_max
[       OK ] tls.recv_max
[ RUN      ] tls.recv_small
[       OK ] tls.recv_small
[ RUN      ] tls.msg_more
[       OK ] tls.msg_more
[ RUN      ] tls.sendmsg_single
[       OK ] tls.sendmsg_single
[ RUN      ] tls.sendmsg_large
[       OK ] tls.sendmsg_large
[ RUN      ] tls.sendmsg_multiple
[       OK ] tls.sendmsg_multiple
[ RUN      ] tls.sendmsg_multiple_stress
[       OK ] tls.sendmsg_multiple_stress
[ RUN      ] tls.splice_from_pipe
[       OK ] tls.splice_from_pipe
[ RUN      ] tls.splice_from_pipe2
[       OK ] tls.splice_from_pipe2
[ RUN      ] tls.send_and_splice
[       OK ] tls.send_and_splice
[ RUN      ] tls.splice_to_pipe
[       OK ] tls.splice_to_pipe
[ RUN      ] tls.recvmsg_single
[       OK ] tls.recvmsg_single
[ RUN      ] tls.recvmsg_single_max
[       OK ] tls.recvmsg_single_max
[ RUN      ] tls.recvmsg_multiple
[       OK ] tls.recvmsg_multiple
[ RUN      ] tls.single_send_multiple_recv
[       OK ] tls.single_send_multiple_recv
[ RUN      ] tls.multiple_send_single_recv
[       OK ] tls.multiple_send_single_recv
[ RUN      ] tls.recv_partial
[       OK ] tls.recv_partial
[ RUN      ] tls.recv_nonblock
[       OK ] tls.recv_nonblock
[ RUN      ] tls.recv_peek
[       OK ] tls.recv_peek
[ RUN      ] tls.recv_peek_multiple
[       OK ] tls.recv_peek_multiple
[ RUN      ] tls.recv_peek_multiple_records
[       OK ] tls.recv_peek_multiple_records
[ RUN      ] tls.recv_peek_large_buf_mult_recs
[       OK ] tls.recv_peek_large_buf_mult_recs
[ RUN      ] tls.pollin
[       OK ] tls.pollin
[ RUN      ] tls.poll_wait
[       OK ] tls.poll_wait
[ RUN      ] tls.blocking
[       OK ] tls.blocking
[ RUN      ] tls.nonblocking
[       OK ] tls.nonblocking
[ RUN      ] tls.control_msg
[       OK ] tls.control_msg
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 29 / 29 tests passed.
[  PASSED  ]
ok 1..6 selftests: net: tls [PASS]
selftests: net: run_netsocktests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--------------------
running socket test
--------------------
[PASS]
ok 1..7 selftests: net: run_netsocktests [PASS]
selftests: net: run_afpackettests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--------------------
running psock_fanout test
--------------------
test: control single socket
test: control multiple sockets
test: unique ids

test: datapath 0x0 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D0,20, expect=3D15,5
warning: incorrect queue lengths
info: count=3D0,20, expect=3D20,5
warning: incorrect queue lengths
info: trying alternate ports (20)

test: datapath 0x0 ports 8000,8003
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D5,20, expect=3D20,5

test: datapath 0x1000 ports 8000,8003
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D15,20, expect=3D20,15

test: datapath 0x1 ports 8000,8003
info: count=3D0,0, expect=3D0,0
info: count=3D10,10, expect=3D10,10
info: count=3D17,18, expect=3D18,17

test: datapath 0x3 ports 8000,8003
info: count=3D0,0, expect=3D0,0
info: count=3D15,5, expect=3D15,5
info: count=3D20,15, expect=3D20,15

test: datapath 0x6 ports 8000,8003
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D20,15, expect=3D15,20

test: datapath 0x7 ports 8000,8003
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D20,15, expect=3D15,20

test: datapath 0x2 ports 8000,8003
info: count=3D0,0, expect=3D0,0
info: count=3D20,0, expect=3D20,0
info: count=3D20,0, expect=3D20,0

test: datapath 0x2 ports 8000,8003
info: count=3D0,0, expect=3D0,0
info: count=3D0,20, expect=3D0,20
info: count=3D0,20, expect=3D0,20

test: datapath 0x2000 ports 8000,8003
info: count=3D0,0, expect=3D0,0
info: count=3D20,20, expect=3D20,20
info: count=3D20,20, expect=3D20,20
OK. All tests passed
[PASS]
--------------------
running psock_tpacket test
--------------------
test: TPACKET_V1 with PACKET_RX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V1 with PACKET_TX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V2 with PACKET_RX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V2 with PACKET_TX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V3 with PACKET_RX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V3 with PACKET_TX_RING .................... 100 pkts (14200 b=
ytes)
OK. All tests passed
[PASS]
ok 1..8 selftests: net: run_afpackettests [PASS]
selftests: net: test_bpf.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
test_bpf: ok
ok 1..9 selftests: net: test_bpf.sh [PASS]
selftests: net: netdevice.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
SKIP: eth0: interface already up
Cannot get device udp-fragmentation-offload settings: Operation not support=
ed
PASS: eth0: ethtool list features
PASS: eth0: ethtool dump
PASS: eth0: ethtool stats
SKIP: eth0: interface kept up
ok 1..10 selftests: net: netdevice.sh [PASS]
selftests: net: rtnetlink.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PASS: policy routing
PASS: route get
PASS: tc htb hierarchy
PASS: gre tunnel endpoint
PASS: gretap
RTNETLINK answers: Operation not supported
Cannot find device "ip6gretap00"
Cannot find device "ip6gretap00"
Cannot find device "ip6gretap00"
RTNETLINK answers: Operation not supported
Cannot find device "ip6gretap00"
FAIL: ip6gretap
PASS: erspan
RTNETLINK answers: Operation not supported
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
RTNETLINK answers: Operation not supported
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
RTNETLINK answers: Operation not supported
Cannot find device "ip6erspan00"
FAIL: ip6erspan
PASS: bridge setup
PASS: ipv6 addrlabel
PASS: set ifalias 82e99eb8-f8d9-41da-9405-f42706a55eb8 for test-dummy0
PASS: vrf
PASS: vxlan
PASS: fou
PASS: macsec
PASS: ipsec
FAIL: ipsec_offload netdevsim doesn't support IPsec offload
ok 1..11 selftests: net: rtnetlink.sh [PASS]
selftests: net: fib_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Single path route test
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    Nexthop device deleted
    TEST: IPv4 fibmatch - no route                                      [ O=
K ]
    TEST: IPv6 fibmatch - no route                                      [ O=
K ]

Multipath route test
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    One nexthop device deleted
    TEST: IPv4 - multipath route removed on delete                      [ O=
K ]
    TEST: IPv6 - multipath down to single path                          [ O=
K ]
    Second nexthop device deleted
    TEST: IPv6 - no route                                               [ O=
K ]

Single path, admin down
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    Route deleted on down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]

Admin down multipath
    Verify start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    One device down, one up
    TEST: IPv4 fibmatch on down device                                  [ O=
K ]
    TEST: IPv6 fibmatch on down device                                  [ O=
K ]
    TEST: IPv4 fibmatch on up device                                    [ O=
K ]
    TEST: IPv6 fibmatch on up device                                    [ O=
K ]
    TEST: IPv4 flags on down device                                     [ O=
K ]
    TEST: IPv6 flags on down device                                     [ O=
K ]
    TEST: IPv4 flags on up device                                       [ O=
K ]
    TEST: IPv6 flags on up device                                       [ O=
K ]
    Other device down and up
    TEST: IPv4 fibmatch on down device                                  [ O=
K ]
    TEST: IPv6 fibmatch on down device                                  [ O=
K ]
    TEST: IPv4 fibmatch on up device                                    [ O=
K ]
    TEST: IPv6 fibmatch on up device                                    [ O=
K ]
    TEST: IPv4 flags on down device                                     [ O=
K ]
    TEST: IPv6 flags on down device                                     [ O=
K ]
    TEST: IPv4 flags on up device                                       [ O=
K ]
    TEST: IPv6 flags on up device                                       [ O=
K ]
    Both devices down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]

Local carrier tests - single path
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 - no linkdown flag                                       [ O=
K ]
    TEST: IPv6 - no linkdown flag                                       [ O=
K ]
    Carrier off on nexthop
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 - linkdown flag set                                      [ O=
K ]
    TEST: IPv6 - linkdown flag set                                      [ O=
K ]
    Route to local address with carrier down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 linkdown flag set                                        [ O=
K ]
    TEST: IPv6 linkdown flag set                                        [ O=
K ]

Single path route carrier test
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 no linkdown flag                                         [ O=
K ]
    TEST: IPv6 no linkdown flag                                         [ O=
K ]
    Carrier down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 linkdown flag set                                        [ O=
K ]
    TEST: IPv6 linkdown flag set                                        [ O=
K ]
    Second address added with carrier down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 linkdown flag set                                        [ O=
K ]
    TEST: IPv6 linkdown flag set                                        [ O=
K ]

IPv4 nexthop tests
<<< write me >>>

IPv6 nexthop tests
    TEST: Directly connected nexthop, unicast address                   [ O=
K ]
    TEST: Directly connected nexthop, unicast address with device       [ O=
K ]
    TEST: Gateway is linklocal address                                  [ O=
K ]
    TEST: Gateway is linklocal address, no device                       [ O=
K ]
    TEST: Gateway can not be local unicast address                      [ O=
K ]
    TEST: Gateway can not be local unicast address, with device         [ O=
K ]
    TEST: Gateway can not be a local linklocal address                  [ O=
K ]
    TEST: Gateway can be local address in a VRF                         [ O=
K ]
    TEST: Gateway can be local address in a VRF, with device            [ O=
K ]
    TEST: Gateway can be local linklocal address in a VRF               [ O=
K ]
    TEST: Redirect to VRF lookup                                        [ O=
K ]
    TEST: VRF route, gateway can be local address in default VRF        [ O=
K ]
    TEST: VRF route, gateway can not be a local address                 [ O=
K ]
    TEST: VRF route, gateway can not be a local addr with device        [ O=
K ]

IPv6 route add / append tests
    TEST: Attempt to add duplicate route - gw                           [ O=
K ]
    TEST: Attempt to add duplicate route - dev only                     [ O=
K ]
    TEST: Attempt to add duplicate route - reject route                 [ O=
K ]
    TEST: Append nexthop to existing route - gw                         [ O=
K ]
    TEST: Add multipath route                                           [ O=
K ]
    TEST: Attempt to add duplicate multipath route                      [ O=
K ]
    TEST: Route add with different metrics                              [ O=
K ]
    TEST: Route delete with metric                                      [ O=
K ]

IPv6 route replace tests
    TEST: Single path with single path                                  [ O=
K ]
    TEST: Single path with multipath                                    [ O=
K ]
    TEST: Single path with single path via multipath attribute          [ O=
K ]
    TEST: Invalid nexthop                                               [ O=
K ]
    TEST: Single path - replace of non-existent route                   [ O=
K ]
    TEST: Multipath with multipath                                      [ O=
K ]
    TEST: Multipath with single path                                    [ O=
K ]
    TEST: Multipath with single path via multipath attribute            [ O=
K ]
    TEST: Multipath - invalid first nexthop                             [ O=
K ]
    TEST: Multipath - invalid second nexthop                            [ O=
K ]
    TEST: Multipath - replace of non-existent route                     [ O=
K ]

IPv4 route add / append tests
    TEST: Attempt to add duplicate route - gw                           [ O=
K ]
    TEST: Attempt to add duplicate route - dev only                     [ O=
K ]
    TEST: Attempt to add duplicate route - reject route                 [ O=
K ]
    TEST: Add new nexthop for existing prefix                           [ O=
K ]
    TEST: Append nexthop to existing route - gw                         [ O=
K ]
    TEST: Append nexthop to existing route - dev only                   [ O=
K ]
    TEST: Append nexthop to existing route - reject route               [ O=
K ]
    TEST: Append nexthop to existing reject route - gw                  [ O=
K ]
    TEST: Append nexthop to existing reject route - dev only            [ O=
K ]
    TEST: add multipath route                                           [ O=
K ]
    TEST: Attempt to add duplicate multipath route                      [ O=
K ]
    TEST: Route add with different metrics                              [ O=
K ]
    TEST: Route delete with metric                                      [ O=
K ]

IPv4 route replace tests
    TEST: Single path with single path                                  [ O=
K ]
    TEST: Single path with multipath                                    [ O=
K ]
    TEST: Single path with reject route                                 [ O=
K ]
    TEST: Single path with single path via multipath attribute          [ O=
K ]
    TEST: Invalid nexthop                                               [ O=
K ]
    TEST: Single path - replace of non-existent route                   [ O=
K ]
    TEST: Multipath with multipath                                      [ O=
K ]
    TEST: Multipath with single path                                    [ O=
K ]
    TEST: Multipath with single path via multipath attribute            [ O=
K ]
    TEST: Multipath with reject route                                   [ O=
K ]
    TEST: Multipath - invalid first nexthop                             [ O=
K ]
    TEST: Multipath - invalid second nexthop                            [ O=
K ]
    TEST: Multipath - replace of non-existent route                     [ O=
K ]

IPv6 prefix route tests
    TEST: Default metric                                                [ O=
K ]
    TEST: User specified metric on first device                         [ O=
K ]
    TEST: User specified metric on second device                        [ O=
K ]
    TEST: Delete of address on first device                             [ O=
K ]
    TEST: Modify metric of address                                      [ O=
K ]
Command line is not complete. Try option "help"
    TEST: Prefix route removed on link down                             [ O=
K ]
    TEST: Prefix route with metric on link up                           [ O=
K ]

IPv4 prefix route tests
    TEST: Default metric                                                [ O=
K ]
    TEST: User specified metric on first device                         [ O=
K ]
    TEST: User specified metric on second device                        [ O=
K ]
    TEST: Delete of address on first device                             [ O=
K ]
    TEST: Modify metric of address                                      [ O=
K ]
Command line is not complete. Try option "help"
    TEST: Prefix route removed on link down                             [ O=
K ]
    TEST: Prefix route with metric on link up                           [ O=
K ]

IPv6 routes with metrics
    TEST: Single path route with mtu metric                             [ O=
K ]
    TEST: Multipath route via 2 single routes with mtu metric on first  [ O=
K ]
    TEST: Multipath route via 2 single routes with mtu metric on 2nd    [ O=
K ]
    TEST:     MTU of second leg                                         [ O=
K ]
    TEST: Multipath route with mtu metric                               [ O=
K ]
    TEST: Using route with mtu metric                                   [ O=
K ]
    TEST: Invalid metric (fails metric_convert)                         [ O=
K ]

IPv4 route add / append tests
    TEST: Single path route with mtu metric                             [ O=
K ]
    TEST: Multipath route with mtu metric                               [ O=
K ]
    TEST: Using route with mtu metric                                   [ O=
K ]
    TEST: Invalid metric (fails metric_convert)                         [ O=
K ]

Tests passed: 141
Tests failed:   0
ok 1..12 selftests: net: fib_tests.sh [PASS]
selftests: net: fib-onlink-tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

########################################
Configuring interfaces
RTNETLINK answers: File exists
not ok 1..13 selftests: net: fib-onlink-tests.sh [FAIL]
selftests: net: pmtu.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
TEST: ipv4: PMTU exceptions                                         [ OK ]
connect: Cannot assign requested address
connect: Cannot assign requested address
TEST: ipv6: PMTU exceptions                                         [FAIL]
  PMTU exception wasn't created after exceeding MTU
TEST: vti6: PMTU exceptions                                         [ OK ]
TEST: vti4: PMTU exceptions                                         [ OK ]
TEST: vti4: default MTU assignment                                  [ OK ]
TEST: vti6: default MTU assignment                                  [ OK ]
TEST: vti4: MTU setting on link creation                            [ OK ]
TEST: vti6: MTU setting on link creation                            [ OK ]
TEST: vti6: MTU changes on link changes                             [ OK ]
not ok 1..14 selftests: net: pmtu.sh [FAIL]
selftests: net: udpgso.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4 cmsg
device mtu (orig): 65536
device mtu (test): 1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv4 setsockopt
device mtu (orig): 65536
device mtu (test): 1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv6 cmsg
device mtu (orig): 65536
device mtu (test): 1500
ipv6 tx:1 gso:0=20
ipv6 tx:1452 gso:0=20
ipv6 tx:1453 gso:0 (fail)
ipv6 tx:1452 gso:1452 (fail)
ipv6 tx:1453 gso:1452=20
ipv6 tx:2904 gso:1452=20
ipv6 tx:2905 gso:1452=20
ipv6 tx:65340 gso:1452=20
ipv6 tx:65527 gso:1452=20
ipv6 tx:65528 gso:1452 (fail)
ipv6 tx:1 gso:1 (fail)
ipv6 tx:2 gso:1=20
ipv6 tx:5 gso:2=20
ipv6 tx:16 gso:1=20
ipv6 tx:17 gso:1 (fail)
OK
ipv6 setsockopt
device mtu (orig): 65536
device mtu (test): 1500
ipv6 tx:1 gso:0=20
ipv6 tx:1452 gso:0=20
ipv6 tx:1453 gso:0 (fail)
ipv6 tx:1452 gso:1452 (fail)
ipv6 tx:1453 gso:1452=20
ipv6 tx:2904 gso:1452=20
ipv6 tx:2905 gso:1452=20
ipv6 tx:65340 gso:1452=20
ipv6 tx:65527 gso:1452=20
ipv6 tx:65528 gso:1452 (fail)
ipv6 tx:1 gso:1 (fail)
ipv6 tx:2 gso:1=20
ipv6 tx:5 gso:2=20
ipv6 tx:16 gso:1=20
ipv6 tx:17 gso:1 (fail)
OK
ipv4 connected
device mtu (orig): 65536
device mtu (test): 1600
route mtu (test): 1500
path mtu (read):  1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv4 msg_more
device mtu (orig): 65536
device mtu (test): 1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv6 msg_more
device mtu (orig): 65536
device mtu (test): 1500
ipv6 tx:1 gso:0=20
ipv6 tx:1452 gso:0=20
ipv6 tx:1453 gso:0 (fail)
ipv6 tx:1452 gso:1452 (fail)
ipv6 tx:1453 gso:1452=20
ipv6 tx:2904 gso:1452=20
ipv6 tx:2905 gso:1452=20
ipv6 tx:65340 gso:1452=20
ipv6 tx:65527 gso:1452=20
ipv6 tx:65528 gso:1452 (fail)
ipv6 tx:1 gso:1 (fail)
ipv6 tx:2 gso:1=20
ipv6 tx:5 gso:2=20
ipv6 tx:16 gso:1=20
ipv6 tx:17 gso:1 (fail)
OK
ok 1..15 selftests: net: udpgso.sh [PASS]
selftests: net: ip_defrag.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4 defrag
PASS
seed =3D 1541042704
ipv4 defrag with overlaps
PASS
seed =3D 1541042713
ipv6 defrag
PASS
seed =3D 1541042744
ipv6 defrag with overlaps
PASS
seed =3D 1541042745
ok 1..16 selftests: net: ip_defrag.sh [PASS]
selftests: net: udpgso_bench.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4
tcp
tcp tx:    404 MB/s     6868 calls/s   6868 msg/s
tcp rx:    404 MB/s     6609 calls/s
tcp tx:    365 MB/s     6198 calls/s   6198 msg/s
tcp rx:    365 MB/s     6066 calls/s
tcp tx:    301 MB/s     5121 calls/s   5121 msg/s
tcp rx:    301 MB/s     5041 calls/s
tcp zerocopy
tcp rx:    242 MB/s     3955 calls/s
tcp tx:    242 MB/s     4119 calls/s   4119 msg/s
tcp tx:    283 MB/s     4814 calls/s   4814 msg/s
tcp rx:    286 MB/s     4369 calls/s
tcp tx:    278 MB/s     4716 calls/s   4716 msg/s
tcp rx:    276 MB/s     4128 calls/s
udp
udp rx:     37 MB/s    27038 calls/s
udp tx:     39 MB/s    27888 calls/s    664 msg/s
udp rx:     40 MB/s    28511 calls/s
udp tx:     41 MB/s    29778 calls/s    709 msg/s
udp rx:     40 MB/s    29047 calls/s
udp tx:     41 MB/s    29484 calls/s    702 msg/s
udp rx:     39 MB/s    27825 calls/s
udp gso
udp rx:    138 MB/s    98985 calls/s
udp tx:    142 MB/s     2423 calls/s   2423 msg/s
udp rx:    129 MB/s    92050 calls/s
udp tx:    141 MB/s     2395 calls/s   2395 msg/s
udp rx:    140 MB/s    99778 calls/s
udp tx:    148 MB/s     2515 calls/s   2515 msg/s
udp rx:    137 MB/s    97612 calls/s
ipv6
tcp
tcp tx:    389 MB/s     6614 calls/s   6614 msg/s
tcp rx:    390 MB/s     6516 calls/s
tcp tx:    292 MB/s     4953 calls/s   4953 msg/s
tcp rx:    293 MB/s     4889 calls/s
tcp tx:    342 MB/s     5811 calls/s   5811 msg/s
tcp rx:    341 MB/s     5575 calls/s
tcp zerocopy
tcp tx:    282 MB/s     4786 calls/s   4786 msg/s
tcp rx:    285 MB/s     4386 calls/s
tcp tx:    296 MB/s     5021 calls/s   5021 msg/s
tcp rx:    293 MB/s     4053 calls/s
tcp tx:    249 MB/s     4234 calls/s   4234 msg/s
tcp rx:    251 MB/s     3771 calls/s
udp
udp rx:     36 MB/s    26629 calls/s
udp tx:     37 MB/s    27434 calls/s    638 msg/s
udp rx:     34 MB/s    24992 calls/s
udp tx:     35 MB/s    25714 calls/s    598 msg/s
udp rx:     34 MB/s    25520 calls/s
udp tx:     36 MB/s    26531 calls/s    617 msg/s
udp rx:     35 MB/s    25741 calls/s
udp gso
udp rx:    136 MB/s    99704 calls/s
udp tx:    144 MB/s     2445 calls/s   2445 msg/s
udp rx:    123 MB/s    90363 calls/s
udp tx:    132 MB/s     2239 calls/s   2239 msg/s
udp rx:     99 MB/s    72199 calls/s
udp tx:    116 MB/s     1977 calls/s   1977 msg/s
udp rx:    136 MB/s    99764 calls/s
ok 1..17 selftests: net: udpgso_bench.sh [PASS]
selftests: net: fib_rule_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

######################################################################
TEST SECTION: IPv4 fib rule
######################################################################

    TEST: rule4 check: oif dummy0                             [ OK ]

    TEST: rule4 del by pref: oif dummy0                       [ OK ]
RTNETLINK answers: No route to host

    TEST: rule4 check: from 192.51.100.3 iif dummy0           [FAIL]

    TEST: rule4 del by pref: from 192.51.100.3 iif dummy0     [ OK ]

    TEST: rule4 check: tos 0x10                               [ OK ]

    TEST: rule4 del by pref: tos 0x10                         [ OK ]

    TEST: rule4 check: fwmark 0x64                            [ OK ]

    TEST: rule4 del by pref: fwmark 0x64                      [ OK ]

    TEST: rule4 check: uidrange 100-100                       [ OK ]

    TEST: rule4 del by pref: uidrange 100-100                 [ OK ]

    TEST: rule4 check: sport 666 dport 777                    [ OK ]

    TEST: rule4 del by pref: sport 666 dport 777              [ OK ]

    TEST: rule4 check: ipproto tcp                            [ OK ]

    TEST: rule4 del by pref: ipproto tcp                      [ OK ]

    TEST: rule4 check: ipproto icmp                           [ OK ]

    TEST: rule4 del by pref: ipproto icmp                     [ OK ]

######################################################################
TEST SECTION: IPv6 fib rule
######################################################################

    TEST: rule6 check: oif dummy0                             [ OK ]

    TEST: rule6 del by pref: oif dummy0                       [ OK ]

    TEST: rule6 check: from 2001:db8:1::3 iif dummy0          [ OK ]

    TEST: rule6 del by pref: from 2001:db8:1::3 iif dummy0    [ OK ]

    TEST: rule6 check: tos 0x10                               [ OK ]

    TEST: rule6 del by pref: tos 0x10                         [ OK ]

    TEST: rule6 check: fwmark 0x64                            [ OK ]

    TEST: rule6 del by pref: fwmark 0x64                      [ OK ]

    TEST: rule6 check: uidrange 100-100                       [ OK ]

    TEST: rule6 del by pref: uidrange 100-100                 [ OK ]

    TEST: rule6 check: sport 666 dport 777                    [ OK ]

    TEST: rule6 del by pref: sport 666 dport 777              [ OK ]

    TEST: rule6 check: ipproto tcp                            [ OK ]

    TEST: rule6 del by pref: ipproto tcp                      [ OK ]

    TEST: rule6 check: ipproto icmp                           [ OK ]

    TEST: rule6 del by pref: ipproto icmp                     [ OK ]
ok 1..18 selftests: net: fib_rule_tests.sh [PASS]
selftests: net: msg_zerocopy.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4 tcp -t 1
=2E/msg_zerocopy: setaffinity 2
=2E/msg_zerocopy: setaffinity 3
not ok 1..19 selftests: net: msg_zerocopy.sh [FAIL]
selftests: net: psock_snd.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
dgram
tx: 128
rx: 142
rx: 100
OK

dgram bind
tx: 128
rx: 142
rx: 100
OK

raw
tx: 142
rx: 142
rx: 100
OK

raw bind
tx: 142
rx: 142
rx: 100
OK

raw qdisc bypass
tx: 142
rx: 142
rx: 100
OK

raw vlan
tx: 146
rx: 100
OK

raw vnet hdr
tx: 152
rx: 142
rx: 100
OK

raw csum_off
tx: 152
rx: 142
rx: 100
OK

raw csum_off with bad offset (fails)
=2E/psock_snd: write: Invalid argument
raw min size
tx: 42
rx: 0
OK

raw mtu size
tx: 1514
rx: 1472
OK

raw mtu size + 1 (fails)
=2E/psock_snd: write: Message too long
raw vlan mtu size + 1 (fails)
=2E/psock_snd: write: Message too long
dgram mtu size
tx: 1500
rx: 1472
OK

dgram mtu size + 1 (fails)
=2E/psock_snd: write: Message too long
raw truncate hlen (fails: does not arrive)
tx: 14
=2E/psock_snd: recv: Resource temporarily unavailable
raw truncate hlen - 1 (fails: EINVAL)
=2E/psock_snd: write: Invalid argument
raw gso min size
tx: 1525
rx: 1473
OK

raw gso min size - 1 (fails)
tx: 1524
=2E/psock_snd: recv: Resource temporarily unavailable
raw gso max size
tx: 65559
rx: 65507
OK

raw gso max size + 1 (fails)
tx: 65560
=2E/psock_snd: recv: Resource temporarily unavailable
OK. All tests passed
ok 1..20 selftests: net: psock_snd.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/net'

2018-11-01 03:26:31 make run_tests -C nsfs
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/nsfs'
gcc -Wall -Werror    owner.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4e=
d591c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/nsfs/owner
gcc -Wall -Werror    pidns.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4e=
d591c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/nsfs/pidns
TAP version 13
selftests: nsfs: owner
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: nsfs: owner [PASS]
selftests: nsfs: pidns
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..2 selftests: nsfs: pidns [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/nsfs'
ignored_by_lkp powerpc test
prctl test: not in Makefile
2018-11-01 03:26:33 make TARGETS=3Dprctl
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591=
c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/prctl'
Makefile:14: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
gcc     disable-tsc-ctxt-sw-stress-test.c   -o disable-tsc-ctxt-sw-stress-t=
est
gcc     disable-tsc-on-off-stress-test.c   -o disable-tsc-on-off-stress-test
gcc     disable-tsc-test.c   -o disable-tsc-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c=
8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/prctl'

2018-11-01 03:26:35 make run_tests -C prctl
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/prctl'
Makefile:14: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
TAP version 13
selftests: prctl: disable-tsc-ctxt-sw-stress-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[No further output means we're allright]
ok 1..1 selftests: prctl: disable-tsc-ctxt-sw-stress-test [PASS]
selftests: prctl: disable-tsc-on-off-stress-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[No further output means we're allright]
ok 1..2 selftests: prctl: disable-tsc-on-off-stress-test [PASS]
selftests: prctl: disable-tsc-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
rdtsc() =3D=3D 2136876715236
prctl(PR_GET_TSC, &tsc_val); tsc_val =3D=3D PR_TSC_ENABLE
rdtsc() =3D=3D 2136879059273
prctl(PR_SET_TSC, PR_TSC_ENABLE)
rdtsc() =3D=3D 2136880080692
prctl(PR_SET_TSC, PR_TSC_SIGSEGV)
rdtsc() =3D=3D [ SIG_SEGV ]
prctl(PR_GET_TSC, &tsc_val); tsc_val =3D=3D PR_TSC_SIGSEGV
prctl(PR_SET_TSC, PR_TSC_ENABLE)
rdtsc() =3D=3D 2136884106335
ok 1..3 selftests: prctl: disable-tsc-test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/prctl'

2018-11-01 03:26:58 make run_tests -C proc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/proc'
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-001-lookup.c  -o /us=
r/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045=
f5/tools/testing/selftests/proc/fd-001-lookup
fd-001-lookup.c:17:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-002-posix-eq.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c0=
45f5/tools/testing/selftests/proc/fd-002-posix-eq
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-003-kthread.c  -o /u=
sr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c04=
5f5/tools/testing/selftests/proc/fd-003-kthread
fd-003-kthread.c:17:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-loadavg-001.c  -o =
/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c=
045f5/tools/testing/selftests/proc/proc-loadavg-001
proc-loadavg-001.c:17:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-map-files-001=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021f=
faf4f407c045f5/tools/testing/selftests/proc/proc-self-map-files-001
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-map-files-002=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021f=
faf4f407c045f5/tools/testing/selftests/proc/proc-self-map-files-002
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-syscall.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407=
c045f5/tools/testing/selftests/proc/proc-self-syscall
proc-self-syscall.c:16:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-wchan.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c0=
45f5/tools/testing/selftests/proc/proc-self-wchan
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-uptime-001.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c0=
45f5/tools/testing/selftests/proc/proc-uptime-001
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-uptime-002.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c0=
45f5/tools/testing/selftests/proc/proc-uptime-002
proc-uptime-002.c:18:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    read.c  -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/=
testing/selftests/proc/read
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    self.c  -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/=
testing/selftests/proc/self
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    thread-self.c  -o /usr/=
src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5=
/tools/testing/selftests/proc/thread-self
TAP version 13
selftests: proc: fd-001-lookup
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: proc: fd-001-lookup [PASS]
selftests: proc: fd-002-posix-eq
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..2 selftests: proc: fd-002-posix-eq [PASS]
selftests: proc: fd-003-kthread
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..3 selftests: proc: fd-003-kthread [PASS]
selftests: proc: proc-loadavg-001
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..4 selftests: proc: proc-loadavg-001 [PASS]
selftests: proc: proc-self-map-files-001
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..5 selftests: proc: proc-self-map-files-001 [PASS]
selftests: proc: proc-self-map-files-002
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..6 selftests: proc: proc-self-map-files-002 [PASS]
selftests: proc: proc-self-syscall
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..7 selftests: proc: proc-self-syscall [PASS]
selftests: proc: proc-self-wchan
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..8 selftests: proc: proc-self-wchan [PASS]
selftests: proc: proc-uptime-001
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..9 selftests: proc: proc-uptime-001 [PASS]
selftests: proc: proc-uptime-002
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..10 selftests: proc: proc-uptime-002 [PASS]
selftests: proc: read
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..11 selftests: proc: read [PASS]
selftests: proc: self
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..12 selftests: proc: self [PASS]
selftests: proc: thread-self
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..13 selftests: proc: thread-self [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/proc'

2018-11-01 03:27:17 make run_tests -C pstore
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/pstore'
TAP version 13
selftests: pstore: pstore_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D Pstore unit tests (pstore_tests) =3D=3D=3D
UUID=3D1b5b7a14-1391-4488-bee4-2ba136be2c20
Checking pstore backend is registered ... ok
	backend=3Dramoops
	cmdline=3Dip=3D::::vm-lkp-nex04-8G-16::dhcp root=3D/dev/ram0 user=3Dlkp jo=
b=3D/lkp/jobs/scheduled/vm-lkp-nex04-8G-16/kernel_selftests-kselftests-02-d=
ebian-x86_64-2018-04-03.cgz-4ed591c8ab44e711e56b8e021ffaf4f407c045f5-201811=
01-5823-1u1bjks-3.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-7.2 branch=3Dlin=
ux-devel/devel-hourly-2018102918 commit=3D4ed591c8ab44e711e56b8e021ffaf4f40=
7c045f5 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-7.2/gcc-7/4ed591c8ab44e711e56b8=
e021ffaf4f407c045f5/vmlinuz-4.19.0-04691-g4ed591c erst_disable max_uptime=
=3D3600 RESULT_ROOT=3D/result/kernel_selftests/kselftests-02/vm-lkp-nex04-8=
G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/4ed591c8ab44e711e56b8e=
021ffaf4f407c045f5/3 LKP_SERVER=3Dinn debug apic=3Ddebug sysrq_always_enabl=
ed rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don=
 panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ram=
disk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ig=
nore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115=
200 vga=3Dnormal rw rcuperf.shutdown=3D0
Checking pstore console is registered ... ok
Checking /dev/pmsg0 exists ... ok
Writing unique string to /dev/pmsg0 ... ok
ok 1..1 selftests: pstore: pstore_tests [PASS]
selftests: pstore: pstore_post_reboot_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D Pstore unit tests (pstore_post_reboot_tests) =3D=3D=3D
UUID=3Da2c028aa-199b-4365-b403-f8831048e36b
Checking pstore backend is registered ... ok
	backend=3Dramoops
	cmdline=3Dip=3D::::vm-lkp-nex04-8G-16::dhcp root=3D/dev/ram0 user=3Dlkp jo=
b=3D/lkp/jobs/scheduled/vm-lkp-nex04-8G-16/kernel_selftests-kselftests-02-d=
ebian-x86_64-2018-04-03.cgz-4ed591c8ab44e711e56b8e021ffaf4f407c045f5-201811=
01-5823-1u1bjks-3.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-7.2 branch=3Dlin=
ux-devel/devel-hourly-2018102918 commit=3D4ed591c8ab44e711e56b8e021ffaf4f40=
7c045f5 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-7.2/gcc-7/4ed591c8ab44e711e56b8=
e021ffaf4f407c045f5/vmlinuz-4.19.0-04691-g4ed591c erst_disable max_uptime=
=3D3600 RESULT_ROOT=3D/result/kernel_selftests/kselftests-02/vm-lkp-nex04-8=
G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/4ed591c8ab44e711e56b8e=
021ffaf4f407c045f5/3 LKP_SERVER=3Dinn debug apic=3Ddebug sysrq_always_enabl=
ed rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don=
 panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ram=
disk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ig=
nore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115=
200 vga=3Dnormal rw rcuperf.shutdown=3D0
pstore_crash_test has not been executed yet. we skip further tests.
not ok 1..2 selftests: pstore: pstore_post_reboot_tests [SKIP]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/pstore'
ptp test: not in Makefile
2018-11-01 03:27:18 make TARGETS=3Dptp
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591=
c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/ptp'
Makefile:10: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
gcc -I../../../../usr/include/    testptp.c  -lrt -o testptp
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c=
8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/ptp'

2018-11-01 03:27:20 make run_tests -C ptp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/ptp'
Makefile:10: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
TAP version 13
selftests: ptp: testptp
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: ptp: testptp [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/ptp'

2018-11-01 03:27:20 make run_tests -C ptrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/ptrace'
gcc -iquote../../../../include/uapi -Wall    peeksiginfo.c  -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/=
testing/selftests/ptrace/peeksiginfo
TAP version 13
selftests: ptrace: peeksiginfo
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PASS
ok 1..1 selftests: ptrace: peeksiginfo [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8ab=
44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/ptrace'

2018-11-01 03:27:21 make run_tests -C rseq
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c8a=
b44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/rseq'
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ -shar=
ed -fPIC rseq.c -lpthread -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591=
c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/rseq/librseq.so
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ basic=
_test.c -lpthread -lrseq -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c=
8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/rseq/basic_test
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ basic=
_percpu_ops_test.c -lpthread -lrseq -o /usr/src/perf_selftests-x86_64-rhel-=
7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/rseq/b=
asic_percpu_ops_test
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ param=
_test.c -lpthread -lrseq -o /usr/src/perf_selftests-x86_64-rhel-7.2-4ed591c=
8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/rseq/param_test
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ -DBEN=
CHMARK param_test.c -lpthread -lrseq -o /usr/src/perf_selftests-x86_64-rhel=
-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selftests/rseq/=
param_test_benchmark
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ -DRSE=
Q_COMPARE_TWICE param_test.c -lpthread -lrseq -o /usr/src/perf_selftests-x8=
6_64-rhel-7.2-4ed591c8ab44e711e56b8e021ffaf4f407c045f5/tools/testing/selfte=
sts/rseq/param_test_compare_twice
TAP version 13
selftests: rseq: basic_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
testing current cpu
ok 1..1 selftests: rseq: basic_test [PASS]
selftests: rseq: basic_percpu_ops_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
spinlock
percpu_list
ok 1..2 selftests: rseq: basic_percpu_ops_test [PASS]
selftests: rseq: param_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..3 selftests: rseq: param_test [PASS]
selftests: rseq: param_test_benchmark
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..4 selftests: rseq: param_test_benchmark [PASS]
selftests: rseq: param_test_compare_twice
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..5 selftests: rseq: param_test_compare_twice [PASS]
selftests: rseq: run_param_test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Default parameters
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Loop injection: 10000 loops
Injecting at <1>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <2>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <3>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <4>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <5>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <6>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <7>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <8>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <9>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Yield injection (25%)
Injecting at <7>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <8>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <9>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Yield injection (50%)
Injecting at <7>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <8>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <9>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Yield injection (100%)
Injecting at <7>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <8>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <9>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Kill injection (25%)
Injecting at <7>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <8>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <9>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Kill injection (50%)
Injecting at <7>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <8>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <9>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Kill injection (100%)
Injecting at <7>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <8>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <9>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Sleep injection (1ms, 25%)
Injecting at <7>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <8>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <9>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Sleep injection (1ms, 50%)
Injecting at <7>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <8>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <9>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Sleep injection (1ms, 100%)
Injecting at <7>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <8>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <9>
Running test spinlock

--lrl7g2KojMNQ8tYq--
