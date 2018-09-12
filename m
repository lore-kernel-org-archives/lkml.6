Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C164C07520
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C692146D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwjrI9rn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C692146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeIMABV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:01:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbeIMABS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:01:18 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57E122087F;
        Wed, 12 Sep 2018 18:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536778525;
        bh=OGBHG5xgtk7G/uUPEKG7Sa+gKJoI269PjsyJWYBvypE=;
        h=From:To:Cc:Subject:Date:From;
        b=GwjrI9rnMiQFljN7WmDbrvYm+jYEPd3kVS59M7QrMJTBFOVow1wCJ5RHG9m78JwLr
         AWdx9Bnjd6jaEzTRLLZnt0z5Nzvm/X68CwCRDwDumFZrVV6E/lt1NRjNsk6RnO3Lcf
         77l0v00dD7/ClA5yxcOXZO5uPs0NPrHNp3kdFjYI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Dongjiu Geng <gengdongjiu@huawei.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        Eric Anholt <eric@anholt.net>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        James Morse <james.morse@arm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Jim Mattson <jmattson@google.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Sean Paul <seanpaul@chromium.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 0/7] perf/urgent fixes
Date:   Wed, 12 Sep 2018 15:55:02 -0300
Message-Id: <20180912185509.32187-1-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
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

The following changes since commit 02e184476eff848273826c1d6617bb37e5bcc7ad:

  perf/core: Force USER_DS when recording user stack data (2018-09-10 14:01:46 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.19-20180912

for you to fetch changes up to 03db8b583d1c3c84963e08e2abf6c79081da5c31:

  perf tools: Fix maps__find_symbol_by_name() (2018-09-11 14:12:51 -0300)

----------------------------------------------------------------
perf/urgent fixes:

- Fix finding a symbol by name when multiple maps use the same backing DSO,
  so we must first see if that symbol name is in the DSO, then see if it is
  inside the range of addresses for that specific map (Adrian Hunter)

- Update the tools copies of UAPI headers, which silences the warnings
  emitted when building the tools and in some cases, like for the new
  KVM ioctls, results in 'perf trace' being able to translate that
  ioctl number to a string (Arnaldo Carvalho de Melo)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (1):
      perf tools: Fix maps__find_symbol_by_name()

Arnaldo Carvalho de Melo (6):
      tools headers uapi: Update tools's copy of linux/perf_event.h
      tools headers uapi: Update tools's copy of asm-generic/unistd.h
      tools headers uapi: Update tools's copy of drm/drm.h
      tools headers uapi: Update tools's copies of kvm headers
      tools headers uapi: Update tools's copy of linux/vhost.h
      tools headers uapi: Update tools's copy of linux/if_link.h

 tools/arch/arm/include/uapi/asm/kvm.h   | 13 ++++++++++++
 tools/arch/arm64/include/uapi/asm/kvm.h | 13 ++++++++++++
 tools/arch/s390/include/uapi/asm/kvm.h  |  5 ++++-
 tools/arch/x86/include/uapi/asm/kvm.h   | 37 +++++++++++++++++++++++++++++++++
 tools/include/uapi/asm-generic/unistd.h |  4 +++-
 tools/include/uapi/drm/drm.h            |  9 ++++++++
 tools/include/uapi/linux/if_link.h      | 17 +++++++++++++++
 tools/include/uapi/linux/kvm.h          |  6 ++++++
 tools/include/uapi/linux/perf_event.h   |  2 +-
 tools/include/uapi/linux/vhost.h        | 18 ++++++++++++++++
 tools/perf/util/map.c                   | 11 ++++++++++
 11 files changed, 132 insertions(+), 3 deletions(-)

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

The alpine ones are failing due to a XSI/POSIX/GNU disagreement on how
strerror_r() should be implemented, a fix is in the works to make libbpf to use
the str_error_r() that tools/perf/ has been using to work on libraries such as
MUSL, that Alpine Linux uses. This problem was not introduced by any patch in
this series.

  # dm
   1 alpine:3.4                    : FAIL gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : FAIL gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : FAIL gcc (Alpine 6.3.0) 6.3.0
   4 alpine:3.7                    : FAIL gcc (Alpine 6.4.0) 6.4.0
   5 alpine:3.8                    : FAIL gcc (Alpine 6.4.0) 6.4.0
   6 alpine:edge                   : FAIL gcc (Alpine 6.4.0) 6.4.0
libbpf.c: In function 'bpf_object__elf_init':
libbpf.c:472:15: error: initialization makes pointer from integer without a cast [-Werror=int-conversion]
    char *cp = strerror_r(errno, errmsg, sizeof(errmsg));
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

Test "x86 bp modify" fails because this is a kernel that doesn't have the
underlying kernel feature fixed.

  # uname -a
  Linux seventh 4.19.0-rc2-00176-gdb44bf4b4768 #1 SMP Thu Sep 6 14:38:21 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  03db8b583d1c perf tools: Fix maps__find_symbol_by_name()
  # perf version --build-options
  perf version 4.19.rc2.g03db8b
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
              make_no_libbpf_O: make NO_LIBBPF=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
             make_util_map_o_O: make util/map.o
                   make_tags_O: make tags
            make_no_demangle_O: make NO_DEMANGLE=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                 make_static_O: make LDFLAGS=-static
                    make_doc_O: make doc
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
              make_clean_all_O: make clean all
            make_no_auxtrace_O: make NO_AUXTRACE=1
                  make_debug_O: make DEBUG=1
             make_no_libperl_O: make NO_LIBPERL=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                   make_help_O: make help
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                 make_perf_o_O: make perf.o
       make_util_pmu_bison_o_O: make util/pmu-bison.o
        make_with_babeltrace_O: make LIBBABELTRACE=1
                make_no_gtk2_O: make NO_GTK2=1
            make_install_bin_O: make install-bin
                make_no_newt_O: make NO_NEWT=1
                 make_cscope_O: make cscope
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
         make_install_prefix_O: make install prefix=/tmp/krava
           make_no_libpython_O: make NO_LIBPYTHON=1
               make_no_slang_O: make NO_SLANG=1
                   make_pure_O: make
             make_no_libnuma_O: make NO_LIBNUMA=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                make_install_O: make install
              make_no_libelf_O: make NO_LIBELF=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
