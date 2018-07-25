Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA82C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417002088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3r6x/TL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417002088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbeGYTNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbeGYTNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:13:11 -0400
Received: from jouet.infradead.org (189-94-96-116.3g.claro.net.br [189.94.96.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5284A20833;
        Wed, 25 Jul 2018 18:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532541624;
        bh=9NaW1wu+3Zg03eEj6kBR0I1Jn8PC+5FPVQn2hsktYTs=;
        h=From:To:Cc:Subject:Date:From;
        b=d3r6x/TLAtmOL/xd/Hkd5dw5OmUfMhUDsHAWD7L2y8ZCJDkWD4i1a6tt+9FzV+tDY
         NjtLs/nOENBtjG5XbmfK0Q2hzAypVPWiDJixlWeuqQJHqkXfT2jSy7+8NZBViUb7xv
         RSXVr3K7iTjsst63/cD8dJkaV1w1D0U7Vzi/mklk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@fb.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Ahern <dsahern@gmail.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>, kernel-team@lge.com,
        Kim Phillips <kim.phillips@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Lukasz Odzioba <lukasz.odzioba@intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Maynard Johnson <maynard@us.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Leach <mike.leach@linaro.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Robert Walker <robert.walker@arm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Sangwon Hong <qpakzk@gmail.com>, stable@vger.kernel.org,
        Stefan Raspl <raspl@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/27] perf/core improvements and fixes
Date:   Wed, 25 Jul 2018 14:59:34 -0300
Message-Id: <20180725180001.15108-1-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Please consider pulling, I'm now investigating why these failed:

  38: LLVM search and compile                               :
  38.1: Basic BPF llvm compile                              : Ok
  38.2: kbuild searching                                    : Ok
  38.3: Compile source for BPF prologue generation          : Ok
  38.4: Compile source for BPF relocation                   : FAILED!
  40: BPF filter                                            :
  40.1: Basic BPF filtering                                 : Ok
  40.2: BPF pinning                                         : Ok
  40.3: BPF prologue generation                             : Ok
  40.4: BPF relocation checker                              : FAILED!

	I think these failures are not related to changes in this patch
kit. Details about the test environment, versions, etc.

Regards,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 1d59d16e9b4d5be80c9786a8b129c0f2af0e9522:

  Merge remote-tracking branch 'tip/perf/urgent' into perf/core (2018-07-24 14:34:32 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.19-20180725

for you to fetch changes up to 9ef0112442bdddef5fb55adf20b3a5464b33de75:

  perf test: Fix subtest number when showing results (2018-07-24 14:55:51 -0300)

----------------------------------------------------------------
perf/cores fixes and improvements:

Tools:

top:

- Fix 'struct comm_str' removal crash race, detected with refcount_t
  debugging (Jiri Olsa)

- Use last_match threads cache only in single threaded mode, fixing
  a crash (Jiri Olsa)

record:

- Synthesize GROUP_DESC feature in pipe mode fixing display of
  event groups (Jiri Olsa)

stat:

- Get rid of extra clock display function (Jiri Olsa)

perf script:

- Show correct offsets for DWARF-based unwinding (Sandipan Das)

test:

- Check that complex event name is parsed correctly (Alexey Budankov)

- Fix subtest number when showing results (Thomas Richter)

Arch specific:

arm64:

- Generate syscall table from the kernel sources (asm/unistd.h) like
  other arches do, speeding up the support for new system calls in
  tools such as 'perf trace' (Kim Phillips)

arm:

- Bail out immediatelly on CoreSight hardware tracing instruction sample failure (Leo Yan)

PowerPC:

- Fix record+probe_libc_inet_pton.sh 'perf test' entry (Sandipan Das)

- Callchain IP filtering fixes (Sandipan Das)

S/390:

- Add support for detailed S/390 PMU event description in 'perf list' (Thomas Richter)

- Add transaction flag (-T) support in 'perf stat' for S/390 (Thomas Richter)

- Fix 'perf kvm' S/390 subcommands (Thomas Richter)

Infrastructure:

hists:

- Clarify callchain disabling when available (Arnaldo Carvalho de Melo)

evsel:

- Use perf_evsel__match instead of open coded equivalent (Jiri Olsa)

Documentation:

- Add missing documentation for 'perf list' --desc and --debug options (Sangwon Hong)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Alexey Budankov (1):
      perf tests: Check that complex event name is parsed correctly

Arnaldo Carvalho de Melo (1):
      perf hists: Clarify callchain disabling when available

Jiri Olsa (7):
      perf tools: Synthesize GROUP_DESC feature in pipe mode
      perf machine: Add threads__get_last_match function
      perf machine: Add threads__set_last_match function
      perf machine: Use last_match threads cache only in single thread mode
      perf tools: Fix struct comm_str removal crash
      perf tools: Use perf_evsel__match instead of open coded equivalent
      perf stat: Get rid of extra clock display function

Kim Phillips (3):
      tools include: Grab copies of arm64 dependent unistd.h files
      perf arm64: Generate system call table from asm/unistd.h
      perf trace arm64: Use generated syscall table

Leo Yan (2):
      perf cs-etm: Introduce invalid address macro
      perf cs-etm: Bail out immediately for instruction sample failure

Sandipan Das (6):
      perf powerpc: Fix callchain ip filtering
      perf powerpc: Fix callchain ip filtering when return address is in a register
      perf tests: Fix record+probe_libc_inet_pton.sh for powerpc64
      perf tests: Fix record+probe_libc_inet_pton.sh to ensure cleanups
      perf tests: Fix record+probe_libc_inet_pton.sh when event exists
      perf script: Show correct offsets for DWARF-based unwinding

Sangwon Hong (1):
      perf list: Add missing documentation for --desc and --debug options

Thomas Richter (6):
      Revert "perf list: Add s390 support for detailed/verbose PMU event description"
      perf list: Add s390 support for detailed PMU event description
      perf json: Add s390 transaction counter definition
      perf stat: Add transaction flag (-T) support for s390
      perf kvm: Fix subcommands on s390
      perf test: Fix subtest number when showing results

 tools/arch/arm64/include/uapi/asm/unistd.h         |  20 +
 tools/include/uapi/asm-generic/unistd.h            | 783 +++++++++++++++++++++
 tools/perf/Documentation/perf-list.txt             |   8 +-
 tools/perf/Makefile.config                         |   2 +
 tools/perf/arch/arm64/Makefile                     |  21 +
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl  |  62 ++
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  |  10 +-
 tools/perf/arch/s390/util/kvm-stat.c               |   2 +-
 tools/perf/builtin-c2c.c                           |   4 +-
 tools/perf/builtin-diff.c                          |   2 +-
 tools/perf/builtin-report.c                        |   4 +-
 tools/perf/builtin-stat.c                          |  60 +-
 tools/perf/builtin-top.c                           |   2 +-
 tools/perf/check-headers.sh                        |   2 +
 tools/perf/pmu-events/arch/s390/cf_z10/basic.json  |  12 +
 tools/perf/pmu-events/arch/s390/cf_z10/crypto.json |  16 +
 .../perf/pmu-events/arch/s390/cf_z10/extended.json |  18 +
 tools/perf/pmu-events/arch/s390/cf_z13/basic.json  |  12 +
 tools/perf/pmu-events/arch/s390/cf_z13/crypto.json |  16 +
 .../perf/pmu-events/arch/s390/cf_z13/extended.json |  56 ++
 .../pmu-events/arch/s390/cf_z13/transaction.json   |   7 +
 tools/perf/pmu-events/arch/s390/cf_z14/basic.json  |   8 +
 tools/perf/pmu-events/arch/s390/cf_z14/crypto.json |  16 +
 .../perf/pmu-events/arch/s390/cf_z14/extended.json |  53 ++
 .../pmu-events/arch/s390/cf_z14/transaction.json   |   7 +
 tools/perf/pmu-events/arch/s390/cf_z196/basic.json |  12 +
 .../perf/pmu-events/arch/s390/cf_z196/crypto.json  |  16 +
 .../pmu-events/arch/s390/cf_z196/extended.json     |  24 +
 .../perf/pmu-events/arch/s390/cf_zec12/basic.json  |  12 +
 .../perf/pmu-events/arch/s390/cf_zec12/crypto.json |  16 +
 .../pmu-events/arch/s390/cf_zec12/extended.json    |  35 +
 .../pmu-events/arch/s390/cf_zec12/transaction.json |   7 +
 tools/perf/pmu-events/jevents.c                    |   2 +
 tools/perf/tests/builtin-test.c                    |   2 +-
 tools/perf/tests/parse-events.c                    |  18 +
 .../tests/shell/record+probe_libc_inet_pton.sh     |  36 +-
 tools/perf/ui/stdio/hist.c                         |   8 +-
 tools/perf/util/comm.c                             |  16 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  10 +-
 tools/perf/util/cs-etm.c                           |   3 +
 tools/perf/util/evsel.c                            |  11 +
 tools/perf/util/evsel.h                            |   9 +-
 tools/perf/util/header.c                           |   2 +-
 tools/perf/util/hist.h                             |   2 +-
 tools/perf/util/machine.c                          |  79 ++-
 tools/perf/util/metricgroup.c                      |  22 +
 tools/perf/util/metricgroup.h                      |   1 +
 tools/perf/util/pmu.c                              |   6 -
 tools/perf/util/stat-shadow.c                      |   5 +-
 tools/perf/util/syscalltbl.c                       |   4 +
 tools/perf/util/unwind-libdw.c                     |   2 +-
 tools/perf/util/unwind-libunwind-local.c           |   2 +-
 52 files changed, 1456 insertions(+), 109 deletions(-)
 create mode 100644 tools/arch/arm64/include/uapi/asm/unistd.h
 create mode 100644 tools/include/uapi/asm-generic/unistd.h
 create mode 100755 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_zec12/transaction.json

Test results:

The first ones are container (docker) based builds of tools/perf with
and without libelf support.  Where clang is available, it is also used
to build perf with/without libelf, and building with LIBCLANGLLVM=1
(built-in clang) with gcc and clang when clang and its devel libraries
are installed.

The objtool and samples/bpf/ builds are disabled now that I'm switching from
using the sources in a local volume to fetching them from a http server to
build it inside the container, to make it easier to build in a container cluster.
Those will come back later.

Several are cross builds, the ones with -x-ARCH and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf commands
with a variety of command line event specifications to then intercept the
sys_perf_event syscall to check that the perf_event_attr fields are set up as
expected, among a variety of other unit tests.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
with a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one. It is planned to have it run on each
of the containers mentioned above, using some container orchestration
infrastructure. Get in contact if interested in helping having this in place.

  # dm
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
   6 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-11)
   7 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
   8 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   9 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  10 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  11 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  12 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
  13 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  14 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
  15 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  16 debian:experimental           : Ok   gcc (Debian 7.3.0-15) 7.3.0
  17 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 7.3.0-15) 7.3.0
  18 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 7.3.0-19) 7.3.0
  19 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 7.3.0-18) 7.3.0
  20 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 7.3.0-20) 7.3.0
  21 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  22 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  23 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  24 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  25 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  26 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  27 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  28 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  29 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
  30 fedora:28                     : Ok   gcc (GCC) 8.1.1 20180712 (Red Hat 8.1.1-5)
  31 fedora:rawhide                : Ok   gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)
  32 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 7.3.0-r3 p1.4) 7.3.0
  33 mageia:5                      : Ok   gcc (GCC) 4.9.2
  34 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  35 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  36 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  37 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  38 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.3.1 20180323 [gcc-7-branch revision 258812]
  39 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  40 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28.0.1)
  41 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  42 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  43 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.4-2017.05) 5.4.1 20170404
  44 ubuntu:15.04                  : Ok   gcc (Ubuntu 4.9.2-10ubuntu13) 4.9.2
  45 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  46 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  47 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  48 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  49 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  52 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  53 ubuntu:17.04                  : Ok   gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
  54 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  55 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  #

  Investigation is underway for the BPF related failures below.

  # git log --oneline -1
  9ef0112442bd (HEAD -> perf/core, jouet/perf/core) perf test: Fix subtest number when showing results
  # perf version --build-options
  perf version 4.18.rc6.g9ef0112
                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                    gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
           syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                  libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
                 libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
  numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                 libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
               libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
               libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
      libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                    zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                    lzma: [ on  ]  # HAVE_LZMA_SUPPORT
               get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                     bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
  # uname -a
  Linux seventh 4.18.0-rc6-00093-g9981b4fb8684 #2 SMP Wed Jul 25 12:31:40 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
  # perf test
   1: vmlinux symtab matches kallsyms                       : Ok
   2: Detect openat syscall event                           : Ok
   3: Detect openat syscall event on all cpus               : Ok
   4: Read samples using the mmap interface                 : Ok
   5: Test data source output                               : Ok
   6: Parse event definition strings                        : Ok
   7: Simple expression parser                              : Ok
   8: PERF_RECORD_* events & perf_sample fields             : Ok
   9: Parse perf pmu format                                 : Ok
  10: DSO data read                                         : Ok
  11: DSO data cache                                        : Ok
  12: DSO data reopen                                       : Ok
  13: Roundtrip evsel->name                                 : Ok
  14: Parse sched tracepoints fields                        : Ok
  15: syscalls:sys_enter_openat event fields                : Ok
  16: Setup struct perf_event_attr                          : Ok
  17: Match and link multiple hists                         : Ok
  18: 'import perf' in python                               : Ok
  19: Breakpoint overflow signal handler                    : Ok
  20: Breakpoint overflow sampling                          : Ok
  21: Breakpoint accounting                                 : Ok
  22: Number of exit events of a simple workload            : Ok
  23: Software clock events period values                   : Ok
  24: Object code reading                                   : Ok
  25: Sample parsing                                        : Ok
  26: Use a dummy software event to keep tracking           : Ok
  27: Parse with no sample_id_all bit set                   : Ok
  28: Filter hist entries                                   : Ok
  29: Lookup mmap thread                                    : Ok
  30: Share thread mg                                       : Ok
  31: Sort output of hist entries                           : Ok
  32: Cumulate child hist entries                           : Ok
  33: Track with sched_switch                               : Ok
  34: Filter fds with revents mask in a fdarray             : Ok
  35: Add fd to a fdarray, making it autogrow               : Ok
  36: kmod_path__parse                                      : Ok
  37: Thread map                                            : Ok
  38: LLVM search and compile                               :
  38.1: Basic BPF llvm compile                              : Ok
  38.2: kbuild searching                                    : Ok
  38.3: Compile source for BPF prologue generation          : Ok
  38.4: Compile source for BPF relocation                   : FAILED!
  39: Session topology                                      : Ok
  40: BPF filter                                            :
  40.1: Basic BPF filtering                                 : Ok
  40.2: BPF pinning                                         : Ok
  40.3: BPF prologue generation                             : Ok
  40.4: BPF relocation checker                              : FAILED!
  41: Synthesize thread map                                 : Ok
  42: Remove thread map                                     : Ok
  43: Synthesize cpu map                                    : Ok
  44: Synthesize stat config                                : Ok
  45: Synthesize stat                                       : Ok
  46: Synthesize stat round                                 : Ok
  47: Synthesize attr update                                : Ok
  48: Event times                                           : Ok
  49: Read backward ring buffer                             : Ok
  50: Print cpu map                                         : Ok
  51: Probe SDT events                                      : Ok
  52: is_printable_array                                    : Ok
  53: Print bitmap                                          : Ok
  54: perf hooks                                            : Ok
  55: builtin clang support                                 : Skip (not compiled in)
  56: unit_number__scnprintf                                : Ok
  57: mem2node                                              : Ok
  58: x86 rdpmc                                             : Ok
  59: Convert perf time to TSC                              : Ok
  60: DWARF unwind                                          : Ok
  61: x86 instruction decoder - new instructions            : Ok
  62: probe libc's inet_pton & backtrace it with ping       : Ok
  63: Check open filename arg using perf trace + vfs_getname: Ok
  64: Use vfs_getname probe to get syscall args filenames   : Ok
  65: Add vfs_getname probe to get syscall args filenames   : Ok
  #

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git2/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
        make_with_babeltrace_O: make LIBBABELTRACE=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
              make_clean_all_O: make clean all
           make_no_libunwind_O: make NO_LIBUNWIND=1
             make_util_map_o_O: make util/map.o
            make_no_auxtrace_O: make NO_AUXTRACE=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
                make_install_O: make install
                   make_pure_O: make
                    make_doc_O: make doc
                   make_help_O: make help
                make_no_gtk2_O: make NO_GTK2=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
               make_no_slang_O: make NO_SLANG=1
            make_install_bin_O: make install-bin
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
             make_no_libnuma_O: make NO_LIBNUMA=1
                make_no_newt_O: make NO_NEWT=1
            make_no_demangle_O: make NO_DEMANGLE=1
              make_no_libelf_O: make NO_LIBELF=1
                 make_cscope_O: make cscope
                 make_static_O: make LDFLAGS=-static
                  make_debug_O: make DEBUG=1
                 make_perf_o_O: make perf.o
           make_no_backtrace_O: make NO_BACKTRACE=1
                   make_tags_O: make tags
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
         make_install_prefix_O: make install prefix=/tmp/krava
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
              make_no_libbpf_O: make NO_LIBBPF=1
             make_no_libperl_O: make NO_LIBPERL=1
           make_no_libpython_O: make NO_LIBPYTHON=1
  OK
  make: Leaving directory '/home/acme/git2/perf/tools/perf'
  $
