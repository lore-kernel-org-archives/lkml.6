Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D34C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA542083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAE93XVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA542083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbeKFVdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:33:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:33236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387674AbeKFVbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:31:23 -0500
Received: from jouet.infradead.org (unknown [189.40.102.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE99E20862;
        Tue,  6 Nov 2018 12:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541505988;
        bh=HNvJae7wP9o7XsRBDQwh2V1K1WYetV48cqteMcVljxg=;
        h=From:To:Cc:Subject:Date:From;
        b=CAE93XVXtqGcI+UPO+stHbkHApZ1EZ8riaNUNiP9EPkDES3wXgLG9XyaZOlik/U1w
         R1lW+PwgVMsIgqxHkColzcOseg5jjztFBvdA6mVUiMDHQWzmKBSIZB9+BMoLkcahqo
         qcAuJeIXkcVDrGz6P2qMcrsyxCBrk7QcqQXpVUeA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        Edward Cree <ecree@solarflare.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Gustavo Romero <gromero@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastien Boisvert <sboisvert@gydle.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Wang Nan <wangnan0@huawei.com>,
        Will Deacon <will.deacon@arm.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/18] perf/urgent improvements and fixes
Date:   Tue,  6 Nov 2018 09:05:54 -0300
Message-Id: <20181106120612.8262-1-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Please consider pulling, mostly fixes, some late coming
improvements in non-core areas,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 29995d296e3e9ce4f9767963ecbef143ade26c36:

  Merge tag 'perf-urgent-for-mingo-4.20-20181031' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-10-31 22:53:40 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.20-20181106

for you to fetch changes up to 8e88c29b351ed4e09dd63f825f1c8260b0cb0ab3:

  perf tools: Do not zero sample_id_all for group members (2018-11-06 08:29:56 -0300)

----------------------------------------------------------------
perf/urgent improvements and fixes:

Intel PT sql viewer: (Adrian Hunter)

- Fall back to /usr/local/lib/libxed.so
- Add Selected branches report
- Add help window
- Fix table find when table re-ordered

Intel PT debug log (Adrian Hunter)

- Add more event information
- Add MTC and CYC timestamps

perf record: (Andi Kleen)

- Support weak groups, just like with 'perf stat'

perf trace: (Arnaldo Carvalho de Melo)

- Start augmenting raw_syscalls:{sys_enter,sys_exit}: goal is to have a
  generic, arch independent eBPF kernel component that is programmed with
  syscall table details, what to copy, how many bytes, pid, arg filters from the
  userspace via eBPF maps by the 'perf trace' tool that continues to use all its
  argument beautifiers, just taking advantage of the extra pointer contents.

JVMTI: (Gustavo Romero)

- Fix undefined symbol scnprintf in libperf-jvmti.so

perf top: (Jin Yao)

- Display the LBR stats in callchain entries

perf stat: (Thomas Richter)

- Handle different PMU names with common prefix

arm64: Will (Deacon)

- Fix arm64 tools build failure wrt smp_load_{acquire,release}.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (6):
      perf scripts python: exported-sql-viewer.py: Fall back to /usr/local/lib/libxed.so
      perf scripts python: exported-sql-viewer.py: Add Selected branches report
      perf scripts python: exported-sql-viewer.py: Add help window
      perf scripts python: exported-sql-viewer.py: Fix table find when table re-ordered
      perf intel-pt: Add more event information to debug log
      perf intel-pt: Add MTC and CYC timestamps to debug log

Andi Kleen (2):
      perf evlist: Move perf_evsel__reset_weak_group into evlist
      perf record: Support weak groups

Arnaldo Carvalho de Melo (5):
      perf examples bpf: Start augmenting raw_syscalls:sys_{start,exit}
      perf trace: When augmenting raw_syscalls plug raw_syscalls:sys_exit too
      perf trace: Fix setting of augmented payload when using eBPF + raw_syscalls
      perf augmented_syscalls: Start collecting pathnames in the BPF program
      perf beauty: Use SRCARCH, ARCH=x86_64 must map to "x86" to find the headers

Gustavo Romero (1):
      perf tools: Fix undefined symbol scnprintf in libperf-jvmti.so

Jin Yao (1):
      perf top: Display the LBR stats in callchain entry

Jiri Olsa (1):
      perf tools: Do not zero sample_id_all for group members

Thomas Richter (1):
      perf stat: Handle different PMU names with common prefix

Will Deacon (1):
      tools headers barrier: Fix arm64 tools build failure wrt smp_load_{acquire,release}

 tools/arch/arm64/include/asm/barrier.h             | 133 +++---
 tools/perf/Documentation/perf-list.txt             |   1 -
 tools/perf/Makefile.perf                           |   2 +-
 tools/perf/builtin-record.c                        |   7 +-
 tools/perf/builtin-stat.c                          |  28 +-
 tools/perf/builtin-top.c                           |   3 +
 tools/perf/builtin-trace.c                         |  34 +-
 tools/perf/examples/bpf/augmented_raw_syscalls.c   | 131 ++++++
 tools/perf/jvmti/jvmti_agent.c                     |  49 +-
 tools/perf/scripts/python/exported-sql-viewer.py   | 493 ++++++++++++++++++++-
 tools/perf/tests/attr/test-record-group-sampling   |   1 -
 tools/perf/util/evlist.c                           |  27 ++
 tools/perf/util/evlist.h                           |   3 +
 tools/perf/util/evsel.c                            |   1 -
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |   4 +
 tools/perf/util/intel-pt-decoder/intel-pt-log.c    |   5 +
 tools/perf/util/intel-pt-decoder/intel-pt-log.h    |   1 +
 tools/perf/util/intel-pt.c                         |  16 +-
 tools/perf/util/pmu.c                              |   2 +-
 19 files changed, 820 insertions(+), 121 deletions(-)
 create mode 100644 tools/perf/examples/bpf/augmented_raw_syscalls.c

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
  14 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  15 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
  16 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  17 debian:experimental           : Ok   gcc (Debian 8.2.0-4) 8.2.0
  18 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.2.0-4) 8.2.0
  19 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.2.0-4) 8.2.0
  20 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.1.0-12) 8.1.0
  21 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.2.0-4) 8.2.0
  22 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  23 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  24 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  25 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  26 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  27 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  28 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  29 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  30 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
  31 fedora:28                     : Ok   gcc (GCC) 8.1.1 20180712 (Red Hat 8.1.1-5)
  32 fedora:rawhide                : Ok   gcc (GCC) 8.2.1 20180905 (Red Hat 8.2.1-3)
  33 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 7.3.0-r3 p1.4) 7.3.0
  34 mageia:5                      : Ok   gcc (GCC) 4.9.2
  35 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  36 opensuse:13.2                 : Ok   gcc (SUSE Linux) 4.8.3 20140627 [gcc-4_8-branch revision 212064]
  37 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  38 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  39 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  40 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.3.1 20180323 [gcc-7-branch revision 258812]
  41 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  42 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28.0.1)
  43 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  44 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  45 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
  46 ubuntu:15.04                  : Ok   gcc (Ubuntu 4.9.2-10ubuntu13) 4.9.2
  47 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  48 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  49 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  52 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  53 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  54 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  55 ubuntu:17.04                  : Ok   gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
  56 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  57 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  58 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-16ubuntu3) 7.3.0
  59 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-16ubuntu3) 7.3.0
  60 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  61 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  62 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  64 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  65 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  66 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.2.0-1ubuntu2) 8.2.0

  # uname -a
  Linux jouet 4.19.0-rc4-00022-gad3273d5f1b9 #1 SMP Mon Sep 17 17:18:22 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  8e88c29b351e perf tools: Do not zero sample_id_all for group members
  # perf version --build-options
  perf version 4.19.g8e88c2
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
  64: Use vfs_getname probe to get syscall args filenames   : Ok
  65: Check open filename arg using perf trace + vfs_getname: Ok
  66: probe libc's inet_pton & backtrace it with ping       : Ok
  67: Add vfs_getname probe to get syscall args filenames   : Ok

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
            make_no_demangle_O: make NO_DEMANGLE=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
              make_no_libbpf_O: make NO_LIBBPF=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
         make_install_prefix_O: make install prefix=/tmp/krava
       make_util_pmu_bison_o_O: make util/pmu-bison.o
              make_clean_all_O: make clean all
                make_no_gtk2_O: make NO_GTK2=1
                    make_doc_O: make doc
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_backtrace_O: make NO_BACKTRACE=1
               make_no_slang_O: make NO_SLANG=1
             make_no_libperl_O: make NO_LIBPERL=1
             make_no_libnuma_O: make NO_LIBNUMA=1
            make_install_bin_O: make install-bin
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                make_install_O: make install
           make_no_libpython_O: make NO_LIBPYTHON=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
             make_util_map_o_O: make util/map.o
              make_no_libelf_O: make NO_LIBELF=1
                  make_debug_O: make DEBUG=1
                   make_tags_O: make tags
                 make_perf_o_O: make perf.o
                   make_help_O: make help
           make_no_libbionic_O: make NO_LIBBIONIC=1
                   make_pure_O: make
            make_no_libaudit_O: make NO_LIBAUDIT=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                make_no_newt_O: make NO_NEWT=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
                 make_static_O: make LDFLAGS=-static
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
