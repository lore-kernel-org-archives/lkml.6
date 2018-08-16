Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8E3C43615
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1732D2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1732D2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390857AbeHPNMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 09:12:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43392 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390813AbeHPNMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 09:12:34 -0400
Received: from localhost (unknown [37.170.164.166])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D7CB240B;
        Thu, 16 Aug 2018 10:14:59 +0000 (UTC)
Date:   Thu, 16 Aug 2018 12:14:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.17.15
Message-ID: <20180816101455.GA10762@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.17.15 kernel.

All users of the 4.17 kernel series must upgrade.

The updated 4.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.17.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-system-cpu           |   24=20
 Documentation/admin-guide/index.rst                          |    9=20
 Documentation/admin-guide/kernel-parameters.txt              |   78 +
 Documentation/admin-guide/l1tf.rst                           |  610 ++++++=
+++++
 Makefile                                                     |    2=20
 arch/Kconfig                                                 |    3=20
 arch/arm/boot/dts/imx6sx.dtsi                                |    2=20
 arch/parisc/Kconfig                                          |    2=20
 arch/parisc/include/asm/barrier.h                            |   32=20
 arch/parisc/kernel/entry.S                                   |    2=20
 arch/parisc/kernel/pacache.S                                 |    1=20
 arch/parisc/kernel/syscall.S                                 |    4=20
 arch/x86/Kconfig                                             |    1=20
 arch/x86/include/asm/apic.h                                  |    9=20
 arch/x86/include/asm/cpufeatures.h                           |    3=20
 arch/x86/include/asm/dmi.h                                   |    2=20
 arch/x86/include/asm/hardirq.h                               |   26=20
 arch/x86/include/asm/irqflags.h                              |    2=20
 arch/x86/include/asm/kvm_host.h                              |    6=20
 arch/x86/include/asm/msr-index.h                             |    7=20
 arch/x86/include/asm/page_32_types.h                         |    9=20
 arch/x86/include/asm/pgtable-2level.h                        |   17=20
 arch/x86/include/asm/pgtable-3level.h                        |   37=20
 arch/x86/include/asm/pgtable-invert.h                        |   32=20
 arch/x86/include/asm/pgtable.h                               |   74 -
 arch/x86/include/asm/pgtable_64.h                            |   38=20
 arch/x86/include/asm/processor.h                             |   17=20
 arch/x86/include/asm/smp.h                                   |    1=20
 arch/x86/include/asm/topology.h                              |    6=20
 arch/x86/include/asm/vmx.h                                   |   11=20
 arch/x86/kernel/apic/apic.c                                  |   18=20
 arch/x86/kernel/apic/io_apic.c                               |    1=20
 arch/x86/kernel/apic/msi.c                                   |    1=20
 arch/x86/kernel/apic/vector.c                                |    1=20
 arch/x86/kernel/cpu/amd.c                                    |   59 -
 arch/x86/kernel/cpu/bugs.c                                   |  171 ++-
 arch/x86/kernel/cpu/common.c                                 |   63 -
 arch/x86/kernel/cpu/cpu.h                                    |    2=20
 arch/x86/kernel/cpu/intel.c                                  |    7=20
 arch/x86/kernel/cpu/microcode/core.c                         |   16=20
 arch/x86/kernel/cpu/topology.c                               |   41=20
 arch/x86/kernel/fpu/core.c                                   |    1=20
 arch/x86/kernel/hpet.c                                       |    1=20
 arch/x86/kernel/i8259.c                                      |    1=20
 arch/x86/kernel/idt.c                                        |    1=20
 arch/x86/kernel/irq.c                                        |    1=20
 arch/x86/kernel/irq_32.c                                     |    1=20
 arch/x86/kernel/irq_64.c                                     |    1=20
 arch/x86/kernel/irqinit.c                                    |    1=20
 arch/x86/kernel/kprobes/core.c                               |    5=20
 arch/x86/kernel/paravirt.c                                   |   14=20
 arch/x86/kernel/setup.c                                      |    6=20
 arch/x86/kernel/smp.c                                        |    1=20
 arch/x86/kernel/smpboot.c                                    |   25=20
 arch/x86/kernel/time.c                                       |    1=20
 arch/x86/kvm/mmu.c                                           |    1=20
 arch/x86/kvm/vmx.c                                           |  455 ++++++=
--
 arch/x86/kvm/x86.c                                           |   34=20
 arch/x86/mm/init.c                                           |   25=20
 arch/x86/mm/kmmio.c                                          |   25=20
 arch/x86/mm/mmap.c                                           |   21=20
 arch/x86/mm/pageattr.c                                       |    8=20
 arch/x86/mm/pti.c                                            |    1=20
 arch/x86/platform/intel-mid/device_libs/platform_mrfld_wdt.c |    1=20
 arch/x86/platform/uv/tlb_uv.c                                |    1=20
 arch/x86/xen/enlighten.c                                     |    1=20
 drivers/base/cpu.c                                           |    8=20
 drivers/block/zram/zram_drv.c                                |   15=20
 drivers/gpu/drm/i915/i915_pmu.c                              |    1=20
 drivers/gpu/drm/i915/intel_lpe_audio.c                       |    1=20
 drivers/net/xen-netfront.c                                   |    8=20
 drivers/pci/host/pci-hyperv.c                                |    2=20
 drivers/scsi/qla2xxx/qla_iocb.c                              |   53=20
 drivers/scsi/sr.c                                            |   29=20
 fs/dcache.c                                                  |   13=20
 fs/namespace.c                                               |   28=20
 include/asm-generic/pgtable.h                                |   12=20
 include/linux/cpu.h                                          |   23=20
 include/linux/swapfile.h                                     |    2=20
 init/main.c                                                  |    2=20
 kernel/bpf/sockmap.c                                         |    9=20
 kernel/cpu.c                                                 |  284 ++++-
 kernel/sched/core.c                                          |   30=20
 kernel/sched/deadline.c                                      |    8=20
 kernel/sched/fair.c                                          |    1=20
 kernel/smp.c                                                 |    2=20
 kernel/softirq.c                                             |   12=20
 kernel/stop_machine.c                                        |   10=20
 mm/memory.c                                                  |   37=20
 mm/mprotect.c                                                |   49=20
 mm/swapfile.c                                                |   46=20
 tools/arch/x86/include/asm/cpufeatures.h                     |   23=20
 tools/include/uapi/linux/prctl.h                             |   12=20
 93 files changed, 2419 insertions(+), 381 deletions(-)

Abel Vesa (1):
      cpu/hotplug: Non-SMP machines do not make use of booted_once

Al Viro (4):
      root dentries need RCU-delayed freeing
      make sure that __dentry_kill() always invalidates d_seq, unhashed or =
not
      fix mntput/mntput race
      fix __legitimize_mnt()/mntput() race

Andi Kleen (10):
      x86/speculation/l1tf: Increase 32bit PAE __PHYSICAL_PAGE_SHIFT
      x86/speculation/l1tf: Protect PROT_NONE PTEs against speculation
      x86/speculation/l1tf: Make sure the first page is always reserved
      x86/speculation/l1tf: Add sysfs reporting for l1tf
      x86/speculation/l1tf: Disallow non privileged high MMIO PROT_NONE map=
pings
      x86/speculation/l1tf: Limit swap file size to MAX_PA/2
      x86/speculation/l1tf: Invert all not present mappings
      x86/speculation/l1tf: Make pmd/pud_mknotpresent() invert
      x86/mm/pat: Make set_memory_np() L1TF safe
      x86/mm/kmmio: Make the tracer robust against L1TF

Arnaldo Carvalho de Melo (1):
      tools headers: Synchronize prctl.h ABI header

Bart Van Assche (1):
      scsi: sr: Avoid that opening a CD-ROM hangs with runtime power manage=
ment enabled

Borislav Petkov (3):
      x86/CPU/AMD: Do not check CPUID max ext level before parsing SMP info
      x86/CPU/AMD: Move TOPOEXT reenablement before reading smp_num_siblings
      x86/CPU/AMD: Have smp_num_siblings and cpu_llc_id always be present

Daniel Borkmann (2):
      bpf, sockmap: fix leak in bpf_tcp_sendmsg wait for mem path
      bpf, sockmap: fix bpf_tcp_sendmsg sock error handling

Daniel Bristot de Oliveira (1):
      sched/deadline: Update rq_clock of later_rq when pushing a task

David Woodhouse (1):
      tools headers: Synchronise x86 cpufeatures.h for L1TF additions

Greg Kroah-Hartman (1):
      Linux 4.17.15

Helge Deller (1):
      parisc: Enable CONFIG_MLONGCALLS by default

Isaac J. Manjarres (1):
      stop_machine: Disable preemption after queueing stopper threads

Jiri Kosina (4):
      x86/speculation: Protect against userspace-userspace spectreRSB
      cpu/hotplug: Expose SMT control init function
      x86/bugs, kvm: Introduce boot-time control of L1TF mitigations
      x86/speculation/l1tf: Unbreak !__HAVE_ARCH_PFN_MODIFY_ALLOWED archite=
ctures

John David Anglin (1):
      parisc: Define mb() and add memory barriers to assembler unlock seque=
nces

Josh Poimboeuf (2):
      cpu/hotplug: detect SMT disabled by BIOS
      x86/microcode: Allow late microcode loading with SMT disabled

Juergen Gross (1):
      xen/netfront: don't cache skb_shinfo()

Konrad Rzeszutek Wilk (9):
      x86/bugs: Move the l1tf function and define pr_fmt properly
      x86/cpufeatures: Add detection of L1D cache flush support.
      x86/KVM: Warn user if KVM is loaded SMT and L1TF CPU bug being present
      x86/KVM/VMX: Add module argument for L1TF mitigation
      x86/KVM/VMX: Split the VMX MSR LOAD structures to have an host/guest =
numbers
      x86/KVM/VMX: Add find_msr() helper function
      x86/KVM/VMX: Separate the VMX AUTOLOAD guest/host number accounting
      x86/KVM/VMX: Extend add_atomic_switch_msr() to allow VMENTER only MSRs
      x86/KVM/VMX: Use MSR save list for IA32_FLUSH_CMD if required

Linus Torvalds (4):
      Mark HI and TASKLET softirq synchronous
      init: rename and re-order boot_cpu_state_init()
      x86/speculation/l1tf: Change order of offset/type in swap entry
      x86/speculation/l1tf: Protect swap entries against L1TF

Masami Hiramatsu (1):
      kprobes/x86: Fix %p uses in error messages

Michal Hocko (1):
      x86/speculation/l1tf: Fix up pte->pfn conversion for PAE

Minchan Kim (1):
      zram: remove BD_CAP_SYNCHRONOUS_IO with writeback feature

Nick Desaulniers (1):
      x86/irqflags: Provide a declaration for native_save_fl

Nicolai Stange (9):
      x86/KVM/VMX: Initialize the vmx_l1d_flush_pages' content
      x86/KVM/VMX: Don't set l1tf_flush_l1d to true from vmx_l1d_flush()
      x86/KVM/VMX: Replace 'vmx_l1d_flush_always' with 'vmx_l1d_flush_cond'
      x86/KVM/VMX: Move the l1tf_flush_l1d test to vmx_l1d_flush()
      x86/irq: Demote irq_cpustat_t::__softirq_pending to u16
      x86/KVM/VMX: Introduce per-host-cpu analogue of l1tf_flush_l1d
      x86: Don't include linux/irq.h from asm/hardirq.h
      x86/irq: Let interrupt handlers set kvm_cpu_l1tf_flush_l1d
      x86/KVM/VMX: Don't set l1tf_flush_l1d from vmx_handle_external_intr()

Oleksij Rempel (1):
      ARM: dts: imx6sx: fix irq for pcie bridge

Paolo Bonzini (6):
      x86/KVM/VMX: Add L1D flush algorithm
      x86/KVM/VMX: Add L1D MSR based flush
      x86/KVM/VMX: Add L1D flush logic
      x86/speculation: Simplify sysfs report of VMX L1TF vulnerability
      x86/speculation: Use ARCH_CAPABILITIES to skip L1D flush on vmentry
      KVM: VMX: Tell the nested hypervisor to skip L1D flush on vmentry

Peter Zijlstra (2):
      x86/paravirt: Fix spectre-v2 mitigations for paravirt guests
      sched/smt: Update sched_smt_present at runtime

Quinn Tran (1):
      scsi: qla2xxx: Fix memory leak for allocating abort IOCB

Thomas Gleixner (26):
      x86/smp: Provide topology_is_primary_thread()
      x86/topology: Provide topology_smt_supported()
      cpu/hotplug: Make bringup/teardown of smp threads symmetric
      cpu/hotplug: Split do_cpu_down()
      cpu/hotplug: Provide knobs to control SMT
      x86/cpu: Remove the pointless CPU printout
      x86/cpu/AMD: Remove the pointless detect_ht() call
      x86/cpu/common: Provide detect_ht_early()
      x86/cpu/topology: Provide detect_extended_topology_early()
      x86/cpu/intel: Evaluate smp_num_siblings early
      x86/cpu/AMD: Evaluate smp_num_siblings early
      x86/apic: Ignore secondary threads if nosmt=3Dforce
      Revert "x86/apic: Ignore secondary threads if nosmt=3Dforce"
      cpu/hotplug: Boot HT siblings at least once
      cpu/hotplug: Online siblings when SMT control is turned on
      x86/litf: Introduce vmx status variable
      x86/kvm: Drop L1TF MSR list approach
      x86/l1tf: Handle EPT disabled state proper
      x86/kvm: Move l1tf setup function
      x86/kvm: Add static key for flush always
      x86/kvm: Serialize L1D flush parameter setter
      x86/kvm: Allow runtime control of L1D flush
      cpu/hotplug: Set CPU_SMT_NOT_SUPPORTED early
      Documentation: Add section about CPU vulnerabilities
      Documentation/l1tf: Remove Yonah processors from not vulnerable list
      cpu/hotplug: Fix SMT supported evaluation

Tony Luck (1):
      Documentation/l1tf: Fix typos

Vlastimil Babka (4):
      x86/speculation/l1tf: Extend 64bit swap file size limit
      x86/speculation/l1tf: Protect PAE swap entries against L1TF
      x86/smp: fix non-SMP broken build due to redefinition of apic_id_is_p=
rimary_thread
      x86/init: fix build with CONFIG_SWAP=3Dn


--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlt1Tp8ACgkQONu9yGCS
aT6/jg/9H9yATUc+6LXSyFY2MmjptFq6NBKviXnItSagpCNH5y//1hSPfSDKIz2V
pWwEYfQiJy02E7d28OS2u6RrVof2ny2kiNQPSd8mdOosZuZ+3dJ6IXS98RuD2P/h
kW91z3Au56W4w8eJoKt0l2x3iq+7dWkaI7udyMm/2iKUTMhYDny3Jdelt/6MGRYR
x7wbNpOqhPFP43My04X0gclRIcCfFmzJpoA7HRLzMY7KPViZ2VxzUHAhVxAesNr9
ySnubzkjzvZhtlTN9N5ueeAwxCQosIbTHZWYCZcHcqVqfvEudldCAGODTE7k9Pow
JiP0Tc1BYR2u/tKuMP2ThBpsbIX5AkcBBKSYuenIzQf35YHlQsTbpKpL6AQfOQsG
tG8t4BWTNACfhbOLbJjQRlDe/rI1t6RYDnwNxyVFbbMl8JQcyCnZo1d/iKnHJPzT
5DTtEpaEtGvlUKILHFtoSBOO3iagpUzyUv1SlNfKhc4BXqkA6NWTHBFONX+gppPg
8DtpqSHrSSiQCcw6/+QmWsAIDrN9aiRP3WGQrNrFi47YhJ+shd7Xtr2AJXyE7Kwo
HtfRSQUBv+DJ8vAVYQ1HZPEyLo+xG2NAd5nN64/4+H2Xa3UsP8FYpcdcMgFeeXsN
rZRMeYAEG+0Bh4faBgvPxKcCJVlxR9p97Igf2fVRVbax5zZXuw8=
=VVfq
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
