Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA84CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD462186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549478962;
	bh=6tUc4+lNzSkzTcd+YLwGduYS/N9lqOh00ssbsrXVgyA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=dAQE2eC/mfKfeIOA1vcCceBnUoGnwYTPRNARW38O+JHF1wXMcG2JuiU6hqs/a8S+H
	 DTQsVBM9rOznf/vWzYBbzCTaLwEIwSUU1KADCQa8caXbMXwG3la4/PNs71/o+NRoC8
	 1fxLBBWU91syzPKq+yhgzdWP14g1DgEVESNRity4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbfBFStU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:49:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:43578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfBFStT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:49:19 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21DB0206DD;
        Wed,  6 Feb 2019 18:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549478957;
        bh=6tUc4+lNzSkzTcd+YLwGduYS/N9lqOh00ssbsrXVgyA=;
        h=From:To:Cc:Subject:Date:From;
        b=Vj1LKQpWjmeq/A1AZx/ItYooOl9f0dSSOdDu6qCx1rlgetJLNn4+13z6uCvxO+Jq1
         3hCO8ajNfDVBF+tf5wgpnYIa8Ss89836Il77BlVUnQVCN01HlfC+zLrcDXYIrzv2EC
         8UR6oGhkq8zvvjFAxVuni4cIwYrRyuXSxJ3sz/0g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Changbin Du <changbin.du@gmail.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        William Cohen <wcohen@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/53] perf/core improvements and fixes
Date:   Wed,  6 Feb 2019 15:48:10 -0300
Message-Id: <20190206184903.24054-1-acme@kernel.org>
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

The following changes since commit ca3bb3d027f69ac3ab1dafb32bde2f5a3a44439c:

  perf/ring_buffer: Convert ring_buffer.aux_refcount to refcount_t (2019-02-04 08:46:17 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.1-20190206

for you to fetch changes up to 16bd4321c2425d37031a902cdbf183e2cd099946:

  perf auxtrace: Add timestamp to auxtrace errors (2019-02-06 11:20:32 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

Hardware tracing:

  Adrian Hunter:

  - Handle calls optimized into jumps to a different symbol
    in the thread stack routines used to process hardware traces (Adrian Hunter)

Intel PT:

  Adrian Hunter:

  - Fix overlap calculation for padding.

  - Fix CYC timestamp calculation after OVF.

  - Packet splitting can only happen in 32-bit.

  - Add timestamp to auxtrace errors.

ARM CoreSight:

  Leo Yan:

  - Add last instruction information in packet

  - Set sample flags for instruction range, exception and
    return packets and for a trace discontinuity.

  - Add exception number in exception packet

  - Change tuple from traceID-CPU# to traceID-metadata

  - Add traceID in packet

  Mathieu Poirier:

  - Add "sinks" group to PMU directory

  - Use event attributes to send sink information to kernel

  - Remove set_drv_config() API, no longer used.

perf annotate:

  Jiri Olsa:

  - Delay symbol annotation to the resort phase, speeding up 'perf report'
    startup.

perf record:

  Alexey Budankov:

  - Allow binding userspace buffers to NUMA nodes.

Symbols:

  Adrian Hunter:

  - Fix calculating of symbol sizes when splitting kallsyms into
    maps for kcore processing.

Vendor events:

  William Cohen:

  - Intel: Fix Load_Miss_Real_Latency on CLX

Misc:

  Arnaldo Carvalho de Melo:

  - Streamline headers, removing includes when all that is needed are
    just forward declarations, fixup the fallout for cases where headers
    should have been explicitely included but were instead obtained
    indirectly, by sheer luck.

  - Add fallback versions for CPU_{OR,EQUAL}(), so that code using it
    continue to build on older systems where those were not yet introduced
    or in systems using some other libc than the GNU one where those
    helpers aren't present.

Documentation:

  Changbin Du:

  - Add documentation for BPF event selection.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (9):
      perf tools: Fix split_kallsyms_for_kcore() for trampoline symbols
      perf thread-stack: Tidy thread_stack__push_cp() usage
      perf thread-stack: Tidy thread_stack__no_call_return() by adding more local variables
      perf thread-stack: Represent jmps to the start of a different symbol
      perf auxtrace: Define auxtrace record alignment
      perf intel-pt: Fix overlap calculation for padding
      perf intel-pt: Fix CYC timestamp calculation after OVF
      perf intel-pt: Packet splitting can happen only on 32-bit
      perf auxtrace: Add timestamp to auxtrace errors

Alexey Budankov (3):
      perf record: Allocate affinity masks
      perf record: Bind the AIO user space buffers to nodes
      perf record: Apply affinity masks when reading mmap buffers

Arnaldo Carvalho de Melo (21):
      perf powerpc: Add missing headers to skip-callchain-idx.c
      perf arm pmu: Add missing linux/string.h header
      perf srccode: Move struct definition from map.h to srccode.h
      perf callchain: Uninline callchain_cursor_reset() to remove map.h dependency
      perf symbols: Introduce map_symbol.h
      pref tools: Add missing map.h includes
      perf map: Move structs and prototypes for map groups to a separate header
      perf tests: Add missing headers so far obtained indirectly
      perf hist: Remove symbol.h from hist.h, just fwd decls are needed
      perf tools: Add missing include for symbols.h
      perf evsel: No need to include symbol.h in evsel.h, symbol_conf.h is enough
      perf thread: Don't include symbol.h, symbol_conf.h is enough
      perf tools: Add missing include <callchain.h> in various places
      perf hist: Remove the needless callchain.h include from hist.h
      perf tests pmu: Add missing headers
      perf pmu: Remove needless evsel.h include, only needs one fwd decl
      perf kvm stat: Replace kvm-stat.h includes with forward declarations
      perf powerpc kvm-stat: Add missing evlist.h header
      perf bpf-loader: Remove unecessary includes from bpf-loader.h
      perf tools: Add fallback versions for CPU_{OR,EQUAL}()
      perf clang: Do not use 'return std::move(something)'

Changbin Du (1):
      perf tools: Add documentation for BPF event selection

Jiri Olsa (3):
      perf hists: Add argument to hists__resort_cb_t callback
      perf evsel: Add output_resort_cb method
      perf report: Move symbol annotation to the resort phase

Leo Yan (8):
      perf cs-etm: Add last instruction information in packet
      perf cs-etm: Set sample flags for instruction range packet
      perf cs-etm: Set sample flags for trace discontinuity
      perf cs-etm: Add exception number in exception packet
      perf cs-etm: Change tuple from traceID-CPU# to traceID-metadata
      perf cs-etm: Add traceID in packet
      perf cs-etm: Set sample flags for exception packet
      perf cs-etm: Set sample flags for exception return packet

Mathieu Poirier (7):
      perf/aux: Make perf_event accessible to setup_aux()
      coresight: perf: Add "sinks" group to PMU directory
      coresight: Use event attributes for sink selection
      perf pmu: Move EVENT_SOURCE_DEVICE_PATH to PMU header file
      perf arm cs-etm: Use event attributes to send sink information to kernel
      perf coresight: Remove set_drv_config() API
      perf pmu: Remove set_drv_config API

William Cohen (1):
      perf vendor events intel: Fix Load_Miss_Real_Latency on CLX

 arch/s390/kernel/perf_cpum_sf.c                    |   6 +-
 arch/x86/events/intel/bts.c                        |   4 +-
 arch/x86/events/intel/pt.c                         |   5 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   | 112 +++++-
 drivers/hwtracing/coresight/coresight-etm-perf.h   |   6 +-
 drivers/hwtracing/coresight/coresight-priv.h       |   1 +
 drivers/hwtracing/coresight/coresight.c            |  60 ++++
 drivers/perf/arm_spe_pmu.c                         |   6 +-
 include/linux/coresight.h                          |   7 +-
 include/linux/perf_event.h                         |   2 +-
 kernel/events/ring_buffer.c                        |   2 +-
 tools/perf/Documentation/perf-config.txt           |  31 ++
 tools/perf/Documentation/perf-record.txt           |  14 +
 tools/perf/arch/arm/tests/dwarf-unwind.c           |   1 +
 tools/perf/arch/arm/util/cs-etm.c                  |  98 +++--
 tools/perf/arch/arm/util/cs-etm.h                  |   3 -
 tools/perf/arch/arm/util/pmu.c                     |   3 +-
 tools/perf/arch/arm64/tests/dwarf-unwind.c         |   1 +
 tools/perf/arch/powerpc/tests/dwarf-unwind.c       |   1 +
 tools/perf/arch/powerpc/util/kvm-stat.c            |   2 +
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  |   3 +
 tools/perf/arch/s390/util/kvm-stat.c               |   1 +
 tools/perf/arch/x86/tests/dwarf-unwind.c           |   1 +
 tools/perf/arch/x86/util/kvm-stat.c                |   1 +
 tools/perf/builtin-annotate.c                      |   1 +
 tools/perf/builtin-c2c.c                           |   9 +-
 tools/perf/builtin-inject.c                        |   2 +
 tools/perf/builtin-kallsyms.c                      |   1 +
 tools/perf/builtin-kmem.c                          |   1 +
 tools/perf/builtin-mem.c                           |   1 +
 tools/perf/builtin-record.c                        |  38 +-
 tools/perf/builtin-report.c                        |  22 +-
 tools/perf/builtin-script.c                        |   1 +
 tools/perf/builtin-stat.c                          |   9 -
 tools/perf/builtin-top.c                           |  14 +-
 tools/perf/builtin-trace.c                         |   2 +
 tools/perf/perf.h                                  |   8 +
 .../arch/x86/cascadelakex/clx-metrics.json         |   2 +-
 tools/perf/scripts/python/export-to-postgresql.py  |   2 +-
 tools/perf/scripts/python/export-to-sqlite.py      |   2 +-
 tools/perf/tests/code-reading.c                    |   2 +
 tools/perf/tests/dwarf-unwind.c                    |   1 +
 tools/perf/tests/hists_common.c                    |   1 +
 tools/perf/tests/hists_cumulate.c                  |   1 +
 tools/perf/tests/hists_filter.c                    |   1 +
 tools/perf/tests/hists_output.c                    |   1 +
 tools/perf/tests/mmap-thread-lookup.c              |   1 +
 tools/perf/tests/pmu.c                             |   2 +
 tools/perf/tests/sample-parsing.c                  |   2 +
 tools/perf/tests/sdt.c                             |   1 +
 tools/perf/ui/browsers/annotate.c                  |   1 +
 tools/perf/ui/browsers/hists.c                     |   3 +
 tools/perf/ui/gtk/annotate.c                       |   2 +
 tools/perf/ui/gtk/hists.c                          |   1 +
 tools/perf/ui/hist.c                               |   1 +
 tools/perf/ui/stdio/hist.c                         |   4 +
 tools/perf/util/Build                              |   1 -
 tools/perf/util/annotate.c                         |   1 +
 tools/perf/util/auxtrace.c                         |  27 +-
 tools/perf/util/auxtrace.h                         |   5 +-
 tools/perf/util/bpf-loader.c                       |   1 +
 tools/perf/util/bpf-loader.h                       |   7 +-
 tools/perf/util/build-id.c                         |   1 +
 tools/perf/util/c++/clang.cpp                      |   2 +-
 tools/perf/util/callchain.c                        |  17 +
 tools/perf/util/callchain.h                        |  20 +-
 tools/perf/util/config.c                           |   1 +
 tools/perf/util/cpu-set-sched.h                    |  50 +++
 tools/perf/util/cpumap.c                           |  10 +
 tools/perf/util/cpumap.h                           |   1 +
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  41 ++-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |   6 +
 tools/perf/util/cs-etm.c                           | 394 ++++++++++++++++++++-
 tools/perf/util/cs-etm.h                           |  53 ++-
 tools/perf/util/db-export.c                        |   1 +
 tools/perf/util/drv_configs.c                      |  78 ----
 tools/perf/util/drv_configs.h                      |  26 --
 tools/perf/util/dso.c                              |   1 +
 tools/perf/util/event.c                            |   2 +
 tools/perf/util/event.h                            |   3 +-
 tools/perf/util/evlist.c                           |   6 +-
 tools/perf/util/evlist.h                           |   2 +-
 tools/perf/util/evsel.h                            |   2 +-
 tools/perf/util/hist.c                             |  21 +-
 tools/perf/util/hist.h                             |   9 +-
 tools/perf/util/intel-bts.c                        |   6 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  39 +-
 tools/perf/util/intel-pt.c                         |  23 +-
 tools/perf/util/kvm-stat.h                         |   7 +-
 tools/perf/util/machine.c                          |   1 +
 tools/perf/util/machine.h                          |   2 +-
 tools/perf/util/map.c                              |   6 +
 tools/perf/util/map.h                              | 100 +-----
 tools/perf/util/map_groups.h                       |  91 +++++
 tools/perf/util/map_symbol.h                       |  22 ++
 tools/perf/util/mmap.c                             | 105 +++++-
 tools/perf/util/mmap.h                             |   3 +-
 tools/perf/util/pmu.c                              |   2 -
 tools/perf/util/pmu.h                              |   5 +-
 tools/perf/util/probe-event.c                      |   2 +
 tools/perf/util/s390-cpumsf.c                      |   7 +-
 .../perf/util/scripting-engines/trace-event-perl.c |   2 +
 .../util/scripting-engines/trace-event-python.c    |   2 +
 tools/perf/util/session.c                          |   5 +
 tools/perf/util/setup.py                           |   5 +
 tools/perf/util/sort.c                             |   8 +-
 tools/perf/util/sort.h                             |   3 +-
 tools/perf/util/srccode.h                          |  13 +
 tools/perf/util/symbol-elf.c                       |   2 +
 tools/perf/util/symbol.c                           |   3 +
 tools/perf/util/symbol.h                           |  14 +-
 tools/perf/util/thread-stack.c                     |  78 ++--
 tools/perf/util/thread-stack.h                     |   3 +
 tools/perf/util/thread.c                           |   1 +
 tools/perf/util/thread.h                           |   7 +-
 tools/perf/util/unwind-libdw.c                     |   2 +
 tools/perf/util/unwind-libunwind-local.c           |   1 +
 tools/perf/util/unwind-libunwind.c                 |   1 +
 tools/perf/util/vdso.c                             |   1 +
 119 files changed, 1399 insertions(+), 473 deletions(-)
 create mode 100644 tools/perf/util/cpu-set-sched.h
 delete mode 100644 tools/perf/util/drv_configs.c
 delete mode 100644 tools/perf/util/drv_configs.h
 create mode 100644 tools/perf/util/map_groups.h
 create mode 100644 tools/perf/util/map_symbol.h

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
  # time dm
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
  Linux quaco 5.0.0-rc3+ #16 SMP Mon Jan 21 12:01:36 -03 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  16bd4321c242 perf auxtrace: Add timestamp to auxtrace errors
  # perf version --build-options
  perf version 5.0.rc5.g16bd43
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
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
           make_no_backtrace_O: make NO_BACKTRACE=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
            make_no_demangle_O: make NO_DEMANGLE=1
                  make_debug_O: make DEBUG=1
                make_no_gtk2_O: make NO_GTK2=1
                   make_tags_O: make tags
              make_clean_all_O: make clean all
         make_install_prefix_O: make install prefix=/tmp/krava
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
              make_no_libelf_O: make NO_LIBELF=1
                 make_cscope_O: make cscope
        make_with_babeltrace_O: make LIBBABELTRACE=1
                 make_perf_o_O: make perf.o
                   make_help_O: make help
               make_no_slang_O: make NO_SLANG=1
                   make_pure_O: make
                 make_static_O: make LDFLAGS=-static
              make_no_libbpf_O: make NO_LIBBPF=1
             make_no_libnuma_O: make NO_LIBNUMA=1
                    make_doc_O: make doc
                make_install_O: make install
           make_no_libpython_O: make NO_LIBPYTHON=1
             make_no_libperl_O: make NO_LIBPERL=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                make_no_newt_O: make NO_NEWT=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
             make_util_map_o_O: make util/map.o
            make_install_bin_O: make install-bin
           make_no_libbionic_O: make NO_LIBBIONIC=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
  OK
  $
