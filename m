Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2782356-1520539702-2-14504515070794198438
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520539701; b=cjJZZUygVAEOmKZ82+Rsi/HPQcb3ydGAGf67KTGLpTJWKMh
    OLx+ONS+4XxN2FbDMAaTfnpYjGybpltUlEgOLk8rnd4PY1HWhCr5YQ+OW6kYMhz3
    JY9qRcBRIHce6cj/zvZDzdvCSg1+qgf83yeRcccuax6EfLwi0ceVn80cWP7flYOA
    CFXZculmGV24DLRB9c5GqEY2hk3ZMOI5Oouav0Uqt5paPaFtFgXF176gxMt3orUF
    yxSDlZNTFurrIlyBc/somICTc1nGYLH0TRUaoKTX6aIYqEYVx1b2QqWVBQK5M/wC
    03pRNmkjNwrr9yS7t4CJYccoGilAMoPMzMUEyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1520539701; bh=wU258hZz5rY5qc0XYNIvStyIKB
    oyxNG4kEQ2guTR4Wo=; b=TYFjgUgs0YPCYa5DDE3co6NLb758MotX0iH0MBwkkc
    SnQkl6iyZ6jiWZM/DlFpeJHh1Mco4512SWPI9aLdEX6KrEnW6zd2Wsj9mDNuHCL8
    /lCipCUC9T2dGhTB1ItN64oKkuV8nTKZk27T/zmmI9kAfMZgY07MrpGspOqeXTdg
    /OWQqCGDcWydOVSCQrCn4ETlF6mfRrvhEqGOpPBO8ZQlhvXc3Y+xKsu3DwJ/wwcQ
    MvZKWhoVnQCeF1AfJ1EntgHJpu0w9MxsJOoTHWU7bPk4VoqkWjYoVSEIlsb6pK1W
    9yEKYtR4fE/cFJ6CpOeKEEco9SwRVDKFY1XTvkGlkQ4g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750965AbeCHTuo (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 14:50:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:59618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750761AbeCHTul (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 14:50:41 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0D6205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Agustin Vega-Frias <agustinv@codeaurora.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Lakshman Annadorai <lakshmana@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        stable@vger.kernel.org, Stephane Eranian <eranian@google.com>,
        Takashi Iwai <tiwai@suse.de>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Timur Tabi <timur@codeaurora.org>,
        Wang Nan <wangnan0@huawei.com>,
        Wang YanQing <udknight@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/54] perf/core improvements and fixes
Date: Thu,  8 Mar 2018 16:49:35 -0300
Message-Id: <20180308195029.14991-1-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Ingo,

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 3f986eefc89c528bf2d398a6dc3637b743a7139e:

  Merge branch 'perf/urgent' into perf/core, to resolve conflict (2018-03-07 09:23:12 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.17-20180308

for you to fetch changes up to 2427b432e63b4b911100f717c48289195b7a7d62:

  perf tools: Update quipper information (2018-03-08 11:30:54 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

- Support to display the IPC/Cycle in 'annotate' TUI, for systems
  where this info can be obtained, like Intel's >= Skylake (Jin Yao)

- Support wildcards on PMU name in dynamic PMU events (Agustin Vega-Frias)

- Display pmu name when printing unmerged events in stat (Agustin Vega-Frias)

- Auto-merge PMU events created by prefix or glob match (Agustin Vega-Frias)

- Fix s390 'call' operations target function annotation (Thomas Richter)

- Handle s390 PC relative load and store instruction in the augmented
  'annotate', code, used so far in the TUI modes of 'perf report' and
  'perf annotate' (Thomas Richter)

- Provide libtraceevent with a kernel symbol resolver, so that
  symbols in tracepoint fields can be resolved when showing them in
  tools such as 'perf report' (Wang YanQing)

- Refactor the cgroups code to look more like other code in tools/perf,
  using cgroup__{put,get} for refcount operations instead of its
  open-coded equivalent, breaking larger functions, etc (Arnaldo Carvalho de Melo)

- Implement support for the -G/--cgroup target in 'perf trace', allowing
  strace like tracing (plus other events, backtraces, etc) for cgroups
  (Arnaldo Carvalho de Melo)

- Update thread shortname in 'perf sched map' when the thread's COMM
  changes (Changbin Du)

- refcount 'struct mem_info', for better sharing it over several
  users, avoid duplicating structs and fixing crashes related to
  use after free (Jiri Olsa)

- Display perf.data version, offsets in 'perf report --header' (Jiri Olsa)

- Record the machine's memory topology information in a perf.data
  feature section, to be used by tools such as 'perf c2c' (Jiri Olsa)

- Fix output of forced groups in the header for 'perf report' --stdio
  and --tui (Jiri Olsa)

- Better support llvm, clang, cxx make tests in the build process (Jiri Olsa)

- Streamline the 'struct perf_mmap' methods, storing some info in the
  struct instead of passing it via various methods, shortening its
  signatures (Kan Liang)

- Update the quipper perf.data parser library site information (Stephane Eranian)

- Correct perf's man pages title markers for asciidoctor (Takashi Iwai)

- Intel PT fixes and refactorings paving the way for implementing
  support for AUX area sampling (Adrian Hunter)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (13):
      perf record: Combine some auxtrace initialization into a single function
      perf auxtrace: Add missing parameters from kernel-doc comments
      perf auxtrace: Rename some buffer-queuing functions
      perf auxtrace: Make auxtrace_queues__add_buffer() return buffer_ptr
      perf intel-pt: Fix overlap detection to identify consecutive buffers correctly
      perf intel-pt: Fix sync_switch
      perf intel-pt: Fix error recovery from missing TIP packet
      perf intel-pt: Fix timestamp following overflow
      perf intel-pt/bts: In auxtrace_record__init_intel() evlist is never NULL
      perf intel-pt: Get rid of intel_pt_use_buffer_pid_tid()
      perf intel-pt: Tidy old_buffer handling in intel_pt_get_trace()
      perf intel-pt: Remove a check for sampling mode
      perf intel-pt: Adjust overlap-checking to support sampling mode

Agustin Vega-Frias (3):
      perf pmu: Support wildcards on pmu name in dynamic pmu events
      perf pmu: Display pmu name when printing unmerged events in stat
      perf pmu: Auto-merge PMU events created by prefix or glob match

Arnaldo Carvalho de Melo (11):
      perf cgroup: Remove misplaced __maybe_unused
      perf cgroup: Rename 'struct cgroup_sel' to 'struct cgroup'
      perf cgroup: Introduce cgroup__delete()
      perf cgroup: Rename close_cgroup() to cgroup__put()
      perf cgroup: Introduce cgroup__get()
      perf cgroup: Introduce find_cgroup() method
      perf cgroup: Introduce cgroup__new() out of open coded equivalent
      perf cgroup: Add evlist__findnew_cgroup()
      perf cgroup: Add evlist__add_default_cgroup()
      perf cgroup: Make the cgroup name be const char *
      perf trace: Support setting cgroups as targets

Changbin Du (2):
      perf sched: Move thread::shortname to thread_runtime
      perf sched map: Re-annotate shortname if thread comm changed

Jin Yao (1):
      perf annotate: Support to display the IPC/Cycle in TUI mode

Jiri Olsa (11):
      perf report: Fix the output for stdio events list
      perf report: Display perf.data header info
      perf record: Move machine variable down the function
      perf record: Remove progname from struct record
      perf tools: Add refcnt into struct mem_info
      perf c2c: Use mem_info refcnt logic
      perf tools: Add MEM_TOPOLOGY feature to perf data file
      perf tools: Update tags with .cpp files
      perf build: Add llvm/clang/cxx make tests into FEATURE_TESTS_EXTRA
      perf build: Add llvm/clang make targets to FILES
      perf build: Force llvm/clang test compile output to .make.output

Kan Liang (8):
      perf evlist: Store 'overwrite' in struct perf_mmap
      perf mmap: Store mmap scope in struct perf_mmap()
      perf mmap: Use the stored scope data in perf_mmap__push()
      perf mmap: Use the stored data in perf_mmap__read_event()
      perf mmap: Use stored 'overwrite' in perf_mmap__consume()
      perf mmap: Simplify perf_mmap__consume()
      perf mmap: Simplify perf_mmap__read_event()
      perf mmap: Simplify perf_mmap__read_init()

Stephane Eranian (1):
      perf tools: Update quipper information

Takashi Iwai (1):
      perf tools: Correct title markers for asciidoctor

Thomas Richter (2):
      perf annotate: Fix s390 target function disassembly
      perf annotate: Handle s390 PC relative load and store instruction.

Wang YanQing (1):
      perf report: Provide libtraceevent with a kernel symbol resolver

 tools/build/Makefile.feature                       |   6 +-
 tools/build/feature/Makefile                       |  14 +-
 tools/include/linux/bitmap.h                       |   2 +-
 tools/perf/Documentation/perf-data.txt             |   2 +-
 tools/perf/Documentation/perf-ftrace.txt           |   2 +-
 tools/perf/Documentation/perf-kallsyms.txt         |   2 +-
 tools/perf/Documentation/perf-list.txt             |   8 +-
 tools/perf/Documentation/perf-sched.txt            |   2 +-
 tools/perf/Documentation/perf-script-perl.txt      |   2 +-
 tools/perf/Documentation/perf-stat.txt             |  17 ++
 tools/perf/Documentation/perf-trace.txt            |  25 ++
 tools/perf/Documentation/perf.data-file-format.txt |   7 +-
 tools/perf/Makefile.perf                           |   6 +-
 tools/perf/arch/s390/annotate/instructions.c       | 116 +++++++-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c       |   7 +-
 tools/perf/arch/x86/util/auxtrace.c                |  14 +-
 tools/perf/builtin-annotate.c                      |  88 +++++-
 tools/perf/builtin-c2c.c                           |  24 +-
 tools/perf/builtin-kvm.c                           |   9 +-
 tools/perf/builtin-record.c                        |  45 +--
 tools/perf/builtin-report.c                        |  26 +-
 tools/perf/builtin-sched.c                         | 133 ++++++---
 tools/perf/builtin-stat.c                          |  29 +-
 tools/perf/builtin-top.c                           |   7 +-
 tools/perf/builtin-trace.c                         |  57 +++-
 tools/perf/tests/backward-ring-buffer.c            |   5 +-
 tools/perf/tests/bpf.c                             |   5 +-
 tools/perf/tests/code-reading.c                    |   7 +-
 tools/perf/tests/keep-tracking.c                   |   7 +-
 tools/perf/tests/mmap-basic.c                      |   7 +-
 tools/perf/tests/openat-syscall-tp-fields.c        |   7 +-
 tools/perf/tests/perf-record.c                     |   7 +-
 tools/perf/tests/sw-clock.c                        |   7 +-
 tools/perf/tests/switch-tracking.c                 |   7 +-
 tools/perf/tests/task-exit.c                       |   7 +-
 tools/perf/ui/browsers/hists.c                     |   5 +-
 tools/perf/util/annotate.c                         |   2 +-
 tools/perf/util/auxtrace.c                         |  37 ++-
 tools/perf/util/auxtrace.h                         |   2 +
 tools/perf/util/cgroup.c                           | 111 +++++---
 tools/perf/util/cgroup.h                           |  13 +-
 tools/perf/util/env.h                              |   9 +
 tools/perf/util/evlist.c                           |   8 +-
 tools/perf/util/evsel.c                            |  23 +-
 tools/perf/util/evsel.h                            |   6 +-
 tools/perf/util/header.c                           | 312 ++++++++++++++++++++-
 tools/perf/util/header.h                           |   1 +
 tools/perf/util/hist.c                             |   4 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  64 ++---
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   2 +-
 tools/perf/util/intel-pt.c                         | 110 ++++----
 tools/perf/util/machine.c                          |   2 +-
 tools/perf/util/mmap.c                             |  63 ++---
 tools/perf/util/mmap.h                             |  16 +-
 tools/perf/util/parse-events.c                     |  21 +-
 tools/perf/util/parse-events.h                     |   2 +-
 tools/perf/util/parse-events.l                     |   2 +-
 tools/perf/util/parse-events.y                     |  18 +-
 tools/perf/util/python.c                           |   7 +-
 tools/perf/util/symbol.c                           |  22 ++
 tools/perf/util/symbol.h                           |  19 +-
 tools/perf/util/thread.h                           |   1 -
 62 files changed, 1197 insertions(+), 401 deletions(-)

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
   1 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
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
  29 fedora:27                     : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
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
  23: Object code reading                                   : FAILED!
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
  56: x86 rdpmc                                             : Ok
  57: Convert perf time to TSC                              : Ok
  58: DWARF unwind                                          : Ok
  59: x86 instruction decoder - new instructions            : Ok
  60: Use vfs_getname probe to get syscall args filenames   : Ok
  61: probe libc's inet_pton & backtrace it with ping       : Ok
  62: Check open filename arg using perf trace + vfs_getname: Ok
  63: probe libc's inet_pton & backtrace it with ping       : Ok
  64: Add vfs_getname probe to get syscall args filenames   : Ok
  #

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
            make_no_auxtrace_O: make NO_AUXTRACE=1
              make_no_libelf_O: make NO_LIBELF=1
                    make_doc_O: make doc
                   make_tags_O: make tags
        make_with_babeltrace_O: make LIBBABELTRACE=1
           make_no_backtrace_O: make NO_BACKTRACE=1
           make_no_libpython_O: make NO_LIBPYTHON=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
         make_install_prefix_O: make install prefix=/tmp/krava
                   make_pure_O: make
              make_clean_all_O: make clean all
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
         make_with_clangllvm_O: make LIBCLANGLLVM=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
           make_no_libbionic_O: make NO_LIBBIONIC=1
             make_no_libnuma_O: make NO_LIBNUMA=1
                  make_debug_O: make DEBUG=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                make_install_O: make install
                   make_help_O: make help
             make_util_map_o_O: make util/map.o
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
            make_no_demangle_O: make NO_DEMANGLE=1
            make_install_bin_O: make install-bin
                 make_perf_o_O: make perf.o
                make_no_gtk2_O: make NO_GTK2=1
                make_no_newt_O: make NO_NEWT=1
               make_no_slang_O: make NO_SLANG=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
              make_no_libbpf_O: make NO_LIBBPF=1
                 make_static_O: make LDFLAGS=-static
             make_no_libperl_O: make NO_LIBPERL=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
