Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83257C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4502184E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549379241;
	bh=h2JGpAdA5WA01NBzjNRDJ6A+/2u/e/O5vbftHe+4+gs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hDJu5v0JUQq+SSLAaUKBUeGd/x6p5/QJYqPo8YG+v4M+4WQaTgqSkbsEsCOgjfYIq
	 gnE+WifGDP0El0+ljTSbaEmz2oAIvbjXS9xIpSe1DiLOeRXJoGIZUvsbJ2tc5D6eas
	 CvK3JMh7wMvae+YgT9HZ7RPP0fQsaH8DR7i8e3Bo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfBEPHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:07:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfBEPHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:07:19 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C739A217D6;
        Tue,  5 Feb 2019 15:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549379237;
        bh=h2JGpAdA5WA01NBzjNRDJ6A+/2u/e/O5vbftHe+4+gs=;
        h=From:To:Cc:Subject:Date:From;
        b=Yq2xmxN8lSFQiDs8ksyX4iiskcoM/fvHPWlTCCR49u+F48STcYUsQQXkg+3LlMDms
         zIl4iMEkLVYLs9xF/8zM0twrKJz+fOMCRZ9xxHXbW1t3HbL7RzzWdejSP8pM8V+S3u
         AXyXwe3Z1GTwRJ1EfC9HbY00GbzapWbSPSCZfEXc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Tony Jones <tonyj@suse.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 0/8] perf/urgent fixes
Date:   Tue,  5 Feb 2019 12:07:00 -0300
Message-Id: <20190205150708.9012-1-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
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

The following changes since commit 9dff0aa95a324e262ffb03f425d00e4751f3294e:

  perf/core: Don't WARN() for impossible ring-buffer sizes (2019-02-04 08:45:25 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.0-20190205

for you to fetch changes up to 8f2f350cbdb2c2fbff654cb778139144b48a59ba:

  perf script python: Add Python3 support to tests/attr.py (2019-02-05 10:31:08 -0300)

----------------------------------------------------------------
perf/urgent fixes:

perf trace:

  Arnaldo Carvalho de Melo:

    Fix handling of probe:vfs_getname when the probed routine is
    inlined in multiple places, fixing the collection of the 'filename'
    parameter in open syscalls.

perf test:

  Gustavo A. R. Silva:

    Fix bitwise operator usage in evsel-tp-sched test, which made tat
    test always detect fields as signed.

  Jiri Olsa:

    Filter out hidden symbols from labels, added in systems where the
    annobin plugin is used, such as RHEL8, which, if left in place make
    the DWARF unwind 'perf test' to fail on PPC.

  Tony Jones:

    Fix 'perf_event_attr' tests when building with python3.

perf mem/c2c:

  Ravi Bangoria:

    Fix perf_mem_events on PowerPC.

tools headers UAPI:

  Arnaldo Carvalho de Melo:

    Sync linux/in.h copy from the kernel sources, silencing a perf build warning.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (4):
      perf clang: Do not use 'return std::move(something)'
      tools headers uapi: Sync linux/in.h copy from the kernel sources
      perf symbols: Add fallback definitions for GELF_ST_VISIBILITY()
      perf trace: Support multiple "vfs_getname" probes

Gustavo A. R. Silva (1):
      perf tests evsel-tp-sched: Fix bitwise operator

Jiri Olsa (1):
      perf symbols: Filter out hidden symbols from labels

Ravi Bangoria (1):
      perf mem/c2c: Fix perf_mem_events to support powerpc

Tony Jones (1):
      perf script python: Add Python3 support to tests/attr.py

 tools/include/uapi/linux/in.h             |  2 +-
 tools/perf/Documentation/perf-c2c.txt     | 16 ++++++++++++----
 tools/perf/Documentation/perf-mem.txt     |  2 +-
 tools/perf/arch/powerpc/util/Build        |  1 +
 tools/perf/arch/powerpc/util/mem-events.c | 11 +++++++++++
 tools/perf/builtin-trace.c                | 25 +++++++++++++++++-------
 tools/perf/tests/attr.py                  | 32 ++++++++++++++++++-------------
 tools/perf/tests/evsel-tp-sched.c         |  2 +-
 tools/perf/util/c++/clang.cpp             |  2 +-
 tools/perf/util/mem-events.c              |  2 +-
 tools/perf/util/symbol-elf.c              | 23 +++++++++++++++++++++-
 11 files changed, 88 insertions(+), 30 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/mem-events.c

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

  # export PERF_TARBALL=http://192.168.124.1/perf/perf-5.0.0-rc5.tar.xz
  # dm 
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   6 alpine:3.9                    : Ok   gcc (Alpine 8.2.0) 8.2.0
   7 alpine:edge                   : Ok   gcc (Alpine 8.2.0) 8.2.0
   8 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
   9 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
  10 android-ndk:r12b-arm          : Ok   gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)
  11 android-ndk:r15c-arm          : Ok   gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)
  12 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  13 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  14 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36)
  15 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 8.2.1 20180502
  16 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  17 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2
  18 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  19 debian:experimental           : Ok   gcc (Debian 8.2.0-16) 8.2.0
  20 debian:experimental-x-arm64   : Ok   gcc (Debian 8.2.0-16) 8.2.0
  21 debian:experimental-x-mips    : Ok   gcc (Debian 8.2.0-16) 8.2.0
  22 debian:experimental-x-mips64  : Ok   gcc (Debian 8.2.0-16) 8.2.0
  23 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  24 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  25 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  26 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  27 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
  28 fedora:28                     : Ok   gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)
  29 fedora:29                     : Ok   gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)
  30 fedora:rawhide                : Ok   gcc (GCC) 9.0.0 20190119 (Red Hat 9.0.0-0.3)
  31 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 7.3.0-r3 p1.4) 7.3.0
  32 mageia:5                      : Ok   gcc (GCC) 4.9.2
  33 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  34 opensuse:13.2                 : Ok   gcc (SUSE Linux) 4.8.3 20140627 [gcc-4_8-branch revision 212064]
  35 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.3.1 20180323 [gcc-7-branch revision 258812]
  36 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.0
  37 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  38 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  39 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  40 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 8.2.1 20190103 [gcc-8-branch revision 267549]
  41 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  42 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36.0.1)
  43 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  44 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
  45 ubuntu:14.04.4-x-linaro-arm64 : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
  46 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609
  47 ubuntu:16.04-x-arm            : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609
  48 ubuntu:16.04-x-arm64          : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609
  49 ubuntu:16.04-x-powerpc        : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609
  50 ubuntu:16.04-x-powerpc64      : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609
  51 ubuntu:16.04-x-powerpc64el    : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609
  52 ubuntu:16.04-x-s390           : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609
  53 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  54 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  55 ubuntu:18.04-x-arm            : Ok   gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  56 ubuntu:18.04-x-arm64          : Ok   gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  57 ubuntu:18.04-x-m68k           : Ok   gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  58 ubuntu:18.04-x-powerpc        : Ok   gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  59 ubuntu:18.04-x-powerpc64      : Ok   gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  60 ubuntu:18.04-x-powerpc64el    : Ok   gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  61 ubuntu:18.04-x-riscv64        : Ok   gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  62 ubuntu:18.04-x-s390           : Ok   gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  63 ubuntu:18.04-x-sh4            : Ok   gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  64 ubuntu:18.04-x-sparc64        : Ok   gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  65 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.2.0-7ubuntu1) 8.2.0
  66 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.2.0-15ubuntu1) 8.2.0
  67 ubuntu:19.04-x-alpha          : Ok   gcc (Ubuntu 8.2.0-15ubuntu1) 8.2.0
  68 ubuntu:19.04-x-hppa           : Ok   gcc (Ubuntu 8.2.0-15ubuntu1) 8.2.0
  # 

  # uname -a
  Linux quaco 4.20.3-200.fc29.x86_64 #1 SMP Thu Jan 17 15:19:35 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  8f2f350cbdb2 perf script python: Add Python3 support to tests/attr.py
  # perf version --build-options
  perf version 5.0.rc5.g8f2f350
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
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
                   make_pure_O: make
                    make_doc_O: make doc
               make_no_slang_O: make NO_SLANG=1
                 make_perf_o_O: make perf.o
                 make_static_O: make LDFLAGS=-static
           make_no_libunwind_O: make NO_LIBUNWIND=1
              make_clean_all_O: make clean all
              make_no_libelf_O: make NO_LIBELF=1
             make_no_libnuma_O: make NO_LIBNUMA=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
            make_no_libaudit_O: make NO_LIBAUDIT=1
            make_no_demangle_O: make NO_DEMANGLE=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
         make_with_clangllvm_O: make LIBCLANGLLVM=1
           make_no_libpython_O: make NO_LIBPYTHON=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
             make_util_map_o_O: make util/map.o
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                   make_tags_O: make tags
              make_no_libbpf_O: make NO_LIBBPF=1
            make_install_bin_O: make install-bin
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                make_install_O: make install
         make_install_prefix_O: make install prefix=/tmp/krava
                make_no_newt_O: make NO_NEWT=1
           make_no_backtrace_O: make NO_BACKTRACE=1
             make_no_libperl_O: make NO_LIBPERL=1
                  make_debug_O: make DEBUG=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                   make_help_O: make help
                make_no_gtk2_O: make NO_GTK2=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
