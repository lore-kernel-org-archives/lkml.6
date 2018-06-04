Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeFDG6z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751520AbeFDG6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:58:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/29] 4.9.106-stable review
Date: Mon,  4 Jun 2018 08:57:56 +0200
Message-Id: <20180604065802.157744637@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.106-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.106-rc1
X-KernelTest-Deadline: 2018-06-06T06:58+00:00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.106 release.
There are 29 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Jun  6 06:57:52 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.106-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.106-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    x86/xen: Add unwind hint annotations to xen_setup_gdt

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    objtool: header file sync-up

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    perf/tools: header file sync up

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool, x86: Add several functions and files to the objtool whitelist

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Fix "noreturn" detection for recursive sibling calls

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Detect RIP-relative switch table references, part 2

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Detect RIP-relative switch table references

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Support GCC 8 switch tables

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Support GCC 8's cold subfunctions

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    objtool: sync up with the 4.14.47 version of objtool

Arnaldo Carvalho de Melo <acme@redhat.com>
    tools include: Include missing headers for fls() and types in linux/log2.h

Arnaldo Carvalho de Melo <acme@redhat.com>
    tools include: Drop ARRAY_SIZE() definition from linux/hashtable.h

Arnaldo Carvalho de Melo <acme@redhat.com>
    tools include: Move ARRAY_SIZE() to linux/kernel.h

Arnaldo Carvalho de Melo <acme@redhat.com>
    tools include: Adopt __same_type() and __must_be_array() from the kernel

Arnaldo Carvalho de Melo <acme@redhat.com>
    tools include: Introduce linux/bug.h, from the kernel sources

Arnaldo Carvalho de Melo <acme@redhat.com>
    tools include uapi: Grab copies of stat.h and fcntl.h

Jiri Olsa <jolsa@kernel.org>
    perf tools: Move headers check into bash script

Jiri Olsa <jolsa@kernel.org>
    perf tools: Force fixdep compilation at the start of the build

Arnaldo Carvalho de Melo <acme@redhat.com>
    tools include: Adopt kernel's refcount.h

Arnaldo Carvalho de Melo <acme@redhat.com>
    tools include: Add UINT_MAX def to kernel.h

Arnaldo Carvalho de Melo <acme@redhat.com>
    tools include: Introduce atomic_cmpxchg_{relaxed,release}()

Arnaldo Carvalho de Melo <acme@redhat.com>
    tools include: Adopt __compiletime_error

Matthew Wilcox <mawilcox@microsoft.com>
    radix tree test suite: Remove types.h

Arnaldo Carvalho de Melo <acme@redhat.com>
    tools include: Introduce linux/compiler-gcc.h

Michael S. Tsirkin <mst@redhat.com>
    tools: enable endian checks for all sparse builds

Matthew Wilcox <willy@linux.intel.com>
    tools: add more bitmap functions

Jiri Olsa <jolsa@kernel.org>
    tools lib: Add for_each_clear_bit macro

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Move checking code to check.c

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Improve detection of BUG() and other dead ends


-------------

Diffstat:

 Makefile                                           |    4 +-
 arch/x86/crypto/Makefile                           |    2 +
 arch/x86/crypto/sha1-mb/Makefile                   |    2 +
 arch/x86/crypto/sha256-mb/Makefile                 |    2 +
 arch/x86/include/asm/orc_types.h                   |  107 +
 arch/x86/include/asm/unwind_hints.h                |  103 +
 arch/x86/kernel/Makefile                           |    1 +
 arch/x86/kernel/acpi/Makefile                      |    2 +
 arch/x86/kernel/kprobes/opt.c                      |    9 +-
 arch/x86/kernel/reboot.c                           |    2 +
 arch/x86/kernel/vmlinux.lds.S                      |    1 +
 arch/x86/kvm/svm.c                                 |    2 +
 arch/x86/kvm/vmx.c                                 |    3 +
 arch/x86/lib/msr-reg.S                             |    8 +-
 arch/x86/net/Makefile                              |    2 +
 arch/x86/platform/efi/Makefile                     |    1 +
 arch/x86/power/Makefile                            |    2 +
 arch/x86/xen/Makefile                              |    3 +
 arch/x86/xen/enlighten.c                           |    5 +-
 include/linux/compiler-gcc.h                       |   13 +-
 kernel/kexec_core.c                                |    4 +-
 tools/arch/arm/include/uapi/asm/kvm.h              |   13 +
 tools/arch/arm64/include/uapi/asm/kvm.h            |    6 +
 tools/arch/powerpc/include/uapi/asm/kvm.h          |    1 +
 tools/arch/s390/include/uapi/asm/kvm.h             |    5 +-
 tools/arch/x86/include/asm/cpufeatures.h           |   44 +-
 tools/arch/x86/include/asm/disabled-features.h     |    7 +-
 tools/arch/x86/include/asm/required-features.h     |    3 +-
 tools/include/asm-generic/bitops.h                 |    1 +
 tools/include/asm-generic/bitops/__ffz.h           |   12 +
 tools/include/asm-generic/bitops/find.h            |   28 +
 tools/include/linux/atomic.h                       |    6 +
 tools/include/linux/bitmap.h                       |   26 +
 tools/include/linux/bitops.h                       |    5 +
 tools/include/linux/bug.h                          |   10 +
 tools/include/linux/compiler-gcc.h                 |   21 +
 tools/include/linux/compiler.h                     |   23 +-
 tools/include/linux/hashtable.h                    |    4 -
 tools/include/linux/kernel.h                       |    7 +
 tools/include/linux/log2.h                         |    3 +
 tools/include/linux/refcount.h                     |  151 ++
 tools/include/linux/spinlock.h                     |    5 +
 tools/include/linux/types.h                        |    5 +-
 tools/include/uapi/asm-generic/mman-common.h       |    5 +
 tools/include/uapi/linux/bpf.h                     |   51 +
 tools/include/uapi/linux/fcntl.h                   |   67 +
 tools/include/uapi/linux/stat.h                    |   45 +
 tools/lib/find_bit.c                               |   25 +
 tools/objtool/Build                                |    4 +
 tools/objtool/Documentation/stack-validation.txt   |  195 +-
 tools/objtool/Makefile                             |   35 +-
 tools/objtool/arch.h                               |   66 +-
 tools/objtool/arch/x86/Build                       |   10 +-
 tools/objtool/arch/x86/decode.c                    |  407 +++-
 .../objtool/arch/x86/{insn => include/asm}/inat.h  |    2 +-
 .../arch/x86/{insn => include/asm}/inat_types.h    |    0
 .../objtool/arch/x86/{insn => include/asm}/insn.h  |    2 +-
 tools/objtool/arch/x86/include/asm/orc_types.h     |  107 +
 tools/objtool/arch/x86/{insn => lib}/inat.c        |    2 +-
 tools/objtool/arch/x86/{insn => lib}/insn.c        |    4 +-
 .../arch/x86/{insn => lib}/x86-opcode-map.txt      |    0
 .../arch/x86/{insn => tools}/gen-insn-attr-x86.awk |    0
 tools/objtool/builtin-check.c                      | 1297 +-----------
 tools/objtool/builtin-orc.c                        |   68 +
 tools/objtool/builtin.h                            |    6 +
 tools/objtool/cfi.h                                |   55 +
 tools/objtool/check.c                              | 2209 ++++++++++++++++++++
 tools/objtool/check.h                              |   82 +
 tools/objtool/elf.c                                |  326 ++-
 tools/objtool/elf.h                                |   23 +-
 tools/objtool/objtool.c                            |   12 +-
 tools/objtool/orc.h                                |   30 +
 tools/objtool/orc_dump.c                           |  213 ++
 tools/objtool/orc_gen.c                            |  221 ++
 tools/objtool/special.c                            |    6 +-
 tools/objtool/sync-check.sh                        |   29 +
 tools/objtool/warn.h                               |   10 +
 tools/perf/MANIFEST                                |    6 +
 tools/perf/Makefile.perf                           |  144 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |    7 +-
 tools/perf/check-headers.sh                        |   61 +
 tools/perf/util/util.h                             |    2 -
 82 files changed, 4804 insertions(+), 1694 deletions(-)
