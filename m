Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932904AbeCMMF0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752330AbeCMMFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:05:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87436204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Clark Williams <williams@redhat.com>,
        Christian Hansen <chansen3@cisco.com>, David Ahern <dsahern@gmail.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jayachandran C <jnair@caviumnetworks.com>,
        Jiri Olsa <jolsa@redhat.com>, Joe Mario <jmario@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Kim Phillips <kim.phillips@arm.com>, Leo Yan <leo.yan@linaro.org>,
        linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Martin Vuille <jpmv27@aim.com>, Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <robert.richter@cavium.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>, Will Deacon <will.deacon@arm.com>,
        William Cohen <wcohen@redhat.com>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/31] perf/core improvements and fixes
Date: Tue, 13 Mar 2018 09:04:37 -0300
Message-Id: <20180313120508.29327-1-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 33801b94741d6c3be9713c10aa627477216c21e2:

  perf/core: Fix installing cgroup events on CPU (2018-03-12 15:28:51 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.17-20180313

for you to fetch changes up to 1b442ed71f0b32d07db03efba150d4592875f988:

  perf test: Fix exit code for record+probe_libc_inet_pton.sh (2018-03-12 15:25:20 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

- Add support for pmu events vendor subdirectories, move vendor event
files (JSON format) to "arm" and "cavium" subdirectories (John Garry)

- Enable ThunderX2 B0 events in the "cavium" vendor event files (Ganapatrao Kulkarni)

- Show zero counters as well in 'perf report --stat' (Ingo Molnar)

- Record physical addresses in samples in 'perf c2c record', so that
  the NUMA node can be displayed for cacheline addresses (Jiri Olsa)

- Fix kernel MMAP name setup when --vmlinux is used (Jiri Olsa)

- Display llvm eBPF compiling command in debug output (Jiri Olsa)

- Add libdw DWARF post unwind support for ARM64 (Jean Pihet, Kim Phillips)

- Unwind with libdw doesn't take symfs into account (Martin Vuille)

- Fix exit code for record+probe_libc_inet_pton.sh 'perf test' entry (Sandipan Das)

- Fix code dump when using transaction events with 'perf stat -T' (Thomas Richter)

- Do not call perf_dafault_config() twice in 'perf record' (Yisheng Xie)

- Fix top.call-graph config variable processing in 'perf top' (Yisheng Xie)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Ganapatrao Kulkarni (1):
      perf vendor events arm64: Enable JSON events for ThunderX2 B0

Ingo Molnar (1):
      perf report: Show zero counters as well in 'perf report --stat'

Jiri Olsa (11):
      perf env: Free memory nodes data
      perf tools: Add mem2node object
      perf tests: Add mem2node object test
      perf c2c record: Record physical addresses in samples
      perf c2c report: Make calc_width work with struct c2c_hist_entry
      perf c2c report: Call calc_width() only for displayed entries
      perf c2c report: Display node for cacheline address
      perf c2c report: Add span header over cacheline data
      perf c2c report: Add cacheline address count column
      perf llvm: Display eBPF compiling command in debug output
      perf machine: Fix mmap name setup

John Garry (11):
      perf vendor events: Drop incomplete multiple mapfile support
      perf vendor events: Fix error code in json_events()
      perf vendor events: Drop support for unused topic directories
      perf vendor events: Add support for pmu events vendor subdirectory
      perf vendor events arm64: Relocate ThunderX2 JSON to cavium subdirectory
      perf vendor events arm64: Relocate Cortex A53 JSONs to arm subdirectory
      perf vendor events: Add support for arch standard events
      perf vendor events arm64: Add armv8-recommended.json
      perf vendor events arm64: Fixup ThunderX2 to use recommended events
      perf vendor events arm64: fixup A53 to use recommended events
      perf vendor events arm64: add HiSilicon hip08 JSON file

Kim Phillips (1):
      perf tools arm64: Add libdw DWARF post unwind support for ARM64

Martin Vuille (1):
      perf unwind: Unwind with libdw doesn't take symfs into account

Sandipan Das (1):
      perf test: Fix exit code for record+probe_libc_inet_pton.sh

Thomas Richter (2):
      perf stat: Fix core dump when flag T is used
      perf stat: Make function perf_stat_evsel_id_init static

Yisheng Xie (2):
      perf record: Avoid duplicate call of perf_default_config()
      perf top: Fix top.call-graph config option reading

 tools/perf/Documentation/perf-c2c.txt              |   2 +-
 tools/perf/Makefile.config                         |   2 +-
 tools/perf/arch/arm64/include/arch-tests.h         |  12 +
 tools/perf/arch/arm64/tests/Build                  |   2 +
 tools/perf/arch/arm64/tests/arch-tests.c           |  16 +
 tools/perf/arch/arm64/util/Build                   |   1 +
 tools/perf/arch/arm64/util/unwind-libdw.c          |  60 +++
 tools/perf/builtin-c2c.c                           | 223 +++++++++-
 tools/perf/builtin-record.c                        |   8 +-
 tools/perf/builtin-stat.c                          |   9 +-
 tools/perf/builtin-top.c                           |   6 +-
 tools/perf/pmu-events/Build                        |   2 +
 tools/perf/pmu-events/README                       |  15 +-
 .../arch/arm64/{ => arm}/cortex-a53/branch.json    |  14 +-
 .../pmu-events/arch/arm64/arm/cortex-a53/bus.json  |   8 +
 .../arch/arm64/arm/cortex-a53/cache.json           |  27 ++
 .../arch/arm64/{ => arm}/cortex-a53/memory.json    |  14 +-
 .../arch/arm64/arm/cortex-a53/other.json           |  28 ++
 .../arch/arm64/{ => arm}/cortex-a53/pipeline.json  |  20 +-
 .../pmu-events/arch/arm64/armv8-recommended.json   | 452 +++++++++++++++++++++
 .../arch/arm64/cavium/thunderx2-imp-def.json       |  62 ---
 .../arch/arm64/cavium/thunderx2/core-imp-def.json  |  32 ++
 .../perf/pmu-events/arch/arm64/cortex-a53/bus.json |  22 -
 .../pmu-events/arch/arm64/cortex-a53/cache.json    |  27 --
 .../pmu-events/arch/arm64/cortex-a53/other.json    |  32 --
 .../arch/arm64/hisilicon/hip08/core-imp-def.json   | 122 ++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   6 +-
 tools/perf/pmu-events/jevents.c                    | 288 ++++++++++---
 tools/perf/tests/Build                             |   1 +
 tools/perf/tests/builtin-test.c                    |   4 +
 tools/perf/tests/mem2node.c                        |  75 ++++
 .../tests/shell/record+probe_libc_inet_pton.sh     |   5 +-
 tools/perf/tests/tests.h                           |   1 +
 tools/perf/ui/stdio/hist.c                         |   6 +-
 tools/perf/util/Build                              |   1 +
 tools/perf/util/env.c                              |   4 +
 tools/perf/util/llvm-utils.c                       |  14 +
 tools/perf/util/machine.c                          |  28 +-
 tools/perf/util/mem2node.c                         | 134 ++++++
 tools/perf/util/mem2node.h                         |  19 +
 tools/perf/util/stat.c                             |   2 +-
 tools/perf/util/stat.h                             |   2 -
 tools/perf/util/unwind-libdw.c                     |   2 +-
 43 files changed, 1533 insertions(+), 277 deletions(-)
 create mode 100644 tools/perf/arch/arm64/include/arch-tests.h
 create mode 100644 tools/perf/arch/arm64/tests/arch-tests.c
 create mode 100644 tools/perf/arch/arm64/util/unwind-libdw.c
 rename tools/perf/pmu-events/arch/arm64/{ => arm}/cortex-a53/branch.json (76%)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a53/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a53/cache.json
 rename tools/perf/pmu-events/arch/arm64/{ => arm}/cortex-a53/memory.json (50%)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a53/other.json
 rename tools/perf/pmu-events/arch/arm64/{ => arm}/cortex-a53/pipeline.json (97%)
 create mode 100644 tools/perf/pmu-events/arch/arm64/armv8-recommended.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/bus.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/cache.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/other.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
 create mode 100644 tools/perf/tests/mem2node.c
 create mode 100644 tools/perf/util/mem2node.c
 create mode 100644 tools/perf/util/mem2node.h

Test results:

The first ones are container (docker) based builds of tools/perf with and
without libelf support.  Where clang is available, it is also used to build
perf with/without libelf.

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
   7 amazonlinux:2                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
   8 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   9 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  10 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  11 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  12 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  13 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  14 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
  15 debian:9                      : Ok   gcc (Debian 6.3.0-18) 6.3.0 20170516
  16 debian:experimental           : Ok   gcc (Debian 7.2.0-17) 7.2.1 20171205
  17 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  18 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  19 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 7.2.0-11) 7.2.0
  20 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  21 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  22 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  23 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  24 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  25 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  26 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  27 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  28 fedora:26                     : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
  29 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
  30 fedora:rawhide                : Ok   gcc (GCC) 7.2.1 20170829 (Red Hat 7.2.1-1)
  31 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 6.4.0-r1 p1.3) 6.4.0
  32 mageia:5                      : Ok   gcc (GCC) 4.9.2
  33 mageia:6                      : Ok   gcc (Mageia 5.4.0-5.mga6) 5.4.0
  34 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  35 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  36 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  37 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.3.0
  38 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  39 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  40 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  41 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  42 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.4-2017.05) 5.4.1 20170404
  43 ubuntu:15.04                  : Ok   gcc (Ubuntu 4.9.2-10ubuntu13) 4.9.2
  44 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.5) 5.4.0 20160609
  45 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  46 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  47 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  48 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1) 5.4.0 20160609
  49 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  50 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  51 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  52 ubuntu:17.04                  : Ok   gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
  53 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3) 7.2.0
  54 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.2.0-16ubuntu1) 7.2.0

  # uname -a
  Linux jouet 4.16.0-rc4 #1 SMP Mon Mar 5 12:18:05 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
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
  21: Number of exit events of a simple workload            : Ok
  22: Software clock events period values                   : Ok
  23: Object code reading                                   : Ok
  24: Sample parsing                                        : Ok
  25: Use a dummy software event to keep tracking           : Ok
  26: Parse with no sample_id_all bit set                   : Ok
  27: Filter hist entries                                   : Ok
  28: Lookup mmap thread                                    : Ok
  29: Share thread mg                                       : Ok
  30: Sort output of hist entries                           : Ok
  31: Cumulate child hist entries                           : Ok
  32: Track with sched_switch                               : Ok
  33: Filter fds with revents mask in a fdarray             : Ok
  34: Add fd to a fdarray, making it autogrow               : Ok
  35: kmod_path__parse                                      : Ok
  36: Thread map                                            : Ok
  37: LLVM search and compile                               :
  37.1: Basic BPF llvm compile                              : Ok
  37.2: kbuild searching                                    : Ok
  37.3: Compile source for BPF prologue generation          : Ok
  37.4: Compile source for BPF relocation                   : Ok
  38: Session topology                                      : Ok
  39: BPF filter                                            :
  39.1: Basic BPF filtering                                 : Ok
  39.2: BPF pinning                                         : Ok
  39.3: BPF prologue generation                             : Ok
  39.4: BPF relocation checker                              : Ok
  40: Synthesize thread map                                 : Ok
  41: Remove thread map                                     : Ok
  42: Synthesize cpu map                                    : Ok
  43: Synthesize stat config                                : Ok
  44: Synthesize stat                                       : Ok
  45: Synthesize stat round                                 : Ok
  46: Synthesize attr update                                : Ok
  47: Event times                                           : Ok
  48: Read backward ring buffer                             : Ok
  49: Print cpu map                                         : Ok
  50: Probe SDT events                                      : Ok
  51: is_printable_array                                    : Ok
  52: Print bitmap                                          : Ok
  53: perf hooks                                            : Ok
  54: builtin clang support                                 : Skip (not compiled in)
  55: unit_number__scnprintf                                : Ok
  56: mem2node                                              : Ok
  57: x86 rdpmc                                             : Ok
  58: Convert perf time to TSC                              : Ok
  59: DWARF unwind                                          : Ok
  60: x86 instruction decoder - new instructions            : Ok
  61: Use vfs_getname probe to get syscall args filenames   : Ok
  62: Check open filename arg using perf trace + vfs_getname: Ok
  63: probe libc's inet_pton & backtrace it with ping       : Ok
  64: Add vfs_getname probe to get syscall args filenames   : Ok
  #

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
             make_no_libperl_O: make NO_LIBPERL=1
                make_no_newt_O: make NO_NEWT=1
                  make_debug_O: make DEBUG=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
            make_no_demangle_O: make NO_DEMANGLE=1
              make_no_libelf_O: make NO_LIBELF=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                   make_pure_O: make
            make_no_libaudit_O: make NO_LIBAUDIT=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                 make_perf_o_O: make perf.o
                   make_tags_O: make tags
             make_no_libnuma_O: make NO_LIBNUMA=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
         make_install_prefix_O: make install prefix=/tmp/krava
           make_no_libpython_O: make NO_LIBPYTHON=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                    make_doc_O: make doc
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
                make_no_gtk2_O: make NO_GTK2=1
                make_install_O: make install
            make_install_bin_O: make install-bin
                   make_help_O: make help
                 make_static_O: make LDFLAGS=-static
            make_no_auxtrace_O: make NO_AUXTRACE=1
           make_no_backtrace_O: make NO_BACKTRACE=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
               make_no_slang_O: make NO_SLANG=1
             make_util_map_o_O: make util/map.o
           make_no_libbionic_O: make NO_LIBBIONIC=1
              make_no_libbpf_O: make NO_LIBBPF=1
              make_clean_all_O: make clean all
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $ 
