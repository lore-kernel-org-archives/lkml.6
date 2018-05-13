Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeEMXYi (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 19:24:38 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:37604 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeEMXYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 19:24:35 -0400
X-Google-Smtp-Source: AB8JxZrOw2a2NRuI7+E5bx/EeENuXlMpX2SAV9Je7XV5MWi7aHBII80wRannyRjCm+rC64G751QM0qoH/tDhUBZPMEo=
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 13 May 2018 16:24:23 -0700
Message-ID: <CA+55aFxi-Q6hvdHn+JwYSQ9b3feNGoFM3eeAuKNhpkfxVNAGpA@mail.gmail.com>
Subject: Linux 4.17-rc5
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4DNOils028253

Things continue to look fairly normal. About half the rc5 release is driver
updates, with amdgpu standing out but mainly because everything else is
really pretty small, not because the amdgpu patches are all that big.

  Outside of drivers, there's a random collection of changes all over: some
filesystems (ceph and cifs), some networking, some core kernel, some small
arch updates, and some tooling.

There's a fair number of changes in there (shortlog appended as usual), but
a lot of them really are one- or two-liners.

So I think we're in pretty good shape. Please go keep testing, though, to
make sure we're not missing anything.

                     Linus

---

Adi Nissim (1):
       net/mlx5: E-Switch, Include VF RDMA stats in vport statistics

Alexander Aring (1):
       net: ieee802154: 6lowpan: fix frag reassembly

Anders Roxell (1):
       selftests: net: use TEST_PROGS_EXTENDED

Andre Tomt (1):
       net/tls: Fix connection stall on partial tls record

Andrew Lunn (1):
       net: dsa: mv88e6xxx: Fix PHY interrupts by parameterising PHY base
address

Andrey Grodzovsky (1):
       drm/amdgpu: Switch to interruptable wait to recover from ring hang.

Andrey Ignatov (1):
       ipv4: fix memory leaks in udp_sendmsg, ping_v4_sendmsg

Andrzej Hajda (2):
       drm/exynos/mixer: fix synchronization check in interlaced mode
       drm/bridge/sii8620: add Kconfig dependency on extcon

Antoine Tenart (1):
       net: phy: sfp: fix the BR,min computation

Arnaldo Carvalho de Melo (4):
       tools headers: Sync x86 cpufeatures.h with the kernel sources
       tools headers kvm: Sync uapi/linux/kvm.h with the kernel sources
       tools headers kvm: Sync ARM UAPI headers with the kernel sources
       Revert "perf pmu: Fix pmu events parsing rule"

Arvind Yadav (2):
       HID: wacom: Release device resource data obtained by devres_alloc()
       HID: intel-ish-hid: use put_device() instead of kfree()

Ashish Samant (1):
       ocfs2: take inode cluster lock before moving reflinked inode from
orphan dir

Ben Skeggs (1):
       drm/nouveau/ttm: don't dereference nvbo::cli, it can outlive client

Bhadram Varka (1):
       net: phy: broadcom: add support for BCM89610 PHY

Boris Brezillon (2):
       drm/vc4: Fix scaling of uni-planar formats
       mtd: rawnand: Make sure we wait tWB before polling the STATUS reg

CHANDAN VN (1):
       arm64: To remove initrd reserved area entry from memblock

Changbin Du (1):
       scripts/faddr2line: fix error when addr2line output contains
discriminator

Charles Machalow (1):
       nvme: Fix sync controller reset return

Chris Packham (1):
       mtd: rawnand: marvell: pass ms delay to wait_op

Christophe JAILLET (2):
       net/mlx4_en: Fix an error handling path in 'mlx4_en_init_netdev()'
       mlxsw: core: Fix an error handling path in
'mlxsw_core_bus_device_register()'

Chuck Lever (2):
       xprtrdma: Fix list corruption / DMAR errors during MR recovery
       sunrpc: Fix latency trace point crashes

Colin Ian King (6):
       ata: fix spelling mistake: "directon" -> "direction"
       firestream: fix spelling mistake: "reseverd" -> "reserved"
       sctp: fix spelling mistake: "max_retans" -> "max_retrans"
       net/9p: fix spelling mistake: "suspsend" -> "suspend"
       qed: fix spelling mistake: "taskelt" -> "tasklet"
       ixgbe: fix memory leak on ipsec allocation

Dan Carpenter (1):
       drm/omap: silence unititialized variable warning

Daniel Borkmann (1):
       bpf: use array_index_nospec in find_prog_type

Daniel Jurgens (1):
       net/mlx5: Free IRQs in shutdown path

David Gilhooley (2):
       arm64: Add MIDR encoding for NVIDIA CPUs
       arm64: capabilities: Add NVIDIA Denver CPU to bp_harden list

David Howells (5):
       rxrpc: Fix missing start of call timeout
       rxrpc: Fix error reception on AF_INET6 sockets
       rxrpc: Fix the min security level for kernel calls
       rxrpc: Add a tracepoint to log ICMP/ICMP6 and error messages
       rxrpc: Trace UDP transmission failure

David Rientjes (1):
       mm, oom: fix concurrent munlock and oom reaper unmap, v3

Davide Caratti (1):
       tc-testing: fix tdc tests for 'bpf' action

Debabrata Banerjee (2):
       bonding: do not allow rlb updates to invalid mac
       bonding: send learning packets for vlans on slave

Dmitry Vyukov (1):
       KASAN: prohibit KASAN+STRUCTLEAK combination

Emil Tantilov (1):
       ixgbe: return error on unsupported SFP module when resetting

Eric Anholt (1):
       drm/vc4: Fix oops dereferencing DPI's connector since panel_bridge.

Eric Dumazet (4):
       nsh: fix infinite loop
       tls: fix use after free in tls_sk_proto_close
       llc: better deal with too small mtu
       tipc: fix one byte leak in tipc_sk_set_orig_addr()

Evan Wang (2):
       libahci: Allow drivers to override stop_engine
       ata: ahci: mvebu: override ahci_stop_engine for mvebu AHCI

Florent Flament (1):
       drm/i915: Fix drm:intel_enable_lvds ERROR message in kernel log

Florian La Roche (1):
       Fix typo in comment.

Ganesh Goudar (2):
       cxgb4: zero the HMA memory
       cxgb4: copy mbox log size to PF0-3 adap instances

Geert Uytterhoeven (4):
       dt-bindings: meson-uart: DT fix s/clocks-names/clock-names/
       dt-bindings: mvebu-uart: DT fix s/interrupts-names/interrupt-names/
       dt-bindings: panel: lvds: Fix path to display timing bindings
       dt-bindings: can: rcar_can: Fix R8A7796 SoC name

Georg Hofmann (1):
       trivial: fix inconsistent help texts

Govert Overgaauw (1):
       gpio: fix aspeed_gpio unmask irq

Gustavo A. R. Silva (3):
       ieee802154: mcr20a: Fix memory leak in mcr20a_probe
       atm: zatm: Fix potential Spectre v1
       net: atm: Fix potential Spectre v1

Hangbin Liu (1):
       ipv4: reset fnhe_mtu_locked after cache route flushed

Hans de Goede (9):
       thermal: int3403_thermal: Fix NULL pointer deref on module load /
probe
       HID: intel_ish-hid: Move header size check to inside the loop
       HID: intel_ish-hid: Stop using a static local buffer in get_report()
       libata: Apply NOLPM quirk for SAMSUNG MZMPC128HBFU-000MV SSD
       libata: Apply NOLPM quirk for SanDisk SD7UB3Q*G1001 SSDs
       Revert "Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174"
       Bluetooth: btusb: Only check needs_reset_resume DMI table for QCA
rome chipsets
       Bluetooth: btusb: Add Dell XPS 13 9360 to
btusb_needs_reset_resume_table
       HID: i2c-hid: Add RESEND_REPORT_DESCR quirk for Toshiba Click Mini
L9W-B

Harry Wentland (3):
       drm/amd/display: Add VG12 ASIC IDs
       drm/amd/display: Add get_firmware_info_v3_2 for VG12
       drm/amd/display: Don't return ddc result and read_bytes in same
return value

Heiner Kallweit (1):
       r8169: fix powering up RTL8168h

Igor Russkikh (2):
       net: aquantia: driver should correctly declare vlan_features bits
       net: aquantia: Limit number of vectors to actually allocated irqs

Ilan Peer (2):
       mac80211: Fix condition validating WMM IE
       mac80211: Adjust SAE authentication timeout

Ilya Dryomov (3):
       ceph: fix rsize/wsize capping in ceph_direct_read_write()
       libceph: add osd_req_op_extent_osd_data_bvecs()
       ceph: fix iov_iter issues in ceph_direct_read_write()

Jacopo Mondi (4):
       dt-bindings: net: ravb: Add support for r8a77965 SoC
       dt-bindings: serial: sh-sci: Add support for r8a77965 (H)SCIF
       dt-bindings: dmaengine: rcar-dmac: document R8A77965 support
       sh: mm: Fix unprotected access to struct device

Jakob Unterwurzacher (1):
       can: dev: increase bus-off message severity

Jan Kiszka (1):
       of: overlay: Stop leaking resources on overlay removal

Jann Horn (2):
       x86/vdso: Remove unused file
       compat: fix 4-byte infoleak via uninitialized struct field

Jean Delvare (1):
       swiotlb: silent unwanted warning "buffer is full"

Jeff Shaw (1):
       ice: Set rq_last_status when cleaning rq

Jeffrey Hugo (1):
       init: fix false positives in W+X checking

Jens Axboe (1):
       nvme: add quirk to force medium priority for SQ creation

Jerry (Fangzhi) Zuo (1):
       drm/amd: Add BIOS smu_info v3_3 required struct def.

Jia-Ju Bai (1):
       net: ieee802154: atusb: Replace GFP_ATOMIC with GFP_KERNEL in
atusb_probe

Jianchao Wang (1):
       nvme: fix use-after-free in nvme_free_ns_head

Jimmy Assarsson (1):
       can: kvaser_usb: Increase correct stats counter in
kvaser_usb_rx_can_msg()

Jiri Pirko (1):
       net: sched: fix error path in tcf_proto_create() when modules are not
configured

Johan Hovold (1):
       rfkill: gpio: fix memory leak in probe error path

Johannes Berg (1):
       cfg80211: limit wiphy names to 128 bytes

Jonathan Neuschäfer (1):
       PM: docs: sleep-states: Fix a typo ("includig")

Juri Lelli (2):
       PM: docs: intel_pstate: fix Active Mode w/o HWP paragraph
       cpufreq: schedutil: remove stale comment

Kai Heng Feng (1):
       PCI / PM: Always check PME wakeup capability for runtime wakeup
support

Kees Cook (1):
       dm mirror: remove VLA usage

Kevin Easton (1):
       af_key: Always verify length of provided sadb_key

Kunihiko Hayashi (1):
       Revert "ata: ahci-platform: add reset control support"

Ladislav Michl (1):
       mtd: onenand: omap2: Disable DMA for HIGHMEM buffers

Laura Abbott (1):
       proc/kcore: don't bounds check against address 0

Linus Torvalds (2):
       mmap: introduce sane default mmap limits
       Linux 4.17-rc5

Long Li (2):
       cifs: Allocate validate negotiation request through kmalloc
       cifs: smbd: Enable signing with smbdirect

Luc Van Oostenryck (1):
       ixgbevf: fix ixgbevf_xmit_frame()'s return type

Lukas Wunner (2):
       can: hi311x: Acquire SPI lock on ->do_get_berr_counter
       can: hi311x: Work around TX complete interrupt erratum

Lukasz Majewski (1):
       doc: Add vendor prefix for Kieback & Peter GmbH

Lyude Paul (1):
       drm/nouveau: Fix deadlock in nv50_mstm_register_connector()

Marek Szyprowski (2):
       thermal: exynos: Reading temperature makes sense only when TMU is
turned on
       thermal: exynos: Propagate error value from tmu_read()

Mark Rutland (1):
       bpf: fix possible spectre-v1 in find_and_alloc_map()

Matheus Castello (1):
       dt-bindings: pinctrl: sunxi: Fix reference to driver

Mathieu Malaterre (2):
       driver core: add __printf verification to __ata_ehi_pushv_desc
       agp: uninorth: make two functions static

Mel Gorman (1):
       Revert "sched/numa: Delay retrying placement for automatic NUMA
balance after wake_affine()"

Michael Chan (1):
       tg3: Fix vunmap() BUG_ON() triggered from tg3_free_consistent().

Michael Ellerman (2):
       powerpc/64: Remove unused paca->soft_enabled
       powerpc/pseries: Fix CONFIG_NUMA=n build

Michal Kalderon (2):
       qed: Fix l2 initializations over iWARP personality
       qede: Fix gfp flags sent to rdma event node allocation

Michel Dänzer (2):
       drm/amd/display: Use kvzalloc for potentially large allocations
       drm/ttm: Use GFP_TRANSHUGE_LIGHT for allocating huge pages

Mika Westerberg (2):
       pinctrl: cherryview: Associate IRQ descriptors to irqdomain
       pinctrl: sunrisepoint: Align GPIO number space with Windows

Mike Snitzer (3):
       dm cache background tracker: fix sparse warning
       dm: fix some sparse warnings and whitespace in dax methods
       dm thin: update Documentation to clarify when "read_only" is valid

Mikulas Patocka (2):
       dm integrity: use kvfree for kvmalloc'd memory
       dm bufio: fix buffer alignment

Miquel Raynal (1):
       mtd: rawnand: marvell: fix command xtype in BCH write hook

Mohammed Gamal (1):
       hv_netvsc: Fix net device attach on older Windows hosts

Moritz Fischer (2):
       net: nixge: Fix error path for obtaining mac address
       net: nixge: Address compiler warnings about signedness

Moshe Shemesh (1):
       net/mlx4_en: Verify coalescing parameters are in range

Naoya Horiguchi (1):
       mm: migrate: fix double call of radix_tree_replace_slot()

Naveen N. Rao (2):
       powerpc/trace/syscalls: Update syscall name matching logic
       powerpc/trace/syscalls: Update syscall name matching logic to account
for ppc_ prefix

Paolo Abeni (1):
       udp: fix SO_BINDTODEVICE

Paulo Alcantara (1):
       cifs: smb2ops: Fix listxattr() when there are no EAs

Pavel Tatashin (1):
       mm: sections are not offlined during memory hotremove

Peter Rosin (1):
       drm/exynos: hdmi: avoid duplicating drm_bridge_attach

Peter Zijlstra (11):
       stop_machine, sched: Fix migrate_swap() vs. active_balance() deadlock
       kthread, sched/wait: Fix kthread_parkme() wait-loop
       kthread, sched/wait: Fix kthread_parkme() completion issue
       sched/core: Introduce set_special_state()
       sched/core: Fix possible Spectre-v1 indexing for
sched_prio_to_weight[]
       sched/autogroup: Fix possible Spectre-v1 indexing for
sched_prio_to_weight[]
       perf/core: Fix possible Spectre-v1 indexing for ->aux_pages[]
       perf/x86: Fix possible Spectre-v1 indexing for hw_perf_event cache_*
       perf/x86: Fix possible Spectre-v1 indexing for x86_pmu::event_map()
       perf/x86/msr: Fix possible Spectre-v1 indexing in the MSR driver
       perf/x86/cstate: Fix possible Spectre-v1 indexing for pkg_msr

Pieter Jansen van Vuuren (1):
       nfp: flower: remove headroom from max MTU calculation

Rafael J. Wysocki (2):
       cpufreq: schedutil: Avoid using invalid next_freq
       PCI / PM: Check device_may_wakeup() in pci_enable_wake()

Randy Dunlap (1):
       mac80211: fix kernel-doc "bad line" warning

Rex Zhu (2):
       drm/amd/pp: Refine the output of pp_power_profile_mode on VI
       drm/amd/pp: Fix performance drop on Fiji

Rich Felker (1):
       sh: fix build failure for J2 cpu with SMP disabled

Rob Herring (2):
       dtc: checks: drop warning for missing PCI bridge bus-range
       sh: switch to NO_BOOTMEM

Rob Taglang (1):
       net: ethernet: sun: niu set correct packet size in skb

Rodrigo Vivi (1):
       drm/i915: Adjust eDP's logical vco in a reliable place.

Roi Dayan (1):
       net/mlx5e: Err if asked to offload TC match on frag being first

Roman Gushchin (1):
       mm: don't show nr_indirectly_reclaimable in /proc/vmstat

Roman Mashak (2):
       net sched actions: fix invalid pointer dereferencing if skbedit flags
missing
       net sched actions: fix refcnt leak in skbmod

Sara Sharon (1):
       mac80211: use timeout from the AddBA response instead of the request

Sebastian Andrzej Siewior (1):
       rbtree: include rcu.h

Sergei Shtylyov (2):
       DT: net: can: rcar_canfd: document R8A77970 bindings
       DT: net: can: rcar_canfd: document R8A77980 bindings

Shuah Khan (Samsung OSG) (1):
       MAINTAINERS: update Shuah's email address

Srinivas Dasari (1):
       nl80211: Free connkeys on external authentication failure

Stefan Schmidt (1):
       net: ieee802154: mcr20a: do not leak resources on error path

Stefano Brivio (2):
       vti6: Change minimum MTU to IPV4_MIN_MTU, vti6 can carry IPv4 too
       openvswitch: Don't swap table in nlattr_set() after OVS_ATTR_NESTED
is found

Steffen Klassert (2):
       xfrm: Fix warning in xfrm6_tunnel_net_exit.
       MAINTAINERS: Update the 3c59x network driver entry

Stephen Hemminger (1):
       hv_netvsc: set master device

Steve French (1):
       smb3: directory sync should not return an error

Steven Rostedt (VMware) (1):
       tracing: Fix regex_match_front() to not over compare the test string

Sun Lianwen (1):
       net/9p: correct some comment errors in 9p file system code

Timur Tabi (1):
       gpioib: do not free unrequested descriptors

Tobias Jakobi (1):
       drm/exynos: mixer: avoid Oops in vp_video_buffer()

Tomi Valkeinen (6):
       drm/omap: fix uninitialized ret variable
       drm/omap: fix possible NULL ref issue in tiler_reserve_2d
       drm/omap: check return value from soc_device_match
       drm/omap: handle error if scale coefs are not found
       drm/omap: add missing linefeeds to prints
       drm/omap: handle alloc failures in omap_connector

Trond Myklebust (1):
       Change Trond's email address in MAINTAINERS

Uwe Kleine-König (3):
       gpio: fix error path in lineevent_create
       can: flexcan: fix endianess detection
       arm: dts: imx[35]*: declare flexcan devices to be compatible to
imx25's flexcan

Ville Syrjälä (3):
       drm/atomic: Clean old_state/new_state in
drm_atomic_state_default_clear()
       drm/atomic: Clean private obj old_state/new_state in
drm_atomic_state_default_clear()
       drm/i915: Correctly populate user mode h/vdisplay with pipe src size
during readout

Vincent Guittot (1):
       sched/fair: Fix the update of blocked load when newly idle

Vitaly Wool (1):
       z3fold: fix reclaim lock-ups

William Breathitt Gray (3):
       gpio: pci-idio-16: Fix port memory offset for get_multiple callback
       gpio: pcie-idio-24: Fix port memory offset for
get_multiple/set_multiple callbacks
       gpio: pcie-idio-24: Fix off-by-one error in get_multiple loop

William Cohen (1):
       perf vendor events intel: Remove duplicated entry for westmereep-dp
in mapfile.csv

Wolfram Sang (1):
       net: flow_dissector: fix typo 'can by' to 'can be'

Xin Long (2):
       sctp: delay the authentication for the duplicated cookie-echo chunk
       sctp: remove sctp_chunk_put from fail_mark err path in
sctp_ulpevent_make_rcvmsg

YU Bo (1):
       net/netlink: make sure the headers line up actual value output

Ying Xue (1):
       tipc: eliminate KMSAN uninit-value in strcmp complaint

Yisheng Xie (1):
       perf bench numa: Fix typo in options

Yixun Lan (1):
       pinctrl: meson-axg: fix the range of aobus bank

YueHaibing (1):
       mac80211_hwsim: fix a possible memory leak in hwsim_new_radio_nl()

Yury Norov (1):
       lib/find_bit_benchmark.c: avoid soft lockup in test_find_first_bit()

pgzh (1):
       HID: lenovo: Add support for IBM/Lenovo Scrollpoint mice

van der Linden, Frank (1):
       x86/xen: Reset VCPU0 info pointer after shared_info remap

weiyongjun (A) (1):
       cfg80211: fix possible memory leak in regdb_query_country()
