Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D37C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA6625F73
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xlnquxXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA6625F73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964813AbeFYRlE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934594AbeFYRlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:41:01 -0400
Received: from jouet.infradead.org (unknown [177.79.80.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CC6F25C6E;
        Mon, 25 Jun 2018 17:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529948460;
        bh=ZCsny4Kt4N8MQBgAnPm6DF9VqY6fhmbWjnJa0Iyat3M=;
        h=From:To:Cc:Subject:Date:From;
        b=xlnquxXWh9K797ndauJ8LXXq/ERUJl0YsX+Kd/Ltmcs3IOgxT2DIH7xlOpSrqMAdA
         idQQWW+9EPohdVwNgOewiDB3jVGEEoTs+x+vturTWM931aRuvSMp5ITERIFGwNSbRH
         CBp4ofD3/Rsh6uMsDHki5pYgBHsD1RtrCgtlsMlQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@fb.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Leblond <eric@regit.org>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>, stable@vger.kernel.org,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/19] perf/urgent fixes for 4.18
Date:   Mon, 25 Jun 2018 14:40:26 -0300
Message-Id: <20180625174045.25765-1-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
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

The following changes since commit 57d6a7938a8fc6cee8420b40ca244220b41721f5:

  perf/core: Move the inline keyword at the beginning of the function declaration (2018-06-22 11:07:47 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.18-20180625

for you to fetch changes up to 92ead7ee30c80f8852d28735cbcb9d79bc85f715:

  perf tools: Fix crash caused by accessing feat_ops[HEADER_LAST_FEATURE] (2018-06-25 11:59:37 -0300)

----------------------------------------------------------------
perf/urgent fixes:

perf bench: (Jiri Olsa):

. Fix NUMA report output code handling of less than 1s runtimes.

perf script: (Ravi Bangoria)

. Add missing output fields in a 'perf script -h' hint.

. Fix crash because of missing evsel->priv.

. Fix crash caused by accessing feat_ops[HEADER_LAST_FEATURE], which
  is just a end of features header marker.

perf stat: (Thomas Richter)

. Remove duplicate event counting

perf test:

. Wire parsing error handling in 'parse events' test (Jiri Olsa)

. Fix 'session topology' test on s/390 (Thomas Richter)

eBPF: (Yonghong Song)

. Fix a clang 7.0 compilation error when building perf linking
  with libclang

intel-pt: (Adrian Hunter)

. Fix packet decoding of CYC packets.

Copies of kernel files: (Arnaldo Carvalho de Melo)

. Synchronize drm/drm.h UAPI

. Update x86's syscall_64.tbl, adding support for 'io_pgetevents' and 'rseq'
  in 'perf trace'.

. Update powerpc uapi/asm/unistd.h, adding support for the 'rseq' syscall.

. Update if_link.h and bpf.h, no effect on tool features.

PowerPC: (Sandipan Das)

. Fix crash if callchain is empty.

s/390: (Thomas Richter)

. Support random socked_id assignment in the perf header.

. Support s390 random socket_id assignment in perf.data file.

. Make PMU alias definitions taken from sysfs and JSON files comparable
  by normalizing them wrt spaces and newlines.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (1):
      perf intel-pt: Fix packet decoding of CYC packets

Arnaldo Carvalho de Melo (5):
      tools headers uapi: Synchronize drm/drm.h
      perf tools: Update x86's syscall_64.tbl, adding 'io_pgetevents' and 'rseq'
      tools include powerpc: Update arch/powerpc/include/uapi/asm/unistd.h copy to get 'rseq' syscall
      tools include uapi: Update if_link.h to pick IFLA_{BRPORT_ISOLATED,VXLAN_TTL_INHERIT}
      tools include uapi: Synchronize bpf.h with the kernel

Jiri Olsa (3):
      perf tests: Add event parsing error handling to parse events test
      perf tests: Add valid callback for parse-events test
      perf bench: Fix numa report output code

Ravi Bangoria (3):
      perf script: Add missing output fields in a hint
      perf script: Fix crash because of missing evsel->priv
      perf tools: Fix crash caused by accessing feat_ops[HEADER_LAST_FEATURE]

Sandipan Das (1):
      perf report powerpc: Fix crash if callchain is empty

Thomas Richter (5):
      perf record: Support s390 random socket_id assignment
      perf test session topology: Fix test on s390
      perf alias: Remove trailing newline when reading sysfs files
      perf alias: Rebuild alias expression string to make it comparable
      perf stat: Remove duplicate event counting

Yonghong Song (1):
      perf tools: Fix a clang 7.0 compilation error

 tools/arch/powerpc/include/uapi/asm/unistd.h       |  1 +
 tools/include/uapi/drm/drm.h                       |  7 ++
 tools/include/uapi/linux/bpf.h                     |  2 +-
 tools/include/uapi/linux/if_link.h                 |  2 +
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  |  2 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |  2 +
 tools/perf/bench/numa.c                            |  5 +-
 tools/perf/builtin-annotate.c                      | 11 ++-
 tools/perf/builtin-report.c                        |  3 +-
 tools/perf/builtin-script.c                        | 30 ++++++-
 tools/perf/tests/parse-events.c                    | 25 ++++--
 tools/perf/tests/topology.c                        |  1 +
 tools/perf/util/c++/clang.cpp                      | 11 ++-
 tools/perf/util/header.c                           | 12 ++-
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   |  2 +-
 tools/perf/util/pmu.c                              | 99 +++++++++++++++++++++-
 16 files changed, 194 insertions(+), 21 deletions(-)

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
   6 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
   7 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
   8 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   9 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  10 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  11 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  12 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
  13 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  14 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
  15 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  16 debian:experimental           : Ok   gcc (Debian 7.3.0-19) 7.3.0
  17 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 7.3.0-19) 7.3.0
  18 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 7.3.0-19) 7.3.0
  19 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 7.3.0-18) 7.3.0
  20 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 7.3.0-19) 7.3.0
  21 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  22 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  23 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  24 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  <stopped due to a power outage>

  # git log --oneline -1
  92ead7ee30c8 (HEAD -> perf/urgent) perf tools: Fix crash caused by accessing feat_ops[HEADER_LAST_FEATURE]
  # perf version
  perf version 4.17.g92ead7
  # uname -a
  Linux jouet 4.17.0-rc5 #21 SMP Mon May 14 15:35:35 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
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
  38.4: Compile source for BPF relocation                   : Ok
  39: Session topology                                      : Ok
  40: BPF filter                                            :
  40.1: Basic BPF filtering                                 : Ok
  40.2: BPF pinning                                         : Ok
  40.3: BPF prologue generation                             : Ok
  40.4: BPF relocation checker                              : Ok
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
  62: Use vfs_getname probe to get syscall args filenames   : Ok
  63: Check open filename arg using perf trace + vfs_getname: Ok
  64: probe libc's inet_pton & backtrace it with ping       : Ok
  65: Add vfs_getname probe to get syscall args filenames   : Ok
  #
  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
         make_install_prefix_O: make install prefix=/tmp/krava
                make_install_O: make install
              make_clean_all_O: make clean all
             make_no_libnuma_O: make NO_LIBNUMA=1
                 make_perf_o_O: make perf.o
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
              make_no_libelf_O: make NO_LIBELF=1
            make_no_demangle_O: make NO_DEMANGLE=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                   make_pure_O: make
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
             make_util_map_o_O: make util/map.o
       make_util_pmu_bison_o_O: make util/pmu-bison.o
            make_install_bin_O: make install-bin
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                    make_doc_O: make doc
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
                   make_tags_O: make tags
                 make_static_O: make LDFLAGS=-static
               make_no_slang_O: make NO_SLANG=1
              make_no_libbpf_O: make NO_LIBBPF=1
             make_no_libperl_O: make NO_LIBPERL=1
                  make_debug_O: make DEBUG=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                make_no_newt_O: make NO_NEWT=1
           make_no_libpython_O: make NO_LIBPYTHON=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                   make_help_O: make help
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                make_no_gtk2_O: make NO_GTK2=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $ 
  
