Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB8FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5CE21850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129658;
	bh=1UFEkMrr+1yX9mBynuLI0Uv3Ja/iR0yRrQBEEdRWYBU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vYCIoTaT4XuwpsgQ4eZNvxymiMEQ1+oGGpwARP5eNxq12d22LerEZHvT+L5tVT+qV
	 EdZdskvn+Xmal4AqiGFjFjzLrqMorhf8ZFW7i8hmJXCHwXp4UWSkCQzQFzZBUI0uap
	 /0g4wW+5kDAYYSOM0Pd4N/mp7Jq1W2x2datzXWJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfBYVU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:20:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:54264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730481AbfBYVUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:20:49 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97F5F21848;
        Mon, 25 Feb 2019 21:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129647;
        bh=1UFEkMrr+1yX9mBynuLI0Uv3Ja/iR0yRrQBEEdRWYBU=;
        h=From:To:Cc:Subject:Date:From;
        b=obpi3vJ3+j9qX+eT96UvQbXHsEu3pX9pOM5JL9s8VppJ0J/S6nIuWZ+HOlHXb/5fx
         /1aP1QeeLmZ8vgcVLnzwbasdeAXTtisXZcXNjbyD9e5HA/dAwRRfczQduylEYw+wyq
         yMvBsRzZW0TCaphNauynuEXkBRBSTT2P1zR5SZwA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mansour Alharthi <malharthi9@gatech.edu>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Tony Jones <tonyj@suse.de>, Wei Li <liwei391@huawei.com>
Subject: [GIT PULL] perf/core improvements and fixes
Date:   Mon, 25 Feb 2019 18:19:58 -0300
Message-Id: <20190225212035.24781-1-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Please consider pulling, this is on top of my previous pull
request, perf-core-for-mingo-5.1-20190220.

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit b4409ae112caa6315f6ee678e953b9fc93e6919c:

  perf tools: Make rm_rf() remove single file (2019-02-20 17:09:28 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.1-20190225

for you to fetch changes up to de667cce7f4f96b6e22da8fd9c065b961f355080:

  perf script python: Add Python3 support to syscall-counts-by-pid.py (2019-02-25 17:17:13 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf annotate:

  Wei Li:

  - Fix getting source line failure.

perf script:

  Andi Kleen:

  - Handle missing fields with -F +...

perf data:

  Jiri Olsa:

  - Prep work to support per-cpu files in a directory.

Intel PT:

  Adrian Hunter:

  - Improve thread_stack__no_call_return()

  - Hide x86 retpolines in thread stacks.

  - exported SQL viewer refactorings, new 'top calls' report.

  Alexander Shishkin:

  - Copy parent's address filter offsets on clone.

  - Fix address filters for vmas with non-zero offset. Applies to
    ARM's CoreSight as well.

python scripts:

  Tony Jones:

  - Python3 support for several 'perf script' python scripts.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (13):
      perf thread-stack: Improve thread_stack__no_call_return()
      perf thread-stack: Hide x86 retpolines
      perf scripts python: exported-sql-viewer.py: Fix missing shebang
      perf scripts python: exported-sql-viewer.py: Remove leftover debugging prints
      perf scripts python: exported-sql-viewer.py: Hide Call Graph option if no calls table
      perf scripts python: exported-sql-viewer.py: Move column headers
      perf scripts python: exported-sql-viewer.py: Factor out ReportDialogBase
      perf scripts python: exported-sql-viewer.py: Factor out ReportVars
      perf scripts python: exported-sql-viewer.py: Move report name into ReportVars
      perf scripts python: exported-sql-viewer.py: Create new dialog data item classes
      perf scripts python: exported-sql-viewer.py: Remove SQLTableDialogDataItem
      perf scripts python: exported-sql-viewer.py: Remove no selection error
      perf scripts python: exported-sql-viewer.py: Add top calls report

Alexander Shishkin (2):
      perf: Copy parent's address filter offsets on clone
      perf, pt, coresight: Fix address filters for vmas with non-zero offset

Andi Kleen (2):
      perf script: Handle missing fields with -F +..
      perf tools: Add perf_exe() helper to find perf binary

Jiri Olsa (9):
      perf data: Move size to struct perf_data_file
      perf data: Add global path holder
      perf tools: Add depth checking to rm_rf
      perf tools: Add pattern name checking to rm_rf
      perf tools: Add rm_rf_perf_data function
      perf data: Make check_backup work over directories
      perf data: Fail check_backup in case of error
      perf data: Add perf_data__(create_dir|close_dir) functions
      perf data: Add perf_data__open_dir_data function

Tony Jones (10):
      perf script python: Add Python3 support to netdev-times.py
      perf script python: Add Python3 support to failed-syscalls-by-pid.py
      perf script python: Add Python3 support to mem-phys-addr.py
      perf script python: Add Python3 support to net_dropmonitor.py
      perf script python: Add Python3 support to powerpc-hcalls.py
      perf script python: Add Python3 support to sctop.py
      perf script python: Add Python3 support to stackcollapse.py
      perf script python: Add Python3 support to stat-cpi.py
      perf script python: Add Python3 support to syscall-counts.py
      perf script python: Add Python3 support to syscall-counts-by-pid.py

Wei Li (1):
      perf annotate: Fix getting source line failure

 arch/x86/events/intel/pt.c                         |   9 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |   7 +-
 include/linux/perf_event.h                         |   7 +-
 kernel/events/core.c                               |  90 ++--
 tools/perf/builtin-annotate.c                      |   4 +-
 tools/perf/builtin-buildid-cache.c                 |   4 +-
 tools/perf/builtin-buildid-list.c                  |   8 +-
 tools/perf/builtin-c2c.c                           |   4 +-
 tools/perf/builtin-diff.c                          |  12 +-
 tools/perf/builtin-evlist.c                        |   4 +-
 tools/perf/builtin-inject.c                        |  10 +-
 tools/perf/builtin-kmem.c                          |   2 +-
 tools/perf/builtin-kvm.c                           |   8 +-
 tools/perf/builtin-lock.c                          |   8 +-
 tools/perf/builtin-mem.c                           |   8 +-
 tools/perf/builtin-record.c                        |  11 +-
 tools/perf/builtin-report.c                        |   6 +-
 tools/perf/builtin-sched.c                         |  16 +-
 tools/perf/builtin-script.c                        |  22 +-
 tools/perf/builtin-stat.c                          |   6 +-
 tools/perf/builtin-timechart.c                     |   8 +-
 tools/perf/builtin-trace.c                         |   8 +-
 tools/perf/scripts/python/exported-sql-viewer.py   | 510 ++++++++++++++-------
 .../perf/scripts/python/failed-syscalls-by-pid.py  |  21 +-
 tools/perf/scripts/python/mem-phys-addr.py         |  24 +-
 tools/perf/scripts/python/net_dropmonitor.py       |  10 +-
 tools/perf/scripts/python/netdev-times.py          |  82 ++--
 tools/perf/scripts/python/powerpc-hcalls.py        |  18 +-
 tools/perf/scripts/python/sctop.py                 |  24 +-
 tools/perf/scripts/python/stackcollapse.py         |   7 +-
 tools/perf/scripts/python/stat-cpi.py              |  10 +-
 tools/perf/scripts/python/syscall-counts-by-pid.py |  22 +-
 tools/perf/scripts/python/syscall-counts.py        |  18 +-
 tools/perf/util/annotate.c                         |   4 +-
 tools/perf/util/data-convert-bt.c                  |   4 +-
 tools/perf/util/data.c                             | 175 ++++++-
 tools/perf/util/data.h                             |  16 +-
 tools/perf/util/header.c                           |  12 +-
 tools/perf/util/thread-stack.c                     | 161 ++++++-
 tools/perf/util/util.c                             |  65 ++-
 tools/perf/util/util.h                             |   3 +
 41 files changed, 1019 insertions(+), 429 deletions(-)

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

  $ export PERF_TARBALL=http://192.168.124.1/perf/perf-5.0.0-rc5.tar.xz
  $ dm
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
  25 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  26 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  27 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  28 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  29 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  30 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  31 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
  32 fedora:28                     : Ok   gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)
  33 fedora:29                     : Ok   gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)
  34 fedora:30                     : Ok   gcc (GCC) 9.0.1 20190203 (Red Hat 9.0.1-0.3)
  35 fedora:rawhide                : Ok   gcc (GCC) 9.0.0 20190119 (Red Hat 9.0.0-0.3)
  36 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 7.3.0-r3 p1.4) 7.3.0
  37 mageia:5                      : Ok   gcc (GCC) 4.9.2
  38 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  39 opensuse:13.2                 : Ok   gcc (SUSE Linux) 4.8.3 20140627 [gcc-4_8-branch revision 212064]
  40 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.3.1 20180323 [gcc-7-branch revision 258812]
  41 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.0
  42 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  43 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  44 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  45 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 8.2.1 20190103 [gcc-8-branch revision 267549]
  46 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  47 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36.0.1)
  48 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  49 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
  50 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
  51 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609
  52 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  53 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  54 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  55 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  56 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  57 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  58 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  59 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  60 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
  61 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
  62 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  63 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  64 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  65 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  66 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  67 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  68 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  69 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  70 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.2.0-7ubuntu1) 8.2.0
  71 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.2.0-20ubuntu1) 8.2.0
  72 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.2.0-20ubuntu1) 8.2.0
  73 ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.2.0-20ubuntu1) 8.2.0
  74 ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.2.0-20ubuntu1) 8.2.0
  $

  # uname -a
  Linux quaco 5.0.0-rc7+ #20 SMP Mon Feb 25 16:16:50 -03 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  de667cce7f4f perf script python: Add Python3 support to syscall-counts-by-pid.py
  # perf version --build-options
  perf version 5.0.rc5.gde667c
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
  25: Object code reading                                   :

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_tags_O: make tags
                   make_help_O: make help
            make_install_bin_O: make install-bin
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                 make_cscope_O: make cscope
       make_util_pmu_bison_o_O: make util/pmu-bison.o
           make_no_libbionic_O: make NO_LIBBIONIC=1
         make_install_prefix_O: make install prefix=/tmp/krava
                   make_pure_O: make
                make_install_O: make install
              make_clean_all_O: make clean all
                make_no_gtk2_O: make NO_GTK2=1
                    make_doc_O: make doc
                make_no_newt_O: make NO_NEWT=1
            make_no_demangle_O: make NO_DEMANGLE=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
             make_no_libnuma_O: make NO_LIBNUMA=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                 make_perf_o_O: make perf.o
             make_no_libperl_O: make NO_LIBPERL=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
              make_no_libelf_O: make NO_LIBELF=1
           make_no_libpython_O: make NO_LIBPYTHON=1
               make_no_slang_O: make NO_SLANG=1
              make_no_libbpf_O: make NO_LIBBPF=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                 make_static_O: make LDFLAGS=-static
             make_util_map_o_O: make util/map.o
                  make_debug_O: make DEBUG=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
