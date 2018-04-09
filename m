Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbeDIQmb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:42:31 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:35361 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753370AbeDIQmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:42:21 -0400
X-Google-Smtp-Source: AIpwx4/9FSc6f73T5dwhCI061XUN3A2xF/5W9y0GXGTkQ9BbUjrMy6h6mk/rQtJW504U12hn/454AA==
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, rkrcmar@redhat.com, kvm@vger.kernel.org
Subject: [GIT PULL] KVM changes for Linux 4.17
Date: Mon,  9 Apr 2018 18:42:12 +0200
Message-Id: <1523292132-8361-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 27e91ad1e746e341ca2312f29bccb9736be7b476:

  kvm: arm/arm64: vgic-v3: Tighten synchronization for guests using v2 on v3 (2018-03-14 18:31:26 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to e01bca2fc698d7f0626f0214001af523e18ad60b:

  kvm: x86: fix a prototype warning (2018-04-06 18:20:31 +0200)

----------------------------------------------------------------
ARM:
- VHE optimizations
- EL2 address space randomization
- speculative execution mitigations ("variant 3a", aka execution past invalid
privilege register access)
- bugfixes and cleanups

PPC:
- improvements for the radix page fault handler for HV KVM on POWER9

s390:
- more kvm stat counters
- virtio gpu plumbing
- documentation
- facilities improvements

x86:
- support for VMware magic I/O port and pseudo-PMCs
- AMD pause loop exiting
- support for AMD core performance extensions
- support for synchronous register access
- expose nVMX capabilities to userspace
- support for Hyper-V signaling via eventfd
- use Enlightened VMCS when running on Hyper-V
- allow userspace to disable MWAIT/HLT/PAUSE vmexits
- usual roundup of optimizations and nested virtualization bugfixes

Generic:
- API selftest infrastructure (though the only tests are for x86 as of now)

----------------------------------------------------------------

There are a few conflicts:
- bugfixes in 4.16 (arch/x86)
- independent ARM tree changes (arch/arm*)
- a Kconfig conflict in drivers/video/console.

It's not hard to solve but I placed a sample resolution anyway at
git://git.kernel.org/pub/scm/virt/kvm/kvm.git, branch kvm-4.17-resolution.

Thanks,

Paolo

Andi Kleen (1):
      KVM: x86: Fix perf timer mode IP reporting

Andrew Jones (1):
      KVM: trivial documentation cleanups

Arbel Moshe (1):
      KVM: x86: Add support for VMware backdoor Pseudo-PMCs

Arnd Bergmann (1):
      x86: kvm: hide the unused 'cpu' variable

Babu Moger (5):
      KVM: VMX: Fix the module parameters for vmx
      KVM: VMX: Remove ple_window_actual_max
      KVM: VMX: Bring the common code to header file
      KVM: SVM: Add pause filter threshold
      KVM: SVM: Implement pause loop exit logic in SVM

Christian Borntraeger (4):
      KVM: s390: implement CPU model only facilities
      KVM: document KVM_CAP_S390_[BPB|PSW|GMAP|COW]
      KVM: s390: add exit io request stats and simplify code
      KVM: s390: provide counters for all interrupt injects/delivery

Christoffer Dall (39):
      KVM: arm/arm64: Avoid vcpu_load for other vcpu ioctls than KVM_RUN
      KVM: arm/arm64: Move vcpu_load call after kvm_vcpu_first_run_init
      KVM: arm64: Avoid storing the vcpu pointer on the stack
      KVM: arm64: Rework hyp_panic for VHE and non-VHE
      KVM: arm/arm64: Get rid of vcpu->arch.irq_lines
      KVM: arm/arm64: Add kvm_vcpu_load_sysregs and kvm_vcpu_put_sysregs
      KVM: arm/arm64: Introduce vcpu_el1_is_32bit
      KVM: arm64: Move debug dirty flag calculation out of world switch
      KVM: arm64: Slightly improve debug save/restore functions
      KVM: arm64: Improve debug register save/restore flow
      KVM: arm64: Factor out fault info population and gic workarounds
      KVM: arm64: Introduce VHE-specific kvm_vcpu_run
      KVM: arm64: Remove kern_hyp_va() use in VHE switch function
      KVM: arm64: Don't deactivate VM on VHE systems
      KVM: arm64: Remove noop calls to timer save/restore from VHE switch
      KVM: arm64: Move userspace system registers into separate function
      KVM: arm64: Rewrite sysreg alternatives to static keys
      KVM: arm64: Introduce separate VHE/non-VHE sysreg save/restore functions
      KVM: arm/arm64: Remove leftover comment from kvm_vcpu_run_vhe
      KVM: arm64: Unify non-VHE host/guest sysreg save and restore functions
      KVM: arm64: Don't save the host ELR_EL2 and SPSR_EL2 on VHE systems
      KVM: arm64: Change 32-bit handling of VM system registers
      KVM: arm64: Rewrite system register accessors to read/write functions
      KVM: arm64: Introduce framework for accessing deferred sysregs
      KVM: arm/arm64: Prepare to handle deferred save/restore of SPSR_EL1
      KVM: arm64: Prepare to handle deferred save/restore of ELR_EL1
      KVM: arm64: Defer saving/restoring 64-bit sysregs to vcpu load/put on VHE
      KVM: arm64: Prepare to handle deferred save/restore of 32-bit registers
      KVM: arm64: Defer saving/restoring 32-bit sysregs to vcpu load/put
      KVM: arm64: Move common VHE/non-VHE trap config in separate functions
      KVM: arm64: Directly call VHE and non-VHE FPSIMD enabled functions
      KVM: arm64: Configure c15, PMU, and debug register traps on cpu load/put for VHE
      KVM: arm64: Cleanup __activate_traps and __deactive_traps for VHE and non-VHE
      KVM: arm/arm64: Get rid of vgic_elrsr
      KVM: arm/arm64: Handle VGICv2 save/restore from the main VGIC code
      KVM: arm/arm64: Move arm64-only vgic-v2-sr.c file to arm64
      KVM: arm/arm64: Handle VGICv3 save/restore from the main VGIC code on VHE
      KVM: arm/arm64: Move VGIC APR save/restore to vgic put/load
      KVM: arm/arm64: Avoid VGICv3 save/restore on VHE with no IRQs

Cole Robinson (3):
      tools/kvm_stat: Fix python3 syntax
      tools/kvm_stat: Don't use deprecated file()
      tools/kvm_stat: Remove unused function

Dan Carpenter (1):
      kvm: x86: hyperv: delete dead code in kvm_hv_hypercall()

Dave Martin (1):
      arm64: KVM: Move CPU ID reg trap setup off the world switch path

Farhan Ali (3):
      Kconfig: Remove HAS_IOMEM dependency for Graphics support
      s390/char: Rename EBCDIC keymap variables
      s390/setup: enable display support for KVM guest

Gal Hammer (1):
      kvm: use insert sort in kvm_io_bus_register_dev function

Janakarajan Natarajan (2):
      x86/msr: Add AMD Core Perf Extension MSRs
      KVM: x86: Add support for AMD Core Perf Extension in guest

Janosch Frank (1):
      KVM: s390: Refactor host cmma and pfmfi interpretation controls

Jérémy Fanguède (2):
      KVM: arm64: Enable the EL1 physical timer for AArch32 guests
      KVM: arm: Enable emulation of the physical timer

KarimAllah Ahmed (1):
      KVM: x86: Update the exit_qualification access bits while walking an address

Ken Hofsass (2):
      KVM: x86: add SYNC_REGS_SIZE_BYTES #define.
      KVM: x86: KVM_CAP_SYNC_REGS

Krish Sadhukhan (1):
      KVM: nVMX: Enforce NMI controls on vmentry of L2 guests

Ladi Prosek (1):
      x86/kvm: rename HV_X64_MSR_APIC_ASSIST_PAGE to HV_X64_MSR_VP_ASSIST_PAGE

Liran Alon (12):
      KVM: x86: Add module parameter for supporting VMware backdoor
      KVM: x86: Always allow access to VMware backdoor I/O ports
      KVM: x86: Add emulation_type to not raise #UD on emulation failure
      KVM: x86: Emulate only IN/OUT instructions when accessing VMware backdoor
      KVM: x86: VMX: Intercept #GP to support access to VMware backdoor ports
      KVM: x86: SVM: Intercept #GP to support access to VMware backdoor ports
      KVM: nVMX: Do not load EOI-exitmap while running L2
      KVM: VMX: No need to clear pending NMI/interrupt on inject realmode interrupt
      KVM: x86: Rename interrupt.pending to interrupt.injected
      KVM: x86: Fix misleading comments on handling pending exceptions
      KVM: nVMX: Require immediate-exit when event reinjected to L2 and L1 event pending
      KVM: nVMX: Optimization: Dont set KVM_REQ_EVENT when VMExit with nested_run_pending

Marc Zyngier (31):
      arm64: alternatives: Add dynamic patching feature
      arm64: insn: Add N immediate encoding
      arm64: insn: Add encoder for bitwise operations using literals
      arm64: KVM: Dynamically patch the kernel/hyp VA mask
      arm64: cpufeatures: Drop the ARM64_HYP_OFFSET_LOW feature flag
      KVM: arm/arm64: Do not use kern_hyp_va() with kvm_vgic_global_state
      KVM: arm/arm64: Demote HYP VA range display to being a debug feature
      KVM: arm/arm64: Move ioremap calls to create_hyp_io_mappings
      KVM: arm/arm64: Keep GICv2 HYP VAs in kvm_vgic_global_state
      KVM: arm/arm64: Fix idmap size and alignment
      KVM: arm64: Fix HYP idmap unmap when using 52bit PA
      KVM: arm/arm64: Move HYP IO VAs to the "idmap" range
      arm64; insn: Add encoder for the EXTR instruction
      arm64: insn: Allow ADD/SUB (immediate) with LSL #12
      arm64: KVM: Dynamically compute the HYP VA mask
      arm64: KVM: Introduce EL2 VA randomisation
      arm64: Update the KVM memory map documentation
      arm64: KVM: Move vector offsetting from hyp-init.S to kvm_get_hyp_vector
      arm64: KVM: Move stashing of x0/x1 into the vector code itself
      arm64: KVM: Move BP hardening vectors into .hyp.text section
      arm64: KVM: Reserve 4 additional instructions in the BPI template
      arm64: KVM: Allow far branches from vector slots to the main vectors
      arm/arm64: KVM: Introduce EL2-specific executable mappings
      arm64: Make BP hardening slot counter available
      arm64: KVM: Allow mapping of vectors outside of the RAM region
      arm64: Enable ARM64_HARDEN_EL2_VECTORS on Cortex-A57 and A72
      Merge tag 'kvm-arm-fixes-for-v4.16-2' into HEAD
      KVM: arm/arm64: vgic: Disallow Active+Pending for level interrupts
      KVM: arm/arm64: vgic-its: Fix potential overrun in vgic_copy_lpi_list
      Revert "arm64: KVM: Use SMCCC_ARCH_WORKAROUND_1 for Falkor BP hardening"
      arm64: Add temporary ERRATA_MIDR_ALL_VERSIONS compatibility macro

Mark Rutland (1):
      arm64/kvm: Prohibit guest LOR accesses

Matthias Kaehlcke (1):
      KVM: x86: Make enum conversion explicit in kvm_pdptr_read()

Paolo Bonzini (7):
      KVM: nVMX: introduce struct nested_vmx_msrs
      KVM: nVMX: expose VMX capabilities for nested hypervisors to userspace
      Merge tag 'kvm-s390-next-4.17-1' of git://git.kernel.org/.../kvms390/linux into HEAD
      KVM: nVMX: fix vmentry failure code when L2 state would require emulation
      KVM: vmx: unify adjacent #ifdefs
      kvm: selftests: add API testing infrastructure
      kvm: selftests: add sync_regs_test

Paul Mackerras (5):
      KVM: PPC: Remove unused kvm_unmap_hva callback
      KVM: PPC: Book3S HV: Radix page fault handler optimizations
      KVM: PPC: Book3S HV: Streamline setting of reference and change bits
      KVM: PPC: Book3S HV: Handle 1GB pages in radix page fault handler
      KVM: PPC: Book3S HV: Use __gfn_to_pfn_memslot() in page fault handler

Peng Hao (2):
      kvm: x86: fix a compile warning
      kvm: x86: fix a prototype warning

Peter Maydell (1):
      KVM: arm: Reserve bit in KVM_REG_ARM encoding for secure/nonsecure

QingFeng Hao (1):
      KVM: add machine check counter to kvm_stat

Radim Krčmář (2):
      Merge tag 'kvm-arm-for-v4.17' of git://git.kernel.org/.../kvmarm/kvmarm
      Merge tag 'kvm-ppc-next-4.17-1' of git://git.kernel.org/.../paulus/powerpc

Roman Kagan (2):
      kvm: x86: factor out kvm.arch.hyperv (de)init
      kvm: x86: hyperv: guest->host event signaling via eventfd

Sean Christopherson (16):
      KVM: VMX: don't configure RM TSS for unrestricted guest
      KVM: VMX: don't configure EPT identity map for unrestricted guest
      KVM: VMX: remove CR0.WP from ..._ALWAYS_ON_UNRESTRICTED_GUEST
      KVM: VMX: don't force CR4.PAE/PSE for unrestricted guest
      KVM: VMX: give unrestricted guest full control of CR3
      KVM: VMX: WARN on a MOV CR3 exit w/ unrestricted guest
      KVM: vVMX: signal failure for nested VMEntry if emulation_required
      KVM: VMX: use kvm_fast_pio_in for handling IN I/O
      KVM: x86: add kvm_fast_pio() to consolidate fast PIO code
      KVM: x86: define SVM/VMX specific kvm_arch_[alloc|free]_vm
      KVM: x86: move setting of ept_identity_map_addr to vmx.c
      KVM: VMX: add struct kvm_vmx to hold VMX specific KVM vars
      KVM: SVM: add struct kvm_svm to hold SVM specific KVM vars
      KVM: VMX: raise internal error for exception during invalid protected mode state
      Revert "KVM: X86: Fix SMRAM accessing even if VM is shutdown"
      KVM: VMX: remove bogus WARN_ON in handle_ept_misconfig

Sebastian Ott (1):
      KVM: s390: fix fallthrough annotation

Shanker Donthineni (2):
      KVM: arm/arm64: No need to zero CNTVOFF in kvm_timer_vcpu_put() for VHE
      arm64: KVM: Use SMCCC_ARCH_WORKAROUND_1 for Falkor BP hardening

Shih-Wei Li (1):
      KVM: arm64: Move HCR_INT_OVERRIDE to default HCR_EL2 guest flag

Stefan Fritsch (1):
      kvm: Add emulation for movups/movupd

Vitaly Kuznetsov (12):
      KVM: lapic: stop advertising DIRECTED_EOI when in-kernel IOAPIC is in use
      x86/kvm/hyper-v: add reenlightenment MSRs support
      x86/kvm/hyper-v: remove stale entries from vec_bitmap/auto_eoi_bitmap on vector change
      x86/kvm/hyper-v: inject #GP only when invalid SINTx vector is unmasked
      x86/kvm/vmx: read MSR_{FS,KERNEL_GS}_BASE from current->thread
      x86/kvm/vmx: avoid expensive rdmsr for MSR_GS_BASE
      x86/hyper-v: move hyperv.h out of uapi
      x86/hyper-v: move definitions from TLFS to hyperv-tlfs.h
      x86/hyper-v: allocate and use Virtual Processor Assist Pages
      x86/hyper-v: define struct hv_enlightened_vmcs and clean field bits
      x86/hyper-v: detect nested features
      x86/kvm: use Enlightened VMCS when running on Hyper-V

Wanpeng Li (9):
      KVM: Introduce paravirtualization hints and KVM_HINTS_DEDICATED
      KVM: X86: Choose qspinlock when dedicated physical CPUs are available
      KVM: X86: Don't use PV TLB flush with dedicated physical CPUs
      KVM: X86: Provide a capability to disable MWAIT intercepts
      KVM: X86: Provide a capability to disable HLT intercepts
      KVM: X86: Provide a capability to disable PAUSE intercepts
      KVM: X86: Fix setup the virt_spin_lock_key before static key get initialized
      KVM: X86: Introduce handle_ud()
      KVM: X86: Add Force Emulation Prefix for "emulate the next instruction"

 .gitignore                                         |    4 +
 .../ABI/testing/sysfs-devices-platform-dock        |   39 +
 Documentation/ABI/testing/sysfs-devices-system-cpu |   77 +-
 Documentation/ABI/testing/sysfs-platform-dptf      |   40 +
 Documentation/PCI/pci.txt                          |    4 +-
 Documentation/admin-guide/kernel-parameters.txt    |    3 +
 Documentation/arm64/memory.txt                     |    9 +-
 Documentation/atomic_bitops.txt                    |    7 +-
 .../bindings/{misc => auxdisplay}/arm-charlcd.txt  |    0
 Documentation/devicetree/bindings/eeprom/at24.txt  |    2 +-
 .../bindings/interrupt-controller/renesas,irqc.txt |    1 +
 .../devicetree/bindings/power/mti,mips-cpc.txt     |    8 +
 .../devicetree/bindings/power/wakeup-source.txt    |    2 +-
 .../devicetree/bindings/thermal/imx-thermal.txt    |   25 +
 .../sched/membarrier-sync-core/arch-support.txt    |   62 +
 Documentation/gpu/tve200.rst                       |    2 +-
 Documentation/i2c/busses/i2c-i801                  |    2 +
 Documentation/locking/mutex-design.txt             |   49 +-
 Documentation/media/dmx.h.rst.exceptions           |   14 +-
 Documentation/media/uapi/dvb/dmx-qbuf.rst          |    7 +-
 Documentation/networking/segmentation-offloads.txt |   38 +-
 Documentation/virtual/kvm/00-INDEX                 |   10 +-
 Documentation/virtual/kvm/api.txt                  |  175 +-
 Documentation/virtual/kvm/cpuid.txt                |   19 +-
 Documentation/virtual/kvm/msr.txt                  |    3 +-
 Documentation/x86/intel_rdt_ui.txt                 |    2 +-
 Documentation/x86/topology.txt                     |    2 +-
 MAINTAINERS                                        |   30 +-
 Makefile                                           |   19 +-
 arch/alpha/include/asm/cmpxchg.h                   |    6 -
 arch/alpha/include/asm/xchg.h                      |   38 +-
 arch/arc/Kconfig                                   |    1 -
 arch/arc/boot/dts/axs101.dts                       |    2 +-
 arch/arc/boot/dts/axs10x_mb.dtsi                   |    4 +-
 arch/arc/boot/dts/haps_hs_idu.dts                  |    2 +-
 arch/arc/boot/dts/nsim_700.dts                     |    2 +-
 arch/arc/boot/dts/nsim_hs.dts                      |    2 +-
 arch/arc/boot/dts/nsim_hs_idu.dts                  |    2 +-
 arch/arc/boot/dts/nsimosci.dts                     |    2 +-
 arch/arc/boot/dts/nsimosci_hs.dts                  |    2 +-
 arch/arc/boot/dts/nsimosci_hs_idu.dts              |    2 +-
 arch/arc/include/asm/bug.h                         |    3 +-
 arch/arc/include/asm/entry-arcv2.h                 |    2 +-
 arch/arc/kernel/mcip.c                             |   74 +-
 arch/arc/kernel/setup.c                            |    4 +-
 arch/arc/kernel/smp.c                              |   50 +-
 arch/arc/kernel/unwind.c                           |    2 +-
 arch/arc/mm/cache.c                                |    5 +-
 arch/arm/boot/dts/bcm11351.dtsi                    |    2 +-
 arch/arm/boot/dts/bcm21664.dtsi                    |    2 +-
 arch/arm/boot/dts/bcm2835.dtsi                     |    6 +-
 arch/arm/boot/dts/bcm2836.dtsi                     |   12 +-
 arch/arm/boot/dts/bcm2837.dtsi                     |    2 +-
 arch/arm/boot/dts/bcm283x.dtsi                     |    2 +-
 arch/arm/boot/dts/bcm958625hr.dts                  |    2 +-
 arch/arm/boot/dts/gemini-dlink-dns-313.dts         |    2 +-
 arch/arm/boot/dts/imx6dl-icore-rqs.dts             |    2 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |    9 +-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi         |    8 +
 arch/arm/boot/dts/omap5-uevm.dts                   |    2 +-
 arch/arm/boot/dts/rk3036.dtsi                      |    4 +-
 arch/arm/boot/dts/rk322x.dtsi                      |    6 +-
 arch/arm/boot/dts/rk3288-phycore-som.dtsi          |   20 -
 arch/arm/boot/dts/zx296702.dtsi                    |   20 +-
 arch/arm/configs/omap2plus_defconfig               |    2 +-
 arch/arm/include/asm/kvm_asm.h                     |    5 +-
 arch/arm/include/asm/kvm_emulate.h                 |   21 +-
 arch/arm/include/asm/kvm_host.h                    |    6 +-
 arch/arm/include/asm/kvm_hyp.h                     |    4 +
 arch/arm/include/asm/kvm_mmu.h                     |   16 +-
 arch/arm/include/uapi/asm/kvm.h                    |    9 +
 arch/arm/kernel/time.c                             |    2 +-
 arch/arm/kvm/coproc.c                              |   61 +
 arch/arm/kvm/emulate.c                             |    4 +-
 arch/arm/kvm/hyp/Makefile                          |    1 -
 arch/arm/kvm/hyp/switch.c                          |   16 +-
 arch/arm/mach-clps711x/board-dt.c                  |    2 +-
 arch/arm/mach-davinci/board-dm355-evm.c            |    2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c        |    2 +-
 arch/arm/mach-davinci/board-dm365-evm.c            |    2 +-
 arch/arm/mach-mvebu/Kconfig                        |    4 +-
 arch/arm/mach-omap1/clock.c                        |    6 +-
 arch/arm/mach-omap2/omap-wakeupgen.c               |    4 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |    6 +-
 arch/arm/mach-omap2/pm.c                           |    4 +-
 arch/arm/mach-omap2/timer.c                        |   19 +-
 arch/arm/mach-ux500/cpu-db8500.c                   |   35 -
 arch/arm/plat-orion/common.c                       |   23 +-
 arch/arm64/Kconfig                                 |   16 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         |    4 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |   10 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |    1 +
 arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi      |    3 +-
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |    2 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |    2 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |    6 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |    6 +-
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |    7 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |    6 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |    2 +-
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi  |    2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |    4 +-
 arch/arm64/include/asm/alternative.h               |   41 +-
 arch/arm64/include/asm/cpucaps.h                   |    2 +-
 arch/arm64/include/asm/cputype.h                   |    2 +-
 arch/arm64/include/asm/hugetlb.h                   |    2 +-
 arch/arm64/include/asm/insn.h                      |   16 +
 arch/arm64/include/asm/kvm_arm.h                   |    6 +-
 arch/arm64/include/asm/kvm_asm.h                   |   19 +-
 arch/arm64/include/asm/kvm_emulate.h               |   78 +-
 arch/arm64/include/asm/kvm_host.h                  |   53 +-
 arch/arm64/include/asm/kvm_hyp.h                   |   29 +-
 arch/arm64/include/asm/kvm_mmu.h                   |  191 +-
 arch/arm64/include/asm/mmu.h                       |    8 +-
 arch/arm64/include/asm/mmu_context.h               |    4 +-
 arch/arm64/include/asm/pgalloc.h                   |   44 +-
 arch/arm64/include/asm/pgtable.h                   |   23 +-
 arch/arm64/include/asm/stacktrace.h                |    2 +-
 arch/arm64/include/asm/sysreg.h                    |    6 +
 arch/arm64/include/asm/uaccess.h                   |   12 +-
 arch/arm64/kernel/Makefile                         |    4 +-
 arch/arm64/kernel/alternative.c                    |   43 +-
 arch/arm64/kernel/armv8_deprecated.c               |    4 +-
 arch/arm64/kernel/asm-offsets.c                    |    1 +
 arch/arm64/kernel/bpi.S                            |   67 +-
 arch/arm64/kernel/cpu_errata.c                     |   34 +-
 arch/arm64/kernel/cpufeature.c                     |   25 +-
 arch/arm64/kernel/efi.c                            |    2 +-
 arch/arm64/kernel/head.S                           |    7 +
 arch/arm64/kernel/hibernate.c                      |  148 +-
 arch/arm64/kernel/insn.c                           |  190 +-
 arch/arm64/kernel/perf_event.c                     |    4 +-
 arch/arm64/kernel/process.c                        |   11 +-
 arch/arm64/kernel/ptrace.c                         |    2 +-
 arch/arm64/kernel/stacktrace.c                     |    5 +
 arch/arm64/kernel/sys_compat.c                     |    2 +-
 arch/arm64/kernel/time.c                           |    2 +-
 arch/arm64/kernel/traps.c                          |   10 +-
 arch/arm64/kvm/Kconfig                             |    3 +
 arch/arm64/kvm/Makefile                            |    2 +-
 arch/arm64/kvm/debug.c                             |   29 +-
 arch/arm64/kvm/hyp-init.S                          |    1 -
 arch/arm64/kvm/hyp/Makefile                        |    2 +-
 arch/arm64/kvm/hyp/debug-sr.c                      |   88 +-
 arch/arm64/kvm/hyp/entry.S                         |    6 +-
 arch/arm64/kvm/hyp/hyp-entry.S                     |   86 +-
 arch/arm64/kvm/hyp/switch.c                        |  386 ++--
 arch/arm64/kvm/hyp/sysreg-sr.c                     |  172 +-
 arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c           |   78 +
 arch/arm64/kvm/inject_fault.c                      |   24 +-
 arch/arm64/kvm/regmap.c                            |   67 +-
 arch/arm64/kvm/sys_regs.c                          |  199 +-
 arch/arm64/kvm/sys_regs.h                          |    4 +-
 arch/arm64/kvm/sys_regs_generic_v8.c               |    4 +-
 arch/arm64/kvm/va_layout.c                         |  227 +++
 arch/arm64/mm/dump.c                               |   54 +-
 arch/arm64/mm/fault.c                              |   44 +-
 arch/arm64/mm/hugetlbpage.c                        |   94 +-
 arch/arm64/mm/kasan_init.c                         |   70 +-
 arch/arm64/mm/mmu.c                                |  292 +--
 arch/arm64/mm/pageattr.c                           |   32 +-
 arch/arm64/mm/proc.S                               |   14 +-
 arch/arm64/net/bpf_jit_comp.c                      |    5 +-
 arch/cris/include/arch-v10/arch/bug.h              |   11 +-
 arch/ia64/include/asm/bug.h                        |    6 +-
 arch/ia64/kernel/Makefile                          |    1 -
 arch/m68k/include/asm/bug.h                        |    3 +
 arch/mips/boot/Makefile                            |    1 +
 arch/mips/include/asm/compat.h                     |    1 -
 arch/mips/include/asm/kvm_para.h                   |    5 +
 arch/mips/kernel/mips-cpc.c                        |   13 +
 arch/mips/kernel/setup.c                           |   16 +-
 arch/mips/kernel/smp-bmips.c                       |    2 +-
 arch/parisc/include/asm/cacheflush.h               |    1 +
 arch/parisc/include/asm/processor.h                |    2 +
 arch/parisc/kernel/cache.c                         |   57 +-
 arch/parisc/kernel/head.S                          |   18 +-
 arch/parisc/kernel/pacache.S                       |   22 +
 arch/parisc/kernel/smp.c                           |    7 +-
 arch/parisc/kernel/time.c                          |   11 +-
 arch/parisc/mm/init.c                              |    7 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h       |    1 +
 arch/powerpc/include/asm/book3s/64/hash-4k.h       |    3 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h      |   16 +-
 arch/powerpc/include/asm/book3s/64/hash.h          |   13 +-
 arch/powerpc/include/asm/book3s/64/pgalloc.h       |   16 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       |    4 +-
 arch/powerpc/include/asm/exception-64s.h           |    2 +-
 arch/powerpc/include/asm/firmware.h                |    2 +-
 arch/powerpc/include/asm/hw_irq.h                  |   12 +-
 arch/powerpc/include/asm/kexec.h                   |    6 +
 arch/powerpc/include/asm/kvm_host.h                |    1 -
 arch/powerpc/include/asm/kvm_para.h                |    5 +
 arch/powerpc/include/asm/kvm_ppc.h                 |    1 -
 arch/powerpc/include/asm/nohash/32/pgtable.h       |    1 +
 arch/powerpc/include/asm/nohash/64/pgtable.h       |    1 +
 arch/powerpc/include/asm/topology.h                |   13 +
 arch/powerpc/kernel/eeh_driver.c                   |    3 +-
 arch/powerpc/kernel/exceptions-64e.S               |    2 +
 arch/powerpc/kernel/exceptions-64s.S               |    6 +-
 arch/powerpc/kernel/prom_init.c                    |    2 +-
 arch/powerpc/kernel/sysfs.c                        |    6 +-
 arch/powerpc/kvm/book3s.c                          |    6 -
 arch/powerpc/kvm/book3s.h                          |    1 -
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |    9 -
 arch/powerpc/kvm/book3s_64_mmu_radix.c             |  384 ++--
 arch/powerpc/kvm/book3s_64_vio_hv.c                |    2 +-
 arch/powerpc/kvm/book3s_hv.c                       |   18 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |   10 +-
 arch/powerpc/kvm/book3s_pr.c                       |   10 -
 arch/powerpc/kvm/book3s_xive.c                     |    2 +-
 arch/powerpc/kvm/e500_mmu_host.c                   |    2 +-
 arch/powerpc/kvm/powerpc.c                         |    4 +-
 arch/powerpc/kvm/trace_pr.h                        |   15 -
 arch/powerpc/mm/drmem.c                            |   14 +-
 arch/powerpc/mm/hash64_4k.c                        |    4 +-
 arch/powerpc/mm/hash64_64k.c                       |    8 +-
 arch/powerpc/mm/hash_utils_64.c                    |    1 +
 arch/powerpc/mm/hugetlbpage-hash64.c               |   10 +-
 arch/powerpc/mm/init-common.c                      |    4 +-
 arch/powerpc/mm/numa.c                             |    5 -
 arch/powerpc/mm/pgtable-radix.c                    |  117 +-
 arch/powerpc/mm/pgtable_64.c                       |    4 +
 arch/powerpc/mm/tlb_hash64.c                       |    9 +-
 arch/powerpc/net/bpf_jit_comp.c                    |    3 +
 arch/powerpc/platforms/powernv/opal-imc.c          |    6 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |    2 +-
 arch/powerpc/platforms/powernv/setup.c             |    4 +
 arch/powerpc/platforms/powernv/vas-window.c        |   16 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c       |    4 +-
 arch/powerpc/platforms/pseries/ras.c               |   31 +-
 arch/powerpc/platforms/pseries/setup.c             |    3 +-
 arch/powerpc/sysdev/xive/spapr.c                   |   16 +-
 arch/riscv/Kconfig                                 |    3 -
 arch/riscv/include/asm/barrier.h                   |    6 +-
 arch/riscv/kernel/entry.S                          |    5 +-
 arch/riscv/kernel/head.S                           |    2 +-
 arch/riscv/kernel/setup.c                          |    2 +-
 arch/s390/include/asm/kvm_host.h                   |   28 +-
 arch/s390/include/asm/kvm_para.h                   |    5 +
 arch/s390/include/asm/mmu.h                        |    4 +-
 arch/s390/include/asm/mmu_context.h                |    2 +-
 arch/s390/kernel/setup.c                           |    2 +
 arch/s390/kvm/gaccess.c                            |    9 +-
 arch/s390/kvm/intercept.c                          |   68 +-
 arch/s390/kvm/interrupt.c                          |  149 +-
 arch/s390/kvm/kvm-s390.c                           |  181 +-
 arch/s390/kvm/kvm-s390.h                           |    9 +-
 arch/s390/kvm/priv.c                               |  196 +-
 arch/s390/kvm/vsie.c                               |   20 +
 arch/s390/tools/gen_facilities.c                   |   20 +
 arch/sh/boot/dts/Makefile                          |    4 +-
 arch/sparc/Kconfig                                 |    2 +
 arch/sparc/include/asm/bug.h                       |    6 +-
 arch/x86/.gitignore                                |    1 +
 arch/x86/Kconfig                                   |   78 +-
 arch/x86/Kconfig.cpu                               |    4 +-
 arch/x86/Makefile                                  |    7 +-
 arch/x86/boot/compressed/eboot.c                   |    4 +-
 .../x86/crypto/sha512-mb/sha512_mb_mgr_init_avx2.c |   10 +-
 arch/x86/entry/calling.h                           |  121 +-
 arch/x86/entry/entry_32.S                          |    3 +-
 arch/x86/entry/entry_64.S                          |  221 +--
 arch/x86/entry/entry_64_compat.S                   |   53 +-
 arch/x86/events/intel/core.c                       |    2 +-
 arch/x86/events/intel/lbr.c                        |    2 +-
 arch/x86/events/intel/p6.c                         |    2 +-
 arch/x86/hyperv/hv_init.c                          |   45 +-
 arch/x86/include/asm/acpi.h                        |    2 +-
 arch/x86/include/asm/apm.h                         |    6 +
 arch/x86/include/asm/asm-prototypes.h              |    3 -
 arch/x86/include/asm/barrier.h                     |    2 +-
 arch/x86/include/asm/bitops.h                      |   29 +-
 arch/x86/include/asm/bug.h                         |   19 +-
 arch/x86/include/asm/cpufeature.h                  |   79 +-
 arch/x86/include/asm/cpufeatures.h                 |    1 +
 arch/x86/include/asm/efi.h                         |   17 +-
 .../{uapi/asm/hyperv.h => asm/hyperv-tlfs.h}       |  317 ++-
 arch/x86/include/asm/kvm_host.h                    |   60 +-
 arch/x86/include/asm/kvm_para.h                    |    6 +
 arch/x86/include/asm/microcode.h                   |    9 +-
 arch/x86/include/asm/mmu_context.h                 |    1 +
 arch/x86/include/asm/mshyperv.h                    |   94 +-
 arch/x86/include/asm/msr-index.h                   |   14 +
 arch/x86/include/asm/nospec-branch.h               |  171 +-
 arch/x86/include/asm/page_64.h                     |    4 -
 arch/x86/include/asm/paravirt.h                    |   21 +-
 arch/x86/include/asm/paravirt_types.h              |    7 +-
 arch/x86/include/asm/percpu.h                      |    2 +-
 arch/x86/include/asm/pgtable.h                     |    8 +-
 arch/x86/include/asm/pgtable_32.h                  |    3 +-
 arch/x86/include/asm/pgtable_64.h                  |    1 +
 arch/x86/include/asm/pgtable_types.h               |   10 +
 arch/x86/include/asm/processor.h                   |   18 +-
 arch/x86/include/asm/refcount.h                    |    6 +-
 arch/x86/include/asm/rmwcc.h                       |   16 +-
 arch/x86/include/asm/smp.h                         |    1 +
 arch/x86/include/asm/svm.h                         |    3 +-
 arch/x86/include/asm/tlbflush.h                    |   27 +-
 arch/x86/include/uapi/asm/kvm.h                    |   19 +-
 arch/x86/include/uapi/asm/kvm_para.h               |   10 +-
 arch/x86/kernel/amd_nb.c                           |    2 +-
 arch/x86/kernel/apic/apic.c                        |    6 +-
 arch/x86/kernel/apic/io_apic.c                     |    2 +-
 arch/x86/kernel/apic/vector.c                      |   25 +-
 arch/x86/kernel/apic/x2apic_uv_x.c                 |   15 +-
 arch/x86/kernel/asm-offsets_32.c                   |    2 +-
 arch/x86/kernel/cpu/amd.c                          |   28 +-
 arch/x86/kernel/cpu/bugs.c                         |   46 +-
 arch/x86/kernel/cpu/centaur.c                      |    4 +-
 arch/x86/kernel/cpu/common.c                       |   43 +-
 arch/x86/kernel/cpu/cyrix.c                        |    2 +-
 arch/x86/kernel/cpu/intel.c                        |   31 +-
 arch/x86/kernel/cpu/intel_rdt.c                    |    2 +-
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c           |    1 +
 arch/x86/kernel/cpu/mcheck/mce-internal.h          |   15 +
 arch/x86/kernel/cpu/mcheck/mce.c                   |   19 +-
 arch/x86/kernel/cpu/microcode/amd.c                |   10 +-
 arch/x86/kernel/cpu/microcode/core.c               |   39 +-
 arch/x86/kernel/cpu/microcode/intel.c              |   16 +-
 arch/x86/kernel/cpu/mshyperv.c                     |   22 +-
 arch/x86/kernel/cpu/mtrr/generic.c                 |    2 +-
 arch/x86/kernel/cpu/mtrr/main.c                    |    4 +-
 arch/x86/kernel/cpu/proc.c                         |    8 +-
 arch/x86/kernel/head_32.S                          |    4 +-
 arch/x86/kernel/head_64.S                          |    2 +
 arch/x86/kernel/kvm.c                              |   38 +-
 arch/x86/kernel/machine_kexec_64.c                 |    1 +
 arch/x86/kernel/module.c                           |    1 +
 arch/x86/kernel/mpparse.c                          |    2 +-
 arch/x86/kernel/paravirt.c                         |    6 +-
 arch/x86/kernel/process_64.c                       |   14 +
 arch/x86/kernel/setup.c                            |   17 +-
 arch/x86/kernel/setup_percpu.c                     |   17 +-
 arch/x86/kernel/smpboot.c                          |   12 +-
 arch/x86/kernel/traps.c                            |    2 +-
 arch/x86/kernel/unwind_orc.c                       |    3 +-
 arch/x86/kvm/cpuid.c                               |   10 +-
 arch/x86/kvm/emulate.c                             |   27 +-
 arch/x86/kvm/hyperv.c                              |  192 +-
 arch/x86/kvm/hyperv.h                              |    4 +
 arch/x86/kvm/irq.c                                 |   26 +-
 arch/x86/kvm/kvm_cache_regs.h                      |    7 +-
 arch/x86/kvm/lapic.c                               |   21 +-
 arch/x86/kvm/lapic.h                               |    2 +-
 arch/x86/kvm/mmu.c                                 |   10 +-
 arch/x86/kvm/paging_tmpl.h                         |   11 +-
 arch/x86/kvm/pmu.c                                 |   37 +
 arch/x86/kvm/pmu.h                                 |    6 +
 arch/x86/kvm/pmu_amd.c                             |  142 +-
 arch/x86/kvm/svm.c                                 |  402 +++-
 arch/x86/kvm/vmx.c                                 | 1124 +++++++----
 arch/x86/kvm/vmx_evmcs.h                           |  324 +++
 arch/x86/kvm/x86.c                                 |  481 ++++-
 arch/x86/kvm/x86.h                                 |   86 +-
 arch/x86/lib/Makefile                              |    1 -
 arch/x86/lib/cpu.c                                 |    2 +-
 arch/x86/lib/error-inject.c                        |    1 +
 arch/x86/lib/retpoline.S                           |   56 -
 arch/x86/mm/cpu_entry_area.c                       |    6 +
 arch/x86/mm/fault.c                                |    4 -
 arch/x86/mm/init_32.c                              |   15 +
 arch/x86/mm/init_64.c                              |    6 +-
 arch/x86/mm/ioremap.c                              |    2 +-
 arch/x86/mm/kmmio.c                                |    2 +-
 arch/x86/mm/mem_encrypt_boot.S                     |    2 +
 arch/x86/mm/pgtable_32.c                           |    2 +-
 arch/x86/mm/tlb.c                                  |    6 +-
 arch/x86/net/bpf_jit_comp.c                        |    9 +-
 arch/x86/oprofile/nmi_int.c                        |    2 +-
 arch/x86/platform/intel-mid/intel-mid.c            |    2 +-
 arch/x86/platform/uv/tlb_uv.c                      |    2 +-
 arch/x86/realmode/rm/trampoline_64.S               |    2 +-
 arch/x86/tools/relocs.c                            |    3 +
 arch/x86/xen/enlighten_pv.c                        |    6 +-
 arch/x86/xen/mmu_pv.c                              |    6 +-
 arch/x86/xen/smp.c                                 |    2 +
 arch/x86/xen/suspend.c                             |   16 +
 arch/xtensa/kernel/pci-dma.c                       |   40 +-
 arch/xtensa/mm/init.c                              |   70 +-
 block/blk-cgroup.c                                 |   11 +-
 block/blk-core.c                                   |    2 +-
 block/blk-mq.c                                     |    5 +-
 block/genhd.c                                      |   48 +-
 block/ioctl.c                                      |    2 +-
 block/kyber-iosched.c                              |    1 +
 block/mq-deadline.c                                |   16 +-
 block/partition-generic.c                          |    6 +
 block/sed-opal.c                                   |    2 +-
 certs/blacklist_nohashes.c                         |    2 +-
 crypto/asymmetric_keys/pkcs7_trust.c               |    1 +
 crypto/asymmetric_keys/pkcs7_verify.c              |   12 +-
 crypto/asymmetric_keys/public_key.c                |    4 +-
 crypto/asymmetric_keys/restrict.c                  |   21 +-
 crypto/sha3_generic.c                              |  218 +-
 drivers/acpi/bus.c                                 |   75 +-
 drivers/acpi/ec.c                                  |    6 +
 drivers/acpi/property.c                            |    4 +-
 drivers/acpi/spcr.c                                |    1 +
 drivers/android/binder.c                           |   29 +-
 drivers/base/core.c                                |    3 +
 drivers/base/power/wakeirq.c                       |    6 +-
 drivers/base/property.c                            |    5 +-
 drivers/block/amiflop.c                            |    2 +-
 drivers/block/ataflop.c                            |    2 +-
 drivers/block/brd.c                                |    2 +-
 drivers/block/floppy.c                             |    2 +-
 drivers/block/loop.c                               |    2 +-
 drivers/block/nbd.c                                |    2 +-
 drivers/block/pktcdvd.c                            |    2 +-
 drivers/block/swim.c                               |    2 +-
 drivers/block/z2ram.c                              |    2 +-
 drivers/bus/ti-sysc.c                              |    2 +-
 drivers/char/hw_random/via-rng.c                   |    2 +-
 drivers/char/tpm/st33zp24/st33zp24.c               |    4 +-
 drivers/char/tpm/tpm-interface.c                   |    4 +
 drivers/char/tpm/tpm2-cmd.c                        |    4 +
 drivers/char/tpm/tpm_i2c_infineon.c                |    5 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c                 |    8 +-
 drivers/char/tpm/tpm_tis_core.c                    |    5 +-
 drivers/clocksource/arc_timer.c                    |   11 +-
 drivers/clocksource/fsl_ftm_timer.c                |    2 +-
 drivers/clocksource/mips-gic-timer.c               |    6 +-
 drivers/clocksource/timer-sun5i.c                  |    2 +-
 drivers/cpufreq/Kconfig.arm                        |    6 +-
 drivers/cpufreq/acpi-cpufreq.c                     |    2 +-
 drivers/cpufreq/longhaul.c                         |    6 +-
 drivers/cpufreq/p4-clockmod.c                      |    2 +-
 drivers/cpufreq/powernow-k7.c                      |    2 +-
 drivers/cpufreq/s3c24xx-cpufreq.c                  |    8 +-
 drivers/cpufreq/scpi-cpufreq.c                     |   16 +-
 drivers/cpufreq/speedstep-centrino.c               |    4 +-
 drivers/cpufreq/speedstep-lib.c                    |    6 +-
 drivers/crypto/caam/ctrl.c                         |    8 +-
 drivers/crypto/ccp/psp-dev.c                       |    8 +-
 drivers/crypto/padlock-aes.c                       |    2 +-
 drivers/crypto/s5p-sss.c                           |   12 +-
 drivers/crypto/sunxi-ss/sun4i-ss-prng.c            |    6 +-
 drivers/crypto/talitos.c                           |    4 +
 drivers/dax/super.c                                |    6 -
 drivers/edac/amd64_edac.c                          |    2 +-
 drivers/edac/sb_edac.c                             |    2 +-
 drivers/extcon/extcon-axp288.c                     |   36 +-
 drivers/extcon/extcon-intel-int3496.c              |    3 +-
 drivers/gpio/gpiolib-of.c                          |   15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |   58 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   26 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |    6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |    7 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   18 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |    2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |    4 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |    4 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |    6 +-
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      |    2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |   18 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |   11 +-
 drivers/gpu/drm/cirrus/cirrus_mode.c               |   40 +-
 drivers/gpu/drm/drm_atomic_helper.c                |   15 +
 drivers/gpu/drm/drm_edid.c                         |   21 +
 drivers/gpu/drm/drm_framebuffer.c                  |    4 +
 drivers/gpu/drm/drm_mm.c                           |   21 +-
 drivers/gpu/drm/drm_probe_helper.c                 |   20 +
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            |   12 +-
 drivers/gpu/drm/exynos/exynos_drm_rotator.h        |   19 -
 drivers/gpu/drm/exynos/exynos_hdmi.c               |    7 +-
 drivers/gpu/drm/exynos/regs-fimc.h                 |    2 +-
 drivers/gpu/drm/exynos/regs-hdmi.h                 |    2 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |   51 +-
 drivers/gpu/drm/i915/gvt/mmio_context.c            |    1 +
 drivers/gpu/drm/i915/gvt/trace.h                   |    2 +-
 drivers/gpu/drm/i915/i915_drv.c                    |   14 +-
 drivers/gpu/drm/i915/i915_drv.h                    |    2 +
 drivers/gpu/drm/i915/i915_gem_context.c            |    2 +-
 drivers/gpu/drm/i915/i915_gem_execbuffer.c         |    4 +-
 drivers/gpu/drm/i915/i915_gem_request.c            |    4 +-
 drivers/gpu/drm/i915/i915_oa_cflgt3.c              |    4 +-
 drivers/gpu/drm/i915/i915_oa_cnl.c                 |    4 +-
 drivers/gpu/drm/i915/i915_pmu.c                    |  231 ++-
 drivers/gpu/drm/i915/i915_pmu.h                    |    6 +
 drivers/gpu/drm/i915/i915_reg.h                    |    4 +-
 drivers/gpu/drm/i915/intel_audio.c                 |    6 +-
 drivers/gpu/drm/i915/intel_bios.c                  |  105 +
 drivers/gpu/drm/i915/intel_breadcrumbs.c           |   29 +-
 drivers/gpu/drm/i915/intel_cdclk.c                 |    8 +
 drivers/gpu/drm/i915/intel_engine_cs.c             |   24 +-
 drivers/gpu/drm/i915/intel_ringbuffer.h            |   14 -
 drivers/gpu/drm/meson/meson_crtc.c                 |    6 +
 drivers/gpu/drm/meson/meson_drv.h                  |    3 +
 drivers/gpu/drm/meson/meson_plane.c                |    7 +-
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c            |    2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |   18 +-
 drivers/gpu/drm/nouveau/nv50_display.c             |    1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c   |    6 +-
 drivers/gpu/drm/radeon/radeon_connectors.c         |   74 +-
 drivers/gpu/drm/radeon/radeon_device.c             |    4 +
 drivers/gpu/drm/radeon/radeon_pm.c                 |    6 +-
 drivers/gpu/drm/scheduler/gpu_scheduler.c          |    2 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |    7 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             |   17 +-
 drivers/gpu/ipu-v3/ipu-common.c                    |    4 +-
 drivers/gpu/ipu-v3/ipu-cpmem.c                     |    2 +
 drivers/gpu/ipu-v3/ipu-csi.c                       |    2 +
 drivers/gpu/ipu-v3/ipu-pre.c                       |    3 +
 drivers/gpu/ipu-v3/ipu-prg.c                       |    3 +
 drivers/hid/hid-ids.h                              |    3 +
 drivers/hid/hid-quirks.c                           |    3 +
 drivers/hv/connection.c                            |    1 -
 drivers/hv/hv.c                                    |    1 -
 drivers/hv/hyperv_vmbus.h                          |    1 +
 drivers/hv/vmbus_drv.c                             |    1 -
 drivers/hwmon/coretemp.c                           |    6 +-
 drivers/hwmon/hwmon-vid.c                          |    2 +-
 drivers/hwmon/k10temp.c                            |    7 +-
 drivers/hwmon/k8temp.c                             |    2 +-
 drivers/i2c/busses/Kconfig                         |    2 +
 drivers/i2c/busses/i2c-bcm2835.c                   |   21 +-
 drivers/i2c/busses/i2c-designware-master.c         |    4 +-
 drivers/i2c/busses/i2c-i801.c                      |    1 +
 drivers/i2c/busses/i2c-octeon-core.c               |    1 +
 drivers/i2c/busses/i2c-octeon-core.h               |    2 +-
 drivers/i2c/busses/i2c-sirf.c                      |    4 +-
 drivers/ide/ide-probe.c                            |    2 +-
 drivers/iio/adc/aspeed_adc.c                       |    7 +-
 drivers/iio/adc/stm32-adc.c                        |    7 +-
 drivers/iio/imu/adis_trigger.c                     |    7 +-
 drivers/iio/industrialio-buffer.c                  |    2 +-
 drivers/iio/proximity/Kconfig                      |    2 +
 drivers/infiniband/core/core_priv.h                |    7 +-
 drivers/infiniband/core/rdma_core.c                |   38 +-
 drivers/infiniband/core/restrack.c                 |   23 +-
 drivers/infiniband/core/uverbs_cmd.c               |   50 +-
 drivers/infiniband/core/uverbs_ioctl.c             |    3 +
 drivers/infiniband/core/uverbs_ioctl_merge.c       |   18 +-
 drivers/infiniband/core/uverbs_main.c              |   29 +-
 drivers/infiniband/core/uverbs_std_types.c         |   12 +-
 drivers/infiniband/core/verbs.c                    |    3 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h            |    2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |   54 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h           |    2 +
 drivers/infiniband/hw/bnxt_re/main.c               |   12 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |   21 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |    4 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |   14 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c       |    4 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c      |    4 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c    |    4 +-
 drivers/infiniband/ulp/ipoib/ipoib_fs.c            |    2 -
 drivers/iommu/intel-svm.c                          |    2 +-
 drivers/irqchip/irq-bcm7038-l1.c                   |    3 -
 drivers/irqchip/irq-bcm7120-l2.c                   |    3 -
 drivers/irqchip/irq-brcmstb-l2.c                   |    3 -
 drivers/irqchip/irq-gic-v2m.c                      |   46 +-
 drivers/irqchip/irq-gic-v3-its-pci-msi.c           |    2 +
 drivers/irqchip/irq-gic-v3-its-platform-msi.c      |    2 +
 drivers/irqchip/irq-gic-v3-its.c                   |    2 +
 drivers/irqchip/irq-gic-v3.c                       |    4 +-
 drivers/irqchip/irq-mips-gic.c                     |    2 -
 drivers/macintosh/macio_asic.c                     |    1 +
 drivers/md/bcache/request.c                        |    2 +-
 drivers/md/bcache/super.c                          |    2 +-
 drivers/md/dm.c                                    |    3 +-
 drivers/md/md-multipath.c                          |    2 +-
 drivers/md/md.c                                    |   53 +-
 drivers/md/md.h                                    |    2 +
 drivers/md/raid1.c                                 |   13 +-
 drivers/md/raid1.h                                 |   12 +
 drivers/md/raid10.c                                |   18 +-
 drivers/md/raid10.h                                |   13 +
 drivers/md/raid5-log.h                             |    3 +-
 drivers/md/raid5-ppl.c                             |   10 +
 drivers/md/raid5.c                                 |   19 +-
 drivers/md/raid5.h                                 |   12 +
 drivers/media/Kconfig                              |    2 +
 drivers/media/common/videobuf2/Kconfig             |    3 +
 drivers/media/common/videobuf2/Makefile            |    9 +-
 .../{v4l2-core => common/videobuf2}/vb2-trace.c    |    0
 drivers/media/dvb-core/Makefile                    |    2 +-
 drivers/media/dvb-core/dmxdev.c                    |  115 +-
 drivers/media/dvb-core/dvb_demux.c                 |  112 +-
 drivers/media/dvb-core/dvb_net.c                   |    5 +-
 drivers/media/dvb-core/dvb_vb2.c                   |   31 +-
 drivers/media/dvb-frontends/m88ds3103.c            |    7 +-
 drivers/media/i2c/tvp5150.c                        |   88 +-
 drivers/media/pci/ttpci/av7110.c                   |    5 +-
 drivers/media/pci/ttpci/av7110_av.c                |    6 +-
 drivers/media/usb/au0828/Kconfig                   |    2 +-
 drivers/media/usb/ttusb-dec/ttusb_dec.c            |   10 +-
 drivers/media/v4l2-core/Kconfig                    |    1 +
 drivers/media/v4l2-core/Makefile                   |    3 +-
 drivers/memory/brcmstb_dpfe.c                      |   74 +-
 drivers/message/fusion/mptctl.c                    |    2 +
 drivers/misc/mei/bus.c                             |    6 -
 drivers/misc/mei/client.c                          |    6 +
 drivers/misc/mei/hw-me-regs.h                      |    5 +
 drivers/misc/mei/pci-me.c                          |    5 +
 drivers/misc/ocxl/file.c                           |    8 +-
 drivers/mmc/core/mmc_ops.c                         |    4 -
 drivers/mmc/host/bcm2835.c                         |    3 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |    1 +
 drivers/mmc/host/dw_mmc-k3.c                       |    4 +
 drivers/mmc/host/dw_mmc-rockchip.c                 |    1 +
 drivers/mmc/host/dw_mmc-zx.c                       |    1 +
 drivers/mmc/host/dw_mmc.c                          |   84 +-
 drivers/mmc/host/dw_mmc.h                          |    2 +
 drivers/mmc/host/meson-gx-mmc.c                    |   19 +-
 drivers/mmc/host/sdhci-pci-core.c                  |   35 +-
 drivers/mtd/nand/Kconfig                           |    2 +-
 drivers/mtd/nand/vf610_nfc.c                       |    6 +-
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c           |    2 +
 .../net/ethernet/aquantia/atlantic/aq_pci_func.c   |   14 +-
 drivers/net/ethernet/broadcom/tg3.c                |   35 +-
 drivers/net/ethernet/broadcom/tg3.h                |    5 +
 drivers/net/ethernet/cavium/common/cavium_ptp.c    |    2 +
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |  110 +-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |   11 +-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.h |    4 -
 drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c     |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c   |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |   25 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c         |   10 -
 drivers/net/ethernet/freescale/gianfar.c           |   23 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |   59 +-
 drivers/net/ethernet/marvell/mvpp2.c               |   11 +-
 .../mellanox/mlx5/core/diag/fs_tracepoint.c        |    8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   14 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |   49 +-
 .../net/ethernet/mellanox/mlx5/core/en_selftest.c  |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |    8 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   13 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |    2 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |   35 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c |   68 +-
 .../ethernet/qualcomm/rmnet/rmnet_map_command.c    |    5 +
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c    |    2 +-
 drivers/net/ethernet/renesas/ravb_main.c           |    6 -
 drivers/net/ethernet/renesas/sh_eth.c              |   18 +-
 drivers/net/ethernet/smsc/Kconfig                  |    2 +-
 drivers/net/macvlan.c                              |    2 +-
 drivers/net/phy/phy_device.c                       |    2 +-
 drivers/net/thunderbolt.c                          |   19 +-
 drivers/net/tun.c                                  |   16 +-
 drivers/net/usb/smsc75xx.c                         |    7 +-
 drivers/net/virtio_net.c                           |   58 +-
 drivers/net/wireless/mac80211_hwsim.c              |    2 +-
 drivers/net/xen-netfront.c                         |    7 +-
 drivers/nvdimm/pmem.c                              |    3 +-
 drivers/nvme/host/core.c                           |   57 +-
 drivers/nvme/host/fabrics.c                        |    2 +-
 drivers/nvme/host/fabrics.h                        |    9 +-
 drivers/nvme/host/fc.c                             |  157 +-
 drivers/nvme/host/multipath.c                      |   15 +-
 drivers/nvme/host/nvme.h                           |    3 +-
 drivers/nvme/host/pci.c                            |   44 +-
 drivers/nvme/host/rdma.c                           |   20 +-
 drivers/nvme/target/core.c                         |    9 +-
 drivers/nvme/target/io-cmd.c                       |    7 +-
 drivers/nvme/target/loop.c                         |    4 +-
 drivers/of/property.c                              |    4 +-
 drivers/opp/cpu.c                                  |    2 +-
 drivers/pci/quirks.c                               |   39 +-
 drivers/pci/setup-res.c                            |    4 +
 drivers/perf/arm_pmu.c                             |  138 +-
 drivers/perf/arm_pmu_acpi.c                        |   61 +-
 drivers/perf/arm_pmu_platform.c                    |   37 +-
 drivers/pinctrl/meson/pinctrl-meson-axg.c          |    4 +-
 drivers/platform/x86/dell-laptop.c                 |   20 +-
 drivers/platform/x86/ideapad-laptop.c              |    2 +-
 drivers/platform/x86/intel-hid.c                   |    1 +
 drivers/platform/x86/intel-vbtn.c                  |   47 +-
 drivers/platform/x86/wmi.c                         |    8 +-
 drivers/s390/char/defkeymap.c                      |   66 +-
 drivers/s390/char/keyboard.c                       |   32 +-
 drivers/s390/char/keyboard.h                       |   11 +
 drivers/s390/virtio/virtio_ccw.c                   |   29 +
 drivers/scsi/Makefile                              |    1 -
 drivers/scsi/aacraid/linit.c                       |    4 +-
 drivers/scsi/aic7xxx/aiclib.c                      |   34 -
 drivers/scsi/bnx2fc/bnx2fc_io.c                    |    1 +
 drivers/scsi/csiostor/csio_lnode.c                 |    2 +-
 drivers/scsi/device_handler/scsi_dh_alua.c         |    5 +
 drivers/scsi/ibmvscsi/ibmvfc.h                     |    2 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c                |    5 +-
 drivers/scsi/qedi/qedi_main.c                      |   55 +-
 drivers/scsi/qla2xxx/qla_init.c                    |   23 +-
 drivers/scsi/qla2xxx/qla_iocb.c                    |    7 +-
 drivers/scsi/qla2xxx/qla_isr.c                     |    6 +-
 drivers/scsi/qla2xxx/qla_os.c                      |    2 +
 drivers/scsi/qla2xxx/qla_target.c                  |    2 -
 drivers/scsi/qla4xxx/ql4_def.h                     |    2 +
 drivers/scsi/qla4xxx/ql4_os.c                      |   46 +
 drivers/scsi/storvsc_drv.c                         |    2 +-
 drivers/scsi/sym53c8xx_2/sym_hipd.c                |    2 +-
 drivers/scsi/ufs/ufshcd.c                          |    2 +
 drivers/soc/imx/gpc.c                              |   12 +-
 drivers/staging/android/ashmem.c                   |   19 +-
 drivers/staging/android/ion/ion_cma_heap.c         |   17 +
 drivers/staging/fsl-mc/bus/Kconfig                 |    2 +-
 .../staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c |    2 +
 drivers/staging/iio/adc/ad7192.c                   |   27 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    4 +-
 drivers/tty/Kconfig                                |    2 +-
 drivers/usb/Kconfig                                |    6 +
 drivers/usb/class/cdc-acm.c                        |    9 +-
 drivers/usb/core/quirks.c                          |    3 +
 drivers/usb/dwc2/gadget.c                          |   26 +-
 drivers/usb/dwc3/core.c                            |   86 +-
 drivers/usb/dwc3/core.h                            |   21 +-
 drivers/usb/dwc3/dwc3-of-simple.c                  |    1 +
 drivers/usb/dwc3/dwc3-omap.c                       |   16 +
 drivers/usb/dwc3/ep0.c                             |    7 +-
 drivers/usb/dwc3/gadget.c                          |    2 +
 drivers/usb/gadget/function/f_fs.c                 |   44 +-
 drivers/usb/gadget/function/f_uac2.c               |    2 +
 drivers/usb/gadget/udc/Kconfig                     |    1 -
 drivers/usb/gadget/udc/bdc/bdc_pci.c               |    1 +
 drivers/usb/gadget/udc/core.c                      |    2 +-
 drivers/usb/gadget/udc/fsl_udc_core.c              |    4 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |    2 +-
 drivers/usb/host/Kconfig                           |    8 -
 drivers/usb/host/ehci-hub.c                        |    4 +-
 drivers/usb/host/ehci-q.c                          |   12 +-
 drivers/usb/host/ohci-hcd.c                        |   10 +-
 drivers/usb/host/ohci-hub.c                        |    4 +-
 drivers/usb/host/ohci-q.c                          |   17 +-
 drivers/usb/host/pci-quirks.c                      |  109 +
 drivers/usb/host/pci-quirks.h                      |    5 +
 drivers/usb/host/xhci-debugfs.c                    |    4 +-
 drivers/usb/host/xhci-hub.c                        |   25 +-
 drivers/usb/host/xhci-pci.c                        |   11 +
 drivers/usb/host/xhci.c                            |   10 +-
 drivers/usb/host/xhci.h                            |    2 +-
 drivers/usb/misc/ldusb.c                           |    6 +
 drivers/usb/musb/musb_core.c                       |    3 +-
 drivers/usb/musb/musb_host.c                       |    8 +-
 drivers/usb/phy/phy-mxs-usb.c                      |    3 +
 drivers/usb/renesas_usbhs/fifo.c                   |    5 +
 drivers/usb/serial/option.c                        |    7 +
 drivers/usb/usbip/stub_dev.c                       |    3 +
 drivers/usb/usbip/vhci_hcd.c                       |    2 +
 drivers/vfio/vfio_iommu_type1.c                    |   18 +-
 drivers/video/Kconfig                              |    5 +-
 drivers/video/console/Kconfig                      |    6 +-
 drivers/video/fbdev/geode/video_gx.c               |    2 +-
 drivers/watchdog/Kconfig                           |    4 +
 drivers/xen/events/events_base.c                   |    4 +-
 drivers/xen/pvcalls-back.c                         |    2 +-
 drivers/xen/pvcalls-front.c                        |  208 +-
 drivers/xen/tmem.c                                 |    4 +
 drivers/xen/xenbus/xenbus.h                        |    1 +
 drivers/xen/xenbus/xenbus_comms.c                  |    1 +
 drivers/xen/xenbus/xenbus_xs.c                     |    3 +
 fs/block_dev.c                                     |   49 +-
 fs/btrfs/backref.c                                 |   11 +-
 fs/btrfs/ctree.h                                   |    7 +-
 fs/btrfs/delayed-ref.c                             |    3 +-
 fs/btrfs/extent-tree.c                             |    4 +
 fs/btrfs/inode-item.c                              |   44 +-
 fs/btrfs/inode.c                                   |   52 +-
 fs/btrfs/qgroup.c                                  |    9 +-
 fs/btrfs/relocation.c                              |   18 +-
 fs/btrfs/send.c                                    |    3 +
 fs/btrfs/super.c                                   |    2 +-
 fs/btrfs/sysfs.c                                   |    8 +-
 fs/btrfs/transaction.c                             |   20 +-
 fs/btrfs/tree-log.c                                |  146 +-
 fs/btrfs/volumes.c                                 |   12 +-
 fs/ceph/caps.c                                     |   26 +
 fs/ceph/dir.c                                      |   28 +-
 fs/ceph/super.c                                    |   27 +-
 fs/ceph/super.h                                    |    2 +-
 fs/direct-io.c                                     |    3 +-
 fs/efivarfs/file.c                                 |    6 +
 fs/gfs2/bmap.c                                     |   43 +-
 fs/nfs/callback_proc.c                             |   14 +-
 fs/nfs/nfs3proc.c                                  |    2 +-
 fs/nfs/nfs4client.c                                |    6 +-
 fs/proc/kcore.c                                    |    4 +
 fs/signalfd.c                                      |   15 +-
 fs/xfs/scrub/agheader.c                            |    3 +-
 fs/xfs/xfs_refcount_item.c                         |    9 +-
 fs/xfs/xfs_rmap_item.c                             |    4 +-
 fs/xfs/xfs_super.c                                 |    2 +
 include/asm-generic/bitops/lock.h                  |    3 +-
 include/asm-generic/bug.h                          |    1 +
 include/asm-generic/kvm_para.h                     |    5 +
 include/drm/drm_atomic.h                           |    9 +
 include/drm/drm_crtc_helper.h                      |    1 +
 include/drm/drm_drv.h                              |    1 +
 include/kvm/arm_vgic.h                             |   14 +-
 include/linux/acpi.h                               |    4 +-
 include/linux/bio.h                                |    4 +-
 include/linux/blkdev.h                             |    2 +-
 include/linux/compiler-clang.h                     |    5 +
 include/linux/compiler-gcc.h                       |   26 +-
 include/linux/compiler.h                           |    9 +
 include/linux/cpuidle.h                            |    2 +-
 include/linux/cpumask.h                            |    2 +
 include/linux/dma-mapping.h                        |    2 +-
 include/linux/fs.h                                 |    2 +-
 include/linux/fwnode.h                             |    4 +-
 include/linux/genhd.h                              |    4 +-
 include/linux/hyperv.h                             |    1 -
 include/linux/init.h                               |    8 +-
 include/linux/jump_label.h                         |    3 +
 include/linux/kconfig.h                            |    9 +
 include/linux/kcore.h                              |    1 +
 include/linux/kernel.h                             |    1 +
 include/linux/kvm_host.h                           |    6 +-
 include/linux/kvm_para.h                           |    5 +
 include/linux/memcontrol.h                         |   24 +-
 include/linux/mm_inline.h                          |    6 -
 include/linux/mutex.h                              |    5 +
 include/linux/nospec.h                             |   18 +-
 include/linux/perf/arm_pmu.h                       |   26 +-
 include/linux/property.h                           |    2 +-
 include/linux/ptr_ring.h                           |    2 +-
 include/linux/sched/mm.h                           |   13 +-
 include/linux/sched/user.h                         |    4 +
 include/linux/semaphore.h                          |    2 +-
 include/linux/skbuff.h                             |    2 +-
 include/linux/swap.h                               |    2 -
 include/linux/workqueue.h                          |    1 +
 include/media/demux.h                              |   21 +-
 include/media/dmxdev.h                             |    2 +
 include/media/dvb_demux.h                          |    4 +
 include/media/dvb_vb2.h                            |   20 +-
 include/net/mac80211.h                             |    2 +-
 include/net/regulatory.h                           |    2 +-
 include/net/udplite.h                              |    1 +
 include/rdma/restrack.h                            |    4 -
 include/rdma/uverbs_ioctl.h                        |   43 +-
 include/soc/arc/mcip.h                             |    5 +
 include/sound/ac97/regs.h                          |    2 +-
 include/trace/events/xen.h                         |    2 +-
 include/uapi/drm/virtgpu_drm.h                     |    1 +
 include/uapi/linux/blktrace_api.h                  |    2 +-
 include/uapi/linux/dvb/dmx.h                       |   35 +
 include/uapi/linux/if_ether.h                      |    6 +-
 include/uapi/linux/kvm.h                           |   25 +-
 include/uapi/linux/libc-compat.h                   |    6 -
 include/uapi/linux/psp-sev.h                       |    2 +-
 include/uapi/linux/ptrace.h                        |    4 +-
 include/uapi/rdma/rdma_user_ioctl.h                |    4 +-
 init/main.c                                        |    2 +
 kernel/bpf/arraymap.c                              |   33 +-
 kernel/bpf/core.c                                  |    2 +-
 kernel/bpf/cpumap.c                                |    2 +-
 kernel/bpf/lpm_trie.c                              |   14 +-
 kernel/bpf/sockmap.c                               |    3 +-
 kernel/extable.c                                   |    2 +-
 kernel/fork.c                                      |   15 +-
 kernel/irq/irqdomain.c                             |   18 +-
 kernel/irq/matrix.c                                |   23 +-
 kernel/jump_label.c                                |   27 +-
 kernel/kprobes.c                                   |  178 +-
 kernel/locking/qspinlock.c                         |   21 +-
 kernel/memremap.c                                  |   15 +-
 kernel/printk/printk.c                             |    3 +-
 kernel/relay.c                                     |    2 +-
 kernel/sched/core.c                                |   27 +-
 kernel/sched/cpufreq_schedutil.c                   |    2 -
 kernel/sched/deadline.c                            |    6 +-
 kernel/sched/rt.c                                  |    3 +-
 kernel/seccomp.c                                   |    6 +-
 kernel/time/timer.c                                |    6 +
 kernel/trace/bpf_trace.c                           |    2 +
 kernel/user.c                                      |    3 +
 kernel/workqueue.c                                 |   16 +
 lib/Kconfig.debug                                  |    1 +
 lib/dma-debug.c                                    |   10 +-
 lib/dma-direct.c                                   |    5 +
 lib/idr.c                                          |   15 +-
 lib/radix-tree.c                                   |    2 +-
 lib/vsprintf.c                                     |    2 +-
 mm/memory-failure.c                                |    2 -
 mm/memory.c                                        |    2 +-
 mm/mlock.c                                         |    6 +
 mm/page_alloc.c                                    |    4 +
 mm/swap.c                                          |   84 +-
 mm/vmalloc.c                                       |   10 +-
 mm/vmscan.c                                        |   59 +-
 mm/zpool.c                                         |    2 +-
 mm/zswap.c                                         |    6 +
 net/9p/trans_virtio.c                              |    3 +-
 net/bridge/br_sysfs_if.c                           |    3 +
 net/bridge/netfilter/ebt_among.c                   |   10 +-
 net/bridge/netfilter/ebt_limit.c                   |    4 +-
 net/ceph/ceph_common.c                             |    7 +
 net/core/dev.c                                     |   11 +-
 net/core/filter.c                                  |    6 +-
 net/core/gen_estimator.c                           |    1 +
 net/decnet/af_decnet.c                             |   62 +-
 net/ipv4/fib_semantics.c                           |    5 +
 net/ipv4/ip_sockglue.c                             |    7 +-
 net/ipv4/netfilter/arp_tables.c                    |    4 +
 net/ipv4/netfilter/ip_tables.c                     |    7 +-
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |   20 +-
 net/ipv4/netfilter/ipt_ECN.c                       |   12 +-
 net/ipv4/netfilter/ipt_REJECT.c                    |    4 +-
 net/ipv4/netfilter/ipt_rpfilter.c                  |    6 +-
 net/ipv4/route.c                                   |    2 +
 net/ipv4/tcp_output.c                              |   34 +-
 net/ipv4/udp.c                                     |    5 +
 net/ipv6/ip6_checksum.c                            |    5 +
 net/ipv6/ipv6_sockglue.c                           |   10 +-
 net/ipv6/netfilter/ip6_tables.c                    |    4 +
 net/ipv6/netfilter/ip6t_REJECT.c                   |    4 +-
 net/ipv6/netfilter/ip6t_rpfilter.c                 |    6 +-
 net/ipv6/netfilter/ip6t_srh.c                      |    6 +-
 net/ipv6/sit.c                                     |    2 +-
 net/mac80211/agg-rx.c                              |    4 +-
 net/mac80211/cfg.c                                 |    2 +-
 net/mac80211/ieee80211_i.h                         |    2 +-
 net/mac80211/mesh.c                                |   17 +-
 net/mac80211/spectmgmt.c                           |    7 +-
 net/mac80211/sta_info.c                            |    3 +-
 net/netfilter/nf_nat_proto_common.c                |    7 +-
 net/netfilter/x_tables.c                           |   74 +-
 net/netfilter/xt_AUDIT.c                           |    4 +-
 net/netfilter/xt_CHECKSUM.c                        |    8 +-
 net/netfilter/xt_CONNSECMARK.c                     |   10 +-
 net/netfilter/xt_CT.c                              |   25 +-
 net/netfilter/xt_DSCP.c                            |    4 +-
 net/netfilter/xt_HL.c                              |   13 +-
 net/netfilter/xt_HMARK.c                           |   27 +-
 net/netfilter/xt_IDLETIMER.c                       |    9 +-
 net/netfilter/xt_LED.c                             |   16 +-
 net/netfilter/xt_NFQUEUE.c                         |    8 +-
 net/netfilter/xt_SECMARK.c                         |   18 +-
 net/netfilter/xt_TCPMSS.c                          |   10 +-
 net/netfilter/xt_TPROXY.c                          |    6 +-
 net/netfilter/xt_addrtype.c                        |   33 +-
 net/netfilter/xt_bpf.c                             |    4 +-
 net/netfilter/xt_cgroup.c                          |    8 +-
 net/netfilter/xt_cluster.c                         |    8 +-
 net/netfilter/xt_connbytes.c                       |    4 +-
 net/netfilter/xt_connlabel.c                       |    7 +-
 net/netfilter/xt_connmark.c                        |    8 +-
 net/netfilter/xt_conntrack.c                       |    4 +-
 net/netfilter/xt_dscp.c                            |    4 +-
 net/netfilter/xt_ecn.c                             |    4 +-
 net/netfilter/xt_hashlimit.c                       |   26 +-
 net/netfilter/xt_helper.c                          |    4 +-
 net/netfilter/xt_ipcomp.c                          |    2 +-
 net/netfilter/xt_ipvs.c                            |    3 +-
 net/netfilter/xt_l2tp.c                            |   22 +-
 net/netfilter/xt_limit.c                           |    4 +-
 net/netfilter/xt_nat.c                             |    5 +-
 net/netfilter/xt_nfacct.c                          |    6 +-
 net/netfilter/xt_physdev.c                         |    4 +-
 net/netfilter/xt_policy.c                          |   23 +-
 net/netfilter/xt_recent.c                          |   14 +-
 net/netfilter/xt_set.c                             |   50 +-
 net/netfilter/xt_socket.c                          |   10 +-
 net/netfilter/xt_state.c                           |    4 +-
 net/netfilter/xt_time.c                            |    6 +-
 net/netlink/af_netlink.c                           |    4 +-
 net/nfc/llcp_commands.c                            |    4 +
 net/nfc/netlink.c                                  |    3 +-
 net/rds/connection.c                               |    2 +-
 net/rxrpc/output.c                                 |    2 +-
 net/rxrpc/recvmsg.c                                |    5 +-
 net/sched/cls_api.c                                |   33 +-
 net/sched/cls_u32.c                                |   24 +-
 net/sctp/debug.c                                   |    6 +
 net/sctp/input.c                                   |    5 +-
 net/sctp/stream.c                                  |    2 +-
 net/sctp/stream_interleave.c                       |   16 +-
 net/tipc/bearer.c                                  |   82 +-
 net/tipc/bearer.h                                  |    4 +
 net/tipc/net.c                                     |   15 +-
 net/tipc/net.h                                     |    1 +
 net/tipc/netlink_compat.c                          |   43 +-
 net/tls/tls_main.c                                 |    7 +-
 net/unix/af_unix.c                                 |    2 +-
 net/wireless/mesh.c                                |   25 +-
 net/wireless/sme.c                                 |    2 +
 samples/seccomp/Makefile                           |   10 +-
 scripts/Makefile.build                             |    8 +
 scripts/coccinelle/api/memdup.cocci                |    4 +-
 scripts/kallsyms.c                                 |    2 +-
 scripts/kconfig/confdata.c                         |    2 +-
 scripts/kconfig/kxgettext.c                        |    2 +-
 scripts/kconfig/lkc.h                              |    1 +
 scripts/kconfig/lxdialog/check-lxdialog.sh         |    3 +-
 scripts/kconfig/menu.c                             |    1 +
 scripts/kconfig/symbol.c                           |    4 +-
 scripts/kconfig/util.c                             |   11 +
 scripts/kconfig/zconf.l                            |   12 +-
 scripts/kconfig/zconf.y                            |    3 +-
 scripts/link-vmlinux.sh                            |    2 +-
 security/integrity/digsig.c                        |    1 +
 security/keys/big_key.c                            |  110 +-
 sound/ac97/Kconfig                                 |    1 -
 sound/core/control.c                               |    2 +-
 sound/core/seq/seq_clientmgr.c                     |    8 +-
 sound/pci/hda/hda_intel.c                          |   38 +-
 sound/pci/hda/patch_realtek.c                      |   73 +
 sound/usb/mixer.c                                  |   18 +-
 sound/usb/pcm.c                                    |    9 +
 sound/usb/quirks-table.h                           |   47 +
 sound/usb/quirks.c                                 |    7 +-
 sound/x86/intel_hdmi_audio.c                       |   37 +-
 tools/arch/powerpc/include/uapi/asm/kvm.h          |    2 +
 tools/arch/s390/include/uapi/asm/unistd.h          |  412 ----
 tools/arch/x86/include/asm/cpufeatures.h           |    1 +
 tools/bpf/bpftool/main.c                           |    2 +-
 tools/bpf/bpftool/prog.c                           |    3 +
 tools/cgroup/Makefile                              |    1 -
 tools/gpio/Makefile                                |    2 -
 tools/hv/Makefile                                  |    1 -
 tools/iio/Makefile                                 |    2 -
 tools/include/uapi/drm/i915_drm.h                  |   77 +
 tools/include/uapi/linux/if_link.h                 |    1 +
 tools/include/uapi/linux/kvm.h                     |   92 +-
 tools/kvm/kvm_stat/kvm_stat                        |  502 +++--
 tools/kvm/kvm_stat/kvm_stat.txt                    |    4 +-
 tools/laptop/freefall/Makefile                     |    1 -
 tools/leds/Makefile                                |    1 -
 tools/lib/bpf/libbpf.c                             |    5 +-
 tools/objtool/builtin-check.c                      |    6 +-
 tools/objtool/builtin-orc.c                        |    6 +-
 tools/objtool/builtin.h                            |    5 +
 tools/objtool/check.c                              |  159 +-
 tools/objtool/check.h                              |    4 +-
 tools/perf/Documentation/perf-data.txt             |    4 +
 tools/perf/Makefile.perf                           |    6 -
 tools/perf/arch/s390/Makefile                      |   10 +-
 tools/perf/arch/s390/entry/syscalls/mksyscalltbl   |   18 +-
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |  390 ++++
 tools/perf/builtin-c2c.c                           |    4 +-
 tools/perf/builtin-report.c                        |    3 +-
 tools/perf/builtin-top.c                           |  150 +-
 tools/perf/check-headers.sh                        |    1 -
 .../pmu-events/arch/arm64/cortex-a53/branch.json   |   27 +
 .../perf/pmu-events/arch/arm64/cortex-a53/bus.json |   22 +
 .../pmu-events/arch/arm64/cortex-a53/cache.json    |   27 +
 .../pmu-events/arch/arm64/cortex-a53/memory.json   |   22 +
 .../pmu-events/arch/arm64/cortex-a53/other.json    |   32 +
 .../pmu-events/arch/arm64/cortex-a53/pipeline.json |   52 +
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |    1 +
 tools/perf/tests/backward-ring-buffer.c            |    7 +-
 .../perf/tests/shell/trace+probe_libc_inet_pton.sh |   23 +-
 tools/perf/ui/browsers/hists.c                     |   38 +-
 tools/perf/ui/browsers/hists.h                     |    3 +-
 tools/perf/util/evlist.c                           |   17 -
 tools/perf/util/evlist.h                           |    4 -
 tools/perf/util/evsel.c                            |   12 +-
 tools/perf/util/evsel.h                            |   14 +
 tools/perf/util/hist.h                             |    6 +-
 tools/perf/util/mmap.c                             |  141 +-
 tools/perf/util/mmap.h                             |   10 +-
 tools/perf/util/util.c                             |   24 +-
 tools/power/acpi/Makefile.config                   |    3 -
 tools/scripts/Makefile.include                     |   18 +
 tools/spi/Makefile                                 |    2 -
 tools/testing/radix-tree/idr-test.c                |   52 +
 tools/testing/radix-tree/linux.c                   |   11 +-
 tools/testing/radix-tree/linux/compiler_types.h    |    0
 tools/testing/radix-tree/linux/gfp.h               |    1 +
 tools/testing/radix-tree/linux/slab.h              |    6 +
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/android/Makefile           |    8 +-
 tools/testing/selftests/bpf/.gitignore             |    1 +
 tools/testing/selftests/bpf/test_maps.c            |    2 +
 tools/testing/selftests/bpf/test_tcpbpf_kern.c     |    1 -
 tools/testing/selftests/bpf/test_verifier.c        |   26 +
 tools/testing/selftests/futex/Makefile             |    6 +-
 tools/testing/selftests/kvm/Makefile               |   39 +
 tools/testing/selftests/kvm/include/kvm_util.h     |  142 ++
 tools/testing/selftests/kvm/include/sparsebit.h    |   75 +
 tools/testing/selftests/kvm/include/test_util.h    |   45 +
 tools/testing/selftests/kvm/include/x86.h          | 1043 ++++++++++
 tools/testing/selftests/kvm/lib/assert.c           |   87 +
 tools/testing/selftests/kvm/lib/elf.c              |  197 ++
 tools/testing/selftests/kvm/lib/io.c               |  158 ++
 tools/testing/selftests/kvm/lib/kvm_util.c         | 1480 ++++++++++++++
 .../testing/selftests/kvm/lib/kvm_util_internal.h  |   67 +
 tools/testing/selftests/kvm/lib/sparsebit.c        | 2087 ++++++++++++++++++++
 tools/testing/selftests/kvm/lib/x86.c              |  700 +++++++
 tools/testing/selftests/kvm/set_sregs_test.c       |   54 +
 tools/testing/selftests/kvm/sync_regs_test.c       |  232 +++
 tools/testing/selftests/memfd/Makefile             |    1 +
 tools/testing/selftests/memfd/config               |    1 +
 tools/testing/selftests/memory-hotplug/Makefile    |    2 +-
 .../powerpc/alignment/alignment_handler.c          |    2 +-
 tools/testing/selftests/pstore/config              |    1 +
 tools/testing/selftests/seccomp/seccomp_bpf.c      |   61 +
 tools/testing/selftests/sync/Makefile              |    2 +-
 tools/testing/selftests/vDSO/Makefile              |   14 +-
 tools/testing/selftests/vm/.gitignore              |    1 +
 tools/testing/selftests/x86/Makefile               |   24 +-
 tools/testing/selftests/x86/mpx-mini-test.c        |   32 +-
 tools/testing/selftests/x86/protection_keys.c      |   28 -
 tools/testing/selftests/x86/single_step_syscall.c  |    5 +-
 tools/testing/selftests/x86/test_mremap_vdso.c     |    4 +
 tools/testing/selftests/x86/test_vdso.c            |   55 +-
 tools/testing/selftests/x86/test_vsyscall.c        |   11 +-
 tools/usb/Makefile                                 |    1 -
 tools/vm/Makefile                                  |    1 -
 tools/wmi/Makefile                                 |    1 -
 virt/kvm/arm/aarch32.c                             |    2 +-
 virt/kvm/arm/arch_timer.c                          |   10 +-
 virt/kvm/arm/arm.c                                 |   48 +-
 virt/kvm/arm/hyp/timer-sr.c                        |   44 +-
 virt/kvm/arm/hyp/vgic-v2-sr.c                      |  159 --
 virt/kvm/arm/hyp/vgic-v3-sr.c                      |  247 ++-
 virt/kvm/arm/mmu.c                                 |  176 +-
 virt/kvm/arm/pmu.c                                 |   36 +-
 virt/kvm/arm/vgic/vgic-init.c                      |   17 -
 virt/kvm/arm/vgic/vgic-its.c                       |   15 +-
 virt/kvm/arm/vgic/vgic-v2.c                        |  152 +-
 virt/kvm/arm/vgic/vgic-v3.c                        |   66 +-
 virt/kvm/arm/vgic/vgic.c                           |   33 +
 virt/kvm/arm/vgic/vgic.h                           |    3 +
 virt/kvm/kvm_main.c                                |   39 +-
 1123 files changed, 22259 insertions(+), 7941 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-dock
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dptf
 rename Documentation/devicetree/bindings/{misc => auxdisplay}/arm-charlcd.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/power/mti,mips-cpc.txt
 create mode 100644 Documentation/features/sched/membarrier-sync-core/arch-support.txt
 create mode 100644 arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c
 create mode 100644 arch/arm64/kvm/va_layout.c
 rename arch/x86/include/{uapi/asm/hyperv.h => asm/hyperv-tlfs.h} (63%)
 create mode 100644 arch/x86/kvm/vmx_evmcs.h
 delete mode 100644 drivers/gpu/drm/exynos/exynos_drm_rotator.h
 rename drivers/media/{v4l2-core => common/videobuf2}/vb2-trace.c (100%)
 delete mode 100644 drivers/scsi/aic7xxx/aiclib.c
 delete mode 100644 tools/arch/s390/include/uapi/asm/unistd.h
 create mode 100644 tools/perf/arch/s390/entry/syscalls/syscall.tbl
 create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/other.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/pipeline.json
 create mode 100644 tools/testing/radix-tree/linux/compiler_types.h
 create mode 100644 tools/testing/selftests/kvm/Makefile
 create mode 100644 tools/testing/selftests/kvm/include/kvm_util.h
 create mode 100644 tools/testing/selftests/kvm/include/sparsebit.h
 create mode 100644 tools/testing/selftests/kvm/include/test_util.h
 create mode 100644 tools/testing/selftests/kvm/include/x86.h
 create mode 100644 tools/testing/selftests/kvm/lib/assert.c
 create mode 100644 tools/testing/selftests/kvm/lib/elf.c
 create mode 100644 tools/testing/selftests/kvm/lib/io.c
 create mode 100644 tools/testing/selftests/kvm/lib/kvm_util.c
 create mode 100644 tools/testing/selftests/kvm/lib/kvm_util_internal.h
 create mode 100644 tools/testing/selftests/kvm/lib/sparsebit.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86.c
 create mode 100644 tools/testing/selftests/kvm/set_sregs_test.c
 create mode 100644 tools/testing/selftests/kvm/sync_regs_test.c
 create mode 100644 tools/testing/selftests/memfd/config
 delete mode 100644 virt/kvm/arm/hyp/vgic-v2-sr.c
