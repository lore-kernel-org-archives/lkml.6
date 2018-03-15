Date: Thu, 15 Mar 2018 14:24:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.27
Message-ID: <20180315132412.GA19131@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.27 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/power/mti,mips-cpc.txt |    8=20
 Documentation/sphinx/kerneldoc.py                        |    3=20
 MAINTAINERS                                              |    1=20
 Makefile                                                 |  259 +++----
 arch/arm/mach-omap2/omap-secure.c                        |    2=20
 arch/arm64/mm/mmu.c                                      |    8=20
 arch/mips/ath25/board.c                                  |    2=20
 arch/mips/cavium-octeon/octeon-irq.c                     |    2=20
 arch/mips/kernel/mips-cpc.c                              |   13=20
 arch/mips/kernel/smp-bmips.c                             |    8=20
 arch/s390/kvm/kvm-s390.c                                 |    1=20
 arch/x86/Kconfig                                         |    1=20
 arch/x86/Makefile                                        |    7=20
 arch/x86/entry/calling.h                                 |   27=20
 arch/x86/entry/entry_32.S                                |    3=20
 arch/x86/entry/entry_64.S                                |   21=20
 arch/x86/entry/entry_64_compat.S                         |   54 -
 arch/x86/include/asm/apm.h                               |    6=20
 arch/x86/include/asm/asm-prototypes.h                    |    3=20
 arch/x86/include/asm/cpufeatures.h                       |    1=20
 arch/x86/include/asm/efi.h                               |   17=20
 arch/x86/include/asm/mmu_context.h                       |    1=20
 arch/x86/include/asm/nospec-branch.h                     |  138 +++-
 arch/x86/include/asm/paravirt.h                          |   17=20
 arch/x86/include/asm/paravirt_types.h                    |    5=20
 arch/x86/include/asm/refcount.h                          |    4=20
 arch/x86/include/asm/rmwcc.h                             |   16=20
 arch/x86/include/asm/sections.h                          |    1=20
 arch/x86/include/uapi/asm/mce.h                          |    1=20
 arch/x86/kernel/cpu/bugs.c                               |   12=20
 arch/x86/kernel/cpu/intel.c                              |    7=20
 arch/x86/kernel/cpu/mcheck/mce.c                         |   26=20
 arch/x86/kernel/head_64.S                                |    2=20
 arch/x86/kernel/kprobes/core.c                           |   10=20
 arch/x86/kernel/vmlinux.lds.S                            |    2=20
 arch/x86/lib/Makefile                                    |    1=20
 arch/x86/lib/retpoline.S                                 |   56 -
 arch/x86/mm/fault.c                                      |    4=20
 arch/x86/mm/mem_encrypt_boot.S                           |    2=20
 arch/x86/realmode/rm/trampoline_64.S                     |    2=20
 drivers/block/loop.c                                     |    2=20
 drivers/char/tpm/tpm-interface.c                         |    6=20
 drivers/char/tpm/tpm_tis.c                               |  108 ---
 drivers/char/tpm/tpm_tis_core.c                          |  121 +++
 drivers/char/tpm/tpm_tis_core.h                          |   16=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                 |    3=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c           |   58 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c                  |   13=20
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c                    |   30=20
 drivers/gpu/drm/amd/amdgpu/si.c                          |   22=20
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                      |   50 -
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c         |   18=20
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c       |   11=20
 drivers/gpu/drm/drm_framebuffer.c                        |    4=20
 drivers/gpu/drm/drm_probe_helper.c                       |   20=20
 drivers/gpu/drm/i915/i915_drv.c                          |    2=20
 drivers/gpu/drm/i915/i915_gem_execbuffer.c               |    4=20
 drivers/gpu/drm/i915/i915_perf.c                         |   38 -
 drivers/gpu/drm/i915/intel_display.c                     |    2=20
 drivers/gpu/drm/i915/intel_hdmi.c                        |   14=20
 drivers/gpu/drm/i915/intel_runtime_pm.c                  |    1=20
 drivers/gpu/drm/nouveau/nouveau_connector.c              |   18=20
 drivers/gpu/drm/nouveau/nv50_display.c                   |    1=20
 drivers/gpu/drm/radeon/cik.c                             |   31=20
 drivers/gpu/drm/radeon/radeon_connectors.c               |   74 +-
 drivers/gpu/drm/radeon/radeon_device.c                   |    4=20
 drivers/gpu/drm/radeon/radeon_pm.c                       |    6=20
 drivers/infiniband/core/device.c                         |    6=20
 drivers/infiniband/core/rdma_core.c                      |   12=20
 drivers/infiniband/core/ucma.c                           |    6=20
 drivers/infiniband/hw/mlx5/cq.c                          |    7=20
 drivers/infiniband/hw/mlx5/mr.c                          |    2=20
 drivers/input/keyboard/matrix_keypad.c                   |    4=20
 drivers/md/bcache/super.c                                |   27=20
 drivers/md/dm-bufio.c                                    |   16=20
 drivers/pci/dwc/pcie-designware-host.c                   |    2=20
 drivers/regulator/stm32-vrefbuf.c                        |    2=20
 drivers/scsi/hosts.c                                     |    3=20
 drivers/scsi/qla2xxx/qla_def.h                           |   49 -
 drivers/scsi/qla2xxx/qla_gs.c                            |   72 +-
 drivers/scsi/qla2xxx/qla_init.c                          |   64 +
 drivers/scsi/qla2xxx/qla_iocb.c                          |   13=20
 drivers/scsi/qla2xxx/qla_isr.c                           |    7=20
 drivers/scsi/qla2xxx/qla_mbx.c                           |    3=20
 drivers/scsi/qla2xxx/qla_mid.c                           |   42 -
 drivers/scsi/qla2xxx/qla_os.c                            |   51 -
 drivers/scsi/qla2xxx/qla_target.c                        |   26=20
 drivers/scsi/scsi_error.c                                |    5=20
 drivers/scsi/scsi_lib.c                                  |    2=20
 drivers/virtio/virtio_ring.c                             |    2=20
 drivers/watchdog/hpwdt.c                                 |  507 ----------=
-----
 fs/nfs/direct.c                                          |    2=20
 fs/nfs/pnfs.c                                            |   13=20
 fs/nfs/write.c                                           |   83 +-
 include/drm/drm_crtc_helper.h                            |    1=20
 include/drm/drm_drv.h                                    |    1=20
 include/linux/compiler-clang.h                           |    5=20
 include/linux/compiler-gcc.h                             |    4=20
 include/linux/init.h                                     |    8=20
 include/linux/nospec.h                                   |   23=20
 include/linux/tpm.h                                      |    1=20
 include/linux/workqueue.h                                |    1=20
 include/scsi/scsi_cmnd.h                                 |    3=20
 include/scsi/scsi_host.h                                 |    2=20
 kernel/workqueue.c                                       |   16=20
 lib/bug.c                                                |    2=20
 mm/memblock.c                                            |   10=20
 net/bridge/netfilter/ebt_among.c                         |   21=20
 net/bridge/netfilter/ebtables.c                          |   13=20
 net/ipv4/netfilter/arp_tables.c                          |    4=20
 net/ipv4/netfilter/ip_tables.c                           |    7=20
 net/ipv4/netfilter/ipt_CLUSTERIP.c                       |   12=20
 net/ipv6/netfilter.c                                     |    9=20
 net/ipv6/netfilter/ip6_tables.c                          |    4=20
 net/ipv6/netfilter/nf_nat_l3proto_ipv6.c                 |    4=20
 net/netfilter/nf_nat_proto_common.c                      |    7=20
 net/netfilter/xt_IDLETIMER.c                             |    9=20
 net/netfilter/xt_LED.c                                   |   12=20
 net/netfilter/xt_hashlimit.c                             |    2=20
 net/smc/af_smc.c                                         |    4=20
 scripts/Makefile.build                                   |    8=20
 scripts/Makefile.lib                                     |    8=20
 sound/core/seq/seq_clientmgr.c                           |   21=20
 sound/core/seq/seq_fifo.c                                |    2=20
 sound/core/seq/seq_memory.c                              |   14=20
 sound/core/seq/seq_memory.h                              |    3=20
 sound/pci/hda/patch_conexant.c                           |    2=20
 sound/pci/hda/patch_realtek.c                            |   45 +
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c      |    2=20
 tools/objtool/builtin-check.c                            |    6=20
 tools/objtool/builtin-orc.c                              |    6=20
 tools/objtool/builtin.h                                  |    5=20
 tools/objtool/check.c                                    |   93 ++
 tools/objtool/check.h                                    |    3=20
 tools/perf/util/trigger.h                                |    9=20
 135 files changed, 1478 insertions(+), 1393 deletions(-)

Adrian Hunter (1):
      perf tools: Fix trigger class trigger_on()

Alex Deucher (6):
      drm/amd/powerplay/smu7: allow mclk switching with no displays
      drm/amd/powerplay/vega10: allow mclk switching with no displays
      Revert "drm/radeon/pm: autoswitch power state when in balanced mode"
      drm/amdgpu: used cached pcie gen info for SI (v2)
      drm/radeon: fix KV harvesting
      drm/amdgpu: fix KV harvesting

Ard Biesheuvel (1):
      arm64: mm: fix thinko in non-global page table attribute check

Arnd Bergmann (4):
      watchdog: hpwdt: fix unused variable warning
      ARM: omap2: hide omap3_save_secure_ram on non-OMAP3 builds
      tpm: remove unused variables
      dm bufio: avoid false-positive Wmaybe-uninitialized warning

Azhar Shaikh (2):
      tpm_tis: Move ilb_base_addr to tpm_tis_data
      tpm: Keep CLKRUN enabled throughout the duration of transmit_cmd()

Bart Van Assche (1):
      scsi: core: Avoid that ATA error handling can trigger a kernel hang o=
r oops

Ben Crocker (1):
      drm/radeon: insist on 32-bit DMA for Cedar on PPC64/PPC64LE

Benjamin Berg (1):
      ALSA: hda/realtek: Limit mic boost on T480

Chintan Patel (1):
      ASoC: Intel: Skylake: Fix jack name format substitution

Chris Fries (1):
      kbuild: Set KBUILD_CFLAGS before incl. arch Makefile

Chris Wilson (1):
      drm/i915: Clear the in-use marker on execbuf failure

Colin Ian King (2):
      MIPS: ath25: Check for kzalloc allocation failure
      MIPS: OCTEON: irq: Check for null return on kzalloc allocation

Cong Wang (1):
      netfilter: ipt_CLUSTERIP: fix a race condition of proc file creation

Dan Williams (2):
      nospec: Kill array_index_nospec_mask_check()
      nospec: Include <asm/barrier.h> dependency

Daniel Vacek (1):
      mm/memblock.c: hardcode the end_pfn being -1

Daniele Ceraolo Spurio (1):
      drm/i915: Fix rsvd2 mask when out-fence is returned

David Hildenbrand (1):
      KVM: s390: fix memory overwrites when not using SCA entries

David Woodhouse (3):
      Revert "x86/retpoline: Simplify vmexit_fill_RSB()"
      x86/speculation: Use IBRS if available before calling into firmware
      x86/retpoline: Support retpoline builds with Clang

Davide Caratti (1):
      net/smc: fix NULL pointer dereference on sock_create_kern() error path

Dennis Wassenberg (3):
      ALSA: hda/realtek - Make dock sound work on ThinkPad L570
      ALSA: hda: add dock and led support for HP EliteBook 820 G3
      ALSA: hda: add dock and led support for HP ProBook 640 G2

Dominik Brodowski (2):
      x86/entry: Reduce the code footprint of the 'idtentry' macro
      x86/entry/64: Use 'xorl' for faster register clearing

Eric Dumazet (3):
      netfilter: xt_hashlimit: fix lock imbalance
      netfilter: IDLETIMER: be syzkaller friendly
      netfilter: use skb_to_full_sk in ip6_route_me_harder

Eric Huang (1):
      drm/amd/powerplay: fix power over limit on Fiji

Fabrice Gasnier (1):
      regulator: stm32-vrefbuf: fix check on ready flag

Florian Westphal (4):
      netfilter: add back stackpointer size checks
      netfilter: ebtables: CONFIG_COMPAT: don't trust userland offsets
      netfilter: bridge: ebt_among: add missing match size checks
      netfilter: ipv6: fix use-after-free Write in nf_nat_ipv6_manip_pkt

Francis Deslauriers (1):
      x86/kprobes: Fix kernel crash when probing .entry_trampoline code

Giridhar Malavali (2):
      scsi: qla2xxx: Defer processing of GS IOCB calls
      scsi: qla2xxx: Remove aborting ELS IOCB call issued as part of timeou=
t.

Greg Kroah-Hartman (1):
      Linux 4.14.27

Hui Wang (1):
      ALSA: hda - Fix a wrong FIXUP for alc289 on Dell machines

Ilia Mirkin (1):
      drm/nouveau: prefer XBGR2101010 for addfb ioctl

Ingo Molnar (1):
      x86/speculation: Move firmware_restrict_branch_speculation_*() from C=
 to CPP

James Hogan (1):
      kbuild: Handle builtin dtb file names containing hyphens

James Zhu (2):
      drm/amdgpu:Correct max uvd handles
      drm/amdgpu:Always save uvd vcpu_bo in VM Mode

Jan Beulich (3):
      x86/asm: Improve how GEN_*_SUFFIXED_RMWcc() specify clobbers
      x86/LDT: Avoid warning in 32-bit builds with older gcc
      x86-64/realmode: Add instruction suffix

Jann Horn (1):
      x86/mm: Remove stale comment about KMEMCHECK

Jason Gunthorpe (1):
      IB/uverbs: Improve lockdep_check

Javier Martinez Canillas (2):
      tpm: delete the TPM_TIS_CLK_ENABLE flag
      tpm: only attempt to disable the LPC CLKRUN if is already enabled

Jerry Hoemann (3):
      watchdog: hpwdt: SMBIOS check
      watchdog: hpwdt: Check source of NMI
      watchdog: hpwdt: Remove legacy NMI sourcing.

Josh Poimboeuf (2):
      objtool: Fix another switch table detection issue
      objtool: Fix 32-bit build

Justin Chen (1):
      MIPS: BMIPS: Do not mask IPIs during suspend

Kailang Yang (2):
      ALSA: hda/realtek - Add support headset mode for DELL WYSE
      ALSA: hda/realtek - Add headset mode support for Dell laptop

Kees Cook (1):
      lib/bug.c: exclude non-BUG/WARN exceptions from report_bug()

Koen Vandeputte (1):
      PCI: dwc: Fix enumeration end when reaching root subordinate

Konrad Rzeszutek Wilk (1):
      x86/spectre_v2: Don't check microcode versions when running under hyp=
ervisors

Leon Romanovsky (3):
      RDMA/ucma: Limit possible option size
      RDMA/ucma: Check that user doesn't overflow QP state
      RDMA/mlx5: Fix integer overflow while resizing CQ

Lionel Landwerlin (1):
      drm/i915/perf: fix perf stream opening lock

Lukas Wunner (5):
      workqueue: Allow retrieval of current task's work struct
      drm: Allow determining if current task is output poll worker
      drm/nouveau: Fix deadlock on runtime suspend
      drm/radeon: Fix deadlock on runtime suspend
      drm/amdgpu: Fix deadlock on runtime suspend

Maarten Lankhorst (2):
      drm/i915: Update watermark state correctly in sanitize_watermarks
      drm/i915: Always call to intel_display_set_init_power() in resume_ear=
ly.

Masahiro Yamada (3):
      kbuild: move "_all" target out of $(KBUILD_SRC) conditional
      kbuild: re-order the code to not parse unnecessary variables
      kbuild: move cc-option and cc-disable-warning after incl. arch Makefi=
le

Matthew Wilcox (1):
      Documentation/sphinx: Fix Directive import error

Michael Lyle (1):
      bcache: don't attach backing with duplicate UUID

Paolo Abeni (2):
      netfilter: x_tables: fix missing timer initialization in xt_LED
      netfilter: nat: cope with negative port range

Parav Pandit (1):
      IB/core: Fix missing RDMA cgroups release in case of failure to regis=
ter device

Paul Burton (2):
      dt-bindings: Document mti,mips-cpc binding
      MIPS: CPC: Map registers using DT in mips_cpc_default_phys_base()

Peter Zijlstra (8):
      x86/speculation, objtool: Annotate indirect calls/jumps for objtool
      x86/paravirt, objtool: Annotate indirect calls
      x86/boot, objtool: Annotate indirect jump in secondary_startup_64()
      x86/mm/sme, objtool: Annotate indirect call in sme_encrypt_execute()
      objtool: Use existing global variables for options
      objtool: Add retpoline validation
      objtool: Add module specific retpoline rules
      objtool, retpolines: Integrate objtool with retpoline support more cl=
osely

Quinn Tran (15):
      scsi: qla2xxx: Fix system crash for Notify ack timeout handling
      scsi: qla2xxx: Fix gpnid error processing
      scsi: qla2xxx: Move session delete to driver work queue
      scsi: qla2xxx: Skip IRQ affinity for Target QPairs
      scsi: qla2xxx: Fix re-login for Nport Handle in use
      scsi: qla2xxx: Retry switch command on time out
      scsi: qla2xxx: Serialize GPNID for multiple RSCN
      scsi: qla2xxx: Fix login state machine stuck at GPDB
      scsi: qla2xxx: Fix Relogin being triggered too fast
      scsi: qla2xxx: Fix PRLI state check
      scsi: qla2xxx: Fix abort command deadlock due to spinlock
      scsi: qla2xxx: Replace fcport alloc with qla2x00_alloc_fcport
      scsi: qla2xxx: Fix scan state field for fcport
      scsi: qla2xxx: Clear loop id after delete
      scsi: qla2xxx: Fix system crash in qlt_plogi_ack_unref

Rex Zhu (1):
      drm/amdgpu: Notify sbios device ready before send request

Ross Zwisler (1):
      loop: Fix lost writes caused by missing flag

Sawan Chandak (1):
      scsi: qla2xxx: Fix NPIV host cleanup in target mode

Sergey Gorenko (1):
      IB/mlx5: Fix incorrect size of klms in the memory region

Seunghun Han (1):
      x86/MCE: Serialize sysfs changes

Stefan Br=FCns (1):
      drm/i915: Try EDID bitbanging on HDMI after failed read

Takashi Iwai (3):
      ALSA: hda/realtek - Fix dock line-out volume on Dell Precision 7520
      ALSA: seq: Don't allow resizing pool in use
      ALSA: seq: More protection for concurrent write and ioctl races

Tang Junhui (1):
      bcache: fix crashes in duplicate cache device register

Tiwei Bie (1):
      virtio_ring: fix num_free handling in error case

Tony Luck (1):
      x86/MCE: Save microcode revision in machine check records

Trond Myklebust (3):
      NFS: Fix an incorrect type in struct nfs_direct_req
      pNFS: Prevent the layout header refcount going to zero in pnfs_roc()
      NFS: Fix unstable write completion

Ville Syrj=E4l=E4 (1):
      drm/i915: Disable DC states around GMBUS on GLK

Vinod Koul (1):
      ASoC: Intel: kbl: fix jack name

Zhang Bo (1):
      Input: matrix_keypad - fix race when disabling interrupts

himanshu.madhani@cavium.com (4):
      scsi: qla2xxx: Fix memory leak in dual/target mode
      scsi: qla2xxx: Fix NULL pointer crash due to active timer for ABTS
      scsi: qla2xxx: Fix NULL pointer crash due to probe failure
      scsi: qla2xxx: Fix recursion while sending terminate exchange


--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqqc/kACgkQONu9yGCS
aT4ogxAAq2R8exAcrw9Tp4tgJ7kkSQsMaqh5grEQ5Qp3nNFtKGg1UHY8DxOfws8v
0XC9J/mra3V1FxCDGAQKaGHapCVrl+ovwmjCMLWmQqPMgwo1rnCnXvWypTVor5fF
H+Tk0K6Mu3E1Ic7RpeaptVU8AWYjhDIpoe1IWOqjaSzYBjIzb6cEeyXM+JOY36PN
cxI5UWHHjnbqTtl20uzQvPz91/BPDUUiiiz4HEQnwH64kR8vDc932czQs36h987F
I4E5dBR6V9sq2kRZiIBgpZN996iruHlDz1eVPEQswFmJDPVFGt0KsibOahLTgipW
/feLGdPIoYRqry1Ws1dQpIm3H3UjLVZ2+NkmpWzoVCW2G6taBWX5thUBbrxtxq9x
GRGF4GhW+DTMkDaBUpcC0c/fwG/+krogPR13YIkTtTWgW1yW50UjGTzOHETno9iP
zbKBLx0MluQSa6nJhFNHIp48fWzQLaLEcfX5w9tbwDCysoPGgo97HxpKMPyKgBr3
CLVjQR86yjzFWR5OwDzgAtQ9LIKOHgfLuWG+EizhA1fTvV1fcUDmWFt8X4Q2yGmJ
7sYi9yYhIfqyQ/csrosVbR9CyprplKmg6LY99QyQdp3+W8MU4/EkxPLe1SWogGOj
4xGzMP07lDEpPwDiBwmVj1hG04Z70uPSm0Aa9lgs1nXqiV+etAQ=
=zASM
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
