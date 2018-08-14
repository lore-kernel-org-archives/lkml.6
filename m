Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820A5C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE5321732
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE5321732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388959AbeHNUQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:16:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52644 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387976AbeHNUQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:16:35 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A8386C5C;
        Tue, 14 Aug 2018 17:28:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.17 00/97] 4.17.15-stable review
Date:   Tue, 14 Aug 2018 19:16:12 +0200
Message-Id: <20180814171433.160434170@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.15-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.17.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.17.15-rc1
X-KernelTest-Deadline: 2018-08-16T17:14+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.17.15 release.
There are 97 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Aug 16 17:14:15 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.15-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.17.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.17.15-rc1

Josh Poimboeuf <jpoimboe@redhat.com>
    x86/microcode: Allow late microcode loading with SMT disabled

David Woodhouse <dwmw@amazon.co.uk>
    tools headers: Synchronise x86 cpufeatures.h for L1TF additions

Arnaldo Carvalho de Melo <acme@redhat.com>
    tools headers: Synchronize prctl.h ABI header

Andi Kleen <ak@linux.intel.com>
    x86/mm/kmmio: Make the tracer robust against L1TF

Andi Kleen <ak@linux.intel.com>
    x86/mm/pat: Make set_memory_np() L1TF safe

Andi Kleen <ak@linux.intel.com>
    x86/speculation/l1tf: Make pmd/pud_mknotpresent() invert

Andi Kleen <ak@linux.intel.com>
    x86/speculation/l1tf: Invert all not present mappings

Thomas Gleixner <tglx@linutronix.de>
    cpu/hotplug: Fix SMT supported evaluation

Paolo Bonzini <pbonzini@redhat.com>
    KVM: VMX: Tell the nested hypervisor to skip L1D flush on vmentry

Paolo Bonzini <pbonzini@redhat.com>
    x86/speculation: Use ARCH_CAPABILITIES to skip L1D flush on vmentry

Paolo Bonzini <pbonzini@redhat.com>
    x86/speculation: Simplify sysfs report of VMX L1TF vulnerability

Thomas Gleixner <tglx@linutronix.de>
    Documentation/l1tf: Remove Yonah processors from not vulnerable list

Nicolai Stange <nstange@suse.de>
    x86/KVM/VMX: Don't set l1tf_flush_l1d from vmx_handle_external_intr()

Nicolai Stange <nstange@suse.de>
    x86/irq: Let interrupt handlers set kvm_cpu_l1tf_flush_l1d

Nicolai Stange <nstange@suse.de>
    x86: Don't include linux/irq.h from asm/hardirq.h

Nicolai Stange <nstange@suse.de>
    x86/KVM/VMX: Introduce per-host-cpu analogue of l1tf_flush_l1d

Nicolai Stange <nstange@suse.de>
    x86/irq: Demote irq_cpustat_t::__softirq_pending to u16

Nicolai Stange <nstange@suse.de>
    x86/KVM/VMX: Move the l1tf_flush_l1d test to vmx_l1d_flush()

Nicolai Stange <nstange@suse.de>
    x86/KVM/VMX: Replace 'vmx_l1d_flush_always' with 'vmx_l1d_flush_cond'

Nicolai Stange <nstange@suse.de>
    x86/KVM/VMX: Don't set l1tf_flush_l1d to true from vmx_l1d_flush()

Josh Poimboeuf <jpoimboe@redhat.com>
    cpu/hotplug: detect SMT disabled by BIOS

Tony Luck <tony.luck@intel.com>
    Documentation/l1tf: Fix typos

Nicolai Stange <nstange@suse.de>
    x86/KVM/VMX: Initialize the vmx_l1d_flush_pages' content

Jiri Kosina <jkosina@suse.cz>
    x86/speculation/l1tf: Unbreak !__HAVE_ARCH_PFN_MODIFY_ALLOWED architectures

Thomas Gleixner <tglx@linutronix.de>
    Documentation: Add section about CPU vulnerabilities

Jiri Kosina <jkosina@suse.cz>
    x86/bugs, kvm: Introduce boot-time control of L1TF mitigations

Thomas Gleixner <tglx@linutronix.de>
    cpu/hotplug: Set CPU_SMT_NOT_SUPPORTED early

Jiri Kosina <jkosina@suse.cz>
    cpu/hotplug: Expose SMT control init function

Thomas Gleixner <tglx@linutronix.de>
    x86/kvm: Allow runtime control of L1D flush

Thomas Gleixner <tglx@linutronix.de>
    x86/kvm: Serialize L1D flush parameter setter

Thomas Gleixner <tglx@linutronix.de>
    x86/kvm: Add static key for flush always

Thomas Gleixner <tglx@linutronix.de>
    x86/kvm: Move l1tf setup function

Thomas Gleixner <tglx@linutronix.de>
    x86/l1tf: Handle EPT disabled state proper

Thomas Gleixner <tglx@linutronix.de>
    x86/kvm: Drop L1TF MSR list approach

Thomas Gleixner <tglx@linutronix.de>
    x86/litf: Introduce vmx status variable

Thomas Gleixner <tglx@linutronix.de>
    cpu/hotplug: Online siblings when SMT control is turned on

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/KVM/VMX: Use MSR save list for IA32_FLUSH_CMD if required

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/KVM/VMX: Extend add_atomic_switch_msr() to allow VMENTER only MSRs

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/KVM/VMX: Separate the VMX AUTOLOAD guest/host number accounting

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/KVM/VMX: Add find_msr() helper function

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/KVM/VMX: Split the VMX MSR LOAD structures to have an host/guest numbers

Paolo Bonzini <pbonzini@redhat.com>
    x86/KVM/VMX: Add L1D flush logic

Paolo Bonzini <pbonzini@redhat.com>
    x86/KVM/VMX: Add L1D MSR based flush

Paolo Bonzini <pbonzini@redhat.com>
    x86/KVM/VMX: Add L1D flush algorithm

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/KVM/VMX: Add module argument for L1TF mitigation

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/KVM: Warn user if KVM is loaded SMT and L1TF CPU bug being present

Thomas Gleixner <tglx@linutronix.de>
    cpu/hotplug: Boot HT siblings at least once

Thomas Gleixner <tglx@linutronix.de>
    Revert "x86/apic: Ignore secondary threads if nosmt=force"

Michal Hocko <mhocko@suse.cz>
    x86/speculation/l1tf: Fix up pte->pfn conversion for PAE

Vlastimil Babka <vbabka@suse.cz>
    x86/speculation/l1tf: Protect PAE swap entries against L1TF

Borislav Petkov <bp@suse.de>
    x86/CPU/AMD: Move TOPOEXT reenablement before reading smp_num_siblings

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/cpufeatures: Add detection of L1D cache flush support.

Vlastimil Babka <vbabka@suse.cz>
    x86/speculation/l1tf: Extend 64bit swap file size limit

Thomas Gleixner <tglx@linutronix.de>
    x86/apic: Ignore secondary threads if nosmt=force

Thomas Gleixner <tglx@linutronix.de>
    x86/cpu/AMD: Evaluate smp_num_siblings early

Borislav Petkov <bp@suse.de>
    x86/CPU/AMD: Do not check CPUID max ext level before parsing SMP info

Thomas Gleixner <tglx@linutronix.de>
    x86/cpu/intel: Evaluate smp_num_siblings early

Thomas Gleixner <tglx@linutronix.de>
    x86/cpu/topology: Provide detect_extended_topology_early()

Thomas Gleixner <tglx@linutronix.de>
    x86/cpu/common: Provide detect_ht_early()

Thomas Gleixner <tglx@linutronix.de>
    x86/cpu/AMD: Remove the pointless detect_ht() call

Thomas Gleixner <tglx@linutronix.de>
    x86/cpu: Remove the pointless CPU printout

Thomas Gleixner <tglx@linutronix.de>
    cpu/hotplug: Provide knobs to control SMT

Thomas Gleixner <tglx@linutronix.de>
    cpu/hotplug: Split do_cpu_down()

Thomas Gleixner <tglx@linutronix.de>
    cpu/hotplug: Make bringup/teardown of smp threads symmetric

Thomas Gleixner <tglx@linutronix.de>
    x86/topology: Provide topology_smt_supported()

Thomas Gleixner <tglx@linutronix.de>
    x86/smp: Provide topology_is_primary_thread()

Peter Zijlstra <peterz@infradead.org>
    sched/smt: Update sched_smt_present at runtime

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Move the l1tf function and define pr_fmt properly

Andi Kleen <ak@linux.intel.com>
    x86/speculation/l1tf: Limit swap file size to MAX_PA/2

Andi Kleen <ak@linux.intel.com>
    x86/speculation/l1tf: Disallow non privileged high MMIO PROT_NONE mappings

Andi Kleen <ak@linux.intel.com>
    x86/speculation/l1tf: Add sysfs reporting for l1tf

Andi Kleen <ak@linux.intel.com>
    x86/speculation/l1tf: Make sure the first page is always reserved

Andi Kleen <ak@linux.intel.com>
    x86/speculation/l1tf: Protect PROT_NONE PTEs against speculation

Linus Torvalds <torvalds@linux-foundation.org>
    x86/speculation/l1tf: Protect swap entries against L1TF

Linus Torvalds <torvalds@linux-foundation.org>
    x86/speculation/l1tf: Change order of offset/type in swap entry

Andi Kleen <ak@linux.intel.com>
    x86/speculation/l1tf: Increase 32bit PAE __PHYSICAL_PAGE_SHIFT

Nick Desaulniers <ndesaulniers@google.com>
    x86/irqflags: Provide a declaration for native_save_fl

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes/x86: Fix %p uses in error messages

Jiri Kosina <jkosina@suse.cz>
    x86/speculation: Protect against userspace-userspace spectreRSB

Peter Zijlstra <peterz@infradead.org>
    x86/paravirt: Fix spectre-v2 mitigations for paravirt guests

Oleksij Rempel <o.rempel@pengutronix.de>
    ARM: dts: imx6sx: fix irq for pcie bridge

Al Viro <viro@zeniv.linux.org.uk>
    fix __legitimize_mnt()/mntput() race

Al Viro <viro@zeniv.linux.org.uk>
    fix mntput/mntput race

Al Viro <viro@zeniv.linux.org.uk>
    make sure that __dentry_kill() always invalidates d_seq, unhashed or not

Al Viro <viro@zeniv.linux.org.uk>
    root dentries need RCU-delayed freeing

Linus Torvalds <torvalds@linux-foundation.org>
    init: rename and re-order boot_cpu_state_init()

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix memory leak for allocating abort IOCB

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: sr: Avoid that opening a CD-ROM hangs with runtime power management enabled

Daniel Borkmann <daniel@iogearbox.net>
    bpf, sockmap: fix bpf_tcp_sendmsg sock error handling

Daniel Borkmann <daniel@iogearbox.net>
    bpf, sockmap: fix leak in bpf_tcp_sendmsg wait for mem path

Juergen Gross <jgross@suse.com>
    xen/netfront: don't cache skb_shinfo()

Minchan Kim <minchan@kernel.org>
    zram: remove BD_CAP_SYNCHRONOUS_IO with writeback feature

Daniel Bristot de Oliveira <bristot@redhat.com>
    sched/deadline: Update rq_clock of later_rq when pushing a task

Isaac J. Manjarres <isaacm@codeaurora.org>
    stop_machine: Disable preemption after queueing stopper threads

Linus Torvalds <torvalds@linux-foundation.org>
    Mark HI and TASKLET softirq synchronous

John David Anglin <dave.anglin@bell.net>
    parisc: Define mb() and add memory barriers to assembler unlock sequences

Helge Deller <deller@gmx.de>
    parisc: Enable CONFIG_MLONGCALLS by default


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-devices-system-cpu |  24 +
 Documentation/admin-guide/index.rst                |   9 +
 Documentation/admin-guide/kernel-parameters.txt    |  78 +++
 Documentation/admin-guide/l1tf.rst                 | 610 +++++++++++++++++++++
 Makefile                                           |   4 +-
 arch/Kconfig                                       |   3 +
 arch/arm/boot/dts/imx6sx.dtsi                      |   2 +-
 arch/parisc/Kconfig                                |   2 +-
 arch/parisc/include/asm/barrier.h                  |  32 ++
 arch/parisc/kernel/entry.S                         |   2 +
 arch/parisc/kernel/pacache.S                       |   1 +
 arch/parisc/kernel/syscall.S                       |   4 +
 arch/x86/Kconfig                                   |   1 +
 arch/x86/include/asm/apic.h                        |   9 +
 arch/x86/include/asm/cpufeatures.h                 |   3 +
 arch/x86/include/asm/dmi.h                         |   2 +-
 arch/x86/include/asm/hardirq.h                     |  26 +-
 arch/x86/include/asm/irqflags.h                    |   2 +
 arch/x86/include/asm/kvm_host.h                    |   6 +
 arch/x86/include/asm/msr-index.h                   |   7 +
 arch/x86/include/asm/page_32_types.h               |   9 +-
 arch/x86/include/asm/pgtable-2level.h              |  17 +
 arch/x86/include/asm/pgtable-3level.h              |  37 +-
 arch/x86/include/asm/pgtable-invert.h              |  32 ++
 arch/x86/include/asm/pgtable.h                     |  74 ++-
 arch/x86/include/asm/pgtable_64.h                  |  38 +-
 arch/x86/include/asm/processor.h                   |  17 +
 arch/x86/include/asm/topology.h                    |   6 +-
 arch/x86/include/asm/vmx.h                         |  11 +
 arch/x86/kernel/apic/apic.c                        |  16 +
 arch/x86/kernel/apic/io_apic.c                     |   1 +
 arch/x86/kernel/apic/msi.c                         |   1 +
 arch/x86/kernel/apic/vector.c                      |   1 +
 arch/x86/kernel/cpu/amd.c                          |  49 +-
 arch/x86/kernel/cpu/bugs.c                         | 171 ++++--
 arch/x86/kernel/cpu/common.c                       |  56 +-
 arch/x86/kernel/cpu/cpu.h                          |   2 +
 arch/x86/kernel/cpu/intel.c                        |   7 +
 arch/x86/kernel/cpu/microcode/core.c               |  16 +-
 arch/x86/kernel/cpu/topology.c                     |  41 +-
 arch/x86/kernel/fpu/core.c                         |   1 +
 arch/x86/kernel/hpet.c                             |   1 +
 arch/x86/kernel/i8259.c                            |   1 +
 arch/x86/kernel/idt.c                              |   1 +
 arch/x86/kernel/irq.c                              |   1 +
 arch/x86/kernel/irq_32.c                           |   1 +
 arch/x86/kernel/irq_64.c                           |   1 +
 arch/x86/kernel/irqinit.c                          |   1 +
 arch/x86/kernel/kprobes/core.c                     |   5 +-
 arch/x86/kernel/paravirt.c                         |  14 +-
 arch/x86/kernel/setup.c                            |   6 +
 arch/x86/kernel/smp.c                              |   1 +
 arch/x86/kernel/smpboot.c                          |  18 +
 arch/x86/kernel/time.c                             |   1 +
 arch/x86/kvm/mmu.c                                 |   1 +
 arch/x86/kvm/vmx.c                                 | 455 ++++++++++++---
 arch/x86/kvm/x86.c                                 |  34 +-
 arch/x86/mm/init.c                                 |  23 +
 arch/x86/mm/kmmio.c                                |  25 +-
 arch/x86/mm/mmap.c                                 |  21 +
 arch/x86/mm/pageattr.c                             |   8 +-
 arch/x86/mm/pti.c                                  |   1 +
 .../intel-mid/device_libs/platform_mrfld_wdt.c     |   1 +
 arch/x86/platform/uv/tlb_uv.c                      |   1 +
 arch/x86/xen/enlighten.c                           |   1 +
 drivers/base/cpu.c                                 |   8 +
 drivers/block/zram/zram_drv.c                      |  15 +-
 drivers/gpu/drm/i915/i915_pmu.c                    |   1 +
 drivers/gpu/drm/i915/intel_lpe_audio.c             |   1 +
 drivers/net/xen-netfront.c                         |   8 +-
 drivers/pci/host/pci-hyperv.c                      |   2 +
 drivers/scsi/qla2xxx/qla_iocb.c                    |  53 +-
 drivers/scsi/sr.c                                  |  29 +-
 fs/dcache.c                                        |  13 +-
 fs/namespace.c                                     |  28 +-
 include/asm-generic/pgtable.h                      |  12 +
 include/linux/cpu.h                                |  23 +-
 include/linux/swapfile.h                           |   2 +
 init/main.c                                        |   2 +-
 kernel/bpf/sockmap.c                               |   9 +-
 kernel/cpu.c                                       | 282 +++++++++-
 kernel/sched/core.c                                |  30 +-
 kernel/sched/deadline.c                            |   8 +-
 kernel/sched/fair.c                                |   1 +
 kernel/smp.c                                       |   2 +
 kernel/softirq.c                                   |  12 +-
 kernel/stop_machine.c                              |  10 +-
 mm/memory.c                                        |  37 +-
 mm/mprotect.c                                      |  49 ++
 mm/swapfile.c                                      |  46 +-
 tools/arch/x86/include/asm/cpufeatures.h           |  23 +-
 tools/include/uapi/linux/prctl.h                   |  12 +
 92 files changed, 2406 insertions(+), 365 deletions(-)


