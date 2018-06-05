Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbeFEJkB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:40:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751442AbeFEJj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:39:59 -0400
Date: Tue, 5 Jun 2018 11:39:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.106
Message-ID: <20180605093936.GA9520@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.106 kernel.

Not everyone who uses 4.9 needs to upgrade here, it's a big sync of the
objtool codebase to make future maintenance of 4.9.y easier over time,
that's all.  But of course, updating and verifying that nothing broke is
always appreciated :)

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                           |    2=20
 arch/x86/crypto/Makefile                           |    2=20
 arch/x86/crypto/sha1-mb/Makefile                   |    2=20
 arch/x86/crypto/sha256-mb/Makefile                 |    2=20
 arch/x86/include/asm/orc_types.h                   |  107 +
 arch/x86/include/asm/unwind_hints.h                |  103=20
 arch/x86/kernel/Makefile                           |    1=20
 arch/x86/kernel/acpi/Makefile                      |    2=20
 arch/x86/kernel/kprobes/opt.c                      |    9=20
 arch/x86/kernel/reboot.c                           |    2=20
 arch/x86/kernel/vmlinux.lds.S                      |    1=20
 arch/x86/kvm/svm.c                                 |    2=20
 arch/x86/kvm/vmx.c                                 |    3=20
 arch/x86/lib/msr-reg.S                             |    8=20
 arch/x86/net/Makefile                              |    2=20
 arch/x86/platform/efi/Makefile                     |    1=20
 arch/x86/power/Makefile                            |    2=20
 arch/x86/xen/Makefile                              |    3=20
 arch/x86/xen/enlighten.c                           |    5=20
 include/linux/compiler-gcc.h                       |   14=20
 kernel/kexec_core.c                                |    4=20
 tools/arch/arm/include/uapi/asm/kvm.h              |   13=20
 tools/arch/arm64/include/uapi/asm/kvm.h            |    6=20
 tools/arch/powerpc/include/uapi/asm/kvm.h          |    1=20
 tools/arch/s390/include/uapi/asm/kvm.h             |    5=20
 tools/arch/x86/include/asm/cpufeatures.h           |   44=20
 tools/arch/x86/include/asm/disabled-features.h     |    7=20
 tools/arch/x86/include/asm/required-features.h     |    3=20
 tools/include/asm-generic/bitops.h                 |    1=20
 tools/include/asm-generic/bitops/__ffz.h           |   12=20
 tools/include/asm-generic/bitops/find.h            |   28=20
 tools/include/linux/atomic.h                       |    6=20
 tools/include/linux/bitmap.h                       |   26=20
 tools/include/linux/bitops.h                       |    5=20
 tools/include/linux/bug.h                          |   10=20
 tools/include/linux/compiler-gcc.h                 |   21=20
 tools/include/linux/compiler.h                     |   23=20
 tools/include/linux/hashtable.h                    |    4=20
 tools/include/linux/kernel.h                       |    7=20
 tools/include/linux/log2.h                         |    3=20
 tools/include/linux/refcount.h                     |  151 +
 tools/include/linux/spinlock.h                     |    5=20
 tools/include/linux/types.h                        |    5=20
 tools/include/uapi/asm-generic/mman-common.h       |    5=20
 tools/include/uapi/linux/bpf.h                     |   51=20
 tools/include/uapi/linux/fcntl.h                   |   67=20
 tools/include/uapi/linux/stat.h                    |   45=20
 tools/lib/find_bit.c                               |   25=20
 tools/objtool/Build                                |    4=20
 tools/objtool/Documentation/stack-validation.txt   |  195 -
 tools/objtool/Makefile                             |   35=20
 tools/objtool/arch.h                               |   66=20
 tools/objtool/arch/x86/Build                       |   10=20
 tools/objtool/arch/x86/decode.c                    |  407 +++
 tools/objtool/arch/x86/include/asm/inat.h          |  234 ++
 tools/objtool/arch/x86/include/asm/inat_types.h    |   29=20
 tools/objtool/arch/x86/include/asm/insn.h          |  211 ++
 tools/objtool/arch/x86/include/asm/orc_types.h     |  107 +
 tools/objtool/arch/x86/insn/gen-insn-attr-x86.awk  |  392 ---
 tools/objtool/arch/x86/insn/inat.c                 |   97=20
 tools/objtool/arch/x86/insn/inat.h                 |  234 --
 tools/objtool/arch/x86/insn/inat_types.h           |   29=20
 tools/objtool/arch/x86/insn/insn.c                 |  606 -----
 tools/objtool/arch/x86/insn/insn.h                 |  211 --
 tools/objtool/arch/x86/insn/x86-opcode-map.txt     | 1063 ----------
 tools/objtool/arch/x86/lib/inat.c                  |   97=20
 tools/objtool/arch/x86/lib/insn.c                  |  606 +++++
 tools/objtool/arch/x86/lib/x86-opcode-map.txt      | 1063 ++++++++++
 tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk |  392 +++
 tools/objtool/builtin-check.c                      | 1297 ------------
 tools/objtool/builtin-orc.c                        |   68=20
 tools/objtool/builtin.h                            |    6=20
 tools/objtool/cfi.h                                |   55=20
 tools/objtool/check.c                              | 2209 ++++++++++++++++=
+++++
 tools/objtool/check.h                              |   82=20
 tools/objtool/elf.c                                |  326 ++-
 tools/objtool/elf.h                                |   23=20
 tools/objtool/objtool.c                            |   12=20
 tools/objtool/orc.h                                |   30=20
 tools/objtool/orc_dump.c                           |  213 ++
 tools/objtool/orc_gen.c                            |  221 ++
 tools/objtool/special.c                            |    6=20
 tools/objtool/sync-check.sh                        |   29=20
 tools/objtool/warn.h                               |   10=20
 tools/perf/MANIFEST                                |    6=20
 tools/perf/Makefile.perf                           |  144 -
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |    7=20
 tools/perf/check-headers.sh                        |   61=20
 tools/perf/util/util.h                             |    2=20
 89 files changed, 7431 insertions(+), 4320 deletions(-)

Arnaldo Carvalho de Melo (11):
      tools include: Introduce linux/compiler-gcc.h
      tools include: Adopt __compiletime_error
      tools include: Introduce atomic_cmpxchg_{relaxed,release}()
      tools include: Add UINT_MAX def to kernel.h
      tools include: Adopt kernel's refcount.h
      tools include uapi: Grab copies of stat.h and fcntl.h
      tools include: Introduce linux/bug.h, from the kernel sources
      tools include: Adopt __same_type() and __must_be_array() from the ker=
nel
      tools include: Move ARRAY_SIZE() to linux/kernel.h
      tools include: Drop ARRAY_SIZE() definition from linux/hashtable.h
      tools include: Include missing headers for fls() and types in linux/l=
og2.h

Greg Kroah-Hartman (5):
      objtool: sync up with the 4.14.47 version of objtool
      perf/tools: header file sync up
      objtool: header file sync-up
      x86/xen: Add unwind hint annotations to xen_setup_gdt
      Linux 4.9.106

Jiri Olsa (3):
      tools lib: Add for_each_clear_bit macro
      perf tools: Force fixdep compilation at the start of the build
      perf tools: Move headers check into bash script

Josh Poimboeuf (9):
      objtool: Improve detection of BUG() and other dead ends
      objtool: Move checking code to check.c
      objtool: Support GCC 8's cold subfunctions
      objtool: Support GCC 8 switch tables
      objtool: Detect RIP-relative switch table references
      objtool: Detect RIP-relative switch table references, part 2
      objtool: Fix "noreturn" detection for recursive sibling calls
      objtool, x86: Add several functions and files to the objtool whitelist
      objtool: Enclose contents of unreachable() macro in a block

Matthew Wilcox (2):
      tools: add more bitmap functions
      radix tree test suite: Remove types.h

Michael S. Tsirkin (1):
      tools: enable endian checks for all sparse builds


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsWWlQACgkQONu9yGCS
aT7V5g//cCbV5CIlX6hEUwmHsShKGBMIGHWPluEUJsCRWBH2lXPSjnqgXwXYcRQ3
zDTDTDhH+PUYxcOoCnLmYTsiSSBSQ9jdMa1aUvBNqHAKGYc17ZNGPAksUG4R7v/p
6hrtkggirPcLUtFvfkafywe0rP5hbvYJit7DWe6Tw38KxELLoQtlz91pLX/nH5lF
xiVQf30mhBYSiQCCmy5jcTMmb7clNfThDlgdUNuAtOZpcD2qUwo8Hz6u+wlUnuvQ
p7oqwreNhWnUljosMiLpXcMHY9W/o3glaLMr/+a7vkQRLqBEkljITJvzA23stVAq
NeJl2rQ6IY7lARMHPXuiRs0v2z10LIZOFUl5lxFYI9/NXI32X/Zu+DjnS2EjO2ni
62YWKJMAyEsrxh7hP3Zb2N+ihk6Njg7f19hcbLTU7KBcNjZe0QaIgAKWYYGBzbE3
KjxjCNTsYcBYEc88pED6X8U2q/ABHS+KlwDCMpQUhj8XRfm4OEu3QldbODA9wNSO
m7wc1Diz4MDpTeOymyVFXsPJgtHOexw0JvvUnLzmk2ytmWF+IsbWmiKdbHRuGS/O
7lBX6KgYPRJdHmPhGrZJcG9Rn0f/dIPcbbkqgfTU3/BQzeUibsJfkCC+4MtFeaQb
ysztU86p25glSp8LPYunm7Eb6znB1/l2wq+RHbX2YQShRIIPe6o=
=izPs
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
