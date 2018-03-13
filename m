Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934034AbeCMQSK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:18:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32996 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933867AbeCMPe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:34:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/140] 4.14.27-stable review
Date: Tue, 13 Mar 2018 16:23:23 +0100
Message-Id: <20180313152458.201155692@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.27-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.27-rc1
X-KernelTest-Deadline: 2018-03-15T15:25+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.27 release.
There are 140 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Mar 15 15:24:23 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.27-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.27-rc1

Francis Deslauriers <francis.deslauriers@efficios.com>
    x86/kprobes: Fix kernel crash when probing .entry_trampoline code

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Fix 32-bit build

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Fix another switch table detection issue

Peter Zijlstra <peterz@infradead.org>
    objtool, retpolines: Integrate objtool with retpoline support more closely

Peter Zijlstra <peterz@infradead.org>
    objtool: Add module specific retpoline rules

Masahiro Yamada <yamada.masahiro@socionext.com>
    kbuild: move cc-option and cc-disable-warning after incl. arch Makefile

Chris Fries <cfries@google.com>
    kbuild: Set KBUILD_CFLAGS before incl. arch Makefile

Masahiro Yamada <yamada.masahiro@socionext.com>
    kbuild: re-order the code to not parse unnecessary variables

Peter Zijlstra <peterz@infradead.org>
    objtool: Add retpoline validation

Peter Zijlstra <peterz@infradead.org>
    objtool: Use existing global variables for options

Peter Zijlstra <peterz@infradead.org>
    x86/mm/sme, objtool: Annotate indirect call in sme_encrypt_execute()

Peter Zijlstra <peterz@infradead.org>
    x86/boot, objtool: Annotate indirect jump in secondary_startup_64()

Peter Zijlstra <peterz@infradead.org>
    x86/paravirt, objtool: Annotate indirect calls

Ingo Molnar <mingo@kernel.org>
    x86/speculation: Move firmware_restrict_branch_speculation_*() from C to CPP

Peter Zijlstra <peterz@infradead.org>
    x86/speculation, objtool: Annotate indirect calls/jumps for objtool

David Woodhouse <dwmw@amazon.co.uk>
    x86/retpoline: Support retpoline builds with Clang

David Woodhouse <dwmw@amazon.co.uk>
    x86/speculation: Use IBRS if available before calling into firmware

David Woodhouse <dwmw@amazon.co.uk>
    Revert "x86/retpoline: Simplify vmexit_fill_RSB()"

Jan Beulich <JBeulich@suse.com>
    x86-64/realmode: Add instruction suffix

Jan Beulich <JBeulich@suse.com>
    x86/LDT: Avoid warning in 32-bit builds with older gcc

Jan Beulich <JBeulich@suse.com>
    x86/asm: Improve how GEN_*_SUFFIXED_RMWcc() specify clobbers

Jann Horn <jannh@google.com>
    x86/mm: Remove stale comment about KMEMCHECK

Dominik Brodowski <linux@dominikbrodowski.net>
    x86/entry/64: Use 'xorl' for faster register clearing

Dominik Brodowski <linux@dominikbrodowski.net>
    x86/entry: Reduce the code footprint of the 'idtentry' macro

Dan Williams <dan.j.williams@intel.com>
    nospec: Include <asm/barrier.h> dependency

Dan Williams <dan.j.williams@intel.com>
    nospec: Kill array_index_nospec_mask_check()

Paul Burton <paul.burton@mips.com>
    MIPS: CPC: Map registers using DT in mips_cpc_default_phys_base()

Paul Burton <paul.burton@mips.com>
    dt-bindings: Document mti,mips-cpc binding

himanshu.madhani@cavium.com <himanshu.madhani@cavium.com>
    scsi: qla2xxx: Fix recursion while sending terminate exchange

himanshu.madhani@cavium.com <himanshu.madhani@cavium.com>
    scsi: qla2xxx: Fix NULL pointer crash due to probe failure

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    ALSA: hda: add dock and led support for HP ProBook 640 G2

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    ALSA: hda: add dock and led support for HP EliteBook 820 G3

Hui Wang <hui.wang@canonical.com>
    ALSA: hda - Fix a wrong FIXUP for alc289 on Dell machines

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: More protection for concurrent write and ioctl races

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Don't allow resizing pool in use

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    ALSA: hda/realtek - Make dock sound work on ThinkPad L570

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek - Fix dock line-out volume on Dell Precision 7520

Benjamin Berg <bberg@redhat.com>
    ALSA: hda/realtek: Limit mic boost on T480

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Add headset mode support for Dell laptop

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Add support headset mode for DELL WYSE

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/spectre_v2: Don't check microcode versions when running under hypervisors

Adrian Hunter <adrian.hunter@intel.com>
    perf tools: Fix trigger class trigger_on()

Seunghun Han <kkamagui@gmail.com>
    x86/MCE: Serialize sysfs changes

Tony Luck <tony.luck@intel.com>
    x86/MCE: Save microcode revision in machine check records

Michael Lyle <mlyle@lyle.org>
    bcache: don't attach backing with duplicate UUID

Tang Junhui <tang.junhui@zte.com.cn>
    bcache: fix crashes in duplicate cache device register

Sergey Gorenko <sergeygo@mellanox.com>
    IB/mlx5: Fix incorrect size of klms in the memory region

Arnd Bergmann <arnd@arndb.de>
    dm bufio: avoid false-positive Wmaybe-uninitialized warning

James Hogan <jhogan@kernel.org>
    kbuild: Handle builtin dtb file names containing hyphens

Parav Pandit <parav@mellanox.com>
    IB/core: Fix missing RDMA cgroups release in case of failure to register device

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    arm64: mm: fix thinko in non-global page table attribute check

David Hildenbrand <david@redhat.com>
    KVM: s390: fix memory overwrites when not using SCA entries

Tiwei Bie <tiwei.bie@intel.com>
    virtio_ring: fix num_free handling in error case

Ross Zwisler <ross.zwisler@linux.intel.com>
    loop: Fix lost writes caused by missing flag

Matthew Wilcox <mawilcox@microsoft.com>
    Documentation/sphinx: Fix Directive import error

Daniel Vacek <neelx@redhat.com>
    mm/page_alloc: fix memmap_init_zone pageblock alignment

Daniel Vacek <neelx@redhat.com>
    mm/memblock.c: hardcode the end_pfn being -1

Kees Cook <keescook@chromium.org>
    lib/bug.c: exclude non-BUG/WARN exceptions from report_bug()

Zhang Bo <zbsdta@126.com>
    Input: matrix_keypad - fix race when disabling interrupts

Koen Vandeputte <koen.vandeputte@ncentric.com>
    PCI: dwc: Fix enumeration end when reaching root subordinate

Colin Ian King <colin.king@canonical.com>
    MIPS: OCTEON: irq: Check for null return on kzalloc allocation

Colin Ian King <colin.king@canonical.com>
    MIPS: ath25: Check for kzalloc allocation failure

Justin Chen <justinpopo6@gmail.com>
    MIPS: BMIPS: Do not mask IPIs during suspend

James Zhu <James.Zhu@amd.com>
    drm/amdgpu:Always save uvd vcpu_bo in VM Mode

James Zhu <James.Zhu@amd.com>
    drm/amdgpu:Correct max uvd handles

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: fix KV harvesting

Alex Deucher <alexander.deucher@amd.com>
    drm/radeon: fix KV harvesting

Rex Zhu <Rex.Zhu@amd.com>
    drm/amdgpu: Notify sbios device ready before send request

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: used cached pcie gen info for SI (v2)

Eric Huang <JinHuiEric.Huang@amd.com>
    drm/amd/powerplay: fix power over limit on Fiji

Ben Crocker <bcrocker@redhat.com>
    drm/radeon: insist on 32-bit DMA for Cedar on PPC64/PPC64LE

Alex Deucher <alexander.deucher@amd.com>
    Revert "drm/radeon/pm: autoswitch power state when in balanced mode"

Alex Deucher <alexander.deucher@amd.com>
    drm/amd/powerplay/vega10: allow mclk switching with no displays

Alex Deucher <alexander.deucher@amd.com>
    drm/amd/powerplay/smu7: allow mclk switching with no displays

Ilia Mirkin <imirkin@alum.mit.edu>
    drm/nouveau: prefer XBGR2101010 for addfb ioctl

Lukas Wunner <lukas@wunner.de>
    drm/amdgpu: Fix deadlock on runtime suspend

Lukas Wunner <lukas@wunner.de>
    drm/radeon: Fix deadlock on runtime suspend

Lukas Wunner <lukas@wunner.de>
    drm/nouveau: Fix deadlock on runtime suspend

Lukas Wunner <lukas@wunner.de>
    drm: Allow determining if current task is output poll worker

Lukas Wunner <lukas@wunner.de>
    workqueue: Allow retrieval of current task's work struct

Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
    drm/i915: Always call to intel_display_set_init_power() in resume_early.

himanshu.madhani@cavium.com <himanshu.madhani@cavium.com>
    scsi: qla2xxx: Fix NULL pointer crash due to active timer for ABTS

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: core: Avoid that ATA error handling can trigger a kernel hang or oops

Lionel Landwerlin <lionel.g.landwerlin@intel.com>
    drm/i915/perf: fix perf stream opening lock

Stefan Brüns <stefan.bruens@rwth-aachen.de>
    drm/i915: Try EDID bitbanging on HDMI after failed read

Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
    drm/i915: Update watermark state correctly in sanitize_watermarks

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Disable DC states around GMBUS on GLK

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915: Clear the in-use marker on execbuf failure

Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
    drm/i915: Fix rsvd2 mask when out-fence is returned

Fabrice Gasnier <fabrice.gasnier@st.com>
    regulator: stm32-vrefbuf: fix check on ready flag

Davide Caratti <dcaratti@redhat.com>
    net/smc: fix NULL pointer dereference on sock_create_kern() error path

Jason Gunthorpe <jgg@mellanox.com>
    IB/uverbs: Improve lockdep_check

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx5: Fix integer overflow while resizing CQ

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Check that user doesn't overflow QP state

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Limit possible option size

Trond Myklebust <trond.myklebust@primarydata.com>
    NFS: Fix unstable write completion

Trond Myklebust <trond.myklebust@primarydata.com>
    pNFS: Prevent the layout header refcount going to zero in pnfs_roc()

Trond Myklebust <trond.myklebust@primarydata.com>
    NFS: Fix an incorrect type in struct nfs_direct_req

himanshu.madhani@cavium.com <himanshu.madhani@cavium.com>
    scsi: qla2xxx: Fix memory leak in dual/target mode

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix system crash in qlt_plogi_ack_unref

Giridhar Malavali <giridhar.malavali@cavium.com>
    scsi: qla2xxx: Remove aborting ELS IOCB call issued as part of timeout.

Giridhar Malavali <giridhar.malavali@cavium.com>
    scsi: qla2xxx: Defer processing of GS IOCB calls

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Clear loop id after delete

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix scan state field for fcport

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Replace fcport alloc with qla2x00_alloc_fcport

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix abort command deadlock due to spinlock

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix PRLI state check

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix Relogin being triggered too fast

Sawan Chandak <sawan.chandak@cavium.com>
    scsi: qla2xxx: Fix NPIV host cleanup in target mode

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix login state machine stuck at GPDB

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Serialize GPNID for multiple RSCN

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Retry switch command on time out

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix re-login for Nport Handle in use

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Skip IRQ affinity for Target QPairs

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Move session delete to driver work queue

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix gpnid error processing

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix system crash for Notify ack timeout handling

Javier Martinez Canillas <javierm@redhat.com>
    tpm: only attempt to disable the LPC CLKRUN if is already enabled

Arnd Bergmann <arnd@arndb.de>
    tpm: remove unused variables

Javier Martinez Canillas <javierm@redhat.com>
    tpm: delete the TPM_TIS_CLK_ENABLE flag

Azhar Shaikh <azhar.shaikh@intel.com>
    tpm: Keep CLKRUN enabled throughout the duration of transmit_cmd()

Azhar Shaikh <azhar.shaikh@intel.com>
    tpm_tis: Move ilb_base_addr to tpm_tis_data

Eric Dumazet <edumazet@google.com>
    netfilter: use skb_to_full_sk in ip6_route_me_harder

Florian Westphal <fw@strlen.de>
    netfilter: ipv6: fix use-after-free Write in nf_nat_ipv6_manip_pkt

Florian Westphal <fw@strlen.de>
    netfilter: bridge: ebt_among: add missing match size checks

Florian Westphal <fw@strlen.de>
    netfilter: ebtables: CONFIG_COMPAT: don't trust userland offsets

Eric Dumazet <edumazet@google.com>
    netfilter: IDLETIMER: be syzkaller friendly

Paolo Abeni <pabeni@redhat.com>
    netfilter: nat: cope with negative port range

Paolo Abeni <pabeni@redhat.com>
    netfilter: x_tables: fix missing timer initialization in xt_LED

Eric Dumazet <edumazet@google.com>
    netfilter: xt_hashlimit: fix lock imbalance

Cong Wang <xiyou.wangcong@gmail.com>
    netfilter: ipt_CLUSTERIP: fix a race condition of proc file creation

Florian Westphal <fw@strlen.de>
    netfilter: add back stackpointer size checks

Vinod Koul <vinod.koul@intel.com>
    ASoC: Intel: kbl: fix jack name

Chintan Patel <chintan.m.patel@intel.com>
    ASoC: Intel: Skylake: Fix jack name format substitution

Arnd Bergmann <arnd@arndb.de>
    ARM: omap2: hide omap3_save_secure_ram on non-OMAP3 builds

Jerry Hoemann <jerry.hoemann@hpe.com>
    watchdog: hpwdt: Remove legacy NMI sourcing.

Arnd Bergmann <arnd@arndb.de>
    watchdog: hpwdt: fix unused variable warning

Jerry Hoemann <jerry.hoemann@hpe.com>
    watchdog: hpwdt: Check source of NMI

Jerry Hoemann <jerry.hoemann@hpe.com>
    watchdog: hpwdt: SMBIOS check

Masahiro Yamada <yamada.masahiro@socionext.com>
    kbuild: move "_all" target out of $(KBUILD_SRC) conditional


-------------

Diffstat:

 .../devicetree/bindings/power/mti,mips-cpc.txt     |   8 +
 Documentation/sphinx/kerneldoc.py                  |   3 +-
 MAINTAINERS                                        |   1 +
 Makefile                                           | 261 ++++++-----
 arch/arm/mach-omap2/omap-secure.c                  |   2 +
 arch/arm64/mm/mmu.c                                |   8 +-
 arch/mips/ath25/board.c                            |   2 +
 arch/mips/cavium-octeon/octeon-irq.c               |   2 +
 arch/mips/kernel/mips-cpc.c                        |  13 +
 arch/mips/kernel/smp-bmips.c                       |   8 +-
 arch/s390/kvm/kvm-s390.c                           |   1 +
 arch/x86/Kconfig                                   |   1 +
 arch/x86/Makefile                                  |   7 +-
 arch/x86/entry/calling.h                           |  27 +-
 arch/x86/entry/entry_32.S                          |   3 +-
 arch/x86/entry/entry_64.S                          |  21 +-
 arch/x86/entry/entry_64_compat.S                   |  54 +--
 arch/x86/include/asm/apm.h                         |   6 +
 arch/x86/include/asm/asm-prototypes.h              |   3 -
 arch/x86/include/asm/cpufeatures.h                 |   1 +
 arch/x86/include/asm/efi.h                         |  17 +-
 arch/x86/include/asm/mmu_context.h                 |   1 +
 arch/x86/include/asm/nospec-branch.h               | 138 +++++-
 arch/x86/include/asm/paravirt.h                    |  17 +-
 arch/x86/include/asm/paravirt_types.h              |   5 +-
 arch/x86/include/asm/refcount.h                    |   4 +-
 arch/x86/include/asm/rmwcc.h                       |  16 +-
 arch/x86/include/asm/sections.h                    |   1 +
 arch/x86/include/uapi/asm/mce.h                    |   1 +
 arch/x86/kernel/cpu/bugs.c                         |  12 +-
 arch/x86/kernel/cpu/intel.c                        |   7 +
 arch/x86/kernel/cpu/mcheck/mce.c                   |  26 +-
 arch/x86/kernel/head_64.S                          |   2 +
 arch/x86/kernel/kprobes/core.c                     |  10 +-
 arch/x86/kernel/vmlinux.lds.S                      |   2 +
 arch/x86/lib/Makefile                              |   1 -
 arch/x86/lib/retpoline.S                           |  56 ---
 arch/x86/mm/fault.c                                |   4 -
 arch/x86/mm/mem_encrypt_boot.S                     |   2 +
 arch/x86/realmode/rm/trampoline_64.S               |   2 +-
 drivers/block/loop.c                               |   2 +-
 drivers/char/tpm/tpm-interface.c                   |   6 +
 drivers/char/tpm/tpm_tis.c                         | 108 -----
 drivers/char/tpm/tpm_tis_core.c                    | 121 ++++-
 drivers/char/tpm/tpm_tis_core.h                    |  16 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |  58 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |  13 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |  30 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |  22 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |  50 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |  18 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |  11 +-
 drivers/gpu/drm/drm_framebuffer.c                  |   4 +
 drivers/gpu/drm/drm_probe_helper.c                 |  20 +
 drivers/gpu/drm/i915/i915_drv.c                    |   2 +
 drivers/gpu/drm/i915/i915_gem_execbuffer.c         |   4 +-
 drivers/gpu/drm/i915/i915_perf.c                   |  38 +-
 drivers/gpu/drm/i915/intel_display.c               |   2 +
 drivers/gpu/drm/i915/intel_hdmi.c                  |  14 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c            |   1 +
 drivers/gpu/drm/nouveau/nouveau_connector.c        |  18 +-
 drivers/gpu/drm/nouveau/nv50_display.c             |   1 +
 drivers/gpu/drm/radeon/cik.c                       |  31 +-
 drivers/gpu/drm/radeon/radeon_connectors.c         |  74 ++-
 drivers/gpu/drm/radeon/radeon_device.c             |   4 +
 drivers/gpu/drm/radeon/radeon_pm.c                 |   6 +-
 drivers/infiniband/core/device.c                   |   6 +-
 drivers/infiniband/core/rdma_core.c                |  12 +-
 drivers/infiniband/core/ucma.c                     |   6 +
 drivers/infiniband/hw/mlx5/cq.c                    |   7 +-
 drivers/infiniband/hw/mlx5/mr.c                    |   2 +-
 drivers/input/keyboard/matrix_keypad.c             |   4 +-
 drivers/md/bcache/super.c                          |  27 +-
 drivers/md/dm-bufio.c                              |  16 +-
 drivers/pci/dwc/pcie-designware-host.c             |   2 +-
 drivers/regulator/stm32-vrefbuf.c                  |   2 +-
 drivers/scsi/hosts.c                               |   3 -
 drivers/scsi/qla2xxx/qla_def.h                     |  49 +-
 drivers/scsi/qla2xxx/qla_gs.c                      |  72 ++-
 drivers/scsi/qla2xxx/qla_init.c                    |  64 ++-
 drivers/scsi/qla2xxx/qla_iocb.c                    |  13 -
 drivers/scsi/qla2xxx/qla_isr.c                     |   7 +-
 drivers/scsi/qla2xxx/qla_mbx.c                     |   3 +-
 drivers/scsi/qla2xxx/qla_mid.c                     |  42 +-
 drivers/scsi/qla2xxx/qla_os.c                      |  51 ++-
 drivers/scsi/qla2xxx/qla_target.c                  |  26 +-
 drivers/scsi/scsi_error.c                          |   5 +-
 drivers/scsi/scsi_lib.c                            |   2 +
 drivers/virtio/virtio_ring.c                       |   2 -
 drivers/watchdog/hpwdt.c                           | 507 +--------------------
 fs/nfs/direct.c                                    |   2 +-
 fs/nfs/pnfs.c                                      |  13 +-
 fs/nfs/write.c                                     |  83 ++--
 include/drm/drm_crtc_helper.h                      |   1 +
 include/drm/drm_drv.h                              |   1 +
 include/linux/compiler-clang.h                     |   5 +
 include/linux/compiler-gcc.h                       |   4 +
 include/linux/init.h                               |   8 +-
 include/linux/nospec.h                             |  23 +-
 include/linux/tpm.h                                |   1 +
 include/linux/workqueue.h                          |   1 +
 include/scsi/scsi_cmnd.h                           |   3 +
 include/scsi/scsi_host.h                           |   2 -
 kernel/workqueue.c                                 |  16 +
 lib/bug.c                                          |   2 +
 mm/memblock.c                                      |  10 +-
 mm/page_alloc.c                                    |   9 +-
 net/bridge/netfilter/ebt_among.c                   |  21 +-
 net/bridge/netfilter/ebtables.c                    |  13 +-
 net/ipv4/netfilter/arp_tables.c                    |   4 +
 net/ipv4/netfilter/ip_tables.c                     |   7 +-
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |  12 +-
 net/ipv6/netfilter.c                               |   9 +-
 net/ipv6/netfilter/ip6_tables.c                    |   4 +
 net/ipv6/netfilter/nf_nat_l3proto_ipv6.c           |   4 +
 net/netfilter/nf_nat_proto_common.c                |   7 +-
 net/netfilter/xt_IDLETIMER.c                       |   9 +-
 net/netfilter/xt_LED.c                             |  12 +-
 net/netfilter/xt_hashlimit.c                       |   2 +-
 net/smc/af_smc.c                                   |   4 +-
 scripts/Makefile.build                             |   8 +
 scripts/Makefile.lib                               |   8 +-
 sound/core/seq/seq_clientmgr.c                     |  21 +-
 sound/core/seq/seq_fifo.c                          |   2 +-
 sound/core/seq/seq_memory.c                        |  14 +-
 sound/core/seq/seq_memory.h                        |   3 +-
 sound/pci/hda/patch_conexant.c                     |   2 +
 sound/pci/hda/patch_realtek.c                      |  45 +-
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |   2 +
 tools/objtool/builtin-check.c                      |   6 +-
 tools/objtool/builtin-orc.c                        |   6 +-
 tools/objtool/builtin.h                            |   5 +
 tools/objtool/check.c                              |  93 +++-
 tools/objtool/check.h                              |   3 +-
 tools/perf/util/trigger.h                          |   9 +-
 136 files changed, 1486 insertions(+), 1396 deletions(-)
