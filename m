Return-Path: <ard.biesheuvel@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518435489; cv=none;
        d=google.com; s=arc-20160816;
        b=TGNE40jqu/xdLAjO0P7UmCR9bXdTp8fPNkhiWx2L2NIfAIh+vaaPXCUYYyP3+Yn9Pa
         9E5CLgy5VcSVOdFttIqZVLcBa0u7AlnzCqqkuIoQF4aglId6/zohSV3+KG6zqCzv6a2h
         2bZCL2XaJTRoE23yGb0s1L+Q8Nh2xFyfMo3PcmoakeN/Je10XlH6TWw81GbCNW4Sjj4e
         aet0XTxm3T5THoFodlUg8H87D34y2DW+QdVosslEbZMz456FA6OLIdQbmh56wCy5Mhvt
         +T+tj/uLq1I/YNQWUk7TDC2rikKC2PstOLPr7/XCpbQH/tVol/Cp8vjEOfbmAan/mifN
         ZJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=GDB7csBc3xX53D0EeUXgz8lURyEt5MY6SiP8isgs2Hk=;
        b=wAEsPGQx59ZlpZ4ncC55IO/afuTmOYYeL8BcElaBLzseltpLETcW8iRqGi/UDTqzR3
         it6ygRIkK5GSY5ZEci1qLd6p7GlZAahfSDfIvxCMqD5W4HyteswVrkKEMybkS7LMqbkS
         tRU+AbkcZm8lAqKrHtIN7O/hvv1JrldAf6jstYi0gq/VoSIFB3D/qyINsXR28RRB5Iae
         g/Y0bKpkFqP3DyAU/6Fi1yTsmO9padYQfzJpfViyuLIqQmi0Cb9OpVquqTrWYRXeaJ+h
         5to1uyI5VZefu7p8NSe3TwJSn7Z3LT8cAQTeHD9uYejCKHJlLCiBwms5MscYqzQgoxFq
         4zmw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=SVilzhdZ;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=SVilzhdZ;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x226wUhgN9SYOPUu7j0Tae8ucIW7bqRgz1QboFdhuvnw7aprDQz9a8EU38C5jXq9dnD/e6XBqTg==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	marc.zyngier@arm.com,
	broonie@linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] arm64 spectre and meltdown mitigations for v4.14-stable
Date: Mon, 12 Feb 2018 11:38:01 +0000
Message-Id: <20180212113801.2552-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592195012503488310?=
X-GMAIL-MSGID: =?utf-8?q?1592195012503488310?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

As mentioned by Will, I have created the v4.14 counterpart of his stable
backport of the arm64/ARM Spectre/Meltdown mitigations that have been pulled
into v4.16-rc1.

Given that this is the v4.15 version backported to v4.14, I have removed any
mention of 'conflicts' from the commit logs as they are now ambiguous. The
patches applied surprisingly cleanly, I only needed to drop two patches that
are already in (the same ones Will mentioned in his PR), and drop another one
dealing with SPE, support for which did not exist yet in v4.14. I also included
the patch

  arm64: move TASK_* definitions to <asm/processor.h>

from v4.15 to make Robin's Spectre v1 patches apply more cleanly.

Thanks,
Ard.

-------------8<----------------
The following changes since commit 81d0cc85caabe062991ea45ddada814835d47fb0:

  Linux 4.14.18 (2018-02-07 11:12:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git tags/arm64-spectre-meltdown-for-4.14-stable

for you to fetch changes up to 2cfc4ce33abf38e3ae369e209c2de31a5008c4bf:

  [Variant 2/Spectre-v2] arm64: Kill PSCI_GET_VERSION as a variant-2 workaround (2018-02-09 16:20:15 +0000)

----------------------------------------------------------------
arm64 Spectre and Meltdown mitigations based on v4.14

----------------------------------------------------------------
Catalin Marinas (1):
      [Variant 3/Meltdown] arm64: kpti: Fix the interaction between ASID switching and software PAN

James Morse (1):
      [Variant 2/Spectre-v2] arm64: cpufeature: __this_cpu_has_cap() shouldn't stop early

Jayachandran C (3):
      [Variant 3/Meltdown] arm64: cputype: Add MIDR values for Cavium ThunderX2 CPUs
      [Variant 3/Meltdown] arm64: Turn on KPTI only on CPUs that need it
      [Variant 2/Spectre-v2] arm64: Branch predictor hardening for Cavium ThunderX2

Marc Zyngier (20):
      [Variant 3/Meltdown] arm64: Force KPTI to be disabled on Cavium ThunderX
      [Variant 2/Spectre-v2] arm64: Move post_ttbr_update_workaround to C code
      [Variant 2/Spectre-v2] arm64: Move BP hardening to check_and_switch_context
      [Variant 2/Spectre-v2] arm64: KVM: Use per-CPU vector when BP hardening is enabled
      [Variant 2/Spectre-v2] arm64: KVM: Increment PC after handling an SMC trap
      [Variant 2/Spectre-v2] arm/arm64: KVM: Consolidate the PSCI include files
      [Variant 2/Spectre-v2] arm/arm64: KVM: Add PSCI_VERSION helper
      [Variant 2/Spectre-v2] arm/arm64: KVM: Add smccc accessors to PSCI code
      [Variant 2/Spectre-v2] arm/arm64: KVM: Implement PSCI 1.0 support
      [Variant 2/Spectre-v2] arm/arm64: KVM: Advertise SMCCC v1.1
      [Variant 2/Spectre-v2] arm64: KVM: Make PSCI_VERSION a fast path
      [Variant 2/Spectre-v2] arm/arm64: KVM: Turn kvm_psci_version into a static inline
      [Variant 2/Spectre-v2] arm64: KVM: Report SMCCC_ARCH_WORKAROUND_1 BP hardening support
      [Variant 2/Spectre-v2] arm64: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling
      [Variant 2/Spectre-v2] firmware/psci: Expose PSCI conduit
      [Variant 2/Spectre-v2] firmware/psci: Expose SMCCC version through psci_ops
      [Variant 2/Spectre-v2] arm/arm64: smccc: Make function identifiers an unsigned quantity
      [Variant 2/Spectre-v2] arm/arm64: smccc: Implement SMCCC v1.1 inline primitive
      [Variant 2/Spectre-v2] arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support
      [Variant 2/Spectre-v2] arm64: Kill PSCI_GET_VERSION as a variant-2 workaround

Robin Murphy (3):
      [Variant 1/Spectre-v1] arm64: Implement array_index_mask_nospec()
      [Variant 1/Spectre-v1] arm64: Make USER_DS an inclusive limit
      [Variant 1/Spectre-v1] arm64: Use pointer masking to limit uaccess speculation

Shanker Donthineni (1):
      [Variant 2/Spectre-v2] arm64: Implement branch predictor hardening for Falkor

Stephen Boyd (1):
      [Variant 3/Meltdown] arm64: cpu_errata: Add Kryo to Falkor 1003 errata

Suzuki K Poulose (2):
      [Variant 3/Meltdown] arm64: capabilities: Handle duplicate entries for a capability
      [Variant 2/Spectre-v2] arm64: Run enable method for errata work arounds on late CPUs

Will Deacon (40):
      [Variant 3/Meltdown] arm64: mm: Use non-global mappings for kernel space
      [Variant 3/Meltdown] arm64: mm: Temporarily disable ARM64_SW_TTBR0_PAN
      [Variant 3/Meltdown] arm64: mm: Move ASID from TTBR0 to TTBR1
      [Variant 3/Meltdown] arm64: mm: Remove pre_ttbr0_update_workaround for Falkor erratum #E1003
      [Variant 3/Meltdown] arm64: mm: Rename post_ttbr0_update_workaround
      [Variant 3/Meltdown] arm64: mm: Fix and re-enable ARM64_SW_TTBR0_PAN
      [Variant 3/Meltdown] arm64: mm: Allocate ASIDs in pairs
      [Variant 3/Meltdown] arm64: mm: Add arm64_kernel_unmapped_at_el0 helper
      [Variant 3/Meltdown] arm64: mm: Invalidate both kernel and user ASIDs when performing TLBI
      [Variant 3/Meltdown] arm64: entry: Add exception trampoline page for exceptions from EL0
      [Variant 3/Meltdown] arm64: mm: Map entry trampoline into trampoline and kernel page tables
      [Variant 3/Meltdown] arm64: entry: Explicitly pass exception level to kernel_ventry macro
      [Variant 3/Meltdown] arm64: entry: Hook up entry trampoline to exception vectors
      [Variant 3/Meltdown] arm64: erratum: Work around Falkor erratum #E1003 in trampoline code
      [Variant 3/Meltdown] arm64: tls: Avoid unconditional zeroing of tpidrro_el0 for native tasks
      [Variant 3/Meltdown] arm64: entry: Add fake CPU feature for unmapping the kernel at EL0
      [Variant 3/Meltdown] arm64: kaslr: Put kernel vectors address in separate data page
      [Variant 3/Meltdown] arm64: use RET instruction for exiting the trampoline
      [Variant 3/Meltdown] arm64: Kconfig: Add CONFIG_UNMAP_KERNEL_AT_EL0
      [Variant 3/Meltdown] arm64: Kconfig: Reword UNMAP_KERNEL_AT_EL0 kconfig entry
      [Variant 3/Meltdown] arm64: Take into account ID_AA64PFR0_EL1.CSV3
      [Variant 3/Meltdown] arm64: mm: Introduce TTBR_ASID_MASK for getting at the ASID in the TTBR
      [Variant 3/Meltdown] arm64: kpti: Make use of nG dependent on arm64_kernel_unmapped_at_el0()
      [Variant 3/Meltdown] arm64: mm: Permit transitioning from Global to Non-Global without BBM
      [Variant 3/Meltdown] arm64: kpti: Add ->enable callback to remap swapper using nG mappings
      [Variant 3/Meltdown] arm64: entry: Reword comment about post_ttbr_update_workaround
      [Variant 3/Meltdown] arm64: idmap: Use "awx" flags for .idmap.text .pushsection directives
      [Variant 1/Spectre-v1] arm64: barrier: Add CSDB macros to control data-value prediction
      [Variant 1/Spectre-v1] arm64: entry: Ensure branch through syscall table is bounded under speculation
      [Variant 1/Spectre-v1] arm64: uaccess: Prevent speculative use of the current addr_limit
      [Variant 1/Spectre-v1] arm64: uaccess: Don't bother eliding access_ok checks in __{get, put}_user
      [Variant 1/Spectre-v1] arm64: uaccess: Mask __user pointers for __arch_{clear, copy_*}_user
      [Variant 1/Spectre-v1] arm64: futex: Mask __user pointers prior to dereference
      [Variant 2/Spectre-v2] arm64: cpufeature: Pass capability structure to ->enable callback
      [Variant 2/Spectre-v2] drivers/firmware: Expose psci_get_version through psci_ops structure
      [Variant 2/Spectre-v2] arm64: Add skeleton to harden the branch predictor against aliasing attacks
      [Variant 2/Spectre-v2] arm64: entry: Apply BP hardening for high-priority synchronous exceptions
      [Variant 2/Spectre-v2] arm64: entry: Apply BP hardening for suspicious interrupts from EL0
      [Variant 2/Spectre-v2] arm64: cputype: Add missing MIDR values for Cortex-A72 and Cortex-A75
      [Variant 2/Spectre-v2] arm64: Implement branch predictor hardening for affected Cortex-A CPUs

Yury Norov (1):
      arm64: move TASK_* definitions to <asm/processor.h>

 Documentation/arm64/silicon-errata.txt |   2 +-
 arch/arm/include/asm/kvm_host.h        |   6 +
 arch/arm/include/asm/kvm_mmu.h         |  10 ++
 arch/arm/include/asm/kvm_psci.h        |  27 ----
 arch/arm/kvm/handle_exit.c             |   4 +-
 arch/arm64/Kconfig                     |  46 +++++--
 arch/arm64/include/asm/asm-uaccess.h   |  36 +++--
 arch/arm64/include/asm/assembler.h     |  54 +++-----
 arch/arm64/include/asm/barrier.h       |  23 ++++
 arch/arm64/include/asm/cpucaps.h       |   5 +-
 arch/arm64/include/asm/cputype.h       |   9 ++
 arch/arm64/include/asm/efi.h           |  12 +-
 arch/arm64/include/asm/fixmap.h        |   5 +
 arch/arm64/include/asm/futex.h         |   9 +-
 arch/arm64/include/asm/kvm_asm.h       |   2 +
 arch/arm64/include/asm/kvm_host.h      |   5 +
 arch/arm64/include/asm/kvm_mmu.h       |  38 ++++++
 arch/arm64/include/asm/kvm_psci.h      |  27 ----
 arch/arm64/include/asm/memory.h        |  15 ---
 arch/arm64/include/asm/mmu.h           |  48 +++++++
 arch/arm64/include/asm/mmu_context.h   |  12 +-
 arch/arm64/include/asm/pgtable-hwdef.h |   1 +
 arch/arm64/include/asm/pgtable-prot.h  |  35 +++--
 arch/arm64/include/asm/pgtable.h       |   1 +
 arch/arm64/include/asm/proc-fns.h      |   6 -
 arch/arm64/include/asm/processor.h     |  24 ++++
 arch/arm64/include/asm/sysreg.h        |   2 +
 arch/arm64/include/asm/tlbflush.h      |  16 ++-
 arch/arm64/include/asm/uaccess.h       | 181 +++++++++++++++++--------
 arch/arm64/kernel/Makefile             |   4 +
 arch/arm64/kernel/arm64ksyms.c         |   4 +-
 arch/arm64/kernel/asm-offsets.c        |   6 +-
 arch/arm64/kernel/bpi.S                |  83 ++++++++++++
 arch/arm64/kernel/cpu-reset.S          |   2 +-
 arch/arm64/kernel/cpu_errata.c         | 239 ++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/cpufeature.c         | 138 +++++++++++++++----
 arch/arm64/kernel/entry.S              | 230 ++++++++++++++++++++++++++-----
 arch/arm64/kernel/head.S               |   2 +-
 arch/arm64/kernel/process.c            |  12 +-
 arch/arm64/kernel/sleep.S              |   2 +-
 arch/arm64/kernel/vmlinux.lds.S        |  22 ++-
 arch/arm64/kvm/handle_exit.c           |  14 +-
 arch/arm64/kvm/hyp/entry.S             |  12 ++
 arch/arm64/kvm/hyp/hyp-entry.S         |  20 ++-
 arch/arm64/kvm/hyp/switch.c            |  13 +-
 arch/arm64/lib/clear_user.S            |  10 +-
 arch/arm64/lib/copy_from_user.S        |   4 +-
 arch/arm64/lib/copy_in_user.S          |   9 +-
 arch/arm64/lib/copy_to_user.S          |   4 +-
 arch/arm64/mm/cache.S                  |   4 +-
 arch/arm64/mm/context.c                |  48 ++++---
 arch/arm64/mm/fault.c                  |  36 ++++-
 arch/arm64/mm/mmu.c                    |  35 +++++
 arch/arm64/mm/proc.S                   | 223 +++++++++++++++++++++++++++---
 arch/arm64/xen/hypercall.S             |   4 +-
 drivers/firmware/psci.c                |  57 +++++++-
 include/kvm/arm_psci.h                 |  51 +++++++
 include/linux/arm-smccc.h              | 165 ++++++++++++++++++++++-
 include/linux/psci.h                   |  14 ++
 include/uapi/linux/psci.h              |   3 +
 virt/kvm/arm/arm.c                     |  10 +-
 virt/kvm/arm/psci.c                    | 143 ++++++++++++++++----
 62 files changed, 1899 insertions(+), 385 deletions(-)
 delete mode 100644 arch/arm/include/asm/kvm_psci.h
 delete mode 100644 arch/arm64/include/asm/kvm_psci.h
 create mode 100644 arch/arm64/kernel/bpi.S
 create mode 100644 include/kvm/arm_psci.h
