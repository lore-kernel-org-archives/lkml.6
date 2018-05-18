Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3687130-1526635053-2-12715234323824967685
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526635052; b=N20iy667xQiIrmQN4l7od0n+bm6+tgprJpRdah7IyQgH26w7fm
    KrqIp99LPysj74HDb21Lvk/OUvN72/nNF7YgERgxbNZlM4cGv3UUUh7CG9Pn+9R2
    b0cJ0NMWo/Bv8cCLo/n4sj9vw0HJSXI9GCA0tWGemGIrEYG87i5LTmjQjDWD/X1f
    IbZg7HUhMRpy8gIWrKr/pPsLNVrFbrAj5eEXC74nOsiVrKTKGXnhOJnFQzds3dfR
    UuFC0JSlq4oMTtRgoyoqzG+qGkLWEuTvQ1Q0vRnmb6a3tQkIrvRXu+mZvk0jR1g/
    P0PgTjSAHBy39CqnQR6VKzn6/IcYnzWMYexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526635052; bh=KH/chlDuFyAsUunyyJzF2MlH6RtRk6
    wIwHqGXjW8Y3c=; b=SgMP+LBP8XxA8akNkDT3loRdf+yGUu0VX41w715jUnYH6D
    Ykl+wdx28hYHeMFddOHVApl/kj2U/jqff37Rxye4KVhRWIze8Jn4mIVcBbDyHAKK
    XroT0JmdFzMPcevzob8gr7NUzWdl0fGsVN5raFgG1oKyrr5aF4w2bbRfYwWgDSsB
    58SLnjZ5QauIBoElnxU6E3jTGLDjlYSrhg8wgTyPhcVNnaVWFwG+YwVaHO6corxY
    gr5e4F7A0C3EqQX63ifxsM1YeEDIx69CtQKiLw/UkpXsLh/1F93QHP5NysWyjCJU
    92jnCpTMT/yZk7BT3FczlXnYNJ6KugG/CPr+/3QQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHxwGyARXwLNVgqlEtV9rv6FiyCH1cZtqMCmFix/Q87QzOBVlWiUb76VUTqw7K0nD+OQ2jmiDKbCqQlXp8/2HUeDoz9g2GgLzoC3QmoXRiJhMaURoUje
    rnMaALx7DbPvdJPsoHXRUCuAtvYbrtGGGOsYBa1u33aU0zTdqMltWxg0Ekcuk2BgR7fA2cYSiacYcsTxlbUMKCf4IGysUChCGpNsAod6rc5Okcbmw+lNBq7x
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=D19gQVrFAAAA:8
    a=AVp4oGAeJcCDcb0J010A:9 a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753092AbeERJR2 (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 05:17:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:45325 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753056AbeERJRZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 May 2018 05:17:25 -0400
From: Jiri Slaby <jslaby@suse.cz>
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v6 00/28] New macros for assembler symbols
Date: Fri, 18 May 2018 11:16:53 +0200
Message-Id: <20180518091721.7604-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.16.3
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This series introduces new macros for assembly as was discussed [1].
The macros are introduced in the first patch of the series. The rest
of patches start using these new macros in x86, converting *all* uses
of the old macros to the new ones throughout the last patch. With
every last user of some old macro, the macro is immediatelly made
forbidden for x86.

When this settles down, conversion of other architectures can be done
too.

For introduction, documentation, use and examples, please see
Documentation/asm-annotations.rst from the first patch of the series.

[1] https://lkml.org/lkml/2017/3/1/742


Jiri Slaby (28):
  linkage: new macros for assembler symbols
  x86/asm/suspend: drop ENTRY from local data
  x86/asm/suspend: use SYM_DATA for data
  x86/asm: annotate relocate_kernel
  x86/asm/entry: annotate THUNKs
  x86/asm: annotate local pseudo-functions
  x86/asm/crypto: annotate local functions
  x86/boot/compressed: annotate local functions
  x86/asm: annotate aliases
  x86/asm/entry: annotate interrupt symbols properly
  x86/asm/head: annotate data appropriatelly
  x86/boot/compressed: annotate data appropriatelly
  um: annotate data appropriatelly
  xen/pvh: annotate data appropriatelly
  x86/asm/purgatory: start using annotations
  x86/asm: do not annotate functions by GLOBAL
  x86/asm: use SYM_INNER_LABEL instead of GLOBAL
  x86/asm/realmode: use SYM_DATA_* instead of GLOBAL
  x86/asm: kill the last GLOBAL user and remove the macro
  x86/asm: make some functions local
  x86/asm/ftrace: mark function_hook as function
  x86_64/asm: add ENDs to some functions and relabel with SYM_CODE_*
  x86_64/asm: change all ENTRY+END to SYM_CODE_*
  x86_64/asm: change all ENTRY+ENDPROC to SYM_FUNC_*
  x86_32/asm: add ENDs to some functions and relabel with SYM_CODE_*
  x86_32/asm: change all ENTRY+END to SYM_CODE_*
  x86_32/asm: change all ENTRY+ENDPROC to SYM_FUNC_*
  x86/asm: replace WEAK uses by SYM_INNER_LABEL

 Documentation/asm-annotations.rst                  | 217 ++++++++++++++++++
 arch/x86/boot/compressed/efi_stub_32.S             |   4 +-
 arch/x86/boot/compressed/efi_thunk_64.S            |  33 +--
 arch/x86/boot/compressed/head_32.S                 |  15 +-
 arch/x86/boot/compressed/head_64.S                 |  60 ++---
 arch/x86/boot/compressed/mem_encrypt.S             |  14 +-
 arch/x86/boot/copy.S                               |  16 +-
 arch/x86/boot/pmjump.S                             |   8 +-
 arch/x86/crypto/aes-i586-asm_32.S                  |   8 +-
 arch/x86/crypto/aes-x86_64-asm_64.S                |   4 +-
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S            |  12 +-
 arch/x86/crypto/aesni-intel_asm.S                  | 114 +++++-----
 arch/x86/crypto/aesni-intel_avx-x86_64.S           |  24 +-
 arch/x86/crypto/blowfish-x86_64-asm_64.S           |  16 +-
 arch/x86/crypto/camellia-aesni-avx-asm_64.S        |  44 ++--
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S       |  44 ++--
 arch/x86/crypto/camellia-x86_64-asm_64.S           |  16 +-
 arch/x86/crypto/cast5-avx-x86_64-asm_64.S          |  24 +-
 arch/x86/crypto/cast6-avx-x86_64-asm_64.S          |  32 +--
 arch/x86/crypto/chacha20-avx2-x86_64.S             |   4 +-
 arch/x86/crypto/chacha20-ssse3-x86_64.S            |   8 +-
 arch/x86/crypto/crc32-pclmul_asm.S                 |   4 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S          |   4 +-
 arch/x86/crypto/crct10dif-pcl-asm_64.S             |   4 +-
 arch/x86/crypto/des3_ede-asm_64.S                  |   8 +-
 arch/x86/crypto/ghash-clmulni-intel_asm.S          |  12 +-
 arch/x86/crypto/poly1305-avx2-x86_64.S             |   4 +-
 arch/x86/crypto/poly1305-sse2-x86_64.S             |   8 +-
 arch/x86/crypto/salsa20-i586-asm_32.S              |   4 +-
 arch/x86/crypto/salsa20-x86_64-asm_64.S            |   4 +-
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S        |  32 +--
 arch/x86/crypto/serpent-avx2-asm_64.S              |  32 +--
 arch/x86/crypto/serpent-sse2-i586-asm_32.S         |   8 +-
 arch/x86/crypto/serpent-sse2-x86_64-asm_64.S       |   8 +-
 arch/x86/crypto/sha1-mb/sha1_mb_mgr_flush_avx2.S   |   8 +-
 arch/x86/crypto/sha1-mb/sha1_mb_mgr_submit_avx2.S  |   4 +-
 arch/x86/crypto/sha1-mb/sha1_x8_avx2.S             |   4 +-
 arch/x86/crypto/sha1_avx2_x86_64_asm.S             |   4 +-
 arch/x86/crypto/sha1_ni_asm.S                      |   4 +-
 arch/x86/crypto/sha1_ssse3_asm.S                   |   4 +-
 arch/x86/crypto/sha256-avx-asm.S                   |   4 +-
 arch/x86/crypto/sha256-avx2-asm.S                  |   4 +-
 .../crypto/sha256-mb/sha256_mb_mgr_flush_avx2.S    |   8 +-
 .../crypto/sha256-mb/sha256_mb_mgr_submit_avx2.S   |   4 +-
 arch/x86/crypto/sha256-mb/sha256_x8_avx2.S         |   4 +-
 arch/x86/crypto/sha256-ssse3-asm.S                 |   4 +-
 arch/x86/crypto/sha256_ni_asm.S                    |   4 +-
 arch/x86/crypto/sha512-avx-asm.S                   |   4 +-
 arch/x86/crypto/sha512-avx2-asm.S                  |   4 +-
 .../crypto/sha512-mb/sha512_mb_mgr_flush_avx2.S    |   8 +-
 .../crypto/sha512-mb/sha512_mb_mgr_submit_avx2.S   |   4 +-
 arch/x86/crypto/sha512-mb/sha512_x4_avx2.S         |   4 +-
 arch/x86/crypto/sha512-ssse3-asm.S                 |   4 +-
 arch/x86/crypto/twofish-avx-x86_64-asm_64.S        |  32 +--
 arch/x86/crypto/twofish-i586-asm_32.S              |   8 +-
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S       |   8 +-
 arch/x86/crypto/twofish-x86_64-asm_64.S            |   8 +-
 arch/x86/entry/entry_32.S                          | 155 ++++++-------
 arch/x86/entry/entry_64.S                          | 107 ++++-----
 arch/x86/entry/entry_64_compat.S                   |  16 +-
 arch/x86/entry/thunk_32.S                          |   4 +-
 arch/x86/entry/thunk_64.S                          |   8 +-
 arch/x86/entry/vdso/vdso32/system_call.S           |   2 +-
 arch/x86/include/asm/linkage.h                     |   4 -
 arch/x86/kernel/acpi/wakeup_32.S                   |  11 +-
 arch/x86/kernel/acpi/wakeup_64.S                   |  25 ++-
 arch/x86/kernel/ftrace_32.S                        |  23 +-
 arch/x86/kernel/ftrace_64.S                        |  42 ++--
 arch/x86/kernel/head_32.S                          |  60 ++---
 arch/x86/kernel/head_64.S                          | 106 ++++-----
 arch/x86/kernel/relocate_kernel_32.S               |  13 +-
 arch/x86/kernel/relocate_kernel_64.S               |  13 +-
 arch/x86/kernel/verify_cpu.S                       |   4 +-
 arch/x86/lib/atomic64_386_32.S                     |   4 +-
 arch/x86/lib/atomic64_cx8_32.S                     |  32 +--
 arch/x86/lib/checksum_32.S                         |  16 +-
 arch/x86/lib/clear_page_64.S                       |  12 +-
 arch/x86/lib/cmpxchg16b_emu.S                      |   4 +-
 arch/x86/lib/cmpxchg8b_emu.S                       |   4 +-
 arch/x86/lib/copy_page_64.S                        |   8 +-
 arch/x86/lib/copy_user_64.S                        |  16 +-
 arch/x86/lib/csum-copy_64.S                        |   4 +-
 arch/x86/lib/getuser.S                             |  24 +-
 arch/x86/lib/hweight.S                             |   8 +-
 arch/x86/lib/iomap_copy_64.S                       |   4 +-
 arch/x86/lib/memcpy_64.S                           |  20 +-
 arch/x86/lib/memmove_64.S                          |   8 +-
 arch/x86/lib/memset_64.S                           |  16 +-
 arch/x86/lib/msr-reg.S                             |   8 +-
 arch/x86/lib/putuser.S                             |  20 +-
 arch/x86/lib/retpoline.S                           |   4 +-
 arch/x86/lib/rwsem.S                               |  24 +-
 arch/x86/math-emu/div_Xsig.S                       |   4 +-
 arch/x86/math-emu/div_small.S                      |   4 +-
 arch/x86/math-emu/mul_Xsig.S                       |  12 +-
 arch/x86/math-emu/polynom_Xsig.S                   |   4 +-
 arch/x86/math-emu/reg_norm.S                       |   8 +-
 arch/x86/math-emu/reg_round.S                      |   4 +-
 arch/x86/math-emu/reg_u_add.S                      |   4 +-
 arch/x86/math-emu/reg_u_div.S                      |   4 +-
 arch/x86/math-emu/reg_u_mul.S                      |   4 +-
 arch/x86/math-emu/reg_u_sub.S                      |   4 +-
 arch/x86/math-emu/round_Xsig.S                     |   8 +-
 arch/x86/math-emu/shr_Xsig.S                       |   4 +-
 arch/x86/math-emu/wm_shrx.S                        |   8 +-
 arch/x86/math-emu/wm_sqrt.S                        |   4 +-
 arch/x86/mm/mem_encrypt_boot.S                     |   8 +-
 arch/x86/platform/efi/efi_stub_32.S                |   4 +-
 arch/x86/platform/efi/efi_stub_64.S                |   4 +-
 arch/x86/platform/efi/efi_thunk_64.S               |  16 +-
 arch/x86/platform/olpc/xo1-wakeup.S                |   3 +-
 arch/x86/power/hibernate_asm_32.S                  |   6 +-
 arch/x86/power/hibernate_asm_64.S                  |  14 +-
 arch/x86/purgatory/entry64.S                       |  21 +-
 arch/x86/purgatory/setup-x86_64.S                  |  14 +-
 arch/x86/purgatory/stack.S                         |   7 +-
 arch/x86/realmode/rm/header.S                      |   8 +-
 arch/x86/realmode/rm/reboot.S                      |  13 +-
 arch/x86/realmode/rm/stack.S                       |  14 +-
 arch/x86/realmode/rm/trampoline_32.S               |  16 +-
 arch/x86/realmode/rm/trampoline_64.S               |  29 +--
 arch/x86/realmode/rm/trampoline_common.S           |   4 +-
 arch/x86/realmode/rm/wakeup_asm.S                  |  15 +-
 arch/x86/realmode/rmpiggy.S                        |  10 +-
 arch/x86/um/vdso/vdso.S                            |   6 +-
 arch/x86/xen/xen-asm.S                             |  20 +-
 arch/x86/xen/xen-asm_32.S                          |   7 +-
 arch/x86/xen/xen-asm_64.S                          |  34 +--
 arch/x86/xen/xen-head.S                            |   8 +-
 arch/x86/xen/xen-pvh.S                             |  15 +-
 include/linux/linkage.h                            | 247 ++++++++++++++++++++-
 131 files changed, 1459 insertions(+), 982 deletions(-)
 create mode 100644 Documentation/asm-annotations.rst

-- 
2.16.3
