Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URG_BIZ,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A16BC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E5D20839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ys6Cojmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E5D20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeIFChH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:37:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbeIFChG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:37:06 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 290632073D;
        Wed,  5 Sep 2018 22:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185093;
        bh=JojfYSE7yOFyLngu45ZdL1QD9ttAGz1fSDnLRYiufro=;
        h=From:To:Cc:Subject:Date:From;
        b=Ys6CojmfyD2ZO6ZaV2+IuldVctVzO41ZrUdm1vdRsvXnVwVd+fyxxUjmiEqCuCKt3
         o9lit/mAPXRPvHccFplmu3YIkpwrpAsdu/OrntvWGpJ+mmjFtvypCSStUOrUBwFtHd
         xmlZcVBiITIfHdYzIOn4z+UE23pkpuHOpja05FwE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Benjamin Peterson <benjamin@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        Gianluca Borello <g.borello@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/77] perf/core improvements and fixes
Date:   Wed,  5 Sep 2018 19:03:23 -0300
Message-Id: <20180905220440.20256-1-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Please consider pulling, this is on top of my latest perf/urgent
pull request,

Best regards,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 4e67b2a5df5d3f341776d12ee575e00ca3ef92de:

  perf annotate: Fix parsing aarch64 branch instructions after objdump update (2018-08-30 15:51:54 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.20-20180905

for you to fetch changes up to 1632936480a53d85ef3012cd9f290e247251cbb9:

  perf tests: Fix record+probe_libc_inet_pton.sh without ping's debuginfo (2018-09-05 10:47:56 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf trace:

- Augment the payload of syscall entry/exit tracepoints with the contents
  of pointer arguments, such as the "filename" argument to the "open"
  syscall or the 'struct sockaddr *' argument to the 'connect' syscall.

  This is done using a BPF program that gets compiled and attached to
  various syscalls:sys_enter_NAME tracepoints, copying via a BPF map and
  "bpf-output" perf event the raw_syscalls:sys_enter tracepoint payload +
  the contents of pointer arguments using the "probe_read", "probe_read_str"
  and "perf_event_output" BPF functions.

  The 'perf trace' codebase now just processes these augmented tracepoints
  using the existing beautifiers that now check if there is more in the
  perf_sample->raw_data than what is expected for a normal syscall enter
  tracepoint (the common preamble, syscall id, up to six parameters),
  using that with hand crafted struct beautifiers.

  This is just to show how to augment the existing tracepoints, work will
  be done to use DWARF or BTF info to do the pretty-printing and to create
  the collectors.

  For now this is done using an example restricted C BPF program, but the
  end goal is to have this all autogenerated and done transparently.

  Its still useful to have this example as one can use it as an skeleton and
  write more involved filters, see the etcsnoop.c BPF example, for instance.

  E.g.:

  # cd tools/perf/examples/bpf/
  # perf trace -e augmented_syscalls.c ping -c 1 ::1
     0.000 ( 0.008 ms): openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC) = 3
     0.020 ( 0.004 ms): openat(dfd: CWD, filename: /lib64/libcap.so.2, flags: CLOEXEC) = 3
     0.051 ( 0.004 ms): openat(dfd: CWD, filename: /lib64/libidn.so.11, flags: CLOEXEC) = 3
     0.076 ( 0.003 ms): openat(dfd: CWD, filename: /lib64/libcrypto.so.1.1, flags: CLOEXEC) = 3
     0.106 ( 0.003 ms): openat(dfd: CWD, filename: /lib64/libresolv.so.2, flags: CLOEXEC) = 3
     0.136 ( 0.004 ms): openat(dfd: CWD, filename: /lib64/libm.so.6, flags: CLOEXEC) = 3
     0.194 ( 0.004 ms): openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC) = 3
     0.224 ( 0.003 ms): openat(dfd: CWD, filename: /lib64/libz.so.1, flags: CLOEXEC) = 3
     0.252 ( 0.004 ms): openat(dfd: CWD, filename: /lib64/libdl.so.2, flags: CLOEXEC) = 3
     0.275 ( 0.003 ms): openat(dfd: CWD, filename: /lib64/libpthread.so.0, flags: CLOEXEC) = 3
     0.730 ( 0.007 ms): open(filename: /usr/lib/locale/locale-archive, flags: CLOEXEC) = 3
  PING ::1(::1) 56 data bytes
     0.834 ( 0.008 ms): connect(fd: 5, uservaddr: { .family: INET6, port: 1025, addr: ::1 }, addrlen: 28) = 0
  64 bytes from ::1: icmp_seq=1 ttl=64 time=0.032 ms

  --- ::1 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev = 0.032/0.032/0.032/0.000 ms
     0.914 ( 0.036 ms): sendto(fd: 4<socket:[843044]>, buff: 0x55b5e52e9720, len: 64, addr: { .family: INET6, port: 58, addr: ::1 }, addr_len: 28) = 64
  #

  Use 'perf trace -e augmented_syscalls.c,close ping -c 1 ::1' to see the
  'close' calls as well, as it is not one of the syscalls augmented in that .c
  file.

  (Arnaldo Carvalho de Melo)

- Alias 'umount' to 'umount2' (Benjamin Peterson)

perf stat: (Jiri Olsa)

- Make many builtin-stat.c functions generic, moving display functions
  to a separate file, prep work for adding the ability to store/display
  stat data in perf record/top.

perf annotate: (Kim Phillips)

- Handle arm64 move instructions

perf report: (Thomas Richter):

- Create auxiliary trace data files for s390

libtraceevent: (Tzvetomir Stoyanov (VMware)):

- Split trace-seq related APIs in a separate header file.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (30):
      perf trace: Pass augmented args to the arg formatters when available
      perf trace: Make the augmented_syscalls filter out the tracepoint event
      perf trace: Print the syscall name for augmented_syscalls
      perf trace: Extract the comm/tid printing for syscall enter
      perf trace: Show comm/tid for augmented_syscalls
      perf trace: Use the augmented filename, expanding syscall enter pointers
      perf trace: Augment the 'open' syscall 'filename' arg
      perf trace: Augment inotify_add_watch pathname syscall arg
      perf trace: Introduce augmented_filename_syscall_enter() declarator
      perf trace: Augment 'newstat' (aka 'stat') filename ptr
      perf trace: Add a etcsnoop.c augmented syscalls eBPF utility
      perf bpf: Give precedence to bpf header dir
      perf bpf: Add linux/socket.h to the headers accessible to bpf proggies
      perf trace augmented_syscalls: Augment connect's 'sockaddr' arg
      perf trace augmented_syscalls: Add augmented_sockaddr_syscall_enter()
      perf trace augmented_syscalls: Augment bind's 'myaddr' sockaddr arg
      perf trace augmented_syscalls: Augment sendto's 'addr' arg
      perf trace beauty: Reorganize 'struct sockaddr *' beautifier
      perf bpf: Add syscall_exit() helper
      perf augmented_syscalls: Update the header comments
      perf trace augmented_syscalls: Rename augmented_*_syscall__enter to just *_syscall
      perf trace augmented_syscalls: Hook into syscalls:sys_exit_SYSCALL too
      perf trace: Show comm and tid for tracepoint events
      perf augmented_syscalls: Check probe_read_str() return separately
      perf augmented_syscalls: Avoid optimization to pass older BPF validators
      perf trace: Introduce syscall__augmented_args() method
      perf trace: Setup augmented_args in the raw_syscalls:sys_enter handler
      perf trace: Use the raw_syscalls:sys_enter for the augmented syscalls
      perf map: Turn some pr_warning() to pr_debug()
      perf tests: Fix record+probe_libc_inet_pton.sh without ping's debuginfo

Benjamin Peterson (1):
      perf trace beauty: Alias 'umount' to 'umount2'

Jiri Olsa (43):
      perf stat: Use evsel->threads in create_perf_stat_counter()
      perf stat: Move 'initial_delay' to 'struct perf_stat_config'
      perf stat: Move 'no_inherit' to 'struct perf_stat_config'
      perf stat: Use local config arg for scale in create_perf_stat_counter()
      perf stat: Add 'identifier' flag to 'struct perf_stat_config'
      perf tools: Switch 'session' argument to 'evlist' in perf_event__synthesize_attrs()
      perf evsel: Introduce perf_evsel__store_ids()
      perf stat: Move create_perf_stat_counter() to stat.c
      perf stat: Rename 'is_pipe' argument to 'attrs' in perf_stat_synthesize_config()
      perf stat: Add 'struct perf_stat_config' argument to perf_stat_synthesize_config()
      perf stat: Add 'struct perf_tool' argument to perf_stat_synthesize_config()
      perf stat: Add 'struct perf_evlist' argument to perf_stat_synthesize_config()
      perf stat: Add 'perf_event__handler_t' argument to perf_stat_synthesize_config()
      perf stat: Move perf_stat_synthesize_config() to stat.c
      perf stat: Introduce perf_evlist__print_counters()
      perf stat: Move STAT_RECORD out of perf_evlist__print_counters()
      perf stat: Add 'struct perf_stat_config' argument to perf_evlist__print_counters()
      perf stat: Pass 'struct perf_stat_config' argument to local print functions
      perf stat: Pass a 'struct perf_stat_config' argument to global print functions
      perf stat: Move csv_* to 'struct perf_stat_config'
      perf stat: Move 'interval_clear' to 'struct perf_stat_config'
      perf stat: Move 'metric_only' to 'struct perf_stat_config'
      perf stat: Move 'unit_width' to 'struct perf_stat_config'
      perf stat: Add 'target' argument to perf_evlist__print_counters()
      perf stat: Pass 'evlist' argument to print functions
      perf stat: Use 'evsel->evlist' instead of 'evsel_list' in collect_all_aliases()
      perf stat: Move 'run_count' to 'struct perf_stat_config'
      perf stat: Move 'metric_only_len' to 'struct perf_stat_config'
      perf stat: Pass 'struct perf_stat_config' to first_shadow_cpu()
      perf stat: Pass 'evlist' to aggr_update_shadow()
      perf stat: Add 'walltime_nsecs_stats' pointer to 'struct perf_stat_config'
      perf stat: Move 'null_run' to 'struct perf_stat_config'
      perf stat: Move 'print_free_counters_hint' to 'struct perf_stat_config'
      perf stat: Move 'print_mixed_hw_group_error' to 'struct perf_stat_config'
      perf stat: Move ru_* data to 'struct perf_stat_config'
      perf stat: Move *_aggr_* data to 'struct perf_stat_config'
      perf stat: Do not use the global 'evsel_list' in print functions
      perf stat: Move 'big_num' data to 'struct perf_stat_config'
      perf stat: Move 'no_merge' data to 'struct perf_stat_config'
      perf stat: Propagate 'struct target' arg to sort_aggr_thread()
      perf stat: Move 'walltime_*' data to 'struct perf_stat_config'
      perf stat: Move 'metric_events' to 'struct perf_stat_config'
      perf stat: Move the display functions to stat-display.c

Kim Phillips (1):
      perf annotate: Handle arm64 move instructions

Thomas Richter (1):
      perf report: Create auxiliary trace data files for s390

Tzvetomir Stoyanov (VMware) (1):
      tools lib traceevent, perf tools: Split trace-seq related APIs in a separate header file

 tools/lib/traceevent/event-parse.c                 |    1 +
 tools/lib/traceevent/event-parse.h                 |   46 +-
 tools/lib/traceevent/event-plugin.c                |    1 +
 tools/lib/traceevent/plugin_function.c             |    1 +
 tools/lib/traceevent/plugin_hrtimer.c              |    1 +
 tools/lib/traceevent/plugin_jbd2.c                 |    1 +
 tools/lib/traceevent/plugin_kmem.c                 |    1 +
 tools/lib/traceevent/plugin_kvm.c                  |    1 +
 tools/lib/traceevent/plugin_mac80211.c             |    1 +
 tools/lib/traceevent/plugin_sched_switch.c         |    1 +
 tools/lib/traceevent/plugin_scsi.c                 |    1 +
 tools/lib/traceevent/plugin_xen.c                  |    1 +
 tools/lib/traceevent/trace-seq.c                   |    2 +
 tools/lib/traceevent/trace-seq.h                   |   55 +
 tools/perf/Makefile.perf                           |    4 +-
 tools/perf/arch/arm64/annotate/instructions.c      |   59 +-
 tools/perf/arch/s390/annotate/instructions.c       |    2 -
 tools/perf/builtin-record.c                        |    2 +-
 tools/perf/builtin-script.c                        |    8 +-
 tools/perf/builtin-stat.c                          | 1440 ++------------------
 tools/perf/builtin-trace.c                         |  163 ++-
 tools/perf/examples/bpf/augmented_syscalls.c       |  154 ++-
 tools/perf/examples/bpf/etcsnoop.c                 |   80 ++
 tools/perf/include/bpf/bpf.h                       |    3 +
 tools/perf/include/bpf/linux/socket.h              |   24 +
 .../tests/shell/record+probe_libc_inet_pton.sh     |    2 +-
 tools/perf/trace/beauty/Build                      |    1 +
 tools/perf/trace/beauty/beauty.h                   |   34 +
 tools/perf/trace/beauty/sockaddr.c                 |   76 ++
 tools/perf/util/Build                              |    1 +
 tools/perf/util/evsel.c                            |   29 +
 tools/perf/util/evsel.h                            |    1 +
 tools/perf/util/header.c                           |    6 +-
 tools/perf/util/header.h                           |    2 +-
 tools/perf/util/llvm-utils.c                       |    2 +-
 tools/perf/util/map.c                              |   15 +-
 tools/perf/util/s390-cpumsf.c                      |   94 +-
 tools/perf/util/stat-display.c                     | 1166 ++++++++++++++++
 tools/perf/util/stat-shadow.c                      |  147 +-
 tools/perf/util/stat.c                             |   95 ++
 tools/perf/util/stat.h                             |   72 +-
 tools/perf/util/trace-event.h                      |    1 +
 42 files changed, 2262 insertions(+), 1535 deletions(-)
 create mode 100644 tools/lib/traceevent/trace-seq.h
 create mode 100644 tools/perf/examples/bpf/etcsnoop.c
 create mode 100644 tools/perf/include/bpf/linux/socket.h
 create mode 100644 tools/perf/trace/beauty/sockaddr.c
 create mode 100644 tools/perf/util/stat-display.c

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

Test "x86 bp modify" fails because this is a distro kernel that doesn't have
the underlying kernel feature fixed.

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
  18 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  19 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  20 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.1.0-12) 8.1.0
  21 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
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
  32 fedora:rawhide                : Ok   gcc (GCC) 8.2.1 20180801 (Red Hat 8.2.1-2)
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
  46 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
  47 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  48 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  49 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  52 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  53 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  54 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  55 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  56 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-16ubuntu3) 7.3.0
  57 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-16ubuntu3) 7.3.0
  58 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  59 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  60 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  61 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  62 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  63 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  64 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  65 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  66 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.2.0-4ubuntu1) 8.2.0
  # 

  # uname -a
  Linux seventh 4.17.17-100.fc27.x86_64 #1 SMP Mon Aug 20 15:53:11 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  1632936480a5 perf tests: Fix record+probe_libc_inet_pton.sh without ping's debuginfo
  # perf version --build-options
  perf version 4.18.g1632936
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
  62: x86 bp modify                                         : FAILED!
  63: probe libc's inet_pton & backtrace it with ping       : Ok
  64: Check open filename arg using perf trace + vfs_getname: Ok
  65: Use vfs_getname probe to get syscall args filenames   : Ok
  66: Add vfs_getname probe to get syscall args filenames   : Ok

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
             make_no_libperl_O: make NO_LIBPERL=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
              make_clean_all_O: make clean all
           make_no_libunwind_O: make NO_LIBUNWIND=1
                    make_doc_O: make doc
              make_no_libelf_O: make NO_LIBELF=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                make_install_O: make install
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                make_no_gtk2_O: make NO_GTK2=1
                 make_perf_o_O: make perf.o
         make_with_clangllvm_O: make LIBCLANGLLVM=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
             make_no_libnuma_O: make NO_LIBNUMA=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                   make_pure_O: make
                   make_tags_O: make tags
               make_no_slang_O: make NO_SLANG=1
         make_install_prefix_O: make install prefix=/tmp/krava
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                  make_debug_O: make DEBUG=1
                   make_help_O: make help
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
              make_no_libbpf_O: make NO_LIBBPF=1
            make_install_bin_O: make install-bin
           make_no_libbionic_O: make NO_LIBBIONIC=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
                make_no_newt_O: make NO_NEWT=1
            make_no_demangle_O: make NO_DEMANGLE=1
             make_util_map_o_O: make util/map.o
                 make_static_O: make LDFLAGS=-static
           make_no_libpython_O: make NO_LIBPYTHON=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $ 
