Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7438BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF30E20821
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCG855Kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF30E20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404185AbeKVONv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:13:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730407AbeKVONv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:13:51 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94D59206BA;
        Thu, 22 Nov 2018 03:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857785;
        bh=ElkuOL25+kq74RPqJ2NrSYtr4qEYD+A62FjwCp4dnYM=;
        h=From:To:Cc:Subject:Date:From;
        b=XCG855KjI2Y8rEnUPBmMQJieVM431yXJYPq9PNfhGHTJF8ca7iTUCxqMmLqv3sh3B
         krmGN9NQAMcDrFn2uDzVnYVgMyB0eva8QriV8kLt7c1Lo6PNKRVgFjoBYovG+UBw8Z
         nyao7Ma9+AbkMLFTn+69ip8Mqb2Yxh0sgdCAwINk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Blanchard <anton@samba.org>,
        Ben Gainey <ben.gainey@arm.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Borislav Petkov <bp@suse.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        David Ahern <dsahern@gmail.com>,
        David Aldridge <david.aldridge@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Edward Cree <ecree@solarflare.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Gustavo Luiz Duarte <gduarte@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Pu Wen <puwen@hygon.cn>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Rob Gardner <rob.gardner@oracle.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>,
        yuzhoujian@didichuxing.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/28] perf/core improvements and fixes
Date:   Thu, 22 Nov 2018 00:35:43 -0300
Message-Id: <20181122033611.15890-1-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Please consider pulling, some from before the trip to Vancouver,
some that were more easy to process before I continue with the backlog.
Took a bit more time than I antecipated due to fixing build breakage in
various places due to multiple patches.  This has tip/perf/urgent
merged.

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit b1a9d7b0190119dad5b9b7841751b5a7586bbc8b:

  Merge tag 'perf-urgent-for-mingo-4.20-20181121' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-11-21 15:57:21 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.21-20181122

for you to fetch changes up to f4a0742b3cc1d03b2ff448017b8c714a77e5a261:

  perf pmu: Move *_cpuid_str() weak functions to header.c (2018-11-21 22:39:59 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

- Start using BPF maps in 'perf trace' for filters in the augmented syscalls
  code, keeping the existing code for tracepoint filters so that we can switch
  back and forth while getting everything BPFied (Arnaldo Carvalho de Melo)

- Suppress potential format-truncation warning in the PMU code (Ben Hutchings)

- Introduce 'perf bench epoll', with "wait" and "ctl" benchmarks (Davidlohr Bueso)

- Fix slowness due to -ffunction-section, do it by sorting the maps by name, so
  avoiding the using rb_first/next to traverse all entries looking for a map name,
  that with --ffunction-section gets to thousands of maps (Eric Saint-Etienne)

- Separate jvmti cmlr check (Jiri Olsa)

- Allow using the stepping when figuring out which JSON files to use for a x86
  processor, so that Cascadelake server can be support, which has the same
  cpuid as some other processor, being different only in the stepping (Kan Liang)

- Share code and output format for uregs and iregs 'perf script' output (Milian Wolff)

- Use perf_evsel__is_clocki() for clock events in 'perf stat' (Ravi Bangoria)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (15):
      perf bpf: Add unistd.h to the headers accessible to bpf proggies
      perf augmented_syscalls: Filter on a hard coded pid
      perf augmented_syscalls: Remove needless linux/socket.h include
      perf bpf: Add defines for map insertion/lookup
      perf bpf: Add simple pid_filter class accessible to BPF proggies
      perf augmented_syscalls: Drop 'write', 'poll' for testing without self pid filter
      perf augmented_syscalls: Use pid_filter
      perf evlist: Rename perf_evlist__set_filter* to perf_evlist__set_tp_filter*
      perf trace: Add "_from_option" suffix to trace__set_filter()
      perf trace: See if there is a map named "filtered_pids"
      perf trace: Fill in BPF "filtered_pids" map when present
      perf augmented_syscalls: Remove example hardcoded set of filtered pids
      Revert "perf augmented_syscalls: Drop 'write', 'poll' for testing without self pid filter"
      perf bpf: Reduce the hardcoded .max_entries for pid_maps
      tools build feature: Check if eventfd() is available

Ben Hutchings (1):
      perf pmu: Suppress potential format-truncation warning

Davidlohr Bueso (3):
      perf bench: Move HAVE_PTHREAD_ATTR_SETAFFINITY_NP into bench.h
      perf bench: Add epoll parallel epoll_wait benchmark
      perf bench: Add epoll_ctl(2) benchmark

Eric Saint-Etienne (1):
      perf symbols: Fix slowness due to -ffunction-section

Jiri Olsa (1):
      perf jvmti: Separate jvmti cmlr check

Kan Liang (3):
      perf vendor events: Add stepping in CPUID string for x86
      perf vendor events: Add JSON metrics for Cascadelake server
      perf pmu: Move *_cpuid_str() weak functions to header.c

Milian Wolff (2):
      perf script: Add newline after uregs output
      perf script: Share code and output format for uregs and iregs output

Pu Wen (1):
      perf tools: Add Hygon Dhyana support

Ravi Bangoria (1):
      perf stat: Use perf_evsel__is_clocki() for clock events

 tools/build/Makefile.feature                       |     1 +
 tools/build/feature/Makefile                       |     8 +
 tools/build/feature/test-all.c                     |     5 +
 tools/build/feature/test-eventfd.c                 |     9 +
 tools/build/feature/test-jvmti-cmlr.c              |    11 +
 tools/build/feature/test-jvmti.c                   |     1 -
 tools/perf/Documentation/perf-bench.txt            |    10 +
 tools/perf/Makefile.config                         |    12 +-
 tools/perf/Makefile.perf                           |     3 +
 tools/perf/arch/x86/util/header.c                  |    66 +-
 tools/perf/arch/x86/util/kvm-stat.c                |     2 +-
 tools/perf/bench/Build                             |     3 +
 tools/perf/bench/bench.h                           |    14 +
 tools/perf/bench/epoll-ctl.c                       |   413 +
 tools/perf/bench/epoll-wait.c                      |   540 +
 tools/perf/bench/futex.h                           |    12 -
 tools/perf/builtin-bench.c                         |    13 +
 tools/perf/builtin-script.c                        |    38 +-
 tools/perf/builtin-trace.c                         |    92 +-
 tools/perf/examples/bpf/augmented_raw_syscalls.c   |    10 +-
 tools/perf/include/bpf/bpf.h                       |    19 +
 tools/perf/include/bpf/pid_filter.h                |    21 +
 tools/perf/include/bpf/unistd.h                    |    10 +
 tools/perf/jvmti/libjvmti.c                        |    12 +
 .../pmu-events/arch/x86/cascadelakex/cache.json    | 10172 +++++++++++++++++++
 .../arch/x86/cascadelakex/clx-metrics.json         |   164 +
 .../arch/x86/cascadelakex/floating-point.json      |    85 +
 .../pmu-events/arch/x86/cascadelakex/frontend.json |   482 +
 .../pmu-events/arch/x86/cascadelakex/memory.json   |  9909 ++++++++++++++++++
 .../pmu-events/arch/x86/cascadelakex/other.json    |  8908 ++++++++++++++++
 .../pmu-events/arch/x86/cascadelakex/pipeline.json |   969 ++
 .../arch/x86/cascadelakex/uncore-memory.json       |   117 +
 .../arch/x86/cascadelakex/uncore-other.json        |   255 +
 .../arch/x86/cascadelakex/virtual-memory.json      |   285 +
 tools/perf/pmu-events/arch/x86/mapfile.csv         |     3 +-
 tools/perf/util/evlist.c                           |    10 +-
 tools/perf/util/evlist.h                           |     6 +-
 tools/perf/util/header.c                           |    39 +
 tools/perf/util/map.c                              |    27 +
 tools/perf/util/map.h                              |     2 +
 tools/perf/util/pmu.c                              |    47 +-
 tools/perf/util/stat-shadow.c                      |     3 +-
 tools/perf/util/symbol.c                           |    15 +-
 43 files changed, 32711 insertions(+), 112 deletions(-)
 create mode 100644 tools/build/feature/test-eventfd.c
 create mode 100644 tools/build/feature/test-jvmti-cmlr.c
 create mode 100644 tools/perf/bench/epoll-ctl.c
 create mode 100644 tools/perf/bench/epoll-wait.c
 create mode 100644 tools/perf/include/bpf/pid_filter.h
 create mode 100644 tools/perf/include/bpf/unistd.h
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/virtual-memory.json

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
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   6 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
   7 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
   8 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
   9 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  10 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  11 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  12 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  13 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
  14 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 8.2.1 20180502
  15 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  16 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
  17 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  18 debian:experimental           : Ok   gcc (Debian 8.2.0-9) 8.2.0
  19 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.2.0-9) 8.2.0
  20 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.2.0-7) 8.2.0
  21 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.2.0-9) 8.2.0
  22 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.2.0-7) 8.2.0
  23 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  24 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  25 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  26 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  27 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  28 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  29 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  30 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  31 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
  32 fedora:28                     : Ok   gcc (GCC) 8.2.1 20181011 (Red Hat 8.2.1-4)
  33 fedora:29                     : Ok   gcc (GCC) 8.2.1 20181011 (Red Hat 8.2.1-4)
  34 fedora:rawhide                : Ok   gcc (GCC) 8.2.1 20181011 (Red Hat 8.2.1-4)
  35 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 7.3.0-r3 p1.4) 7.3.0
  36 mageia:5                      : Ok   gcc (GCC) 4.9.2
  37 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  38 opensuse:13.2                 : Ok   gcc (SUSE Linux) 4.8.3 20140627 [gcc-4_8-branch revision 212064]
  39 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  40 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  41 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  42 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.3.1 20180323 [gcc-7-branch revision 258812]
  43 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  44 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36.0.1)
  45 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  46 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  47 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
  48 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
  49 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  52 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  53 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  54 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  55 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  56 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  57 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  58 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
  59 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
  60 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  61 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  62 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  63 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  64 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  65 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.2.0-7ubuntu1) 8.2.0

  # uname -a
  Linux seventh 4.19.0-rc8-00014-gc0cff31be705 #1 SMP Wed Oct 17 09:00:22 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  f4a0742b3cc1 perf pmu: Move *_cpuid_str() weak functions to header.c
  # perf version --build-options
  perf version 4.20.rc3.gf4a074
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
  65: Check open filename arg using perf trace + vfs_getname: Ok
  66: Use vfs_getname probe to get syscall args filenames   : Ok
  67: Add vfs_getname probe to get syscall args filenames   : Ok

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_pure_O: make
            make_no_demangle_O: make NO_DEMANGLE=1
                  make_debug_O: make DEBUG=1
                make_no_newt_O: make NO_NEWT=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                make_no_gtk2_O: make NO_GTK2=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
            make_install_bin_O: make install-bin
             make_util_map_o_O: make util/map.o
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                    make_doc_O: make doc
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
           make_no_libbionic_O: make NO_LIBBIONIC=1
                   make_tags_O: make tags
         make_with_clangllvm_O: make LIBCLANGLLVM=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
              make_no_libelf_O: make NO_LIBELF=1
           make_no_libpython_O: make NO_LIBPYTHON=1
           make_no_backtrace_O: make NO_BACKTRACE=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
              make_clean_all_O: make clean all
                make_install_O: make install
                 make_perf_o_O: make perf.o
            make_no_auxtrace_O: make NO_AUXTRACE=1
              make_no_libbpf_O: make NO_LIBBPF=1
               make_no_slang_O: make NO_SLANG=1
         make_install_prefix_O: make install prefix=/tmp/krava
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
             make_no_libperl_O: make NO_LIBPERL=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                   make_help_O: make help
                 make_static_O: make LDFLAGS=-static
             make_no_libnuma_O: make NO_LIBNUMA=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
