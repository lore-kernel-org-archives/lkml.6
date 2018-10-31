Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AA5ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263EF2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnRPHjjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263EF2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbeKABoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:44:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbeKABoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:44:12 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF14520664;
        Wed, 31 Oct 2018 16:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541004323;
        bh=f4qdZYpip6Ye2zzxa4fFSrWYi32+Va2NUhxqiS2nnug=;
        h=From:To:Cc:Subject:Date:From;
        b=QnRPHjjbvFj1Uvl+Wv0LFkLFvD9f+MZByt8qqHMd6GTT3o5JyqZ1xP0udELOl2dZ/
         rAt8QPb4Mvw+7k+IgXPP9WMz4E2CKnURXInHygrteItoez0xSG+Bk5L7ivoHAgqJy1
         CR/FRMigyxSpEZapGmqIznNRNuv6kKYwDxHjkurE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Peterson <benjamin@python.org>,
        coresight@lists.linaro.org, David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Don Zickus <dzickus@redhat.com>, Eric Leblond <eric@regit.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@intel.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Souvik Banerjee <souvik1997@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/24] perf/urgent improvements and fixes
Date:   Wed, 31 Oct 2018 13:44:40 -0300
Message-Id: <20181031164508.4784-1-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Please consider pulling, next ones should be concentrating just
on bug fixes, been busy with some, so some were left in the queue,
flushing them now.

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 28fa741c27e6d57f6bf594ba3c444ce79e671e09:

  perf/core: Clean up inconsisent indentation (2018-10-30 09:51:58 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.20-20181031

for you to fetch changes up to 5d4f0edaa3ac4f1844ed7c64cd2bae6f1912bac5:

  perf intel-pt/bts: Calculate cpumode for synthesized samples (2018-10-31 12:56:26 -0300)

----------------------------------------------------------------
perf/urgent improvements and fixes:

- Fixes dealing with the removal of the fallback to looking up samples
  marked as userspace in the kernel maps, done recently:

  - For intel-pt, that was setting the synthesized header misc field
    as PERF_RECORD_MISC_USER, depending thus on the fallback to take
    place, now it sets as USER or KERNEL according to x86 specific
    knowledge. Also now it inserts the PERF_CONTEXT_{USER,KERNEL} into
    the PERF_SAMPLE_CALLCHAINs it synthesizes from hw traces (Adrian Hunter)

  - Similar fixes for the cs-etm ARM HW trace code, that used the Intel PT
    model as a starting point (Leo Yan)

  - For the "caller" callchain order, where the callchain returned by the
    kernel was simply reversed without taking into account the
    PERF_CONTEXT_{USER,KERNEL,etc} markers from where to define if an entry
    was for kernel or userspace, working just because the map lookup fallback
    was in place (David S. Miller)

- Allow for selecting if 'overwrite' mode should be used in 'perf top' and
  make the default for it not to be used. This is due to problems with the
  current implementation where the pausing used ends up making 'perf top'
  miss PERF_RECORD_{MMAP,FORK,EXEC,etc} events, which with short lifetime
  threads workloads leads quickly to many "unknown" maps (and thus symbols)
  to appear in the UI. Workloads with long thread lifetimes and with few
  metadata events can still use --overwrite to take advantage of the
  overwrite mode (Arnaldo Carvalho de Melo)

- Start 'perf top''s display thread earlier, so that the screen doesn't
  remain blank for too long at tool start (David S. Miller)

- Don't clone maps from parent when synthesizing forks, to avoid the inevitable
  flurry of overlapping maps as we process the synthesized MMAP2 events that get
  delivered shortly thereafter. (David S. Miller)

- Take pgoff into account when reporting elf to libdwfl, now the unwinding
  results are the same with elfutils's libdwfl and libunwind (Milian Wolff)

- Update lotsa kernel ABI headers (Arnaldo Carvalho de Melo)

- 'perf trace' syscall arg beautification improvements to allow for
  handling args such as mount's 'flags', where maks have to be ignored
  before considering what is left, that, if only zeroes, is suppressed
  like other args without such masks (Arnaldo Carvalho de Melo)

- Beautify mount's 'source' and 'flags' args (Arnaldo Carvalho de Melo)

- Generate mmap's flags bit constants from linux/mman.h and all the
  arch specific mman.h files, so that no changes in the main 'perf trace'
  source files is required when new flags get added (Arnaldo Carvalho de Melo)

- Consider syscall aliases, so that 'perf trace -e umount' works and we don't
  have to use 'umount2' (that works as well, just not required) (Arnaldo Carvalho de Melo)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (2):
      perf intel-pt: Insert callchain context into synthesized callchains
      perf intel-pt/bts: Calculate cpumode for synthesized samples

Arnaldo Carvalho de Melo (21):
      tools include uapi: Grab a copy of linux/fs.h
      perf beauty: Add a generator for MS_ mount/umount's flag constants
      perf beauty: Switch from GPL v2.0 to LGPL v2.1
      perf beauty: Introduce strarray__scnprintf_flags()
      perf trace beauty: Allow syscalls to mask an argument before considering it
      perf trace beauty: Beautify mount/umount's 'flags' argument
      perf trace: Consider syscall aliases too
      perf trace: Beautify the umount's 'name' argument
      perf trace: Beautify mount's first pathname arg
      perf top: Allow disabling the overwrite mode
      perf top: Do not use overwrite mode by default
      tools include uapi: Update linux/fs.h copy
      tools arch uapi: Update asm-generic/unistd.h and arm64 unistd.h copies
      tools include uapi: Update asound.h copy
      perf beauty: Add a generator for MAP_ mmap's flag constants
      perf beauty: Wire up the mmap flags table generator to the Makefile
      perf trace beauty: Use the mmap flags table generated from headers
      tools include uapi: Update linux/mmap.h copy
      tools headers: Sync the various kvm.h header copies
      tools headers uapi: Update linux/netlink.h header copy
      tools headers uapi: Update linux/if_link.h header copy

David Miller (2):
      perf top: Start display thread earlier
      perf tools: Don't clone maps from parent when synthesizing forks

David S. Miller (1):
      perf callchain: Honour the ordering of PERF_CONTEXT_{USER,KERNEL,etc}

Leo Yan (1):
      perf cs-etm: Correct CPU mode for samples

Milian Wolff (1):
      perf unwind: Take pgoff into account when reporting elf to libdwfl

 include/uapi/linux/perf_event.h                    |   2 +
 tools/arch/arm64/include/uapi/asm/unistd.h         |   1 +
 tools/arch/powerpc/include/uapi/asm/kvm.h          |   1 +
 tools/arch/s390/include/uapi/asm/kvm.h             |   2 +
 tools/arch/x86/include/uapi/asm/kvm.h              |   6 +-
 tools/include/uapi/asm-generic/unistd.h            |   2 +
 tools/include/uapi/linux/fs.h                      | 393 +++++++++++++++++++++
 tools/include/uapi/linux/if_link.h                 |   1 +
 tools/include/uapi/linux/kvm.h                     |  21 +-
 tools/include/uapi/linux/mman.h                    |   2 +
 tools/include/uapi/linux/netlink.h                 |   1 +
 tools/include/uapi/linux/perf_event.h              |   2 +
 tools/include/uapi/sound/asound.h                  |   2 +-
 tools/perf/Documentation/perf-top.txt              |  10 +
 tools/perf/Makefile.perf                           |  19 +
 tools/perf/builtin-top.c                           |  21 +-
 tools/perf/builtin-trace.c                         |  48 ++-
 tools/perf/check-headers.sh                        |   1 +
 tools/perf/trace/beauty/Build                      |   1 +
 tools/perf/trace/beauty/beauty.h                   |   7 +
 tools/perf/trace/beauty/clone.c                    |   3 +-
 tools/perf/trace/beauty/drm_ioctl.sh               |   1 +
 tools/perf/trace/beauty/eventfd.c                  |   2 +-
 tools/perf/trace/beauty/fcntl.c                    |   3 +-
 tools/perf/trace/beauty/flock.c                    |   2 +-
 tools/perf/trace/beauty/futex_op.c                 |   2 +-
 tools/perf/trace/beauty/futex_val3.c               |   2 +-
 tools/perf/trace/beauty/ioctl.c                    |   3 +-
 tools/perf/trace/beauty/kcmp.c                     |   3 +-
 tools/perf/trace/beauty/kcmp_type.sh               |   1 +
 tools/perf/trace/beauty/kvm_ioctl.sh               |   1 +
 tools/perf/trace/beauty/madvise_behavior.sh        |   1 +
 tools/perf/trace/beauty/mmap.c                     |  50 +--
 tools/perf/trace/beauty/mmap_flags.sh              |  32 ++
 tools/perf/trace/beauty/mode_t.c                   |   2 +-
 tools/perf/trace/beauty/mount_flags.c              |  43 +++
 tools/perf/trace/beauty/mount_flags.sh             |  15 +
 tools/perf/trace/beauty/msg_flags.c                |   2 +-
 tools/perf/trace/beauty/open_flags.c               |   2 +-
 tools/perf/trace/beauty/perf_event_open.c          |   2 +-
 tools/perf/trace/beauty/perf_ioctl.sh              |   1 +
 tools/perf/trace/beauty/pid.c                      |   3 +-
 tools/perf/trace/beauty/pkey_alloc.c               |  30 +-
 .../perf/trace/beauty/pkey_alloc_access_rights.sh  |   1 +
 tools/perf/trace/beauty/prctl.c                    |   3 +-
 tools/perf/trace/beauty/prctl_option.sh            |   1 +
 tools/perf/trace/beauty/sched_policy.c             |   2 +-
 tools/perf/trace/beauty/seccomp.c                  |   2 +-
 tools/perf/trace/beauty/signum.c                   |   2 +-
 tools/perf/trace/beauty/sndrv_ctl_ioctl.sh         |   1 +
 tools/perf/trace/beauty/sndrv_pcm_ioctl.sh         |   1 +
 tools/perf/trace/beauty/sockaddr.c                 |   2 +-
 tools/perf/trace/beauty/socket.c                   |   2 +-
 tools/perf/trace/beauty/socket_ipproto.sh          |   1 +
 tools/perf/trace/beauty/socket_type.c              |   2 +-
 tools/perf/trace/beauty/statx.c                    |   3 +-
 tools/perf/trace/beauty/vhost_virtio_ioctl.sh      |   1 +
 tools/perf/trace/beauty/waitid_options.c           |   2 +-
 tools/perf/util/cs-etm.c                           |  39 +-
 tools/perf/util/event.c                            |   1 +
 tools/perf/util/intel-bts.c                        |  17 +-
 tools/perf/util/intel-pt.c                         |  28 +-
 tools/perf/util/machine.c                          |  54 ++-
 tools/perf/util/thread-stack.c                     |  44 ++-
 tools/perf/util/thread-stack.h                     |   2 +-
 tools/perf/util/thread.c                           |  13 +-
 tools/perf/util/thread.h                           |   2 +-
 tools/perf/util/unwind-libdw.c                     |   4 +-
 68 files changed, 837 insertions(+), 142 deletions(-)
 create mode 100644 tools/include/uapi/linux/fs.h
 create mode 100755 tools/perf/trace/beauty/mmap_flags.sh
 create mode 100644 tools/perf/trace/beauty/mount_flags.c
 create mode 100755 tools/perf/trace/beauty/mount_flags.sh

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

The failures are minor and will be fixed soon.

  50     6.21 ubuntu:16.04-x-arm64          : FAIL aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609

This one is related to smp_load_{acquire,release} expansions in this specific
gcc version, reported to Daniel Borkmann

  60     3.70 ubuntu:18.04-x-m68k           : FAIL m68k-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  64     3.48 ubuntu:18.04-x-riscv64        : FAIL riscv64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0

These two need mman.h files added to its directories in tools/arch/, will fix later.

  66     3.84 ubuntu:18.04-x-sh4            : FAIL sh4-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0

Needs to normalize sh4 -> sh so that it finds
tools/arch/sh/include/uapi/asm/mman.h.

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
  14 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 8.2.1 20180502
  15 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  16 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
  17 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  18 debian:experimental           : Ok   gcc (Debian 8.2.0-8) 8.2.0
  19 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.2.0-7) 8.2.0
  20 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.2.0-7) 8.2.0
  21 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.1.0-12) 8.1.0
  22 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.2.0-7) 8.2.0
  23 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  24 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  25 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  26 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  27 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  28 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  29 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  30 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  31 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
  32 fedora:28                     : Ok   gcc (GCC) 8.1.1 20180712 (Red Hat 8.1.1-5)
  33 fedora:29                     : Ok   gcc (GCC) 8.2.1 20181011 (Red Hat 8.2.1-4)
  34 fedora:rawhide                : Ok   gcc (GCC) 8.2.1 20180905 (Red Hat 8.2.1-3)
  35 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 7.3.0-r3 p1.4) 7.3.0
  36 mageia:5                      : Ok   gcc (GCC) 4.9.2
  37 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  38 opensuse:13.2                 : Ok   gcc (SUSE Linux) 4.8.3 20140627 [gcc-4_8-branch revision 212064]
  39 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  40 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  41 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  42 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.3.1 20180323 [gcc-7-branch revision 258812]
  43 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  44 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28.0.1)
  45 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  46 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  47 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
  48 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
  49 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50 ubuntu:16.04-x-arm64          : FAIL aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  52 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  53 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  54 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  55 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  56 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  57 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  58 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
  59 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
  60 ubuntu:18.04-x-m68k           : FAIL m68k-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  61 ubuntu:17.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  62 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  63 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  64 ubuntu:18.04-x-riscv64        : FAIL riscv64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  65 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  66 ubuntu:18.04-x-sh4            : FAIL sh4-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  67 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  68 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.2.0-7ubuntu1) 8.2.0

  # uname -a
  Linux seventh 4.19.0-rc8-00014-gc0cff31be705 #1 SMP Wed Oct 17 09:00:22 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  5d4f0edaa3ac perf intel-pt/bts: Calculate cpumode for synthesized samples
  # perf version --build-options
  perf version 4.19.g5d4f0e
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
  65: Check open filename arg using perf trace + vfs_getname: Ok
  66: Use vfs_getname probe to get syscall args filenames   : Ok
  67: Add vfs_getname probe to get syscall args filenames   : Ok

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
         make_with_clangllvm_O: make LIBCLANGLLVM=1
             make_no_libperl_O: make NO_LIBPERL=1
         make_install_prefix_O: make install prefix=/tmp/krava
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
           make_no_libpython_O: make NO_LIBPYTHON=1
                 make_perf_o_O: make perf.o
                 make_static_O: make LDFLAGS=-static
                make_no_newt_O: make NO_NEWT=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
             make_util_map_o_O: make util/map.o
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
              make_no_libelf_O: make NO_LIBELF=1
           make_no_backtrace_O: make NO_BACKTRACE=1
              make_no_libbpf_O: make NO_LIBBPF=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                make_no_gtk2_O: make NO_GTK2=1
            make_install_bin_O: make install-bin
            make_no_demangle_O: make NO_DEMANGLE=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
             make_no_libnuma_O: make NO_LIBNUMA=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                   make_pure_O: make
                   make_tags_O: make tags
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                make_install_O: make install
              make_clean_all_O: make clean all
               make_no_slang_O: make NO_SLANG=1
                    make_doc_O: make doc
                  make_debug_O: make DEBUG=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                   make_help_O: make help
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
