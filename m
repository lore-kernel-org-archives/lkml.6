Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A889C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAD421D62
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJ83RKBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAD421D62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732509AbeHIRYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:24:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732388AbeHIRYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:24:00 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26FF0214FF;
        Thu,  9 Aug 2018 14:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826722;
        bh=kgs5bb9qB9Wad4rMsBeKDT2LHJIQFe4Hnv+jWDYCk6k=;
        h=From:To:Cc:Subject:Date:From;
        b=FJ83RKBJKRC/0fRBsRw0VnO1SKKQnOy0dbkOazLT7kreJUnTaUvx+ms8Gr70HONev
         MDddSp6mpjch3NX3t7MQIewHBHm/+AmmqCgmgohsfmOZMQf+tTa5hYyHNEyPFjeADG
         srlNm7rCzZ0YhQg9j+y86hQYfAOzAz5eZDUsCxiQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-arm-kernel@lists.infradead.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Snitzer <snitzer@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Sean V Kelley <seanvk.dev@oregontracks.org>,
        Stephane Eranian <eranian@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Wang Nan <wangnan0@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        William Cohen <wcohen@redhat.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/44] perf/core improvements and fixes
Date:   Thu,  9 Aug 2018 11:57:38 -0300
Message-Id: <20180809145822.21391-1-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

Several new test environments consisting of building with/without
elfutils 0.173 ELF and DWARF libraries cross built for many
architectures, some appearing in the this container based test
environment for the first time: 

  56 ubuntu:18.04-x-m68k     : Ok  m68k-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  60 ubuntu:18.04-x-riscv64  : Ok  riscv64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  62 ubuntu:18.04-x-sh4      : Ok  sh4-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  63 ubuntu:18.04-x-sparc64  : Ok  sparc64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0

The following changes since commit ec2cb7a526d49b65576301e183448fb51ee543a6:

  Merge tag 'perf-core-for-mingo-4.19-20180801' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2018-08-02 09:59:41 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.19-20180809

for you to fetch changes up to 6a9405b56c274024564f9014bba97b92c91b34d6:

  perf map: Optimize maps__fixup_overlappings() (2018-08-08 15:56:00 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf annotate: (Jiri Olsa)

- Show percentage based on global or local hits or period, adding hotkeys ('p':
  local/global, 'b': hit/period, use 'h' to see all hotkeys in the TUI) to
  toggle those modes in the TUI, as well as a command line to select that, i.e.

      perf report/annotate --percent-type global-period,local-period,global-hits,local-hits

  to help understand the impact an annotated line has globally or just on the
  function's total number of hits or its total period.

  Try using it from the dynamic annotation interface from 'perf top', i.e.
  fire up 'perf top', then press 'a' on a kernel function then try pressing 'p'
  to see, dynamicly, the global/local percentage for the lines with samples.

  This was based on a suggestion made by Stephane Eranian.

perf trace: (Arnaldo Carvalho de Melo)

- Process syscalls:sys_enter_SYSCALLNAME tracepoints using the strace-like
  beautifiers used with raw_syscalls:sys_enter, paving the way to use
  those beautifiers with whatever event carries that payload in its
  PERF_SAMPLE_RAW area (Arnaldo Carvalho de Melo)

- Add more wrappers for BPF functions to be used in eBPF programs, together
  with examples on how to use them, for instance, a "hello, world" like
  program attached to the 'openat' syscall entry tracepoint using a stdio.h
  like puts() function that abstracts access to the bpf_perf_event_output
  eBPF function associated with a eBPF map associated with a "bpf-output"
  (PERF_COUNT_SW_BPF_OUTPUT software event) that gets what is passed into
  the perf ring buffer to finally appear in the 'perf trace' output:

    $ cd tools/perf/examples/bpf/
    $ cat hello.c
    #include <stdio.h>

    int syscall_enter(openat)(void *args)
    {
	    puts("Hello, world\n");
	    return 0;
    }

    license(GPL);
    $
    # perf trace -e hello.c cat /etc/passwd > /dev/null
      0.000 __bpf_stdout__:Hello, world
      0.033 __bpf_stdout__:Hello, world
      0.358 __bpf_stdout__:Hello, world
    #

- Add another example (augmented_syscalls.c) that copies the syscall tracepoint
  payload + the first 64 bytes of 'openat''s 'filename' pointer parameter,
  using the eBPF's probe_read, probe_read_str and perf_event_output, sending to
  an eBPF map associated with a bpf-output perf event that then gets passwd to
  the existing raw_syscalls:sys_enter beautifier.

  The changesets were done very granularly so that we can see that payload
  first processed by the generic bpf_output formatter, where we can see that the
  filename is being copied, together with the raw_syscalls:sys_enter formatter,
  to make sure both agree, e.g.:

  # perf trace -e perf/tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): __augmented_syscalls__:X?.C......................`\..................../etc/ld.so.cache..#......,....ao.k...............k......1.".........
     0.006 (         ): syscalls:sys_enter_openat:dfd: CWD, filename: 0x5c600da8, flags: CLOEXEC
     0.008 ( 0.005 ms): cat/31292 openat(dfd: CWD, filename: 0x5c600da8, flags: CLOEXEC) = 3
     0.036 (         ): __augmented_syscalls__:X?.C.......................\..................../lib64/libc.so.6......... .\....#........?.......=.C..../.".........
     0.037 (         ): syscalls:sys_enter_openat:dfd: CWD, filename: 0x5c808ce0, flags: CLOEXEC
     0.039 ( 0.007 ms): cat/31292 openat(dfd: CWD, filename: 0x5c808ce0, flags: CLOEXEC) = 3
     0.323 (         ): __augmented_syscalls__:X?.C.....................P....................../etc/passwd......>.C....@................>.C.....,....ao.>.C........
     0.325 (         ): syscalls:sys_enter_openat:dfd: CWD, filename: 0xe8be50d6
     0.327 ( 0.004 ms): cat/31292 openat(dfd: CWD, filename: 0xe8be50d6) = 3
  #

  The next step is to improve the beautifiers to use that filename so that we
  can show it just like 'perf trace' + probe:vfs_getname (getname_flags kprobe supported
  by 'perf trace' to show the pathname in syscalls like open, openat, rename, etc) and
  strace does (via ptrace).

  This now requires having a clang installed to turn the augmented_syscalls.c into
  eBPF object to feed the kernel, in upcoming patches this need will be removed by
  making 'perf trace' generate the object directly, or by linking libclang into
  perf's binary, code that is already in merged.

  strace's '-s strsize' will be implemented to state how many bytes we should copy,
  so that a the familiar 'strace' workflow can be mimic'ed some more. Per-event
  terms should also be used to state how many bytes for each pointer arg should be
  copied and subsequently beautified, something like:

     # perf trace -e openat/filename:16/,read/buf:256/

Infrastructure: (Konstantin Khlebnikov)

- Optimize the synthesization of maps for pre-existing threads, synthesizing
  maps just for the thread group leader

- Optimize maps__fixup_overlappings()

Arch specific:

arm64: (Sean V Kelley)

- Enable JSON events for Ampere Computing eMAG processor

s/390: (Thomas Richter)

- Support auxiliary trace on 'perf report'

Cleanups:

- Drop unneeded bitmap_zero() calls (Yury Norov)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (17):
      perf trace: Associate vfs_getname()'ed pathname with fd returned from 'openat'
      perf trace: Use beautifiers on syscalls:sys_enter_ handlers
      perf trace: Rename some syscall_tp methods to raw_syscall
      perf trace: Allow setting up a syscall_tp struct without a format_field
      perf trace: Setup struct syscall_tp for syscalls:sys_{enter,exit}_NAME events
      perf trace: Use perf_evsel__sc_tp_{uint,ptr} for "id"/"args" handling syscalls:* events
      perf bpf: Add 'syscall_enter' probe helper for syscall enter tracepoints
      perf bpf: Add struct bpf_map struct
      perf bpf: Add bpf/stdio.h wrapper to bpf_perf_event_output function
      perf bpf: Make bpf__for_each_stdout_map() generic
      perf bpf: Generalize bpf__setup_stdout()
      perf bpf: Add bpf__setup_output_event() strerror() counterpart
      perf bpf: Add wrappers to BPF_FUNC_probe_read(_str) functions
      perf trace: Handle "bpf-output" events associated with "__augmented_syscalls__" BPF map
      perf bpf: Make bpf__setup_output_event() return the bpf-output event
      perf trace: Setup the augmented syscalls bpf-output event fields
      perf trace: Wire up the augmented syscalls with the syscalls:sys_enter_FOO beautifier

Jiri Olsa (20):
      perf annotate: Make symbol__annotate_fprintf2() local
      perf annotate: Make annotation_line__max_percent static
      perf annotate: Get rid of annotation__scnprintf_samples_period()
      perf annotate: Rename struct annotation_line::samples* to data*
      perf annotate: Rename local sample variables to data
      perf annotate: Rename hist to sym_hist in annotation__calc_percent
      perf annotate: Loop group events directly in annotation__calc_percent()
      perf annotate: Switch struct annotation_data::percent to array
      perf annotate: Add PERCENT_HITS_GLOBAL percent value
      perf annotate: Add PERCENT_PERIOD_LOCAL percent value
      perf annotate: Add PERCENT_PERIOD_GLOBAL percent value
      perf annotate: Add percent_type to struct annotation_options
      perf annotate: Pass struct annotation_options to symbol__calc_lines()
      perf annotate: Pass 'struct annotation_options' to map_symbol__annotation_dump()
      perf annotate: Pass browser percent_type in annotate_browser__calc_percent()
      perf annotate: Add support to toggle percent type
      perf annotate: Make local period the default percent type
      perf annotate: Display percent type in stdio output
      perf annotate: Add --percent-type option
      perf report: Add --percent-type option

Konstantin Khlebnikov (2):
      perf map: Synthesize maps only for thread group leader
      perf map: Optimize maps__fixup_overlappings()

Sean V Kelley (1):
      perf vendor events arm64: Enable JSON events for eMAG

Thomas Richter (3):
      perf auxtrace: Support for perf report -D for s390
      perf report: Add raw report support for s390 auxiliary trace
      perf report: Add GUI report support for s390 auxiliary trace

Yury Norov (1):
      perf tools: Drop unneeded bitmap_zero() calls

 tools/perf/Documentation/perf-annotate.txt         |   9 +
 tools/perf/Documentation/perf-report.txt           |   9 +
 tools/perf/arch/s390/util/auxtrace.c               |   1 +
 tools/perf/builtin-annotate.c                      |   4 +
 tools/perf/builtin-report.c                        |   3 +
 tools/perf/builtin-trace.c                         | 191 ++++-
 tools/perf/examples/bpf/augmented_syscalls.c       |  55 ++
 tools/perf/examples/bpf/hello.c                    |   9 +
 tools/perf/examples/bpf/sys_enter_openat.c         |  33 +
 tools/perf/include/bpf/bpf.h                       |  20 +
 tools/perf/include/bpf/stdio.h                     |  19 +
 .../arch/arm64/ampere/emag/core-imp-def.json       |  32 +
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   1 +
 tools/perf/tests/bitmap.c                          |   2 -
 tools/perf/tests/mem2node.c                        |   2 -
 tools/perf/ui/browsers/annotate.c                  |  76 +-
 tools/perf/util/Build                              |   1 +
 tools/perf/util/annotate.c                         | 301 ++++---
 tools/perf/util/annotate.h                         |  54 +-
 tools/perf/util/auxtrace.c                         |   3 +
 tools/perf/util/auxtrace.h                         |   1 +
 tools/perf/util/bpf-loader.c                       |  48 +-
 tools/perf/util/bpf-loader.h                       |  23 +-
 tools/perf/util/event.c                            |  13 +-
 tools/perf/util/evsel.h                            |   7 +
 tools/perf/util/header.c                           |   3 -
 tools/perf/util/map.c                              |  44 +-
 tools/perf/util/map.h                              |   1 -
 tools/perf/util/s390-cpumsf-kernel.h               |  71 ++
 tools/perf/util/s390-cpumsf.c                      | 945 +++++++++++++++++++++
 tools/perf/util/s390-cpumsf.h                      |  21 +
 31 files changed, 1773 insertions(+), 229 deletions(-)
 create mode 100644 tools/perf/examples/bpf/augmented_syscalls.c
 create mode 100644 tools/perf/examples/bpf/hello.c
 create mode 100644 tools/perf/examples/bpf/sys_enter_openat.c
 create mode 100644 tools/perf/include/bpf/stdio.h
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json
 create mode 100644 tools/perf/util/s390-cpumsf-kernel.h
 create mode 100644 tools/perf/util/s390-cpumsf.c
 create mode 100644 tools/perf/util/s390-cpumsf.h

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
  11 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  12 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
  13 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  14 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
  15 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  16 debian:experimental           : Ok   gcc (Debian 8.2.0-1) 8.2.0
  17 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  18 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  19 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 7.3.0-18) 7.3.0
  20 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  21 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  22 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  23 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  24 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  25 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  26 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  27 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  28 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  29 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
  30 fedora:28                     : Ok   gcc (GCC) 8.1.1 20180502 (Red Hat 8.1.1-1)
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
  43 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
  44 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
  45 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  46 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  47 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  48 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  49 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  52 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  53 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  54 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-16ubuntu3) 7.3.0
  55 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-16ubuntu3) 7.3.0
  56 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  57 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  58 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  59 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  60 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  61 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  62 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  63 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  64 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.2.0-1ubuntu2) 8.2.0
  #

  # uname -a
  Linux jouet 4.18.0-rc8-00002-g1236568ee3cb #12 SMP Tue Aug 7 14:08:26 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  6a9405b56c27 (HEAD -> perf/core, tag: perf-core-for-mingo-4.19-20180809, acme.korg/perf/core) perf map: Optimize maps__fixup_overlappings()
  # perf version --build-options
  perf version 4.18.rc7.g6a9405
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
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
              make_clean_all_O: make clean all
                   make_help_O: make help
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                  make_debug_O: make DEBUG=1
           make_no_backtrace_O: make NO_BACKTRACE=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
              make_no_libelf_O: make NO_LIBELF=1
                 make_perf_o_O: make perf.o
            make_install_bin_O: make install-bin
         make_install_prefix_O: make install prefix=/tmp/krava
                make_no_gtk2_O: make NO_GTK2=1
              make_no_libbpf_O: make NO_LIBBPF=1
                 make_static_O: make LDFLAGS=-static
             make_no_libperl_O: make NO_LIBPERL=1
                 make_cscope_O: make cscope
                make_no_newt_O: make NO_NEWT=1
            make_no_demangle_O: make NO_DEMANGLE=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                   make_pure_O: make
               make_no_slang_O: make NO_SLANG=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                    make_doc_O: make doc
             make_no_libnuma_O: make NO_LIBNUMA=1
                   make_tags_O: make tags
            make_no_auxtrace_O: make NO_AUXTRACE=1
                make_install_O: make install
        make_with_babeltrace_O: make LIBBABELTRACE=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
             make_util_map_o_O: make util/map.o
           make_no_libpython_O: make NO_LIBPYTHON=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
