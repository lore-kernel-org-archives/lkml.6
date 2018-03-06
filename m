Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-891914-1520357043-2-2358070342291721852
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520357042; b=NpWJCaDOhOzUJNObOrBQywaHwIEPKOaQx5BUyomwXC0HMuE
    g0mXyhDypbHXMFprHttfXLpJfJQ3AHA/jQdbNZkfC8ykHYxPIUf+tJ30eo1/bVCz
    2ZDoQeo+az6T81LZrVu+PKqi/3tE6yjNnw1ki0m8SS+rmKQMXUcxkEKjTDa4ncSt
    NV+poHlv4Z1umj8ZvNd0gLsBWd8Ftc9fYsA2Qwb7Lb3LwuZSO2u3p8I6JrY0CYkL
    OgnN9CTI2g1Ps7FGaY7QgFJAcMCSTU89DchsvunkGsYZDo2R4nYfBsLo3G9BjjOC
    nFqHPbrKYYIApXhtNP3yhkSByk9j3OBuU3bZfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1520357042; bh=gxbCwXUotEkEeEifDdq/36ch6B
    J6VC1G/yvb/vvJVaQ=; b=cFbzjH8vZCVpSK9/KlHSULL32MZlPkrWrSvDyN+Dwv
    XFfE90WugY7h5nz8IIqbUVFa5G3c0ZMfX2AFUfTSkL5HuOD/E2JybvOOMNcaC1p4
    sO9YYMRARhsiB68ArrlzYDyh4hBJsTDMgaJJ2PxsqBsuE2Eu2hrslV+y0Jza5DKB
    4Z7YSckf3IVMcBoBi0WJA/5rxe2CBckhaCtJGNKNoPB3mrD6aqMoVG5n6sAvMgN9
    nDbUBhi/gRwUPjYEz0U9tkISSclZPQ1Vgw+GIskOKmh8Ns2NnfzErBhNlcDBzgNa
    wmw7XmEKNgS9af0DJE3AQDLaW/ns+sOZ379t0Juw/UUw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S1750838AbeCFRX7 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 12:23:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:55122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753880AbeCFRX6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Mar 2018 12:23:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E4EA20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ilya Pronin <ipronin@twitter.com>, Jin Yao <yao.jin@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sangwon Hong <qpakzk@gmail.com>, stable@vger.kernel.org,
        Taeung Song <treeze.taeung@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 0/9] perf/urgent fixes
Date: Tue,  6 Mar 2018 14:23:34 -0300
Message-Id: <20180306172343.16546-1-acme@kernel.org>
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

The following changes since commit 58bdf601c2de6071d0386a7a6fa707bd04761c47:

  Merge branch 'i2c/for-current-fixed' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux (2018-03-03 14:55:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.16-20180306

for you to fetch changes up to 8f2c9efabe1ed212b88ce1c5cf5e768385c9222e:

  perf record: Combine some auxtrace initialization into a single function (2018-03-06 12:03:39 -0300)

----------------------------------------------------------------
perf/urgent fixes:

- Be more robust when drawing arrows in the annotation TUI, avoiding a
  segfault when jump instructions have as a target addresses in functions
  other that the one currently being annotated. The full fix will come in
  the following days, when jumping to other functions will work as call
  instructions (Arnaldo Carvalho de Melo)

- Prevent auxtrace_queues__process_index() from queuing AUX area data for
  decoding when the --no-itrace option has been used (Adrian Hunter)

- Sync copy of kvm UAPI headers and x86's cpufeatures.h (Arnaldo Carvalho de Melo)

- Fix 'perf stat' CVS output format for non-supported counters (Ilya Pronin)

- Fix crash in 'perf record|perf report' pipe mode (Jiri Olsa)

- Fix annoying 'perf top' overwrite fallback message on older kernels (Kan Liang)

- Fix the usage on the 'perf kallsyms' man page (Sangwon Hong)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
The following changes since commit 317660940fd9dddd3201c2f92e25c27902c753fa:

  perf/x86/intel/uncore: Fix Skylake UPI event format (2018-03-04 09:59:00 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.16-20180306

for you to fetch changes up to de19e5c3c51fdb1ff20d0f61d099db902ff7494b:

  perf tools: Fix trigger class trigger_on() (2018-03-06 11:31:14 -0300)

----------------------------------------------------------------
perf/urgent fixes:

- Be more robust when drawing arrows in the annotation TUI, avoiding a
  segfault when jump instructions have as a target addresses in functions
  other that the one currently being annotated. The full fix will come in
  the following days, when jumping to other functions will work as call
  instructions (Arnaldo Carvalho de Melo)

- Prevent auxtrace_queues__process_index() from queuing AUX area data for
  decoding when the --no-itrace option has been used (Adrian Hunter)

- Sync copy of kvm UAPI headers and x86's cpufeatures.h (Arnaldo Carvalho de Melo)

- Fix 'perf stat' CSV output format for non-supported counters (Ilya Pronin)

- Fix crash in 'perf record|perf report' pipe mode (Jiri Olsa)

- Fix annoying 'perf top' overwrite fallback message on older kernels (Kan Liang)

- Fix the usage on the 'perf kallsyms' man page (Sangwon Hong)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (2):
      perf auxtrace: Prevent decoding when --no-itrace
      perf tools: Fix trigger class trigger_on()

Arnaldo Carvalho de Melo (3):
      perf annotate browser: Be more robust when drawing jump arrows
      tools headers: Sync copy of kvm UAPI headers
      tools headers: Sync x86's cpufeatures.h

Ilya Pronin (1):
      perf stat: Fix CVS output format for non-supported counters

Jiri Olsa (1):
      perf record: Fix crash in pipe mode

Kan Liang (1):
      perf top: Fix annoying fallback message on older kernels

Sangwon Hong (1):
      perf kallsyms: Fix the usage on the man page

 tools/arch/x86/include/asm/cpufeatures.h   |  1 +
 tools/include/uapi/linux/kvm.h             |  2 ++
 tools/perf/Documentation/perf-kallsyms.txt |  2 +-
 tools/perf/builtin-record.c                |  9 +++++++++
 tools/perf/builtin-stat.c                  |  2 +-
 tools/perf/builtin-top.c                   |  2 +-
 tools/perf/perf.h                          |  1 +
 tools/perf/ui/browsers/annotate.c          | 25 +++++++++++++++++++++++++
 tools/perf/util/auxtrace.c                 | 15 +++++++++------
 tools/perf/util/record.c                   |  8 ++++++--
 tools/perf/util/trigger.h                  |  9 +++++----
 11 files changed, 61 insertions(+), 15 deletions(-)

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
   4 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-11)
   6 amazonlinux:2                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
   7 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   8 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   9 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  10 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  11 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  12 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  13 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
  14 debian:9                      : Ok   gcc (Debian 6.3.0-18) 6.3.0 20170516
  15 debian:experimental           : Ok   gcc (Debian 7.2.0-17) 7.2.1 20171205
  16 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  17 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  18 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 7.2.0-11) 7.2.0
  19 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  20 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  21 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  22 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  23 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  24 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  25 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  26 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  27 fedora:26                     : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
  28 fedora:27                     : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
  29 fedora:rawhide                : Ok   gcc (GCC) 7.2.1 20170829 (Red Hat 7.2.1-1)
  30 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 6.4.0-r1 p1.3) 6.4.0
  31 mageia:5                      : Ok   gcc (GCC) 4.9.2
  32 mageia:6                      : Ok   gcc (Mageia 5.4.0-5.mga6) 5.4.0
  33 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  34 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  35 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  36 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.3.0
  37 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  38 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  39 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  40 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  41 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.4-2017.05) 5.4.1 20170404
  42 ubuntu:15.04                  : Ok   gcc (Ubuntu 4.9.2-10ubuntu13) 4.9.2
  43 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.5) 5.4.0 20160609
  44 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  45 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  46 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  47 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1) 5.4.0 20160609
  48 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  49 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  50 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  51 ubuntu:17.04                  : Ok   gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
  52 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3) 7.2.0
  53 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.2.0-16ubuntu1) 7.2.0

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
                  make_debug_O: make DEBUG=1
                make_no_gtk2_O: make NO_GTK2=1
            make_install_bin_O: make install-bin
               make_no_slang_O: make NO_SLANG=1
                make_no_newt_O: make NO_NEWT=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                 make_perf_o_O: make perf.o
             make_util_map_o_O: make util/map.o
                   make_pure_O: make
         make_install_prefix_O: make install prefix=/tmp/krava
         make_with_clangllvm_O: make LIBCLANGLLVM=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
           make_no_libpython_O: make NO_LIBPYTHON=1
              make_no_libelf_O: make NO_LIBELF=1
                make_install_O: make install
                   make_help_O: make help
              make_clean_all_O: make clean all
            make_no_libaudit_O: make NO_LIBAUDIT=1
                    make_doc_O: make doc
                   make_tags_O: make tags
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
           make_no_backtrace_O: make NO_BACKTRACE=1
            make_no_demangle_O: make NO_DEMANGLE=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
             make_no_libnuma_O: make NO_LIBNUMA=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
             make_no_libperl_O: make NO_LIBPERL=1
              make_no_libbpf_O: make NO_LIBBPF=1
                 make_static_O: make LDFLAGS=-static
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
