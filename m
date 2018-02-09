Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518184113-2-478410978221179918
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184111; b=cEjV1Z4jwN2VB+e4t/lDwdNxBn6KwpJ+o99ap4VKIuI0gky
    OHA1rxK30W0ZDTR/eOFiA/WUvNT/Q4Nf0ajIYnxqmaWsFWgUgNoouTiId6Mp574Y
    O/JWTDmXyCCMt7BxxMK7+LSDbtU0ruGzp/G2L20E+WMBMhLw0XvjKXPGMby3GSDS
    TwcM0+hVtvS/KpdKuMOJBVx3icl8XafI0Y09gYeogYJ5hUY+0GJxpZ4XXlYG697j
    Mn9s5Rv+zyr+QwvELbpCldRKVJqGpcc6Ey9/JPdqycG+f/GMqtm0Md1mrll/qMyz
    ygmyZw7I+c5k67ihDB5xpDfC+DZzr2p59rFxJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1518184111; bh=SWiAZ5BpLtAPAgF0Vf7KZwGX0Q30CIrsrmA3BsQyLPg=; b=w
    AKDRadzjEaN6qdd88V+9zgqJzYsswIYdilje/wBiatRvXNlkjCTlbUu1BaFSV9OM
    nAfBQfFxA7yOMLfaMOnbWJWA6XF+cn3HRCpqDSkm2ULnUZoiUB75DWLosJTFpwG4
    +yNn2olZRjXNLbquWB+4I9ZMM55vp+AvzFro15pMMGAmVf/XIEuFtG7/Xfn+BpfS
    YSN2kWaVyWHSWiMFU0dkw4KZknA7N3z733Yy3uNQrqJFfpARkHhG+7LcmXkMRv91
    LcuQifrDchFq4mP+yL9OaYHN3LWjfl5A6ZW/atflyw51BHf4Spq1p5df1t/VAaGO
    SX/NKIyMQjrJS4Rn1nHCw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeBINsJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:48:09 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47324 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751090AbeBINsH (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 9 Feb 2018 08:48:07 -0500
Date: Fri, 9 Feb 2018 13:48:11 +0000
From: Will Deacon <will.deacon@arm.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org
Subject: [GIT PULL] arm64 spectre and meltdown mitigations for -stable
Message-ID: <20180209134811.GB11309@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

I've put together a tag which includes all of the upstream arm64 spectre and
meltdown mitigations based on v4.15. Please could you consider taking this
into the 4.15 stable tree?

I understand that Ard (cc'd) is using this stack to create a version for 4.14
too.

Note that there are two commits in here that are already in stable:

  9c9345fb26ff [Variant 1/Spectre-v1] Documentation: Document array_index_nospec
  60d6c8a8e54e [Variant 1/Spectre-v1] array_index_nospec: Sanitize speculative array de-references

so you can skip those when applying.

Please shout if you run into trouble.

Thanks,

Will

--->8

The following changes since commit d8a5b80568a9cb66810e75b182018e9edb68e8ff:

  Linux 4.15 (2018-01-28 13:20:33 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-spectre-meltdown-for-4.15-stable

for you to fetch changes up to a4c4410bae3dc1f00ab3bfb9d425740bf197b5b6:

  [Variant 2/Spectre-v2] arm64: Kill PSCI_GET_VERSION as a variant-2 workaround (2018-02-07 15:48:57 +0000)

----------------------------------------------------------------
arm64 Spectre and Meltdown mitigations based on v4.15

----------------------------------------------------------------
Catalin Marinas (1):
      [Variant 3/Meltdown] arm64: kpti: Fix the interaction between ASID switching and software PAN

Dan Williams (1):
      [Variant 1/Spectre-v1] array_index_nospec: Sanitize speculative array de-references

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

Mark Rutland (1):
      [Variant 1/Spectre-v1] Documentation: Document array_index_nospec

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

Will Deacon (41):
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
      [Variant 3/Meltdown] perf: arm_spe: Fail device probe when arm64_kernel_unmapped_at_el0()
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

 Documentation/arm64/silicon-errata.txt |   2 +-
 Documentation/speculation.txt          |  90 +++++++++++++
 arch/arm/include/asm/kvm_host.h        |   6 +
 arch/arm/include/asm/kvm_mmu.h         |  10 ++
 arch/arm/include/asm/kvm_psci.h        |  27 ----
 arch/arm/kvm/handle_exit.c             |   4 +-
 arch/arm64/Kconfig                     |  46 +++++--
 arch/arm64/include/asm/asm-uaccess.h   |  36 +++--
 arch/arm64/include/asm/assembler.h     |  54 +++-----
 arch/arm64/include/asm/barrier.h       |  22 +++
 arch/arm64/include/asm/cpucaps.h       |   5 +-
 arch/arm64/include/asm/cputype.h       |   9 ++
 arch/arm64/include/asm/efi.h           |  12 +-
 arch/arm64/include/asm/fixmap.h        |   5 +
 arch/arm64/include/asm/futex.h         |   9 +-
 arch/arm64/include/asm/kvm_asm.h       |   2 +
 arch/arm64/include/asm/kvm_host.h      |   5 +
 arch/arm64/include/asm/kvm_mmu.h       |  38 ++++++
 arch/arm64/include/asm/kvm_psci.h      |  27 ----
 arch/arm64/include/asm/mmu.h           |  48 +++++++
 arch/arm64/include/asm/mmu_context.h   |  12 +-
 arch/arm64/include/asm/pgtable-hwdef.h |   1 +
 arch/arm64/include/asm/pgtable-prot.h  |  35 +++--
 arch/arm64/include/asm/pgtable.h       |   1 +
 arch/arm64/include/asm/proc-fns.h      |   6 -
 arch/arm64/include/asm/processor.h     |   3 +
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
 arch/arm64/kernel/entry.S              | 228 ++++++++++++++++++++++++++-----
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
 arch/arm64/mm/proc.S                   | 224 +++++++++++++++++++++++++++---
 arch/arm64/xen/hypercall.S             |   4 +-
 drivers/firmware/psci.c                |  57 +++++++-
 drivers/perf/arm_spe_pmu.c             |   9 ++
 include/kvm/arm_psci.h                 |  51 +++++++
 include/linux/arm-smccc.h              | 165 ++++++++++++++++++++++-
 include/linux/nospec.h                 |  72 ++++++++++
 include/linux/psci.h                   |  14 ++
 include/uapi/linux/psci.h              |   3 +
 virt/kvm/arm/arm.c                     |  10 +-
 virt/kvm/arm/psci.c                    | 143 ++++++++++++++++----
 64 files changed, 2049 insertions(+), 368 deletions(-)
 create mode 100644 Documentation/speculation.txt
 delete mode 100644 arch/arm/include/asm/kvm_psci.h
 delete mode 100644 arch/arm64/include/asm/kvm_psci.h
 create mode 100644 arch/arm64/kernel/bpi.S
 create mode 100644 include/kvm/arm_psci.h
 create mode 100644 include/linux/nospec.h
