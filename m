Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCACC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CCE218DE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546626843;
	bh=wnzfYpHlKYh558hNk+W49LFzLYoc9OcWFgOg+O0l2lA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kjs34KcblOBiO0UEmlFCTghx2qTJ5DVRfO5IFjt6dNqp8u1L3hGpXgk9NhiOhJ6ot
	 7JjL6DuX1lGzCms67ExAFpQyuq+kQbuefTemmbOqZOarTTgQ4jbNXGBhZUjpBBikZm
	 7gQJrqBfjGbOVIBteQtpHVJcW9lqAV729e9QC45Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfADSeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:34:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:52584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbfADSeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:34:02 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C235218DE;
        Fri,  4 Jan 2019 18:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546626840;
        bh=wnzfYpHlKYh558hNk+W49LFzLYoc9OcWFgOg+O0l2lA=;
        h=From:To:Cc:Subject:Date:From;
        b=1fPWzn2RPWKofccCzcf+mIHHRQQcFu1pQ57DvLO1jFVCEFreZLtGhQyHeBtX34+HR
         325aLyAatOiSNFq3mKlHmoo509F0qCY2p3wSH9/hzRiGidccuPw7je8QdktK4t9djf
         aFOm3FMtFe2JH29qQ1uGQLYjoz5acvjUnBvChnb8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ivan Krylov <krylov.r00t@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Mattias Jacobsson <2pi@mok.nu>
Subject: [GIT PULL 00/16] perf/core improvements and fixes
Date:   Fri,  4 Jan 2019 15:33:21 -0300
Message-Id: <20190104183337.12771-1-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Please consider pulling,

Best regards,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 2573be22e5b6f24a0cabc97715c808c47e29eaaf:

  Merge tag 'perf-core-for-mingo-4.21-20190103' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-01-03 14:05:16 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.21-20190104

for you to fetch changes up to 03fa483821c0b4db7c2b1453d3332f397d82313f:

  perf test shell: Use a fallback to get the pathname in vfs_getname (2019-01-04 15:12:29 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf annotate:

  Ivan Krylov:

  - Pass filename to objdump via execl, fixing usage with filenames
    with special characters.

perf report:

  Jin Yao:

     Fix wrong iteration count in --branch-history

perf stat:

  Jin Yao:

  - Fix endless wait for child process

perf test:

  Arnaldo Carvalho de Melo:

  - Use a fallback to get the pathname in vfs_getname in

tools build:

  Jiri Olsa:

  - Allow overriding CFLAGS assignments.

Misc:

  Arnaldo Carvalho de Melo:

  - Syncronize UAPI headers

  Mattias Jacobsson:

  - Remove redundant va_end() in strbuf_addv()

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (10):
      tools headers x86: Sync disabled-features.h
      tools headers uapi: Sync prctl.h with the kernel sources
      tools beauty: Make the prctl option table generator catch all PR_ options
      tools headers uapi: Update i915_drm.h
      tools headers uapi: Sync linux/in.h copy from the kernel sources
      tools headers uapi: Sync linux/kvm.h with the kernel sources
      tools headers uapi: Sync copy of asm-generic/unistd.h with the kernel sources
      tools headers x86: Sync asm/cpufeatures.h copy with the kernel sources
      perf python: Make sure the python binding output directory is in place
      perf test shell: Use a fallback to get the pathname in vfs_getname

Ivan Krylov (1):
      perf annotate: Pass filename to objdump via execl

Jin Yao (2):
      perf stat: Fix endless wait for child process
      perf report: Fix wrong iteration count in --branch-history

Jiri Olsa (2):
      tools thermal tmon: Use -O3 instead of -O1 if available
      tools iio: Override CFLAGS assignments

Mattias Jacobsson (1):
      perf strbuf: Remove redundant va_end() in strbuf_addv()

 tools/arch/x86/include/asm/cpufeatures.h        |  2 ++
 tools/arch/x86/include/asm/disabled-features.h  |  8 ++++++-
 tools/iio/Makefile                              |  2 +-
 tools/include/uapi/asm-generic/unistd.h         |  4 +++-
 tools/include/uapi/drm/i915_drm.h               |  8 +++++++
 tools/include/uapi/linux/in.h                   | 10 +++++---
 tools/include/uapi/linux/kvm.h                  | 19 +++++++++++++++
 tools/include/uapi/linux/prctl.h                |  8 +++++++
 tools/perf/Makefile.perf                        |  4 +++-
 tools/perf/builtin-stat.c                       |  3 ++-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh |  3 ++-
 tools/perf/trace/beauty/prctl_option.sh         |  2 +-
 tools/perf/util/annotate.c                      |  8 +++----
 tools/perf/util/callchain.c                     | 32 +++++++++++++++----------
 tools/perf/util/callchain.h                     |  1 +
 tools/perf/util/machine.c                       |  2 +-
 tools/perf/util/strbuf.c                        |  1 -
 tools/thermal/tmon/Makefile                     |  2 +-
 18 files changed, 90 insertions(+), 29 deletions(-)

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

  $ dm
   1  alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2  alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3  alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4  alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5  alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   6  alpine:edge                   : Ok   gcc (Alpine 8.2.0) 8.2.0
   7  amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
   8  amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
   9  android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  10  android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  11  centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  12  centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  13  centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36)
  14  clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 8.2.1 20180502
  15  debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  16  debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2
  17  debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  18  debian:experimental           : Ok   gcc (Debian 8.2.0-13) 8.2.0
  19  debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
  20  debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
  21  debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.2.0-11) 8.2.0
  22  debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
  23  fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  24  fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  25  fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  26  fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  27  fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  28  fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  29  fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  30  fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
  31  fedora:28                     : Ok   gcc (GCC) 8.2.1 20181105 (Red Hat 8.2.1-5)
  32  fedora:29                     : Ok   gcc (GCC) 8.2.1 20181105 (Red Hat 8.2.1-5)
  33  fedora:rawhide                : Ok   gcc (GCC) 8.2.1 20181105 (Red Hat 8.2.1-5)
  34  gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 7.3.0-r3 p1.4) 7.3.0
  35  mageia:5                      : Ok   gcc (GCC) 4.9.2
  36  mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  37  opensuse:13.2                 : Ok   gcc (SUSE Linux) 4.8.3 20140627 [gcc-4_8-branch revision 212064]
  38  opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.3.1 20180323 [gcc-7-branch revision 258812]
  39  opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  40  opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  41  opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  42  opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 8.2.1 20181108 [gcc-8-branch revision 265914]
  43  oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  44  oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36.0.1)
  45  ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  46  ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
  47  ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
  48  ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
  49  ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50  ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51  ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  52  ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  53  ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  54  ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  55  ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  56  ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  57  ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
  58  ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
  59  ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  60  ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  61  ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  62  ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  63  ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  64  ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  65  ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  66  ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  67  ubuntu:18.10                  : Ok   gcc (Ubuntu 8.2.0-7ubuntu1) 8.2.0
  68  ubuntu:19.04                  : Ok   gcc (Ubuntu 8.2.0-12ubuntu1) 8.2.0
  69  ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.2.0-11ubuntu1) 8.2.0
  70  ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.2.0-11ubuntu1) 8.2.0

  # uname -a
  Linux quaco 4.19.13-300.fc29.x86_64 #1 SMP Sat Dec 29 22:54:28 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  03fa483821c0 perf test shell: Use a fallback to get the pathname in vfs_getname
  # perf version --build-options
  perf version 4.20.g03fa48
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
            make_no_demangle_O: make NO_DEMANGLE=1
             make_no_libperl_O: make NO_LIBPERL=1
                make_no_newt_O: make NO_NEWT=1
                make_no_gtk2_O: make NO_GTK2=1
              make_no_libbpf_O: make NO_LIBBPF=1
                 make_static_O: make LDFLAGS=-static
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                 make_cscope_O: make cscope
            make_no_libaudit_O: make NO_LIBAUDIT=1
                   make_help_O: make help
            make_no_auxtrace_O: make NO_AUXTRACE=1
             make_no_libnuma_O: make NO_LIBNUMA=1
                 make_perf_o_O: make perf.o
              make_no_libelf_O: make NO_LIBELF=1
         make_install_prefix_O: make install prefix=/tmp/krava
                   make_tags_O: make tags
           make_no_backtrace_O: make NO_BACKTRACE=1
                   make_pure_O: make
           make_no_libunwind_O: make NO_LIBUNWIND=1
               make_no_slang_O: make NO_SLANG=1
                make_install_O: make install
              make_clean_all_O: make clean all
            make_install_bin_O: make install-bin
           make_no_libpython_O: make NO_LIBPYTHON=1
                  make_debug_O: make DEBUG=1
                    make_doc_O: make doc
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
           make_no_libbionic_O: make NO_LIBBIONIC=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
             make_util_map_o_O: make util/map.o
        make_with_babeltrace_O: make LIBBABELTRACE=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $

