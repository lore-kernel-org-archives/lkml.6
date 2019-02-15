Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE57C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F90C2229F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191556;
	bh=2kvlM51I/zwKiJHOPqdfKgyB9F6GXl7y2OKDjpkxceg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=B/hRXdYrIswpK3gpuFkoXxOmp3sEMUYahp/TeeyhWQXoH6WkCd3CgMv8BfGv50SI8
	 7rCosgZmu+lk5Qsau868CcMcmOa6hiadf73uiCuGZEwDq980MsfELN5uCqg78eCcNV
	 /wp1NN/8XfnmC9hgexqMvtoZrioAZlbAO6UHIdBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfBOApy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:45:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:43834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730220AbfBOApx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:45:53 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30DAE21B68;
        Fri, 15 Feb 2019 00:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191550;
        bh=2kvlM51I/zwKiJHOPqdfKgyB9F6GXl7y2OKDjpkxceg=;
        h=From:To:Cc:Subject:Date:From;
        b=HC1MvptVTiZzWsILTc9rx2162mmLPUPByFL/WqaXVSnqNW4lbxROWC6emeYP+Wbgr
         UYark40ebnIHTcugsMPBzSE7s9D+BuH8nM7XLS/iKP7SjA0jqPqVN4shMFqbdmS0/C
         kUSDnphWeY8ogzcjMaFH8Z2w755irGnNPxJ6HhEc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        David Carrillo-Cisneros <davidca@fb.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Paul Clarke <pc@us.ibm.com>, Song Liu <songliubraving@fb.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/43] perf/core improvements and fixes
Date:   Thu, 14 Feb 2019 21:44:56 -0300
Message-Id: <20190215004539.23571-1-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit af63147c1edacfb75a28885a7cd7e6f44e626164:

  perf/x86/intel: Add counter freezing quirk for Goldmont (2019-02-11 08:00:42 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.1-20190214

for you to fetch changes up to 44ec8396e2dadf0f0806767642cfac9e04d0d5b1:

  tools build feature sched_getcpu: Undef _GNU_SOURCE at the end (2019-02-14 15:39:21 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf list:

  Jiri Olsa:

  - Display metric expressions for --details option

perf record:

  Alexey Budankov:

  - Implement --affinity=node|cpu option, leftover, the other patches
    in this kit were already applied.

perf trace:

  Arnaldo Carvalho de Melo:

  - Fix segfaults due to not properly handling negative file descriptor syscall args.

  - Fix segfault related to the 'waitid' 'options' prefix showing logic.

  - Filter out 'gnome-terminal*' if it is a parent of 'perf trace', to reduce the
    syscall feedback loop in system wide sessions.

BPF:

  Song Liu:

  - Silence "Couldn't synthesize bpf events" warning for EPERM.

Build system:

  Arnaldo Carvalho de Melo:

  - Fix the test-all.c feature detection fast path that was broken for
    quite a while leading to longer build times.

Event parsing:

  Jiri Olsa:

  - Fix legacy events symbol separator parsing

cs-etm:

  Mathieu Poirier:

  - Fix some error path return errors and plug some memory leaks.

  - Add proper header file for symbols

  - Remove unused structure fields.

  - Modularize auxtrace_buffer fetch, decoder and packet processing loop.

Vendor events:

  Paul Clarke:

  - Add assorted metrics for the Power8 and Power9 architectures.

perf report:

  Thomas Richter:

  - Add s390 diagnostic sampling descriptor size

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Alexey Budankov (1):
      perf record: Implement --affinity=node|cpu option

Arnaldo Carvalho de Melo (11):
      tools feature: Undef _GNU_SOURCE at the end of feature tests
      perf beauty ioctl cmd: The 'fd' arg is signed
      perf trace: Check if the 'fd' is negative when mapping it to pathname
      perf beauty waitid options: Fix up prefix showing logic
      tools build: Add -lrt to FEATURE_CHECK_LDFLAGS-libaio
      perf trace: Filter out gnome-terminal* parent
      perf coresight: Do not test for libopencsd by default
      perf unwind: Do not put libunwind-{x86,aarch64} in FEATURE_TESTS_BASIC
      tools build: Add test-reallocarray.c to test-all.c to fix the build
      perf build: Add missing FEATURE_CHECK_LDFLAGS-libcrypto
      tools build feature sched_getcpu: Undef _GNU_SOURCE at the end

Jiri Olsa (7):
      perf tools: Compile perf with libperf-in.o instead of libperf.a
      perf tools: Rename LIB_FILE to LIBPERF_A
      perf tools: Rename build libperf to perf
      perf tools: Fix legacy events symbol separator parsing
      perf list: Display metric expressions for --details option
      perf header: Get rid of write_it label
      perf header: Remove unused 'cpu_nr' field  from 'struct cpu_topo'

Mathieu Poirier (14):
      perf cs-etm: Add proper header file for symbols
      perf cs-etm: Remove unused structure field "state"
      perf cs-etm: Remove unused structure field "time" and "timestamp"
      perf cs-etm: Fix wrong return values in error path
      perf cs-etm: Introducing function cs_etm_decoder__init_dparams()
      perf cs-etm: Fix memory leak in error path
      perf cs-etm: Introducing function cs_etm__init_trace_params()
      perf cs-etm: Fix erroneous comment
      perf cs-etm: Cleaning up function cs_etm__alloc_queue()
      perf cs-etm: Rethink kernel address initialisation
      perf cs-etm: Make cs_etm__run_decoder() queue independent
      perf cs-etm: Modularize main decoder function
      perf cs-etm: Modularize main packet processing loop
      perf cs-etm: Modularize auxtrace_buffer fetch function

Paul Clarke (8):
      perf vendor events power8: Cpi_breakdown & estimated_dcache_miss_cpi metrics
      perf vendor events power8: Dl1_reload, instruction_misses, l2_stats, lsu_rejects, memory & pteg_reloads metrics
      perf vendor events power8: Branch_prediction, latency, bus_stats, instruction_mix & instruction_stats metrics
      perf vendor events power8: Translaton & general metrics
      perf vendor events power9: Cpi_breakdown & estimated_dcache_miss_cpi metrics
      perf vendor events power9: Dl1_reloads, instruction_misses, l[23]_stats & pteg_reloads metrics
      perf vendor events power9: Branch_prediction, instruction_stats, latency, lsu_rejects, memory, prefetch & translation metrics
      perf vendor events power9: General metrics

Song Liu (1):
      perf utils: Silence "Couldn't synthesize bpf events" warning for EPERM

Thomas Richter (1):
      perf report: Add s390 diagnosic sampling descriptor size

 tools/build/Makefile.feature                       |   10 +-
 tools/build/feature/test-all.c                     |   10 +-
 tools/build/feature/test-get_current_dir_name.c    |    1 +
 tools/build/feature/test-libpython.c               |    1 +
 tools/build/feature/test-reallocarray.c            |    2 +
 tools/build/feature/test-sched_getcpu.c            |    2 +
 tools/build/feature/test-setns.c                   |    1 +
 tools/perf/Build                                   |   10 +-
 tools/perf/Documentation/perf-record.txt           |    5 +
 tools/perf/Makefile.config                         |   14 +-
 tools/perf/Makefile.perf                           |   24 +-
 tools/perf/arch/Build                              |    4 +-
 tools/perf/arch/arm/Build                          |    4 +-
 tools/perf/arch/arm/tests/Build                    |    8 +-
 tools/perf/arch/arm/util/Build                     |    8 +-
 tools/perf/arch/arm64/Build                        |    4 +-
 tools/perf/arch/arm64/tests/Build                  |    6 +-
 tools/perf/arch/arm64/util/Build                   |   12 +-
 tools/perf/arch/nds32/Build                        |    2 +-
 tools/perf/arch/nds32/util/Build                   |    2 +-
 tools/perf/arch/powerpc/Build                      |    4 +-
 tools/perf/arch/powerpc/tests/Build                |    6 +-
 tools/perf/arch/powerpc/util/Build                 |   18 +-
 tools/perf/arch/s390/Build                         |    2 +-
 tools/perf/arch/s390/util/Build                    |   12 +-
 tools/perf/arch/sh/Build                           |    2 +-
 tools/perf/arch/sh/util/Build                      |    2 +-
 tools/perf/arch/sparc/Build                        |    2 +-
 tools/perf/arch/sparc/util/Build                   |    2 +-
 tools/perf/arch/x86/Build                          |    4 +-
 tools/perf/arch/x86/tests/Build                    |   14 +-
 tools/perf/arch/x86/util/Build                     |   30 +-
 tools/perf/arch/xtensa/Build                       |    2 +-
 tools/perf/arch/xtensa/util/Build                  |    2 +-
 tools/perf/builtin-list.c                          |    8 +-
 tools/perf/builtin-record.c                        |   18 +
 tools/perf/builtin-trace.c                         |    6 +-
 .../pmu-events/arch/powerpc/power8/metrics.json    | 2245 ++++++++++++++++++++
 .../pmu-events/arch/powerpc/power9/metrics.json    | 1982 +++++++++++++++++
 tools/perf/scripts/Build                           |    4 +-
 tools/perf/scripts/perl/Perf-Trace-Util/Build      |    2 +-
 tools/perf/scripts/python/Perf-Trace-Util/Build    |    2 +-
 tools/perf/tests/parse-events.c                    |   30 +
 tools/perf/trace/beauty/Build                      |   26 +-
 tools/perf/trace/beauty/ioctl.c                    |    2 +-
 tools/perf/trace/beauty/waitid_options.c           |    2 +-
 tools/perf/ui/Build                                |   18 +-
 tools/perf/ui/browsers/Build                       |   10 +-
 tools/perf/ui/tui/Build                            |    8 +-
 tools/perf/util/Build                              |  276 +--
 tools/perf/util/bpf-event.c                        |    4 +-
 tools/perf/util/c++/Build                          |    4 +-
 tools/perf/util/cs-etm-decoder/Build               |    2 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |   10 +-
 tools/perf/util/cs-etm.c                           |  458 ++--
 tools/perf/util/cs-etm.h                           |    4 +-
 tools/perf/util/header.c                           |    8 +-
 tools/perf/util/intel-pt-decoder/Build             |    2 +-
 tools/perf/util/metricgroup.c                      |    8 +-
 tools/perf/util/metricgroup.h                      |    3 +-
 tools/perf/util/parse-events.c                     |    2 +-
 tools/perf/util/parse-events.y                     |    4 +-
 tools/perf/util/s390-cpumsf.c                      |    5 +
 tools/perf/util/scripting-engines/Build            |    4 +-
 64 files changed, 4877 insertions(+), 512 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power8/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/metrics.json

Test results:

The first ones are container based builds of tools/perf with and without libelf
support.  Where clang is available, it is also used to build perf with/without
libelf, and building with LIBCLANGLLVM=1 (built-in clang) with gcc and clang
when clang and its devel libraries are installed.

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

[root@quaco perf]# export PERF_TARBALL=http://192.168.124.1/perf/perf-5.0.0-rc5.tar.xz
[root@quaco perf]# time dm
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   6 alpine:3.9                    : Ok   gcc (Alpine 8.2.0) 8.2.0
   7 alpine:edge                   : Ok   gcc (Alpine 8.2.0) 8.2.0
   8 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
   9 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
  10 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  11 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  12 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  13 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  14 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36)
  15 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 8.2.1 20180502
  16 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  17 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2
  18 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  19 debian:experimental           : Ok   gcc (Debian 8.2.0-17) 8.2.1 20190204
  20 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
  21 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
  22 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.2.0-16) 8.2.0
  23 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  24 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  25 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  26 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  27 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
  28 fedora:28                     : Ok   gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)
  29 fedora:29                     : Ok   gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)
  30 fedora:30                     : Ok   gcc (GCC) 9.0.1 20190203 (Red Hat 9.0.1-0.3)
  31 fedora:rawhide                : Ok   gcc (GCC) 9.0.0 20190119 (Red Hat 9.0.0-0.3)
  32 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 7.3.0-r3 p1.4) 7.3.0
  33 mageia:5                      : Ok   gcc (GCC) 4.9.2
  34 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  35 opensuse:13.2                 : Ok   gcc (SUSE Linux) 4.8.3 20140627 [gcc-4_8-branch revision 212064]
  36 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.3.1 20180323 [gcc-7-branch revision 258812]
  37 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.0
  38 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  39 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  40 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  41 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 8.2.1 20190103 [gcc-8-branch revision 267549]
  42 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  43 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36.0.1)
  44 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  45 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
  46 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
  47 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609
  48 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  49 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  52 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  53 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  54 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  55 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  56 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
  57 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
  58 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  59 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  60 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  61 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  62 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  63 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  64 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  65 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  66 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.2.0-7ubuntu1) 8.2.0
  67 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.2.0-20ubuntu1) 8.2.0
  68 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.2.0-20ubuntu1) 8.2.0
  69 ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.2.0-20ubuntu1) 8.2.0
  70 ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.2.0-20ubuntu1) 8.2.0
  #

  # uname -a
  Linux quaco 4.20.6-200.fc29.x86_64 #1 SMP Thu Jan 31 15:50:43 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  44ec8396e2da tools build feature sched_getcpu: Undef _GNU_SOURCE at the end
  # perf version --build-options
  perf version 5.0.rc5.g44ec839
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
  22: Watchpoint                                            :
  22.1: Read Only Watchpoint                                : Skip
  22.2: Write Only Watchpoint                               : Ok
  22.3: Read / Write Watchpoint                             : Ok
  22.4: Modify Watchpoint                                   : Ok
  23: Number of exit events of a simple workload            : Ok
  24: Software clock events period values                   : Ok
  25: Object code reading                                   : Ok
  26: Sample parsing                                        : Ok
  27: Use a dummy software event to keep tracking           : Ok
  28: Parse with no sample_id_all bit set                   : Ok
  29: Filter hist entries                                   : Ok
  30: Lookup mmap thread                                    : Ok
  31: Share thread mg                                       : Ok
  32: Sort output of hist entries                           : Ok
  33: Cumulate child hist entries                           : Ok
  34: Track with sched_switch                               : Ok
  35: Filter fds with revents mask in a fdarray             : Ok
  36: Add fd to a fdarray, making it autogrow               : Ok
  37: kmod_path__parse                                      : Ok
  38: Thread map                                            : Ok
  39: LLVM search and compile                               :
  39.1: Basic BPF llvm compile                              : Ok
  39.2: kbuild searching                                    : Ok
  39.3: Compile source for BPF prologue generation          : Ok
  39.4: Compile source for BPF relocation                   : Ok
  40: Session topology                                      : Ok
  41: BPF filter                                            :
  41.1: Basic BPF filtering                                 : Ok
  41.2: BPF pinning                                         : Ok
  41.3: BPF prologue generation                             : Ok
  41.4: BPF relocation checker                              : Ok
  42: Synthesize thread map                                 : Ok
  43: Remove thread map                                     : Ok
  44: Synthesize cpu map                                    : Ok
  45: Synthesize stat config                                : Ok
  46: Synthesize stat                                       : Ok
  47: Synthesize stat round                                 : Ok
  48: Synthesize attr update                                : Ok
  49: Event times                                           : Ok
  50: Read backward ring buffer                             : Ok
  51: Print cpu map                                         : Ok
  52: Probe SDT events                                      : Ok
  53: is_printable_array                                    : Ok
  54: Print bitmap                                          : Ok
  55: perf hooks                                            : Ok
  56: builtin clang support                                 : Skip (not compiled in)
  57: unit_number__scnprintf                                : Ok
  58: mem2node                                              : Ok
  59: x86 rdpmc                                             : Ok
  60: Convert perf time to TSC                              : Ok
  61: DWARF unwind                                          : Ok
  62: x86 instruction decoder - new instructions            : Ok
  63: x86 bp modify                                         : Ok
  64: probe libc's inet_pton & backtrace it with ping       : Ok
  65: Use vfs_getname probe to get syscall args filenames   : Ok
  66: Add vfs_getname probe to get syscall args filenames   : Ok
  67: Check open filename arg using perf trace + vfs_getname: Ok

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                   make_pure_O: make
                  make_debug_O: make DEBUG=1
                make_no_newt_O: make NO_NEWT=1
              make_clean_all_O: make clean all
                   make_help_O: make help
              make_no_libelf_O: make NO_LIBELF=1
             make_no_libperl_O: make NO_LIBPERL=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                    make_doc_O: make doc
            make_no_libaudit_O: make NO_LIBAUDIT=1
                make_install_O: make install
            make_no_demangle_O: make NO_DEMANGLE=1
             make_no_libnuma_O: make NO_LIBNUMA=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                 make_static_O: make LDFLAGS=-static
         make_install_prefix_O: make install prefix=/tmp/krava
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
            make_install_bin_O: make install-bin
           make_no_libunwind_O: make NO_LIBUNWIND=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                 make_perf_o_O: make perf.o
                make_no_gtk2_O: make NO_GTK2=1
               make_no_slang_O: make NO_SLANG=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
             make_util_map_o_O: make util/map.o
              make_no_libbpf_O: make NO_LIBBPF=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
                 make_cscope_O: make cscope
                   make_tags_O: make tags
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_libpython_O: make NO_LIBPYTHON=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $ 
