Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932454AbeCLAmc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 20:42:32 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:36681 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932368AbeCLAm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 20:42:29 -0400
X-Google-Smtp-Source: AG47ELuPsOJ+q0lf+Cg4kL5sxZ/JocCZMZApD+37eeF8d4tEc2vQjHUG6tgpJh373nqPbpDKOZjxyDqH/prJg23jlLY=
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Mar 2018 17:42:27 -0700
X-Google-Sender-Auth: HMC4kmxaSSqAhw2cfHWtA0bFvIA
Message-ID: <CA+55aFxXAMHeD8zz1BLv9r_2rjWJ6xE=cNGVAoWOvQJog7oz9A@mail.gmail.com>
Subject: Linux 4.16-rc5
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2C0goDB022526

This continue to be pretty normal - this rc is slightly larger than
rc4 was, but that looks like one of the normal fluctuations due to
timing of pull requests, not due to anything distressing. In
particular, this past week we had both a networking pull and a drm
pull, which accounts for a fait chunk of it all.

In addition to the networking updates (both drivers and core
networking) and the drm stuff (mainly some amdgpu display handling
updates), there's the usual arch fixes (mostly x86 this time -
microcode handling and some syscall cleanups) and various random
driver fixes (rdma, md, scsi, watchdog). Plus some misc stuff:
filesystems (overlayfs, xfs) some core kernel code, and tooling
(mainly perf and selftests).

Nothing particular stands out, the appended shortlog gives a flavor of
the details.

               Linus

---

Adrian Hunter (2):
      perf auxtrace: Prevent decoding when --no-itrace
      perf tools: Fix trigger class trigger_on()

Alastair D'Silva (2):
      ocxl: Add get_metadata IOCTL to share OCXL information to userspace
      ocxl: Document the OCXL_IOCTL_GET_METADATA IOCTL

Alex Deucher (3):
      drm/amdgpu: used cached pcie gen info for SI (v2)
      drm/radeon: fix KV harvesting
      drm/amdgpu: fix KV harvesting

Amir Goldstein (3):
      ovl: hash non-dir by lower inode for fsnotify
      ovl: check lower ancestry on encode of lower dir file handle
      ovl: check ERR_PTR() return value from ovl_lookup_real()

Andi Shyti (2):
      Input: mms114 - fix license module information
      Input: mms114 - add SPDX identifier

Andrea Arcangeli (1):
      mm/gup.c: teach get_user_pages_unlocked to handle FOLL_NOWAIT

Andreas Gruenbacher (1):
      gfs2: Fixes to "Implement iomap for block_map" (2)

Andrew Lunn (1):
      net: phy: Restore phy_resume() locking assumption

Andy Lutomirski (1):
      x86/vsyscall/64: Drop "native" vsyscalls

Ard Biesheuvel (1):
      arm64: mm: fix thinko in non-global page table attribute check

Arkadi Sharshevsky (2):
      devlink: Compare to size_new in case of resource child validation
      devlink: Fix resource coverity errors

Arkadiusz Hiler (1):
      Revert "Input: synaptics - Lenovo Thinkpad T460p devices should use RMI"

Arnaldo Carvalho de Melo (3):
      perf annotate browser: Be more robust when drawing jump arrows
      tools headers: Sync copy of kvm UAPI headers
      tools headers: Sync x86's cpufeatures.h

Arnd Bergmann (2):
      net: ipv4: avoid unused variable warning for sysctl
      dm bufio: avoid false-positive Wmaybe-uninitialized warning

Arvind Yadav (1):
      xen: xenbus: use put_device() instead of kfree()

Ashok Raj (4):
      x86/microcode/intel: Check microcode revision before updating
sibling threads
      x86/microcode/intel: Writeback and invalidate caches before
updating microcode
      x86/microcode: Do not upload microcode if CPUs are offline
      x86/microcode: Synchronize late microcode loading

Bart Van Assche (1):
      scsi: core: Avoid that ATA error handling can trigger a kernel
hang or oops

Bassem Boubaker (1):
      cdc_ether: flag the Cinterion PLS8 modem by gemalto as WWAN

Benjamin Berg (1):
      ALSA: hda/realtek: Limit mic boost on T480

Bharata B Rao (1):
      powerpc/pseries: Fix vector5 in ibm architecture vector table

Bhavesh Davda (1):
      xen-blkfront: move negotiate_mq to cover all cases of new VBDs

Bhawanpreet Lakha (1):
      drm/amd/display: Fix takover from VGA mode

Boqun Feng (1):
      rtmutex: Make rt_mutex_futex_unlock() safe for irq-off callsites

Boris Pismenny (1):
      tls: Use correct sk->sk_prot for IPV6

Borislav Petkov (3):
      x86/microcode: Get rid of struct apply_microcode_ctx
      x86/microcode/intel: Look into the patch cache first
      x86/microcode: Request microcode on the BSP

Chris Wilson (1):
      drm/i915: Suspend submission tasklets around wedging

Christian Borntraeger (2):
      KVM: s390: provide io interrupt kvm_stat
      s390/entry.S: fix spurious zeroing of r0

Christoph Hellwig (4):
      xfs: don't allocate COW blocks for zeroing holes or unwritten extents
      xfs: don't start out with the exclusive ilock for direct I/O
      xfs: don't block on the ilock for RWF_NOWAIT
      Revert "nvme: create 'slaves' and 'holders' entries for hidden
controllers"

Claudiu Manoil (1):
      gianfar: Fix Rx byte accounting for ndev stats

Colin Ian King (3):
      MIPS: ath25: Check for kzalloc allocation failure
      MIPS: OCTEON: irq: Check for null return on kzalloc allocation
      ia64/err-inject: fix spelling mistake: "capapbilities" -> "capabilities"

Corentin Labbe (1):
      ia64: convert unwcheck.py to python3

Dan Carpenter (1):
      IB/mlx5: Fix an error code in __mlx5_ib_modify_qp()

Daniel Axtens (4):
      net: rename skb_gso_validate_mtu -> skb_gso_validate_network_len
      net: sched: tbf: handle GSO_BY_FRAGS case in enqueue
      net: xfrm: use skb_gso_validate_network_len() to check gso sizes
      net: make skb_gso_*_seglen functions private

Daniel Borkmann (2):
      bpf: allow xadd only on aligned memory
      bpf, ppc64: fix out of bounds access in tail call

Daniel Jurgens (1):
      {net, IB}/mlx5: Raise fatal IB event when sys error occurs

Daniel Vacek (2):
      mm/memblock.c: hardcode the end_pfn being -1
      mm/page_alloc: fix memmap_init_zone pageblock alignment

Darren Hart (VMware) (2):
      platform/x86: Allow for SMBIOS backend defaults
      platform/x86: dell-smbios: Resolve dependency error on DCDBAS

Darren Trapp (1):
      scsi: qla2xxx: Fix FC-NVMe LUN discovery

David Hildenbrand (1):
      KVM: s390: fix memory overwrites when not using SCA entries

David S. Miller (1):
      ARM: orion5x: Revert commit 4904dbda41c8.

Davide Caratti (2):
      net/smc: fix NULL pointer dereference on sock_create_kern() error path
      tc-testing: skbmod: fix match value of ethertype

Davidlohr Bueso (1):
      ia64/err-inject: Use get_user_pages_fast()

Denis Du (1):
      hdlc_ppp: carrier detect ok, don't turn off negotiation

Dennis Wassenberg (3):
      ALSA: hda/realtek - Make dock sound work on ThinkPad L570
      ALSA: hda: add dock and led support for HP EliteBook 820 G3
      ALSA: hda: add dock and led support for HP ProBook 640 G2

Devesh Sharma (2):
      RDMA/bnxt_re: Unconditionly fence non wire memory operations
      RDMA/bnxt_re: Fix incorrect DB offset calculation

Dmitry Torokhov (1):
      Revert "platform/chrome: chromeos_laptop: make chromeos_laptop const"

Dominik Brodowski (6):
      x86/syscalls/32: Simplify $entry == $compat entries
      x86/entry: Remove stale syscall prototype
      x86/syscalls: Use proper syscall definition for sys_ioperm()
      x86/syscalls: Use COMPAT_SYSCALL_DEFINEx() macros for x86-only
compat syscalls
      x86/entry: Do not special-case clone(2) in compat entry
      x86/entry/64/compat: Save one instruction in entry_INT80_compat()

Doug Ledford (1):
      Revert "RDMA/mlx5: Fix integer overflow while resizing CQ"

Edward Cree (1):
      net: ethtool: don't ignore return from driver get_fecparam method

Emil Tantilov (1):
      ixgbe: fix crash in build_skb Rx code path

Eric Dumazet (4):
      netfilter: use skb_to_full_sk in ip6_route_me_harder
      test_bpf: add a schedule point
      r8152: fix tx packets accounting
      test_bpf: reduce MAX_TESTRUNS

Eric W. Biederman (2):
      signal: Correct the offset of si_pkey in struct siginfo
      signal/x86: Include the field offsets in the build time checks

Eric Yang (3):
      drm/amd/display: fix cursor related Pstate hang
      drm/amd/display: update infoframe after dig fe is turned on
      drm/amd/display: early return if not in vga mode in disable_vga

Eugeniu Rosca (1):
      s390: Replace IS_ENABLED(EXPOLINE_*) with IS_ENABLED(CONFIG_EXPOLINE_*)

Fabrice Gasnier (1):
      regulator: stm32-vrefbuf: fix check on ready flag

Felix Fietkau (2):
      mac80211: drop frames with unexpected DS bits from fast-rx to slow path
      netfilter: nf_flow_table: fix checksum when handling DNAT

Fengguang Wu (1):
      ovl: fix ptr_ret.cocci warnings

Florian Westphal (7):
      netfilter: ipt_CLUSTERIP: put config struct if we can't
increment ct refcount
      netfilter: ipt_CLUSTERIP: put config instead of freeing it
      netfilter: ipv6: fix use-after-free Write in nf_nat_ipv6_manip_pkt
      netfilter: bridge: ebt_among: add missing match size checks
      netfilter: ebtables: convert BUG_ONs to WARN_ONs
      netfilter: ebtables: CONFIG_COMPAT: don't trust userland offsets
      netfilter: don't set F_IFACE on ipv6 fib lookups

Francis Deslauriers (1):
      x86/kprobes: Fix kernel crash when probing .entry_trampoline code

Geert Uytterhoeven (2):
      regulator: Fix resume from suspend to idle
      gpio: rcar: Use wakeup_path i.s.o. explicit clock handling

Giulio Benetti (1):
      drm/sun4i: Fix dclk_set_phase

Gregory CLEMENT (1):
      dmaengine: mv_xor_v2: Fix clock resource by adding a register clock

Guenter Roeck (3):
      powerpc/boot: Fix random libfdt related build errors
      s390: Fix runtime warning about negative pgtables_bytes
      PCI: Move of_irq_parse_and_map_pci() declaration under OF_IRQ

Guillaume Nault (1):
      ppp: prevent unregistered channels from connecting to PPP units

Hannes Reinecke (4):
      scsi: qla2xxx: Fixup locking for session deletion
      scsi: qla2xxx: do not check login_state if no loop id is assigned
      scsi: qla2xxx: ensure async flags are reset correctly
      scsi: core: return BLK_STS_OK for DID_OK in __scsi_error_from_host_byte()

Hans de Goede (1):
      Bluetooth: btusb: Use DMI matching for QCA reset_resume quirking

Harry Wentland (11):
      drm/amd/display: Don't blow up if TG is NULL in dce110_vblank_set
      drm/amd/display: Default HDMI6G support to true. Log VBIOS table error.
      drm/amd/display: Move MAX_TMDS_CLOCK define to header
      drm/amd/display: Remove unnecessary fail labels in create_stream_for_sink
      drm/amd/display: Pass signal directly to enable_tmds_output
      drm/amd/display: Don't allow dual-link DVI on all ASICs.
      drm/amd/display: Don't block dual-link DVI modes
      drm/amd/display: Make create_stream_for_sink more consistent
      drm/amd/display: Call update_stream_signal directly from amdgpu_dm
      drm/amd/display: Use crtc enable/disable_vblank hooks
      drm/amd/display: Return success when enabling interrupt

Hendrik Brueckner (1):
      s390/clean-up: use CFI_* macros in entry.S

Huacai Chen (2):
      MIPS: Loongson64: Select ARCH_MIGHT_HAVE_PC_PARPORT
      MIPS: Loongson64: Select ARCH_MIGHT_HAVE_PC_SERIO

Hui Wang (1):
      ALSA: hda - Fix a wrong FIXUP for alc289 on Dell machines

Ido Schimmel (3):
      bridge: Fix VLAN reference count problem
      mlxsw: spectrum: Treat IPv6 unregistered multicast as broadcast
      spectrum: Reference count VLAN entries

Igor Pylypiv (1):
      watchdog: f71808e_wdt: Fix magic close handling

Ilya Pronin (1):
      perf stat: Fix CVS output format for non-supported counters

Jack M (1):
      IB/mlx4: Include GID type when deleting GIDs from HW table under RoCE

Jack Morgenstein (1):
      IB/mlx4: Fix corruption of RoCEv2 IPv4 GIDs

James Chapman (5):
      l2tp: don't use inet_shutdown on tunnel destroy
      l2tp: don't use inet_shutdown on ppp session destroy
      l2tp: fix races with tunnel socket close
      l2tp: fix race in pppol2tp_release with session object destroy
      l2tp: fix tunnel lookup use-after-free race

James Hogan (1):
      kbuild: Handle builtin dtb file names containing hyphens

James Smart (1):
      nvme_fc: rework sqsize handling

James Zhu (2):
      drm/amdgpu:Correct max uvd handles
      drm/amdgpu:Always save uvd vcpu_bo in VM Mode

Jason Wang (5):
      Revert "tuntap: add missing xdp flush"
      tuntap: disable preemption during XDP processing
      tuntap: correctly add the missing XDP flush
      virtio-net: disable NAPI only when enabled during XDP set
      virtio-net: re enable XDP_REDIRECT for mergeable buffer

Jayachandran C (1):
      watchdog: sbsa: use 32-bit read for WCV

Jernej Skrabec (1):
      drm/sun4i: Release exclusive clock lock when disabling TCON

Jerry (Fangzhi) Zuo (2):
      drm/amd/display: Fix topology change issue in MST rehook
      drm/amd/display: Fixed non-native modes not lighting up

Jerry Hoemann (1):
      watchdog: hpwdt: Remove legacy NMI sourcing.

Jiri Olsa (1):
      perf record: Fix crash in pipe mode

Jiri Pirko (2):
      mlxsw: core: Fix flex keys scratchpad offset conflict
      mlxsw: spectrum: Fix handling of resource_size_param

Joey Pabalinas (1):
      net/tcp/illinois: replace broken algorithm reference link

Jon Maloy (1):
      tipc: correct initial value for group congestion flag

Jonathan Brassow (1):
      dm raid: fix incorrect sync_ratio when degraded

Josh Poimboeuf (1):
      objtool: Fix 32-bit build

Julian Anastasov (1):
      ipvs: remove IPS_NAT_MASK check to fix passive FTP

Julian Wiedmann (6):
      s390/qeth: fix overestimated count of buffer elements
      s390/qeth: fix IP removal on offline cards
      s390/qeth: fix double-free on IP add/remove race
      Revert "s390/qeth: fix using of ref counter for rxip addresses"
      s390/qeth: fix IP address lookup for L3 devices
      s390/qeth: fix IPA command submission race

Justin Chen (1):
      MIPS: BMIPS: Do not mask IPIs during suspend

Ka-Cheong Poon (1):
      rds: Incorrect reference counting in TCP socket creation

Kailang Yang (2):
      ALSA: hda/realtek - Add support headset mode for DELL WYSE
      ALSA: hda/realtek - Add headset mode support for Dell laptop

Kalderon, Michal (4):
      RDMA/qedr: Fix ipv6 destination address resolution
      RDMA/qedr: Fix iWARP connect with port mapper
      RDMA/qedr: Fix kernel panic when running fio over NFSoRDMA
      RDMA/qedr: Fix iWARP write and send with immediate

Kan Liang (2):
      perf/x86/intel/uncore: Fix Skylake UPI event format
      perf top: Fix annoying fallback message on older kernels

Karsten Graul (2):
      net/smc: use a constant for control message length
      net/smc: use link_id of server in confirm link reply

Kees Cook (2):
      bug: use %pB in BUG and stack protector failure
      lib/bug.c: exclude non-BUG/WARN exceptions from report_bug()

Koen Vandeputte (1):
      PCI: dwc: Fix enumeration end when reaching root subordinate

Konrad Rzeszutek Wilk (1):
      x86/spectre_v2: Don't check microcode versions when running
under hypervisors

Laurent Vivier (1):
      KVM: PPC: Book3S HV: Fix guest time accounting with
VIRT_CPU_ACCOUNTING_GEN

Leo (Sunpeng) Li (1):
      drm/amd/display: Fix memleaks when atomic check fails.

Leon Romanovsky (4):
      RDMA/ucma: Limit possible option size
      RDMA/mlx5: Fix integer overflow while resizing CQ
      RDMA/ucma: Check that user doesn't overflow QP state
      RDMA/mlx5: Fix integer overflow while resizing CQ

Li Zhijian (1):
      selftests/vm/run_vmtests: adjust hugetlb size according to nr_cpus

Linus Torvalds (1):
      Linux 4.16-rc5

Lionel Landwerlin (1):
      drm/i915/perf: fix perf stream opening lock

Luis R. Rodriguez (1):
      lib/test_kmod.c: fix limit check on number of test devices created

Manish Rangankar (1):
      scsi: qedi: Fix kernel crash during port toggle

Marc Zyngier (1):
      arm64: Relax ARM_SMCCC_ARCH_WORKAROUND_1 discovery

Mario Limonciello (3):
      platform/x86: dell-smbios: Correct some style warnings
      platform/x86: dell-smbios: Rename dell-smbios source to dell-smbios-base
      platform/x86: dell-smbios: Link all dell-smbios-* modules together

Mark Bloch (1):
      IB/mlx5: When not in dual port RoCE mode, use provided port as native

Martin Schwidefsky (1):
      s390: do not bypass BPENTER for interrupt system calls

Masahiro Yamada (1):
      clocksource/atmel-st: Add 'depends on HAS_IOMEM' to fix unmet dependency

Matt Redfearn (1):
      signals: Move put_compat_sigset to compat.h to silence hardened usercopy

Matteo Croce (1):
      scripts/bloat-o-meter: fix typos in help

Matthew Wilcox (2):
      ia64: Convert remaining atomic operations
      Documentation/sphinx: Fix Directive import error

Matthias Schiffer (2):
      batman-adv: fix packet checksum in receive path
      batman-adv: invalidate checksum on fragment reassembly

Mauricio Faria de Oliveira (1):
      scsi: mpt3sas: fix oops in error handlers after shutdown/unload

Max Gurtovoy (1):
      RDMA/core: Reduce poll batch for direct cq polling

Maxime Ripard (3):
      drm/sun4i: tcon: Reduce the scope of the LVDS error a bit
      drm/sun4i: rgb: Fix potential division by zero
      drm/sun4i: crtc: Call drm_crtc_vblank_on / drm_crtc_vblank_off

Michael Ellerman (3):
      selftests/powerpc: Skip tm-trap if transactional memory is not enabled
      selftests/powerpc: Fix missing clean of pmu/lib.o
      selftests/powerpc: Skip the subpage_prot tests if the syscall is
unavailable

Michael Kelley (EOSG) (1):
      scsi: storvsc: Spread interrupts when picking a channel for I/O requests

Michael Lyle (1):
      bcache: don't attach backing with duplicate UUID

Michal Hocko (1):
      hugetlb: fix surplus pages accounting

Michel Dänzer (1):
      drm/amdgpu/dce6: Use DRM_DEBUG instead of DRM_INFO for HPD IRQ info

Mike Manning (1):
      net: allow interface to be set into VRF if VLAN interface in same VRF

Mike Snitzer (3):
      dm: use blkdev_get rather than bdgrab when issuing pass-through ioctl
      dm mpath: remove unnecessary NVMe branching in favor of scsi_dh checks
      dm table: allow upgrade from bio-based to specialized bio-based variant

Mikita Lipski (1):
      drm/amd/display: Set irq state only on existing crtcs

Miklos Szeredi (1):
      ovl: update Kconfig texts

Mikulas Patocka (1):
      dm table: fix "nvme" test

Ming Lei (1):
      nvme: pci: pass max vectors as num_possible_cpus() to
pci_alloc_irq_vectors

Moni Shoua (1):
      IB/mlx: Set slid to zero in Ethernet completion struct

Muneendra Kumar M (1):
      IB/core : Add null pointer check in addr_resolve

Noa Osherovich (1):
      IB/mlx5: Avoid passing an invalid QP type to firmware

Pablo Neira Ayuso (3):
      netfilter: nf_tables: return EBUSY if device already belongs to flowtable
      netfilter: nf_tables: missing attribute validation in
nf_tables_delflowtable()
      netfilter: nf_tables: use the right index from flowtable error path

Parav Pandit (2):
      IB/core: Fix missing RDMA cgroups release in case of failure to
register device
      IB/core: Fix possible crash to access NULL netdev

Paul Mackerras (4):
      KVM: PPC: Fix compile error that occurs when CONFIG_ALTIVEC=n
      KVM: PPC: Book3S: Fix compile error that occurs with some gcc versions
      KVM: PPC: Book3S HV: Fix handling of large pages in radix page
fault handler
      KVM: PPC: Book3S HV: Fix VRMA initialization with 2MB or 1GB
memory backing

Peter Malone (1):
      fbdev: Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in
sbusfb_ioctl_helper().

Ramon Fried (1):
      qrtr: add MODULE_ALIAS macro to smd

Rasmus Villemoes (3):
      fixdep: remove stale references to uml-config.h
      fixdep: remove some false CONFIG_ matches
      fixdep: do not ignore kconfig.h

Rex Zhu (1):
      drm/amdgpu: Notify sbios device ready before send request

Roland Dreier (1):
      nvme-fabrics: Ignore nr_io_queues option for discovery controllers

Romain Naour (1):
      cfg80211: add missing dependency to CFG80211 suboptions

Roman Li (3):
      drm/amd/display: Fix active dongle hotplug
      drm/amd/display: Fix FBC topology change
      drm/amd/display: fix boot-up on vega10

Ross Zwisler (1):
      loop: Fix lost writes caused by missing flag

Sabrina Dubroca (1):
      net: ipv4: don't allow setting net.ipv4.route.min_pmtu below 68

Sangwon Hong (1):
      perf kallsyms: Fix the usage on the man page

Sebastian Ott (3):
      s390/cio: fix ccw_device_start_timeout API
      s390/cio: fix return code after missing interrupt
      s390/cio: clear timer when terminating driver I/O

Selvin Xavier (2):
      RDMA/bnxt_re: Fix the ib_reg failure cleanup
      RDMA/bnxt_re: Avoid Hard lockup during error CQE processing

Sergei Shtylyov (2):
      DT: net: renesas,ravb: document R8A77980 bindings
      sh_eth: uninline TSU register accessors

Sergei Trofimovich (1):
      ia64: doc: tweak whitespace for 'console=' parameter

Sergey Gorenko (1):
      IB/mlx5: Fix incorrect size of klms in the memory region

Seunghun Han (2):
      x86/pti: Fix a comment typo
      x86/MCE: Serialize sysfs changes

Shalom Toledo (1):
      mlxsw: spectrum_switchdev: Check success of FDB add operation

Shirish S (5):
      drm/amd/display: defer modeset check in dm_update_planes_state
      drm/amd/display: validate plane in dce110 for scaling
      drm/amd/display: update plane params before validation
      drm/amd/display: disable CRTCs with NULL FB on their primary plane (V2)
      drm/amd/display: validate plane format on primary plane

Shivasharan S (1):
      scsi: megaraid_sas: Do not use 32-bit atomic request descriptor
for Ventura controllers

Shuah Khan (1):
      selftests: memory-hotplug: fix emit_tests regression

Soheil Hassas Yeganeh (1):
      tcp: purge write queue upon RST

Song Liu (1):
      perf/core: Fix ctx_event_type in ctx_resched()

Sreekanth Reddy (1):
      scsi: mpt3sas: wait for and flush running commands on shutdown/unload

Stefan Haberland (1):
      s390/dasd: fix handling of internal requests

Stefan Wahren (1):
      Bluetooth: hci_bcm: Make shutdown and device wake GPIO optional

Stephen Hemminger (9):
      hv_netvsc: avoid retry on send during shutdown
      hv_netvsc: only wake transmit queue if link is up
      hv_netvsc: fix error unwind handling if vmbus_open fails
      hv_netvsc: cancel subchannel setup before halting device
      hv_netvsc: fix race in napi poll when rescheduling
      hv_netvsc: use napi_schedule_irqoff
      hv_netvsc: defer queue selection to VF
      hv_netvsc: filter multicast/broadcast
      hv_netvsc: propagate rx filters to VF

Stephen Suryaputra (1):
      vrf: check forwarding on the original netdevice when generating
ICMP dest unreachable

Sven Eckelmann (5):
      batman-adv: Ignore invalid batadv_iv_gw during netlink send
      batman-adv: Ignore invalid batadv_v_gw during netlink send
      batman-adv: Fix netlink dumping of BLA claims
      batman-adv: Fix netlink dumping of BLA backbones
      batman-adv: Fix internal interface indices types

Taehee Yoo (1):
      netfilter: increase IPSTATS_MIB_CSUMERRORS stat

Takashi Iwai (4):
      ALSA: hda/realtek - Fix dock line-out volume on Dell Precision 7520
      ALSA: seq: Don't allow resizing pool in use
      ALSA: seq: More protection for concurrent write and ioctl races
      ALSA: seq: Remove superfluous snd_seq_queue_client_leave_cells() call

Tang Junhui (1):
      bcache: fix crashes in duplicate cache device register

Thomas Winter (1):
      ip_tunnel: Do not use mark in skb by default

Tiwei Bie (1):
      virtio_ring: fix num_free handling in error case

Toke Høiland-Jørgensen (1):
      mac80211: Adjust TSQ pacing shift

Tom St Denis (1):
      drm/amd/amdgpu: Mask rptr as well in ring debugfs

Tony Luck (1):
      x86/MCE: Save microcode revision in machine check records

Vivek Goyal (1):
      ovl: redirect_dir=nofollow should not follow redirect for opaque lower

Wen Xiong (1):
      nvme-pci: Fix EEH failure on ppc

Will Deacon (1):
      arm_pmu: Use disable_irq_nosync when disabling SPI in CPU teardown hook

Xin Long (3):
      ip_gre: fix IFLA_MTU ignored on NEWLINK
      ip6_tunnel: fix IFLA_MTU ignored on NEWLINK
      sit: fix IFLA_MTU ignored on NEWLINK

Yoshihiro Shimoda (1):
      dmaengine: rcar-dmac: fix max_chunk_size for R-Car Gen3

Yuchung Cheng (2):
      tcp: revert F-RTO middle-box workaround
      tcp: revert F-RTO extension to detect more spurious timeouts

Zhang Bo (1):
      Input: matrix_keypad - fix race when disabling interrupts

himanshu.madhani@cavium.com (1):
      scsi: qla2xxx: Fix NULL pointer crash due to active timer for ABTS
